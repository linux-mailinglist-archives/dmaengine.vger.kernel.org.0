Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC438D15B
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhEUWXv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:23:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:7038 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhEUWXv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:23:51 -0400
IronPort-SDR: +FPg26ieF9wOsn89Ys35za3rrLrYMZaTWC+ICj70JHFG5WH0fI/C1FTW2UwNQ9Kyt7zKGURjc5
 9j6Jj1WiXeug==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="188979692"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188979692"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:27 -0700
IronPort-SDR: XXm5rg9uUS7JZ8Jkq9JhFv6JOTfrknT0fK0SPl3tmDOWL9pK9ChLoMbRUI3kWEmDEUarZWEgUu
 Wmgo9DuqoHRA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441271912"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:24 -0700
Subject: [PATCH 10/18] dmaengine: idxd: move probe() bits for idxd 'struct
 device' to device.c
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:22:20 -0700
Message-ID: <162163574008.260470.13851204140720969094.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the code related to a ->probe() function for the idxd
'struct device' to device.c to prep for the idxd device
sub-driver in device.c.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   37 +++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |    1 +
 drivers/dma/idxd/sysfs.c  |   40 ++--------------------------------------
 3 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index f146a4fb772f..e3665bac9980 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1247,3 +1247,40 @@ void drv_disable_wq(struct idxd_wq *wq)
 	__drv_disable_wq(wq);
 	mutex_unlock(&wq->wq_lock);
 }
+
+int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
+{
+	struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
+	unsigned long flags;
+	int rc;
+
+	/*
+	 * Device should be in disabled state for the idxd_drv to load. If it's in
+	 * enabled state, then the device was altered outside of driver's control.
+	 * If the state is in halted state, then we don't want to proceed.
+	 */
+	if (idxd->state != IDXD_DEV_DISABLED)
+		return -ENXIO;
+
+	/* Device configuration */
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		rc = idxd_device_config(idxd);
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	if (rc < 0)
+		return -ENXIO;
+
+	/* Start device */
+	rc = idxd_device_enable(idxd);
+	if (rc < 0)
+		return rc;
+
+	/* Setup DMA device without channels */
+	rc = idxd_register_dma_device(idxd);
+	if (rc < 0) {
+		idxd_device_disable(idxd);
+		return rc;
+	}
+
+	return 0;
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index ffa1adae7b54..b1ec63ea0a00 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -492,6 +492,7 @@ void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
 void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
+int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
 int drv_enable_wq(struct idxd_wq *wq);
 void drv_disable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 5ce8d2827d44..83f721fb3369 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -52,44 +52,8 @@ struct bus_type dsa_bus_type = {
 
 static int idxd_dsa_drv_probe(struct idxd_dev *idxd_dev)
 {
-	struct device *dev = &idxd_dev->conf_dev;
-	unsigned long flags;
-	int rc;
-
-	if (is_idxd_dev(idxd_dev)) {
-		struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
-
-		if (idxd->state != IDXD_DEV_DISABLED)
-			return -ENXIO;
-
-		/* Device configuration */
-		spin_lock_irqsave(&idxd->dev_lock, flags);
-		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-			rc = idxd_device_config(idxd);
-		spin_unlock_irqrestore(&idxd->dev_lock, flags);
-		if (rc < 0) {
-			dev_dbg(dev, "Device config failed: %d\n", rc);
-			return rc;
-		}
-
-		/* Start device */
-		rc = idxd_device_enable(idxd);
-		if (rc < 0) {
-			dev_warn(dev, "Device enable failed: %d\n", rc);
-			return rc;
-		}
-
-		/* Setup DMA device without channels */
-		rc = idxd_register_dma_device(idxd);
-		if (rc < 0) {
-			dev_dbg(dev, "Failed to register dmaengine device\n");
-			idxd_device_disable(idxd);
-			return rc;
-		}
-
-		dev_info(dev, "Device %s enabled\n", dev_name(dev));
-		return 0;
-	}
+	if (is_idxd_dev(idxd_dev))
+		return idxd_device_drv_probe(idxd_dev);
 
 	if (is_idxd_wq_dev(idxd_dev)) {
 		struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);


