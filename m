Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E02B29A4F7
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 07:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506906AbgJ0Gzf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 02:55:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:42071 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506917AbgJ0Gzf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Oct 2020 02:55:35 -0400
IronPort-SDR: 3cywgdMLh6EJQEmjA5Lits66MIpyauLWTzGgaU4ezLvoOGcDKlQF1r7/Tgwy3t53VTBY4+fa1d
 I6UsGsZaFGqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155004154"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="155004154"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 23:55:34 -0700
IronPort-SDR: ct+nmWFhGRFnGlj6Ot8m+QQwa1n4hDmGw0cnupanUkObCvGx9o/0TPHTGIYmvEIdFgght3abNL
 63JO5O3tO7mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="350175857"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga008.jf.intel.com with ESMTP; 26 Oct 2020 23:55:33 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/15] dmaengine: dw-axi-dmac: Support device_prep_slave_sg
Date:   Tue, 27 Oct 2020 14:38:49 +0800
Message-Id: <20201027063858.4877-7-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201027063858.4877-1-jee.heng.sia@intel.com>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add device_prep_slave_sg() callback function so that DMA_MEM_TO_DEV
and DMA_DEV_TO_MEM operations in single mode can be supported.

Existing AxiDMA driver only support data transfer between
memory to memory. Data transfer between device to memory and
memory to device in single mode would failed if this interface
is not supported by the AxiDMA driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 142 ++++++++++++++++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   1 +
 2 files changed, 143 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 16e6934ae9a1..1124c97025f2 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -307,6 +307,22 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	       priority << CH_CFG_H_PRIORITY_POS |
 	       DWAXIDMAC_HS_SEL_HW << CH_CFG_H_HS_SEL_DST_POS |
 	       DWAXIDMAC_HS_SEL_HW << CH_CFG_H_HS_SEL_SRC_POS);
+	switch (chan->direction) {
+	case DMA_MEM_TO_DEV:
+		reg |= (chan->config.device_fc ?
+			DWAXIDMAC_TT_FC_MEM_TO_PER_DST :
+			DWAXIDMAC_TT_FC_MEM_TO_PER_DMAC)
+			<< CH_CFG_H_TT_FC_POS;
+		break;
+	case DMA_DEV_TO_MEM:
+		reg |= (chan->config.device_fc ?
+			DWAXIDMAC_TT_FC_PER_TO_MEM_SRC :
+			DWAXIDMAC_TT_FC_PER_TO_MEM_DMAC)
+			<< CH_CFG_H_TT_FC_POS;
+		break;
+	default:
+		break;
+	}
 	axi_chan_iowrite32(chan, CH_CFG_H, reg);
 
 	write_chan_llp(chan, first->hw_desc[0].llp | lms);
@@ -559,6 +575,129 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor *
+dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+			      unsigned int sg_len,
+			      enum dma_transfer_direction direction,
+			      unsigned long flags, void *context)
+{
+	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	unsigned int data_width = BIT(chan->chip->dw->hdata->m_data_width);
+	struct axi_dma_hw_desc *hw_desc = NULL;
+	struct axi_dma_desc *desc = NULL;
+	struct scatterlist *sg;
+	unsigned int reg_width;
+	unsigned int mem_width;
+	dma_addr_t reg;
+	unsigned int i;
+	u32 ctllo, ctlhi;
+	size_t block_ts;
+	u32 mem, len;
+	u64 llp = 0;
+	u8 lms = 0; /* Select AXI0 master for LLI fetching */
+
+	if (unlikely(!is_slave_direction(direction) || !sg_len))
+		return NULL;
+
+	chan->direction = direction;
+
+	desc = axi_desc_alloc(sg_len);
+	if (unlikely(!desc))
+		goto err_desc_get;
+
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		reg_width = __ffs(chan->config.dst_addr_width);
+		reg = chan->config.dst_addr;
+		ctllo = reg_width << CH_CTL_L_DST_WIDTH_POS |
+			DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_DST_INC_POS |
+			DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS;
+		break;
+	case DMA_DEV_TO_MEM:
+		reg_width = __ffs(chan->config.src_addr_width);
+		reg = chan->config.src_addr;
+		ctllo = reg_width << CH_CTL_L_SRC_WIDTH_POS |
+			DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS |
+			DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_SRC_INC_POS;
+		break;
+	default:
+		return NULL;
+	}
+
+	desc->chan = chan;
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		mem = sg_dma_address(sg);
+		len = sg_dma_len(sg);
+		hw_desc = &desc->hw_desc[i];
+		mem_width = __ffs(data_width | mem | len);
+		if (mem_width > DWAXIDMAC_TRANS_WIDTH_32)
+			mem_width = DWAXIDMAC_TRANS_WIDTH_32;
+
+		hw_desc->lli = axi_desc_get(chan, &hw_desc->llp);
+		if (unlikely(!hw_desc->lli))
+			goto err_desc_get;
+
+		if (direction == DMA_MEM_TO_DEV)
+			block_ts = len >> mem_width;
+		else
+			block_ts = len >> reg_width;
+
+		ctlhi = CH_CTL_H_LLI_VALID;
+		if (chan->chip->dw->hdata->restrict_axi_burst_len) {
+			u32 burst_len = chan->chip->dw->hdata->axi_rw_burst_len;
+
+			ctlhi |= (CH_CTL_H_ARLEN_EN |
+				burst_len << CH_CTL_H_ARLEN_POS |
+				CH_CTL_H_AWLEN_EN |
+				burst_len << CH_CTL_H_AWLEN_POS);
+		}
+
+		hw_desc->lli->ctl_hi = cpu_to_le32(ctlhi);
+
+		if (direction == DMA_MEM_TO_DEV)
+			ctllo |= mem_width << CH_CTL_L_SRC_WIDTH_POS;
+		else
+			ctllo |= mem_width << CH_CTL_L_DST_WIDTH_POS;
+
+		if (direction == DMA_MEM_TO_DEV) {
+			write_desc_sar(hw_desc, mem);
+			write_desc_dar(hw_desc, reg);
+		} else {
+			write_desc_sar(hw_desc, reg);
+			write_desc_dar(hw_desc, mem);
+		}
+
+		hw_desc->lli->block_ts_lo = cpu_to_le32(block_ts - 1);
+		ctllo |= (DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
+				 DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS);
+		hw_desc->lli->ctl_lo = cpu_to_le32(ctllo);
+
+		set_desc_src_master(hw_desc);
+	}
+
+	if (unlikely(!desc))
+		return NULL;
+
+	/* Set end-of-link to the last link descriptor of list */
+	set_desc_last(&desc->hw_desc[sg_len - 1]);
+
+	/* Managed transfer list */
+	do {
+		hw_desc = &desc->hw_desc[--sg_len];
+		write_desc_llp(hw_desc, llp | lms);
+		llp = hw_desc->llp;
+	} while (sg_len);
+
+	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
+
+err_desc_get:
+	if (desc)
+		axi_desc_put(desc);
+
+	return NULL;
+}
+
 static int dw_axi_dma_chan_slave_config(struct dma_chan *dchan,
 					struct dma_slave_config *config)
 {
@@ -938,12 +1077,14 @@ static int dw_probe(struct platform_device *pdev)
 
 	/* Set capabilities */
 	dma_cap_set(DMA_MEMCPY, dw->dma.cap_mask);
+	dma_cap_set(DMA_SLAVE, dw->dma.cap_mask);
 
 	/* DMA capabilities */
 	dw->dma.chancnt = hdata->nr_channels;
 	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
+	dw->dma.directions |= BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
 	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 
 	dw->dma.dev = chip->dev;
@@ -959,6 +1100,7 @@ static int dw_probe(struct platform_device *pdev)
 	dw->dma.device_prep_dma_memcpy = dma_chan_prep_dma_memcpy;
 	dw->dma.device_synchronize = dw_axi_dma_synchronize;
 	dw->dma.device_config = dw_axi_dma_chan_slave_config;
+	dw->dma.device_prep_slave_sg = dw_axi_dma_chan_prep_slave_sg;
 
 	platform_set_drvdata(pdev, chip);
 
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index a75b921d6b1a..ac49f2e14b0c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -44,6 +44,7 @@ struct axi_dma_chan {
 
 	struct axi_dma_desc		*desc;
 	struct dma_slave_config		config;
+	enum dma_transfer_direction	direction;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
 };
-- 
2.18.0

