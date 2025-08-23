Return-Path: <dmaengine+bounces-6171-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D61C2B32A1C
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 18:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 092157B4B27
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9047B2ECD06;
	Sat, 23 Aug 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeF86+0y"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6255D2E888B;
	Sat, 23 Aug 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964681; cv=none; b=E24sm36YvfamarzEvWhAhgUqI5tCVu2UxcO9bsIBG1+X/L0UzVd8P9uYoAdkNgP0WBVjJgbDUtp0wd6w7FXGyRdGJDC1jiN58pNMmTMFRKaq7BUoZPZjL7zoDbYlVJ10tf61+Tcml62lXBG7xnt30aZ6EGsyqNbuGv4NNNQyofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964681; c=relaxed/simple;
	bh=eRF0y8k9gBqSWRmWw3RnFEXQjPJyHVaqp9mzsJmVrLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4yWlV8azvbimhkfdRpAqatHcsDyzh/hIp/gtJ7JnGlEol6rIbjUZPjbFAdObhV+oXdJmo13vYobHYLrNvPla09U519bvu3LVjyf48MU/hC5NfonmFNuTChnfikZl0V/WffJx6ZIUyEDBBi1I0TH/yfr/Ls82d7OqhbmOrWAD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeF86+0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437F9C116B1;
	Sat, 23 Aug 2025 15:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964681;
	bh=eRF0y8k9gBqSWRmWw3RnFEXQjPJyHVaqp9mzsJmVrLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CeF86+0yhUk+/N7XRTd+EFTcLdsIqcBniToNywamiSlQP1uXKp/0hQsEkvclMka1D
	 tdhju8kL5Kn202gKepoh9ZWI3HUVsWs1saxwlFc/YNJrO+5v3xBxqk9jOKcN0fbyUc
	 nNp438NTCjsObF4kh/pTJrkRNQ7ucIiMyBmrcID1SjD/IcLkrwaPzjw4Sx7P4sLtT8
	 2HWroMI6+Ub+zSjinWZ5ATbQplQDvP9/Kae1D21yKpj4em7gbjqdK+O/YzrKTnT8YL
	 gRKJOOp3m2B/oS+ryY1i2JaLSssdNYhnSVoKtIe4PDjz+989OkmCRnjQKr4NV7yRK2
	 2dJuTypWkffRA==
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
Subject: [PATCH 10/14] dmaengine: dma350: Alloc command[] from dma pool
Date: Sat, 23 Aug 2025 23:40:05 +0800
Message-ID: <20250823154009.25992-11-jszhang@kernel.org>
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

Currently, the command[] is allocated with kzalloc(), but dma350 may be
used on dma-non-coherent platforms, to prepare the support of peripheral
and scatter-gather chaining on both dma-coherent and dma-non-coherent
platforms, let's alloc them from dma pool.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 143 +++++++++++++++++++++++++++++++--------
 1 file changed, 113 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 72067518799e..3d26a1f020df 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -4,6 +4,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/dmaengine.h>
+#include <linux/dmapool.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -143,6 +144,7 @@
 #define LINK_LINKADDR		BIT(30)
 #define LINK_LINKADDRHI		BIT(31)
 
+#define D350_MAX_CMDS		16
 
 enum ch_ctrl_donetype {
 	CH_CTRL_DONETYPE_NONE = 0,
@@ -169,18 +171,25 @@ enum ch_cfg_memattr {
 	MEMATTR_WB = 0xff
 };
 
-struct d350_desc {
-	struct virt_dma_desc vd;
-	u32 command[16];
+struct d350_sg {
+	u32 *command;
+	dma_addr_t phys;
 	u16 xsize;
 	u16 xsizehi;
 	u8 tsz;
 };
 
+struct d350_desc {
+	struct virt_dma_desc vd;
+	u32 sglen;
+	struct d350_sg sg[] __counted_by(sglen);
+};
+
 struct d350_chan {
 	struct virt_dma_chan vc;
 	struct d350_desc *desc;
 	void __iomem *base;
+	struct dma_pool *cmd_pool;
 	int irq;
 	enum dma_status status;
 	dma_cookie_t cookie;
@@ -210,7 +219,14 @@ static inline struct d350_desc *to_d350_desc(struct virt_dma_desc *vd)
 
 static void d350_desc_free(struct virt_dma_desc *vd)
 {
-	kfree(to_d350_desc(vd));
+	struct d350_chan *dch = to_d350_chan(vd->tx.chan);
+	struct d350_desc *desc = to_d350_desc(vd);
+	int i;
+
+	for (i = 0; i < desc->sglen; i++)
+		dma_pool_free(dch->cmd_pool, desc->sg[i].command, desc->sg[i].phys);
+
+	kfree(desc);
 }
 
 static struct dma_async_tx_descriptor *d350_prep_memcpy(struct dma_chan *chan,
@@ -218,22 +234,32 @@ static struct dma_async_tx_descriptor *d350_prep_memcpy(struct dma_chan *chan,
 {
 	struct d350_chan *dch = to_d350_chan(chan);
 	struct d350_desc *desc;
+	struct d350_sg *sg;
+	dma_addr_t phys;
 	u32 *cmd;
 
-	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	desc = kzalloc(struct_size(desc, sg, 1), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-	desc->tsz = __ffs(len | dest | src | (1 << dch->tsz));
-	desc->xsize = lower_16_bits(len >> desc->tsz);
-	desc->xsizehi = upper_16_bits(len >> desc->tsz);
+	sg = &desc->sg[0];
+	sg->command = dma_pool_zalloc(dch->cmd_pool, GFP_NOWAIT, &phys);
+	if (unlikely(!sg->command)) {
+		kfree(desc);
+		return NULL;
+	}
+	sg->phys = phys;
+
+	sg->tsz = __ffs(len | dest | src | (1 << dch->tsz));
+	sg->xsize = lower_16_bits(len >> sg->tsz);
+	sg->xsizehi = upper_16_bits(len >> sg->tsz);
 
-	cmd = desc->command;
+	cmd = sg->command;
 	cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_SRCADDRHI | LINK_DESADDR |
 		 LINK_DESADDRHI | LINK_XSIZE | LINK_XSIZEHI | LINK_SRCTRANSCFG |
 		 LINK_DESTRANSCFG | LINK_XADDRINC | LINK_LINKADDR;
 
-	cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, desc->tsz) |
+	cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, sg->tsz) |
 		 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE) |
 		 FIELD_PREP(CH_CTRL_DONETYPE, CH_CTRL_DONETYPE_CMD);
 
@@ -241,13 +267,15 @@ static struct dma_async_tx_descriptor *d350_prep_memcpy(struct dma_chan *chan,
 	cmd[3] = upper_32_bits(src);
 	cmd[4] = lower_32_bits(dest);
 	cmd[5] = upper_32_bits(dest);
-	cmd[6] = FIELD_PREP(CH_XY_SRC, desc->xsize) | FIELD_PREP(CH_XY_DES, desc->xsize);
-	cmd[7] = FIELD_PREP(CH_XY_SRC, desc->xsizehi) | FIELD_PREP(CH_XY_DES, desc->xsizehi);
+	cmd[6] = FIELD_PREP(CH_XY_SRC, sg->xsize) | FIELD_PREP(CH_XY_DES, sg->xsize);
+	cmd[7] = FIELD_PREP(CH_XY_SRC, sg->xsizehi) | FIELD_PREP(CH_XY_DES, sg->xsizehi);
 	cmd[8] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
 	cmd[9] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
 	cmd[10] = FIELD_PREP(CH_XY_SRC, 1) | FIELD_PREP(CH_XY_DES, 1);
 	cmd[11] = 0;
 
+	mb();
+
 	return vchan_tx_prep(&dch->vc, &desc->vd, flags);
 }
 
@@ -256,34 +284,46 @@ static struct dma_async_tx_descriptor *d350_prep_memset(struct dma_chan *chan,
 {
 	struct d350_chan *dch = to_d350_chan(chan);
 	struct d350_desc *desc;
+	struct d350_sg *sg;
+	dma_addr_t phys;
 	u32 *cmd;
 
-	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+	desc = kzalloc(struct_size(desc, sg, 1), GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-	desc->tsz = __ffs(len | dest | (1 << dch->tsz));
-	desc->xsize = lower_16_bits(len >> desc->tsz);
-	desc->xsizehi = upper_16_bits(len >> desc->tsz);
+	sg = &desc->sg[0];
+	sg->command = dma_pool_zalloc(dch->cmd_pool, GFP_NOWAIT, &phys);
+	if (unlikely(!sg->command)) {
+		kfree(desc);
+		return NULL;
+	}
+	sg->phys = phys;
+
+	sg->tsz = __ffs(len | dest | (1 << dch->tsz));
+	sg->xsize = lower_16_bits(len >> sg->tsz);
+	sg->xsizehi = upper_16_bits(len >> sg->tsz);
 
-	cmd = desc->command;
+	cmd = sg->command;
 	cmd[0] = LINK_CTRL | LINK_DESADDR | LINK_DESADDRHI |
 		 LINK_XSIZE | LINK_XSIZEHI | LINK_DESTRANSCFG |
 		 LINK_XADDRINC | LINK_FILLVAL | LINK_LINKADDR;
 
-	cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, desc->tsz) |
+	cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, sg->tsz) |
 		 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_FILL) |
 		 FIELD_PREP(CH_CTRL_DONETYPE, CH_CTRL_DONETYPE_CMD);
 
 	cmd[2] = lower_32_bits(dest);
 	cmd[3] = upper_32_bits(dest);
-	cmd[4] = FIELD_PREP(CH_XY_DES, desc->xsize);
-	cmd[5] = FIELD_PREP(CH_XY_DES, desc->xsizehi);
+	cmd[4] = FIELD_PREP(CH_XY_DES, sg->xsize);
+	cmd[5] = FIELD_PREP(CH_XY_DES, sg->xsizehi);
 	cmd[6] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
 	cmd[7] = FIELD_PREP(CH_XY_DES, 1);
 	cmd[8] = (u8)value * 0x01010101;
 	cmd[9] = 0;
 
+	mb();
+
 	return vchan_tx_prep(&dch->vc, &desc->vd, flags);
 }
 
@@ -319,8 +359,9 @@ static int d350_resume(struct dma_chan *chan)
 
 static u32 d350_get_residue(struct d350_chan *dch)
 {
-	u32 res, xsize, xsizehi, hi_new;
-	int retries = 3; /* 1st time unlucky, 2nd improbable, 3rd just broken */
+	u32 res, xsize, xsizehi, linkaddr, linkaddrhi, hi_new;
+	int i, sgcur, retries = 3; /* 1st time unlucky, 2nd improbable, 3rd just broken */
+	struct d350_desc *desc = dch->desc;
 
 	hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
 	do {
@@ -329,10 +370,26 @@ static u32 d350_get_residue(struct d350_chan *dch)
 		hi_new = readl_relaxed(dch->base + CH_XSIZEHI);
 	} while (xsizehi != hi_new && --retries);
 
+	hi_new = readl_relaxed(dch->base + CH_LINKADDRHI);
+	do {
+		linkaddrhi = hi_new;
+		linkaddr = readl_relaxed(dch->base + CH_LINKADDR);
+		hi_new = readl_relaxed(dch->base + CH_LINKADDRHI);
+	} while (linkaddrhi != hi_new && --retries);
+
+	for (i = 0; i < desc->sglen; i++) {
+		if (desc->sg[i].phys == (((u64)linkaddrhi << 32) | (linkaddr & ~CH_LINKADDR_EN)))
+			sgcur = i;
+	}
+
 	res = FIELD_GET(CH_XY_DES, xsize);
 	res |= FIELD_GET(CH_XY_DES, xsizehi) << 16;
+	res <<= desc->sg[sgcur].tsz;
+
+	for (i = sgcur + 1; i < desc->sglen; i++)
+		res += (((u32)desc->sg[i].xsizehi << 16 | desc->sg[i].xsize) << desc->sg[i].tsz);
 
-	return res << dch->desc->tsz;
+	return res;
 }
 
 static int d350_terminate_all(struct dma_chan *chan)
@@ -365,7 +422,13 @@ static void d350_synchronize(struct dma_chan *chan)
 
 static u32 d350_desc_bytes(struct d350_desc *desc)
 {
-	return ((u32)desc->xsizehi << 16 | desc->xsize) << desc->tsz;
+	int i;
+	u32 bytes = 0;
+
+	for (i = 0; i < desc->sglen; i++)
+		bytes += (((u32)desc->sg[i].xsizehi << 16 | desc->sg[i].xsize) << desc->sg[i].tsz);
+
+	return bytes;
 }
 
 static enum dma_status d350_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
@@ -415,8 +478,8 @@ static void d350_start_next(struct d350_chan *dch)
 	dch->cookie = dch->desc->vd.tx.cookie;
 	dch->residue = d350_desc_bytes(dch->desc);
 
-	hdr = dch->desc->command[0];
-	reg = &dch->desc->command[1];
+	hdr = dch->desc->sg[0].command[0];
+	reg = &dch->desc->sg[0].command[1];
 
 	if (hdr & LINK_INTREN)
 		writel_relaxed(*reg++, dch->base + CH_INTREN);
@@ -512,11 +575,29 @@ static irqreturn_t d350_irq(int irq, void *data)
 static int d350_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct d350_chan *dch = to_d350_chan(chan);
-	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
-			      dev_name(&dch->vc.chan.dev->device), dch);
-	if (!ret)
-		writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
+	int ret;
+
+	dch->cmd_pool = dma_pool_create(dma_chan_name(chan),
+					  chan->device->dev,
+					  D350_MAX_CMDS * sizeof(u32),
+					  sizeof(u32), 0);
+	if (!dch->cmd_pool) {
+		dev_err(chan->device->dev, "No memory for cmd pool\n");
+		return -ENOMEM;
+	}
+
+	ret = request_irq(dch->irq, d350_irq, 0,
+			  dev_name(&dch->vc.chan.dev->device), dch);
+	if (ret < 0)
+		goto err_irq;
+
+	writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
+
+	return 0;
 
+err_irq:
+	dma_pool_destroy(dch->cmd_pool);
+	dch->cmd_pool = NULL;
 	return ret;
 }
 
@@ -527,6 +608,8 @@ static void d350_free_chan_resources(struct dma_chan *chan)
 	writel_relaxed(0, dch->base + CH_INTREN);
 	free_irq(dch->irq, dch);
 	vchan_free_chan_resources(&dch->vc);
+	dma_pool_destroy(dch->cmd_pool);
+	dch->cmd_pool = NULL;
 }
 
 static int d350_probe(struct platform_device *pdev)
-- 
2.50.0


