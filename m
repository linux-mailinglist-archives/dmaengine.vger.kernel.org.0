Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BCB3C9468
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 01:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbhGNXXt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 19:23:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:61911 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236097AbhGNXXt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 19:23:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="207423696"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="207423696"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:20:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="428518484"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:20:56 -0700
Subject: [PATCH v2 06/18] dmaengine: idxd: move wq_disable() to device.c
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 14 Jul 2021 16:20:56 -0700
Message-ID: <162630485648.631529.13186529233670382444.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
References: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
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
index b1c509bcfa31..8d8e249931a9 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1253,3 +1253,40 @@ int drv_enable_wq(struct idxd_wq *wq)
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
index e2773eb9d02c..3f0e1f6be130 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -488,6 +488,7 @@ void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
 int drv_enable_wq(struct idxd_wq *wq);
+void drv_disable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
 int idxd_device_enable(struct idxd_device *idxd);
 int idxd_device_disable(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 4e492d31e094..65e33a0b535a 100644
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
 	dev_dbg(dev, "%s called for %s\n", __func__, dev_name(dev));
@@ -133,7 +97,7 @@ static int idxd_config_bus_remove(struct device *dev)
 	if (is_idxd_wq_dev(dev)) {
 		struct idxd_wq *wq = confdev_to_wq(dev);
 
-		disable_wq(wq);
+		drv_disable_wq(wq);
 	} else if (is_idxd_dev(dev)) {
 		struct idxd_device *idxd = confdev_to_idxd(dev);
 		int i;


