Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D867A28AD37
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 06:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgJLEjx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 00:39:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:21608 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgJLEjT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Oct 2020 00:39:19 -0400
IronPort-SDR: EKzDV9484Di13sXrNEKR2IUnFUPqf6o3Irty4kEFUlbS2Q3by9GkN8WpL36KJLVnRsPGMn3REz
 e+k2TE5m5s+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="164903180"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="164903180"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 21:39:18 -0700
IronPort-SDR: hj9F4b8xh2hfrkEPm9aNVSDK1h29ihFGinCOGFrl8AIGuiyJUbwq4XPstwQXhfffgHvOP3iYT5
 JVRCRL4d+84A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="313321333"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com) ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2020 21:39:17 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] dmaengine: dw-axi-dmac: Support burst residue granularity
Date:   Mon, 12 Oct 2020 12:21:54 +0800
Message-Id: <20201012042200.29787-10-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201012042200.29787-1-jee.heng.sia@intel.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
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

