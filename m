Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B13811330AE
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jan 2020 21:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgAGUlT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jan 2020 15:41:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:57765 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgAGUlS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 Jan 2020 15:41:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 12:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="217300333"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jan 2020 12:41:16 -0800
Subject: [PATCH v4 4/9] dmaengine: idxd: Init and probe for Intel data
 accelerators
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Tue, 07 Jan 2020 13:41:16 -0700
Message-ID: <157842967632.27241.15427659079528765283.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157842940405.27241.1146722525082010210.stgit@djiang5-desk3.ch.intel.com>
References: <157842940405.27241.1146722525082010210.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The idxd driver introduces the Intel Data Stream Accelerator [1] that will
be available on future Intel Xeon CPUs. One of the kernel access
point for the driver is through the dmaengine subsystem. It will initially
provide the DMA copy service to the kernel.

Some of the main functionality introduced with this accelerator
are: shared virtual memory (SVM) support, and descriptor submission using
Intel CPU instructions movdir64b and enqcmds. There will be additional
accelerator devices that share the same driver with variations to
capabilities.

This commit introduces the probe and initialization component of the
driver.

[1]: https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 MAINTAINERS                  |    8 +
 drivers/dma/Kconfig          |   13 +
 drivers/dma/Makefile         |    1 
 drivers/dma/idxd/Makefile    |    2 
 drivers/dma/idxd/device.c    |  657 ++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h      |  225 ++++++++++++++
 drivers/dma/idxd/init.c      |  468 ++++++++++++++++++++++++++++++
 drivers/dma/idxd/irq.c       |  156 ++++++++++
 drivers/dma/idxd/registers.h |  335 +++++++++++++++++++++
 include/uapi/linux/idxd.h    |  218 ++++++++++++++
 10 files changed, 2083 insertions(+)
 create mode 100644 drivers/dma/idxd/Makefile
 create mode 100644 drivers/dma/idxd/device.c
 create mode 100644 drivers/dma/idxd/idxd.h
 create mode 100644 drivers/dma/idxd/init.c
 create mode 100644 drivers/dma/idxd/irq.c
 create mode 100644 drivers/dma/idxd/registers.h
 create mode 100644 include/uapi/linux/idxd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8982c6e013b3..8c3c980efdf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8381,6 +8381,14 @@ Q:	https://patchwork.kernel.org/project/linux-dmaengine/list/
 S:	Supported
 F:	drivers/dma/ioat*
 
+INTEL IADX DRIVER
+M:	Dave Jiang <dave.jiang@intel.com>
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	drivers/dma/idxd/*
+F:	include/uapi/linux/idxd.h
+F:	include/linux/idxd.h
+
 INTEL IDLE DRIVER
 M:	Jacob Pan <jacob.jun.pan@linux.intel.com>
 M:	Len Brown <lenb@kernel.org>
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6fa1eba9d477..4ca11e45a731 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -273,6 +273,19 @@ config INTEL_IDMA64
 	  Enable DMA support for Intel Low Power Subsystem such as found on
 	  Intel Skylake PCH.
 
+config INTEL_IDXD
+	tristate "Intel Data Accelerators support"
+	depends on PCI && X86_64
+	select DMA_ENGINE
+	select SBITMAP
+	help
+	  Enable support for the Intel(R) data accelerators present
+	  in Intel Xeon CPU.
+
+	  Say Y if you have such a platform.
+
+	  If unsure, say N.
+
 config INTEL_IOATDMA
 	tristate "Intel I/OAT DMA support"
 	depends on PCI && X86_64
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 42d7e2fc64fa..208decad784f 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_IMX_DMA) += imx-dma.o
 obj-$(CONFIG_IMX_SDMA) += imx-sdma.o
 obj-$(CONFIG_INTEL_IDMA64) += idma64.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioat/
+obj-$(CONFIG_INTEL_IDXD) += idxd/
 obj-$(CONFIG_INTEL_IOP_ADMA) += iop-adma.o
 obj-$(CONFIG_INTEL_MIC_X100_DMA) += mic_x100_dma.o
 obj-$(CONFIG_K3_DMA) += k3dma.o
diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
new file mode 100644
index 000000000000..0dd1ca77513f
--- /dev/null
+++ b/drivers/dma/idxd/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_INTEL_IDXD) += idxd.o
+idxd-y := init.o irq.o device.o
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
new file mode 100644
index 000000000000..af2bdc18df3d
--- /dev/null
+++ b/drivers/dma/idxd/device.c
@@ -0,0 +1,657 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <uapi/linux/idxd.h>
+#include "idxd.h"
+#include "registers.h"
+
+static int idxd_cmd_wait(struct idxd_device *idxd, u32 *status, int timeout);
+static int idxd_cmd_send(struct idxd_device *idxd, int cmd_code, u32 operand);
+
+/* Interrupt control bits */
+int idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id)
+{
+	struct pci_dev *pdev = idxd->pdev;
+	int msixcnt = pci_msix_vec_count(pdev);
+	union msix_perm perm;
+	u32 offset;
+
+	if (vec_id < 0 || vec_id >= msixcnt)
+		return -EINVAL;
+
+	offset = idxd->msix_perm_offset + vec_id * 8;
+	perm.bits = ioread32(idxd->reg_base + offset);
+	perm.ignore = 1;
+	iowrite32(perm.bits, idxd->reg_base + offset);
+
+	return 0;
+}
+
+void idxd_mask_msix_vectors(struct idxd_device *idxd)
+{
+	struct pci_dev *pdev = idxd->pdev;
+	int msixcnt = pci_msix_vec_count(pdev);
+	int i, rc;
+
+	for (i = 0; i < msixcnt; i++) {
+		rc = idxd_mask_msix_vector(idxd, i);
+		if (rc < 0)
+			dev_warn(&pdev->dev,
+				 "Failed disabling msix vec %d\n", i);
+	}
+}
+
+int idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id)
+{
+	struct pci_dev *pdev = idxd->pdev;
+	int msixcnt = pci_msix_vec_count(pdev);
+	union msix_perm perm;
+	u32 offset;
+
+	if (vec_id < 0 || vec_id >= msixcnt)
+		return -EINVAL;
+
+	offset = idxd->msix_perm_offset + vec_id * 8;
+	perm.bits = ioread32(idxd->reg_base + offset);
+	perm.ignore = 0;
+	iowrite32(perm.bits, idxd->reg_base + offset);
+
+	return 0;
+}
+
+void idxd_unmask_error_interrupts(struct idxd_device *idxd)
+{
+	union genctrl_reg genctrl;
+
+	genctrl.bits = ioread32(idxd->reg_base + IDXD_GENCTRL_OFFSET);
+	genctrl.softerr_int_en = 1;
+	iowrite32(genctrl.bits, idxd->reg_base + IDXD_GENCTRL_OFFSET);
+}
+
+void idxd_mask_error_interrupts(struct idxd_device *idxd)
+{
+	union genctrl_reg genctrl;
+
+	genctrl.bits = ioread32(idxd->reg_base + IDXD_GENCTRL_OFFSET);
+	genctrl.softerr_int_en = 0;
+	iowrite32(genctrl.bits, idxd->reg_base + IDXD_GENCTRL_OFFSET);
+}
+
+static void free_hw_descs(struct idxd_wq *wq)
+{
+	int i;
+
+	for (i = 0; i < wq->num_descs; i++)
+		kfree(wq->hw_descs[i]);
+
+	kfree(wq->hw_descs);
+}
+
+static int alloc_hw_descs(struct idxd_wq *wq, int num)
+{
+	struct device *dev = &wq->idxd->pdev->dev;
+	int i;
+	int node = dev_to_node(dev);
+
+	wq->hw_descs = kcalloc_node(num, sizeof(struct dsa_hw_desc *),
+				    GFP_KERNEL, node);
+	if (!wq->hw_descs)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		wq->hw_descs[i] = kzalloc_node(sizeof(*wq->hw_descs[i]),
+					       GFP_KERNEL, node);
+		if (!wq->hw_descs[i]) {
+			free_hw_descs(wq);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static void free_descs(struct idxd_wq *wq)
+{
+	int i;
+
+	for (i = 0; i < wq->num_descs; i++)
+		kfree(wq->descs[i]);
+
+	kfree(wq->descs);
+}
+
+static int alloc_descs(struct idxd_wq *wq, int num)
+{
+	struct device *dev = &wq->idxd->pdev->dev;
+	int i;
+	int node = dev_to_node(dev);
+
+	wq->descs = kcalloc_node(num, sizeof(struct idxd_desc *),
+				 GFP_KERNEL, node);
+	if (!wq->descs)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		wq->descs[i] = kzalloc_node(sizeof(*wq->descs[i]),
+					    GFP_KERNEL, node);
+		if (!wq->descs[i]) {
+			free_descs(wq);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/* WQ control bits */
+int idxd_wq_alloc_resources(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct idxd_group *group = wq->group;
+	struct device *dev = &idxd->pdev->dev;
+	int rc, num_descs, i;
+
+	num_descs = wq->size +
+		idxd->hw.gen_cap.max_descs_per_engine * group->num_engines;
+	wq->num_descs = num_descs;
+
+	rc = alloc_hw_descs(wq, num_descs);
+	if (rc < 0)
+		return rc;
+
+	wq->compls_size = num_descs * sizeof(struct dsa_completion_record);
+	wq->compls = dma_alloc_coherent(dev, wq->compls_size,
+					&wq->compls_addr, GFP_KERNEL);
+	if (!wq->compls) {
+		rc = -ENOMEM;
+		goto fail_alloc_compls;
+	}
+
+	rc = alloc_descs(wq, num_descs);
+	if (rc < 0)
+		goto fail_alloc_descs;
+
+	rc = sbitmap_init_node(&wq->sbmap, num_descs, -1, GFP_KERNEL,
+			       dev_to_node(dev));
+	if (rc < 0)
+		goto fail_sbitmap_init;
+
+	for (i = 0; i < num_descs; i++) {
+		struct idxd_desc *desc = wq->descs[i];
+
+		desc->hw = wq->hw_descs[i];
+		desc->completion = &wq->compls[i];
+		desc->compl_dma  = wq->compls_addr +
+			sizeof(struct dsa_completion_record) * i;
+		desc->id = i;
+		desc->wq = wq;
+	}
+
+	return 0;
+
+ fail_sbitmap_init:
+	free_descs(wq);
+ fail_alloc_descs:
+	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
+ fail_alloc_compls:
+	free_hw_descs(wq);
+	return rc;
+}
+
+void idxd_wq_free_resources(struct idxd_wq *wq)
+{
+	struct device *dev = &wq->idxd->pdev->dev;
+
+	free_hw_descs(wq);
+	free_descs(wq);
+	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
+	sbitmap_free(&wq->sbmap);
+}
+
+int idxd_wq_enable(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	u32 status;
+	int rc;
+
+	lockdep_assert_held(&idxd->dev_lock);
+
+	if (wq->state == IDXD_WQ_ENABLED) {
+		dev_dbg(dev, "WQ %d already enabled\n", wq->id);
+		return -ENXIO;
+	}
+
+	rc = idxd_cmd_send(idxd, IDXD_CMD_ENABLE_WQ, wq->id);
+	if (rc < 0)
+		return rc;
+	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
+	if (rc < 0)
+		return rc;
+
+	if (status != IDXD_CMDSTS_SUCCESS &&
+	    status != IDXD_CMDSTS_ERR_WQ_ENABLED) {
+		dev_dbg(dev, "WQ enable failed: %#x\n", status);
+		return -ENXIO;
+	}
+
+	wq->state = IDXD_WQ_ENABLED;
+	dev_dbg(dev, "WQ %d enabled\n", wq->id);
+	return 0;
+}
+
+int idxd_wq_disable(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	u32 status, operand;
+	int rc;
+
+	lockdep_assert_held(&idxd->dev_lock);
+	dev_dbg(dev, "Disabling WQ %d\n", wq->id);
+
+	if (wq->state != IDXD_WQ_ENABLED) {
+		dev_dbg(dev, "WQ %d in wrong state: %d\n", wq->id, wq->state);
+		return 0;
+	}
+
+	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
+	rc = idxd_cmd_send(idxd, IDXD_CMD_DISABLE_WQ, operand);
+	if (rc < 0)
+		return rc;
+	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
+	if (rc < 0)
+		return rc;
+
+	if (status != IDXD_CMDSTS_SUCCESS) {
+		dev_dbg(dev, "WQ disable failed: %#x\n", status);
+		return -ENXIO;
+	}
+
+	wq->state = IDXD_WQ_DISABLED;
+	dev_dbg(dev, "WQ %d disabled\n", wq->id);
+	return 0;
+}
+
+/* Device control bits */
+static inline bool idxd_is_enabled(struct idxd_device *idxd)
+{
+	union gensts_reg gensts;
+
+	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
+
+	if (gensts.state == IDXD_DEVICE_STATE_ENABLED)
+		return true;
+	return false;
+}
+
+static int idxd_cmd_wait(struct idxd_device *idxd, u32 *status, int timeout)
+{
+	u32 sts, to = timeout;
+
+	lockdep_assert_held(&idxd->dev_lock);
+	sts = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
+	while (sts & IDXD_CMDSTS_ACTIVE && --to) {
+		cpu_relax();
+		sts = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
+	}
+
+	if (to == 0 && sts & IDXD_CMDSTS_ACTIVE) {
+		dev_warn(&idxd->pdev->dev, "%s timed out!\n", __func__);
+		*status = 0;
+		return -EBUSY;
+	}
+
+	*status = sts;
+	return 0;
+}
+
+static int idxd_cmd_send(struct idxd_device *idxd, int cmd_code, u32 operand)
+{
+	union idxd_command_reg cmd;
+	int rc;
+	u32 status;
+
+	lockdep_assert_held(&idxd->dev_lock);
+	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
+	if (rc < 0)
+		return rc;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.cmd = cmd_code;
+	cmd.operand = operand;
+	dev_dbg(&idxd->pdev->dev, "%s: sending cmd: %#x op: %#x\n",
+		__func__, cmd_code, operand);
+	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
+
+	return 0;
+}
+
+int idxd_device_enable(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	int rc;
+	u32 status;
+
+	lockdep_assert_held(&idxd->dev_lock);
+	if (idxd_is_enabled(idxd)) {
+		dev_dbg(dev, "Device already enabled\n");
+		return -ENXIO;
+	}
+
+	rc = idxd_cmd_send(idxd, IDXD_CMD_ENABLE_DEVICE, 0);
+	if (rc < 0)
+		return rc;
+	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
+	if (rc < 0)
+		return rc;
+
+	/* If the command is successful or if the device was enabled */
+	if (status != IDXD_CMDSTS_SUCCESS &&
+	    status != IDXD_CMDSTS_ERR_DEV_ENABLED) {
+		dev_dbg(dev, "%s: err_code: %#x\n", __func__, status);
+		return -ENXIO;
+	}
+
+	idxd->state = IDXD_DEV_ENABLED;
+	return 0;
+}
+
+int idxd_device_disable(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	int rc;
+	u32 status;
+
+	lockdep_assert_held(&idxd->dev_lock);
+	if (!idxd_is_enabled(idxd)) {
+		dev_dbg(dev, "Device is not enabled\n");
+		return 0;
+	}
+
+	rc = idxd_cmd_send(idxd, IDXD_CMD_DISABLE_DEVICE, 0);
+	if (rc < 0)
+		return rc;
+	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
+	if (rc < 0)
+		return rc;
+
+	/* If the command is successful or if the device was disabled */
+	if (status != IDXD_CMDSTS_SUCCESS &&
+	    !(status & IDXD_CMDSTS_ERR_DIS_DEV_EN)) {
+		dev_dbg(dev, "%s: err_code: %#x\n", __func__, status);
+		rc = -ENXIO;
+		return rc;
+	}
+
+	idxd->state = IDXD_DEV_CONF_READY;
+	return 0;
+}
+
+int __idxd_device_reset(struct idxd_device *idxd)
+{
+	u32 status;
+	int rc;
+
+	rc = idxd_cmd_send(idxd, IDXD_CMD_RESET_DEVICE, 0);
+	if (rc < 0)
+		return rc;
+	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+int idxd_device_reset(struct idxd_device *idxd)
+{
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	rc = __idxd_device_reset(idxd);
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	return rc;
+}
+
+/* Device configuration bits */
+static void idxd_group_config_write(struct idxd_group *group)
+{
+	struct idxd_device *idxd = group->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	int i;
+	u32 grpcfg_offset;
+
+	dev_dbg(dev, "Writing group %d cfg registers\n", group->id);
+
+	/* setup GRPWQCFG */
+	for (i = 0; i < 4; i++) {
+		grpcfg_offset = idxd->grpcfg_offset +
+			group->id * 64 + i * sizeof(u64);
+		iowrite64(group->grpcfg.wqs[i],
+			  idxd->reg_base + grpcfg_offset);
+		dev_dbg(dev, "GRPCFG wq[%d:%d: %#x]: %#llx\n",
+			group->id, i, grpcfg_offset,
+			ioread64(idxd->reg_base + grpcfg_offset));
+	}
+
+	/* setup GRPENGCFG */
+	grpcfg_offset = idxd->grpcfg_offset + group->id * 64 + 32;
+	iowrite64(group->grpcfg.engines, idxd->reg_base + grpcfg_offset);
+	dev_dbg(dev, "GRPCFG engs[%d: %#x]: %#llx\n", group->id,
+		grpcfg_offset, ioread64(idxd->reg_base + grpcfg_offset));
+
+	/* setup GRPFLAGS */
+	grpcfg_offset = idxd->grpcfg_offset + group->id * 64 + 40;
+	iowrite32(group->grpcfg.flags.bits, idxd->reg_base + grpcfg_offset);
+	dev_dbg(dev, "GRPFLAGS flags[%d: %#x]: %#x\n",
+		group->id, grpcfg_offset,
+		ioread32(idxd->reg_base + grpcfg_offset));
+}
+
+static int idxd_groups_config_write(struct idxd_device *idxd)
+
+{
+	union gencfg_reg reg;
+	int i;
+	struct device *dev = &idxd->pdev->dev;
+
+	/* Setup bandwidth token limit */
+	if (idxd->token_limit) {
+		reg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
+		reg.token_limit = idxd->token_limit;
+		iowrite32(reg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
+	}
+
+	dev_dbg(dev, "GENCFG(%#x): %#x\n", IDXD_GENCFG_OFFSET,
+		ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET));
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		struct idxd_group *group = &idxd->groups[i];
+
+		idxd_group_config_write(group);
+	}
+
+	return 0;
+}
+
+static int idxd_wq_config_write(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	u32 wq_offset;
+	int i;
+
+	if (!wq->group)
+		return 0;
+
+	memset(&wq->wqcfg, 0, sizeof(union wqcfg));
+
+	/* byte 0-3 */
+	wq->wqcfg.wq_size = wq->size;
+
+	if (wq->size == 0) {
+		dev_warn(dev, "Incorrect work queue size: 0\n");
+		return -EINVAL;
+	}
+
+	/* bytes 4-7 */
+	wq->wqcfg.wq_thresh = wq->threshold;
+
+	/* byte 8-11 */
+	wq->wqcfg.priv = 1; /* kernel, therefore priv */
+	wq->wqcfg.mode = 1;
+
+	wq->wqcfg.priority = wq->priority;
+
+	/* bytes 12-15 */
+	wq->wqcfg.max_xfer_shift = idxd->hw.gen_cap.max_xfer_shift;
+	wq->wqcfg.max_batch_shift = idxd->hw.gen_cap.max_batch_shift;
+
+	dev_dbg(dev, "WQ %d CFGs\n", wq->id);
+	for (i = 0; i < 8; i++) {
+		wq_offset = idxd->wqcfg_offset + wq->id * 32 + i * sizeof(u32);
+		iowrite32(wq->wqcfg.bits[i], idxd->reg_base + wq_offset);
+		dev_dbg(dev, "WQ[%d][%d][%#x]: %#x\n",
+			wq->id, i, wq_offset,
+			ioread32(idxd->reg_base + wq_offset));
+	}
+
+	return 0;
+}
+
+static int idxd_wqs_config_write(struct idxd_device *idxd)
+{
+	int i, rc;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+
+		rc = idxd_wq_config_write(wq);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+static void idxd_group_flags_setup(struct idxd_device *idxd)
+{
+	int i;
+
+	/* TC-A 0 and TC-B 1 should be defaults */
+	for (i = 0; i < idxd->max_groups; i++) {
+		struct idxd_group *group = &idxd->groups[i];
+
+		if (group->tc_a == -1)
+			group->grpcfg.flags.tc_a = 0;
+		else
+			group->grpcfg.flags.tc_a = group->tc_a;
+		if (group->tc_b == -1)
+			group->grpcfg.flags.tc_b = 1;
+		else
+			group->grpcfg.flags.tc_b = group->tc_b;
+		group->grpcfg.flags.use_token_limit = group->use_token_limit;
+		group->grpcfg.flags.tokens_reserved = group->tokens_reserved;
+		if (group->tokens_allowed)
+			group->grpcfg.flags.tokens_allowed =
+				group->tokens_allowed;
+		else
+			group->grpcfg.flags.tokens_allowed = idxd->max_tokens;
+	}
+}
+
+static int idxd_engines_setup(struct idxd_device *idxd)
+{
+	int i, engines = 0;
+	struct idxd_engine *eng;
+	struct idxd_group *group;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		group = &idxd->groups[i];
+		group->grpcfg.engines = 0;
+	}
+
+	for (i = 0; i < idxd->max_engines; i++) {
+		eng = &idxd->engines[i];
+		group = eng->group;
+
+		if (!group)
+			continue;
+
+		group->grpcfg.engines |= BIT(eng->id);
+		engines++;
+	}
+
+	if (!engines)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int idxd_wqs_setup(struct idxd_device *idxd)
+{
+	struct idxd_wq *wq;
+	struct idxd_group *group;
+	int i, j, configured = 0;
+	struct device *dev = &idxd->pdev->dev;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		group = &idxd->groups[i];
+		for (j = 0; j < 4; j++)
+			group->grpcfg.wqs[j] = 0;
+	}
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = &idxd->wqs[i];
+		group = wq->group;
+
+		if (!wq->group)
+			continue;
+		if (!wq->size)
+			continue;
+
+		if (!wq_dedicated(wq)) {
+			dev_warn(dev, "No shared workqueue support.\n");
+			return -EINVAL;
+		}
+
+		group->grpcfg.wqs[wq->id / 64] |= BIT(wq->id % 64);
+		configured++;
+	}
+
+	if (configured == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+int idxd_device_config(struct idxd_device *idxd)
+{
+	int rc;
+
+	lockdep_assert_held(&idxd->dev_lock);
+	rc = idxd_wqs_setup(idxd);
+	if (rc < 0)
+		return rc;
+
+	rc = idxd_engines_setup(idxd);
+	if (rc < 0)
+		return rc;
+
+	idxd_group_flags_setup(idxd);
+
+	rc = idxd_wqs_config_write(idxd);
+	if (rc < 0)
+		return rc;
+
+	rc = idxd_groups_config_write(idxd);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
new file mode 100644
index 000000000000..733484922365
--- /dev/null
+++ b/drivers/dma/idxd/idxd.h
@@ -0,0 +1,225 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#ifndef _IDXD_H_
+#define _IDXD_H_
+
+#include <linux/sbitmap.h>
+#include <linux/percpu-rwsem.h>
+#include <linux/wait.h>
+#include "registers.h"
+
+#define IDXD_DRIVER_VERSION	"1.00"
+
+extern struct kmem_cache *idxd_desc_pool;
+
+#define IDXD_REG_TIMEOUT	50
+#define IDXD_DRAIN_TIMEOUT	5000
+
+enum idxd_type {
+	IDXD_TYPE_UNKNOWN = -1,
+	IDXD_TYPE_DSA = 0,
+	IDXD_TYPE_MAX
+};
+
+#define IDXD_NAME_SIZE		128
+
+struct idxd_device_driver {
+	struct device_driver drv;
+};
+
+struct idxd_irq_entry {
+	struct idxd_device *idxd;
+	int id;
+	struct llist_head pending_llist;
+	struct list_head work_list;
+};
+
+struct idxd_group {
+	struct device conf_dev;
+	struct idxd_device *idxd;
+	struct grpcfg grpcfg;
+	int id;
+	int num_engines;
+	int num_wqs;
+	bool use_token_limit;
+	u8 tokens_allowed;
+	u8 tokens_reserved;
+	int tc_a;
+	int tc_b;
+};
+
+#define IDXD_MAX_PRIORITY	0xf
+
+enum idxd_wq_state {
+	IDXD_WQ_DISABLED = 0,
+	IDXD_WQ_ENABLED,
+};
+
+enum idxd_wq_flag {
+	WQ_FLAG_DEDICATED = 0,
+};
+
+enum idxd_wq_type {
+	IDXD_WQT_NONE = 0,
+	IDXD_WQT_KERNEL,
+};
+
+#define IDXD_ALLOCATED_BATCH_SIZE	128U
+#define WQ_NAME_SIZE   1024
+#define WQ_TYPE_SIZE   10
+
+struct idxd_wq {
+	void __iomem *dportal;
+	struct device conf_dev;
+	struct idxd_device *idxd;
+	int id;
+	enum idxd_wq_type type;
+	struct idxd_group *group;
+	int client_count;
+	struct mutex wq_lock;	/* mutex for workqueue */
+	u32 size;
+	u32 threshold;
+	u32 priority;
+	enum idxd_wq_state state;
+	unsigned long flags;
+	union wqcfg wqcfg;
+	atomic_t dq_count;	/* dedicated queue flow control */
+	u32 vec_ptr;		/* interrupt steering */
+	struct dsa_hw_desc **hw_descs;
+	int num_descs;
+	struct dsa_completion_record *compls;
+	dma_addr_t compls_addr;
+	int compls_size;
+	struct idxd_desc **descs;
+	struct sbitmap sbmap;
+	struct percpu_rw_semaphore submit_lock;
+	wait_queue_head_t submit_waitq;
+	char name[WQ_NAME_SIZE + 1];
+};
+
+struct idxd_engine {
+	struct device conf_dev;
+	int id;
+	struct idxd_group *group;
+	struct idxd_device *idxd;
+};
+
+/* shadow registers */
+struct idxd_hw {
+	u32 version;
+	union gen_cap_reg gen_cap;
+	union wq_cap_reg wq_cap;
+	union group_cap_reg group_cap;
+	union engine_cap_reg engine_cap;
+	struct opcap opcap;
+};
+
+enum idxd_device_state {
+	IDXD_DEV_HALTED = -1,
+	IDXD_DEV_DISABLED = 0,
+	IDXD_DEV_CONF_READY,
+	IDXD_DEV_ENABLED,
+};
+
+enum idxd_device_flag {
+	IDXD_FLAG_CONFIGURABLE = 0,
+};
+
+struct idxd_device {
+	enum idxd_type type;
+	struct device conf_dev;
+	struct list_head list;
+	struct idxd_hw hw;
+	enum idxd_device_state state;
+	unsigned long flags;
+	int id;
+
+	struct pci_dev *pdev;
+	void __iomem *reg_base;
+
+	spinlock_t dev_lock;	/* spinlock for device */
+	struct idxd_group *groups;
+	struct idxd_wq *wqs;
+	struct idxd_engine *engines;
+
+	int num_groups;
+
+	u32 msix_perm_offset;
+	u32 wqcfg_offset;
+	u32 grpcfg_offset;
+	u32 perfmon_offset;
+
+	u64 max_xfer_bytes;
+	u32 max_batch_size;
+	int max_groups;
+	int max_engines;
+	int max_tokens;
+	int max_wqs;
+	int max_wq_size;
+	int token_limit;
+
+	union sw_err_reg sw_err;
+
+	struct msix_entry *msix_entries;
+	int num_wq_irqs;
+	struct idxd_irq_entry *irq_entries;
+};
+
+/* IDXD software descriptor */
+struct idxd_desc {
+	struct dsa_hw_desc *hw;
+	dma_addr_t desc_dma;
+	struct dsa_completion_record *completion;
+	dma_addr_t compl_dma;
+	struct llist_node llnode;
+	struct list_head list;
+	int id;
+	struct idxd_wq *wq;
+};
+
+#define confdev_to_idxd(dev) container_of(dev, struct idxd_device, conf_dev)
+#define confdev_to_wq(dev) container_of(dev, struct idxd_wq, conf_dev)
+
+static inline bool wq_dedicated(struct idxd_wq *wq)
+{
+	return test_bit(WQ_FLAG_DEDICATED, &wq->flags);
+}
+
+static inline void idxd_set_type(struct idxd_device *idxd)
+{
+	struct pci_dev *pdev = idxd->pdev;
+
+	if (pdev->device == PCI_DEVICE_ID_INTEL_DSA_SPR0)
+		idxd->type = IDXD_TYPE_DSA;
+	else
+		idxd->type = IDXD_TYPE_UNKNOWN;
+}
+
+const char *idxd_get_dev_name(struct idxd_device *idxd);
+
+/* device interrupt control */
+irqreturn_t idxd_irq_handler(int vec, void *data);
+irqreturn_t idxd_misc_thread(int vec, void *data);
+irqreturn_t idxd_wq_thread(int irq, void *data);
+void idxd_mask_error_interrupts(struct idxd_device *idxd);
+void idxd_unmask_error_interrupts(struct idxd_device *idxd);
+void idxd_mask_msix_vectors(struct idxd_device *idxd);
+int idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id);
+int idxd_unmask_msix_vector(struct idxd_device *idxd, int vec_id);
+
+/* device control */
+int idxd_device_enable(struct idxd_device *idxd);
+int idxd_device_disable(struct idxd_device *idxd);
+int idxd_device_reset(struct idxd_device *idxd);
+int __idxd_device_reset(struct idxd_device *idxd);
+void idxd_device_cleanup(struct idxd_device *idxd);
+int idxd_device_config(struct idxd_device *idxd);
+void idxd_device_wqs_clear_state(struct idxd_device *idxd);
+
+/* work queue control */
+int idxd_wq_alloc_resources(struct idxd_wq *wq);
+void idxd_wq_free_resources(struct idxd_wq *wq);
+int idxd_wq_enable(struct idxd_wq *wq);
+int idxd_wq_disable(struct idxd_wq *wq);
+
+#endif
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
new file mode 100644
index 000000000000..6e89a87d62b0
--- /dev/null
+++ b/drivers/dma/idxd/init.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/workqueue.h>
+#include <linux/aer.h>
+#include <linux/fs.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <uapi/linux/idxd.h>
+#include "registers.h"
+#include "idxd.h"
+
+MODULE_VERSION(IDXD_DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Intel Corporation");
+
+#define DRV_NAME "idxd"
+
+static struct idr idxd_idrs[IDXD_TYPE_MAX];
+static struct mutex idxd_idr_lock;
+
+static struct pci_device_id idxd_pci_tbl[] = {
+	/* DSA ver 1.0 platforms */
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_DSA_SPR0) },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
+
+static char *idxd_name[] = {
+	"dsa",
+};
+
+const char *idxd_get_dev_name(struct idxd_device *idxd)
+{
+	return idxd_name[idxd->type];
+}
+
+static int idxd_setup_interrupts(struct idxd_device *idxd)
+{
+	struct pci_dev *pdev = idxd->pdev;
+	struct device *dev = &pdev->dev;
+	struct msix_entry *msix;
+	struct idxd_irq_entry *irq_entry;
+	int i, msixcnt;
+	int rc = 0;
+
+	msixcnt = pci_msix_vec_count(pdev);
+	if (msixcnt < 0) {
+		dev_err(dev, "Not MSI-X interrupt capable.\n");
+		goto err_no_irq;
+	}
+
+	idxd->msix_entries = devm_kzalloc(dev, sizeof(struct msix_entry) *
+			msixcnt, GFP_KERNEL);
+	if (!idxd->msix_entries) {
+		rc = -ENOMEM;
+		goto err_no_irq;
+	}
+
+	for (i = 0; i < msixcnt; i++)
+		idxd->msix_entries[i].entry = i;
+
+	rc = pci_enable_msix_exact(pdev, idxd->msix_entries, msixcnt);
+	if (rc) {
+		dev_err(dev, "Failed enabling %d MSIX entries.\n", msixcnt);
+		goto err_no_irq;
+	}
+	dev_dbg(dev, "Enabled %d msix vectors\n", msixcnt);
+
+	/*
+	 * We implement 1 completion list per MSI-X entry except for
+	 * entry 0, which is for errors and others.
+	 */
+	idxd->irq_entries = devm_kcalloc(dev, msixcnt,
+					 sizeof(struct idxd_irq_entry),
+					 GFP_KERNEL);
+	if (!idxd->irq_entries) {
+		rc = -ENOMEM;
+		goto err_no_irq;
+	}
+
+	for (i = 0; i < msixcnt; i++) {
+		idxd->irq_entries[i].id = i;
+		idxd->irq_entries[i].idxd = idxd;
+	}
+
+	msix = &idxd->msix_entries[0];
+	irq_entry = &idxd->irq_entries[0];
+	rc = devm_request_threaded_irq(dev, msix->vector, idxd_irq_handler,
+				       idxd_misc_thread, 0, "idxd-misc",
+				       irq_entry);
+	if (rc < 0) {
+		dev_err(dev, "Failed to allocate misc interrupt.\n");
+		goto err_no_irq;
+	}
+
+	dev_dbg(dev, "Allocated idxd-misc handler on msix vector %d\n",
+		msix->vector);
+
+	/* first MSI-X entry is not for wq interrupts */
+	idxd->num_wq_irqs = msixcnt - 1;
+
+	for (i = 1; i < msixcnt; i++) {
+		msix = &idxd->msix_entries[i];
+		irq_entry = &idxd->irq_entries[i];
+
+		init_llist_head(&idxd->irq_entries[i].pending_llist);
+		INIT_LIST_HEAD(&idxd->irq_entries[i].work_list);
+		rc = devm_request_threaded_irq(dev, msix->vector,
+					       idxd_irq_handler,
+					       idxd_wq_thread, 0,
+					       "idxd-portal", irq_entry);
+		if (rc < 0) {
+			dev_err(dev, "Failed to allocate irq %d.\n",
+				msix->vector);
+			goto err_no_irq;
+		}
+		dev_dbg(dev, "Allocated idxd-msix %d for vector %d\n",
+			i, msix->vector);
+	}
+
+	idxd_unmask_error_interrupts(idxd);
+
+	return 0;
+
+ err_no_irq:
+	/* Disable error interrupt generation */
+	idxd_mask_error_interrupts(idxd);
+	pci_disable_msix(pdev);
+	dev_err(dev, "No usable interrupts\n");
+	return rc;
+}
+
+static void idxd_wqs_free_lock(struct idxd_device *idxd)
+{
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+
+		percpu_free_rwsem(&wq->submit_lock);
+	}
+}
+
+static int idxd_setup_internals(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	int i;
+
+	idxd->groups = devm_kcalloc(dev, idxd->max_groups,
+				    sizeof(struct idxd_group), GFP_KERNEL);
+	if (!idxd->groups)
+		return -ENOMEM;
+
+	for (i = 0; i < idxd->max_groups; i++) {
+		idxd->groups[i].idxd = idxd;
+		idxd->groups[i].id = i;
+		idxd->groups[i].tc_a = -1;
+		idxd->groups[i].tc_b = -1;
+	}
+
+	idxd->wqs = devm_kcalloc(dev, idxd->max_wqs, sizeof(struct idxd_wq),
+				 GFP_KERNEL);
+	if (!idxd->wqs)
+		return -ENOMEM;
+
+	idxd->engines = devm_kcalloc(dev, idxd->max_engines,
+				     sizeof(struct idxd_engine), GFP_KERNEL);
+	if (!idxd->engines)
+		return -ENOMEM;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+		int rc;
+
+		wq->id = i;
+		wq->idxd = idxd;
+		mutex_init(&wq->wq_lock);
+		atomic_set(&wq->dq_count, 0);
+		init_waitqueue_head(&wq->submit_waitq);
+		rc = percpu_init_rwsem(&wq->submit_lock);
+		if (rc < 0) {
+			idxd_wqs_free_lock(idxd);
+			return rc;
+		}
+	}
+
+	for (i = 0; i < idxd->max_engines; i++) {
+		idxd->engines[i].idxd = idxd;
+		idxd->engines[i].id = i;
+	}
+
+	return 0;
+}
+
+static void idxd_read_table_offsets(struct idxd_device *idxd)
+{
+	union offsets_reg offsets;
+	struct device *dev = &idxd->pdev->dev;
+
+	offsets.bits[0] = ioread64(idxd->reg_base + IDXD_TABLE_OFFSET);
+	offsets.bits[1] = ioread64(idxd->reg_base + IDXD_TABLE_OFFSET
+			+ sizeof(u64));
+	idxd->grpcfg_offset = offsets.grpcfg * 0x100;
+	dev_dbg(dev, "IDXD Group Config Offset: %#x\n", idxd->grpcfg_offset);
+	idxd->wqcfg_offset = offsets.wqcfg * 0x100;
+	dev_dbg(dev, "IDXD Work Queue Config Offset: %#x\n",
+		idxd->wqcfg_offset);
+	idxd->msix_perm_offset = offsets.msix_perm * 0x100;
+	dev_dbg(dev, "IDXD MSIX Permission Offset: %#x\n",
+		idxd->msix_perm_offset);
+	idxd->perfmon_offset = offsets.perfmon * 0x100;
+	dev_dbg(dev, "IDXD Perfmon Offset: %#x\n", idxd->perfmon_offset);
+}
+
+static void idxd_read_caps(struct idxd_device *idxd)
+{
+	struct device *dev = &idxd->pdev->dev;
+	int i;
+
+	/* reading generic capabilities */
+	idxd->hw.gen_cap.bits = ioread64(idxd->reg_base + IDXD_GENCAP_OFFSET);
+	dev_dbg(dev, "gen_cap: %#llx\n", idxd->hw.gen_cap.bits);
+	idxd->max_xfer_bytes = 1ULL << idxd->hw.gen_cap.max_xfer_shift;
+	dev_dbg(dev, "max xfer size: %llu bytes\n", idxd->max_xfer_bytes);
+	idxd->max_batch_size = 1U << idxd->hw.gen_cap.max_batch_shift;
+	dev_dbg(dev, "max batch size: %u\n", idxd->max_batch_size);
+	if (idxd->hw.gen_cap.config_en)
+		set_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags);
+
+	/* reading group capabilities */
+	idxd->hw.group_cap.bits =
+		ioread64(idxd->reg_base + IDXD_GRPCAP_OFFSET);
+	dev_dbg(dev, "group_cap: %#llx\n", idxd->hw.group_cap.bits);
+	idxd->max_groups = idxd->hw.group_cap.num_groups;
+	dev_dbg(dev, "max groups: %u\n", idxd->max_groups);
+	idxd->max_tokens = idxd->hw.group_cap.total_tokens;
+	dev_dbg(dev, "max tokens: %u\n", idxd->max_tokens);
+
+	/* read engine capabilities */
+	idxd->hw.engine_cap.bits =
+		ioread64(idxd->reg_base + IDXD_ENGCAP_OFFSET);
+	dev_dbg(dev, "engine_cap: %#llx\n", idxd->hw.engine_cap.bits);
+	idxd->max_engines = idxd->hw.engine_cap.num_engines;
+	dev_dbg(dev, "max engines: %u\n", idxd->max_engines);
+
+	/* read workqueue capabilities */
+	idxd->hw.wq_cap.bits = ioread64(idxd->reg_base + IDXD_WQCAP_OFFSET);
+	dev_dbg(dev, "wq_cap: %#llx\n", idxd->hw.wq_cap.bits);
+	idxd->max_wq_size = idxd->hw.wq_cap.total_wq_size;
+	dev_dbg(dev, "total workqueue size: %u\n", idxd->max_wq_size);
+	idxd->max_wqs = idxd->hw.wq_cap.num_wqs;
+	dev_dbg(dev, "max workqueues: %u\n", idxd->max_wqs);
+
+	/* reading operation capabilities */
+	for (i = 0; i < 4; i++) {
+		idxd->hw.opcap.bits[i] = ioread64(idxd->reg_base +
+				IDXD_OPCAP_OFFSET + i * sizeof(u64));
+		dev_dbg(dev, "opcap[%d]: %#llx\n", i, idxd->hw.opcap.bits[i]);
+	}
+}
+
+static struct idxd_device *idxd_alloc(struct pci_dev *pdev,
+				      void __iomem * const *iomap)
+{
+	struct device *dev = &pdev->dev;
+	struct idxd_device *idxd;
+
+	idxd = devm_kzalloc(dev, sizeof(struct idxd_device), GFP_KERNEL);
+	if (!idxd)
+		return NULL;
+
+	idxd->pdev = pdev;
+	idxd->reg_base = iomap[IDXD_MMIO_BAR];
+	spin_lock_init(&idxd->dev_lock);
+
+	return idxd;
+}
+
+static int idxd_probe(struct idxd_device *idxd)
+{
+	struct pci_dev *pdev = idxd->pdev;
+	struct device *dev = &pdev->dev;
+	int rc;
+
+	dev_dbg(dev, "%s entered and resetting device\n", __func__);
+	rc = idxd_device_reset(idxd);
+	if (rc < 0)
+		return rc;
+	dev_dbg(dev, "IDXD reset complete\n");
+
+	idxd_read_caps(idxd);
+	idxd_read_table_offsets(idxd);
+
+	rc = idxd_setup_internals(idxd);
+	if (rc)
+		goto err_setup;
+
+	rc = idxd_setup_interrupts(idxd);
+	if (rc)
+		goto err_setup;
+
+	dev_dbg(dev, "IDXD interrupt setup complete.\n");
+
+	mutex_lock(&idxd_idr_lock);
+	idxd->id = idr_alloc(&idxd_idrs[idxd->type], idxd, 0, 0, GFP_KERNEL);
+	mutex_unlock(&idxd_idr_lock);
+	if (idxd->id < 0) {
+		rc = -ENOMEM;
+		goto err_idr_fail;
+	}
+
+	dev_dbg(dev, "IDXD device %d probed successfully\n", idxd->id);
+	return 0;
+
+ err_idr_fail:
+	idxd_mask_error_interrupts(idxd);
+	idxd_mask_msix_vectors(idxd);
+ err_setup:
+	return rc;
+}
+
+static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	void __iomem * const *iomap;
+	struct device *dev = &pdev->dev;
+	struct idxd_device *idxd;
+	int rc;
+	unsigned int mask;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	dev_dbg(dev, "Mapping BARs\n");
+	mask = (1 << IDXD_MMIO_BAR);
+	rc = pcim_iomap_regions(pdev, mask, DRV_NAME);
+	if (rc)
+		return rc;
+
+	iomap = pcim_iomap_table(pdev);
+	if (!iomap)
+		return -ENOMEM;
+
+	dev_dbg(dev, "Set DMA masks\n");
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (rc)
+		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (rc)
+		return rc;
+
+	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (rc)
+		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (rc)
+		return rc;
+
+	dev_dbg(dev, "Alloc IDXD context\n");
+	idxd = idxd_alloc(pdev, iomap);
+	if (!idxd)
+		return -ENOMEM;
+
+	idxd_set_type(idxd);
+
+	dev_dbg(dev, "Set PCI master\n");
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, idxd);
+
+	idxd->hw.version = ioread32(idxd->reg_base + IDXD_VER_OFFSET);
+	rc = idxd_probe(idxd);
+	if (rc) {
+		dev_err(dev, "Intel(R) IDXD DMA Engine init failed\n");
+		return -ENODEV;
+	}
+
+	dev_info(&pdev->dev, "Intel(R) Accelerator Device (v%x)\n",
+		 idxd->hw.version);
+
+	return 0;
+}
+
+static void idxd_shutdown(struct pci_dev *pdev)
+{
+	struct idxd_device *idxd = pci_get_drvdata(pdev);
+	int rc, i;
+	struct idxd_irq_entry *irq_entry;
+	int msixcnt = pci_msix_vec_count(pdev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&idxd->dev_lock, flags);
+	rc = idxd_device_disable(idxd);
+	spin_unlock_irqrestore(&idxd->dev_lock, flags);
+	if (rc)
+		dev_err(&pdev->dev, "Disabling device failed\n");
+
+	dev_dbg(&pdev->dev, "%s called\n", __func__);
+	idxd_mask_msix_vectors(idxd);
+	idxd_mask_error_interrupts(idxd);
+
+	for (i = 0; i < msixcnt; i++) {
+		irq_entry = &idxd->irq_entries[i];
+		synchronize_irq(idxd->msix_entries[i].vector);
+		if (i == 0)
+			continue;
+	}
+}
+
+static void idxd_remove(struct pci_dev *pdev)
+{
+	struct idxd_device *idxd = pci_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "%s called\n", __func__);
+	idxd_shutdown(pdev);
+	idxd_wqs_free_lock(idxd);
+	mutex_lock(&idxd_idr_lock);
+	idr_remove(&idxd_idrs[idxd->type], idxd->id);
+	mutex_unlock(&idxd_idr_lock);
+}
+
+static struct pci_driver idxd_pci_driver = {
+	.name		= DRV_NAME,
+	.id_table	= idxd_pci_tbl,
+	.probe		= idxd_pci_probe,
+	.remove		= idxd_remove,
+	.shutdown	= idxd_shutdown,
+};
+
+static int __init idxd_init_module(void)
+{
+	int err, i;
+
+	/*
+	 * If the CPU does not support write512, there's no point in
+	 * enumerating the device. We can not utilize it.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_MOVDIR64B)) {
+		pr_warn("idxd driver failed to load without MOVDIR64B.\n");
+		return -ENODEV;
+	}
+
+	pr_info("%s: Intel(R) Accelerator Devices Driver %s\n",
+		DRV_NAME, IDXD_DRIVER_VERSION);
+
+	mutex_init(&idxd_idr_lock);
+	for (i = 0; i < IDXD_TYPE_MAX; i++)
+		idr_init(&idxd_idrs[i]);
+
+	err = pci_register_driver(&idxd_pci_driver);
+	if (err)
+		return err;
+
+	return 0;
+}
+module_init(idxd_init_module);
+
+static void __exit idxd_exit_module(void)
+{
+	pci_unregister_driver(&idxd_pci_driver);
+}
+module_exit(idxd_exit_module);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
new file mode 100644
index 000000000000..de4b80973c2f
--- /dev/null
+++ b/drivers/dma/idxd/irq.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <uapi/linux/idxd.h>
+#include "idxd.h"
+#include "registers.h"
+
+void idxd_device_wqs_clear_state(struct idxd_device *idxd)
+{
+	int i;
+
+	lockdep_assert_held(&idxd->dev_lock);
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+
+		wq->state = IDXD_WQ_DISABLED;
+	}
+}
+
+static int idxd_restart(struct idxd_device *idxd)
+{
+	int i, rc;
+
+	lockdep_assert_held(&idxd->dev_lock);
+
+	rc = __idxd_device_reset(idxd);
+	if (rc < 0)
+		goto out;
+
+	rc = idxd_device_config(idxd);
+	if (rc < 0)
+		goto out;
+
+	rc = idxd_device_enable(idxd);
+	if (rc < 0)
+		goto out;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = &idxd->wqs[i];
+
+		if (wq->state == IDXD_WQ_ENABLED) {
+			rc = idxd_wq_enable(wq);
+			if (rc < 0) {
+				dev_warn(&idxd->pdev->dev,
+					 "Unable to re-enable wq %s\n",
+					 dev_name(&wq->conf_dev));
+			}
+		}
+	}
+
+	return 0;
+
+ out:
+	idxd_device_wqs_clear_state(idxd);
+	idxd->state = IDXD_DEV_HALTED;
+	return rc;
+}
+
+irqreturn_t idxd_irq_handler(int vec, void *data)
+{
+	struct idxd_irq_entry *irq_entry = data;
+	struct idxd_device *idxd = irq_entry->idxd;
+
+	idxd_mask_msix_vector(idxd, irq_entry->id);
+	return IRQ_WAKE_THREAD;
+}
+
+irqreturn_t idxd_misc_thread(int vec, void *data)
+{
+	struct idxd_irq_entry *irq_entry = data;
+	struct idxd_device *idxd = irq_entry->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	union gensts_reg gensts;
+	u32 cause, val = 0;
+	int i, rc;
+	bool err = false;
+
+	cause = ioread32(idxd->reg_base + IDXD_INTCAUSE_OFFSET);
+
+	if (cause & IDXD_INTC_ERR) {
+		spin_lock_bh(&idxd->dev_lock);
+		for (i = 0; i < 4; i++)
+			idxd->sw_err.bits[i] = ioread64(idxd->reg_base +
+					IDXD_SWERR_OFFSET + i * sizeof(u64));
+		iowrite64(IDXD_SWERR_ACK, idxd->reg_base + IDXD_SWERR_OFFSET);
+		spin_unlock_bh(&idxd->dev_lock);
+		val |= IDXD_INTC_ERR;
+
+		for (i = 0; i < 4; i++)
+			dev_warn(dev, "err[%d]: %#16.16llx\n",
+				 i, idxd->sw_err.bits[i]);
+		err = true;
+	}
+
+	if (cause & IDXD_INTC_CMD) {
+		/* Driver does use command interrupts */
+		val |= IDXD_INTC_CMD;
+	}
+
+	if (cause & IDXD_INTC_OCCUPY) {
+		/* Driver does not utilize occupancy interrupt */
+		val |= IDXD_INTC_OCCUPY;
+	}
+
+	if (cause & IDXD_INTC_PERFMON_OVFL) {
+		/*
+		 * Driver does not utilize perfmon counter overflow interrupt
+		 * yet.
+		 */
+		val |= IDXD_INTC_PERFMON_OVFL;
+	}
+
+	val ^= cause;
+	if (val)
+		dev_warn_once(dev, "Unexpected interrupt cause bits set: %#x\n",
+			      val);
+
+	iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
+	if (!err)
+		return IRQ_HANDLED;
+
+	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
+	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
+		spin_lock_bh(&idxd->dev_lock);
+		if (gensts.reset_type == IDXD_DEVICE_RESET_SOFTWARE) {
+			rc = idxd_restart(idxd);
+			if (rc < 0)
+				dev_err(&idxd->pdev->dev,
+					"idxd restart failed, device halt.");
+		} else {
+			idxd_device_wqs_clear_state(idxd);
+			idxd->state = IDXD_DEV_HALTED;
+			dev_err(&idxd->pdev->dev,
+				"idxd halted, need %s.\n",
+				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
+				"FLR" : "system reset");
+		}
+		spin_unlock_bh(&idxd->dev_lock);
+	}
+
+	idxd_unmask_msix_vector(idxd, irq_entry->id);
+	return IRQ_HANDLED;
+}
+
+irqreturn_t idxd_wq_thread(int irq, void *data)
+{
+	struct idxd_irq_entry *irq_entry = data;
+
+	idxd_unmask_msix_vector(irq_entry->idxd, irq_entry->id);
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
new file mode 100644
index 000000000000..77275a07fa61
--- /dev/null
+++ b/drivers/dma/idxd/registers.h
@@ -0,0 +1,335 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#ifndef _IDXD_REGISTERS_H_
+#define _IDXD_REGISTERS_H_
+
+/* PCI Config */
+#define PCI_DEVICE_ID_INTEL_DSA_SPR0	0x0b25
+
+#define IDXD_MMIO_BAR		0
+#define IDXD_WQ_BAR		2
+
+/* MMIO Device BAR0 Registers */
+#define IDXD_VER_OFFSET			0x00
+#define IDXD_VER_MAJOR_MASK		0xf0
+#define IDXD_VER_MINOR_MASK		0x0f
+#define GET_IDXD_VER_MAJOR(x)		(((x) & IDXD_VER_MAJOR_MASK) >> 4)
+#define GET_IDXD_VER_MINOR(x)		((x) & IDXD_VER_MINOR_MASK)
+
+union gen_cap_reg {
+	struct {
+		u64 block_on_fault:1;
+		u64 overlap_copy:1;
+		u64 cache_control_mem:1;
+		u64 cache_control_cache:1;
+		u64 rsvd:3;
+		u64 int_handle_req:1;
+		u64 dest_readback:1;
+		u64 drain_readback:1;
+		u64 rsvd2:6;
+		u64 max_xfer_shift:5;
+		u64 max_batch_shift:4;
+		u64 max_ims_mult:6;
+		u64 config_en:1;
+		u64 max_descs_per_engine:8;
+		u64 rsvd3:24;
+	};
+	u64 bits;
+} __packed;
+#define IDXD_GENCAP_OFFSET		0x10
+
+union wq_cap_reg {
+	struct {
+		u64 total_wq_size:16;
+		u64 num_wqs:8;
+		u64 rsvd:24;
+		u64 shared_mode:1;
+		u64 dedicated_mode:1;
+		u64 rsvd2:1;
+		u64 priority:1;
+		u64 occupancy:1;
+		u64 occupancy_int:1;
+		u64 rsvd3:10;
+	};
+	u64 bits;
+} __packed;
+#define IDXD_WQCAP_OFFSET		0x20
+
+union group_cap_reg {
+	struct {
+		u64 num_groups:8;
+		u64 total_tokens:8;
+		u64 token_en:1;
+		u64 token_limit:1;
+		u64 rsvd:46;
+	};
+	u64 bits;
+} __packed;
+#define IDXD_GRPCAP_OFFSET		0x30
+
+union engine_cap_reg {
+	struct {
+		u64 num_engines:8;
+		u64 rsvd:56;
+	};
+	u64 bits;
+} __packed;
+
+#define IDXD_ENGCAP_OFFSET		0x38
+
+#define IDXD_OPCAP_NOOP			0x0001
+#define IDXD_OPCAP_BATCH			0x0002
+#define IDXD_OPCAP_MEMMOVE		0x0008
+struct opcap {
+	u64 bits[4];
+};
+
+#define IDXD_OPCAP_OFFSET		0x40
+
+#define IDXD_TABLE_OFFSET		0x60
+union offsets_reg {
+	struct {
+		u64 grpcfg:16;
+		u64 wqcfg:16;
+		u64 msix_perm:16;
+		u64 ims:16;
+		u64 perfmon:16;
+		u64 rsvd:48;
+	};
+	u64 bits[2];
+} __packed;
+
+#define IDXD_GENCFG_OFFSET		0x80
+union gencfg_reg {
+	struct {
+		u32 token_limit:8;
+		u32 rsvd:4;
+		u32 user_int_en:1;
+		u32 rsvd2:19;
+	};
+	u32 bits;
+} __packed;
+
+#define IDXD_GENCTRL_OFFSET		0x88
+union genctrl_reg {
+	struct {
+		u32 softerr_int_en:1;
+		u32 rsvd:31;
+	};
+	u32 bits;
+} __packed;
+
+#define IDXD_GENSTATS_OFFSET		0x90
+union gensts_reg {
+	struct {
+		u32 state:2;
+		u32 reset_type:2;
+		u32 rsvd:28;
+	};
+	u32 bits;
+} __packed;
+
+enum idxd_device_status_state {
+	IDXD_DEVICE_STATE_DISABLED = 0,
+	IDXD_DEVICE_STATE_ENABLED,
+	IDXD_DEVICE_STATE_DRAIN,
+	IDXD_DEVICE_STATE_HALT,
+};
+
+enum idxd_device_reset_type {
+	IDXD_DEVICE_RESET_SOFTWARE = 0,
+	IDXD_DEVICE_RESET_FLR,
+	IDXD_DEVICE_RESET_WARM,
+	IDXD_DEVICE_RESET_COLD,
+};
+
+#define IDXD_INTCAUSE_OFFSET		0x98
+#define IDXD_INTC_ERR			0x01
+#define IDXD_INTC_CMD			0x02
+#define IDXD_INTC_OCCUPY			0x04
+#define IDXD_INTC_PERFMON_OVFL		0x08
+
+#define IDXD_CMD_OFFSET			0xa0
+union idxd_command_reg {
+	struct {
+		u32 operand:20;
+		u32 cmd:5;
+		u32 rsvd:6;
+		u32 int_req:1;
+	};
+	u32 bits;
+} __packed;
+
+enum idxd_cmd {
+	IDXD_CMD_ENABLE_DEVICE = 1,
+	IDXD_CMD_DISABLE_DEVICE,
+	IDXD_CMD_DRAIN_ALL,
+	IDXD_CMD_ABORT_ALL,
+	IDXD_CMD_RESET_DEVICE,
+	IDXD_CMD_ENABLE_WQ,
+	IDXD_CMD_DISABLE_WQ,
+	IDXD_CMD_DRAIN_WQ,
+	IDXD_CMD_ABORT_WQ,
+	IDXD_CMD_RESET_WQ,
+	IDXD_CMD_DRAIN_PASID,
+	IDXD_CMD_ABORT_PASID,
+	IDXD_CMD_REQUEST_INT_HANDLE,
+};
+
+#define IDXD_CMDSTS_OFFSET		0xa8
+union cmdsts_reg {
+	struct {
+		u8 err;
+		u16 result;
+		u8 rsvd:7;
+		u8 active:1;
+	};
+	u32 bits;
+} __packed;
+#define IDXD_CMDSTS_ACTIVE		0x80000000
+
+enum idxd_cmdsts_err {
+	IDXD_CMDSTS_SUCCESS = 0,
+	IDXD_CMDSTS_INVAL_CMD,
+	IDXD_CMDSTS_INVAL_WQIDX,
+	IDXD_CMDSTS_HW_ERR,
+	/* enable device errors */
+	IDXD_CMDSTS_ERR_DEV_ENABLED = 0x10,
+	IDXD_CMDSTS_ERR_CONFIG,
+	IDXD_CMDSTS_ERR_BUSMASTER_EN,
+	IDXD_CMDSTS_ERR_PASID_INVAL,
+	IDXD_CMDSTS_ERR_WQ_SIZE_ERANGE,
+	IDXD_CMDSTS_ERR_GRP_CONFIG,
+	IDXD_CMDSTS_ERR_GRP_CONFIG2,
+	IDXD_CMDSTS_ERR_GRP_CONFIG3,
+	IDXD_CMDSTS_ERR_GRP_CONFIG4,
+	/* enable wq errors */
+	IDXD_CMDSTS_ERR_DEV_NOTEN = 0x20,
+	IDXD_CMDSTS_ERR_WQ_ENABLED,
+	IDXD_CMDSTS_ERR_WQ_SIZE,
+	IDXD_CMDSTS_ERR_WQ_PRIOR,
+	IDXD_CMDSTS_ERR_WQ_MODE,
+	IDXD_CMDSTS_ERR_BOF_EN,
+	IDXD_CMDSTS_ERR_PASID_EN,
+	IDXD_CMDSTS_ERR_MAX_BATCH_SIZE,
+	IDXD_CMDSTS_ERR_MAX_XFER_SIZE,
+	/* disable device errors */
+	IDXD_CMDSTS_ERR_DIS_DEV_EN = 0x31,
+	/* disable WQ, drain WQ, abort WQ, reset WQ */
+	IDXD_CMDSTS_ERR_DEV_NOT_EN,
+	/* request interrupt handle */
+	IDXD_CMDSTS_ERR_INVAL_INT_IDX = 0x41,
+	IDXD_CMDSTS_ERR_NO_HANDLE,
+};
+
+#define IDXD_SWERR_OFFSET		0xc0
+#define IDXD_SWERR_VALID			0x00000001
+#define IDXD_SWERR_OVERFLOW		0x00000002
+#define IDXD_SWERR_ACK			(IDXD_SWERR_VALID | IDXD_SWERR_OVERFLOW)
+union sw_err_reg {
+	struct {
+		u64 valid:1;
+		u64 overflow:1;
+		u64 desc_valid:1;
+		u64 wq_idx_valid:1;
+		u64 batch:1;
+		u64 fault_rw:1;
+		u64 priv:1;
+		u64 rsvd:1;
+		u64 error:8;
+		u64 wq_idx:8;
+		u64 rsvd2:8;
+		u64 operation:8;
+		u64 pasid:20;
+		u64 rsvd3:4;
+
+		u64 batch_idx:16;
+		u64 rsvd4:16;
+		u64 invalid_flags:32;
+
+		u64 fault_addr;
+
+		u64 rsvd5;
+	};
+	u64 bits[4];
+};
+
+union msix_perm {
+	struct {
+		u32 rsvd:2;
+		u32 ignore:1;
+		u32 pasid_en:1;
+		u32 rsvd2:8;
+		u32 pasid:20;
+	};
+	u32 bits;
+};
+
+union group_flags {
+	struct {
+		u32 tc_a:3;
+		u32 tc_b:3;
+		u32 rsvd:1;
+		u32 use_token_limit:1;
+		u32 tokens_reserved:8;
+		u32 rsvd2:4;
+		u32 tokens_allowed:8;
+		u32 rsvd3:4;
+	};
+	u32 bits;
+} __packed;
+
+struct grpcfg {
+	u64 wqs[4];
+	u64 engines;
+	union group_flags flags;
+} __packed;
+
+union wqcfg {
+	struct {
+		/* bytes 0-3 */
+		u16 wq_size;
+		u16 rsvd;
+
+		/* bytes 4-7 */
+		u16 wq_thresh;
+		u16 rsvd1;
+
+		/* bytes 8-11 */
+		u32 mode:1;	/* shared or dedicated */
+		u32 bof:1;	/* block on fault */
+		u32 rsvd2:2;
+		u32 priority:4;
+		u32 pasid:20;
+		u32 pasid_en:1;
+		u32 priv:1;
+		u32 rsvd3:2;
+
+		/* bytes 12-15 */
+		u32 max_xfer_shift:5;
+		u32 max_batch_shift:4;
+		u32 rsvd4:23;
+
+		/* bytes 16-19 */
+		u16 occupancy_inth;
+		u16 occupancy_table_sel:1;
+		u16 rsvd5:15;
+
+		/* bytes 20-23 */
+		u16 occupancy_limit;
+		u16 occupancy_int_en:1;
+		u16 rsvd6:15;
+
+		/* bytes 24-27 */
+		u16 occupancy;
+		u16 occupancy_int:1;
+		u16 rsvd7:12;
+		u16 mode_support:1;
+		u16 wq_state:2;
+
+		/* bytes 28-31 */
+		u32 rsvd8;
+	};
+	u32 bits[8];
+} __packed;
+#endif
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
new file mode 100644
index 000000000000..259424f6d87a
--- /dev/null
+++ b/include/uapi/linux/idxd.h
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
+#ifndef _USR_IDXD_H_
+#define _USR_IDXD_H_
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
+
+/* Descriptor flags */
+#define IDXD_OP_FLAG_FENCE	0x0001
+#define IDXD_OP_FLAG_BOF	0x0002
+#define IDXD_OP_FLAG_CRAV	0x0004
+#define IDXD_OP_FLAG_RCR	0x0008
+#define IDXD_OP_FLAG_RCI	0x0010
+#define IDXD_OP_FLAG_CRSTS	0x0020
+#define IDXD_OP_FLAG_CR		0x0080
+#define IDXD_OP_FLAG_CC		0x0100
+#define IDXD_OP_FLAG_ADDR1_TCS	0x0200
+#define IDXD_OP_FLAG_ADDR2_TCS	0x0400
+#define IDXD_OP_FLAG_ADDR3_TCS	0x0800
+#define IDXD_OP_FLAG_CR_TCS	0x1000
+#define IDXD_OP_FLAG_STORD	0x2000
+#define IDXD_OP_FLAG_DRDBK	0x4000
+#define IDXD_OP_FLAG_DSTS	0x8000
+
+/* Opcode */
+enum dsa_opcode {
+	DSA_OPCODE_NOOP = 0,
+	DSA_OPCODE_BATCH,
+	DSA_OPCODE_DRAIN,
+	DSA_OPCODE_MEMMOVE,
+	DSA_OPCODE_MEMFILL,
+	DSA_OPCODE_COMPARE,
+	DSA_OPCODE_COMPVAL,
+	DSA_OPCODE_CR_DELTA,
+	DSA_OPCODE_AP_DELTA,
+	DSA_OPCODE_DUALCAST,
+	DSA_OPCODE_CRCGEN,
+	DSA_OPCODE_COPY_CRC,
+	DSA_OPCODE_DIF_INS,
+	DSA_OPCODE_DIF_STRP,
+	DSA_OPCODE_DIF_UPDT,
+	DSA_OPCODE_CFLUSH = 0x20,
+};
+
+/* Completion record status */
+enum dsa_completion_status {
+	DSA_COMP_NONE = 0,
+	DSA_COMP_SUCCESS,
+	DSA_COMP_SUCCESS_PRED,
+	DSA_COMP_PAGE_FAULT_NOBOF,
+	DSA_COMP_PAGE_FAULT_IR,
+	DSA_COMP_BATCH_FAIL,
+	DSA_COMP_BATCH_PAGE_FAULT,
+	DSA_COMP_BAD_OPCODE = 0x10,
+	DSA_COMP_INVALID_FLAGS,
+	DSA_COMP_NOZERO_RESERVE,
+	DSA_COMP_XFER_ERANGE,
+	DSA_COMP_DESC_CNT_ERANGE,
+	DSA_COMP_DESCLIST_ALIGN = 0x18,
+	DSA_COMP_INT_HANDLE_INVAL,
+	DSA_COMP_CRA_XLAT,
+	DSA_COMP_CRA_ALIGN,
+	DSA_COMP_ADDR_ALIGN,
+	DSA_COMP_PRIV_BAD,
+	DSA_COMP_HW_ERR1 = 0x20,
+	DSA_COMP_TRANSLATION_FAIL = 0x22,
+};
+
+#define DSA_COMP_STATUS_MASK		0x7f
+#define DSA_COMP_STATUS_WRITE		0x80
+
+struct dsa_batch_desc {
+	uint32_t	pasid:20;
+	uint32_t	rsvd:11;
+	uint32_t	priv:1;
+	uint32_t	flags:24;
+	uint32_t	opcode:8;
+	uint64_t	completion_addr;
+	uint64_t	desc_list_addr;
+	uint64_t	rsvd1;
+	uint32_t	desc_count;
+	uint16_t	interrupt_handle;
+	uint16_t	rsvd2;
+	uint8_t		rsvd3[24];
+} __attribute__((packed));
+
+struct dsa_hw_desc {
+	uint32_t	pasid:20;
+	uint32_t	rsvd:11;
+	uint32_t	priv:1;
+	uint32_t	flags:24;
+	uint32_t	opcode:8;
+	uint64_t	completion_addr;
+	union {
+		uint64_t	src_addr;
+		uint64_t	rdback_addr;
+		uint64_t	pattern;
+	};
+	union {
+		uint64_t	dst_addr;
+		uint64_t	rdback_addr2;
+		uint64_t	src2_addr;
+		uint64_t	comp_pattern;
+	};
+	uint32_t	xfer_size;
+	uint16_t	int_handle;
+	uint16_t	rsvd1;
+	union {
+		uint8_t		expected_res;
+		struct {
+			uint64_t	delta_addr;
+			uint32_t	max_delta_size;
+		};
+		uint32_t	delta_rec_size;
+		uint64_t	dest2;
+		/* CRC */
+		struct {
+			uint32_t	crc_seed;
+			uint32_t	crc_rsvd;
+			uint64_t	seed_addr;
+		};
+		/* DIF check or strip */
+		struct {
+			uint8_t		src_dif_flags;
+			uint8_t		dif_chk_res;
+			uint8_t		dif_chk_flags;
+			uint8_t		dif_chk_res2[5];
+			uint32_t	chk_ref_tag_seed;
+			uint16_t	chk_app_tag_mask;
+			uint16_t	chk_app_tag_seed;
+		};
+		/* DIF insert */
+		struct {
+			uint8_t		dif_ins_res;
+			uint8_t		dest_dif_flag;
+			uint8_t		dif_ins_flags;
+			uint8_t		dif_ins_res2[13];
+			uint32_t	ins_ref_tag_seed;
+			uint16_t	ins_app_tag_mask;
+			uint16_t	ins_app_tag_seed;
+		};
+		/* DIF update */
+		struct {
+			uint8_t		src_upd_flags;
+			uint8_t		upd_dest_flags;
+			uint8_t		dif_upd_flags;
+			uint8_t		dif_upd_res[5];
+			uint32_t	src_ref_tag_seed;
+			uint16_t	src_app_tag_mask;
+			uint16_t	src_app_tag_seed;
+			uint32_t	dest_ref_tag_seed;
+			uint16_t	dest_app_tag_mask;
+			uint16_t	dest_app_tag_seed;
+		};
+
+		uint8_t		op_specific[24];
+	};
+} __attribute__((packed));
+
+struct dsa_raw_desc {
+	uint64_t	field[8];
+} __attribute__((packed));
+
+/*
+ * The status field will be modified by hardware, therefore it should be
+ * volatile and prevent the compiler from optimize the read.
+ */
+struct dsa_completion_record {
+	volatile uint8_t	status;
+	union {
+		uint8_t		result;
+		uint8_t		dif_status;
+	};
+	uint16_t		rsvd;
+	uint32_t		bytes_completed;
+	uint64_t		fault_addr;
+	union {
+		uint16_t	delta_rec_size;
+		uint16_t	crc_val;
+
+		/* DIF check & strip */
+		struct {
+			uint32_t	dif_chk_ref_tag;
+			uint16_t	dif_chk_app_tag_mask;
+			uint16_t	dif_chk_app_tag;
+		};
+
+		/* DIF insert */
+		struct {
+			uint64_t	dif_ins_res;
+			uint32_t	dif_ins_ref_tag;
+			uint16_t	dif_ins_app_tag_mask;
+			uint16_t	dif_ins_app_tag;
+		};
+
+		/* DIF update */
+		struct {
+			uint32_t	dif_upd_src_ref_tag;
+			uint16_t	dif_upd_src_app_tag_mask;
+			uint16_t	dif_upd_src_app_tag;
+			uint32_t	dif_upd_dest_ref_tag;
+			uint16_t	dif_upd_dest_app_tag_mask;
+			uint16_t	dif_upd_dest_app_tag;
+		};
+
+		uint8_t		op_specific[16];
+	};
+} __attribute__((packed));
+
+struct dsa_raw_completion_record {
+	uint64_t	field[4];
+} __attribute__((packed));
+
+#endif

