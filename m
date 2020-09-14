Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA1268CF9
	for <lists+dmaengine@lfdr.de>; Mon, 14 Sep 2020 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgINOKa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Sep 2020 10:10:30 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:19500 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgINOK1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Sep 2020 10:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600092627; x=1631628627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=geI8agSqDEl8zMk40bc/l3d67Msd8KIhzsqdRKAzC9k=;
  b=yW01cK2onJWN0AMezUIBVOlhSSlNJYJF0hrz7yEZor3IJqADlNTIjdBb
   Rn0ko+hvJvhfvoPBx3QvMBjK0xKMQNpLEwTdrLXGVx5xM4DKYMCkg2BQP
   JB7TU9Lktxs12YqvlKBrQP8OyAqtSaunuH19Ds1NVcOzLsYNtxw3Rvkc7
   98dQ4jr4WapVY/GvfvP5n5njR0vg1KKDuC0QQjdTj6oh7mXUE9LxE87zt
   D/AIRv5KE9+o/WZQZDUOVwT7dvktPhIFGEiGuDAWuLgdRDA4pB3hD/n5c
   zEziQHFkIaY0UM/ygHzX/eyNgG7wwe49AXeUanNFwPvJAUF/HzYlIr85d
   A==;
IronPort-SDR: PZl5BTWGTYH55D0umY7G/R7xoLASER18KV/GmTlzTODcpQeDQwkSOYfkkosPuCy5LXaq5hk4vv
 rfUDQUrER10SCtwNCuZ97rW3hF5Liqpg6c7K1QlGQoUimER5+RTu3VQAdeSQyhqeK2sjJXhwY5
 /M6ohUKX8QjhcXc4hFB3lON153zqeYhZXoS+M25Q559YL+gdkXgupBji80mj0hWnJtZXMm5qvd
 c+QeFweJ9E1ATBbIcXXUOpvSxPLw5r0N3DCCNeq/c7soDTnNuXe22pHXtJ6lL/HO0HaO7ZKJAF
 R74=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="90900819"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:10:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:10:23 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 14 Sep 2020 07:10:19 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <tudor.ambarus@microchip.com>, <ludovic.desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 5/7] dmaengine: at_xdmac: add support for sama7g5 based at_xdmac
Date:   Mon, 14 Sep 2020 17:09:54 +0300
Message-ID: <20200914140956.221432-6-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914140956.221432-1-eugen.hristev@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
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
 drivers/dma/at_xdmac.c      | 99 ++++++++++++++++++++++++++++++-------
 drivers/dma/at_xdmac_regs.h |  9 ----
 2 files changed, 82 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 81bb90206092..874484a4e79f 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -38,6 +38,27 @@ enum atc_status {
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
@@ -71,6 +92,7 @@ struct at_xdmac {
 	struct clk		*clk;
 	u32			save_gim;
 	struct dma_pool		*at_xdmac_desc_pool;
+	const struct at_xdmac_layout	*layout;
 	struct at_xdmac_chan	chan[];
 };
 
@@ -103,9 +125,33 @@ struct at_xdmac_desc {
 	struct list_head		xfer_node;
 } __aligned(sizeof(u64));
 
+static struct at_xdmac_layout at_xdmac_sama5d4_layout = {
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
+static struct at_xdmac_layout at_xdmac_sama7g5_layout = {
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
@@ -204,8 +250,10 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
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
@@ -400,6 +448,7 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
 				      enum dma_transfer_direction direction)
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
 	int			csize, dwidth;
 
 	if (direction == DMA_DEV_TO_MEM) {
@@ -407,12 +456,14 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
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
+			atchan->cfg |= AT_XDMAC_CC_DIF(atchan->memif)
+				| AT_XDMAC_CC_SIF(atchan->perif);
+
 		csize = ffs(atchan->sconfig.src_maxburst) - 1;
 		if (csize < 0) {
 			dev_err(chan2dev(chan), "invalid src maxburst value\n");
@@ -430,12 +481,14 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
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
+			atchan->cfg |=  AT_XDMAC_CC_DIF(atchan->perif)
+				| AT_XDMAC_CC_SIF(atchan->memif);
+
 		csize = ffs(atchan->sconfig.dst_maxburst) - 1;
 		if (csize < 0) {
 			dev_err(chan2dev(chan), "invalid src maxburst value\n");
@@ -711,6 +764,7 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 				struct data_chunk *chunk)
 {
 	struct at_xdmac_desc	*desc;
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
 	u32			dwidth;
 	unsigned long		flags;
 	size_t			ublen;
@@ -727,10 +781,10 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 	 * flag status.
 	 */
 	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
-					| AT_XDMAC_CC_DIF(0)
-					| AT_XDMAC_CC_SIF(0)
 					| AT_XDMAC_CC_MBSIZE_SIXTEEN
 					| AT_XDMAC_CC_TYPE_MEM_TRAN;
+	if (atxdmac->layout->sdif)
+		chan_cc |= AT_XDMAC_CC_DIF(0) | AT_XDMAC_CC_SIF(0);
 
 	dwidth = at_xdmac_align_width(chan, src | dst | chunk->size);
 	if (chunk->size >= (AT_XDMAC_MBR_UBC_UBLEN_MAX << dwidth)) {
@@ -893,6 +947,7 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 			 size_t len, unsigned long flags)
 {
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
 	struct at_xdmac_desc	*first = NULL, *prev = NULL;
 	size_t			remaining_size = len, xfer_size = 0, ublen;
 	dma_addr_t		src_addr = src, dst_addr = dest;
@@ -911,12 +966,13 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
 					| AT_XDMAC_CC_DAM_INCREMENTED_AM
 					| AT_XDMAC_CC_SAM_INCREMENTED_AM
-					| AT_XDMAC_CC_DIF(0)
-					| AT_XDMAC_CC_SIF(0)
 					| AT_XDMAC_CC_MBSIZE_SIXTEEN
 					| AT_XDMAC_CC_TYPE_MEM_TRAN;
 	unsigned long		irqflags;
 
+	if (atxdmac->layout->sdif)
+		chan_cc |= AT_XDMAC_CC_DIF(0) | AT_XDMAC_CC_SIF(0);
+
 	dev_dbg(chan2dev(chan), "%s: src=%pad, dest=%pad, len=%zd, flags=0x%lx\n",
 		__func__, &src, &dest, len, flags);
 
@@ -999,6 +1055,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 							 int value)
 {
 	struct at_xdmac_desc	*desc;
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
 	unsigned long		flags;
 	size_t			ublen;
 	u32			dwidth;
@@ -1017,11 +1074,11 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 	u32			chan_cc = AT_XDMAC_CC_PERID(0x7f)
 					| AT_XDMAC_CC_DAM_UBS_AM
 					| AT_XDMAC_CC_SAM_INCREMENTED_AM
-					| AT_XDMAC_CC_DIF(0)
-					| AT_XDMAC_CC_SIF(0)
 					| AT_XDMAC_CC_MBSIZE_SIXTEEN
 					| AT_XDMAC_CC_MEMSET_HW_MODE
 					| AT_XDMAC_CC_TYPE_MEM_TRAN;
+	if (atxdmac->layout->sdif)
+		chan_cc |= AT_XDMAC_CC_DIF(0) | AT_XDMAC_CC_SIF(0);
 
 	dwidth = at_xdmac_align_width(chan, dst_addr);
 
@@ -1297,7 +1354,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	mask = AT_XDMAC_CC_TYPE | AT_XDMAC_CC_DSYNC;
 	value = AT_XDMAC_CC_TYPE_PER_TRAN | AT_XDMAC_CC_DSYNC_PER2MEM;
 	if ((desc->lld.mbr_cfg & mask) == value) {
-		at_xdmac_write(atxdmac, AT_XDMAC_GSWF, atchan->mask);
+		at_xdmac_write(atxdmac, atxdmac->layout->gswf, atchan->mask);
 		while (!(at_xdmac_chan_read(atchan, AT_XDMAC_CIS) & AT_XDMAC_CIS_FIS))
 			cpu_relax();
 	}
@@ -1355,7 +1412,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	 * FIFO flush ensures that data are really written.
 	 */
 	if ((desc->lld.mbr_cfg & mask) == value) {
-		at_xdmac_write(atxdmac, AT_XDMAC_GSWF, atchan->mask);
+		at_xdmac_write(atxdmac, atxdmac->layout->gswf, atchan->mask);
 		while (!(at_xdmac_chan_read(atchan, AT_XDMAC_CIS) & AT_XDMAC_CIS_FIS))
 			cpu_relax();
 	}
@@ -1620,7 +1677,7 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
 		return 0;
 
 	spin_lock_irqsave(&atchan->lock, flags);
-	at_xdmac_write(atxdmac, AT_XDMAC_GRWS, atchan->mask);
+	at_xdmac_write(atxdmac, atxdmac->layout->grws, atchan->mask);
 	while (at_xdmac_chan_read(atchan, AT_XDMAC_CC)
 	       & (AT_XDMAC_CC_WRIP | AT_XDMAC_CC_RDIP))
 		cpu_relax();
@@ -1643,7 +1700,7 @@ static int at_xdmac_device_resume(struct dma_chan *chan)
 		return 0;
 	}
 
-	at_xdmac_write(atxdmac, AT_XDMAC_GRWR, atchan->mask);
+	at_xdmac_write(atxdmac, atxdmac->layout->grwr, atchan->mask);
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
@@ -1845,6 +1902,10 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	atxdmac->regs = base;
 	atxdmac->irq = irq;
 
+	atxdmac->layout = of_device_get_match_data(&pdev->dev);
+	if (!atxdmac->layout)
+		return -ENODEV;
+
 	atxdmac->clk = devm_clk_get(&pdev->dev, "dma_clk");
 	if (IS_ERR(atxdmac->clk)) {
 		dev_err(&pdev->dev, "can't get dma_clk\n");
@@ -1988,6 +2049,10 @@ static const struct dev_pm_ops atmel_xdmac_dev_pm_ops = {
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
diff --git a/drivers/dma/at_xdmac_regs.h b/drivers/dma/at_xdmac_regs.h
index 3f7dda4c5743..7b4b4e24de70 100644
--- a/drivers/dma/at_xdmac_regs.h
+++ b/drivers/dma/at_xdmac_regs.h
@@ -22,13 +22,6 @@
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
@@ -134,8 +127,6 @@
 #define AT_XDMAC_CSUS		0x30	/* Channel Source Microblock Stride */
 #define AT_XDMAC_CDUS		0x34	/* Channel Destination Microblock Stride */
 
-#define AT_XDMAC_CHAN_REG_BASE	0x50	/* Channel registers base address */
-
 /* Microblock control members */
 #define AT_XDMAC_MBR_UBC_UBLEN_MAX	0xFFFFFFUL	/* Maximum Microblock Length */
 #define AT_XDMAC_MBR_UBC_NDE		(0x1 << 24)	/* Next Descriptor Enable */
-- 
2.25.1

