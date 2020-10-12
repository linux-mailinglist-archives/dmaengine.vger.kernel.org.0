Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7085F28AD33
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 06:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgJLEjq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 00:39:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:21626 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgJLEjd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Oct 2020 00:39:33 -0400
IronPort-SDR: C/Cp4bVIJtYhwz+kV24W/B6H6tY7aNUkhZ8jqCMmt9cWudtCisBy8fOT50Ixk7Qg3zESHVqNk/
 uspNSVQn+VBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="164903198"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="164903198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 21:39:31 -0700
IronPort-SDR: 84bIOb9DVxY1oydbIm52UxACwFRkVPlYhCthP6Apgn7FzFzMyKUr1PJQha8nN9zzqDtoXjBPCA
 cd/GBXjmSlpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="313321386"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com) ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2020 21:39:29 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD registers
Date:   Mon, 12 Oct 2020 12:21:59 +0800
Message-Id: <20201012042200.29787-15-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201012042200.29787-1-jee.heng.sia@intel.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 44 ++++++++++++++++---
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 0f40b41fd5c0..d4fca3ffe67f 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -312,7 +312,7 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 				      struct axi_dma_desc *first)
 {
 	u32 priority = chan->chip->dw->hdata->priority[chan->id];
-	u32 reg, irq_mask;
+	u32 reg, irq_mask, reg_width, offset, val;
 	u8 lms = 0; /* Select AXI0 master for LLI fetching */
 
 	if (unlikely(axi_chan_is_hw_enable(chan))) {
@@ -334,6 +334,25 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	       DWAXIDMAC_HS_SEL_HW << CH_CFG_H_HS_SEL_SRC_POS);
 	switch (chan->direction) {
 	case DMA_MEM_TO_DEV:
+		if (chan->chip->apb_regs) {
+			reg_width = __ffs(chan->config.dst_addr_width);
+			/*
+			 * Configure Byte and Halfword register
+			 * for MEM_TO_DEV only.
+			 */
+			if (reg_width == DWAXIDMAC_TRANS_WIDTH_16) {
+				offset = DMAC_APB_HALFWORD_WR_CH_EN;
+				val = ioread32(chan->chip->apb_regs + offset);
+				val |= BIT(chan->id);
+				iowrite32(val, chan->chip->apb_regs + offset);
+			} else if (reg_width == DWAXIDMAC_TRANS_WIDTH_8) {
+				offset = DMAC_APB_BYTE_WR_CH_EN;
+				val = ioread32(chan->chip->apb_regs + offset);
+				val |= BIT(chan->id);
+				iowrite32(val, chan->chip->apb_regs + offset);
+			}
+		}
+
 		reg |= (chan->config.device_fc ?
 			DWAXIDMAC_TT_FC_MEM_TO_PER_DST :
 			DWAXIDMAC_TT_FC_MEM_TO_PER_DMAC)
@@ -1054,8 +1073,9 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	u32 chan_active = BIT(chan->id) << DMAC_CHAN_EN_SHIFT;
+	u32 reg_width = __ffs(chan->config.dst_addr_width);
 	unsigned long flags;
-	u32 val;
+	u32 offset, val;
 	int ret;
 	LIST_HEAD(head);
 
@@ -1067,9 +1087,23 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 		dev_warn(dchan2dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
 
-	if (chan->direction != DMA_MEM_TO_MEM)
-		dw_axi_dma_set_hw_channel(chan->chip,
-					  chan->hw_hs_num, false);
+	if (chan->direction != DMA_MEM_TO_MEM) {
+		ret = dw_axi_dma_set_hw_channel(chan->chip,
+						chan->hw_hs_num, false);
+		if (ret == 0 && chan->direction == DMA_MEM_TO_DEV) {
+			if (reg_width == DWAXIDMAC_TRANS_WIDTH_8) {
+				offset = DMAC_APB_BYTE_WR_CH_EN;
+				val = ioread32(chan->chip->apb_regs + offset);
+				val &= ~BIT(chan->id);
+				iowrite32(val, chan->chip->apb_regs + offset);
+			} else if (reg_width == DWAXIDMAC_TRANS_WIDTH_16) {
+				offset = DMAC_APB_HALFWORD_WR_CH_EN;
+				val = ioread32(chan->chip->apb_regs + offset);
+				val &= ~BIT(chan->id);
+				iowrite32(val, chan->chip->apb_regs + offset);
+			}
+		}
+	}
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
-- 
2.18.0

