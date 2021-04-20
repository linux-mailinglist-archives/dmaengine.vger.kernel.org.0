Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B294365FAD
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 20:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhDTSrI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 14:47:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:12764 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233092AbhDTSrI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 14:47:08 -0400
IronPort-SDR: Kq9xYcR52n/ssdRr1+c657EAVUpeai2RLI/0cgcaUKv2fa21swgCnd3Qt+RyJyyq9pOPGlr/8l
 LxNQI/rJjshw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="175053497"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="175053497"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:35 -0700
IronPort-SDR: 953I88Oc75+0cYUW1ydo/fMyXm+nbsyOyLDqTGzQYjHvJ8BIixQb10+SmkFMriiQwp7foAAMs0
 271/jRBNvF6g==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="454975818"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 11:46:34 -0700
Subject: [PATCH 3/6] dmaengine: idxd: add interrupt handle request and release
 support
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 20 Apr 2021 11:46:34 -0700
Message-ID: <161894439422.3202472.17579543737810265471.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
References: <161894424826.3202472.897357148671784604.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DSA spec states that when Request Interrupt Handle and Release Interrupt
Handle command bits are set in the CMDCAP register, these device commands
must be supported by the driver.

The interrupt handle is programmed in a descriptor. When Request Interrupt
Handle is not supported, the interrupt handle is the index of the desired
entry in the MSI-X table. When the command is supported, driver must use
the command to obtain a handle to be programmed in the submitted
descriptor.

A requested handle may be revoked. After the handle is revoked, any use of
the handle will result in Invalid Interrupt Handle error.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c    |   71 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h      |   13 ++++++++
 drivers/dma/idxd/init.c      |   56 +++++++++++++++++++++++++++++++++
 drivers/dma/idxd/registers.h |    9 +++++
 drivers/dma/idxd/submit.c    |   35 +++++++++++++++++----
 drivers/dma/idxd/sysfs.c     |    1 +
 6 files changed, 176 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 3ddb1c731080..54d5afec81cf 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -598,6 +598,77 @@ void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid)
 	dev_dbg(dev, "pasid %d drained\n", pasid);
 }
 
+int idxd_device_request_int_handle(struct idxd_device *idxd, int idx, int *handle,
+				   enum idxd_interrupt_type irq_type)
+{
+	struct device *dev = &idxd->pdev->dev;
+	u32 operand, status;
+
+	if (!(idxd->hw.cmd_cap & BIT(IDXD_CMD_REQUEST_INT_HANDLE)))
+		return -EOPNOTSUPP;
+
+	dev_dbg(dev, "get int handle, idx %d\n", idx);
+
+	operand = idx & GENMASK(15, 0);
+	if (irq_type == IDXD_IRQ_IMS)
+		operand |= CMD_INT_HANDLE_IMS;
+
+	dev_dbg(dev, "cmd: %u operand: %#x\n", IDXD_CMD_REQUEST_INT_HANDLE, operand);
+
+	idxd_cmd_exec(idxd, IDXD_CMD_REQUEST_INT_HANDLE, operand, &status);
+
+	if ((status & IDXD_CMDSTS_ERR_MASK) != IDXD_CMDSTS_SUCCESS) {
+		dev_dbg(dev, "request int handle failed: %#x\n", status);
+		return -ENXIO;
+	}
+
+	*handle = (status >> IDXD_CMDSTS_RES_SHIFT) & GENMASK(15, 0);
+
+	dev_dbg(dev, "int handle acquired: %u\n", *handle);
+	return 0;
+}
+
+int idxd_device_release_int_handle(struct idxd_device *idxd, int handle,
+				   enum idxd_interrupt_type irq_type)
+{
+	struct device *dev = &idxd->pdev->dev;
+	u32 operand, status;
+	union idxd_command_reg cmd;
+	unsigned long flags;
+
+	if (!(idxd->hw.cmd_cap & BIT(IDXD_CMD_RELEASE_INT_HANDLE)))
+		return -EOPNOTSUPP;
+
+	dev_dbg(dev, "release int handle, handle %d\n", handle);
+
+	memset(&cmd, 0, sizeof(cmd));
+	operand = handle & GENMASK(15, 0);
+
+	if (irq_type == IDXD_IRQ_IMS)
+		operand |= CMD_INT_HANDLE_IMS;
+
+	cmd.cmd = IDXD_CMD_RELEASE_INT_HANDLE;
+	cmd.operand = operand;
+
+	dev_dbg(dev, "cmd: %u operand: %#x\n", IDXD_CMD_RELEASE_INT_HANDLE, operand);
+
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
+
+	while (ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET) & IDXD_CMDSTS_ACTIVE)
+		cpu_relax();
+	status = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+
+	if ((status & IDXD_CMDSTS_ERR_MASK) != IDXD_CMDSTS_SUCCESS) {
+		dev_dbg(dev, "release int handle failed: %#x\n", status);
+		return -ENXIO;
+	}
+
+	dev_dbg(dev, "int handle released.\n");
+	return 0;
+}
+
 /* Device configuration bits */
 void idxd_msix_perm_setup(struct idxd_device *idxd)
 {
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 940a2e1ddf12..c1d4a1976206 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -160,6 +160,7 @@ struct idxd_hw {
 	union group_cap_reg group_cap;
 	union engine_cap_reg engine_cap;
 	struct opcap opcap;
+	u32 cmd_cap;
 };
 
 enum idxd_device_state {
@@ -237,6 +238,8 @@ struct idxd_device {
 	struct idxd_dma_dev *idxd_dma;
 	struct workqueue_struct *wq;
 	struct work_struct work;
+
+	int *int_handles;
 };
 
 /* IDXD software descriptor */
@@ -256,6 +259,7 @@ struct idxd_desc {
 	struct list_head list;
 	int id;
 	int cpu;
+	unsigned int vector;
 	struct idxd_wq *wq;
 };
 
@@ -330,6 +334,11 @@ enum idxd_portal_prot {
 	IDXD_PORTAL_LIMITED,
 };
 
+enum idxd_interrupt_type {
+	IDXD_IRQ_MSIX = 0,
+	IDXD_IRQ_IMS,
+};
+
 static inline int idxd_get_wq_portal_offset(enum idxd_portal_prot prot)
 {
 	return prot * 0x1000;
@@ -385,6 +394,10 @@ int idxd_device_config(struct idxd_device *idxd);
 void idxd_device_wqs_clear_state(struct idxd_device *idxd);
 void idxd_device_drain_pasid(struct idxd_device *idxd, int pasid);
 int idxd_device_load_config(struct idxd_device *idxd);
+int idxd_device_request_int_handle(struct idxd_device *idxd, int idx, int *handle,
+				   enum idxd_interrupt_type irq_type);
+int idxd_device_release_int_handle(struct idxd_device *idxd, int handle,
+				   enum idxd_interrupt_type irq_type);
 
 /* work queue control */
 int idxd_wq_alloc_resources(struct idxd_wq *wq);
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index a07e6d8eec00..ef58750c24cc 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -125,7 +125,25 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 			dev_err(dev, "Failed to allocate irq %d.\n", irq_entry->vector);
 			goto err_wq_irqs;
 		}
+
 		dev_dbg(dev, "Allocated idxd-msix %d for vector %d\n", i, irq_entry->vector);
+		if (idxd->hw.cmd_cap & BIT(IDXD_CMD_REQUEST_INT_HANDLE)) {
+			/*
+			 * The MSIX vector enumeration starts at 1 with vector 0 being the
+			 * misc interrupt that handles non I/O completion events. The
+			 * interrupt handles are for IMS enumeration on guest. The misc
+			 * interrupt vector does not require a handle and therefore we start
+			 * the int_handles at index 0. Since 'i' starts at 1, the first
+			 * int_handles index will be 0.
+			 */
+			rc = idxd_device_request_int_handle(idxd, i, &idxd->int_handles[i - 1],
+							    IDXD_IRQ_MSIX);
+			if (rc < 0) {
+				free_irq(irq_entry->vector, irq_entry);
+				goto err_wq_irqs;
+			}
+			dev_dbg(dev, "int handle requested: %u\n", idxd->int_handles[i - 1]);
+		}
 	}
 
 	idxd_unmask_error_interrupts(idxd);
@@ -136,6 +154,9 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
 	while (--i >= 0) {
 		irq_entry = &idxd->irq_entries[i];
 		free_irq(irq_entry->vector, irq_entry);
+		if (i != 0)
+			idxd_device_release_int_handle(idxd,
+						       idxd->int_handles[i], IDXD_IRQ_MSIX);
 	}
  err_misc_irq:
 	/* Disable error interrupt generation */
@@ -288,9 +309,15 @@ static int idxd_setup_internals(struct idxd_device *idxd)
 
 	init_waitqueue_head(&idxd->cmd_waitq);
 
+	if (idxd->hw.cmd_cap & BIT(IDXD_CMD_REQUEST_INT_HANDLE)) {
+		idxd->int_handles = devm_kcalloc(dev, idxd->max_wqs, sizeof(int), GFP_KERNEL);
+		if (!idxd->int_handles)
+			return -ENOMEM;
+	}
+
 	rc = idxd_setup_wqs(idxd);
 	if (rc < 0)
-		return rc;
+		goto err_wqs;
 
 	rc = idxd_setup_engines(idxd);
 	if (rc < 0)
@@ -317,6 +344,8 @@ static int idxd_setup_internals(struct idxd_device *idxd)
  err_engine:
 	for (i = 0; i < idxd->max_wqs; i++)
 		put_device(&idxd->wqs[i]->conf_dev);
+ err_wqs:
+	kfree(idxd->int_handles);
 	return rc;
 }
 
@@ -345,6 +374,12 @@ static void idxd_read_caps(struct idxd_device *idxd)
 	/* reading generic capabilities */
 	idxd->hw.gen_cap.bits = ioread64(idxd->reg_base + IDXD_GENCAP_OFFSET);
 	dev_dbg(dev, "gen_cap: %#llx\n", idxd->hw.gen_cap.bits);
+
+	if (idxd->hw.gen_cap.cmd_cap) {
+		idxd->hw.cmd_cap = ioread32(idxd->reg_base + IDXD_CMDCAP_OFFSET);
+		dev_dbg(dev, "cmd_cap: %#x\n", idxd->hw.cmd_cap);
+	}
+
 	idxd->max_xfer_bytes = 1ULL << idxd->hw.gen_cap.max_xfer_shift;
 	dev_dbg(dev, "max xfer size: %llu bytes\n", idxd->max_xfer_bytes);
 	idxd->max_batch_size = 1U << idxd->hw.gen_cap.max_batch_shift;
@@ -604,6 +639,24 @@ static void idxd_flush_work_list(struct idxd_irq_entry *ie)
 	}
 }
 
+static void idxd_release_int_handles(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	int i, rc;
+
+	for (i = 0; i < idxd->num_wq_irqs; i++) {
+		if (idxd->hw.cmd_cap & BIT(IDXD_CMD_RELEASE_INT_HANDLE)) {
+			rc = idxd_device_release_int_handle(idxd, idxd->int_handles[i],
+							    IDXD_IRQ_MSIX);
+			if (rc < 0)
+				dev_warn(dev, "irq handle %d release failed\n",
+					 idxd->int_handles[i]);
+			else
+				dev_dbg(dev, "int handle requested: %u\n", idxd->int_handles[i]);
+		}
+	}
+}
+
 static void idxd_shutdown(struct pci_dev *pdev)
 {
 	struct idxd_device *idxd = pci_get_drvdata(pdev);
@@ -630,6 +683,7 @@ static void idxd_shutdown(struct pci_dev *pdev)
 	}
 
 	idxd_msix_perm_clear(idxd);
+	idxd_release_int_handles(idxd);
 	pci_free_irq_vectors(pdev);
 	pci_iounmap(pdev, idxd->reg_base);
 	pci_disable_device(pdev);
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 751ecb4f9f81..5cbf368c7367 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -24,8 +24,8 @@ union gen_cap_reg {
 		u64 overlap_copy:1;
 		u64 cache_control_mem:1;
 		u64 cache_control_cache:1;
+		u64 cmd_cap:1;
 		u64 rsvd:3;
-		u64 int_handle_req:1;
 		u64 dest_readback:1;
 		u64 drain_readback:1;
 		u64 rsvd2:6;
@@ -180,8 +180,11 @@ enum idxd_cmd {
 	IDXD_CMD_DRAIN_PASID,
 	IDXD_CMD_ABORT_PASID,
 	IDXD_CMD_REQUEST_INT_HANDLE,
+	IDXD_CMD_RELEASE_INT_HANDLE,
 };
 
+#define CMD_INT_HANDLE_IMS		0x10000
+
 #define IDXD_CMDSTS_OFFSET		0xa8
 union cmdsts_reg {
 	struct {
@@ -193,6 +196,8 @@ union cmdsts_reg {
 	u32 bits;
 } __packed;
 #define IDXD_CMDSTS_ACTIVE		0x80000000
+#define IDXD_CMDSTS_ERR_MASK		0xff
+#define IDXD_CMDSTS_RES_SHIFT		8
 
 enum idxd_cmdsts_err {
 	IDXD_CMDSTS_SUCCESS = 0,
@@ -228,6 +233,8 @@ enum idxd_cmdsts_err {
 	IDXD_CMDSTS_ERR_NO_HANDLE,
 };
 
+#define IDXD_CMDCAP_OFFSET		0xb0
+
 #define IDXD_SWERR_OFFSET		0xc0
 #define IDXD_SWERR_VALID		0x00000001
 #define IDXD_SWERR_OVERFLOW		0x00000002
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 02f9f51e29a6..19afb62abaff 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -22,11 +22,23 @@ static struct idxd_desc *__get_desc(struct idxd_wq *wq, int idx, int cpu)
 		desc->hw->pasid = idxd->pasid;
 
 	/*
-	 * Descriptor completion vectors are 1-8 for MSIX. We will round
-	 * robin through the 8 vectors.
+	 * Descriptor completion vectors are 1...N for MSIX. We will round
+	 * robin through the N vectors.
 	 */
 	wq->vec_ptr = (wq->vec_ptr % idxd->num_wq_irqs) + 1;
-	desc->hw->int_handle = wq->vec_ptr;
+	if (!idxd->int_handles) {
+		desc->hw->int_handle = wq->vec_ptr;
+	} else {
+		desc->vector = wq->vec_ptr;
+		/*
+		 * int_handles are only for descriptor completion. However for device
+		 * MSIX enumeration, vec 0 is used for misc interrupts. Therefore even
+		 * though we are rotating through 1...N for descriptor interrupts, we
+		 * need to acqurie the int_handles from 0..N-1.
+		 */
+		desc->hw->int_handle = idxd->int_handles[desc->vector - 1];
+	}
+
 	return desc;
 }
 
@@ -79,7 +91,6 @@ void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 {
 	struct idxd_device *idxd = wq->idxd;
-	int vec = desc->hw->int_handle;
 	void __iomem *portal;
 	int rc;
 
@@ -117,9 +128,19 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	 * Pending the descriptor to the lockless list for the irq_entry
 	 * that we designated the descriptor to.
 	 */
-	if (desc->hw->flags & IDXD_OP_FLAG_RCI)
-		llist_add(&desc->llnode,
-			  &idxd->irq_entries[vec].pending_llist);
+	if (desc->hw->flags & IDXD_OP_FLAG_RCI) {
+		int vec;
+
+		/*
+		 * If the driver is on host kernel, it would be the value
+		 * assigned to interrupt handle, which is index for MSIX
+		 * vector. If it's guest then can't use the int_handle since
+		 * that is the index to IMS for the entire device. The guest
+		 * device local index will be used.
+		 */
+		vec = !idxd->int_handles ? desc->hw->int_handle : desc->vector;
+		llist_add(&desc->llnode, &idxd->irq_entries[vec].pending_llist);
+	}
 
 	return 0;
 }
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index d45cb61f300b..3f4ea4d0fae7 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1600,6 +1600,7 @@ static void idxd_conf_device_release(struct device *dev)
 	kfree(idxd->wqs);
 	kfree(idxd->engines);
 	kfree(idxd->irq_entries);
+	kfree(idxd->int_handles);
 	ida_free(&idxd_ida, idxd->id);
 	kfree(idxd);
 }


