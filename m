Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA4E3C946E
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 01:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhGNXYM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 19:24:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:21874 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237579AbhGNXYL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 19:24:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190126173"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190126173"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:19 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="494685364"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:19 -0700
Subject: [PATCH v2 10/18] dmaengine: idxd: move probe() bits for idxd 'struct
 device' to device.c
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 14 Jul 2021 16:21:19 -0700
Message-ID: <162630487911.631529.2394973148629623706.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
References: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
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
index 8d8e249931a9..b9aa209efee4 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1290,3 +1290,40 @@ void drv_disable_wq(struct idxd_wq *wq)
 	__drv_disable_wq(wq);
 	mutex_unlock(&wq->wq_lock);
 }
+
+int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
+{
+	struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
+	unsigned long flags;
+	int rc = 0;
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
index aa39af446fba..435cfb4fca29 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -490,6 +490,7 @@ void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
 void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
+int idxd_device_drv_probe(struct idxd_dev *idxd_dev);
 int drv_enable_wq(struct idxd_wq *wq);
 void drv_disable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 378580942386..4822454aea45 100644
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


