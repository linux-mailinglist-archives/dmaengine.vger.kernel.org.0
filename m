Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114A030CFBB
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 00:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhBBXLl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 18:11:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:35716 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236089AbhBBXLk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 2 Feb 2021 18:11:40 -0500
IronPort-SDR: gf0i6/YMpQkj7F3ekXTkIfUeJN0Pu8fMxJRzfAHEHyUt8gBb6ef/GWhANRGpBZgJwnrAf96Qrn
 4JJt4QqwxoMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="242462940"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="242462940"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:10:58 -0800
IronPort-SDR: MlkYYzwGcZ5hxgrx+oOnXDJPmbI26TymmS+OuBkw8nl8tQNXrn7LMos351qlsFveXLdTq+wjg2
 hgQ38Sz9QKQA==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="575693706"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:10:58 -0800
Subject: [PATCH] dmaengine: idxd: add support for readonly config mode
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 02 Feb 2021 16:10:57 -0700
Message-ID: <161230745733.3446217.5102188183075947665.stgit@djiang5-desk3.ch.intel.com>
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
index b7227f2abe78..b0873222e05f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -827,3 +827,119 @@ int idxd_device_config(struct idxd_device *idxd)
 
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
+				wq = &idxd->wqs[id];
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
+			struct idxd_engine *engine = &idxd->engines[i];
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
+		struct idxd_group *group = &idxd->groups[i];
+
+		idxd_group_load_config(group);
+	}
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+
+		rc = idxd_wq_load_config(wq);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index d1d56b1fae37..67d476a7002f 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -336,6 +336,7 @@ void idxd_device_cleanup(struct idxd_device *idxd);
 int idxd_device_config(struct idxd_device *idxd);
 void idxd_device_wqs_clear_state(struct idxd_device *idxd);
 void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid);
+int idxd_device_load_config(struct idxd_device *idxd);
 
 /* work queue control */
 int idxd_wq_alloc_resources(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index ee203fdebac3..a3ed31056869 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -361,6 +361,14 @@ static int idxd_probe(struct idxd_device *idxd)
 	if (rc)
 		goto err_setup;
 
+	/* If the configs are readonly, then load them from device */
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
+		dev_dbg(dev, "Loading RO device config\n");
+		rc = idxd_device_load_config(idxd);
+		if (rc < 0)
+			goto err_setup;
+	}
+
 	rc = idxd_setup_interrupts(idxd);
 	if (rc)
 		goto err_setup;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index f4e93db8e26e..07f8068a813a 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -173,7 +173,8 @@ static int enable_wq(struct idxd_wq *wq)
 	}
 
 	spin_lock_irqsave(&idxd->dev_lock, flags);
-	rc = idxd_device_config(idxd);
+	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		rc = idxd_device_config(idxd);
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 	if (rc < 0) {
 		mutex_unlock(&wq->wq_lock);
@@ -233,7 +234,7 @@ static int enable_wq(struct idxd_wq *wq)
 
 static int idxd_config_bus_probe(struct device *dev)
 {
-	int rc;
+	int rc = 0;
 	unsigned long flags;
 
 	dev_dbg(dev, "%s called\n", __func__);
@@ -251,7 +252,8 @@ static int idxd_config_bus_probe(struct device *dev)
 
 		/* Perform IDXD configuration and enabling */
 		spin_lock_irqsave(&idxd->dev_lock, flags);
-		rc = idxd_device_config(idxd);
+		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+			rc = idxd_device_config(idxd);
 		spin_unlock_irqrestore(&idxd->dev_lock, flags);
 		if (rc < 0) {
 			module_put(THIS_MODULE);
@@ -355,12 +357,14 @@ static int idxd_config_bus_remove(struct device *dev)
 
 		idxd_unregister_dma_device(idxd);
 		rc = idxd_device_disable(idxd);
-		for (i = 0; i < idxd->max_wqs; i++) {
-			struct idxd_wq *wq = &idxd->wqs[i];
-
-			mutex_lock(&wq->wq_lock);
-			idxd_wq_disable_cleanup(wq);
-			mutex_unlock(&wq->wq_lock);
+		if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
+			for (i = 0; i < idxd->max_wqs; i++) {
+				struct idxd_wq *wq = &idxd->wqs[i];
+
+				mutex_lock(&wq->wq_lock);
+				idxd_wq_disable_cleanup(wq);
+				mutex_unlock(&wq->wq_lock);
+			}
 		}
 		module_put(THIS_MODULE);
 		if (rc < 0)


