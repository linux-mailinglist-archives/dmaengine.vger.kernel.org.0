Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC56F3D00D7
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhGTRGo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 13:06:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:17000 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229627AbhGTRGl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 13:06:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211016692"
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="211016692"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 10:47:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,255,1620716400"; 
   d="scan'208";a="469847769"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jul 2021 10:47:17 -0700
From:   pandith.n@intel.com
To:     Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com, kris.pan@intel.com,
        mallikarjunappa.sangannavar@intel.com, Srikanth.Thokala@intel.com,
        Pandith N <pandith.n@intel.com>
Subject: [PATCH V4 1/3] dmaengine: dw-axi-dmac: Remove free slot check algorithm in dw_axi_dma_set_hw_channel
Date:   Tue, 20 Jul 2021 23:17:11 +0530
Message-Id: <20210720174713.13282-2-pandith.n@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720174713.13282-1-pandith.n@intel.com>
References: <20210720174713.13282-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

Removed free slot check algorithm in dw_axi_dma_set_hw_channel. For 8
DMA channels, use respective handshake slot in DMA_HS_SEL APB register.

For every channel, an dedicated slot is provided in  hardware handshake
register AXIDMA_CTRL_DMA_HS_SEL_n. Peripheral source number is
programmed in respective channel slots.

Signed-off-by: Pandith N <pandith.n@intel.com>
Tested-by: Pan Kris <kris.pan@intel.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 49 +++++++------------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 +
 2 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index d9e4ac3edb4e..6b871e20ae27 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -470,19 +470,14 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
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
@@ -490,26 +485,22 @@ static void dw_axi_dma_set_hw_channel(struct axi_dma_chip *chip,
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
@@ -742,7 +733,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 		llp = hw_desc->llp;
 	} while (total_segments);
 
-	dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true);
+	dw_axi_dma_set_hw_channel(chan, true);
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
 
@@ -822,7 +813,7 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		llp = hw_desc->llp;
 	} while (num_sgs);
 
-	dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true);
+	dw_axi_dma_set_hw_channel(chan, true);
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
 
@@ -1098,8 +1089,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 			 "%s failed to stop\n", axi_chan_name(chan));
 
 	if (chan->direction != DMA_MEM_TO_MEM)
-		dw_axi_dma_set_hw_channel(chan->chip,
-					  chan->hw_handshake_num, false);
+		dw_axi_dma_set_hw_channel(chan, false);
 	if (chan->direction == DMA_MEM_TO_DEV)
 		dw_axi_dma_set_byte_halfword(chan, false);
 
@@ -1365,7 +1355,6 @@ static int dw_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-
 	INIT_LIST_HEAD(&dw->dma.channels);
 	for (i = 0; i < hdata->nr_channels; i++) {
 		struct axi_dma_chan *chan = &dw->chan[i];
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index b69897887c76..358f553cafe9 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -184,6 +184,8 @@ static inline struct axi_dma_chan *dchan_to_axi_dma_chan(struct dma_chan *dchan)
 #define DMAC_APB_HALFWORD_WR_CH_EN	0x020 /* DMAC Halfword write enables */
 
 #define UNUSED_CHANNEL		0x3F /* Set unused DMA channel to 0x3F */
+#define DMA_APB_HS_SEL_BIT_SIZE	0x08 /* HW handshake bits per channel */
+#define DMA_APB_HS_SEL_MASK	0xFF /* HW handshake select masks */
 #define MAX_BLOCK_SIZE		0x1000 /* 1024 blocks * 4 bytes data width */
 
 /* DMAC_CFG */
-- 
2.17.1

