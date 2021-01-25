Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2FF30205D
	for <lists+dmaengine@lfdr.de>; Mon, 25 Jan 2021 03:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbhAYByz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Jan 2021 20:54:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:4252 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbhAYByj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 24 Jan 2021 20:54:39 -0500
IronPort-SDR: p6V6K6pVAJF/4tkbvFFQCQ1dGoLEWQxRS8H2gLIJQPTwafrznu9wdbgCBTvdb7om+ugWEEoTJk
 RGjQOFLy1T5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176137839"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="176137839"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 17:51:07 -0800
IronPort-SDR: ipso8imZOBgp58ngVvzDRu3rqvMttaPr2HNVyjWHgVoM1qkRMkEXhnpK+3b6Oy0nrw96xMRePU
 qAFhuITcILEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="352796010"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2021 17:51:04 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v12 15/17] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD registers
Date:   Mon, 25 Jan 2021 09:32:53 +0800
Message-Id: <20210125013255.25799-16-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210125013255.25799-1-jee.heng.sia@intel.com>
References: <20210125013255.25799-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay AxiDMA BYTE and HALFWORD registers
programming.

Intel KeemBay AxiDMA supports data transfer between device to memory
and memory to device operations.

This code is needed by I2C, I3C, I2S, SPI and UART which uses FIFO
size of 8bits and 16bits to perform memory to device data transfer
operation. 0-padding functionality is provided to avoid
pre-processing of data on CPU.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index e19369f9365a..a1dddec95316 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -307,6 +307,29 @@ static void write_chan_llp(struct axi_dma_chan *chan, dma_addr_t adr)
 	axi_chan_iowrite64(chan, CH_LLP, adr);
 }
 
+static void dw_axi_dma_set_byte_halfword(struct axi_dma_chan *chan, bool set)
+{
+	u32 offset = DMAC_APB_BYTE_WR_CH_EN;
+	u32 reg_width, val;
+
+	if (!chan->chip->apb_regs) {
+		dev_dbg(chan->chip->dev, "apb_regs not initialized\n");
+		return;
+	}
+
+	reg_width = __ffs(chan->config.dst_addr_width);
+	if (reg_width == DWAXIDMAC_TRANS_WIDTH_16)
+		offset = DMAC_APB_HALFWORD_WR_CH_EN;
+
+	val = ioread32(chan->chip->apb_regs + offset);
+
+	if (set)
+		val |= BIT(chan->id);
+	else
+		val &= ~BIT(chan->id);
+
+	iowrite32(val, chan->chip->apb_regs + offset);
+}
 /* Called in chan locked context */
 static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 				      struct axi_dma_desc *first)
@@ -334,6 +357,7 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	       DWAXIDMAC_HS_SEL_HW << CH_CFG_H_HS_SEL_SRC_POS);
 	switch (chan->direction) {
 	case DMA_MEM_TO_DEV:
+		dw_axi_dma_set_byte_halfword(chan, true);
 		reg |= (chan->config.device_fc ?
 			DWAXIDMAC_TT_FC_MEM_TO_PER_DST :
 			DWAXIDMAC_TT_FC_MEM_TO_PER_DMAC)
@@ -1008,6 +1032,8 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	if (chan->direction != DMA_MEM_TO_MEM)
 		dw_axi_dma_set_hw_channel(chan->chip,
 					  chan->hw_handshake_num, false);
+	if (chan->direction == DMA_MEM_TO_DEV)
+		dw_axi_dma_set_byte_halfword(chan, false);
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
-- 
2.18.0

