Return-Path: <dmaengine+bounces-6173-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA3B32A26
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 18:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690F73A1E1A
	for <lists+dmaengine@lfdr.de>; Sat, 23 Aug 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B996E2ECE9E;
	Sat, 23 Aug 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS8g/RI3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0A22E9ED3;
	Sat, 23 Aug 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964687; cv=none; b=fOwbPpIYjckNRhVKZ6iBpSghuTDhQVCbun6ihAwJvG/mUeDT4d87QxJf14SHQlEc6TrZ7taJRx0o00+14h3FdobWbCL8sPwos1maM8LxH0we3MtlSWmDpiw8FgGFyOx7WHC3hR6fMqVflVjt/L4pPqDbhnYYESzA93xbVn26uyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964687; c=relaxed/simple;
	bh=HrsbhSkWMp6y8bCJ4SusuQXu2u6vriVvJmqCSwtzL1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYqnotaiASt7qOHiuGzttl7UxRPgQxZYGAS9JR+AmpGg/LHyFkDHeEhV4EaBLjZq/p5J3LNqAmFeETaoCwSScvygYMZE2sUIPVOLmloWgBHwy8iSpKoecBZZPjVoLdZFoStiqMQ2KIHHjO3dToWXHMMGfI1W0A9lsj11iiZX0NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS8g/RI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00324C4CEE7;
	Sat, 23 Aug 2025 15:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755964687;
	bh=HrsbhSkWMp6y8bCJ4SusuQXu2u6vriVvJmqCSwtzL1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NS8g/RI3qlFLDpSb5AXMXrIdsjq9mri2FbmcIuFzwj9eKnPtynIS6tcc2kxVGOAOW
	 MOAQXoNID1/JwFOxUPXQU655Fn3TL/gVXL2vnIWcjH2cGDhoaJEmQ0dNSI227UEE+U
	 41wFMfjtYsHQFB9SPejrMyCdX4lHO0NPD3iiE7mZROtcxL7fqgjT01w22Vb2f3De5E
	 qu8TSUwXuMw8GhiQFtOEE7ReWTZtvBM9QYAizc3NNczWsUeKMK5VjTCXaXpO3o3245
	 OKTzwEA69Zw3erkVkpzYCVAWowev1Ev7pMZLpOuMB2hqv/Kz0PZnXWQAUiKY1qsHVO
	 tGVpVcoD+d/Kw==
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
Subject: [PATCH 12/14] dmaengine: dma350: Support device_prep_dma_cyclic
Date: Sat, 23 Aug 2025 23:40:07 +0800
Message-ID: <20250823154009.25992-13-jszhang@kernel.org>
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

Add support for device_prep_dma_cyclic() callback function to benefit
DMA cyclic client, for example ALSA.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/arm-dma350.c | 118 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index a285778264b9..5abb965c6687 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -212,8 +212,10 @@ struct d350_chan {
 	enum dma_status status;
 	dma_cookie_t cookie;
 	u32 residue;
+	u32 periods;
 	u8 tsz;
 	u8 ch;
+	bool cyclic;
 	bool has_trig;
 	bool has_wrap;
 	bool coherent;
@@ -475,6 +477,105 @@ d350_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor *
+d350_prep_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
+		 size_t buf_len, size_t period_len, enum dma_transfer_direction dir,
+		 unsigned long flags)
+{
+	struct d350_chan *dch = to_d350_chan(chan);
+	u32 periods, trig, *cmd, tsz;
+	dma_addr_t src, dst, phys;
+	struct d350_desc *desc;
+	struct d350_sg *dsg;
+	int i, j;
+
+	if (unlikely(!is_slave_direction(dir) || !buf_len || !period_len))
+		return NULL;
+
+	periods = buf_len / period_len;
+
+	desc = kzalloc(struct_size(desc, sg, periods), GFP_NOWAIT);
+	if (!desc)
+		return NULL;
+
+	dch->cyclic = true;
+	desc->sglen = periods;
+
+	if (dir == DMA_MEM_TO_DEV)
+		tsz = __ffs(dch->config.dst_addr_width | (1 << dch->tsz));
+	else
+		tsz = __ffs(dch->config.src_addr_width | (1 << dch->tsz));
+
+	for (i = 0; i < periods; i++) {
+		desc->sg[i].command = dma_pool_zalloc(dch->cmd_pool, GFP_NOWAIT, &phys);
+		if (unlikely(!desc->sg[i].command))
+			goto err_cmd_alloc;
+
+		desc->sg[i].phys = phys;
+		dsg = &desc->sg[i];
+
+		if (dir == DMA_MEM_TO_DEV) {
+			src = buf_addr + i * period_len;
+			dst = dch->config.dst_addr;
+			trig = CH_CTRL_USEDESTRIGIN;
+		} else {
+			src = dch->config.src_addr;
+			dst = buf_addr + i * period_len;
+			trig = CH_CTRL_USESRCTRIGIN;
+		}
+		dsg->tsz = tsz;
+		dsg->xsize = lower_16_bits(period_len >> dsg->tsz);
+		dsg->xsizehi = upper_16_bits(period_len >> dsg->tsz);
+
+		cmd = dsg->command;
+		cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_SRCADDRHI | LINK_DESADDR |
+			 LINK_DESADDRHI | LINK_XSIZE | LINK_XSIZEHI | LINK_SRCTRANSCFG |
+			 LINK_DESTRANSCFG | LINK_XADDRINC | LINK_LINKADDR;
+
+		cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, dsg->tsz) |
+			 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE) |
+			 FIELD_PREP(CH_CTRL_DONETYPE, CH_CTRL_DONETYPE_CMD) | trig;
+
+		cmd[2] = lower_32_bits(src);
+		cmd[3] = upper_32_bits(src);
+		cmd[4] = lower_32_bits(dst);
+		cmd[5] = upper_32_bits(dst);
+		cmd[6] = FIELD_PREP(CH_XY_SRC, dsg->xsize) | FIELD_PREP(CH_XY_DES, dsg->xsize);
+		cmd[7] = FIELD_PREP(CH_XY_SRC, dsg->xsizehi) | FIELD_PREP(CH_XY_DES, dsg->xsizehi);
+		if (dir == DMA_MEM_TO_DEV) {
+			cmd[0] |= LINK_DESTRIGINCFG;
+			cmd[8] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
+			cmd[9] = TRANSCFG_DEVICE;
+			cmd[10] = FIELD_PREP(CH_XY_SRC, 1);
+			cmd[11] = FIELD_PREP(CH_DESTRIGINMODE, CH_DESTRIG_DMA_FC) |
+				  FIELD_PREP(CH_DESTRIGINTYPE, CH_DESTRIG_HW_REQ);
+		} else {
+			cmd[0] |= LINK_SRCTRIGINCFG;
+			cmd[8] = TRANSCFG_DEVICE;
+			cmd[9] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
+			cmd[10] = FIELD_PREP(CH_XY_DES, 1);
+			cmd[11] = FIELD_PREP(CH_SRCTRIGINMODE, CH_SRCTRIG_DMA_FC) |
+				  FIELD_PREP(CH_SRCTRIGINTYPE, CH_SRCTRIG_HW_REQ);
+		}
+
+		if (i)
+			desc->sg[i - 1].command[12] = phys | CH_LINKADDR_EN;
+	}
+
+	/* cyclic list */
+	desc->sg[periods - 1].command[12] = desc->sg[0].phys | CH_LINKADDR_EN;
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
 static int d350_slave_config(struct dma_chan *chan, struct dma_slave_config *config)
 {
 	struct d350_chan *dch = to_d350_chan(chan);
@@ -565,6 +666,7 @@ static int d350_terminate_all(struct dma_chan *chan)
 	}
 	vchan_get_all_descriptors(&dch->vc, &list);
 	list_splice_tail(&list, &dch->vc.desc_terminated);
+	dch->cyclic = false;
 	spin_unlock_irqrestore(&dch->vc.lock, flags);
 
 	return 0;
@@ -716,11 +818,15 @@ static irqreturn_t d350_irq(int irq, void *data)
 
 	spin_lock(&dch->vc.lock);
 	if (ch_status & CH_STAT_INTR_DONE) {
-		vchan_cookie_complete(vd);
-		dch->desc = NULL;
-		dch->status = DMA_COMPLETE;
-		dch->residue = 0;
-		d350_start_next(dch);
+		if (dch->cyclic) {
+			vchan_cyclic_callback(vd);
+		} else {
+			vchan_cookie_complete(vd);
+			dch->desc = NULL;
+			dch->status = DMA_COMPLETE;
+			dch->residue = 0;
+			d350_start_next(dch);
+		}
 	} else {
 		dch->status = DMA_ERROR;
 		dch->residue = vd->tx_result.residue;
@@ -886,8 +992,10 @@ static int d350_probe(struct platform_device *pdev)
 	if (trig_bits) {
 		dmac->dma.directions |= (BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV));
 		dma_cap_set(DMA_SLAVE, dmac->dma.cap_mask);
+		dma_cap_set(DMA_CYCLIC, dmac->dma.cap_mask);
 		dmac->dma.device_config = d350_slave_config;
 		dmac->dma.device_prep_slave_sg = d350_prep_slave_sg;
+		dmac->dma.device_prep_dma_cyclic = d350_prep_cyclic;
 	}
 
 	if (memset) {
-- 
2.50.0


