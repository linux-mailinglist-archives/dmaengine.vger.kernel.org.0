Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27692FE7FA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 11:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbhAUKs6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 05:48:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:36494 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbhAUKsV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Jan 2021 05:48:21 -0500
IronPort-SDR: evF951rV93pjLNp370yQhRoApGDKNoe0cBEbUZQe/LHRaXsyAnOxVBZDsxGiehOB28eu3QqTi+
 77SuPAlCloPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="240790335"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="240790335"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:45:40 -0800
IronPort-SDR: dKoF+hjOry7k522M86SN6WM9zKu4XEbYBaDx647ggnAKKuuGkslwNgBaelmRu4AVZDSVPKXRsp
 31uzfK0wrq8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="356417848"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jan 2021 02:45:38 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v11 16/16] dmaengine: dw-axi-dmac: Virtually split the linked-list
Date:   Thu, 21 Jan 2021 18:27:26 +0800
Message-Id: <20210121102726.22805-17-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210121102726.22805-1-jee.heng.sia@intel.com>
References: <20210121102726.22805-1-jee.heng.sia@intel.com>
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
Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 111 ++++++++++++++----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   1 +
 2 files changed, 92 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 88d4923dee6c..ac3d81b72a15 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -581,6 +581,11 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
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
@@ -642,6 +647,35 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
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
@@ -652,13 +686,27 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
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
 
@@ -666,12 +714,13 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
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
 
@@ -681,17 +730,17 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
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
 
 	dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true);
 
@@ -713,9 +762,13 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
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
@@ -723,35 +776,51 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
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
 
 	dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true);
 
@@ -953,7 +1022,6 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 	vd = vchan_next_desc(&chan->vc);
 
 	if (chan->cyclic) {
-		vchan_cyclic_callback(vd);
 		desc = vd_to_axi_desc(vd);
 		if (desc) {
 			llp = lo_hi_readq(chan->chan_regs + CH_LLP);
@@ -963,6 +1031,9 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
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

