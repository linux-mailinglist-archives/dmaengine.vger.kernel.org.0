Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8AD3C21F0
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jul 2021 11:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhGIJyW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jul 2021 05:54:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:6406 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232170AbhGIJyU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Jul 2021 05:54:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="209719319"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="209719319"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 02:51:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="487992104"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2021 02:51:34 -0700
From:   pandith.n@intel.com
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com, kris.pan@intel.com,
        mallikarjunappa.sangannavar@intel.com, Srikanth.Thokala@intel.com,
        Pandith N <pandith.n@intel.com>
Subject: [linux-drivers-review] [PATCH V2 1/1] dmaengine: dw-axi-dmac: support parallel memory <--> peripheral transfers
Date:   Fri,  9 Jul 2021 15:21:33 +0530
Message-Id: <20210709095133.26867-1-pandith.n@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

Added support for multiple DMA_MEM_TO_DEV, DMA_DEV_TO_MEM transfers in
parallel. This is required for peripherals using DMA for transmit and
receive operations at the same time. APB slot number needs to be programmed
in channel hardware handshaking interface.

Removed free slot check algorithm in dw_axi_dma_set_hw_channel. For 8
DMA channels, use respective handshake slot in DMA_HS_SEL APB register.

Burst length, DMA HW capability set in dt-binding is now used in driver.

Signed-off-by: Pandith N <pandith.n@intel.com>
Tested-by: Pan Kris <kris.pan@intel.com>

---
Changes since v1:
Added new macro, magic mask for HW handshake select.
Typos in commit message are corrected
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 56 +++++++++----------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  4 ++
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index d9e4ac3edb4e..aace3751c56e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -363,12 +363,16 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 			DWAXIDMAC_TT_FC_MEM_TO_PER_DST :
 			DWAXIDMAC_TT_FC_MEM_TO_PER_DMAC)
 			<< CH_CFG_H_TT_FC_POS;
+		if (chan->chip->apb_regs)
+			reg |= (chan->id << CH_CFG_H_DST_PER_POS);
 		break;
 	case DMA_DEV_TO_MEM:
 		reg |= (chan->config.device_fc ?
 			DWAXIDMAC_TT_FC_PER_TO_MEM_SRC :
 			DWAXIDMAC_TT_FC_PER_TO_MEM_DMAC)
 			<< CH_CFG_H_TT_FC_POS;
+		if (chan->chip->apb_regs)
+			reg |= (chan->id << CH_CFG_H_SRC_PER_POS);
 		break;
 	default:
 		break;
@@ -470,19 +474,14 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
 	pm_runtime_put(chan->chip->dev);
 }
 
-static void dw_axi_dma_set_hw_channel(struct axi_dma_chip *chip,
-				      u32 handshake_num, bool set)
+static int dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)
 {
-	unsigned long start = 0;
-	unsigned long reg_value;
-	unsigned long reg_mask;
-	unsigned long reg_set;
-	unsigned long mask;
-	unsigned long val;
+	struct axi_dma_chip *chip = chan->chip;
+	unsigned long reg_value, val;
 
 	if (!chip->apb_regs) {
 		dev_dbg(chip->dev, "apb_regs not initialized\n");
-		return;
+		return -EINVAL;
 	}
 
 	/*
@@ -490,26 +489,22 @@ static void dw_axi_dma_set_hw_channel(struct axi_dma_chip *chip,
 	 * Lock the DMA channel by assign a handshake number to the channel.
 	 * Unlock the DMA channel by assign 0x3F to the channel.
 	 */
-	if (set) {
-		reg_set = UNUSED_CHANNEL;
-		val = handshake_num;
-	} else {
-		reg_set = handshake_num;
+	if (set)
+		val = chan->hw_handshake_num;
+	else
 		val = UNUSED_CHANNEL;
-	}
 
 	reg_value = lo_hi_readq(chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
 
-	for_each_set_clump8(start, reg_mask, &reg_value, 64) {
-		if (reg_mask == reg_set) {
-			mask = GENMASK_ULL(start + 7, start);
-			reg_value &= ~mask;
-			reg_value |= rol64(val, start);
-			lo_hi_writeq(reg_value,
-				     chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
-			break;
-		}
-	}
+	/* Channel is already allocated, set handshake as per channel ID */
+	/* 64 bit write should handle for 8 channels */
+
+	reg_value &= ~(DMA_APB_HS_SEL_MASK <<
+			(chan->id * DMA_APB_HS_SEL_BIT_SIZE));
+	reg_value |= (val << (chan->id * DMA_APB_HS_SEL_BIT_SIZE));
+	lo_hi_writeq(reg_value, chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
+
+	return 0;
 }
 
 /*
@@ -742,7 +737,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 		llp = hw_desc->llp;
 	} while (total_segments);
 
-	dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true);
+	dw_axi_dma_set_hw_channel(chan, true);
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
 
@@ -822,7 +817,7 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		llp = hw_desc->llp;
 	} while (num_sgs);
 
-	dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true);
+	dw_axi_dma_set_hw_channel(chan, true);
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
 
@@ -1098,8 +1093,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 			 "%s failed to stop\n", axi_chan_name(chan));
 
 	if (chan->direction != DMA_MEM_TO_MEM)
-		dw_axi_dma_set_hw_channel(chan->chip,
-					  chan->hw_handshake_num, false);
+		dw_axi_dma_set_hw_channel(chan, false);
 	if (chan->direction == DMA_MEM_TO_DEV)
 		dw_axi_dma_set_byte_halfword(chan, false);
 
@@ -1296,7 +1290,7 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 			return -EINVAL;
 
 		chip->dw->hdata->restrict_axi_burst_len = true;
-		chip->dw->hdata->axi_rw_burst_len = tmp - 1;
+		chip->dw->hdata->axi_rw_burst_len = tmp;
 	}
 
 	return 0;
@@ -1365,7 +1359,6 @@ static int dw_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < hdata->nr_channels; i++) {
 		struct axi_dma_chan *chan = &dw->chan[i];
@@ -1386,6 +1379,7 @@ static int dw_probe(struct platform_device *pdev)
 
 	/* DMA capabilities */
 	dw->dma.chancnt = hdata->nr_channels;
+	dw->dma.max_burst = hdata->axi_rw_burst_len;
 	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b69897887c76..1d0b7bc07cca 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -184,6 +184,8 @@ static inline struct axi_dma_chan *dchan_to_axi_dma_chan(struct dma_chan *dchan)
 #define DMAC_APB_HALFWORD_WR_CH_EN	0x020 /* DMAC Halfword write enables */
 
 #define UNUSED_CHANNEL		0x3F /* Set unused DMA channel to 0x3F */
+#define DMA_APB_HS_SEL_BIT_SIZE 0x08 /* HW handshake bits per channel */
+#define DMA_APB_HS_SEL_MASK	0xFF /* HW handshake select masks */
 #define MAX_BLOCK_SIZE		0x1000 /* 1024 blocks * 4 bytes data width */
 
 /* DMAC_CFG */
@@ -256,6 +258,8 @@ enum {
 
 /* CH_CFG_H */
 #define CH_CFG_H_PRIORITY_POS		17
+#define CH_CFG_H_DST_PER_POS            12
+#define CH_CFG_H_SRC_PER_POS            7
 #define CH_CFG_H_HS_SEL_DST_POS		4
 #define CH_CFG_H_HS_SEL_SRC_POS		3
 enum {
-- 
2.17.1

