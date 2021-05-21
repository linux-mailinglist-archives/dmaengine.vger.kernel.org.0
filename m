Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E91838D159
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhEUWXm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:23:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:17564 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhEUWXi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:23:38 -0400
IronPort-SDR: uvZDEtvQ/sgpzmEL6A4y1BwsNvvIGGMR9SNCdMzJIOC10WxQ6hlZkmIc7LmU2MV0NlPiv3QP1u
 MdbwKyexgk5w==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201295634"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201295634"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:57 -0700
IronPort-SDR: vK2uwNHFBDfDpJ7C9KbZiQB24Oj5xZJYKSZPUTY+MD4X0rwnr0xGAIhZ9+vhA+2FqmsNcGNXTX
 7q2TbcqvJ40A==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="631964005"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:57 -0700
Subject: [PATCH 06/18] dmaengine: idxd: move wq_disable() to device.c
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:21:56 -0700
Message-ID: <162163571678.260470.6578183131248464880.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the wq_disable() function to device.c in preparation of setting up the
idxd internal sub-driver framework. No logic changes.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   37 +++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/sysfs.c  |   38 +-------------------------------------
 3 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 0f214078f8c6..f146a4fb772f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1210,3 +1210,40 @@ int drv_enable_wq(struct idxd_wq *wq)
 	mutex_unlock(&wq->wq_lock);
 	return rc;
 }
+
+static void __drv_disable_wq(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+
+	lockdep_assert_held(&wq->wq_lock);
+
+	if (wq->type == IDXD_WQT_KERNEL)
+		idxd_wq_quiesce(wq);
+
+	if (is_idxd_wq_dmaengine(wq))
+		idxd_unregister_dma_channel(wq);
+	else if (is_idxd_wq_cdev(wq))
+		idxd_wq_del_cdev(wq);
+
+	if (idxd_wq_refcount(wq))
+		dev_warn(dev, "Clients has claim on wq %d: %d\n",
+			 wq->id, idxd_wq_refcount(wq));
+
+	idxd_wq_unmap_portal(wq);
+
+	idxd_wq_drain(wq);
+	idxd_wq_reset(wq);
+
+	idxd_wq_free_resources(wq);
+	wq->client_count = 0;
+
+	dev_info(dev, "wq %s disabled\n", dev_name(wq_confdev(wq)));
+}
+
+void drv_disable_wq(struct idxd_wq *wq)
+{
+	mutex_lock(&wq->wq_lock);
+	__drv_disable_wq(wq);
+	mutex_unlock(&wq->wq_lock);
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index ba1ff968c50d..0b0f9361c2eb 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -490,6 +490,7 @@ void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
 int drv_enable_wq(struct idxd_wq *wq);
+void drv_disable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
 int idxd_device_enable(struct idxd_device *idxd);
 int idxd_device_disable(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index f4f7e8870436..ac0997b4c72a 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -89,42 +89,6 @@ static int idxd_config_bus_probe(struct device *dev)
 	return -ENODEV;
 }
 
-static void disable_wq(struct idxd_wq *wq)
-{
-	struct idxd_device *idxd = wq->idxd;
-	struct device *dev = &idxd->pdev->dev;
-
-	mutex_lock(&wq->wq_lock);
-	dev_dbg(dev, "%s removing WQ %s\n", __func__, dev_name(wq_confdev(wq)));
-	if (wq->state == IDXD_WQ_DISABLED) {
-		mutex_unlock(&wq->wq_lock);
-		return;
-	}
-
-	if (wq->type == IDXD_WQT_KERNEL)
-		idxd_wq_quiesce(wq);
-
-	if (is_idxd_wq_dmaengine(wq))
-		idxd_unregister_dma_channel(wq);
-	else if (is_idxd_wq_cdev(wq))
-		idxd_wq_del_cdev(wq);
-
-	if (idxd_wq_refcount(wq))
-		dev_warn(dev, "Clients has claim on wq %d: %d\n",
-			 wq->id, idxd_wq_refcount(wq));
-
-	idxd_wq_unmap_portal(wq);
-
-	idxd_wq_drain(wq);
-	idxd_wq_reset(wq);
-
-	idxd_wq_free_resources(wq);
-	wq->client_count = 0;
-	mutex_unlock(&wq->wq_lock);
-
-	dev_info(dev, "wq %s disabled\n", dev_name(wq_confdev(wq)));
-}
-
 static int idxd_config_bus_remove(struct device *dev)
 {
 	int rc;
@@ -135,7 +99,7 @@ static int idxd_config_bus_remove(struct device *dev)
 	if (is_idxd_wq_dev(dev)) {
 		struct idxd_wq *wq = confdev_to_wq(dev);
 
-		disable_wq(wq);
+		drv_disable_wq(wq);
 	} else if (is_idxd_dev(dev)) {
 		struct idxd_device *idxd = confdev_to_idxd(dev);
 		int i;


