Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1119867A
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2020 23:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgC3V1V (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Mar 2020 17:27:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:3612 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgC3V1V (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 30 Mar 2020 17:27:21 -0400
IronPort-SDR: 0hwL4TRcm5RKc5NBRE21GpbJwFagr/SLgdYiJYPAaYC400/4XyN/nHwhZNPawf9lzZahy64WE7
 bekYYAq6v3aw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 14:27:20 -0700
IronPort-SDR: dEYIN1PQ26Ri94pvAMB/lBo2B1HvCD1otdPH6PI6/GoAK19UQANvj58tEoe3sz7qPi3zsgsOC4
 1TT834r+96zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; 
   d="scan'208";a="242161588"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2020 14:27:18 -0700
Subject: [PATCH 5/6] dmaengine: idxd: add shared workqueue support
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Date:   Mon, 30 Mar 2020 14:27:18 -0700
Message-ID: <158560363819.6059.10677408046138443526.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add shared workqueue support that includes the support of Shared Virtual
memory (SVM) or in similar terms On Demand Paging (ODP). The shared
workqueue uses the enqcmds command in kernel and will respond with retry if
the workqueue is full. Shared workqueue only works when there is PASID
support from the IOMMU.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/Kconfig       |    4 +
 drivers/dma/idxd/cdev.c   |   46 ++++++++++++++
 drivers/dma/idxd/device.c |  122 +++++++++++++++++++++++++++++++++++--
 drivers/dma/idxd/dma.c    |    2 -
 drivers/dma/idxd/idxd.h   |   13 +++-
 drivers/dma/idxd/init.c   |   92 +++++++++++++++++++++++-----
 drivers/dma/idxd/irq.c    |  147 +++++++++++++++++++++++++++++++++++++++++----
 drivers/dma/idxd/submit.c |  119 +++++++++++++++++++++++++++---------
 drivers/dma/idxd/sysfs.c  |  133 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 603 insertions(+), 75 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 5142da401db3..81b7848c1edb 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -286,6 +286,10 @@ config INTEL_IDXD
 	depends on PCI && X86_64
 	select DMA_ENGINE
 	select SBITMAP
+	select INTEL_IOMMU_SVM
+	select PCI_PRI
+	select PCI_PASID
+	select PCI_IOV
 	help
 	  Enable support for the Intel(R) data accelerators present
 	  in Intel Xeon CPU.
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index ff49847e37a8..27be9250606d 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -31,6 +31,7 @@ static struct idxd_cdev_context ictx[IDXD_TYPE_MAX] = {
 
 struct idxd_user_context {
 	struct idxd_wq *wq;
+	int pasid;
 	struct task_struct *task;
 	unsigned int flags;
 };
@@ -74,6 +75,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_device *idxd;
 	struct idxd_wq *wq;
 	struct device *dev;
+	int rc;
 
 	wq = inode_wq(inode);
 	idxd = wq->idxd;
@@ -90,8 +92,34 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 	ctx->wq = wq;
 	filp->private_data = ctx;
+
+	if (idxd->pasid_enabled) {
+		ctx->task = current;
+		get_task_struct(current);
+
+		rc = intel_svm_bind_mm(dev, &ctx->pasid, 0, NULL);
+		if (rc < 0) {
+			dev_err(dev, "pasid allocation failed: %d\n", rc);
+			goto failed;
+		}
+
+		if (wq_dedicated(wq)) {
+			rc = idxd_wq_set_pasid(wq, ctx->pasid);
+			if (rc < 0) {
+				dev_err(dev, "wq set pasid failed: %d\n", rc);
+				goto failed;
+			}
+		}
+	}
+
 	idxd_wq_get(wq);
 	return 0;
+
+failed:
+	if (ctx->task)
+		put_task_struct(current);
+	kfree(ctx);
+	return rc;
 }
 
 static int idxd_cdev_release(struct inode *node, struct file *filep)
@@ -100,10 +128,26 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 	struct idxd_wq *wq = ctx->wq;
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
+	int rc;
 
 	dev_dbg(dev, "%s called\n", __func__);
 	filep->private_data = NULL;
 
+	if (idxd->pasid_enabled) {
+		rc = idxd_device_drain_pasid(idxd, ctx->pasid);
+		if (rc < 0)
+			dev_err(dev, "Failed to drain pasid: %d\n",
+				ctx->pasid);
+		intel_svm_unbind_mm(&idxd->pdev->dev, ctx->pasid);
+		put_task_struct(ctx->task);
+
+		if (wq_dedicated(wq)) {
+			rc = idxd_wq_disable_pasid(wq);
+			if (rc < 0)
+				dev_err(dev, "wq disable pasid failed.\n");
+		}
+	}
+
 	kfree(ctx);
 	idxd_wq_put(wq);
 	return 0;
@@ -140,7 +184,7 @@ static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (rc < 0)
 		return rc;
 
-	vma->vm_flags |= VM_DONTCOPY;
+	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_WIPEONFORK;
 	pfn = (base + idxd_get_wq_portal_full_offset(wq->id,
 				IDXD_PORTAL_LIMITED)) >> PAGE_SHIFT;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index f6f49f0f6fae..9a785fef8879 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -298,10 +298,19 @@ int idxd_wq_map_portal(struct idxd_wq *wq)
 	start = pci_resource_start(pdev, IDXD_WQ_BAR);
 	start = start + wq->id * IDXD_PORTAL_SIZE;
 
-	wq->dportal = devm_ioremap(dev, start, IDXD_PORTAL_SIZE);
-	if (!wq->dportal)
-		return -ENOMEM;
-	dev_dbg(dev, "wq %d portal mapped at %p\n", wq->id, wq->dportal);
+	if (wq_dedicated(wq)) {
+		wq->portal = devm_ioremap(dev, start, IDXD_PORTAL_SIZE);
+		if (!wq->portal)
+			return -ENOMEM;
+		dev_dbg(dev, "dedicated wq %d portal mapped at %p\n",
+			wq->id, wq->portal);
+	} else {
+		wq->portal = devm_cmdmem_remap(dev, start, IDXD_PORTAL_SIZE);
+		if (!wq->portal)
+			return -ENOMEM;
+		dev_dbg(dev, "shared wq %d portal mapped at %p\n",
+			wq->id, wq->portal);
+	}
 
 	return 0;
 }
@@ -310,7 +319,63 @@ void idxd_wq_unmap_portal(struct idxd_wq *wq)
 {
 	struct device *dev = &wq->idxd->pdev->dev;
 
-	devm_iounmap(dev, wq->dportal);
+	if (wq_dedicated(wq))
+		devm_iounmap(dev, wq->portal);
+	else
+		devm_cmdmem_unmap(dev, wq->portal);
+}
+
+int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
+{
+	struct idxd_device *idxd = wq->idxd;
+	int rc;
+	union wqcfg wqcfg;
+	unsigned int offset;
+
+	lockdep_assert_held(&idxd->dev_lock);
+
+	rc = idxd_wq_disable(wq);
+	if (rc < 0)
+		return rc;
+
+	offset = idxd->wqcfg_offset + wq->id * sizeof(wqcfg);
+	offset += sizeof(u32) * 2;
+	wqcfg.bits[2] = ioread32(idxd->reg_base + offset);
+	wqcfg.pasid_en = 1;
+	wqcfg.pasid = pasid;
+	iowrite32(wqcfg.bits[2], idxd->reg_base + offset);
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
+
+	lockdep_assert_held(&idxd->dev_lock);
+
+	rc = idxd_wq_disable(wq);
+	if (rc < 0)
+		return rc;
+
+	offset = idxd->wqcfg_offset + wq->id * sizeof(wqcfg);
+	wqcfg.bits[2] = ioread32(idxd->reg_base + offset);
+	wqcfg.pasid_en = 0;
+	wqcfg.pasid = 0;
+	iowrite32(wqcfg.bits[2], idxd->reg_base + offset);
+
+	rc = idxd_wq_enable(wq);
+	if (rc < 0)
+		return rc;
+
+	return 0;
 }
 
 /* Device control bits */
@@ -454,6 +519,35 @@ int idxd_device_reset(struct idxd_device *idxd)
 	return rc;
 }
 
+int idxd_device_drain_pasid(struct idxd_device *idxd, int pasid)
+{
+	int rc;
+	struct device *dev = &idxd->pdev->dev;
+	u32 operand, status;
+
+	lockdep_assert_held(&idxd->dev_lock);
+
+	dev_dbg(dev, "Drain pasid %d\n", pasid);
+
+	operand = pasid;
+	dev_dbg(dev, "cmd: %u operand: %#x\n", IDXD_CMD_DRAIN_PASID, operand);
+	rc = idxd_cmd_send(idxd, IDXD_CMD_DRAIN_PASID, operand);
+	if (rc < 0)
+		return rc;
+
+	rc = idxd_cmd_wait(idxd, &status, IDXD_DRAIN_TIMEOUT);
+	if (rc < 0)
+		return rc;
+
+	if (status != IDXD_CMDSTS_SUCCESS) {
+		dev_dbg(dev, "pasid drain failed: %#x\n", status);
+		return -ENXIO;
+	}
+
+	dev_dbg(dev, "pasid %d drained\n", pasid);
+	return 0;
+}
+
 /* Device configuration bits */
 static void idxd_group_config_write(struct idxd_group *group)
 {
@@ -539,11 +633,21 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	wq->wqcfg.wq_thresh = wq->threshold;
 
 	/* byte 8-11 */
-	wq->wqcfg.priv = !!(wq->type == IDXD_WQT_KERNEL);
-	wq->wqcfg.mode = 1;
+	wq->wqcfg.priv = wq->type == IDXD_WQT_KERNEL ? 1 : 0;
+	if (wq_dedicated(wq))
+		wq->wqcfg.mode = 1;
+
+	if (idxd->pasid_enabled) {
+		wq->wqcfg.pasid_en = 1;
+		wq->wqcfg.pasid = idxd->pasid;
+	}
 
 	wq->wqcfg.priority = wq->priority;
 
+	if (idxd->hw.gen_cap.block_on_fault &&
+	    test_bit(WQ_FLAG_BOF, &wq->flags))
+		wq->wqcfg.bof = 1;
+
 	/* bytes 12-15 */
 	wq->wqcfg.max_xfer_shift = idxd->hw.gen_cap.max_xfer_shift;
 	wq->wqcfg.max_batch_shift = idxd->hw.gen_cap.max_batch_shift;
@@ -651,8 +755,8 @@ static int idxd_wqs_setup(struct idxd_device *idxd)
 		if (!wq->size)
 			continue;
 
-		if (!wq_dedicated(wq)) {
-			dev_warn(dev, "No shared workqueue support.\n");
+		if (!wq_dedicated(wq) && !idxd->pasid_enabled) {
+			dev_warn(dev, "No pasid support but shared queue.\n");
 			return -EINVAL;
 		}
 
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index c64c1429d160..9a4f78519e57 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -154,7 +154,7 @@ dma_cookie_t idxd_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	cookie = dma_cookie_assign(tx);
 
-	rc = idxd_submit_desc(wq, desc);
+	rc = idxd_submit_desc(wq, desc, IDXD_OP_BLOCK);
 	if (rc < 0) {
 		idxd_free_desc(wq, desc);
 		return rc;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index b8f8a363b4a7..2e96dec04eda 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -59,6 +59,7 @@ enum idxd_wq_state {
 
 enum idxd_wq_flag {
 	WQ_FLAG_DEDICATED = 0,
+	WQ_FLAG_BOF,
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
@@ -165,6 +167,9 @@ struct idxd_device {
 	struct idxd_wq *wqs;
 	struct idxd_engine *engines;
 
+	bool pasid_enabled;
+	int pasid;
+
 	int num_groups;
 
 	u32 msix_perm_offset;
@@ -282,6 +287,7 @@ int __idxd_device_reset(struct idxd_device *idxd);
 void idxd_device_cleanup(struct idxd_device *idxd);
 int idxd_device_config(struct idxd_device *idxd);
 void idxd_device_wqs_clear_state(struct idxd_device *idxd);
+int idxd_device_drain_pasid(struct idxd_device *idxd, int pasid);
 
 /* work queue control */
 int idxd_wq_alloc_resources(struct idxd_wq *wq);
@@ -290,9 +296,12 @@ int idxd_wq_enable(struct idxd_wq *wq);
 int idxd_wq_disable(struct idxd_wq *wq);
 int idxd_wq_map_portal(struct idxd_wq *wq);
 void idxd_wq_unmap_portal(struct idxd_wq *wq);
+int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid);
+int idxd_wq_disable_pasid(struct idxd_wq *wq);
 
 /* submission */
-int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
+int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc,
+		     enum idxd_op_type optype);
 struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype);
 void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc);
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 7778c05deb5d..f3afd47ec782 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -14,6 +14,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/intel-svm.h>
 #include <uapi/linux/idxd.h>
 #include <linux/dmaengine.h>
 #include "../dmaengine.h"
@@ -53,6 +54,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	struct idxd_irq_entry *irq_entry;
 	int i, msixcnt;
 	int rc = 0;
+	union msix_perm mperm;
 
 	msixcnt = pci_msix_vec_count(pdev);
 	if (msixcnt < 0) {
@@ -131,6 +133,14 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 
 	idxd_unmask_error_interrupts(idxd);
 
+	/* Setup MSIX permission table */
+	mperm.bits = 0;
+	mperm.pasid = idxd->pasid;
+	mperm.pasid_en = idxd->pasid_enabled;
+	for (i = 1; i < msixcnt; i++)
+		iowrite32(mperm.bits, idxd->reg_base +
+				idxd->msix_perm_offset + i * 8);
+
 	return 0;
 
  err_no_irq:
@@ -272,8 +282,7 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	}
 }
 
-static struct idxd_device *idxd_alloc(struct pci_dev *pdev,
-				      void __iomem * const *iomap)
+static struct idxd_device *idxd_alloc(struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct idxd_device *idxd;
@@ -283,12 +292,55 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev,
 		return NULL;
 
 	idxd->pdev = pdev;
-	idxd->reg_base = iomap[IDXD_MMIO_BAR];
 	spin_lock_init(&idxd->dev_lock);
 
 	return idxd;
 }
 
+static void idxd_enable_system_pasid(struct idxd_device *idxd)
+{
+	int rc, flags, pasid;
+	struct pci_dev *pdev = idxd->pdev;
+
+	/*
+	 * If CPU does not have enqcmds support then there's no point in
+	 * enabling pasid.
+	 */
+	if (!pdev->cmdmem)
+		return;
+
+	flags = SVM_FLAG_SUPERVISOR_MODE;
+
+	rc = intel_svm_bind_mm(&idxd->pdev->dev, &pasid, flags, NULL);
+	if (rc < 0) {
+		dev_warn(&idxd->pdev->dev,
+			 "system pasid allocation failed: %d\n", rc);
+		idxd->pasid_enabled = false;
+		return;
+	}
+
+	idxd->pasid_enabled = true;
+	idxd->pasid = pasid;
+	dev_dbg(&idxd->pdev->dev, "system pasid: %d\n", pasid);
+}
+
+static int idxd_disable_system_pasid(struct idxd_device *idxd)
+{
+	int rc;
+
+	if (idxd->pasid_enabled) {
+		rc = intel_svm_unbind_mm(&idxd->pdev->dev, idxd->pasid);
+		if (rc < 0) {
+			dev_warn(&idxd->pdev->dev,
+				 "system pasid unbind failed: %d\n",
+					rc);
+			return rc;
+		}
+	}
+	idxd->pasid_enabled = false;
+	return 0;
+}
+
 static int idxd_probe(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
@@ -301,6 +353,7 @@ static int idxd_probe(struct idxd_device *idxd)
 		return rc;
 	dev_dbg(dev, "IDXD reset complete\n");
 
+	idxd_enable_system_pasid(idxd);
 	idxd_read_caps(idxd);
 	idxd_read_table_offsets(idxd);
 
@@ -331,29 +384,31 @@ static int idxd_probe(struct idxd_device *idxd)
 	idxd_mask_error_interrupts(idxd);
 	idxd_mask_msix_vectors(idxd);
  err_setup:
+	idxd_disable_system_pasid(idxd);
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
+
+	if (!pdev->cmdmem)
+		dev_dbg(dev, "Device does not have cmdmem support\n");
 
-	iomap = pcim_iomap_table(pdev);
-	if (!iomap)
+	dev_dbg(dev, "Mapping BARs\n");
+	idxd->reg_base = pcim_iomap(pdev, IDXD_MMIO_BAR, 0);
+	if (!idxd->reg_base)
 		return -ENOMEM;
 
 	dev_dbg(dev, "Set DMA masks\n");
@@ -369,11 +424,6 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	dev_dbg(dev, "Alloc IDXD context\n");
-	idxd = idxd_alloc(pdev, iomap);
-	if (!idxd)
-		return -ENOMEM;
-
 	idxd_set_type(idxd);
 
 	dev_dbg(dev, "Set PCI master\n");
@@ -463,6 +513,7 @@ static void idxd_remove(struct pci_dev *pdev)
 	idxd_cleanup_sysfs(idxd);
 	idxd_shutdown(pdev);
 	idxd_wqs_free_lock(idxd);
+	idxd_disable_system_pasid(idxd);
 	mutex_lock(&idxd_idr_lock);
 	idr_remove(&idxd_idrs[idxd->type], idxd->id);
 	mutex_unlock(&idxd_idr_lock);
@@ -481,7 +532,7 @@ static int __init idxd_init_module(void)
 	int err, i;
 
 	/*
-	 * If the CPU does not support write512, there's no point in
+	 * If the CPU does not support MOVDIR64B or ENQCMDS, there's no point in
 	 * enumerating the device. We can not utilize it.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_MOVDIR64B)) {
@@ -489,6 +540,11 @@ static int __init idxd_init_module(void)
 		return -ENODEV;
 	}
 
+	if (!boot_cpu_has(X86_FEATURE_ENQCMD)) {
+		pr_warn("idxd module failed to load without ENQCMD.\n");
+		return -ENODEV;
+	}
+
 	pr_info("%s: Intel(R) Accelerator Devices Driver %s\n",
 		DRV_NAME, IDXD_DRIVER_VERSION);
 
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index d6fcd2e60103..37ad927d6944 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -11,6 +11,38 @@
 #include "idxd.h"
 #include "registers.h"
 
+enum irq_work_type {
+	IRQ_WORK_NORMAL = 0,
+	IRQ_WORK_PROCESS_FAULT,
+};
+
+static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
+				 enum irq_work_type wtype,
+				 int *processed, u64 data);
+static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
+				     enum irq_work_type wtype,
+				     int *processed, u64 data);
+
+static void idxd_mask_and_sync_wq_msix_vectors(struct idxd_device *idxd)
+{
+	int irqcnt = idxd->num_wq_irqs + 1;
+	int i;
+
+	for (i = 1; i < irqcnt; i++) {
+		idxd_mask_msix_vector(idxd, i);
+		synchronize_irq(idxd->msix_entries[i].vector);
+	}
+}
+
+static void idxd_unmask_wq_msix_vectors(struct idxd_device *idxd)
+{
+	int irqcnt = idxd->num_wq_irqs + 1;
+	int i;
+
+	for (i = 1; i < irqcnt; i++)
+		idxd_unmask_msix_vector(idxd, i);
+}
+
 void idxd_device_wqs_clear_state(struct idxd_device *idxd)
 {
 	int i;
@@ -62,6 +94,45 @@ static int idxd_restart(struct idxd_device *idxd)
 	return rc;
 }
 
+static void idxd_device_complete_fault_desc(struct idxd_device *idxd,
+					    u64 fault_addr)
+{
+	unsigned long flags;
+	struct idxd_irq_entry *ie;
+	int i, found = 0;
+	int irqcnt = idxd->num_wq_irqs + 1;
+
+	idxd_mask_and_sync_wq_msix_vectors(idxd);
+
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+
+	/*
+	 * At this point, all MSIX vectors used by workqueues should be masked
+	 * and all threaded irq handlers should be quieted. We should be able
+	 * to touch the pending descriptor lists.
+	 */
+
+	for (i = 1; i < irqcnt; i++) {
+		ie = &idxd->irq_entries[i];
+		irq_process_work_list(ie, IRQ_WORK_PROCESS_FAULT,
+				      &found, fault_addr);
+		if (found) {
+			spin_unlock_irqrestore(&idxd->dev_lock, flags);
+			return;
+		}
+
+		irq_process_pending_llist(ie, IRQ_WORK_PROCESS_FAULT,
+					  &found, fault_addr);
+		if (found) {
+			spin_unlock_irqrestore(&idxd->dev_lock, flags);
+			return;
+		}
+	}
+
+	idxd_unmask_wq_msix_vectors(idxd);
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+}
+
 irqreturn_t idxd_irq_handler(int vec, void *data)
 {
 	struct idxd_irq_entry *irq_entry = data;
@@ -136,13 +207,24 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 
 	val ^= cause;
 	if (val)
-		dev_warn_once(dev, "Unexpected interrupt cause bits set: %#x\n",
+		dev_warn_once(dev,
+			      "Unexpected interrupt cause bits set: %#x\n",
 			      val);
 
 	iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
 	if (!err)
 		return IRQ_HANDLED;
 
+	/*
+	 * This case should rarely happen and typically is due to software
+	 * programming error by the driver.
+	 */
+	if (idxd->sw_err.valid &&
+	    idxd->sw_err.desc_valid &&
+	    idxd->sw_err.fault_addr)
+		idxd_device_complete_fault_desc(idxd,
+						idxd->sw_err.fault_addr);
+
 	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
 	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
 		spin_lock_bh(&idxd->dev_lock);
@@ -166,24 +248,56 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	return IRQ_HANDLED;
 }
 
+static bool process_fault(struct idxd_desc *desc, u64 fault_addr)
+{
+	if ((u64)desc->hw == fault_addr ||
+	    (u64)desc->completion == fault_addr) {
+		idxd_dma_complete_txd(desc, IDXD_COMPLETE_DEV_FAIL);
+		return true;
+	}
+
+	return false;
+}
+
+static bool complete_desc(struct idxd_desc *desc)
+{
+	if (desc->completion->status) {
+		idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL);
+		return true;
+	}
+
+	return false;
+}
+
 static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
-				     int *processed)
+				     enum irq_work_type wtype,
+				     int *processed, u64 data)
 {
 	struct idxd_desc *desc, *t;
 	struct llist_node *head;
 	int queued = 0;
+	bool completed = false;
 
 	head = llist_del_all(&irq_entry->pending_llist);
-	if (!head)
+	if (!head) {
+		*processed = 0;
 		return 0;
+	}
 
 	llist_for_each_entry_safe(desc, t, head, llnode) {
-		if (desc->completion->status) {
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL);
+		if (wtype == IRQ_WORK_NORMAL)
+			completed = complete_desc(desc);
+		else if (wtype == IRQ_WORK_PROCESS_FAULT)
+			completed = process_fault(desc, data);
+
+		if (completed) {
 			idxd_free_desc(desc->wq, desc);
 			(*processed)++;
+			if (wtype == IRQ_WORK_PROCESS_FAULT)
+				break;
 		} else {
-			list_add_tail(&desc->list, &irq_entry->work_list);
+			list_add_tail(&desc->list,
+				      &irq_entry->work_list);
 			queued++;
 		}
 	}
@@ -192,10 +306,12 @@ static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
 }
 
 static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
-				 int *processed)
+				 enum irq_work_type wtype,
+				 int *processed, u64 data)
 {
 	struct list_head *node, *next;
 	int queued = 0;
+	bool completed = false;
 
 	if (list_empty(&irq_entry->work_list))
 		return 0;
@@ -204,12 +320,17 @@ static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
 		struct idxd_desc *desc =
 			container_of(node, struct idxd_desc, list);
 
-		if (desc->completion->status) {
+		if (wtype == IRQ_WORK_NORMAL)
+			completed = complete_desc(desc);
+		else if (wtype == IRQ_WORK_PROCESS_FAULT)
+			completed = process_fault(desc, data);
+
+		if (completed) {
 			list_del(&desc->list);
-			/* process and callback */
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL);
 			idxd_free_desc(desc->wq, desc);
 			(*processed)++;
+			if (wtype == IRQ_WORK_PROCESS_FAULT)
+				break;
 		} else {
 			queued++;
 		}
@@ -243,13 +364,15 @@ irqreturn_t idxd_wq_thread(int irq, void *data)
 	 * 5. Repeat until no more descriptors.
 	 */
 	do {
-		rc = irq_process_work_list(irq_entry, &processed);
+		rc = irq_process_work_list(irq_entry, IRQ_WORK_NORMAL,
+					   &processed, 0);
 		if (rc != 0) {
 			retry++;
 			continue;
 		}
 
-		rc = irq_process_pending_llist(irq_entry, &processed);
+		rc = irq_process_pending_llist(irq_entry, IRQ_WORK_NORMAL,
+					       &processed, 0);
 	} while (rc != 0 && retry != 10);
 
 	idxd_unmask_msix_vector(irq_entry->idxd, irq_entry->id);
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 45a0c5869a0a..741bc3aa7267 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -8,41 +8,44 @@
 #include "idxd.h"
 #include "registers.h"
 
-struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype)
+struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq,
+				  enum idxd_op_type optype)
 {
+	struct idxd_device *idxd = wq->idxd;
 	struct idxd_desc *desc;
 	int idx;
-	struct idxd_device *idxd = wq->idxd;
 
 	if (idxd->state != IDXD_DEV_ENABLED)
 		return ERR_PTR(-EIO);
 
-	if (optype == IDXD_OP_BLOCK)
-		percpu_down_read(&wq->submit_lock);
-	else if (!percpu_down_read_trylock(&wq->submit_lock))
-		return ERR_PTR(-EBUSY);
+	if (wq_dedicated(wq)) {
+		if (optype == IDXD_OP_BLOCK)
+			percpu_down_read(&wq->submit_lock);
+		else if (!percpu_down_read_trylock(&wq->submit_lock))
+			return ERR_PTR(-EBUSY);
+
+		if (!atomic_add_unless(&wq->dq_count, 1, wq->size)) {
+			int rc;
 
-	if (!atomic_add_unless(&wq->dq_count, 1, wq->size)) {
-		int rc;
+			if (optype == IDXD_OP_NONBLOCK) {
+				percpu_up_read(&wq->submit_lock);
+				return ERR_PTR(-EAGAIN);
+			}
 
-		if (optype == IDXD_OP_NONBLOCK) {
 			percpu_up_read(&wq->submit_lock);
-			return ERR_PTR(-EAGAIN);
+			percpu_down_write(&wq->submit_lock);
+			rc = wait_event_interruptible(wq->submit_waitq,
+					atomic_add_unless(&wq->dq_count, 1,
+							  wq->size) ||
+					idxd->state != IDXD_DEV_ENABLED);
+			percpu_up_write(&wq->submit_lock);
+			if (rc < 0)
+				return ERR_PTR(-EINTR);
+			if (idxd->state != IDXD_DEV_ENABLED)
+				return ERR_PTR(-EIO);
+		} else {
+			percpu_up_read(&wq->submit_lock);
 		}
-
-		percpu_up_read(&wq->submit_lock);
-		percpu_down_write(&wq->submit_lock);
-		rc = wait_event_interruptible(wq->submit_waitq,
-					      atomic_add_unless(&wq->dq_count,
-								1, wq->size) ||
-					       idxd->state != IDXD_DEV_ENABLED);
-		percpu_up_write(&wq->submit_lock);
-		if (rc < 0)
-			return ERR_PTR(-EINTR);
-		if (idxd->state != IDXD_DEV_ENABLED)
-			return ERR_PTR(-EIO);
-	} else {
-		percpu_up_read(&wq->submit_lock);
 	}
 
 	idx = sbitmap_get(&wq->sbmap, 0, false);
@@ -59,29 +62,81 @@ struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype)
 
 void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 {
-	atomic_dec(&wq->dq_count);
+	if (wq_dedicated(wq))
+		atomic_dec(&wq->dq_count);
 
 	sbitmap_clear_bit(&wq->sbmap, desc->id);
 	wake_up(&wq->submit_waitq);
 }
 
-int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
+static int idxd_iosubmit_cmd_sync(struct idxd_wq *wq, void __iomem *portal,
+				  struct dsa_hw_desc *hw,
+				  enum idxd_op_type optype)
 {
 	struct idxd_device *idxd = wq->idxd;
-	int vec = desc->hw->int_handle;
-	void __iomem *portal;
+	int rc;
 
-	if (idxd->state != IDXD_DEV_ENABLED)
-		return -EIO;
+	if (optype == IDXD_OP_BLOCK)
+		percpu_down_read(&wq->submit_lock);
+	else if (!percpu_down_read_trylock(&wq->submit_lock))
+		return -EBUSY;
 
-	portal = wq->dportal + idxd_get_wq_portal_offset(IDXD_PORTAL_UNLIMITED);
 	/*
 	 * The wmb() flushes writes to coherent DMA data before possibly
 	 * triggering a DMA read. The wmb() is necessary even on UP because
 	 * the recipient is a device.
 	 */
 	wmb();
-	iosubmit_cmds512(portal, desc->hw, 1);
+	rc = iosubmit_cmds512_sync(portal, hw, 1);
+	if (rc) {
+		if (optype == IDXD_OP_NONBLOCK)
+			return -EBUSY;
+		if (idxd->state != IDXD_DEV_ENABLED)
+			return -EIO;
+		percpu_up_read(&wq->submit_lock);
+		percpu_down_write(&wq->submit_lock);
+		rc = wait_event_interruptible(wq->submit_waitq,
+					      !iosubmit_cmds512_sync(portal,
+								     hw, 1) ||
+					      idxd->state != IDXD_DEV_ENABLED);
+		percpu_up_write(&wq->submit_lock);
+		if (rc < 0)
+			return -EINTR;
+		if (idxd->state != IDXD_DEV_ENABLED)
+			return -EIO;
+	} else {
+		percpu_up_read(&wq->submit_lock);
+	}
+
+	return 0;
+}
+
+int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc,
+		     enum idxd_op_type optype)
+{
+	struct idxd_device *idxd = wq->idxd;
+	int vec = desc->hw->int_handle;
+	int rc;
+	void __iomem *portal;
+
+	if (idxd->state != IDXD_DEV_ENABLED)
+		return -EIO;
+
+	portal = wq->portal +
+		 idxd_get_wq_portal_offset(IDXD_PORTAL_UNLIMITED);
+	if (wq_dedicated(wq)) {
+		/*
+		 * The wmb() flushes writes to coherent DMA data before
+		 * possibly triggering a DMA read. The wmb() is necessary
+		 * even on UP because the recipient is a device.
+		 */
+		wmb();
+		iosubmit_cmds512(portal, desc->hw, 1);
+	} else {
+		rc = idxd_iosubmit_cmd_sync(wq, portal, desc->hw, optype);
+		if (rc < 0)
+			return rc;
+	}
 
 	/*
 	 * Pending the descriptor to the lockless list for the irq_entry
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 3999827970ab..dc38172be42e 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -179,6 +179,30 @@ static int idxd_config_bus_probe(struct device *dev)
 			return -EINVAL;
 		}
 
+		/* Shared WQ checks */
+		if (!wq_dedicated(wq)) {
+			if (!idxd->pasid_enabled) {
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
@@ -880,6 +904,8 @@ static ssize_t wq_mode_store(struct device *dev,
 	if (sysfs_streq(buf, "dedicated")) {
 		set_bit(WQ_FLAG_DEDICATED, &wq->flags);
 		wq->threshold = 0;
+	} else if (sysfs_streq(buf, "shared") && idxd->pasid_enabled) {
+		clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
 	} else {
 		return -EINVAL;
 	}
@@ -978,6 +1004,91 @@ static ssize_t wq_priority_store(struct device *dev,
 static struct device_attribute dev_attr_wq_priority =
 		__ATTR(priority, 0644, wq_priority_show, wq_priority_store);
 
+static ssize_t wq_block_on_fault_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+
+	return sprintf(buf, "%u\n", test_bit(WQ_FLAG_BOF, &wq->flags));
+}
+
+static ssize_t wq_block_on_fault_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
+	struct idxd_device *idxd = wq->idxd;
+	unsigned long val;
+	int rc;
+
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	rc = kstrtoul(buf, 10, &val);
+	if (rc < 0)
+		return -EINVAL;
+
+	if (val == 1)
+		set_bit(WQ_FLAG_BOF, &wq->flags);
+	else if (val == 0)
+		clear_bit(WQ_FLAG_BOF, &wq->flags);
+	else
+		return -EINVAL;
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
+	unsigned long val;
+	int rc;
+
+	rc = kstrtoul(buf, 10, &val);
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
+		return -EPERM;
+
+	if (test_bit(WQ_FLAG_DEDICATED, &wq->flags))
+		return -EINVAL;
+
+	if (val > wq->size)
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
@@ -1049,6 +1160,15 @@ static ssize_t wq_name_store(struct device *dev,
 	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
 		return -EINVAL;
 
+	/*
+	 * This is temporarily placed here until we implement the direct
+	 * submission API through dmaengine with SVM support.
+	 */
+	if (sysfs_streq(buf, "dmaengine") &&
+	    wq->type == IDXD_WQT_KERNEL &&
+	    wq->idxd->pasid_enabled)
+		return -EOPNOTSUPP;
+
 	memset(wq->name, 0, WQ_NAME_SIZE + 1);
 	strncpy(wq->name, buf, WQ_NAME_SIZE);
 	strreplace(wq->name, '\n', '\0');
@@ -1076,6 +1196,8 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_mode.attr,
 	&dev_attr_wq_size.attr,
 	&dev_attr_wq_priority.attr,
+	&dev_attr_wq_block_on_fault.attr,
+	&dev_attr_wq_threshold.attr,
 	&dev_attr_wq_type.attr,
 	&dev_attr_wq_name.attr,
 	&dev_attr_wq_cdev_minor.attr,
@@ -1215,6 +1337,16 @@ static ssize_t clients_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(clients);
 
+static ssize_t pasid_enabled_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct idxd_device *idxd =
+		container_of(dev, struct idxd_device, conf_dev);
+
+	return sprintf(buf, "%u\n", idxd->pasid_enabled);
+}
+static DEVICE_ATTR_RO(pasid_enabled);
+
 static ssize_t state_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
@@ -1324,6 +1456,7 @@ static struct attribute *idxd_device_attributes[] = {
 	&dev_attr_gen_cap.attr,
 	&dev_attr_configurable.attr,
 	&dev_attr_clients.attr,
+	&dev_attr_pasid_enabled.attr,
 	&dev_attr_state.attr,
 	&dev_attr_errors.attr,
 	&dev_attr_max_tokens.attr,

