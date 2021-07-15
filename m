Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EBC3CA630
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 20:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbhGOSqf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 14:46:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:20621 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238143AbhGOSq3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 14:46:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="210422788"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="210422788"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="489552227"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:32 -0700
Subject: [PATCH v3 05/18] dmaengine: idxd: move wq_enable() to device.c
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Jul 2021 11:43:31 -0700
Message-ID: <162637461176.744545.3806109011554118998.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
References: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
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
index 4a2af9799239..b1c509bcfa31 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1129,3 +1129,127 @@ int idxd_device_load_config(struct idxd_device *idxd)
 
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
+	rc = idxd_wq_disable(wq, false);
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
index 0f0a938854a9..6ebec8a57b54 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -487,6 +487,7 @@ void idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
 void idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
 
 /* device control */
+int drv_enable_wq(struct idxd_wq *wq);
 int idxd_device_init_reset(struct idxd_device *idxd);
 int idxd_device_enable(struct idxd_device *idxd);
 int idxd_device_disable(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 56f13a71c1cb..4e492d31e094 100644
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
-		rc = idxd_wq_disable(wq, false);
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


