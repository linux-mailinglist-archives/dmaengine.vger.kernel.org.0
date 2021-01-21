Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8E32FE274
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 07:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbhAUGPq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 01:15:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:10404 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbhAUGPh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Jan 2021 01:15:37 -0500
IronPort-SDR: NgQ1VO+vR9izqQYV5IH9tdjIyUlUa/ez2CHIz6J8X159P927+tkKK0sdaFRAVLJJ6CuvnSG58Z
 BYEHeAviLTbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="175716797"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="175716797"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 22:14:35 -0800
IronPort-SDR: 78O3Sj0Spi6tUndVSz/zt5HVoTNcO6VDFaV8DQhSN6yhccq4WtsP9HwNW6VstQXyWg1JjztHwg
 YbqufSz323yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="427201394"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga001.jf.intel.com with ESMTP; 20 Jan 2021 22:14:33 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v10 09/16] dmaengine: dw-axi-dmac: Support burst residue granularity
Date:   Thu, 21 Jan 2021 13:56:34 +0800
Message-Id: <20210121055641.6307-10-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210121055641.6307-1-jee.heng.sia@intel.com>
References: <20210121055641.6307-1-jee.heng.sia@intel.com>
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

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 43 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a8b6c8c8ef58..830d3de76abd 100644
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
index 3498bef5453b..46baf93de617 100644
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

