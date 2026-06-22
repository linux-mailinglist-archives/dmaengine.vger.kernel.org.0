Return-Path: <dmaengine+bounces-11705-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hIiKKSySOGqRdwcAu9opvQ
	(envelope-from <dmaengine+bounces-11705-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:38:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F36ABF42
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:38:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RWy9WHrv;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11705-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11705-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB2E530055C1
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673EC2517A5;
	Mon, 22 Jun 2026 01:38:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07A25F98B
	for <dmaengine@vger.kernel.org>; Mon, 22 Jun 2026 01:38:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782092324; cv=none; b=pwhqTfDOvHVLBVxjtcyxxWLsDNjj6FKO4hmVyvE9p5Ce3j9TAat0F+EC2VTT8UMTXkuDpQnH8SuXLRjb7ksUoV9cs0N0yWVNuoLFYJm3RzlGnxRXuNTPiuugThysflgDK8dUPDvhG62HdAITeO+15O9tRgxE/WJlPZAeU31wlvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782092324; c=relaxed/simple;
	bh=AUqQtUzkNoSkYSGTZ+DxhkWOf9HoxaXr4yKXv+TNYDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lxpys6zridM45CVo1LjlS1KKNQKGQ6Ji5YeEvAjJp0U3QMKQ/GHORETIaALqIMDOZjHu+H87Gh+JqIqVDpM2GJ2w4XsFV/qPNpVGDnqGHr+L+wVsB8dxGyMjiD/5JwT80eJugoo1px55us6SIe/ilbOCHvInpWVXoBcgDpKIDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWy9WHrv; arc=none smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51a019e9ea9so22618111cf.2
        for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 18:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782092321; x=1782697121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v94lnRVnvoTJ1Pc8aoKqSqEARqq8CGmwJLQaxJ+xYl4=;
        b=RWy9WHrv936c//HtWrR3NxaZVKr8SuxHKMhC48rfsgLLLPT69mSeSrXRQOu+YNSo3C
         gvUVOB1aCoZJKdUiCS9KBn6IPaqilsQpNWVaB74wucaneFQgdIx97/bAIxhgEnSzZml6
         WqZ7Bw8lQl83hI0x9V6LqZz/76bzJwzYXAKDpvqokR1+UV2xVhYLG4vmdpUo1vLLKGFX
         iNN+Rz5Trc67BoahTj7F1C/NgKZSFkivmj7qFUwxeCHiljFCENDrtOymw9g5RUYjqK5x
         S0rK7Jw6zYjKQE7Ixw6AiaUF9TEhp2qGuBLXAOnI16rFB3S+hbxKPK4+HPNZHaksgpgI
         DMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782092321; x=1782697121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v94lnRVnvoTJ1Pc8aoKqSqEARqq8CGmwJLQaxJ+xYl4=;
        b=beVJoT2yiYM8w9N/NQy/xrE3vOCqeGDRWgUf/iROoHaZM7+BIB5hiTNf335akGpYyr
         YdaqjHjma/P0S0KHKRxpuO6i2zcSH7vVVPlRE7tBWfHrx2ncA0TdZtg6PX7IiscSVmFF
         70piBZ/Q9bl922HN90e33l4HBE8PnowJ0N5tn3tpaoM6jn1RojwW7zV/sa+JaSj5XoB+
         z2JJUdsToINve5rZ5ZIFUlC90EI5QO3idVmjWTgzGQf2LYuAURqyi5x5xpoThH4+rcjR
         By0VVgb/tYIsN6ddqwRrnDRYSt+kJunXpEWVAuyhxkRtC2dSRrx8gYevOoo8kbmz8wSr
         +xMg==
X-Forwarded-Encrypted: i=1; AFNElJ8CvhGrodSirnm6r4MQmUCUbYjvJ5k0cisQVYBPJUOcerdfvh4D9z+q5uOA1GT19LMKF+SmpXe3CwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PrhT5I9//hN/B0YqYyHnjqAntzB68IBgs6F9fWapZSNVFht4
	cCnSgfopg8jHQc+Vfz4g7XjYJPOPbLQ1w6ibSi7yFuSnUvliDOKEKmpf
X-Gm-Gg: AfdE7cmlSuTksplv0ftQKi5NKFkRSVFE04stQaNA2s0ui23BUzlnNKkrcqE5a2nJBwU
	C4WbbkIFZIvTYib3/iuIZUC6yDR5C6w7a8lTLoBBvdxn6HKwN6o/Gy0f3DZ5I0XWQnM6jrKPCgr
	KY5+L6SMs7NVpXZlO4EG+bnEHn00gJ24NtGsU5pC76ISnhnWD4SOAwopaQCJemIyhGRAiI50TZF
	wMkgEJyHFDdVzh7i5fSSrD2JP0CPdU2s+U1cr9T92GgJTuYwaKyIVQsYooK4dpWLrDLymgjyDuQ
	kfDka9y6gDpEG9RDwdDQLLTkRfl/v34nI8wqnrUNm5N1koy9us4/Kr6JVQlgm9ITGE/BfAjpBMB
	XOTkdZQHf015J62imUKPA9/N6+W7fDp4IDca4D/7cdMR7G2ge6hOmaYbw39+7Bzi1mL2pyR6W4O
	nkUIZm5nsMB/6lfw==
X-Received: by 2002:a05:622a:410e:b0:516:e39a:8540 with SMTP id d75a77b69052e-51a06af48a7mr138785651cf.48.1782092320980;
        Sun, 21 Jun 2026 18:38:40 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a098e287csm55778831cf.29.2026.06.21.18.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 18:38:40 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Mon, 22 Jun 2026 01:36:25 +0000
Subject: [PATCH v3 3/5] dmaengine: sun6i-dma: Add num_channels_per_reg for
 flexible interrupt mapping
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-sun60i-a733-dma-v3-3-f697ef296cbc@gmail.com>
References: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com>
In-Reply-To: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com>
To: conor+dt@kernel.org, mripard@kernel.org, krzk+dt@kernel.org, 
 robh@kernel.org, samuel@sholland.org, wens@kernel.org, 
 jernej.skrabec@gmail.com, Frank.Li@kernel.org, vkoul@kernel.org
Cc: Yuanshen Cao <alex.caoys@gmail.com>, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11705-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:conor+dt@kernel.org,m:mripard@kernel.org,m:krzk+dt@kernel.org,m:robh@kernel.org,m:samuel@sholland.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:alex.caoys@gmail.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Frank.Li@nxp.com,m:conor@kernel.org,m:krzk@kernel.org,m:jernejskrabec@gmail.com,m:alexcaoys@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,sholland.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F1F36ABF42

The previous implementation of `sun6i-dma` had some implicit assumptions
about the number of channels per interrupt register. Specifically,
functions like `sun6i_kill_tasklet` were hardcoded to only disable
interrupts for IRQ 0 and 1. `DMA_MAX_CHANNELS` is also not in used in
the past, and the old SoCs never has more than 16 channels.

The A733 has a different interrupt structure where the number of
channels per register may differ. This patch introduces
`num_channels_per_reg` to the `sun6i_dma_config`, similar to BSP, to
make the interrupt handling logic hardware-agnostic. It also sets
`DMA_MAX_CHANNELS` to 16 to align with the new BSP code and ensure loops
over interrupts are correctly bounded.

Changes:
- Change `DMA_MAX_CHANNELS` definition to 16.
- Added `num_channels_per_reg` to `struct sun6i_dma_config`.
- Replaced hardcoded IRQ register calculations with values from
  `sdev->cfg->num_channels_per_reg`.
- Updated `sun6i_kill_tasklet` to loop through all possible interrupt
  registers based on `DMA_MAX_CHANNELS` and the configuration.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 drivers/dma/sun6i-dma.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 9984b9033cbb..196a0d73b221 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -41,7 +41,7 @@
 #define DMA_STAT		0x30
 
 /* Offset between DMA_IRQ_EN and DMA_IRQ_STAT limits number of channels */
-#define DMA_MAX_CHANNELS	(DMA_IRQ_CHAN_NR * 0x10 / 4)
+#define DMA_MAX_CHANNELS	16
 
 /*
  * sun8i specific registers
@@ -151,6 +151,7 @@ struct sun6i_dma_config {
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
 	bool has_mbus_clk;
+	u32 num_channels_per_reg;
 };
 
 /*
@@ -482,8 +483,8 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 
 	sun6i_dma_dump_lli(vchan, pchan->desc->v_lli, pchan->desc->p_lli);
 
-	irq_reg = pchan->idx / DMA_IRQ_CHAN_NR;
-	irq_offset = pchan->idx % DMA_IRQ_CHAN_NR;
+	irq_reg = pchan->idx / sdev->cfg->num_channels_per_reg;
+	irq_offset = pchan->idx % sdev->cfg->num_channels_per_reg;
 
 	vchan->irq_type = vchan->cyclic ? DMA_IRQ_PKG : DMA_IRQ_QUEUE;
 
@@ -575,7 +576,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 	int i, j, ret = IRQ_NONE;
 	u32 status;
 
-	for (i = 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
+	for (i = 0; i < sdev->num_pchans / sdev->cfg->num_channels_per_reg; i++) {
 		status = sdev->cfg->read_irq_stat(sdev, i);
 		if (!status)
 			continue;
@@ -585,7 +586,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 
 		sdev->cfg->write_irq_stat(sdev, i, status);
 
-		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
+		for (j = 0; (j < sdev->cfg->num_channels_per_reg) && status; j++) {
 			pchan = sdev->pchans + j;
 			vchan = pchan->vchan;
 			if (vchan && (status & vchan->irq_type)) {
@@ -1116,9 +1117,11 @@ static struct dma_chan *sun6i_dma_of_xlate(struct of_phandle_args *dma_spec,
 
 static inline void sun6i_kill_tasklet(struct sun6i_dma_dev *sdev)
 {
+	int i;
+
 	/* Disable all interrupts from DMA */
-	writel(0, sdev->base + DMA_IRQ_EN(0));
-	writel(0, sdev->base + DMA_IRQ_EN(1));
+	for (i = 0; i < DMA_MAX_CHANNELS / sdev->cfg->num_channels_per_reg; i++)
+		sdev->cfg->write_irq_en(sdev, i, 0);
 
 	/* Prevent spurious interrupts from scheduling the tasklet */
 	atomic_inc(&sdev->tasklet_shutdown);
@@ -1181,6 +1184,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
@@ -1206,6 +1210,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
@@ -1226,6 +1231,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
@@ -1255,6 +1261,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
@@ -1278,6 +1285,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
@@ -1301,6 +1309,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 	.has_mbus_clk = true,
 	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
@@ -1325,6 +1334,7 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 	.has_mbus_clk = true,
 	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
@@ -1351,6 +1361,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 

-- 
2.54.0


