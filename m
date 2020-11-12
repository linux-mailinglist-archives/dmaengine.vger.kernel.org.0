Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74102B01A6
	for <lists+dmaengine@lfdr.de>; Thu, 12 Nov 2020 10:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgKLJHn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Nov 2020 04:07:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:38735 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgKLJHF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Nov 2020 04:07:05 -0500
IronPort-SDR: T/C5kYSVlcGc1lXYwhSEGfpoCwVW4ao6le5FnQhWqD5PLBBLo+Sir1/h6hMuOdrL0/uh/hehly
 FhOzDcHoKIxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="254988326"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="254988326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 01:07:05 -0800
IronPort-SDR: 9aWrweWNYZT96RDMQ+GTTjyJ2l1YmkMro2+3uNs/U8jsA+jv/Mfp5U0KQ7kOAw1EzBKHEGOnrp
 Lfzdn32S6aGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="360911769"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga002.fm.intel.com with ESMTP; 12 Nov 2020 01:07:03 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 14/15] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA BYTE and HALFWORD registers
Date:   Thu, 12 Nov 2020 16:49:52 +0800
Message-Id: <20201112084953.21629-15-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201112084953.21629-1-jee.heng.sia@intel.com>
References: <20201112084953.21629-1-jee.heng.sia@intel.com>
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
index df85f8289f05..812f51c717e6 100644
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
@@ -1000,8 +1019,9 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	u32 chan_active = BIT(chan->id) << DMAC_CHAN_EN_SHIFT;
+	u32 reg_width = __ffs(chan->config.dst_addr_width);
 	unsigned long flags;
-	u32 val;
+	u32 offset, val;
 	int ret;
 	LIST_HEAD(head);
 
@@ -1013,9 +1033,23 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
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

