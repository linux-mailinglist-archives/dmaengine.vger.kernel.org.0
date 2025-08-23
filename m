Return-Path: <dmaengine+bounces-6172-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD553B32A21
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 18:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BB41887572
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89162EC57B;
	Sat, 23 Aug 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSk5doxN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71D2EBDFD;
	Sat, 23 Aug 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964684; cv=none; b=ql9AH9wbG0rO267RI3jbm2AG6SckMrGje+a0n0yz4XLM8WijGZSRgfhn+OMshPh+QYrIZQ8LWn5iJXfvJmPZ1mjdUqssVvs9fq8oe4f8G9g8JbuQ17ERd8Z2N+h447ntwDU4u9g2fXT+sHH2gdELEfvmsAIHF4h7Wr34/7Hlj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964684; c=relaxed/simple;
	bh=N5iYBEau1mtI9QojhfZLi4171xb9nHXTmzGExxeg6+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiWxiRMYjx600OIqL++2GCcM0K3tzneln4BjciN/ZomYmZQ80VwHqBYTGi3g1myiB1eSJ4+jmyPLQRBEU921LEvbuxFhjUJtUen/9bI77Vudm7Nbdp9lHPSMWbqOldXVnQcJbuYE8GUL9+xjoxtuyiw3u1HbiiMEbd3SbXl8/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSk5doxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08281C4CEE7;
	Sat, 23 Aug 2025 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964684;
	bh=N5iYBEau1mtI9QojhfZLi4171xb9nHXTmzGExxeg6+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSk5doxNwSpotdmbzFRyIrXY/6SaYpA8gBMY5agnBIWyXPukIbQulhTDtw6/HtXzW
	 FdNNUe3m9vMetTzjW/C+fZ8X9DBHS9GHiQHVZMY9nHJfS4PM3BxmfejP4IbL5VlW5v
	 c8Uf8L4UPvc7JHUmyOSUKq35sQjCBBM+d9mpfYw498XyW/XV+1U+78oWbiskyzhnVc
	 Adu2VOqrcvyT+RQTQ17SeAT6+gFSXGa2pbSnSykqqXSqdzGQn0iI6j2ZjdbBhI+bfY
	 tXtprE3NNduRmpYgkxfUkZ+0k+4DXOAsv5cEUeCz6V1IfSbVGg62RLfwyoLdIPQuqI
	 OX4Xl1Q6ZtS6A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] dmaengine: dma350: Support device_prep_slave_sg
Date: Sat, 23 Aug 2025 23:40:06 +0800
Message-ID: <20250823154009.25992-12-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823154009.25992-1-jszhang@kernel.org>
References: <20250823154009.25992-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device_prep_slave_sg() callback function so that DMA_MEM_TO_DEV
and DMA_DEV_TO_MEM operations in single mode can be supported.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 180 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 174 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 3d26a1f020df..a285778264b9 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2024-2025 Arm Limited
+// Copyright (C) 2025 Synaptics Incorporated
 // Arm DMA-350 driver
 
 #include <linux/bitfield.h>
@@ -98,7 +99,23 @@
 
 #define CH_FILLVAL		0x38
 #define CH_SRCTRIGINCFG		0x4c
+#define CH_SRCTRIGINMODE	GENMASK(11, 10)
+#define CH_SRCTRIG_CMD		0
+#define CH_SRCTRIG_DMA_FC	2
+#define CH_SRCTRIG_PERIF_FC	3
+#define CH_SRCTRIGINTYPE	GENMASK(9, 8)
+#define CH_SRCTRIG_SW_REQ	0
+#define CH_SRCTRIG_HW_REQ	2
+#define CH_SRCTRIG_INTERN_REQ	3
 #define CH_DESTRIGINCFG		0x50
+#define CH_DESTRIGINMODE	GENMASK(11, 10)
+#define CH_DESTRIG_CMD		0
+#define CH_DESTRIG_DMA_FC	2
+#define CH_DESTRIG_PERIF_FC	3
+#define CH_DESTRIGINTYPE	GENMASK(9, 8)
+#define CH_DESTRIG_SW_REQ	0
+#define CH_DESTRIG_HW_REQ	2
+#define CH_DESTRIG_INTERN_REQ	3
 #define CH_LINKATTR		0x70
 #define CH_LINK_SHAREATTR	GENMASK(9, 8)
 #define CH_LINK_MEMATTR		GENMASK(7, 0)
@@ -190,11 +207,13 @@ struct d350_chan {
 	struct d350_desc *desc;
 	void __iomem *base;
 	struct dma_pool *cmd_pool;
+	struct dma_slave_config config;
 	int irq;
 	enum dma_status status;
 	dma_cookie_t cookie;
 	u32 residue;
 	u8 tsz;
+	u8 ch;
 	bool has_trig;
 	bool has_wrap;
 	bool coherent;
@@ -327,6 +346,144 @@ static struct dma_async_tx_descriptor *d350_prep_memset(struct dma_chan *chan,
 	return vchan_tx_prep(&dch->vc, &desc->vd, flags);
 }
 
+static struct dma_async_tx_descriptor *
+d350_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		   unsigned int sg_len, enum dma_transfer_direction dir,
+		   unsigned long flags, void *context)
+{
+	struct d350_chan *dch = to_d350_chan(chan);
+	dma_addr_t src, dst, phys;
+	struct d350_desc *desc;
+	struct scatterlist *sg;
+	u32 len, trig, *cmd, *la_cmd, tsz;
+	struct d350_sg *dsg;
+	int i, j;
+
+	if (unlikely(!is_slave_direction(dir) || !sg_len))
+		return NULL;
+
+	desc = kzalloc(struct_size(desc, sg, sg_len), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	desc->sglen = sg_len;
+
+	if (dir == DMA_MEM_TO_DEV)
+		tsz = __ffs(dch->config.dst_addr_width | (1 << dch->tsz));
+	else
+		tsz = __ffs(dch->config.src_addr_width | (1 << dch->tsz));
+
+	for_each_sg(sgl, sg, sg_len, i) {
+		desc->sg[i].command = dma_pool_zalloc(dch->cmd_pool, GFP_NOWAIT, &phys);
+		if (unlikely(!desc->sg[i].command))
+			goto err_cmd_alloc;
+
+		desc->sg[i].phys = phys;
+		dsg = &desc->sg[i];
+		len = sg_dma_len(sg);
+
+		if (dir == DMA_MEM_TO_DEV) {
+			src = sg_dma_address(sg);
+			dst = dch->config.dst_addr;
+			trig = CH_CTRL_USEDESTRIGIN;
+		} else {
+			src = dch->config.src_addr;
+			dst = sg_dma_address(sg);
+			trig = CH_CTRL_USESRCTRIGIN;
+		}
+		dsg->tsz = tsz;
+		dsg->xsize = lower_16_bits(len >> dsg->tsz);
+		dsg->xsizehi = upper_16_bits(len >> dsg->tsz);
+
+		cmd = dsg->command;
+		if (!i) {
+			cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_SRCADDRHI | LINK_DESADDR |
+				 LINK_DESADDRHI | LINK_XSIZE | LINK_XSIZEHI | LINK_SRCTRANSCFG |
+				 LINK_DESTRANSCFG | LINK_XADDRINC | LINK_LINKADDR;
+
+			cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, dsg->tsz) | trig |
+				 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE);
+
+			cmd[2] = lower_32_bits(src);
+			cmd[3] = upper_32_bits(src);
+			cmd[4] = lower_32_bits(dst);
+			cmd[5] = upper_32_bits(dst);
+			cmd[6] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
+				 FIELD_PREP(CH_XY_DES, dsg->xsize);
+			cmd[7] = FIELD_PREP(CH_XY_SRC, dsg->xsizehi) |
+				 FIELD_PREP(CH_XY_DES, dsg->xsizehi);
+			if (dir == DMA_MEM_TO_DEV) {
+				cmd[0] |= LINK_DESTRIGINCFG;
+				cmd[8] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
+				cmd[9] = TRANSCFG_DEVICE;
+				cmd[10] = FIELD_PREP(CH_XY_SRC, 1);
+				cmd[11] = FIELD_PREP(CH_DESTRIGINMODE, CH_DESTRIG_DMA_FC) |
+					  FIELD_PREP(CH_DESTRIGINTYPE, CH_DESTRIG_HW_REQ);
+			} else {
+				cmd[0] |= LINK_SRCTRIGINCFG;
+				cmd[8] = TRANSCFG_DEVICE;
+				cmd[9] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
+				cmd[10] = FIELD_PREP(CH_XY_DES, 1);
+				cmd[11] = FIELD_PREP(CH_SRCTRIGINMODE, CH_SRCTRIG_DMA_FC) |
+					  FIELD_PREP(CH_SRCTRIGINTYPE, CH_SRCTRIG_HW_REQ);
+			}
+			la_cmd = &cmd[12];
+		} else {
+			*la_cmd = phys | CH_LINKADDR_EN;
+			if (i == sg_len - 1) {
+				cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_SRCADDRHI | LINK_DESADDR |
+					 LINK_DESADDRHI | LINK_XSIZE | LINK_XSIZEHI | LINK_LINKADDR;
+				cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, dsg->tsz) | trig |
+					 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE);
+				cmd[2] = lower_32_bits(src);
+				cmd[3] = upper_32_bits(src);
+				cmd[4] = lower_32_bits(dst);
+				cmd[5] = upper_32_bits(dst);
+				cmd[6] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
+					 FIELD_PREP(CH_XY_DES, dsg->xsize);
+				cmd[7] = FIELD_PREP(CH_XY_SRC, dsg->xsizehi) |
+					 FIELD_PREP(CH_XY_DES, dsg->xsizehi);
+				la_cmd = &cmd[8];
+			} else {
+				cmd[0] = LINK_SRCADDR | LINK_SRCADDRHI | LINK_DESADDR |
+					 LINK_DESADDRHI | LINK_XSIZE | LINK_XSIZEHI | LINK_LINKADDR;
+				cmd[1] = lower_32_bits(src);
+				cmd[2] = upper_32_bits(src);
+				cmd[3] = lower_32_bits(dst);
+				cmd[4] = upper_32_bits(dst);
+				cmd[5] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
+					 FIELD_PREP(CH_XY_DES, dsg->xsize);
+				cmd[6] = FIELD_PREP(CH_XY_SRC, dsg->xsizehi) |
+					 FIELD_PREP(CH_XY_DES, dsg->xsizehi);
+				la_cmd = &cmd[7];
+			}
+		}
+	}
+
+	/* the last command */
+	*la_cmd = 0;
+	desc->sg[sg_len - 1].command[1] |= FIELD_PREP(CH_CTRL_DONETYPE, CH_CTRL_DONETYPE_CMD);
+
+	mb();
+
+	return vchan_tx_prep(&dch->vc, &desc->vd, flags);
+
+err_cmd_alloc:
+	for (j = 0; j < i; j++)
+		dma_pool_free(dch->cmd_pool, desc->sg[j].command, desc->sg[j].phys);
+	kfree(desc);
+	return NULL;
+}
+
+static int d350_slave_config(struct dma_chan *chan, struct dma_slave_config *config)
+{
+	struct d350_chan *dch = to_d350_chan(chan);
+
+	memcpy(&dch->config, config, sizeof(*config));
+
+	return 0;
+}
+
 static int d350_pause(struct dma_chan *chan)
 {
 	struct d350_chan *dch = to_d350_chan(chan);
@@ -558,8 +715,9 @@ static irqreturn_t d350_irq(int irq, void *data)
 	writel_relaxed(ch_status, dch->base + CH_STATUS);
 
 	spin_lock(&dch->vc.lock);
-	vchan_cookie_complete(vd);
 	if (ch_status & CH_STAT_INTR_DONE) {
+		vchan_cookie_complete(vd);
+		dch->desc = NULL;
 		dch->status = DMA_COMPLETE;
 		dch->residue = 0;
 		d350_start_next(dch);
@@ -617,7 +775,7 @@ static int d350_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct d350 *dmac;
 	void __iomem *base;
-	u32 reg, dma_chan_mask;
+	u32 reg, dma_chan_mask, trig_bits = 0;
 	int ret, nchan, dw, aw, r, p;
 	bool coherent, memset;
 
@@ -637,13 +795,11 @@ static int d350_probe(struct platform_device *pdev)
 	dw = 1 << FIELD_GET(DMA_CFG_DATA_WIDTH, reg);
 	aw = FIELD_GET(DMA_CFG_ADDR_WIDTH, reg) + 1;
 
-	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(aw));
-	coherent = device_get_dma_attr(dev) == DEV_DMA_COHERENT;
-
 	dmac = devm_kzalloc(dev, struct_size(dmac, channels, nchan), GFP_KERNEL);
 	if (!dmac)
 		return -ENOMEM;
 
+	dmac->dma.dev = dev;
 	dmac->nchan = nchan;
 
 	/* Enable all channels by default */
@@ -655,12 +811,14 @@ static int d350_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(aw));
+	coherent = device_get_dma_attr(dev) == DEV_DMA_COHERENT;
+
 	reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
 	dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
 
 	dev_dbg(dev, "DMA-350 r%dp%d with %d channels, %d requests\n", r, p, dmac->nchan, dmac->nreq);
 
-	dmac->dma.dev = dev;
 	for (int i = min(dw, 16); i > 0; i /= 2) {
 		dmac->dma.src_addr_widths |= BIT(i);
 		dmac->dma.dst_addr_widths |= BIT(i);
@@ -692,6 +850,7 @@ static int d350_probe(struct platform_device *pdev)
 
 		dch->coherent = coherent;
 		dch->base = base + DMACH(i);
+		dch->ch = i;
 		writel_relaxed(CH_CMD_CLEAR, dch->base + CH_CMD);
 
 		reg = readl_relaxed(dch->base + CH_BUILDCFG1);
@@ -711,6 +870,7 @@ static int d350_probe(struct platform_device *pdev)
 
 		/* Fill is a special case of Wrap */
 		memset &= dch->has_wrap;
+		trig_bits |= dch->has_trig << dch->ch;
 
 		reg = readl_relaxed(dch->base + CH_BUILDCFG0);
 		dch->tsz = FIELD_GET(CH_CFG_DATA_WIDTH, reg);
@@ -723,6 +883,13 @@ static int d350_probe(struct platform_device *pdev)
 		vchan_init(&dch->vc, &dmac->dma);
 	}
 
+	if (trig_bits) {
+		dmac->dma.directions |= (BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV));
+		dma_cap_set(DMA_SLAVE, dmac->dma.cap_mask);
+		dmac->dma.device_config = d350_slave_config;
+		dmac->dma.device_prep_slave_sg = d350_prep_slave_sg;
+	}
+
 	if (memset) {
 		dma_cap_set(DMA_MEMSET, dmac->dma.cap_mask);
 		dmac->dma.device_prep_dma_memset = d350_prep_memset;
@@ -759,5 +926,6 @@ static struct platform_driver d350_driver = {
 module_platform_driver(d350_driver);
 
 MODULE_AUTHOR("Robin Murphy <robin.murphy@arm.com>");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
 MODULE_DESCRIPTION("Arm DMA-350 driver");
 MODULE_LICENSE("GPL v2");
-- 
2.50.0


