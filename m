Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390A429A4F0
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 07:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504391AbgJ0GzX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 02:55:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:42071 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504346AbgJ0GzX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 02:55:23 -0400
IronPort-SDR: l985djO0tEgJoxvhFDOurzeQZDDpIjiidRTlOW0GWXkKowbrw3gMr8ER+oCxyG5yiil3Tg/uVs
 hOOWG4DOw5LQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155004141"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="155004141"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:55:22 -0700
IronPort-SDR: MEJKfwUWHdyVsISU+HjTG8jwFkiaPdJZGrKwJ2JTyIj7gtUssdMIVC1GCcjDyeD8fe4VJQP8K6
 emmPJFfdNqVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="350175841"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2020 23:55:21 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/15] dmaengine: dw-axi-dmac: simplify descriptor management
Date:   Tue, 27 Oct 2020 14:38:45 +0800
Message-Id: <20201027063858.4877-3-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201027063858.4877-1-jee.heng.sia@intel.com>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Simplify and refactor the descriptor management by removing the redundant
Linked List Item (LLI) queue control logic from the AxiDMA driver.
The descriptor is split into virtual descriptor and hardware LLI so that
only hardware LLI memories are allocated from the DMA memory pool.

Up to 64 descriptors can be allocated within a PAGE_SIZE compare to 16
descriptors in previous version. This solves the problem where an
ALSA driver expects more than 16 DMA descriptors to run.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 164 ++++++++++--------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   9 +-
 2 files changed, 102 insertions(+), 71 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 14c1ac26f866..8cfd645479e1 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 
 #include "dw-axi-dmac.h"
@@ -195,43 +196,58 @@ static inline const char *axi_chan_name(struct axi_dma_chan *chan)
 	return dma_chan_name(&chan->vc.chan);
 }
 
-static struct axi_dma_desc *axi_desc_get(struct axi_dma_chan *chan)
+static struct axi_dma_desc *axi_desc_alloc(u32 num)
 {
-	struct dw_axi_dma *dw = chan->chip->dw;
 	struct axi_dma_desc *desc;
+
+	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	desc->hw_desc = kcalloc(num, sizeof(*desc->hw_desc), GFP_NOWAIT);
+	if (!desc->hw_desc) {
+		kfree(desc);
+		return NULL;
+	}
+
+	return desc;
+}
+
+static struct axi_dma_lli *axi_desc_get(struct axi_dma_chan *chan,
+					dma_addr_t *addr)
+{
+	struct dw_axi_dma *dw = chan->chip->dw;
+	struct axi_dma_lli *lli;
 	dma_addr_t phys;
 
-	desc = dma_pool_zalloc(dw->desc_pool, GFP_NOWAIT, &phys);
-	if (unlikely(!desc)) {
+	lli = dma_pool_zalloc(dw->desc_pool, GFP_NOWAIT, &phys);
+	if (unlikely(!lli)) {
 		dev_err(chan2dev(chan), "%s: not enough descriptors available\n",
 			axi_chan_name(chan));
 		return NULL;
 	}
 
 	atomic_inc(&chan->descs_allocated);
-	INIT_LIST_HEAD(&desc->xfer_list);
-	desc->vd.tx.phys = phys;
-	desc->chan = chan;
+	*addr = phys;
 
-	return desc;
+	return lli;
 }
 
 static void axi_desc_put(struct axi_dma_desc *desc)
 {
 	struct axi_dma_chan *chan = desc->chan;
 	struct dw_axi_dma *dw = chan->chip->dw;
-	struct axi_dma_desc *child, *_next;
-	unsigned int descs_put = 0;
+	int count = atomic_read(&chan->descs_allocated);
+	struct axi_dma_hw_desc *hw_desc;
+	int descs_put;
 
-	list_for_each_entry_safe(child, _next, &desc->xfer_list, xfer_list) {
-		list_del(&child->xfer_list);
-		dma_pool_free(dw->desc_pool, child, child->vd.tx.phys);
-		descs_put++;
+	for (descs_put = 0; descs_put < count; descs_put++) {
+		hw_desc = &desc->hw_desc[descs_put];
+		dma_pool_free(dw->desc_pool, hw_desc->lli, hw_desc->llp);
 	}
 
-	dma_pool_free(dw->desc_pool, desc, desc->vd.tx.phys);
-	descs_put++;
-
+	kfree(desc->hw_desc);
+	kfree(desc);
 	atomic_sub(descs_put, &chan->descs_allocated);
 	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
 		axi_chan_name(chan), descs_put,
@@ -258,9 +274,9 @@ dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	return ret;
 }
 
-static void write_desc_llp(struct axi_dma_desc *desc, dma_addr_t adr)
+static void write_desc_llp(struct axi_dma_hw_desc *desc, dma_addr_t adr)
 {
-	desc->lli.llp = cpu_to_le64(adr);
+	desc->lli->llp = cpu_to_le64(adr);
 }
 
 static void write_chan_llp(struct axi_dma_chan *chan, dma_addr_t adr)
@@ -295,7 +311,7 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	       DWAXIDMAC_HS_SEL_HW << CH_CFG_H_HS_SEL_SRC_POS);
 	axi_chan_iowrite32(chan, CH_CFG_H, reg);
 
-	write_chan_llp(chan, first->vd.tx.phys | lms);
+	write_chan_llp(chan, first->hw_desc[0].llp | lms);
 
 	irq_mask = DWAXIDMAC_IRQ_DMA_TRF | DWAXIDMAC_IRQ_ALL_ERR;
 	axi_chan_irq_sig_set(chan, irq_mask);
@@ -378,67 +394,78 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
  * transfer and completes the DMA transfer operation at the end of current
  * block transfer.
  */
-static void set_desc_last(struct axi_dma_desc *desc)
+static void set_desc_last(struct axi_dma_hw_desc *desc)
 {
 	u32 val;
 
-	val = le32_to_cpu(desc->lli.ctl_hi);
+	val = le32_to_cpu(desc->lli->ctl_hi);
 	val |= CH_CTL_H_LLI_LAST;
-	desc->lli.ctl_hi = cpu_to_le32(val);
+	desc->lli->ctl_hi = cpu_to_le32(val);
 }
 
-static void write_desc_sar(struct axi_dma_desc *desc, dma_addr_t adr)
+static void write_desc_sar(struct axi_dma_hw_desc *desc, dma_addr_t adr)
 {
-	desc->lli.sar = cpu_to_le64(adr);
+	desc->lli->sar = cpu_to_le64(adr);
 }
 
-static void write_desc_dar(struct axi_dma_desc *desc, dma_addr_t adr)
+static void write_desc_dar(struct axi_dma_hw_desc *desc, dma_addr_t adr)
 {
-	desc->lli.dar = cpu_to_le64(adr);
+	desc->lli->dar = cpu_to_le64(adr);
 }
 
-static void set_desc_src_master(struct axi_dma_desc *desc)
+static void set_desc_src_master(struct axi_dma_hw_desc *desc)
 {
 	u32 val;
 
 	/* Select AXI0 for source master */
-	val = le32_to_cpu(desc->lli.ctl_lo);
+	val = le32_to_cpu(desc->lli->ctl_lo);
 	val &= ~CH_CTL_L_SRC_MAST;
-	desc->lli.ctl_lo = cpu_to_le32(val);
+	desc->lli->ctl_lo = cpu_to_le32(val);
 }
 
-static void set_desc_dest_master(struct axi_dma_desc *desc)
+static void set_desc_dest_master(struct axi_dma_hw_desc *hw_desc,
+				 struct axi_dma_desc *desc)
 {
 	u32 val;
 
 	/* Select AXI1 for source master if available */
-	val = le32_to_cpu(desc->lli.ctl_lo);
+	val = le32_to_cpu(hw_desc->lli->ctl_lo);
 	if (desc->chan->chip->dw->hdata->nr_masters > 1)
 		val |= CH_CTL_L_DST_MAST;
 	else
 		val &= ~CH_CTL_L_DST_MAST;
 
-	desc->lli.ctl_lo = cpu_to_le32(val);
+	hw_desc->lli->ctl_lo = cpu_to_le32(val);
 }
 
 static struct dma_async_tx_descriptor *
 dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 			 dma_addr_t src_adr, size_t len, unsigned long flags)
 {
-	struct axi_dma_desc *first = NULL, *desc = NULL, *prev = NULL;
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	size_t block_ts, max_block_ts, xfer_len;
-	u32 xfer_width, reg;
+	struct axi_dma_hw_desc *hw_desc = NULL;
+	struct axi_dma_desc *desc = NULL;
+	u32 xfer_width, reg, num;
+	u64 llp = 0;
 	u8 lms = 0; /* Select AXI0 master for LLI fetching */
 
 	dev_dbg(chan2dev(chan), "%s: memcpy: src: %pad dst: %pad length: %zd flags: %#lx",
 		axi_chan_name(chan), &src_adr, &dst_adr, len, flags);
 
 	max_block_ts = chan->chip->dw->hdata->block_size[chan->id];
+	xfer_width = axi_chan_get_xfer_width(chan, src_adr, dst_adr, len);
+	num = DIV_ROUND_UP(len, max_block_ts << xfer_width);
+	desc = axi_desc_alloc(num);
+	if (unlikely(!desc))
+		goto err_desc_get;
 
+	desc->chan = chan;
+	num = 0;
 	while (len) {
 		xfer_len = len;
 
+		hw_desc = &desc->hw_desc[num];
 		/*
 		 * Take care for the alignment.
 		 * Actually source and destination widths can be different, but
@@ -457,13 +484,13 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 			xfer_len = max_block_ts << xfer_width;
 		}
 
-		desc = axi_desc_get(chan);
-		if (unlikely(!desc))
+		hw_desc->lli = axi_desc_get(chan, &hw_desc->llp);
+		if (unlikely(!hw_desc->lli))
 			goto err_desc_get;
 
-		write_desc_sar(desc, src_adr);
-		write_desc_dar(desc, dst_adr);
-		desc->lli.block_ts_lo = cpu_to_le32(block_ts - 1);
+		write_desc_sar(hw_desc, src_adr);
+		write_desc_dar(hw_desc, dst_adr);
+		hw_desc->lli->block_ts_lo = cpu_to_le32(block_ts - 1);
 
 		reg = CH_CTL_H_LLI_VALID;
 		if (chan->chip->dw->hdata->restrict_axi_burst_len) {
@@ -474,7 +501,7 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 				CH_CTL_H_AWLEN_EN |
 				burst_len << CH_CTL_H_AWLEN_POS);
 		}
-		desc->lli.ctl_hi = cpu_to_le32(reg);
+		hw_desc->lli->ctl_hi = cpu_to_le32(reg);
 
 		reg = (DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
 		       DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS |
@@ -482,62 +509,61 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 		       xfer_width << CH_CTL_L_SRC_WIDTH_POS |
 		       DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS |
 		       DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS);
-		desc->lli.ctl_lo = cpu_to_le32(reg);
+		hw_desc->lli->ctl_lo = cpu_to_le32(reg);
 
-		set_desc_src_master(desc);
-		set_desc_dest_master(desc);
+		set_desc_src_master(hw_desc);
+		set_desc_dest_master(hw_desc, desc);
 
-		/* Manage transfer list (xfer_list) */
-		if (!first) {
-			first = desc;
-		} else {
-			list_add_tail(&desc->xfer_list, &first->xfer_list);
-			write_desc_llp(prev, desc->vd.tx.phys | lms);
-		}
-		prev = desc;
 
 		/* update the length and addresses for the next loop cycle */
 		len -= xfer_len;
 		dst_adr += xfer_len;
 		src_adr += xfer_len;
+		num++;
 	}
 
 	/* Total len of src/dest sg == 0, so no descriptor were allocated */
-	if (unlikely(!first))
+	if (unlikely(!desc))
 		return NULL;
 
 	/* Set end-of-link to the last link descriptor of list */
-	set_desc_last(desc);
+	set_desc_last(&desc->hw_desc[num - 1]);
+	/* Managed transfer list */
+	do {
+		hw_desc = &desc->hw_desc[--num];
+		write_desc_llp(hw_desc, llp | lms);
+		llp = hw_desc->llp;
+	} while (num);
 
-	return vchan_tx_prep(&chan->vc, &first->vd, flags);
+	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
 
 err_desc_get:
-	if (first)
-		axi_desc_put(first);
+	if (desc)
+		axi_desc_put(desc);
 	return NULL;
 }
 
 static void axi_chan_dump_lli(struct axi_dma_chan *chan,
-			      struct axi_dma_desc *desc)
+			      struct axi_dma_hw_desc *desc)
 {
 	dev_err(dchan2dev(&chan->vc.chan),
 		"SAR: 0x%llx DAR: 0x%llx LLP: 0x%llx BTS 0x%x CTL: 0x%x:%08x",
-		le64_to_cpu(desc->lli.sar),
-		le64_to_cpu(desc->lli.dar),
-		le64_to_cpu(desc->lli.llp),
-		le32_to_cpu(desc->lli.block_ts_lo),
-		le32_to_cpu(desc->lli.ctl_hi),
-		le32_to_cpu(desc->lli.ctl_lo));
+		le64_to_cpu(desc->lli->sar),
+		le64_to_cpu(desc->lli->dar),
+		le64_to_cpu(desc->lli->llp),
+		le32_to_cpu(desc->lli->block_ts_lo),
+		le32_to_cpu(desc->lli->ctl_hi),
+		le32_to_cpu(desc->lli->ctl_lo));
 }
 
 static void axi_chan_list_dump_lli(struct axi_dma_chan *chan,
 				   struct axi_dma_desc *desc_head)
 {
-	struct axi_dma_desc *desc;
+	int count = atomic_read(&chan->descs_allocated);
+	int i;
 
-	axi_chan_dump_lli(chan, desc_head);
-	list_for_each_entry(desc, &desc_head->xfer_list, xfer_list)
-		axi_chan_dump_lli(chan, desc);
+	for (i = 0; i < count; i++)
+		axi_chan_dump_lli(chan, &desc_head->hw_desc[i]);
 }
 
 static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
@@ -872,7 +898,7 @@ static int dw_probe(struct platform_device *pdev)
 
 	/* Lli address must be aligned to a 64-byte boundary */
 	dw->desc_pool = dmam_pool_create(KBUILD_MODNAME, chip->dev,
-					 sizeof(struct axi_dma_desc), 64, 0);
+					 sizeof(struct axi_dma_lli), 64, 0);
 	if (!dw->desc_pool) {
 		dev_err(chip->dev, "No memory for descriptors dma pool\n");
 		return -ENOMEM;
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 18b6014cf9b4..41e775e6e593 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -41,6 +41,7 @@ struct axi_dma_chan {
 
 	struct virt_dma_chan		vc;
 
+	struct axi_dma_desc		*desc;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
 };
@@ -80,12 +81,16 @@ struct __packed axi_dma_lli {
 	__le32		reserved_hi;
 };
 
+struct axi_dma_hw_desc {
+	struct axi_dma_lli	*lli;
+	dma_addr_t		llp;
+};
+
 struct axi_dma_desc {
-	struct axi_dma_lli		lli;
+	struct axi_dma_hw_desc	*hw_desc;
 
 	struct virt_dma_desc		vd;
 	struct axi_dma_chan		*chan;
-	struct list_head		xfer_list;
 };
 
 static inline struct device *dchan2dev(struct dma_chan *dchan)
-- 
2.18.0

