Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25903C946B
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 01:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhGNXYG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 19:24:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:16044 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235370AbhGNXYG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 19:24:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190819232"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190819232"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="630544649"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 16:21:13 -0700
Subject: [PATCH v2 09/18] dmaengine: idxd: fix bus_probe() and bus_remove()
 for dsa_bus
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 14 Jul 2021 16:21:13 -0700
Message-ID: <162630487336.631529.258869892017418239.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
References: <162630468448.631529.1963704964865951650.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Current implementation have put all the code that should be in a driver
probe/remove in the bus probe/remove function. Add ->probe() and ->remove()
support for the dsa_drv and move all those code out of bus probe/remove.
The change does not split out the distinction between device sub-driver and
wq sub-driver. It only cleans up the bus calls. The split out will be
addressed in follow on patches.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/idxd.h  |   24 ++++++----
 drivers/dma/idxd/sysfs.c |  108 +++++++++++++++++++++++-----------------------
 2 files changed, 69 insertions(+), 63 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 29c94200b55e..aa39af446fba 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -51,6 +51,8 @@ enum idxd_type {
 
 struct idxd_device_driver {
 	const char *name;
+	int (*probe)(struct idxd_dev *idxd_dev);
+	void (*remove)(struct idxd_dev *idxd_dev);
 	struct device_driver drv;
 };
 
@@ -315,19 +317,21 @@ struct idxd_desc {
 #define cdev_dev(cdev) &cdev->idxd_dev.conf_dev
 
 #define confdev_to_idxd_dev(dev) container_of(dev, struct idxd_dev, conf_dev)
+#define idxd_dev_to_idxd(idxd_dev) container_of(idxd_dev, struct idxd_device, idxd_dev)
+#define idxd_dev_to_wq(idxd_dev) container_of(idxd_dev, struct idxd_wq, idxd_dev)
 
 static inline struct idxd_device *confdev_to_idxd(struct device *dev)
 {
 	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
 
-	return container_of(idxd_dev, struct idxd_device, idxd_dev);
+	return idxd_dev_to_idxd(idxd_dev);
 }
 
 static inline struct idxd_wq *confdev_to_wq(struct device *dev)
 {
 	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
 
-	return container_of(idxd_dev, struct idxd_wq, idxd_dev);
+	return idxd_dev_to_wq(idxd_dev);
 }
 
 static inline struct idxd_engine *confdev_to_engine(struct device *dev)
@@ -371,24 +375,24 @@ extern struct device_type idxd_wq_device_type;
 extern struct device_type idxd_engine_device_type;
 extern struct device_type idxd_group_device_type;
 
-static inline bool is_dsa_dev(struct device *dev)
+static inline bool is_dsa_dev(struct idxd_dev *idxd_dev)
 {
-	return dev->type == &dsa_device_type;
+	return idxd_dev->type == IDXD_DEV_DSA;
 }
 
-static inline bool is_iax_dev(struct device *dev)
+static inline bool is_iax_dev(struct idxd_dev *idxd_dev)
 {
-	return dev->type == &iax_device_type;
+	return idxd_dev->type == IDXD_DEV_IAX;
 }
 
-static inline bool is_idxd_dev(struct device *dev)
+static inline bool is_idxd_dev(struct idxd_dev *idxd_dev)
 {
-	return is_dsa_dev(dev) || is_iax_dev(dev);
+	return is_dsa_dev(idxd_dev) || is_iax_dev(idxd_dev);
 }
 
-static inline bool is_idxd_wq_dev(struct device *dev)
+static inline bool is_idxd_wq_dev(struct idxd_dev *idxd_dev)
 {
-	return dev->type == &idxd_wq_device_type;
+	return idxd_dev->type == IDXD_DEV_WQ;
 }
 
 static inline bool is_idxd_wq_dmaengine(struct idxd_wq *wq)
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3682bff7948a..378580942386 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -19,69 +19,80 @@ static char *idxd_wq_type_names[] = {
 static int idxd_config_bus_match(struct device *dev,
 				 struct device_driver *drv)
 {
-	int matched = 0;
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
 
-	if (is_idxd_dev(dev)) {
-		matched = 1;
-	} else if (is_idxd_wq_dev(dev)) {
-		struct idxd_wq *wq = confdev_to_wq(dev);
+	return (is_idxd_dev(idxd_dev) || is_idxd_wq_dev(idxd_dev));
+}
 
-		if (wq->state != IDXD_WQ_DISABLED) {
-			dev_dbg(dev, "%s not disabled\n", dev_name(dev));
-			return 0;
-		}
-		matched = 1;
-	}
+static int idxd_config_bus_probe(struct device *dev)
+{
+	struct idxd_device_driver *idxd_drv =
+		container_of(dev->driver, struct idxd_device_driver, drv);
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
 
-	if (matched)
-		dev_dbg(dev, "%s matched\n", dev_name(dev));
+	return idxd_drv->probe(idxd_dev);
+}
 
-	return matched;
+static int idxd_config_bus_remove(struct device *dev)
+{
+	struct idxd_device_driver *idxd_drv =
+		container_of(dev->driver, struct idxd_device_driver, drv);
+	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
+
+	idxd_drv->remove(idxd_dev);
+	return 0;
 }
 
-static int idxd_config_bus_probe(struct device *dev)
+struct bus_type dsa_bus_type = {
+	.name = "dsa",
+	.match = idxd_config_bus_match,
+	.probe = idxd_config_bus_probe,
+	.remove = idxd_config_bus_remove,
+};
+
+static int idxd_dsa_drv_probe(struct idxd_dev *idxd_dev)
 {
-	int rc = 0;
+	struct device *dev = &idxd_dev->conf_dev;
 	unsigned long flags;
+	int rc;
 
-	dev_dbg(dev, "%s called\n", __func__);
-
-	if (is_idxd_dev(dev)) {
-		struct idxd_device *idxd = confdev_to_idxd(dev);
+	if (is_idxd_dev(idxd_dev)) {
+		struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
 
-		if (!try_module_get(THIS_MODULE))
+		if (idxd->state != IDXD_DEV_DISABLED)
 			return -ENXIO;
 
-		/* Perform IDXD configuration and enabling */
+		/* Device configuration */
 		spin_lock_irqsave(&idxd->dev_lock, flags);
 		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 			rc = idxd_device_config(idxd);
 		spin_unlock_irqrestore(&idxd->dev_lock, flags);
 		if (rc < 0) {
-			module_put(THIS_MODULE);
-			dev_warn(dev, "Device config failed: %d\n", rc);
+			dev_dbg(dev, "Device config failed: %d\n", rc);
 			return rc;
 		}
 
-		/* start device */
+		/* Start device */
 		rc = idxd_device_enable(idxd);
 		if (rc < 0) {
-			module_put(THIS_MODULE);
 			dev_warn(dev, "Device enable failed: %d\n", rc);
 			return rc;
 		}
 
-		dev_info(dev, "Device %s enabled\n", dev_name(dev));
-
+		/* Setup DMA device without channels */
 		rc = idxd_register_dma_device(idxd);
 		if (rc < 0) {
-			module_put(THIS_MODULE);
 			dev_dbg(dev, "Failed to register dmaengine device\n");
+			idxd_device_disable(idxd);
 			return rc;
 		}
+
+		dev_info(dev, "Device %s enabled\n", dev_name(dev));
 		return 0;
-	} else if (is_idxd_wq_dev(dev)) {
-		struct idxd_wq *wq = confdev_to_wq(dev);
+	}
+
+	if (is_idxd_wq_dev(idxd_dev)) {
+		struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
 
 		return drv_enable_wq(wq);
 	}
@@ -89,21 +100,14 @@ static int idxd_config_bus_probe(struct device *dev)
 	return -ENODEV;
 }
 
-static int idxd_config_bus_remove(struct device *dev)
+static void idxd_dsa_drv_remove(struct idxd_dev *idxd_dev)
 {
-	dev_dbg(dev, "%s called for %s\n", __func__, dev_name(dev));
-
-	/* disable workqueue here */
-	if (is_idxd_wq_dev(dev)) {
-		struct idxd_wq *wq = confdev_to_wq(dev);
+	struct device *dev = &idxd_dev->conf_dev;
 
-		drv_disable_wq(wq);
-	} else if (is_idxd_dev(dev)) {
-		struct idxd_device *idxd = confdev_to_idxd(dev);
+	if (is_idxd_dev(idxd_dev)) {
+		struct idxd_device *idxd = idxd_dev_to_idxd(idxd_dev);
 		int i;
 
-		dev_dbg(dev, "%s removing dev %s\n", __func__,
-			dev_name(idxd_confdev(idxd)));
 		for (i = 0; i < idxd->max_wqs; i++) {
 			struct idxd_wq *wq = idxd->wqs[i];
 
@@ -118,23 +122,21 @@ static int idxd_config_bus_remove(struct device *dev)
 		idxd_device_disable(idxd);
 		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
 			idxd_device_reset(idxd);
-		module_put(THIS_MODULE);
-
-		dev_info(dev, "Device %s disabled\n", dev_name(dev));
+		return;
 	}
 
-	return 0;
-}
+	if (is_idxd_wq_dev(idxd_dev)) {
+		struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
 
-struct bus_type dsa_bus_type = {
-	.name = "dsa",
-	.match = idxd_config_bus_match,
-	.probe = idxd_config_bus_probe,
-	.remove = idxd_config_bus_remove,
-};
+		drv_disable_wq(wq);
+		return;
+	}
+}
 
 static struct idxd_device_driver dsa_drv = {
 	.name = "dsa",
+	.probe = idxd_dsa_drv_probe,
+	.remove = idxd_dsa_drv_remove,
 };
 
 /* IDXD generic driver setup */


