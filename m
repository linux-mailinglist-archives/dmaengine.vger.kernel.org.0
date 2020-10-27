Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5BB29A500
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 07:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506961AbgJ0Gzp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 02:55:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:42071 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506952AbgJ0Gzn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 02:55:43 -0400
IronPort-SDR: uCznFg11Scc75InP26y6J2aGrImJbOFjAByN+j0Gp2UNoWsGih+eW1TNmXN3ZtkMBfctLoli9F
 MCX5J0HkAQSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155004168"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="155004168"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:55:43 -0700
IronPort-SDR: SJu9sb6JpIZgYU5cU2mJyFEOYgkWZcemjWZ3ylZ87/JRnEFPSP8s75SlouU6LXqaVOo1sWcHWx
 rV9u9J43KMoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="350175870"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2020 23:55:41 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/15] dmaengine: dw-axi-dmac: Support burst residue granularity
Date:   Tue, 27 Oct 2020 14:38:52 +0800
Message-Id: <20201027063858.4877-10-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201027063858.4877-1-jee.heng.sia@intel.com>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for DMA_RESIDUE_GRANULARITY_BURST so that AxiDMA can report
DMA residue.

Existing AxiDMA driver only support data transfer between
memory to memory operation, therefore reporting DMA residue
to the DMA clients is not supported.

Reporting DMA residue to the DMA clients is important as DMA clients
shall invoke dmaengine_tx_status() to understand the number of bytes
been transferred so that the buffer pointer can be updated accordingly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 44 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 011cf7134f25..cd99557a716c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -265,14 +265,36 @@ dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 		  struct dma_tx_state *txstate)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
-	enum dma_status ret;
+	struct virt_dma_desc *vdesc;
+	enum dma_status status;
+	u32 completed_length;
+	unsigned long flags;
+	u32 completed_blocks;
+	size_t bytes = 0;
+	u32 length;
+	u32 len;
 
-	ret = dma_cookie_status(dchan, cookie, txstate);
+	status = dma_cookie_status(dchan, cookie, txstate);
+	if (status == DMA_COMPLETE)
+		return status;
 
-	if (chan->is_paused && ret == DMA_IN_PROGRESS)
-		ret = DMA_PAUSED;
+	spin_lock_irqsave(&chan->vc.lock, flags);
 
-	return ret;
+	vdesc = vchan_find_desc(&chan->vc, cookie);
+	if (vdesc) {
+		length = vd_to_axi_desc(vdesc)->length;
+		completed_blocks = vd_to_axi_desc(vdesc)->completed_blocks;
+		len = vd_to_axi_desc(vdesc)->hw_desc[0].len;
+		completed_length = completed_blocks * len;
+		bytes = length - completed_length;
+	} else {
+		bytes = vd_to_axi_desc(vdesc)->length;
+	}
+
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+	dma_set_residue(txstate, bytes);
+
+	return status;
 }
 
 static void write_desc_llp(struct axi_dma_hw_desc *desc, dma_addr_t adr)
@@ -497,6 +519,7 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 
 	desc->chan = chan;
 	num = 0;
+	desc->length = 0;
 	while (len) {
 		xfer_len = len;
 
@@ -549,7 +572,8 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 		set_desc_src_master(hw_desc);
 		set_desc_dest_master(hw_desc, desc);
 
-
+		hw_desc->len = xfer_len;
+		desc->length += hw_desc->len;
 		/* update the length and addresses for the next loop cycle */
 		len -= xfer_len;
 		dst_adr += xfer_len;
@@ -612,6 +636,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 	chan->direction = direction;
 	desc->chan = chan;
 	chan->cyclic = true;
+	desc->length = 0;
 
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
@@ -677,6 +702,8 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 
 		set_desc_src_master(hw_desc);
 
+		hw_desc->len = period_len;
+		desc->length += hw_desc->len;
 		/*
 		 * Set end-of-link to the linked descriptor, so that cyclic
 		 * callback function can be triggered during interrupt.
@@ -757,6 +784,7 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	}
 
 	desc->chan = chan;
+	desc->length = 0;
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		mem = sg_dma_address(sg);
@@ -806,6 +834,8 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		hw_desc->lli->ctl_lo = cpu_to_le32(ctllo);
 
 		set_desc_src_master(hw_desc);
+		hw_desc->len = len;
+		desc->length += hw_desc->len;
 	}
 
 	if (unlikely(!desc))
@@ -1269,7 +1299,7 @@ static int dw_probe(struct platform_device *pdev)
 	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
 	dw->dma.directions |= BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
-	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
 	dw->dma.dev = chip->dev;
 	dw->dma.device_tx_status = dma_chan_tx_status;
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 651874e5c88f..bdb66d775125 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -88,6 +88,7 @@ struct __packed axi_dma_lli {
 struct axi_dma_hw_desc {
 	struct axi_dma_lli	*lli;
 	dma_addr_t		llp;
+	u32			len;
 };
 
 struct axi_dma_desc {
@@ -96,6 +97,7 @@ struct axi_dma_desc {
 	struct virt_dma_desc		vd;
 	struct axi_dma_chan		*chan;
 	u32				completed_blocks;
+	u32				length;
 };
 
 static inline struct device *dchan2dev(struct dma_chan *dchan)
-- 
2.18.0

