Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB32538D153
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhEUWXP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:23:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:7002 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEUWXP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:23:15 -0400
IronPort-SDR: i6uZs/aAfObA6vkoDRTQyX59tIi+MIp9wtCSRVeUD+Iqc5koUjfSqYahu0mrD25XPCJedKOtwD
 kFQJ6CLWA6Mg==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="188979576"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="188979576"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:51 -0700
IronPort-SDR: vN1dmEHdPEPnhzKSBqHQnXUPRgJoz2xldl4OYRNrXLd1IrO4rGAdgy3tztShHAcDEGGshbaHwD
 F+sWvnUq+atg==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="434466231"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:21:51 -0700
Subject: [PATCH 05/18] dmaengine: idxd: move wq_enable() to device.c
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:21:50 -0700
Message-ID: <162163571092.260470.420049824189364690.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the wq_enable() function to device.c in preparation of setting up the
idxd internal sub-driver framework. No logic changes.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |  124 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |    1 
 drivers/dma/idxd/sysfs.c  |  124 ---------------------------------------------
 3 files changed, 126 insertions(+), 123 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index af7a526217d0..0f214078f8c6 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1086,3 +1086,127 @@ int idxd_device_load_config(struct idxd_device *idxd)
 
 	return 0;
 }
+
+static int __drv_enable_wq(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	unsigned long flags;
+	int rc = -ENXIO;
+
+	lockdep_assert_held(&wq->wq_lock);
+
+	if (idxd->state != IDXD_DEV_ENABLED)
+		goto err;
+
+	if (wq->state != IDXD_WQ_DISABLED) {
+		dev_dbg(dev, "wq %d already enabled.\n", wq->id);
+		rc = -EBUSY;
+		goto err;
+	}
+
+	if (!wq->group) {
+		dev_dbg(dev, "wq %d not attached to group.\n", wq->id);
+		goto err;
+	}
+
+	if (strlen(wq->name) == 0) {
+		dev_dbg(dev, "wq %d name not set.\n", wq->id);
+		goto err;
+	}
+
+	/* Shared WQ checks */
+	if (wq_shared(wq)) {
+		if (!device_swq_supported(idxd)) {
+			dev_dbg(dev, "PASID not enabled and shared wq.\n");
+			goto err;
+		}
+		/*
+		 * Shared wq with the threshold set to 0 means the user
+		 * did not set the threshold or transitioned from a
+		 * dedicated wq but did not set threshold. A value
+		 * of 0 would effectively disable the shared wq. The
+		 * driver does not allow a value of 0 to be set for
+		 * threshold via sysfs.
+		 */
+		if (wq->threshold == 0) {
+			dev_dbg(dev, "Shared wq and threshold 0.\n");
+			goto err;
+		}
+	}
+
+	rc = idxd_wq_alloc_resources(wq);
+	if (rc < 0) {
+		dev_dbg(dev, "wq resource alloc failed\n");
+		goto err;
+	}
+
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		rc = idxd_device_config(idxd);
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	if (rc < 0) {
+		dev_dbg(dev, "Writing wq %d config failed: %d\n", wq->id, rc);
+		goto err;
+	}
+
+	rc = idxd_wq_enable(wq);
+	if (rc < 0) {
+		dev_dbg(dev, "wq %d enabling failed: %d\n", wq->id, rc);
+		goto err;
+	}
+
+	rc = idxd_wq_map_portal(wq);
+	if (rc < 0) {
+		dev_dbg(dev, "wq %d portal mapping failed: %d\n", wq->id, rc);
+		goto err_map_portal;
+	}
+
+	wq->client_count = 0;
+
+	if (wq->type == IDXD_WQT_KERNEL) {
+		rc = idxd_wq_init_percpu_ref(wq);
+		if (rc < 0) {
+			dev_dbg(dev, "wq %d percpu_ref setup failed\n", wq->id);
+			goto err_cpu_ref;
+		}
+	}
+
+	if (is_idxd_wq_dmaengine(wq)) {
+		rc = idxd_register_dma_channel(wq);
+		if (rc < 0) {
+			dev_dbg(dev, "wq %d DMA channel register failed\n", wq->id);
+			goto err_client;
+		}
+	} else if (is_idxd_wq_cdev(wq)) {
+		rc = idxd_wq_add_cdev(wq);
+		if (rc < 0) {
+			dev_dbg(dev, "wq %d cdev creation failed\n", wq->id);
+			goto err_client;
+		}
+	}
+
+	dev_info(dev, "wq %s enabled\n", dev_name(wq_confdev(wq)));
+	return 0;
+
+err_client:
+	idxd_wq_quiesce(wq);
+err_cpu_ref:
+	idxd_wq_unmap_portal(wq);
+err_map_portal:
+	rc = idxd_wq_disable(wq);
+	if (rc < 0)
+		dev_dbg(dev, "wq %s disable failed\n", dev_name(wq_confdev(wq)));
+err:
+	return rc;
+}
+
+int drv_enable_wq(struct idxd_wq *wq)
+{
+	int rc;
+
+	mutex_lock(&wq->wq_lock);
+	rc = __drv_enable_wq(wq);
+	mutex_unlock(&wq->wq_lock);
+	return rc;
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 7ca379acca31..ba1ff968c50d 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -489,6 +489,7 @@ void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
 void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
+int drv_enable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
 int idxd_device_enable(struct idxd_device *idxd);
 int idxd_device_disable(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 069f70d5c81a..f4f7e8870436 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -39,128 +39,6 @@ static int idxd_config_bus_match(struct device *dev,
 	return matched;
 }
 
-static int enable_wq(struct idxd_wq *wq)
-{
-	struct idxd_device *idxd = wq->idxd;
-	struct device *dev = &idxd->pdev->dev;
-	unsigned long flags;
-	int rc;
-
-	mutex_lock(&wq->wq_lock);
-
-	if (idxd->state != IDXD_DEV_ENABLED) {
-		mutex_unlock(&wq->wq_lock);
-		dev_warn(dev, "Enabling while device not enabled.\n");
-		return -EPERM;
-	}
-
-	if (wq->state != IDXD_WQ_DISABLED) {
-		mutex_unlock(&wq->wq_lock);
-		dev_warn(dev, "WQ %d already enabled.\n", wq->id);
-		return -EBUSY;
-	}
-
-	if (!wq->group) {
-		mutex_unlock(&wq->wq_lock);
-		dev_warn(dev, "WQ not attached to group.\n");
-		return -EINVAL;
-	}
-
-	if (strlen(wq->name) == 0) {
-		mutex_unlock(&wq->wq_lock);
-		dev_warn(dev, "WQ name not set.\n");
-		return -EINVAL;
-	}
-
-	/* Shared WQ checks */
-	if (wq_shared(wq)) {
-		if (!device_swq_supported(idxd)) {
-			dev_warn(dev, "PASID not enabled and shared WQ.\n");
-			mutex_unlock(&wq->wq_lock);
-			return -ENXIO;
-		}
-		/*
-		 * Shared wq with the threshold set to 0 means the user
-		 * did not set the threshold or transitioned from a
-		 * dedicated wq but did not set threshold. A value
-		 * of 0 would effectively disable the shared wq. The
-		 * driver does not allow a value of 0 to be set for
-		 * threshold via sysfs.
-		 */
-		if (wq->threshold == 0) {
-			dev_warn(dev, "Shared WQ and threshold 0.\n");
-			mutex_unlock(&wq->wq_lock);
-			return -EINVAL;
-		}
-	}
-
-	rc = idxd_wq_alloc_resources(wq);
-	if (rc < 0) {
-		mutex_unlock(&wq->wq_lock);
-		dev_warn(dev, "WQ resource alloc failed\n");
-		return rc;
-	}
-
-	spin_lock_irqsave(&idxd->dev_lock, flags);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock_irqrestore(&idxd->dev_lock, flags);
-	if (rc < 0) {
-		mutex_unlock(&wq->wq_lock);
-		dev_warn(dev, "Writing WQ %d config failed: %d\n", wq->id, rc);
-		return rc;
-	}
-
-	rc = idxd_wq_enable(wq);
-	if (rc < 0) {
-		mutex_unlock(&wq->wq_lock);
-		dev_warn(dev, "WQ %d enabling failed: %d\n", wq->id, rc);
-		return rc;
-	}
-
-	rc = idxd_wq_map_portal(wq);
-	if (rc < 0) {
-		dev_warn(dev, "wq portal mapping failed: %d\n", rc);
-		rc = idxd_wq_disable(wq);
-		if (rc < 0)
-			dev_warn(dev, "IDXD wq disable failed\n");
-		mutex_unlock(&wq->wq_lock);
-		return rc;
-	}
-
-	wq->client_count = 0;
-
-	if (wq->type == IDXD_WQT_KERNEL) {
-		rc = idxd_wq_init_percpu_ref(wq);
-		if (rc < 0) {
-			dev_dbg(dev, "percpu_ref setup failed\n");
-			mutex_unlock(&wq->wq_lock);
-			return rc;
-		}
-	}
-
-	if (is_idxd_wq_dmaengine(wq)) {
-		rc = idxd_register_dma_channel(wq);
-		if (rc < 0) {
-			dev_dbg(dev, "DMA channel register failed\n");
-			mutex_unlock(&wq->wq_lock);
-			return rc;
-		}
-	} else if (is_idxd_wq_cdev(wq)) {
-		rc = idxd_wq_add_cdev(wq);
-		if (rc < 0) {
-			dev_dbg(dev, "Cdev creation failed\n");
-			mutex_unlock(&wq->wq_lock);
-			return rc;
-		}
-	}
-
-	mutex_unlock(&wq->wq_lock);
-	dev_info(dev, "wq %s enabled\n", dev_name(wq_confdev(wq)));
-
-	return 0;
-}
-
 static int idxd_config_bus_probe(struct device *dev)
 {
 	int rc = 0;
@@ -205,7 +83,7 @@ static int idxd_config_bus_probe(struct device *dev)
 	} else if (is_idxd_wq_dev(dev)) {
 		struct idxd_wq *wq = confdev_to_wq(dev);
 
-		return enable_wq(wq);
+		return drv_enable_wq(wq);
 	}
 
 	return -ENODEV;


