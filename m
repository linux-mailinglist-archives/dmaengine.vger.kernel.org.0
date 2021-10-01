Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8918F41EF2E
	for <lists+dmaengine@lfdr.de>; Fri,  1 Oct 2021 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354198AbhJAOOh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Oct 2021 10:14:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:11422 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhJAOOh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 1 Oct 2021 10:14:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="248005324"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="248005324"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 07:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="480470573"
Received: from coresw01.iind.intel.com ([10.106.46.194])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2021 07:08:16 -0700
From:   pandith.n@intel.com
To:     vkoul@kernel.org, eugeniy.paltsev@synopsys.com,
        dmaengine@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        mallikarjunappa.sangannavar@intel.com, srikanth.thokala@intel.com,
        kenchappa.demakkanavar@intel.com, Pandith N <pandith.n@intel.com>
Subject: [PATCH V3 1/3] dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8
Date:   Fri,  1 Oct 2021 19:38:10 +0530
Message-Id: <20211001140812.24977-2-pandith.n@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001140812.24977-1-pandith.n@intel.com>
References: <20211001140812.24977-1-pandith.n@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

Added support for DMA controller with more than 8 channels.
DMAC register map changes based on number of channels.

Enabling DMAC channel:
DMAC_CHENREG has to be used when number of channels <= 8
DMAC_CHENREG2 has to be used when number of channels > 8

Configuring DMA channel:
CHx_CFG has to be used when number of channels <= 8
CHx_CFG2 has to be used when number of channels > 8

Suspending and resuming channel:
DMAC_CHENREG has to be used when number of channels <= 8 DMAC_CHSUSPREG
has to be used for suspending a channel > 8

Signed-off-by: Pandith N <pandith.n@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
Changes V1-->V2:
Initialize register values in channel resume and pause Removed unwanted
braces in flow control setting.

Changes from v2->v3
check if channel is enabled, before suspending.
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 105 +++++++++++++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  35 +++++-
 2 files changed, 109 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 35993ab92154..9a8231244c42 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -79,6 +79,32 @@ axi_chan_iowrite64(struct axi_dma_chan *chan, u32 reg, u64 val)
 	iowrite32(upper_32_bits(val), chan->chan_regs + reg + 4);
 }
 
+static inline void axi_chan_config_write(struct axi_dma_chan *chan,
+					 struct axi_dma_chan_config *config)
+{
+	u32 cfg_lo, cfg_hi;
+
+	cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
+		  config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
+	if (chan->chip->dw->hdata->reg_map_8_channels) {
+		cfg_hi = config->tt_fc << CH_CFG_H_TT_FC_POS |
+			 config->hs_sel_src << CH_CFG_H_HS_SEL_SRC_POS |
+			 config->hs_sel_dst << CH_CFG_H_HS_SEL_DST_POS |
+			 config->src_per << CH_CFG_H_SRC_PER_POS |
+			 config->dst_per << CH_CFG_H_DST_PER_POS |
+			 config->prior << CH_CFG_H_PRIORITY_POS;
+	} else {
+		cfg_lo |= config->src_per << CH_CFG2_L_SRC_PER_POS |
+			  config->dst_per << CH_CFG2_L_DST_PER_POS;
+		cfg_hi = config->tt_fc << CH_CFG2_H_TT_FC_POS |
+			 config->hs_sel_src << CH_CFG2_H_HS_SEL_SRC_POS |
+			 config->hs_sel_dst << CH_CFG2_H_HS_SEL_DST_POS |
+			 config->prior << CH_CFG2_H_PRIORITY_POS;
+	}
+	axi_chan_iowrite32(chan, CH_CFG_L, cfg_lo);
+	axi_chan_iowrite32(chan, CH_CFG_H, cfg_hi);
+}
+
 static inline void axi_dma_disable(struct axi_dma_chip *chip)
 {
 	u32 val;
@@ -154,7 +180,10 @@ static inline void axi_chan_disable(struct axi_dma_chan *chan)
 
 	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
 	val &= ~(BIT(chan->id) << DMAC_CHAN_EN_SHIFT);
-	val |=   BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
+	if (chan->chip->dw->hdata->reg_map_8_channels)
+		val |=   BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
+	else
+		val |=   BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
 	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
 }
 
@@ -163,8 +192,12 @@ static inline void axi_chan_enable(struct axi_dma_chan *chan)
 	u32 val;
 
 	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-	val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
-	       BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
+	if (chan->chip->dw->hdata->reg_map_8_channels)
+		val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
+			BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
+	else
+		val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
+			BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
 	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
 }
 
@@ -336,7 +369,8 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 				      struct axi_dma_desc *first)
 {
 	u32 priority = chan->chip->dw->hdata->priority[chan->id];
-	u32 reg, irq_mask;
+	struct axi_dma_chan_config config;
+	u32 irq_mask;
 	u8 lms = 0; /* Select AXI0 master for LLI fetching */
 
 	if (unlikely(axi_chan_is_hw_enable(chan))) {
@@ -348,36 +382,32 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 
 	axi_dma_enable(chan->chip);
 
-	reg = (DWAXIDMAC_MBLK_TYPE_LL << CH_CFG_L_DST_MULTBLK_TYPE_POS |
-	       DWAXIDMAC_MBLK_TYPE_LL << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
-	axi_chan_iowrite32(chan, CH_CFG_L, reg);
-
-	reg = (DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC << CH_CFG_H_TT_FC_POS |
-	       priority << CH_CFG_H_PRIORITY_POS |
-	       DWAXIDMAC_HS_SEL_HW << CH_CFG_H_HS_SEL_DST_POS |
-	       DWAXIDMAC_HS_SEL_HW << CH_CFG_H_HS_SEL_SRC_POS);
+	config.dst_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
+	config.src_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
+	config.tt_fc = DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;
+	config.prior = priority;
+	config.hs_sel_dst = DWAXIDMAC_HS_SEL_HW;
+	config.hs_sel_dst = DWAXIDMAC_HS_SEL_HW;
 	switch (chan->direction) {
 	case DMA_MEM_TO_DEV:
 		dw_axi_dma_set_byte_halfword(chan, true);
-		reg |= (chan->config.device_fc ?
-			DWAXIDMAC_TT_FC_MEM_TO_PER_DST :
-			DWAXIDMAC_TT_FC_MEM_TO_PER_DMAC)
-			<< CH_CFG_H_TT_FC_POS;
+		config.tt_fc = chan->config.device_fc ?
+				DWAXIDMAC_TT_FC_MEM_TO_PER_DST :
+				DWAXIDMAC_TT_FC_MEM_TO_PER_DMAC;
 		if (chan->chip->apb_regs)
-			reg |= (chan->id << CH_CFG_H_DST_PER_POS);
+			config.dst_per = chan->id;
 		break;
 	case DMA_DEV_TO_MEM:
-		reg |= (chan->config.device_fc ?
-			DWAXIDMAC_TT_FC_PER_TO_MEM_SRC :
-			DWAXIDMAC_TT_FC_PER_TO_MEM_DMAC)
-			<< CH_CFG_H_TT_FC_POS;
+		config.tt_fc = chan->config.device_fc ?
+				DWAXIDMAC_TT_FC_PER_TO_MEM_SRC :
+				DWAXIDMAC_TT_FC_PER_TO_MEM_DMAC;
 		if (chan->chip->apb_regs)
-			reg |= (chan->id << CH_CFG_H_SRC_PER_POS);
+			config.src_per = chan->id;
 		break;
 	default:
 		break;
 	}
-	axi_chan_iowrite32(chan, CH_CFG_H, reg);
+	axi_chan_config_write(chan, &config);
 
 	write_chan_llp(chan, first->hw_desc[0].llp | lms);
 
@@ -1120,10 +1150,17 @@ static int dma_chan_pause(struct dma_chan *dchan)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
-	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-	val |= BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT |
-	       BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
-	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+	if (chan->chip->dw->hdata->reg_map_8_channels) {
+		val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+		val |= BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT |
+			BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
+		axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+	} else {
+		val = 0;
+		val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
+			BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
+		axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, val);
+	}
 
 	do  {
 		if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED)
@@ -1147,9 +1184,15 @@ static inline void axi_chan_resume(struct axi_dma_chan *chan)
 	u32 val;
 
 	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-	val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT);
-	val |=  (BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT);
-	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+	if (chan->chip->dw->hdata->reg_map_8_channels) {
+		val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT);
+		val |=  (BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT);
+		axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+	} else {
+		val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT);
+		val |=  (BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT);
+		axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, val);
+	}
 
 	chan->is_paused = false;
 }
@@ -1241,6 +1284,8 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 		return -EINVAL;
 
 	chip->dw->hdata->nr_channels = tmp;
+	if (tmp <= DMA_REG_MAP_CH_REF)
+		chip->dw->hdata->reg_map_8_channels = true;
 
 	ret = device_property_read_u32(dev, "snps,dma-masters", &tmp);
 	if (ret)
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 380005afde16..be69a0b76860 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -18,7 +18,7 @@
 
 #include "../virt-dma.h"
 
-#define DMAC_MAX_CHANNELS	8
+#define DMAC_MAX_CHANNELS	16
 #define DMAC_MAX_MASTERS	2
 #define DMAC_MAX_BLK_SIZE	0x200000
 
@@ -30,6 +30,8 @@ struct dw_axi_dma_hcfg {
 	u32	priority[DMAC_MAX_CHANNELS];
 	/* maximum supported axi burst length */
 	u32	axi_rw_burst_len;
+	/* Register map for DMAX_NUM_CHANNELS <= 8 */
+	bool	reg_map_8_channels;
 	bool	restrict_axi_burst_len;
 };
 
@@ -103,6 +105,17 @@ struct axi_dma_desc {
 	u32				period_len;
 };
 
+struct axi_dma_chan_config {
+	u8 dst_multblk_type;
+	u8 src_multblk_type;
+	u8 dst_per;
+	u8 src_per;
+	u8 tt_fc;
+	u8 prior;
+	u8 hs_sel_dst;
+	u8 hs_sel_src;
+};
+
 static inline struct device *dchan2dev(struct dma_chan *dchan)
 {
 	return &dchan->dev->device;
@@ -139,6 +152,8 @@ static inline struct axi_dma_chan *dchan_to_axi_dma_chan(struct dma_chan *dchan)
 #define DMAC_CHEN		0x018 /* R/W DMAC Channel Enable */
 #define DMAC_CHEN_L		0x018 /* R/W DMAC Channel Enable 00-31 */
 #define DMAC_CHEN_H		0x01C /* R/W DMAC Channel Enable 32-63 */
+#define DMAC_CHSUSPREG		0x020 /* R/W DMAC Channel Suspend */
+#define DMAC_CHABORTREG		0x028 /* R/W DMAC Channel Abort */
 #define DMAC_INTSTATUS		0x030 /* R DMAC Interrupt Status */
 #define DMAC_COMMON_INTCLEAR	0x038 /* W DMAC Interrupt Clear */
 #define DMAC_COMMON_INTSTATUS_ENA 0x040 /* R DMAC Interrupt Status Enable */
@@ -187,6 +202,7 @@ static inline struct axi_dma_chan *dchan_to_axi_dma_chan(struct dma_chan *dchan)
 #define DMA_APB_HS_SEL_BIT_SIZE	0x08 /* HW handshake bits per channel */
 #define DMA_APB_HS_SEL_MASK	0xFF /* HW handshake select masks */
 #define MAX_BLOCK_SIZE		0x1000 /* 1024 blocks * 4 bytes data width */
+#define DMA_REG_MAP_CH_REF	0x08 /* Channel count to choose register map */
 
 /* DMAC_CFG */
 #define DMAC_EN_POS			0
@@ -195,12 +211,20 @@ static inline struct axi_dma_chan *dchan_to_axi_dma_chan(struct dma_chan *dchan)
 #define INT_EN_POS			1
 #define INT_EN_MASK			BIT(INT_EN_POS)
 
+/* DMAC_CHEN */
 #define DMAC_CHAN_EN_SHIFT		0
 #define DMAC_CHAN_EN_WE_SHIFT		8
 
 #define DMAC_CHAN_SUSP_SHIFT		16
 #define DMAC_CHAN_SUSP_WE_SHIFT		24
 
+/* DMAC_CHEN2 */
+#define DMAC_CHAN_EN2_WE_SHIFT		16
+
+/* DMAC_CHSUSP */
+#define DMAC_CHAN_SUSP2_SHIFT		0
+#define DMAC_CHAN_SUSP2_WE_SHIFT	16
+
 /* CH_CTL_H */
 #define CH_CTL_H_ARLEN_EN		BIT(6)
 #define CH_CTL_H_ARLEN_POS		7
@@ -289,6 +313,15 @@ enum {
 	DWAXIDMAC_MBLK_TYPE_LL
 };
 
+/* CH_CFG2 */
+#define CH_CFG2_L_SRC_PER_POS		4
+#define CH_CFG2_L_DST_PER_POS		11
+
+#define CH_CFG2_H_TT_FC_POS		0
+#define CH_CFG2_H_HS_SEL_SRC_POS	3
+#define CH_CFG2_H_HS_SEL_DST_POS	4
+#define CH_CFG2_H_PRIORITY_POS		20
+
 /**
  * DW AXI DMA channel interrupts
  *
-- 
2.17.1

