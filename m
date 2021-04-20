Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2622365FAE
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 20:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhDTSrM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 14:47:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:51762 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233092AbhDTSrL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 14:47:11 -0400
IronPort-SDR: UTbPyyJq9+rl97GH12k8BzP55l+hRGX+4uSJbTOlMO0n3kPQQJxlQDZoqDAnCHsSTUM9e7MLNe
 qs8hqilYhhfw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="216189547"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="216189547"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:29 -0700
IronPort-SDR: GqUUTFzGiW91TYPR435kdOD5NxcIm1asnPp9uTeBfjkjElZ7aVy1wO2n6p9VK24xLdzxA3I48W
 TfmTZFXZFh/Q==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="401163794"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:28 -0700
Subject: [PATCH 2/6] dmaengine: idxd: add support for readonly config mode
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 20 Apr 2021 11:46:28 -0700
Message-ID: <161894438847.3202472.6317563824045432727.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
References: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The read-only configuration mode is defined by the DSA spec as a mode of
the device WQ configuration. When GENCAP register bit 31 is set to 0,
the device is in RO mode and group configuration and some fields of the
workqueue configuration registers are read-only and reflect the fixed
configuration of the device. Add support for RO mode. The driver will
load the values from the registers directly setup all the internally
cached data structures based on the device configuration.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |  116 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |    1 
 drivers/dma/idxd/init.c   |    8 +++
 drivers/dma/idxd/sysfs.c  |   22 +++++----
 4 files changed, 138 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 6d674fdedb4d..3ddb1c731080 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -884,3 +884,119 @@ int idxd_device_config(struct idxd_device *idxd)
 
 	return 0;
 }
+
+static int idxd_wq_load_config(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	int wqcfg_offset;
+	int i;
+
+	wqcfg_offset = WQCFG_OFFSET(idxd, wq->id, 0);
+	memcpy_fromio(wq->wqcfg, idxd->reg_base + wqcfg_offset, idxd->wqcfg_size);
+
+	wq->size = wq->wqcfg->wq_size;
+	wq->threshold = wq->wqcfg->wq_thresh;
+	if (wq->wqcfg->priv)
+		wq->type = IDXD_WQT_KERNEL;
+
+	/* The driver does not support shared WQ mode in read-only config yet */
+	if (wq->wqcfg->mode == 0 || wq->wqcfg->pasid_en)
+		return -EOPNOTSUPP;
+
+	set_bit(WQ_FLAG_DEDICATED, &wq->flags);
+
+	wq->priority = wq->wqcfg->priority;
+
+	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
+		wqcfg_offset = WQCFG_OFFSET(idxd, wq->id, i);
+		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n", wq->id, i, wqcfg_offset, wq->wqcfg->bits[i]);
+	}
+
+	return 0;
+}
+
+static void idxd_group_load_config(struct idxd_group *group)
+{
+	struct idxd_device *idxd = group->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	int i, j, grpcfg_offset;
+
+	/*
+	 * Load WQS bit fields
+	 * Iterate through all 256 bits 64 bits at a time
+	 */
+	for (i = 0; i < GRPWQCFG_STRIDES; i++) {
+		struct idxd_wq *wq;
+
+		grpcfg_offset = GRPWQCFG_OFFSET(idxd, group->id, i);
+		group->grpcfg.wqs[i] = ioread64(idxd->reg_base + grpcfg_offset);
+		dev_dbg(dev, "GRPCFG wq[%d:%d: %#x]: %#llx\n",
+			group->id, i, grpcfg_offset, group->grpcfg.wqs[i]);
+
+		if (i * 64 >= idxd->max_wqs)
+			break;
+
+		/* Iterate through all 64 bits and check for wq set */
+		for (j = 0; j < 64; j++) {
+			int id = i * 64 + j;
+
+			/* No need to check beyond max wqs */
+			if (id >= idxd->max_wqs)
+				break;
+
+			/* Set group assignment for wq if wq bit is set */
+			if (group->grpcfg.wqs[i] & BIT(j)) {
+				wq = idxd->wqs[id];
+				wq->group = group;
+			}
+		}
+	}
+
+	grpcfg_offset = GRPENGCFG_OFFSET(idxd, group->id);
+	group->grpcfg.engines = ioread64(idxd->reg_base + grpcfg_offset);
+	dev_dbg(dev, "GRPCFG engs[%d: %#x]: %#llx\n", group->id,
+		grpcfg_offset, group->grpcfg.engines);
+
+	/* Iterate through all 64 bits to check engines set */
+	for (i = 0; i < 64; i++) {
+		if (i >= idxd->max_engines)
+			break;
+
+		if (group->grpcfg.engines & BIT(i)) {
+			struct idxd_engine *engine = idxd->engines[i];
+
+			engine->group = group;
+		}
+	}
+
+	grpcfg_offset = GRPFLGCFG_OFFSET(idxd, group->id);
+	group->grpcfg.flags.bits = ioread32(idxd->reg_base + grpcfg_offset);
+	dev_dbg(dev, "GRPFLAGS flags[%d: %#x]: %#x\n",
+		group->id, grpcfg_offset, group->grpcfg.flags.bits);
+}
+
+int idxd_device_load_config(struct idxd_device *idxd)
+{
+	union gencfg_reg reg;
+	int i, rc;
+
+	reg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
+	idxd->token_limit = reg.token_limit;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		struct idxd_group *group = idxd->groups[i];
+
+		idxd_group_load_config(group);
+	}
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = idxd->wqs[i];
+
+		rc = idxd_wq_load_config(wq);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 1b539cbf3c14..940a2e1ddf12 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -384,6 +384,7 @@ void idxd_device_cleanup(struct idxd_device *idxd);
 int idxd_device_config(struct idxd_device *idxd);
 void idxd_device_wqs_clear_state(struct idxd_device *idxd);
 void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid);
+int idxd_device_load_config(struct idxd_device *idxd);
 
 /* work queue control */
 int idxd_wq_alloc_resources(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index eda5ffd307c6..a07e6d8eec00 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -482,6 +482,14 @@ static int idxd_probe(struct idxd_device *idxd)
 	if (rc)
 		goto err;
 
+	/* If the configs are readonly, then load them from device */
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
+		dev_dbg(dev, "Loading RO device config\n");
+		rc = idxd_device_load_config(idxd);
+		if (rc < 0)
+			goto err;
+	}
+
 	rc = idxd_setup_interrupts(idxd);
 	if (rc)
 		goto err;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index dad5c0be9ae8..d45cb61f300b 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -110,7 +110,8 @@ static int enable_wq(struct idxd_wq *wq)
 	}
 
 	spin_lock_irqsave(&idxd->dev_lock, flags);
-	rc = idxd_device_config(idxd);
+	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		rc = idxd_device_config(idxd);
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 	if (rc < 0) {
 		mutex_unlock(&wq->wq_lock);
@@ -170,7 +171,7 @@ static int enable_wq(struct idxd_wq *wq)
 
 static int idxd_config_bus_probe(struct device *dev)
 {
-	int rc;
+	int rc = 0;
 	unsigned long flags;
 
 	dev_dbg(dev, "%s called\n", __func__);
@@ -188,7 +189,8 @@ static int idxd_config_bus_probe(struct device *dev)
 
 		/* Perform IDXD configuration and enabling */
 		spin_lock_irqsave(&idxd->dev_lock, flags);
-		rc = idxd_device_config(idxd);
+		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+			rc = idxd_device_config(idxd);
 		spin_unlock_irqrestore(&idxd->dev_lock, flags);
 		if (rc < 0) {
 			module_put(THIS_MODULE);
@@ -287,12 +289,14 @@ static int idxd_config_bus_remove(struct device *dev)
 
 		idxd_unregister_dma_device(idxd);
 		rc = idxd_device_disable(idxd);
-		for (i = 0; i < idxd->max_wqs; i++) {
-			struct idxd_wq *wq = idxd->wqs[i];
-
-			mutex_lock(&wq->wq_lock);
-			idxd_wq_disable_cleanup(wq);
-			mutex_unlock(&wq->wq_lock);
+		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
+			for (i = 0; i < idxd->max_wqs; i++) {
+				struct idxd_wq *wq = idxd->wqs[i];
+
+				mutex_lock(&wq->wq_lock);
+				idxd_wq_disable_cleanup(wq);
+				mutex_unlock(&wq->wq_lock);
+			}
 		}
 		module_put(THIS_MODULE);
 		if (rc < 0)


