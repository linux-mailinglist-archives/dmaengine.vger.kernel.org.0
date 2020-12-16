Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBF22DB914
	for <lists+dmaengine@lfdr.de>; Wed, 16 Dec 2020 03:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgLPC2e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 21:28:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:26382 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgLPC2e (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Dec 2020 21:28:34 -0500
IronPort-SDR: MYt/8QLjjjEdv+TlNGO9yCmYAoy8D/CXCCCZE4H+nCqx0HofiKv9xq0/CpBYGGo7cmx/tU7uCG
 d8MCyLLTDV1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="259716477"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="259716477"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 18:27:18 -0800
IronPort-SDR: VFROEsgvjyeUfZaCf/BNhLOZ0+tDNohxyzOYPXDzxwX2/gjDa2Mzdwx5QTcHdE1IX/o3nk7yIs
 7tJkr0Mfok+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="557080835"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2020 18:27:15 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 13/16] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA handshake
Date:   Wed, 16 Dec 2020 10:10:00 +0800
Message-Id: <20201216021003.26911-14-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201216021003.26911-1-jee.heng.sia@intel.com>
References: <20201216021003.26911-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay AxiDMA device handshake programming.
Device handshake number passed in to the AxiDMA shall be written to
the Intel KeemBay AxiDMA hardware handshake registers before DMA
operations are started.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 8135b827b47a..440f9a8b25da 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -445,6 +445,48 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
 	pm_runtime_put(chan->chip->dev);
 }
 
+static int dw_axi_dma_set_hw_channel(struct axi_dma_chip *chip,
+				     u32 handshake_num, bool set)
+{
+	unsigned long start = 0;
+	unsigned long reg_value;
+	unsigned long reg_mask;
+	unsigned long reg_set;
+	unsigned long mask;
+	unsigned long val;
+
+	if (!chip->apb_regs)
+		return -ENODEV;
+
+	/*
+	 * An unused DMA channel has a default value of 0x3F.
+	 * Lock the DMA channel by assign a handshake number to the channel.
+	 * Unlock the DMA channel by assign 0x3F to the channel.
+	 */
+	if (set) {
+		reg_set = UNUSED_CHANNEL;
+		val = handshake_num;
+	} else {
+		reg_set = handshake_num;
+		val = UNUSED_CHANNEL;
+	}
+
+	reg_value = lo_hi_readq(chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
+
+	for_each_set_clump8(start, reg_mask, &reg_value, 64) {
+		if (reg_mask == reg_set) {
+			mask = GENMASK_ULL(start + 7, start);
+			reg_value &= ~mask;
+			reg_value |= rol64(val, start);
+			lo_hi_writeq(reg_value,
+				     chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * If DW_axi_dmac sees CHx_CTL.ShadowReg_Or_LLI_Last bit of the fetched LLI
  * as 1, it understands that the current block is the final block in the
@@ -626,6 +668,9 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 		llp = hw_desc->llp;
 	} while (num_periods);
 
+	if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true))
+		goto err_desc_get;
+
 	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
 
 err_desc_get:
@@ -684,6 +729,9 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		llp = hw_desc->llp;
 	} while (sg_len);
 
+	if (dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true))
+		goto err_desc_get;
+
 	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
 
 err_desc_get:
@@ -959,6 +1007,10 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 		dev_warn(dchan2dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
 
+	if (chan->direction != DMA_MEM_TO_MEM)
+		dw_axi_dma_set_hw_channel(chan->chip,
+					  chan->hw_handshake_num, false);
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
 	vchan_get_all_descriptors(&chan->vc, &head);
-- 
2.18.0

