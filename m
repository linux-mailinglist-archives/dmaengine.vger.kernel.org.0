Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA282DB91E
	for <lists+dmaengine@lfdr.de>; Wed, 16 Dec 2020 03:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgLPC2t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 21:28:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:26382 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgLPC2t (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Dec 2020 21:28:49 -0500
IronPort-SDR: 3DHXF715WaCnd0Jc+WhuKxFBrDvDpwU2JmGFEjnvCXLJal+Kf4OWUbAmIqFQd1/VjeBAupP/kh
 qmcyexq71lDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="259716490"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="259716490"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 18:27:29 -0800
IronPort-SDR: 2tL1H6i4qTymITFrsqm9CcVamO3k3DPEk7oVuOsQrNUXMqoq5JIeROpYo0ncdOCvr1QTDX4+x6
 rxVJzrzKl22g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="557080879"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2020 18:27:27 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 16/16] dmaengine: dw-axi-dmac: Virtually split the linked-list
Date:   Wed, 16 Dec 2020 10:10:03 +0800
Message-Id: <20201216021003.26911-17-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201216021003.26911-1-jee.heng.sia@intel.com>
References: <20201216021003.26911-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

AxiDMA driver exposed the dma_set_max_seg_size() to the DMAENGINE.
It shall helps the DMA clients to create size-optimized linked-list
for the controller.

However, there are certain situations where DMA client might not be
abled to benefit from the dma_get_max_seg_size() if the segment size
can't meet the nature of the DMA client's operation.

In the case of ALSA operation, ALSA application and driver expecting
to run in a period of larger than 10ms regardless of the bit depth.
With this large period, there is a strong request to split the linked-list
in the AxiDMA driver.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 111 ++++++++++++++----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   1 +
 2 files changed, 92 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 1a218fcdbb16..bf83dea947be 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -576,6 +576,11 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 	if (mem_width > DWAXIDMAC_TRANS_WIDTH_32)
 		mem_width = DWAXIDMAC_TRANS_WIDTH_32;
 
+	if (!IS_ALIGNED(mem_addr, 4)) {
+		dev_err(chan->chip->dev, "invalid buffer alignment\n");
+		return -EINVAL;
+	}
+
 	switch (chan->direction) {
 	case DMA_MEM_TO_DEV:
 		reg_width = __ffs(chan->config.dst_addr_width);
@@ -637,6 +642,35 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 	return 0;
 }
 
+static size_t calculate_block_len(struct axi_dma_chan *chan,
+				  dma_addr_t dma_addr, size_t buf_len,
+				  enum dma_transfer_direction direction)
+{
+	u32 data_width, reg_width, mem_width;
+	size_t axi_block_ts, block_len;
+
+	axi_block_ts = chan->chip->dw->hdata->block_size[chan->id];
+
+	switch (direction) {
+	case DMA_MEM_TO_DEV:
+		data_width = BIT(chan->chip->dw->hdata->m_data_width);
+		mem_width = __ffs(data_width | dma_addr | buf_len);
+		if (mem_width > DWAXIDMAC_TRANS_WIDTH_32)
+			mem_width = DWAXIDMAC_TRANS_WIDTH_32;
+
+		block_len = axi_block_ts << mem_width;
+		break;
+	case DMA_DEV_TO_MEM:
+		reg_width = __ffs(chan->config.src_addr_width);
+		block_len = axi_block_ts << reg_width;
+		break;
+	default:
+		block_len = 0;
+	}
+
+	return block_len;
+}
+
 static struct dma_async_tx_descriptor *
 dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 			    size_t buf_len, size_t period_len,
@@ -647,13 +681,27 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 	struct axi_dma_hw_desc *hw_desc = NULL;
 	struct axi_dma_desc *desc = NULL;
 	dma_addr_t src_addr = dma_addr;
-	u32 num_periods = buf_len / period_len;
+	u32 num_periods, num_segments;
+	size_t axi_block_len;
+	u32 total_segments;
+	u32 segment_len;
 	unsigned int i;
 	int status;
 	u64 llp = 0;
 	u8 lms = 0; /* Select AXI0 master for LLI fetching */
 
-	desc = axi_desc_alloc(num_periods);
+	num_periods = buf_len / period_len;
+
+	axi_block_len = calculate_block_len(chan, dma_addr, buf_len, direction);
+	if (axi_block_len == 0)
+		return NULL;
+
+	num_segments = DIV_ROUND_UP(period_len, axi_block_len);
+	segment_len = DIV_ROUND_UP(period_len, num_segments);
+
+	total_segments = num_periods * num_segments;
+
+	desc = axi_desc_alloc(total_segments);
 	if (unlikely(!desc))
 		goto err_desc_get;
 
@@ -661,12 +709,13 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 	desc->chan = chan;
 	chan->cyclic = true;
 	desc->length = 0;
+	desc->period_len = period_len;
 
-	for (i = 0; i < num_periods; i++) {
+	for (i = 0; i < total_segments; i++) {
 		hw_desc = &desc->hw_desc[i];
 
 		status = dw_axi_dma_set_hw_desc(chan, hw_desc, src_addr,
-						period_len);
+						segment_len);
 		if (status < 0)
 			goto err_desc_get;
 
@@ -676,17 +725,17 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 		 */
 		set_desc_last(hw_desc);
 
-		src_addr += period_len;
+		src_addr += segment_len;
 	}
 
 	llp = desc->hw_desc[0].llp;
 
 	/* Managed transfer list */
 	do {
-		hw_desc = &desc->hw_desc[--num_periods];
+		hw_desc = &desc->hw_desc[--total_segments];
 		write_desc_llp(hw_desc, llp | lms);
 		llp = hw_desc->llp;
-	} while (num_periods);
+	} while (total_segments);
 
 	if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true))
 		goto err_desc_get;
@@ -709,9 +758,13 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	struct axi_dma_hw_desc *hw_desc = NULL;
 	struct axi_dma_desc *desc = NULL;
+	u32 num_segments, segment_len;
+	unsigned int loop = 0;
 	struct scatterlist *sg;
+	size_t axi_block_len;
+	u32 len, num_sgs = 0;
 	unsigned int i;
-	u32 mem, len;
+	dma_addr_t mem;
 	int status;
 	u64 llp = 0;
 	u8 lms = 0; /* Select AXI0 master for LLI fetching */
@@ -719,35 +772,51 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	if (unlikely(!is_slave_direction(direction) || !sg_len))
 		return NULL;
 
-	chan->direction = direction;
+	mem = sg_dma_address(sgl);
+	len = sg_dma_len(sgl);
+
+	axi_block_len = calculate_block_len(chan, mem, len, direction);
+	if (axi_block_len == 0)
+		return NULL;
 
-	desc = axi_desc_alloc(sg_len);
+	for_each_sg(sgl, sg, sg_len, i)
+		num_sgs += DIV_ROUND_UP(sg_dma_len(sg), axi_block_len);
+
+	desc = axi_desc_alloc(num_sgs);
 	if (unlikely(!desc))
 		goto err_desc_get;
 
 	desc->chan = chan;
 	desc->length = 0;
+	chan->direction = direction;
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		mem = sg_dma_address(sg);
 		len = sg_dma_len(sg);
-		hw_desc = &desc->hw_desc[i];
-
-		status = dw_axi_dma_set_hw_desc(chan, hw_desc, mem, len);
-		if (status < 0)
-			goto err_desc_get;
-		desc->length += hw_desc->len;
+		num_segments = DIV_ROUND_UP(sg_dma_len(sg), axi_block_len);
+		segment_len = DIV_ROUND_UP(sg_dma_len(sg), num_segments);
+
+		do {
+			hw_desc = &desc->hw_desc[loop++];
+			status = dw_axi_dma_set_hw_desc(chan, hw_desc, mem, segment_len);
+			if (status < 0)
+				goto err_desc_get;
+
+			desc->length += hw_desc->len;
+			len -= segment_len;
+			mem += segment_len;
+		} while (len >= segment_len);
 	}
 
 	/* Set end-of-link to the last link descriptor of list */
-	set_desc_last(&desc->hw_desc[sg_len - 1]);
+	set_desc_last(&desc->hw_desc[num_sgs - 1]);
 
 	/* Managed transfer list */
 	do {
-		hw_desc = &desc->hw_desc[--sg_len];
+		hw_desc = &desc->hw_desc[--num_sgs];
 		write_desc_llp(hw_desc, llp | lms);
 		llp = hw_desc->llp;
-	} while (sg_len);
+	} while (num_sgs);
 
 	if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true))
 		goto err_desc_get;
@@ -950,7 +1019,6 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 	vd = vchan_next_desc(&chan->vc);
 
 	if (chan->cyclic) {
-		vchan_cyclic_callback(vd);
 		desc = vd_to_axi_desc(vd);
 		if (desc) {
 			llp = lo_hi_readq(chan->chan_regs + CH_LLP);
@@ -960,6 +1028,9 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 					axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
 					hw_desc->lli->ctl_hi |= CH_CTL_H_LLI_VALID;
 					desc->completed_blocks = i;
+
+					if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
+						vchan_cyclic_callback(vd);
 					break;
 				}
 			}
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 1e937ea2a96d..b69897887c76 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -100,6 +100,7 @@ struct axi_dma_desc {
 	struct axi_dma_chan		*chan;
 	u32				completed_blocks;
 	u32				length;
+	u32				period_len;
 };
 
 static inline struct device *dchan2dev(struct dma_chan *dchan)
-- 
2.18.0

