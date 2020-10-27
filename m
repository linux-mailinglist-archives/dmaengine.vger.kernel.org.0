Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5629C24C
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 18:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1820125AbgJ0Reh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 13:34:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:37729 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1814604AbgJ0Reh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 13:34:37 -0400
IronPort-SDR: TJkArxF/bsJdZXuwPrYnjfW3LQrUICr3BjIfT1uAF6VUWa0Xg+3gXHx0TQpBjZsy3t6SfivhLf
 x7oOZ2z8U1ZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="185876837"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="185876837"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:34:36 -0700
IronPort-SDR: w6VG2Wz6Gws1y81YEGlXnBjKzk2GcHfxpzbqa4BvKdBGhjfOoB4l/fd46cdaDPf31vAdr+j14P
 DzLzZKMau9/Q==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="468413108"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:34:35 -0700
Subject: [PATCH v8 1/3] dmaengine: idxd: Add shared workqueue support
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 27 Oct 2020 10:34:35 -0700
Message-ID: <160382007499.3911367.26043087963708134.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <160381975739.3911367.10543310695440091523.stgit@djiang5-desk3.ch.intel.com>
References: <160381975739.3911367.10543310695440091523.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add shared workqueue support that includes the support of Shared Virtual
memory (SVM) or in similar terms On Demand Paging (ODP). The shared
workqueue uses the enqcmds command in kernel and will respond with retry if
the workqueue is full. Shared workqueue only works when there is PASID
support from the IOMMU.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/Kconfig          |   10 +++
 drivers/dma/idxd/cdev.c      |   49 ++++++++++++++++
 drivers/dma/idxd/device.c    |   95 ++++++++++++++++++++++++++++---
 drivers/dma/idxd/dma.c       |    9 ---
 drivers/dma/idxd/idxd.h      |   28 +++++++++
 drivers/dma/idxd/init.c      |   91 +++++++++++++++++++++++-------
 drivers/dma/idxd/registers.h |   16 +++++
 drivers/dma/idxd/submit.c    |   35 ++++++++++--
 drivers/dma/idxd/sysfs.c     |  127 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 414 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 518a1437862a..6a908785a5f7 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -296,6 +296,16 @@ config INTEL_IDXD
 
 	  If unsure, say N.
 
+# Config symbol that collects all the dependencies that's necessary to
+# support shared virtual memory for the devices supported by idxd.
+config INTEL_IDXD_SVM
+	bool "Accelerator Shared Virtual Memory Support"
+	depends on INTEL_IDXD
+	depends on INTEL_IOMMU_SVM
+	depends on PCI_PRI
+	depends on PCI_PASID
+	depends on PCI_IOV
+
 config INTEL_IOATDMA
 	tristate "Intel I/OAT DMA support"
 	depends on PCI && X86_64
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index c3976156db2f..010b820d8f74 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -11,6 +11,7 @@
 #include <linux/cdev.h>
 #include <linux/fs.h>
 #include <linux/poll.h>
+#include <linux/iommu.h>
 #include <uapi/linux/idxd.h>
 #include "registers.h"
 #include "idxd.h"
@@ -32,7 +33,9 @@ static struct idxd_cdev_context ictx[IDXD_TYPE_MAX] = {
 struct idxd_user_context {
 	struct idxd_wq *wq;
 	struct task_struct *task;
+	unsigned int pasid;
 	unsigned int flags;
+	struct iommu_sva *sva;
 };
 
 enum idxd_cdev_cleanup {
@@ -75,6 +78,8 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_wq *wq;
 	struct device *dev;
 	int rc = 0;
+	struct iommu_sva *sva;
+	unsigned int pasid;
 
 	wq = inode_wq(inode);
 	idxd = wq->idxd;
@@ -95,6 +100,34 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 	ctx->wq = wq;
 	filp->private_data = ctx;
+
+	if (device_pasid_enabled(idxd)) {
+		sva = iommu_sva_bind_device(dev, current->mm, NULL);
+		if (IS_ERR(sva)) {
+			rc = PTR_ERR(sva);
+			dev_err(dev, "pasid allocation failed: %d\n", rc);
+			goto failed;
+		}
+
+		pasid = iommu_sva_get_pasid(sva);
+		if (pasid == IOMMU_PASID_INVALID) {
+			iommu_sva_unbind_device(sva);
+			goto failed;
+		}
+
+		ctx->sva = sva;
+		ctx->pasid = pasid;
+
+		if (wq_dedicated(wq)) {
+			rc = idxd_wq_set_pasid(wq, pasid);
+			if (rc < 0) {
+				iommu_sva_unbind_device(sva);
+				dev_err(dev, "wq set pasid failed: %d\n", rc);
+				goto failed;
+			}
+		}
+	}
+
 	idxd_wq_get(wq);
 	mutex_unlock(&wq->wq_lock);
 	return 0;
@@ -111,13 +144,27 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	struct idxd_wq *wq = ctx->wq;
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
+	int rc;
 
 	dev_dbg(dev, "%s called\n", __func__);
 	filep->private_data = NULL;
 
 	/* Wait for in-flight operations to complete. */
-	idxd_wq_drain(wq);
+	if (wq_shared(wq)) {
+		idxd_device_drain_pasid(idxd, ctx->pasid);
+	} else {
+		if (device_pasid_enabled(idxd)) {
+			/* The wq disable in the disable pasid function will drain the wq */
+			rc = idxd_wq_disable_pasid(wq);
+			if (rc < 0)
+				dev_err(dev, "wq disable pasid failed.\n");
+		} else {
+			idxd_wq_drain(wq);
+		}
+	}
 
+	if (ctx->sva)
+		iommu_sva_unbind_device(ctx->sva);
 	kfree(ctx);
 	mutex_lock(&wq->wq_lock);
 	idxd_wq_put(wq);
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 200b9109cacf..f43453df76c8 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -273,10 +273,9 @@ int idxd_wq_map_portal(struct idxd_wq *wq)
 	start = pci_resource_start(pdev, IDXD_WQ_BAR);
 	start = start + wq->id * IDXD_PORTAL_SIZE;
 
-	wq->dportal = devm_ioremap(dev, start, IDXD_PORTAL_SIZE);
-	if (!wq->dportal)
+	wq->portal = devm_ioremap(dev, start, IDXD_PORTAL_SIZE);
+	if (!wq->portal)
 		return -ENOMEM;
-	dev_dbg(dev, "wq %d portal mapped at %p\n", wq->id, wq->dportal);
 
 	return 0;
 }
@@ -285,7 +284,61 @@ void idxd_wq_unmap_portal(struct idxd_wq *wq)
 {
 	struct device *dev = &wq->idxd->pdev->dev;
 
-	devm_iounmap(dev, wq->dportal);
+	devm_iounmap(dev, wq->portal);
+}
+
+int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
+{
+	struct idxd_device *idxd = wq->idxd;
+	int rc;
+	union wqcfg wqcfg;
+	unsigned int offset;
+	unsigned long flags;
+
+	rc = idxd_wq_disable(wq);
+	if (rc < 0)
+		return rc;
+
+	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PASID_IDX);
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	wqcfg.bits[WQCFG_PASID_IDX] = ioread32(idxd->reg_base + offset);
+	wqcfg.pasid_en = 1;
+	wqcfg.pasid = pasid;
+	iowrite32(wqcfg.bits[WQCFG_PASID_IDX], idxd->reg_base + offset);
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+
+	rc = idxd_wq_enable(wq);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+int idxd_wq_disable_pasid(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	int rc;
+	union wqcfg wqcfg;
+	unsigned int offset;
+	unsigned long flags;
+
+	rc = idxd_wq_disable(wq);
+	if (rc < 0)
+		return rc;
+
+	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PASID_IDX);
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	wqcfg.bits[WQCFG_PASID_IDX] = ioread32(idxd->reg_base + offset);
+	wqcfg.pasid_en = 0;
+	wqcfg.pasid = 0;
+	iowrite32(wqcfg.bits[WQCFG_PASID_IDX], idxd->reg_base + offset);
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+
+	rc = idxd_wq_enable(wq);
+	if (rc < 0)
+		return rc;
+
+	return 0;
 }
 
 void idxd_wq_disable_cleanup(struct idxd_wq *wq)
@@ -305,7 +358,7 @@ void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	memset(wq->name, 0, WQ_NAME_SIZE);
 
 	for (i = 0; i < 8; i++) {
-		wq_offset = idxd->wqcfg_offset + wq->id * 32 + i * sizeof(u32);
+		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
 		iowrite32(0, idxd->reg_base + wq_offset);
 		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n",
 			wq->id, i, wq_offset,
@@ -468,6 +521,17 @@ void idxd_device_reset(struct idxd_device *idxd)
 	spin_unlock_irqrestore(&idxd->dev_lock, flags);
 }
 
+void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid)
+{
+	struct device *dev = &idxd->pdev->dev;
+	u32 operand;
+
+	operand = pasid;
+	dev_dbg(dev, "cmd: %u operand: %#x\n", IDXD_CMD_DRAIN_PASID, operand);
+	idxd_cmd_exec(idxd, IDXD_CMD_DRAIN_PASID, operand, NULL);
+	dev_dbg(dev, "pasid %d drained\n", pasid);
+}
+
 /* Device configuration bits */
 static void idxd_group_config_write(struct idxd_group *group)
 {
@@ -553,18 +617,29 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	wq->wqcfg.wq_thresh = wq->threshold;
 
 	/* byte 8-11 */
-	wq->wqcfg.priv = !!(wq->type == IDXD_WQT_KERNEL);
-	wq->wqcfg.mode = 1;
+	wq->wqcfg.priv = wq->type == IDXD_WQT_KERNEL ? 1 : 0;
+	if (wq_dedicated(wq))
+		wq->wqcfg.mode = 1;
+
+	if (device_pasid_enabled(idxd)) {
+		wq->wqcfg.pasid_en = 1;
+		if (wq->type == IDXD_WQT_KERNEL && wq_dedicated(wq))
+			wq->wqcfg.pasid = idxd->pasid;
+	}
 
 	wq->wqcfg.priority = wq->priority;
 
+	if (idxd->hw.gen_cap.block_on_fault &&
+	    test_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags))
+		wq->wqcfg.bof = 1;
+
 	/* bytes 12-15 */
 	wq->wqcfg.max_xfer_shift = ilog2(wq->max_xfer_bytes);
 	wq->wqcfg.max_batch_shift = ilog2(wq->max_batch_size);
 
 	dev_dbg(dev, "WQ %d CFGs\n", wq->id);
 	for (i = 0; i < 8; i++) {
-		wq_offset = idxd->wqcfg_offset + wq->id * 32 + i * sizeof(u32);
+		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
 		iowrite32(wq->wqcfg.bits[i], idxd->reg_base + wq_offset);
 		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n",
 			wq->id, i, wq_offset,
@@ -665,8 +740,8 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
 		if (!wq->size)
 			continue;
 
-		if (!wq_dedicated(wq)) {
-			dev_warn(dev, "No shared workqueue support.\n");
+		if (wq_shared(wq) && !device_swq_supported(idxd)) {
+			dev_warn(dev, "No shared wq support but configured.\n");
 			return -EINVAL;
 		}
 
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 0c892cbd72e0..8ed2773d8285 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -61,8 +61,6 @@ static inline void idxd_prep_desc_common(struct idxd_wq *wq,
 					 u64 addr_f1, u64 addr_f2, u64 len,
 					 u64 compl, u32 flags)
 {
-	struct idxd_device *idxd = wq->idxd;
-
 	hw->flags = flags;
 	hw->opcode = opcode;
 	hw->src_addr = addr_f1;
@@ -70,13 +68,6 @@ static inline void idxd_prep_desc_common(struct idxd_wq *wq,
 	hw->xfer_size = len;
 	hw->priv = !!(wq->type == IDXD_WQT_KERNEL);
 	hw->completion_addr = compl;
-
-	/*
-	 * Descriptor completion vectors are 1-8 for MSIX. We will round
-	 * robin through the 8 vectors.
-	 */
-	wq->vec_ptr = (wq->vec_ptr % idxd->num_wq_irqs) + 1;
-	hw->int_handle =  wq->vec_ptr;
 }
 
 static struct dma_async_tx_descriptor *
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index c64df197e724..43a216c42d25 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -59,6 +59,7 @@ enum idxd_wq_state {
 
 enum idxd_wq_flag {
 	WQ_FLAG_DEDICATED = 0,
+	WQ_FLAG_BLOCK_ON_FAULT,
 };
 
 enum idxd_wq_type {
@@ -86,10 +87,11 @@ enum idxd_op_type {
 enum idxd_complete_type {
 	IDXD_COMPLETE_NORMAL = 0,
 	IDXD_COMPLETE_ABORT,
+	IDXD_COMPLETE_DEV_FAIL,
 };
 
 struct idxd_wq {
-	void __iomem *dportal;
+	void __iomem *portal;
 	struct device conf_dev;
 	struct idxd_cdev idxd_cdev;
 	struct idxd_device *idxd;
@@ -145,6 +147,7 @@ enum idxd_device_state {
 enum idxd_device_flag {
 	IDXD_FLAG_CONFIGURABLE = 0,
 	IDXD_FLAG_CMD_RUNNING,
+	IDXD_FLAG_PASID_ENABLED,
 };
 
 struct idxd_device {
@@ -167,6 +170,9 @@ struct idxd_device {
 	struct idxd_wq *wqs;
 	struct idxd_engine *engines;
 
+	struct iommu_sva *sva;
+	unsigned int pasid;
+
 	int num_groups;
 
 	u32 msix_perm_offset;
@@ -214,11 +220,28 @@ struct idxd_desc {
 
 extern struct bus_type dsa_bus_type;
 
+extern bool support_enqcmd;
+
 static inline bool wq_dedicated(struct idxd_wq *wq)
 {
 	return test_bit(WQ_FLAG_DEDICATED, &wq->flags);
 }
 
+static inline bool wq_shared(struct idxd_wq *wq)
+{
+	return !test_bit(WQ_FLAG_DEDICATED, &wq->flags);
+}
+
+static inline bool device_pasid_enabled(struct idxd_device *idxd)
+{
+	return test_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
+}
+
+static inline bool device_swq_supported(struct idxd_device *idxd)
+{
+	return (support_enqcmd && device_pasid_enabled(idxd));
+}
+
 enum idxd_portal_prot {
 	IDXD_PORTAL_UNLIMITED = 0,
 	IDXD_PORTAL_LIMITED,
@@ -287,6 +310,7 @@ void idxd_device_reset(struct idxd_device *idxd);
 void idxd_device_cleanup(struct idxd_device *idxd);
 int idxd_device_config(struct idxd_device *idxd);
 void idxd_device_wqs_clear_state(struct idxd_device *idxd);
+void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid);
 
 /* work queue control */
 int idxd_wq_alloc_resources(struct idxd_wq *wq);
@@ -297,6 +321,8 @@ void idxd_wq_drain(struct idxd_wq *wq);
 int idxd_wq_map_portal(struct idxd_wq *wq);
 void idxd_wq_unmap_portal(struct idxd_wq *wq);
 void idxd_wq_disable_cleanup(struct idxd_wq *wq);
+int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid);
+int idxd_wq_disable_pasid(struct idxd_wq *wq);
 
 /* submission */
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 11e5ce168177..626401a71fdd 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -14,6 +14,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/intel-svm.h>
+#include <linux/iommu.h>
 #include <uapi/linux/idxd.h>
 #include <linux/dmaengine.h>
 #include "../dmaengine.h"
@@ -26,6 +28,8 @@ MODULE_AUTHOR("Intel Corporation");
 
 #define DRV_NAME "idxd"
 
+bool support_enqcmd;
+
 static struct idr idxd_idrs[IDXD_TYPE_MAX];
 static struct mutex idxd_idr_lock;
 
@@ -53,6 +57,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	struct idxd_irq_entry *irq_entry;
 	int i, msixcnt;
 	int rc = 0;
+	union msix_perm mperm;
 
 	msixcnt = pci_msix_vec_count(pdev);
 	if (msixcnt < 0) {
@@ -131,6 +136,13 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 
 	idxd_unmask_error_interrupts(idxd);
 
+	/* Setup MSIX permission table */
+	mperm.bits = 0;
+	mperm.pasid = idxd->pasid;
+	mperm.pasid_en = device_pasid_enabled(idxd);
+	for (i = 1; i < msixcnt; i++)
+		iowrite32(mperm.bits, idxd->reg_base + idxd->msix_perm_offset + i * 8);
+
 	return 0;
 
  err_no_irq:
@@ -260,8 +272,7 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	}
 }
 
-static struct idxd_device *idxd_alloc(struct pci_dev *pdev,
-				      void __iomem * const *iomap)
+static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct idxd_device *idxd;
@@ -271,12 +282,45 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev,
 		return NULL;
 
 	idxd->pdev = pdev;
-	idxd->reg_base = iomap[IDXD_MMIO_BAR];
 	spin_lock_init(&idxd->dev_lock);
 
 	return idxd;
 }
 
+static int idxd_enable_system_pasid(struct idxd_device *idxd)
+{
+	int flags;
+	unsigned int pasid;
+	struct iommu_sva *sva;
+
+	flags = SVM_FLAG_SUPERVISOR_MODE;
+
+	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
+	if (IS_ERR(sva)) {
+		dev_warn(&idxd->pdev->dev,
+			 "iommu sva bind failed: %ld\n", PTR_ERR(sva));
+		return PTR_ERR(sva);
+	}
+
+	pasid = iommu_sva_get_pasid(sva);
+	if (pasid == IOMMU_PASID_INVALID) {
+		iommu_sva_unbind_device(sva);
+		return -ENODEV;
+	}
+
+	idxd->sva = sva;
+	idxd->pasid = pasid;
+	dev_dbg(&idxd->pdev->dev, "system pasid: %u\n", pasid);
+	return 0;
+}
+
+static void idxd_disable_system_pasid(struct idxd_device *idxd)
+{
+
+	iommu_sva_unbind_device(idxd->sva);
+	idxd->sva = NULL;
+}
+
 static int idxd_probe(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
@@ -287,6 +331,14 @@ static int idxd_probe(struct idxd_device *idxd)
 	idxd_device_init_reset(idxd);
 	dev_dbg(dev, "IDXD reset complete\n");
 
+	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM)) {
+		rc = idxd_enable_system_pasid(idxd);
+		if (rc < 0)
+			dev_warn(dev, "Failed to enable PASID. No SVA support: %d\n", rc);
+		else
+			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
+	}
+
 	idxd_read_caps(idxd);
 	idxd_read_table_offsets(idxd);
 
@@ -317,29 +369,29 @@ static int idxd_probe(struct idxd_device *idxd)
 	idxd_mask_error_interrupts(idxd);
 	idxd_mask_msix_vectors(idxd);
  err_setup:
+	if (device_pasid_enabled(idxd))
+		idxd_disable_system_pasid(idxd);
 	return rc;
 }
 
 static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	void __iomem * const *iomap;
 	struct device *dev = &pdev->dev;
 	struct idxd_device *idxd;
 	int rc;
-	unsigned int mask;
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
-	dev_dbg(dev, "Mapping BARs\n");
-	mask = (1 << IDXD_MMIO_BAR);
-	rc = pcim_iomap_regions(pdev, mask, DRV_NAME);
-	if (rc)
-		return rc;
+	dev_dbg(dev, "Alloc IDXD context\n");
+	idxd = idxd_alloc(pdev);
+	if (!idxd)
+		return -ENOMEM;
 
-	iomap = pcim_iomap_table(pdev);
-	if (!iomap)
+	dev_dbg(dev, "Mapping BARs\n");
+	idxd->reg_base = pcim_iomap(pdev, IDXD_MMIO_BAR, 0);
+	if (!idxd->reg_base)
 		return -ENOMEM;
 
 	dev_dbg(dev, "Set DMA masks\n");
@@ -355,11 +407,6 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	dev_dbg(dev, "Alloc IDXD context\n");
-	idxd = idxd_alloc(pdev, iomap);
-	if (!idxd)
-		return -ENOMEM;
-
 	idxd_set_type(idxd);
 
 	dev_dbg(dev, "Set PCI master\n");
@@ -447,6 +494,8 @@ static void idxd_remove(struct pci_dev *pdev)
 	dev_dbg(&pdev->dev, "%s called\n", __func__);
 	idxd_cleanup_sysfs(idxd);
 	idxd_shutdown(pdev);
+	if (device_pasid_enabled(idxd))
+		idxd_disable_system_pasid(idxd);
 	mutex_lock(&idxd_idr_lock);
 	idr_remove(&idxd_idrs[idxd->type], idxd->id);
 	mutex_unlock(&idxd_idr_lock);
@@ -465,7 +514,7 @@ static int __init idxd_init_module(void)
 	int err, i;
 
 	/*
-	 * If the CPU does not support write512, there's no point in
+	 * If the CPU does not support MOVDIR64B or ENQCMDS, there's no point in
 	 * enumerating the device. We can not utilize it.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_MOVDIR64B)) {
@@ -473,8 +522,10 @@ static int __init idxd_init_module(void)
 		return -ENODEV;
 	}
 
-	pr_info("%s: Intel(R) Accelerator Devices Driver %s\n",
-		DRV_NAME, IDXD_DRIVER_VERSION);
+	if (!boot_cpu_has(X86_FEATURE_ENQCMD))
+		pr_warn("Platform does not have ENQCMD(S) support.\n");
+	else
+		support_enqcmd = true;
 
 	mutex_init(&idxd_idr_lock);
 	for (i = 0; i < IDXD_TYPE_MAX; i++)
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index a39e7ae6b3d9..070616b11a77 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -333,4 +333,20 @@ union wqcfg {
 	};
 	u32 bits[8];
 } __packed;
+
+#define WQCFG_PASID_IDX                2
+
+/*
+ * This macro calculates the offset into the WQCFG register
+ * idxd - struct idxd *
+ * n - wq id
+ * ofs - the index of the 32b dword for the config register
+ *
+ * The WQCFG register block is divided into groups per each wq. The n index
+ * allows us to move to the register group that's for that particular wq.
+ * Each register is 32bits. The ofs gives us the number of register to access.
+ */
+#define WQCFG_OFFSET(idxd_dev, n, ofs) ((idxd_dev)->wqcfg_offset +\
+					(n) * sizeof(union wqcfg) +\
+					sizeof(u32) * (ofs))
 #endif
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 156a1ee233aa..efca5d8468a6 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -11,11 +11,22 @@
 static struct idxd_desc *__get_desc(struct idxd_wq *wq, int idx, int cpu)
 {
 	struct idxd_desc *desc;
+	struct idxd_device *idxd = wq->idxd;
 
 	desc = wq->descs[idx];
 	memset(desc->hw, 0, sizeof(struct dsa_hw_desc));
 	memset(desc->completion, 0, sizeof(struct dsa_completion_record));
 	desc->cpu = cpu;
+
+	if (device_pasid_enabled(idxd))
+		desc->hw->pasid = idxd->pasid;
+
+	/*
+	 * Descriptor completion vectors are 1-8 for MSIX. We will round
+	 * robin through the 8 vectors.
+	 */
+	wq->vec_ptr = (wq->vec_ptr % idxd->num_wq_irqs) + 1;
+	desc->hw->int_handle = wq->vec_ptr;
 	return desc;
 }
 
@@ -70,18 +81,32 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	struct idxd_device *idxd = wq->idxd;
 	int vec = desc->hw->int_handle;
 	void __iomem *portal;
+	int rc;
 
 	if (idxd->state != IDXD_DEV_ENABLED)
 		return -EIO;
 
-	portal = wq->dportal + idxd_get_wq_portal_offset(IDXD_PORTAL_UNLIMITED);
+	portal = wq->portal + idxd_get_wq_portal_offset(IDXD_PORTAL_LIMITED);
+
 	/*
-	 * The wmb() flushes writes to coherent DMA data before possibly
-	 * triggering a DMA read. The wmb() is necessary even on UP because
-	 * the recipient is a device.
+	 * The wmb() flushes writes to coherent DMA data before
+	 * possibly triggering a DMA read. The wmb() is necessary
+	 * even on UP because the recipient is a device.
 	 */
 	wmb();
-	iosubmit_cmds512(portal, desc->hw, 1);
+	if (wq_dedicated(wq)) {
+		iosubmit_cmds512(portal, desc->hw, 1);
+	} else {
+		/*
+		 * It's not likely that we would receive queue full rejection
+		 * since the descriptor allocation gates at wq size. If we
+		 * receive a -EAGAIN, that means something went wrong such as the
+		 * device is not accepting descriptor at all.
+		 */
+		rc = enqcmds(portal, desc->hw);
+		if (rc < 0)
+			return rc;
+	}
 
 	/*
 	 * Pending the descriptor to the lockless list for the irq_entry
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 07a5db06a29a..6d292eb79bf3 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -175,6 +175,30 @@ static int idxd_config_bus_probe(struct device *dev)
 			return -EINVAL;
 		}
 
+		/* Shared WQ checks */
+		if (wq_shared(wq)) {
+			if (!device_swq_supported(idxd)) {
+				dev_warn(dev,
+					 "PASID not enabled and shared WQ.\n");
+				mutex_unlock(&wq->wq_lock);
+				return -ENXIO;
+			}
+			/*
+			 * Shared wq with the threshold set to 0 means the user
+			 * did not set the threshold or transitioned from a
+			 * dedicated wq but did not set threshold. A value
+			 * of 0 would effectively disable the shared wq. The
+			 * driver does not allow a value of 0 to be set for
+			 * threshold via sysfs.
+			 */
+			if (wq->threshold == 0) {
+				dev_warn(dev,
+					 "Shared WQ and threshold 0.\n");
+				mutex_unlock(&wq->wq_lock);
+				return -EINVAL;
+			}
+		}
+
 		rc = idxd_wq_alloc_resources(wq);
 		if (rc < 0) {
 			mutex_unlock(&wq->wq_lock);
@@ -875,6 +899,8 @@ static ssize_t wq_mode_store(struct device *dev,
 	if (sysfs_streq(buf, "dedicated")) {
 		set_bit(WQ_FLAG_DEDICATED, &wq->flags);
 		wq->threshold = 0;
+	} else if (sysfs_streq(buf, "shared") && device_swq_supported(idxd)) {
+		clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
 	} else {
 		return -EINVAL;
 	}
@@ -973,6 +999,87 @@ static ssize_t wq_priority_store(struct device *dev,
 static struct device_attribute dev_attr_wq_priority =
 		__ATTR(priority, 0644, wq_priority_show, wq_priority_store);
 
+static ssize_t wq_block_on_fault_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+
+	return sprintf(buf, "%u\n",
+		       test_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags));
+}
+
+static ssize_t wq_block_on_fault_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_device *idxd = wq->idxd;
+	bool bof;
+	int rc;
+
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -ENXIO;
+
+	rc = kstrtobool(buf, &bof);
+	if (rc < 0)
+		return rc;
+
+	if (bof)
+		set_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
+	else
+		clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
+
+	return count;
+}
+
+static struct device_attribute dev_attr_wq_block_on_fault =
+		__ATTR(block_on_fault, 0644, wq_block_on_fault_show,
+		       wq_block_on_fault_store);
+
+static ssize_t wq_threshold_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+
+	return sprintf(buf, "%u\n", wq->threshold);
+}
+
+static ssize_t wq_threshold_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_device *idxd = wq->idxd;
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc < 0)
+		return -EINVAL;
+
+	if (val > wq->size || val <= 0)
+		return -EINVAL;
+
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -ENXIO;
+
+	if (test_bit(WQ_FLAG_DEDICATED, &wq->flags))
+		return -EINVAL;
+
+	wq->threshold = val;
+
+	return count;
+}
+
+static struct device_attribute dev_attr_wq_threshold =
+		__ATTR(threshold, 0644, wq_threshold_show, wq_threshold_store);
+
 static ssize_t wq_type_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -1044,6 +1151,13 @@ static ssize_t wq_name_store(struct device *dev,
 	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
 		return -EINVAL;
 
+	/*
+	 * This is temporarily placed here until we have SVM support for
+	 * dmaengine.
+	 */
+	if (wq->type == IDXD_WQT_KERNEL && device_pasid_enabled(wq->idxd))
+		return -EOPNOTSUPP;
+
 	memset(wq->name, 0, WQ_NAME_SIZE + 1);
 	strncpy(wq->name, buf, WQ_NAME_SIZE);
 	strreplace(wq->name, '\n', '\0');
@@ -1154,6 +1268,8 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_mode.attr,
 	&dev_attr_wq_size.attr,
 	&dev_attr_wq_priority.attr,
+	&dev_attr_wq_block_on_fault.attr,
+	&dev_attr_wq_threshold.attr,
 	&dev_attr_wq_type.attr,
 	&dev_attr_wq_name.attr,
 	&dev_attr_wq_cdev_minor.attr,
@@ -1305,6 +1421,16 @@ static ssize_t clients_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(clients);
 
+static ssize_t pasid_enabled_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct idxd_device *idxd =
+		container_of(dev, struct idxd_device, conf_dev);
+
+	return sprintf(buf, "%u\n", device_pasid_enabled(idxd));
+}
+static DEVICE_ATTR_RO(pasid_enabled);
+
 static ssize_t state_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
@@ -1424,6 +1550,7 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_gen_cap.attr,
 	&dev_attr_configurable.attr,
 	&dev_attr_clients.attr,
+	&dev_attr_pasid_enabled.attr,
 	&dev_attr_state.attr,
 	&dev_attr_errors.attr,
 	&dev_attr_max_tokens.attr,


