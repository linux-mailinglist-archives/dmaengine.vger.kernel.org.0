Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D79311314
	for <lists+dmaengine@lfdr.de>; Fri,  5 Feb 2021 22:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhBEVHc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Feb 2021 16:07:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:22064 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233385AbhBETMB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Feb 2021 14:12:01 -0500
IronPort-SDR: tNJdH/V9pm/ch5GT+J8LWVBoG4nfZgXxZW6NUppZ9OVzkCX/4mBfs5FcVeKeXyf2fkhZPD6Mvs
 DL/XE//F7cag==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="177982049"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="177982049"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 12:53:45 -0800
IronPort-SDR: A9H5lm1Sd7i/M1gNhBM3L79kwkWoUYKCEc7Q63pqu+getCM1rq23nqINQo/VKV9hbKa2J3d4dq
 vtBnQGY+FsCQ==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="484459065"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 12:53:44 -0800
Subject: [PATCH v5 08/14] vfio/mdev: idxd: add emulation rw routines
From:   Dave Jiang <dave.jiang@intel.com>
To:     alex.williamson@redhat.com, kwankhede@nvidia.com,
        tglx@linutronix.de, vkoul@kernel.org
Cc:     megha.dey@intel.com, jacob.jun.pan@intel.com, ashok.raj@intel.com,
        jgg@mellanox.com, yi.l.liu@intel.com, baolu.lu@intel.com,
        kevin.tian@intel.com, sanjay.k.kumar@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        eric.auger@redhat.com, parav@mellanox.com, netanelg@mellanox.com,
        shahafs@mellanox.com, pbonzini@redhat.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Date:   Fri, 05 Feb 2021 13:53:44 -0700
Message-ID: <161255842420.339900.2588415689318940385.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <161255810396.339900.7646244556839438765.stgit@djiang5-desk3.ch.intel.com>
References: <161255810396.339900.7646244556839438765.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add emulation routines for PCI config read/write, MMIO read/write, and
interrupt handling routine for the emulated device. The rw routines are
called when PCI config read/writes or BAR0 mmio read/writes and being
issued by the guest kernel through KVM/qemu.

Because we are supporting read-only configuration, most of the MMIO
emulations are simple memory copy except for cases such as handling device
commands and interrupts.

As part of emulation code, add the support code for "1dwq" mdev type.
This mdev type follows the standard VFIO mdev flow. The "1dwq" type will
export a single dedicated wq to the mdev. The dwq will have read-only
configuration that is configured by the host. The mdev type does not
support PASID and SVA and will match the stage 1 driver in functional
support. For backward compatibility, the mdev will maintain the DSA
spec definition of this mdev type once the commit goes upstream.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/registers.h  |   10 +
 drivers/vfio/mdev/idxd/vdev.c |  456 ++++++++++++++++++++++++++++++++++++++++-
 drivers/vfio/mdev/idxd/vdev.h |    8 +
 include/uapi/linux/idxd.h     |    2 
 4 files changed, 468 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index d9a732decdd5..50ea94259c99 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -195,7 +195,8 @@ union cmdsts_reg {
 	};
 	u32 bits;
 } __packed;
-#define IDXD_CMDSTS_ACTIVE		0x80000000
+#define IDXD_CMDS_ACTIVE_BIT		31
+#define IDXD_CMDSTS_ACTIVE		BIT(IDXD_CMDS_ACTIVE_BIT)
 #define IDXD_CMDSTS_ERR_MASK		0xff
 #define IDXD_CMDSTS_RES_SHIFT		8
 
@@ -278,6 +279,11 @@ union msix_perm {
 	u32 bits;
 } __packed;
 
+#define IDXD_MSIX_PERM_MASK	0xfffff00c
+#define IDXD_MSIX_PERM_IGNORE	0x3
+#define MSIX_ENTRY_MASK_INT	0x1
+#define MSIX_ENTRY_CTRL_BYTE	12
+
 union group_flags {
 	struct {
 		u32 tc_a:3;
@@ -349,6 +355,8 @@ union wqcfg {
 
 #define WQCFG_PASID_IDX		2
 #define WQCFG_PRIV_IDX		2
+#define WQCFG_MODE_DEDICATED	1
+#define WQCFG_MODE_SHARED	0
 
 /*
  * This macro calculates the offset into the WQCFG register
diff --git a/drivers/vfio/mdev/idxd/vdev.c b/drivers/vfio/mdev/idxd/vdev.c
index 766753a2ec53..958b09987e5c 100644
--- a/drivers/vfio/mdev/idxd/vdev.c
+++ b/drivers/vfio/mdev/idxd/vdev.c
@@ -25,35 +25,472 @@
 
 int vidxd_send_interrupt(struct ims_irq_entry *iie)
 {
-	/* PLACE HOLDER */
+	struct vdcm_idxd *vidxd = iie->vidxd;
+	struct device *dev = &vidxd->idxd->pdev->dev;
+	int rc;
+
+	dev_dbg(dev, "%s interrput %d\n", __func__, iie->id);
+
+	if (!vidxd->vdev.msix_trigger[iie->id]) {
+		dev_warn(dev, "%s: intr eventfd not found %d\n", __func__, iie->id);
+		return -EINVAL;
+	}
+
+	rc = eventfd_signal(vidxd->vdev.msix_trigger[iie->id], 1);
+	if (rc != 1)
+		dev_err(dev, "eventfd signal failed: %d on wq(%d) vector(%d)\n",
+			vidxd->wq->id, iie->id, rc);
+	else
+		dev_dbg(dev, "vidxd interrupt triggered wq(%d) %d\n", vidxd->wq->id, iie->id);
+
+	return rc;
+}
+
+static void vidxd_report_error(struct vdcm_idxd *vidxd, unsigned int error)
+{
+	u8 *bar0 = vidxd->bar0;
+	union sw_err_reg *swerr = (union sw_err_reg *)(bar0 + IDXD_SWERR_OFFSET);
+	union genctrl_reg *genctrl;
+	bool send = false;
+
+	if (!swerr->valid) {
+		memset(swerr, 0, sizeof(*swerr));
+		swerr->valid = 1;
+		swerr->error = error;
+		send = true;
+	} else if (swerr->valid && !swerr->overflow) {
+		swerr->overflow = 1;
+	}
+
+	genctrl = (union genctrl_reg *)(bar0 + IDXD_GENCTRL_OFFSET);
+	if (send && genctrl->softerr_int_en) {
+		u32 *intcause = (u32 *)(bar0 + IDXD_INTCAUSE_OFFSET);
+
+		*intcause |= IDXD_INTC_ERR;
+		vidxd_send_interrupt(&vidxd->irq_entries[0]);
+	}
+}
+
+int vidxd_mmio_write(struct vdcm_idxd *vidxd, u64 pos, void *buf, unsigned int size)
+{
+	u32 offset = pos & (vidxd->bar_size[0] - 1);
+	u8 *bar0 = vidxd->bar0;
+	struct device *dev = mdev_dev(vidxd->vdev.mdev);
+
+	dev_dbg(dev, "vidxd mmio W %d %x %x: %llx\n", vidxd->wq->id, size,
+		offset, get_reg_val(buf, size));
+
+	if (((size & (size - 1)) != 0) || (offset & (size - 1)) != 0)
+		return -EINVAL;
+
+	/* If we don't limit this, we potentially can write out of bound */
+	if (size > sizeof(u32))
+		return -EINVAL;
+
+	switch (offset) {
+	case IDXD_GENCFG_OFFSET ... IDXD_GENCFG_OFFSET + 3:
+		/* Write only when device is disabled. */
+		if (vidxd_state(vidxd) == IDXD_DEVICE_STATE_DISABLED)
+			memcpy(bar0 + offset, buf, size);
+		break;
+
+	case IDXD_GENCTRL_OFFSET:
+		memcpy(bar0 + offset, buf, size);
+		break;
+
+	case IDXD_INTCAUSE_OFFSET:
+		bar0[offset] &= ~(get_reg_val(buf, 1) & GENMASK(4, 0));
+		break;
+
+	case IDXD_CMD_OFFSET: {
+		u32 *cmdsts = (u32 *)(bar0 + IDXD_CMDSTS_OFFSET);
+		u32 val = get_reg_val(buf, size);
+
+		if (size != sizeof(u32))
+			return -EINVAL;
+
+		/* Check and set command in progress */
+		if (test_and_set_bit(IDXD_CMDS_ACTIVE_BIT, (unsigned long *)cmdsts) == 0)
+			vidxd_do_command(vidxd, val);
+		else
+			vidxd_report_error(vidxd, DSA_ERR_CMD_REG);
+		break;
+	}
+
+	case IDXD_SWERR_OFFSET:
+		/* W1C */
+		bar0[offset] &= ~(get_reg_val(buf, 1) & GENMASK(1, 0));
+		break;
+
+	case VIDXD_WQCFG_OFFSET ... VIDXD_WQCFG_OFFSET + VIDXD_WQ_CTRL_SZ - 1:
+	case VIDXD_GRPCFG_OFFSET ...  VIDXD_GRPCFG_OFFSET + VIDXD_GRP_CTRL_SZ - 1:
+		/* Nothing is written. Should be all RO */
+		break;
+
+	case VIDXD_MSIX_TABLE_OFFSET ...  VIDXD_MSIX_TABLE_OFFSET + VIDXD_MSIX_TBL_SZ - 1: {
+		int index = (offset - VIDXD_MSIX_TABLE_OFFSET) / 0x10;
+		u8 *msix_entry = &bar0[VIDXD_MSIX_TABLE_OFFSET + index * 0x10];
+		u64 *pba = (u64 *)(bar0 + VIDXD_MSIX_PBA_OFFSET);
+		u8 ctrl;
+
+		ctrl = msix_entry[MSIX_ENTRY_CTRL_BYTE];
+		memcpy(bar0 + offset, buf, size);
+		/* Handle clearing of UNMASK bit */
+		if (!(msix_entry[MSIX_ENTRY_CTRL_BYTE] & MSIX_ENTRY_MASK_INT) &&
+		    ctrl & MSIX_ENTRY_MASK_INT)
+			if (test_and_clear_bit(index, (unsigned long *)pba))
+				vidxd_send_interrupt(&vidxd->irq_entries[index]);
+		break;
+	}
+
+	case VIDXD_MSIX_PERM_OFFSET ...  VIDXD_MSIX_PERM_OFFSET + VIDXD_MSIX_PERM_TBL_SZ - 1:
+		memcpy(bar0 + offset, buf, size);
+		break;
+	} /* offset */
+
 	return 0;
 }
 
 int vidxd_mmio_read(struct vdcm_idxd *vidxd, u64 pos, void *buf, unsigned int size)
 {
-	/* PLACEHOLDER */
+	u32 offset = pos & (vidxd->bar_size[0] - 1);
+	struct device *dev = mdev_dev(vidxd->vdev.mdev);
+
+	memcpy(buf, vidxd->bar0 + offset, size);
+
+	dev_dbg(dev, "vidxd mmio R %d %x %x: %llx\n",
+		vidxd->wq->id, size, offset, get_reg_val(buf, size));
 	return 0;
 }
 
-int vidxd_mmio_write(struct vdcm_idxd *vidxd, u64 pos, void *buf, unsigned int size)
+int vidxd_cfg_read(struct vdcm_idxd *vidxd, unsigned int pos, void *buf, unsigned int count)
 {
-	/* PLACEHOLDER */
+	u32 offset = pos & 0xfff;
+	struct device *dev = mdev_dev(vidxd->vdev.mdev);
+
+	memcpy(buf, &vidxd->cfg[offset], count);
+
+	dev_dbg(dev, "vidxd pci R %d %x %x: %llx\n",
+		vidxd->wq->id, count, offset, get_reg_val(buf, count));
+
 	return 0;
 }
 
-int vidxd_cfg_read(struct vdcm_idxd *vidxd, unsigned int pos, void *buf, unsigned int count)
+/*
+ * Much of the emulation code has been borrowed from Intel i915 cfg space
+ * emulation code.
+ * drivers/gpu/drm/i915/gvt/cfg_space.c:
+ */
+
+/*
+ * Bitmap for writable bits (RW or RW1C bits, but cannot co-exist in one
+ * byte) byte by byte in standard pci configuration space. (not the full
+ * 256 bytes.)
+ */
+static const u8 pci_cfg_space_rw_bmp[PCI_INTERRUPT_LINE + 4] = {
+	[PCI_COMMAND]		= 0xff, 0x07,
+	[PCI_STATUS]		= 0x00, 0xf9, /* the only one RW1C byte */
+	[PCI_CACHE_LINE_SIZE]	= 0xff,
+	[PCI_BASE_ADDRESS_0 ... PCI_CARDBUS_CIS - 1] = 0xff,
+	[PCI_ROM_ADDRESS]	= 0x01, 0xf8, 0xff, 0xff,
+	[PCI_INTERRUPT_LINE]	= 0xff,
+};
+
+static void _pci_cfg_mem_write(struct vdcm_idxd *vidxd, unsigned int off, u8 *src,
+			       unsigned int bytes)
 {
-	/* PLACEHOLDER */
+	u8 *cfg_base = vidxd->cfg;
+	u8 mask, new, old;
+	int i = 0;
+
+	for (; i < bytes && (off + i < sizeof(pci_cfg_space_rw_bmp)); i++) {
+		mask = pci_cfg_space_rw_bmp[off + i];
+		old = cfg_base[off + i];
+		new = src[i] & mask;
+
+		/**
+		 * The PCI_STATUS high byte has RW1C bits, here
+		 * emulates clear by writing 1 for these bits.
+		 * Writing a 0b to RW1C bits has no effect.
+		 */
+		if (off + i == PCI_STATUS + 1)
+			new = (~new & old) & mask;
+
+		cfg_base[off + i] = (old & ~mask) | new;
+	}
+
+	/* For other configuration space directly copy as it is. */
+	if (i < bytes)
+		memcpy(cfg_base + off + i, src + i, bytes - i);
+}
+
+static inline void _write_pci_bar(struct vdcm_idxd *vidxd, u32 offset, u32 val, bool low)
+{
+	u32 *pval;
+
+	/* BAR offset should be 32 bits algiend */
+	offset = rounddown(offset, 4);
+	pval = (u32 *)(vidxd->cfg + offset);
+
+	if (low) {
+		/*
+		 * only update bit 31 - bit 4,
+		 * leave the bit 3 - bit 0 unchanged.
+		 */
+		*pval = (val & GENMASK(31, 4)) | (*pval & GENMASK(3, 0));
+	} else {
+		*pval = val;
+	}
+}
+
+static int _pci_cfg_bar_write(struct vdcm_idxd *vidxd, unsigned int offset, void *p_data,
+			      unsigned int bytes)
+{
+	u32 new = *(u32 *)(p_data);
+	bool lo = IS_ALIGNED(offset, 8);
+	u64 size;
+	unsigned int bar_id;
+
+	/*
+	 * Power-up software can determine how much address
+	 * space the device requires by writing a value of
+	 * all 1's to the register and then reading the value
+	 * back. The device will return 0's in all don't-care
+	 * address bits.
+	 */
+	if (new == 0xffffffff) {
+		switch (offset) {
+		case PCI_BASE_ADDRESS_0:
+		case PCI_BASE_ADDRESS_1:
+		case PCI_BASE_ADDRESS_2:
+		case PCI_BASE_ADDRESS_3:
+			bar_id = (offset - PCI_BASE_ADDRESS_0) / 8;
+			size = vidxd->bar_size[bar_id];
+			_write_pci_bar(vidxd, offset, size >> (lo ? 0 : 32), lo);
+			break;
+		default:
+			/* Unimplemented BARs */
+			_write_pci_bar(vidxd, offset, 0x0, false);
+		}
+	} else {
+		switch (offset) {
+		case PCI_BASE_ADDRESS_0:
+		case PCI_BASE_ADDRESS_1:
+		case PCI_BASE_ADDRESS_2:
+		case PCI_BASE_ADDRESS_3:
+			_write_pci_bar(vidxd, offset, new, lo);
+			break;
+		default:
+			break;
+		}
+	}
 	return 0;
 }
 
 int vidxd_cfg_write(struct vdcm_idxd *vidxd, unsigned int pos, void *buf, unsigned int size)
 {
-	/* PLACEHOLDER */
+	struct device *dev = &vidxd->idxd->pdev->dev;
+
+	if (size > 4)
+		return -EINVAL;
+
+	if (pos + size > VIDXD_MAX_CFG_SPACE_SZ)
+		return -EINVAL;
+
+	dev_dbg(dev, "vidxd pci W %d %x %x: %llx\n", vidxd->wq->id, size, pos,
+		get_reg_val(buf, size));
+
+	/* First check if it's PCI_COMMAND */
+	if (IS_ALIGNED(pos, 2) && pos == PCI_COMMAND) {
+		bool new_bme;
+		bool bme;
+
+		if (size > 2)
+			return -EINVAL;
+
+		new_bme = !!(get_reg_val(buf, 2) & PCI_COMMAND_MASTER);
+		bme = !!(vidxd->cfg[pos] & PCI_COMMAND_MASTER);
+		_pci_cfg_mem_write(vidxd, pos, buf, size);
+
+		/* Flag error if turning off BME while device is enabled */
+		if ((bme && !new_bme) && vidxd_state(vidxd) == IDXD_DEVICE_STATE_ENABLED)
+			vidxd_report_error(vidxd, DSA_ERR_PCI_CFG);
+		return 0;
+	}
+
+	switch (pos) {
+	case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_5:
+		if (!IS_ALIGNED(pos, 4))
+			return -EINVAL;
+		return _pci_cfg_bar_write(vidxd, pos, buf, size);
+
+	default:
+		_pci_cfg_mem_write(vidxd, pos, buf, size);
+	}
 	return 0;
 }
 
+static void vidxd_mmio_init_grpcap(struct vdcm_idxd *vidxd)
+{
+	u8 *bar0 = vidxd->bar0;
+	union group_cap_reg *grp_cap = (union group_cap_reg *)(bar0 + IDXD_GRPCAP_OFFSET);
+
+	/* single group for current implementation */
+	grp_cap->token_en = 0;
+	grp_cap->token_limit = 0;
+	grp_cap->total_tokens = 0;
+	grp_cap->num_groups = 1;
+}
+
+static void vidxd_mmio_init_grpcfg(struct vdcm_idxd *vidxd)
+{
+	u8 *bar0 = vidxd->bar0;
+	struct grpcfg *grpcfg = (struct grpcfg *)(bar0 + VIDXD_GRPCFG_OFFSET);
+	struct idxd_wq *wq = vidxd->wq;
+	struct idxd_group *group = wq->group;
+	int i;
+
+	/*
+	 * At this point, we are only exporting a single workqueue for
+	 * each mdev. So we need to just fake it as first workqueue
+	 * and also mark the available engines in this group.
+	 */
+
+	/* Set single workqueue and the first one */
+	grpcfg->wqs[0] = BIT(0);
+	grpcfg->engines = 0;
+	for (i = 0; i < group->num_engines; i++)
+		grpcfg->engines |= BIT(i);
+	grpcfg->flags.bits = group->grpcfg.flags.bits;
+}
+
+static void vidxd_mmio_init_wqcap(struct vdcm_idxd *vidxd)
+{
+	u8 *bar0 = vidxd->bar0;
+	struct idxd_wq *wq = vidxd->wq;
+	union wq_cap_reg *wq_cap = (union wq_cap_reg *)(bar0 + IDXD_WQCAP_OFFSET);
+
+	wq_cap->occupancy_int = 0;
+	wq_cap->occupancy = 0;
+	wq_cap->priority = 0;
+	wq_cap->total_wq_size = wq->size;
+	wq_cap->num_wqs = VIDXD_MAX_WQS;
+	wq_cap->wq_ats_support = 0;
+	wq_cap->dedicated_mode = 1;
+	wq_cap->shared_mode = 0;
+}
+
+static void vidxd_mmio_init_wqcfg(struct vdcm_idxd *vidxd)
+{
+	struct idxd_device *idxd = vidxd->idxd;
+	struct idxd_wq *wq = vidxd->wq;
+	u8 *bar0 = vidxd->bar0;
+	union wqcfg *wqcfg = (union wqcfg *)(bar0 + VIDXD_WQCFG_OFFSET);
+
+	wqcfg->wq_size = wq->size;
+	wqcfg->wq_thresh = wq->threshold;
+
+	wqcfg->mode = WQCFG_MODE_DEDICATED;
+
+	wqcfg->bof = 0;
+
+	wqcfg->priority = wq->priority;
+	wqcfg->max_xfer_shift = idxd->hw.gen_cap.max_xfer_shift;
+	wqcfg->max_batch_shift = idxd->hw.gen_cap.max_batch_shift;
+	/* make mode change read-only */
+	wqcfg->mode_support = 0;
+}
+
+static void vidxd_mmio_init_engcap(struct vdcm_idxd *vidxd)
+{
+	u8 *bar0 = vidxd->bar0;
+	union engine_cap_reg *engcap = (union engine_cap_reg *)(bar0 + IDXD_ENGCAP_OFFSET);
+	struct idxd_wq *wq = vidxd->wq;
+	struct idxd_group *group = wq->group;
+
+	engcap->num_engines = group->num_engines;
+}
+
+static void vidxd_mmio_init_gencap(struct vdcm_idxd *vidxd)
+{
+	struct idxd_device *idxd = vidxd->idxd;
+	u8 *bar0 = vidxd->bar0;
+	union gen_cap_reg *gencap = (union gen_cap_reg *)(bar0 + IDXD_GENCAP_OFFSET);
+
+	gencap->bits = idxd->hw.gen_cap.bits;
+	gencap->config_en = 0;
+	gencap->max_ims_mult = 0;
+	gencap->cmd_cap = 1;
+	gencap->block_on_fault = 0;
+}
+
+static void vidxd_mmio_init_cmdcap(struct vdcm_idxd *vidxd)
+{
+	struct idxd_device *idxd = vidxd->idxd;
+	u8 *bar0 = vidxd->bar0;
+	u32 *cmdcap = (u32 *)(bar0 + IDXD_CMDCAP_OFFSET);
+
+	if (idxd->hw.cmd_cap)
+		*cmdcap = idxd->hw.cmd_cap;
+	else
+		*cmdcap = 0x1ffe;
+
+	*cmdcap |= BIT(IDXD_CMD_REQUEST_INT_HANDLE) | BIT(IDXD_CMD_RELEASE_INT_HANDLE);
+}
+
+static void vidxd_mmio_init_opcap(struct vdcm_idxd *vidxd)
+{
+	u64 opcode;
+	u8 *bar0 = vidxd->bar0;
+	u64 *opcap = (u64 *)(bar0 + IDXD_OPCAP_OFFSET);
+
+	opcode = BIT_ULL(DSA_OPCODE_NOOP) | BIT_ULL(DSA_OPCODE_BATCH) |
+		 BIT_ULL(DSA_OPCODE_DRAIN) | BIT_ULL(DSA_OPCODE_MEMMOVE) |
+		 BIT_ULL(DSA_OPCODE_MEMFILL) | BIT_ULL(DSA_OPCODE_COMPARE) |
+		 BIT_ULL(DSA_OPCODE_COMPVAL) | BIT_ULL(DSA_OPCODE_CR_DELTA) |
+		 BIT_ULL(DSA_OPCODE_AP_DELTA) | BIT_ULL(DSA_OPCODE_DUALCAST) |
+		 BIT_ULL(DSA_OPCODE_CRCGEN) | BIT_ULL(DSA_OPCODE_COPY_CRC) |
+		 BIT_ULL(DSA_OPCODE_DIF_CHECK) | BIT_ULL(DSA_OPCODE_DIF_INS) |
+		 BIT_ULL(DSA_OPCODE_DIF_STRP) | BIT_ULL(DSA_OPCODE_DIF_UPDT) |
+		 BIT_ULL(DSA_OPCODE_CFLUSH);
+	*opcap = opcode;
+}
+
+static void vidxd_mmio_init_version(struct vdcm_idxd *vidxd)
+{
+	struct idxd_device *idxd = vidxd->idxd;
+	u32 *version;
+
+	version = (u32 *)vidxd->bar0;
+	*version = idxd->hw.version;
+}
+
 void vidxd_mmio_init(struct vdcm_idxd *vidxd)
+{
+	u8 *bar0 = vidxd->bar0;
+	union offsets_reg *offsets;
+
+	memset(vidxd->bar0, 0, VIDXD_BAR0_SIZE);
+
+	vidxd_mmio_init_version(vidxd);
+	vidxd_mmio_init_gencap(vidxd);
+	vidxd_mmio_init_wqcap(vidxd);
+	vidxd_mmio_init_grpcap(vidxd);
+	vidxd_mmio_init_engcap(vidxd);
+	vidxd_mmio_init_opcap(vidxd);
+
+	offsets = (union offsets_reg *)(bar0 + IDXD_TABLE_OFFSET);
+	offsets->grpcfg = VIDXD_GRPCFG_OFFSET / 0x100;
+	offsets->wqcfg = VIDXD_WQCFG_OFFSET / 0x100;
+	offsets->msix_perm = VIDXD_MSIX_PERM_OFFSET / 0x100;
+
+	vidxd_mmio_init_cmdcap(vidxd);
+	memset(bar0 + VIDXD_MSIX_PERM_OFFSET, 0, VIDXD_MSIX_PERM_TBL_SZ);
+	vidxd_mmio_init_grpcfg(vidxd);
+	vidxd_mmio_init_wqcfg(vidxd);
+}
+
+static void idxd_complete_command(struct vdcm_idxd *vidxd, enum idxd_cmdsts_err val)
 {
 	/* PLACEHOLDER */
 }
@@ -63,6 +500,11 @@ void vidxd_reset(struct vdcm_idxd *vidxd)
 	/* PLACEHOLDER */
 }
 
+void vidxd_do_command(struct vdcm_idxd *vidxd, u32 val)
+{
+	/* PLACEHOLDER */
+}
+
 int vidxd_setup_ims_entries(struct vdcm_idxd *vidxd)
 {
 	/* PLACEHOLDER */
diff --git a/drivers/vfio/mdev/idxd/vdev.h b/drivers/vfio/mdev/idxd/vdev.h
index cc2ba6ccff7b..fc0f405baa40 100644
--- a/drivers/vfio/mdev/idxd/vdev.h
+++ b/drivers/vfio/mdev/idxd/vdev.h
@@ -6,6 +6,13 @@
 
 #include "mdev.h"
 
+static inline u8 vidxd_state(struct vdcm_idxd *vidxd)
+{
+	union gensts_reg *gensts = (union gensts_reg *)(vidxd->bar0 + IDXD_GENSTATS_OFFSET);
+
+	return gensts->state;
+}
+
 int vidxd_mmio_read(struct vdcm_idxd *vidxd, u64 pos, void *buf, unsigned int size);
 int vidxd_mmio_write(struct vdcm_idxd *vidxd, u64 pos, void *buf, unsigned int size);
 int vidxd_cfg_read(struct vdcm_idxd *vidxd, unsigned int pos, void *buf, unsigned int count);
@@ -15,5 +22,6 @@ void vidxd_reset(struct vdcm_idxd *vidxd);
 int vidxd_send_interrupt(struct ims_irq_entry *iie);
 int vidxd_setup_ims_entries(struct vdcm_idxd *vidxd);
 void vidxd_free_ims_entries(struct vdcm_idxd *vidxd);
+void vidxd_do_command(struct vdcm_idxd *vidxd, u32 val);
 
 #endif
diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 236d437947bc..22d1b229a912 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -89,6 +89,8 @@ enum dsa_completion_status {
 	DSA_COMP_HW_ERR1,
 	DSA_COMP_HW_ERR_DRB,
 	DSA_COMP_TRANSLATION_FAIL,
+	DSA_ERR_PCI_CFG = 0x51,
+	DSA_ERR_CMD_REG,
 };
 
 enum iax_completion_status {


