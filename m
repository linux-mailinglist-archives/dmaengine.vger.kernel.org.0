Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BBB2B56E6
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 03:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKQCjH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Nov 2020 21:39:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:52551 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbgKQCjG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Nov 2020 21:39:06 -0500
IronPort-SDR: DXtGXml/2P0nqaX3Y+dG0PcT9iXOWehSZoDFgR0HaXu3fpU8EF91I794/H21TbJPDJ0lks+pmV
 9eKLR2FnyOcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="168274084"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="168274084"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 18:39:06 -0800
IronPort-SDR: CgSWu5LOzWNw9Zgb3l06xUXUZr8la2ar5kgXFqpXzEnc7YjzMbgQ7PB6fCv3ji5WqM9E7ytnV2
 V5x8qNdJu5Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="358706101"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2020 18:39:04 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 09/15] dmaengine: dw-axi-dmac: Support burst residue granularity
Date:   Tue, 17 Nov 2020 10:22:09 +0800
Message-Id: <20201117022215.2461-10-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201117022215.2461-1-jee.heng.sia@intel.com>
References: <20201117022215.2461-1-jee.heng.sia@intel.com>
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
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 43 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 72871b8738be..7c97b58206bf 100644
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
+	if (status == DMA_COMPLETE || !txstate)
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
@@ -549,6 +571,7 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 
 	set_desc_src_master(hw_desc);
 
+	hw_desc->len = len;
 	return 0;
 }
 
@@ -575,6 +598,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 	chan->direction = direction;
 	desc->chan = chan;
 	chan->cyclic = true;
+	desc->length = 0;
 
 	for (i = 0; i < num_periods; i++) {
 		hw_desc = &desc->hw_desc[i];
@@ -584,6 +608,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 		if (status < 0)
 			goto err_desc_get;
 
+		desc->length += hw_desc->len;
 		/* Set end-of-link to the linked descriptor, so that cyclic
 		 * callback function can be triggered during interrupt.
 		 */
@@ -636,6 +661,7 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		goto err_desc_get;
 
 	desc->chan = chan;
+	desc->length = 0;
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		mem = sg_dma_address(sg);
@@ -645,6 +671,7 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		status = dw_axi_dma_set_hw_desc(chan, hw_desc, mem, len);
 		if (status < 0)
 			goto err_desc_get;
+		desc->length += hw_desc->len;
 	}
 
 	/* Set end-of-link to the last link descriptor of list */
@@ -690,6 +717,7 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 
 	desc->chan = chan;
 	num = 0;
+	desc->length = 0;
 	while (len) {
 		xfer_len = len;
 
@@ -742,7 +770,8 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 		set_desc_src_master(hw_desc);
 		set_desc_dest_master(hw_desc, desc);
 
-
+		hw_desc->len = xfer_len;
+		desc->length += hw_desc->len;
 		/* update the length and addresses for the next loop cycle */
 		len -= xfer_len;
 		dst_adr += xfer_len;
@@ -1210,7 +1239,7 @@ static int dw_probe(struct platform_device *pdev)
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

