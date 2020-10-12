Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB728AD2C
	for <lists+dmaengine@lfdr.de>; Mon, 12 Oct 2020 06:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgJLEjd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Oct 2020 00:39:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:21608 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgJLEjd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Oct 2020 00:39:33 -0400
IronPort-SDR: lwxhFjS+HHV0NUds2ogkq1GjNI9XizWnGgB2p/TcnhBl3JYi5C675DVXdSYUmraGzW3m1Dcdnz
 9VGIM/0JXiiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="164903191"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="164903191"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 21:39:26 -0700
IronPort-SDR: t4HVJ0k6WlokpKZm3aqpSnlyDZkgOC6vQ1sVaIePIYqBHo9veXl0ZwHCGrYOZBWEinPtSN5Q+H
 QnGLyZWE/YLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="313321367"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com) ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2020 21:39:24 -0700
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     andriy.shevchenko@linux.intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] dmaengine: dw-axi-dmac: Add Intel KeemBay DMA register fields
Date:   Mon, 12 Oct 2020 12:21:57 +0800
Message-Id: <20201012042200.29787-13-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201012042200.29787-1-jee.heng.sia@intel.com>
References: <20201012042200.29787-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for Intel KeemBay DMA registers. These registers are required
to run data transfer between device to memory and memory to device on Intel
KeemBay SoC.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  4 ++++
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index ce89b4dee1dc..19806c586e81 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1252,6 +1252,10 @@ static int dw_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
+	chip->apb_regs = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(chip->apb_regs))
+		dev_warn(&pdev->dev, "apb_regs not supported\n");
+
 	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
 	if (IS_ERR(chip->core_clk))
 		return PTR_ERR(chip->core_clk);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index bdb66d775125..f64e8d33b127 100644
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
 
+/* Apb slave registers */
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

