Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870C32EA26F
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jan 2021 02:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbhAEBB6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Jan 2021 20:01:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:29970 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbhAEBB5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 Jan 2021 20:01:57 -0500
IronPort-SDR: C4hpVlGawEmLcHJ7j/u/wM2TxtHq4S1BdbttBIN2OGshsHGmKKpOj5GmVnoxUoM5VCheOqX/my
 Jtdmzi42P+og==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="261794164"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="261794164"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 17:00:45 -0800
IronPort-SDR: pw525Oy7qhnGlkcwkCbrN7BX9/JbLvpsEvpsNM+4YqdsGyutT1HjzFuqgbR4SMKCWeDBeYEhOg
 gXWUIQezPErw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="569540327"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2021 17:00:43 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v9 13/16] dmaengine: dw-axi-dmac: Add Intel KeemBay AxiDMA handshake
Date:   Tue,  5 Jan 2021 08:43:03 +0800
Message-Id: <20210105004306.13588-14-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210105004306.13588-1-jee.heng.sia@intel.com>
References: <20210105004306.13588-1-jee.heng.sia@intel.com>
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
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 062d27c61983..e19369f9365a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -445,6 +445,48 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
 	pm_runtime_put(chan->chip->dev);
 }
 
+static void dw_axi_dma_set_hw_channel(struct axi_dma_chip *chip,
+				      u32 handshake_num, bool set)
+{
+	unsigned long start = 0;
+	unsigned long reg_value;
+	unsigned long reg_mask;
+	unsigned long reg_set;
+	unsigned long mask;
+	unsigned long val;
+
+	if (!chip->apb_regs) {
+		dev_dbg(chip->dev, "apb_regs not initialized\n");
+		return;
+	}
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
+}
+
 /*
  * If DW_axi_dmac sees CHx_CTL.ShadowReg_Or_LLI_Last bit of the fetched LLI
  * as 1, it understands that the current block is the final block in the
@@ -626,6 +668,8 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 		llp = hw_desc->llp;
 	} while (num_periods);
 
+	dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true);
+
 	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
 
 err_desc_get:
@@ -684,6 +728,8 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		llp = hw_desc->llp;
 	} while (sg_len);
 
+	dw_axi_dma_set_hw_channel(chan->chip, chan->hw_handshake_num, true);
+
 	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
 
 err_desc_get:
@@ -959,6 +1005,10 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
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

