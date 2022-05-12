Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DF0524164
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 02:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349569AbiELAMN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 20:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349554AbiELAML (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 20:12:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4E087A2A
        for <dmaengine@vger.kernel.org>; Wed, 11 May 2022 17:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652314318; x=1683850318;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=je842DzU7tJ5GlvnJuAlxAbGJM2L0ay2mCoKKhVSfRU=;
  b=Bu5jeyGfh4NFI0ZIJk1VyxhMCW84pDxhde0qxAi1FkcNt6H5Co0BSctI
   nyMafv+wrd4SiybvPtYR/df7K5S4joErjcs/8DCREhKphXVKB86os1L6S
   4RBj8OwljVjwlV+7VQtLPMda8oa6ochJ/5dFOX7m61K4YpOWladxWETJ8
   xL4q+WvExU7hdKSRyc6wRv8ZGolXTObFafLJAqePq5ricZyf6z4D96lN0
   C0WVDCioAYuUluRaWGLXAjOWQ7X82SjD2JEgUsoFJtGM3K2nrHZoTZPLt
   NSOQTqcyJyH/O6OtbJZ6QyAs4y5aWmpkS4cujQGlymO+B2kxckbsCTpwR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249741700"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="249741700"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:11:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="697797888"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:11:57 -0700
Subject: [PATCH] dmaengine: idxd: Separate user and kernel pasid enabling
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, jacob.jun.pan@linux.intel.com,
        baolu.lu@intel.com
Date:   Wed, 11 May 2022 17:11:57 -0700
Message-ID: <165231431746.986466.5666862038354800551.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The idxd driver always gated the pasid enabling under a single knob and
this assumption is incorrect. The pasid used for kernel operation can be
independently toggled and has no dependency on the user pasid (and vice
versa). Split the two so they are independent "enabled" flags.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/cdev.c   |    4 ++--
 drivers/dma/idxd/device.c |    6 +++---
 drivers/dma/idxd/idxd.h   |   16 ++++++++++++++--
 drivers/dma/idxd/init.c   |   30 +++++++++++++++---------------
 drivers/dma/idxd/sysfs.c  |    2 +-
 5 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index b670b75885ad..28796df62ea6 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -99,7 +99,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	ctx->wq = wq;
 	filp->private_data = ctx;
 
-	if (device_pasid_enabled(idxd)) {
+	if (device_user_pasid_enabled(idxd)) {
 		sva = iommu_sva_bind_device(dev, current->mm, NULL);
 		if (IS_ERR(sva)) {
 			rc = PTR_ERR(sva);
@@ -152,7 +152,7 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	if (wq_shared(wq)) {
 		idxd_device_drain_pasid(idxd, ctx->pasid);
 	} else {
-		if (device_pasid_enabled(idxd)) {
+		if (device_user_pasid_enabled(idxd)) {
 			/* The wq disable in the disable pasid function will drain the wq */
 			rc = idxd_wq_disable_pasid(wq);
 			if (rc < 0)
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index d1dba2a3af5d..d576268374d0 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -965,7 +965,7 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
 		if (!wq->group)
 			continue;
 
-		if (wq_shared(wq) && !device_swq_supported(idxd)) {
+		if (wq_shared(wq) && !wq_shared_supported(wq)) {
 			idxd->cmd_status = IDXD_SCMD_WQ_NO_SWQ_SUPPORT;
 			dev_warn(dev, "No shared wq support but configured.\n");
 			return -EINVAL;
@@ -1266,7 +1266,7 @@ int drv_enable_wq(struct idxd_wq *wq)
 
 	/* Shared WQ checks */
 	if (wq_shared(wq)) {
-		if (!device_swq_supported(idxd)) {
+		if (!wq_shared_supported(wq)) {
 			idxd->cmd_status = IDXD_SCMD_WQ_NO_SVM;
 			dev_dbg(dev, "PASID not enabled and shared wq.\n");
 			goto err;
@@ -1296,7 +1296,7 @@ int drv_enable_wq(struct idxd_wq *wq)
 	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
 		int priv = 0;
 
-		if (device_pasid_enabled(idxd)) {
+		if (wq_pasid_enabled(wq)) {
 			if (is_idxd_wq_kernel(wq) || wq_shared(wq)) {
 				u32 pasid = wq_dedicated(wq) ? idxd->pasid : 0;
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 24e6a0824c64..fed0dfc1eaa8 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -239,6 +239,7 @@ enum idxd_device_flag {
 	IDXD_FLAG_CONFIGURABLE = 0,
 	IDXD_FLAG_CMD_RUNNING,
 	IDXD_FLAG_PASID_ENABLED,
+	IDXD_FLAG_USER_PASID_ENABLED,
 };
 
 struct idxd_dma_dev {
@@ -469,9 +470,20 @@ static inline bool device_pasid_enabled(struct idxd_device *idxd)
 	return test_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 }
 
-static inline bool device_swq_supported(struct idxd_device *idxd)
+static inline bool device_user_pasid_enabled(struct idxd_device *idxd)
 {
-	return (support_enqcmd && device_pasid_enabled(idxd));
+	return test_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
+}
+
+static inline bool wq_pasid_enabled(struct idxd_wq *wq)
+{
+	return (is_idxd_wq_kernel(wq) && device_pasid_enabled(wq->idxd)) ||
+	       (is_idxd_wq_user(wq) && device_user_pasid_enabled(wq->idxd));
+}
+
+static inline bool wq_shared_supported(struct idxd_wq *wq)
+{
+	return (support_enqcmd && wq_pasid_enabled(wq));
 }
 
 enum idxd_portal_prot {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 993a5dcca24f..355fb3ef4cbf 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -512,18 +512,15 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD reset complete\n");
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
-		rc = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA);
-		if (rc == 0) {
-			rc = idxd_enable_system_pasid(idxd);
-			if (rc < 0) {
-				iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
-				dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
-			} else {
-				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
-			}
-		} else {
-			dev_warn(dev, "Unable to turn on SVA feature.\n");
-		}
+		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
+			dev_warn(dev, "Unable to turn on user SVA feature.\n");
+		else
+			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
+
+		if (idxd_enable_system_pasid(idxd))
+			dev_warn(dev, "No in-kernel DMA with PASID.\n");
+		else
+			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 	} else if (!sva) {
 		dev_warn(dev, "User forced SVA off via module param.\n");
 	}
@@ -561,7 +558,8 @@ static int idxd_probe(struct idxd_device *idxd)
  err:
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+	if (device_user_pasid_enabled(idxd))
+		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
 	return rc;
 }
 
@@ -574,7 +572,8 @@ static void idxd_cleanup(struct idxd_device *idxd)
 	idxd_cleanup_internals(idxd);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
+	if (device_user_pasid_enabled(idxd))
+		iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA);
 }
 
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -691,7 +690,8 @@ static void idxd_remove(struct pci_dev *pdev)
 	free_irq(irq_entry->vector, irq_entry);
 	pci_free_irq_vectors(pdev);
 	pci_iounmap(pdev, idxd->reg_base);
-	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
+	if (device_user_pasid_enabled(idxd))
+		iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 7e628e31ce24..d482e708f0fa 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -588,7 +588,7 @@ static ssize_t wq_mode_store(struct device *dev,
 	if (sysfs_streq(buf, "dedicated")) {
 		set_bit(WQ_FLAG_DEDICATED, &wq->flags);
 		wq->threshold = 0;
-	} else if (sysfs_streq(buf, "shared") && device_swq_supported(idxd)) {
+	} else if (sysfs_streq(buf, "shared")) {
 		clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
 	} else {
 		return -EINVAL;


