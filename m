Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEA29020C
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 11:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406164AbgJPJjJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 05:39:09 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:62759 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406162AbgJPJjJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Oct 2020 05:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602841148; x=1634377148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jvbP/Zad1CYHUtJvc7y5mtZervsfI7swMAlVWWhT+Ac=;
  b=EOM9mNsshljE94BsLM6LytJx14B3WZsyUdYA/Ckh4skZD+rJ826oj2dT
   LmB9lvCSwCfxEthmIeCAfzlkgDJr/MQbPBGVeq+zPPW3mHGkL7AA3/49d
   W+GuTrp4P3gQfTPlAywFxxO2Tmg1mKBVlrRHX7/OhS32naXzrYVXHzW20
   GNe56vx5bffBTTwMd2AuS1GjgSmDSiKUUGBHWPyagQeefHwsv8o9h/g4L
   hfXlruOehjsObq/7LVkvm4iPUP3Vg4kuCnXjCfY1AgBEZ3PIWfQ2t8pr1
   VIWy3Iw2yAaC0kWHb9QAYQRG9VRkS2JaKlD/WACFqGNSPh2xbkztI1Egj
   Q==;
IronPort-SDR: oTkIA8SDqLC/4UiP4xPrbdk3/CgU+FYT2pfee5ss18zjgwQiMZpA9ndnioGht7uF9v0Sk4oLkB
 QpyL28NDi1l/7wG6oIzLAYDLwpJ1GFFqki1fdxFIxwJ+01ylQTYfbm6Ix6w8W1lO+nbTqkUDfc
 EoSkreiz/7VWUrM9zh2RNYGwFACPG1oWktGplbEkbO8tuCn/5zIOsfuP2yl2Leh92pHjiIwZTp
 QU3Wu9RMoD5Tk8w/mIweYe1yJkgMmbf8M1E6PBE1l5Uhe2VjRrJRCtPanOcWbzJPJAYt3xEqW5
 t1c=
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="92865487"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Oct 2020 02:39:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 16 Oct 2020 02:38:56 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 16 Oct 2020 02:38:53 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <tudor.ambarus@microchip.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v2 3/4] dmaengine: at_xdmac: add support for sama7g5 based at_xdmac
Date:   Fri, 16 Oct 2020 12:38:50 +0300
Message-ID: <20201016093850.290053-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SAMA7G5 SoC uses a slightly different variant of the AT_XDMAC.
Added support by a new compatible and a layout struct that copes
to the specific version considering the compatible string.
Only the differences in register map are present in the layout struct.
I reworked the register access for this part that has the differences.
Also the Source/Destination Interface bits are no longer valid for this
variant of the XDMAC. Thus, the layout also has a bool for specifying
whether these bits are required or not.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v2:
- removed patch that was moving the register definitions to a different file
- changed according to review from Tudor : removed SIF(0)/DIF(0) and
added comments, changed alignment on some 'or' operations, added const on
layouts structs

 drivers/dma/at_xdmac.c | 110 +++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 94f7023472bb..bfbf6375c293 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -38,13 +38,6 @@
 #define AT_XDMAC_GE		0x1C	/* Global Channel Enable Register */
 #define AT_XDMAC_GD		0x20	/* Global Channel Disable Register */
 #define AT_XDMAC_GS		0x24	/* Global Channel Status Register */
-#define AT_XDMAC_GRS		0x28	/* Global Channel Read Suspend Register */
-#define AT_XDMAC_GWS		0x2C	/* Global Write Suspend Register */
-#define AT_XDMAC_GRWS		0x30	/* Global Channel Read Write Suspend Register */
-#define AT_XDMAC_GRWR		0x34	/* Global Channel Read Write Resume Register */
-#define AT_XDMAC_GSWR		0x38	/* Global Channel Software Request Register */
-#define AT_XDMAC_GSWS		0x3C	/* Global channel Software Request Status Register */
-#define AT_XDMAC_GSWF		0x40	/* Global Channel Software Flush Request Register */
 #define AT_XDMAC_VERSION	0xFFC	/* XDMAC Version Register */
 
 /* Channel relative registers offsets */
@@ -150,8 +143,6 @@
 #define AT_XDMAC_CSUS		0x30	/* Channel Source Microblock Stride */
 #define AT_XDMAC_CDUS		0x34	/* Channel Destination Microblock Stride */
 
-#define AT_XDMAC_CHAN_REG_BASE	0x50	/* Channel registers base address */
-
 /* Microblock control members */
 #define AT_XDMAC_MBR_UBC_UBLEN_MAX	0xFFFFFFUL	/* Maximum Microblock Length */
 #define AT_XDMAC_MBR_UBC_NDE		(0x1 << 24)	/* Next Descriptor Enable */
@@ -179,6 +170,27 @@ enum atc_status {
 	AT_XDMAC_CHAN_IS_PAUSED,
 };
 
+struct at_xdmac_layout {
+	/* Global Channel Read Suspend Register */
+	u8				grs;
+	/* Global Write Suspend Register */
+	u8				gws;
+	/* Global Channel Read Write Suspend Register */
+	u8				grws;
+	/* Global Channel Read Write Resume Register */
+	u8				grwr;
+	/* Global Channel Software Request Register */
+	u8				gswr;
+	/* Global channel Software Request Status Register */
+	u8				gsws;
+	/* Global Channel Software Flush Request Register */
+	u8				gswf;
+	/* Channel reg base */
+	u8				chan_cc_reg_base;
+	/* Source/Destination Interface must be specified or not */
+	bool				sdif;
+};
+
 /* ----- Channels ----- */
 struct at_xdmac_chan {
 	struct dma_chan			chan;
@@ -212,6 +224,7 @@ struct at_xdmac {
 	struct clk		*clk;
 	u32			save_gim;
 	struct dma_pool		*at_xdmac_desc_pool;
+	const struct at_xdmac_layout	*layout;
 	struct at_xdmac_chan	chan[];
 };
 
@@ -244,9 +257,33 @@ struct at_xdmac_desc {
 	struct list_head		xfer_node;
 } __aligned(sizeof(u64));
 
+static const struct at_xdmac_layout at_xdmac_sama5d4_layout = {
+	.grs = 0x28,
+	.gws = 0x2C,
+	.grws = 0x30,
+	.grwr = 0x34,
+	.gswr = 0x38,
+	.gsws = 0x3C,
+	.gswf = 0x40,
+	.chan_cc_reg_base = 0x50,
+	.sdif = true,
+};
+
+static const struct at_xdmac_layout at_xdmac_sama7g5_layout = {
+	.grs = 0x30,
+	.gws = 0x38,
+	.grws = 0x40,
+	.grwr = 0x44,
+	.gswr = 0x48,
+	.gsws = 0x4C,
+	.gswf = 0x50,
+	.chan_cc_reg_base = 0x60,
+	.sdif = false,
+};
+
 static inline void __iomem *at_xdmac_chan_reg_base(struct at_xdmac *atxdmac, unsigned int chan_nb)
 {
-	return atxdmac->regs + (AT_XDMAC_CHAN_REG_BASE + chan_nb * 0x40);
+	return atxdmac->regs + (atxdmac->layout->chan_cc_reg_base + chan_nb * 0x40);
 }
 
 #define at_xdmac_read(atxdmac, reg) readl_relaxed((atxdmac)->regs + (reg))
@@ -345,8 +382,10 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 	first->active_xfer = true;
 
 	/* Tell xdmac where to get the first descriptor. */
-	reg = AT_XDMAC_CNDA_NDA(first->tx_dma_desc.phys)
-	      | AT_XDMAC_CNDA_NDAIF(atchan->memif);
+	reg = AT_XDMAC_CNDA_NDA(first->tx_dma_desc.phys);
+	if (atxdmac->layout->sdif)
+		reg |= AT_XDMAC_CNDA_NDAIF(atchan->memif);
+
 	at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, reg);
 
 	/*
@@ -541,6 +580,7 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
 				      enum dma_transfer_direction direction)
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
 	int			csize, dwidth;
 
 	if (direction == DMA_DEV_TO_MEM) {
@@ -548,12 +588,14 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
 			AT91_XDMAC_DT_PERID(atchan->perid)
 			| AT_XDMAC_CC_DAM_INCREMENTED_AM
 			| AT_XDMAC_CC_SAM_FIXED_AM
-			| AT_XDMAC_CC_DIF(atchan->memif)
-			| AT_XDMAC_CC_SIF(atchan->perif)
 			| AT_XDMAC_CC_SWREQ_HWR_CONNECTED
 			| AT_XDMAC_CC_DSYNC_PER2MEM
 			| AT_XDMAC_CC_MBSIZE_SIXTEEN
 			| AT_XDMAC_CC_TYPE_PER_TRAN;
+		if (atxdmac->layout->sdif)
+			atchan->cfg |= AT_XDMAC_CC_DIF(atchan->memif) |
+				       AT_XDMAC_CC_SIF(atchan->perif);
+
 		csize = ffs(atchan->sconfig.src_maxburst) - 1;
 		if (csize < 0) {
 			dev_err(chan2dev(chan), "invalid src maxburst value\n");
@@ -571,12 +613,14 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
 			AT91_XDMAC_DT_PERID(atchan->perid)
 			| AT_XDMAC_CC_DAM_FIXED_AM
 			| AT_XDMAC_CC_SAM_INCREMENTED_AM
-			| AT_XDMAC_CC_DIF(atchan->perif)
-			| AT_XDMAC_CC_SIF(atchan->memif)
 			| AT_XDMAC_CC_SWREQ_HWR_CONNECTED
 			| AT_XDMAC_CC_DSYNC_MEM2PER
 			| AT_XDMAC_CC_MBSIZE_SIXTEEN
 			| AT_XDMAC_CC_TYPE_PER_TRAN;
+		if (atxdmac->layout->sdif)
+			atchan->cfg |= AT_XDMAC_CC_DIF(atchan->perif) |
+				       AT_XDMAC_CC_SIF(atchan->memif);
+
 		csize = ffs(atchan->sconfig.dst_maxburst) - 1;
 		if (csize < 0) {
 			dev_err(chan2dev(chan), "invalid src maxburst value\n");
@@ -866,10 +910,12 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 	 * ERRATA: Even if useless for memory transfers, the PERID has to not
 	 * match the one of another channel. If not, it could lead to spurious
 	 * flag status.
+	 * For SAMA7G5x case, the SIF and DIF fields are no longer used.
+	 * Thus, no need to have the SIF/DIF interfaces here.
+	 * For SAMA5D4x and SAMA5D2x the SIF and DIF are already configured as
+	 * zero.
 	 */
 	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
-					| AT_XDMAC_CC_DIF(0)
-					| AT_XDMAC_CC_SIF(0)
 					| AT_XDMAC_CC_MBSIZE_SIXTEEN
 					| AT_XDMAC_CC_TYPE_MEM_TRAN;
 
@@ -1048,12 +1094,14 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	 * ERRATA: Even if useless for memory transfers, the PERID has to not
 	 * match the one of another channel. If not, it could lead to spurious
 	 * flag status.
+	 * For SAMA7G5x case, the SIF and DIF fields are no longer used.
+	 * Thus, no need to have the SIF/DIF interfaces here.
+	 * For SAMA5D4x and SAMA5D2x the SIF and DIF are already configured as
+	 * zero.
 	 */
 	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
 					| AT_XDMAC_CC_DAM_INCREMENTED_AM
 					| AT_XDMAC_CC_SAM_INCREMENTED_AM
-					| AT_XDMAC_CC_DIF(0)
-					| AT_XDMAC_CC_SIF(0)
 					| AT_XDMAC_CC_MBSIZE_SIXTEEN
 					| AT_XDMAC_CC_TYPE_MEM_TRAN;
 	unsigned long		irqflags;
@@ -1154,12 +1202,14 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 	 * ERRATA: Even if useless for memory transfers, the PERID has to not
 	 * match the one of another channel. If not, it could lead to spurious
 	 * flag status.
+	 * For SAMA7G5x case, the SIF and DIF fields are no longer used.
+	 * Thus, no need to have the SIF/DIF interfaces here.
+	 * For SAMA5D4x and SAMA5D2x the SIF and DIF are already configured as
+	 * zero.
 	 */
 	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
 					| AT_XDMAC_CC_DAM_UBS_AM
 					| AT_XDMAC_CC_SAM_INCREMENTED_AM
-					| AT_XDMAC_CC_DIF(0)
-					| AT_XDMAC_CC_SIF(0)
 					| AT_XDMAC_CC_MBSIZE_SIXTEEN
 					| AT_XDMAC_CC_MEMSET_HW_MODE
 					| AT_XDMAC_CC_TYPE_MEM_TRAN;
@@ -1438,7 +1488,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	mask = AT_XDMAC_CC_TYPE | AT_XDMAC_CC_DSYNC;
 	value = AT_XDMAC_CC_TYPE_PER_TRAN | AT_XDMAC_CC_DSYNC_PER2MEM;
 	if ((desc->lld.mbr_cfg & mask) == value) {
-		at_xdmac_write(atxdmac, AT_XDMAC_GSWF, atchan->mask);
+		at_xdmac_write(atxdmac, atxdmac->layout->gswf, atchan->mask);
 		while (!(at_xdmac_chan_read(atchan, AT_XDMAC_CIS) & AT_XDMAC_CIS_FIS))
 			cpu_relax();
 	}
@@ -1496,7 +1546,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	 * FIFO flush ensures that data are really written.
 	 */
 	if ((desc->lld.mbr_cfg & mask) == value) {
-		at_xdmac_write(atxdmac, AT_XDMAC_GSWF, atchan->mask);
+		at_xdmac_write(atxdmac, atxdmac->layout->gswf, atchan->mask);
 		while (!(at_xdmac_chan_read(atchan, AT_XDMAC_CIS) & AT_XDMAC_CIS_FIS))
 			cpu_relax();
 	}
@@ -1761,7 +1811,7 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
 		return 0;
 
 	spin_lock_irqsave(&atchan->lock, flags);
-	at_xdmac_write(atxdmac, AT_XDMAC_GRWS, atchan->mask);
+	at_xdmac_write(atxdmac, atxdmac->layout->grws, atchan->mask);
 	while (at_xdmac_chan_read(atchan, AT_XDMAC_CC)
 	       & (AT_XDMAC_CC_WRIP | AT_XDMAC_CC_RDIP))
 		cpu_relax();
@@ -1784,7 +1834,7 @@ static int at_xdmac_device_resume(struct dma_chan *chan)
 		return 0;
 	}
 
-	at_xdmac_write(atxdmac, AT_XDMAC_GRWR, atchan->mask);
+	at_xdmac_write(atxdmac, atxdmac->layout->grwr, atchan->mask);
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
@@ -1986,6 +2036,10 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	atxdmac->regs = base;
 	atxdmac->irq = irq;
 
+	atxdmac->layout = of_device_get_match_data(&pdev->dev);
+	if (!atxdmac->layout)
+		return -ENODEV;
+
 	atxdmac->clk = devm_clk_get(&pdev->dev, "dma_clk");
 	if (IS_ERR(atxdmac->clk)) {
 		dev_err(&pdev->dev, "can't get dma_clk\n");
@@ -2129,6 +2183,10 @@ static const struct dev_pm_ops atmel_xdmac_dev_pm_ops = {
 static const struct of_device_id atmel_xdmac_dt_ids[] = {
 	{
 		.compatible = "atmel,sama5d4-dma",
+		.data = &at_xdmac_sama5d4_layout,
+	}, {
+		.compatible = "microchip,sama7g5-dma",
+		.data = &at_xdmac_sama7g5_layout,
 	}, {
 		/* sentinel */
 	}
-- 
2.25.1

