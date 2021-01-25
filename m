Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABFA302016
	for <lists+dmaengine@lfdr.de>; Mon, 25 Jan 2021 02:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbhAYBxh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Jan 2021 20:53:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:4252 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbhAYBxI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 24 Jan 2021 20:53:08 -0500
IronPort-SDR: r6awgNFzaJDHUV1OwK676Vs3/kfwntssdKxl+tmabCEkJUQlZQ8UQafPKWuugxGDX2cqEgs24I
 MqupGbwz7olQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176137826"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="176137826"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 17:50:54 -0800
IronPort-SDR: B/jBRTOdLijRtk6dL0DuwfSlssVhFKVDVk7izsaJue1MqEgRskuG3WqESOu2F1EzxorAKSNPdG
 yadRnH0c8qGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="352795969"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2021 17:50:52 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v12 11/17] dmaengine: dw-axi-dmac: Add Intel KeemBay DMA register fields
Date:   Mon, 25 Jan 2021 09:32:49 +0800
Message-Id: <20210125013255.25799-12-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210125013255.25799-1-jee.heng.sia@intel.com>
References: <20210125013255.25799-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay DMA registers. These registers are required
to run data transfer between device to memory and memory to device on Intel
KeemBay SoC.

Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Tested-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 46baf93de617..3a357f7fda02 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -63,6 +63,7 @@ struct axi_dma_chip {
 	struct device		*dev;
 	int			irq;
 	void __iomem		*regs;
+	void __iomem		*apb_regs;
 	struct clk		*core_clk;
 	struct clk		*cfgr_clk;
 	struct dw_axi_dma	*dw;
@@ -169,6 +170,19 @@ static inline struct axi_dma_chan *dchan_to_axi_dma_chan(struct dma_chan *dchan)
 #define CH_INTSIGNAL_ENA	0x090 /* R/W Chan Interrupt Signal Enable */
 #define CH_INTCLEAR		0x098 /* W Chan Interrupt Clear */
 
+/* These Apb registers are used by Intel KeemBay SoC */
+#define DMAC_APB_CFG		0x000 /* DMAC Apb Configuration Register */
+#define DMAC_APB_STAT		0x004 /* DMAC Apb Status Register */
+#define DMAC_APB_DEBUG_STAT_0	0x008 /* DMAC Apb Debug Status Register 0 */
+#define DMAC_APB_DEBUG_STAT_1	0x00C /* DMAC Apb Debug Status Register 1 */
+#define DMAC_APB_HW_HS_SEL_0	0x010 /* DMAC Apb HW HS register 0 */
+#define DMAC_APB_HW_HS_SEL_1	0x014 /* DMAC Apb HW HS register 1 */
+#define DMAC_APB_LPI		0x018 /* DMAC Apb Low Power Interface Reg */
+#define DMAC_APB_BYTE_WR_CH_EN	0x01C /* DMAC Apb Byte Write Enable */
+#define DMAC_APB_HALFWORD_WR_CH_EN	0x020 /* DMAC Halfword write enables */
+
+#define UNUSED_CHANNEL		0x3F /* Set unused DMA channel to 0x3F */
+#define MAX_BLOCK_SIZE		0x1000 /* 1024 blocks * 4 bytes data width */
 
 /* DMAC_CFG */
 #define DMAC_EN_POS			0
-- 
2.18.0

