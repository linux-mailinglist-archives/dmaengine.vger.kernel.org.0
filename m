Return-Path: <dmaengine+bounces-11631-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AsR9HLPLNGrUhAYAu9opvQ
	(envelope-from <dmaengine+bounces-11631-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 06:55:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 680426A3DFD
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 06:55:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KLEBQden;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11631-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11631-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEBCD302672C
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 04:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5B33A9FE;
	Fri, 19 Jun 2026 04:54:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E263358CA
	for <dmaengine@vger.kernel.org>; Fri, 19 Jun 2026 04:54:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844874; cv=none; b=N1FUqBbANG645nQAam3+BDNjoipyLT3MpLQxtzuZdGKFb4iMVP8vVSbkD0Zmnt4gD5Sdw4fnvMTMcq1MVlQ4bSrKWvcnDEnq5BP51RT0CIV2aQpjWDqEebjT0UlbDAnVcmjdReGDRjKLmRMgwvko8AO7wq5Y+bD0wJlM3B0AuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844874; c=relaxed/simple;
	bh=aSajCbsbFZZ1xQwTPnErZJbWQK1/5h9xY/tXmk98wvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CY5iQ9fYojVYNXtG0EvIEHHgLKiS7uPGMIQ6sdx1YuJyNuRpkSsCqW8t1r6p6gP7C/rI8cN0vfnJwAGFUchNZ/jZYi9nipxew7iJ3R6kdUEt/NI94Y2z2c5Y2wo/heZtc1YQ5luHWtw5IK6G8U28Eubs/2KpBZrOug5WRl7DAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLEBQden; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9203654905eso68794085a.0
        for <dmaengine@vger.kernel.org>; Thu, 18 Jun 2026 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781844872; x=1782449672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q55XUG3Ko0ecxcUOCYiIDN/X4N3ed40r7B6RThXSSPU=;
        b=KLEBQdenisj1rQxuI0fF3pAI3RILZFDReVM1Iyt8I82dsdEWVbZrCzVzPtFGHALI2Y
         Pi/GGXnA89V09d17MZmxl9l6WUQFtDPsaA0t50LL37V3wA/ClyImVX1dw4T6weV0B7gK
         R+PUxi4tzKkuA6ZZBEqMViTwLbf5K9g2nkfmzqztJzIl4Bb3ZRMZxMFiLZWq5YHY1wi6
         T5rhqDd6YZFvBvbKbXysqbsOyf1ktA1ekoIjkwqdqO7PcgqGq0q8iJBXu78EHS6ucljb
         KncCoP7yzX+kTGxHcbWmgkVq0GmcJXFfGWm92Z/c5HP+OF2Dl2RyKRhw1DSWEHe3nsfu
         CMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844872; x=1782449672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q55XUG3Ko0ecxcUOCYiIDN/X4N3ed40r7B6RThXSSPU=;
        b=VE2dX+jhfRPmLlsPdpFhZP09fhD5UMlu3fYh+EqXyIjo83aYW7jft4jTuHFeo+pmQV
         M9TwIKsbbb8/EeQ6WMkfVIcFIxKGLlOt3X2f0d6PDcVtgsFsMU/Dpva0yDKkoi3cODpI
         jrQgZSNr+3S6NdBOOp0rASdQcHqM96eHfgCj3+1q8BLm7JZPNnRT8WnC2GNs8co42g3g
         9KkQb06dn/XxYVxwVBwMVx5qGt1q3NAHFDKc5U3EfiA8STlvxZBkmyuBO8B8GvrMgYRh
         KSayorlme7pIskqnjpmJvIsAn78wi21h6AjvacH28ITkQI2tZLuAsO63exi4O08Rhn7F
         jqWw==
X-Gm-Message-State: AOJu0Yz2n5DeEEU1wFoposBuZaEY+Oj1itMGy+bvcAvmPiGhxQXIFb8Q
	Vmh3MI+yy1Uwdnlu4JoaC1qbwajcOCkFCk5bqMCEr5U5g3FnzCqlZ3W5
X-Gm-Gg: AfdE7clmlXNyIbIdPTcUJs5IhvdaYow/OlSXehXAFvptvQGoMHN1NI6e1TRMYEItIlg
	CL9LxBsvxQ/8zersJpmIZ1ihioGUQTgqsQZIWRVV6ol0H9MgXczplddVYO0IGI/OrAshueniKMI
	req9Sa43U7okXU60y5aJ4l1GQJnfwCEaJ38t9G0XGBv7BNeEsVeNhHdjAhnbm6gebM8esBiiah1
	rd87QhRi8BJs9WvjJHeP1n+3743w/xXGaglAEBe9r5l46EHiYfwxu8mJ6MHMX61bs/aCAa8VB1M
	pVaH8kI3PCidBCs2lPhyPrJ/LYOZxWvF/FdrTbf3wpTuyfHEnGoywwTN2G/iffd4362g3P+YFJk
	npbnP7q/IYYi2PT+3ODnOOPJnMEJu6skfM+aM6FmruYtuiar5EyXk2uIJNy7PGRSx0yel/HQYds
	9MkhSGHelszKwcSQ==
X-Received: by 2002:a05:620a:298c:b0:915:afa5:754 with SMTP id af79cd13be357-9208e982356mr322872985a.2.1781844872251;
        Thu, 18 Jun 2026 21:54:32 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a425448asm134464485a.23.2026.06.18.21.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:54:31 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Fri, 19 Jun 2026 04:53:32 +0000
Subject: [PATCH 3/5] dmaengine: sun6i-dma: Add num_channels_per_reg for
 flexible interrupt mapping
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-sun60i-a733-dma-v1-3-da4b649fc72a@gmail.com>
References: <20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com>
In-Reply-To: <20260619-sun60i-a733-dma-v1-0-da4b649fc72a@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yuanshen Cao <alex.caoys@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11631-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:alex.caoys@gmail.com,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:alexcaoys@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,gmail.com];
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
X-Rspamd-Queue-Id: 680426A3DFD

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

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 drivers/dma/sun6i-dma.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 059455425e19..fb1c1a28744b 100644
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
@@ -481,8 +482,8 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 
 	sun6i_dma_dump_lli(vchan, pchan->desc->v_lli, pchan->desc->p_lli);
 
-	irq_reg = pchan->idx / DMA_IRQ_CHAN_NR;
-	irq_offset = pchan->idx % DMA_IRQ_CHAN_NR;
+	irq_reg = pchan->idx / sdev->cfg->num_channels_per_reg;
+	irq_offset = pchan->idx % sdev->cfg->num_channels_per_reg;
 
 	vchan->irq_type = vchan->cyclic ? DMA_IRQ_PKG : DMA_IRQ_QUEUE;
 
@@ -574,7 +575,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 	int i, j, ret = IRQ_NONE;
 	u32 status;
 
-	for (i = 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
+	for (i = 0; i < sdev->num_pchans / sdev->cfg->num_channels_per_reg; i++) {
 		status = sdev->cfg->read_irq_stat(sdev, i);
 		if (!status)
 			continue;
@@ -584,7 +585,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 
 		sdev->cfg->write_irq_stat(sdev, i, status);
 
-		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
+		for (j = 0; (j < sdev->cfg->num_channels_per_reg) && status; j++) {
 			pchan = sdev->pchans + j;
 			vchan = pchan->vchan;
 			if (vchan && (status & vchan->irq_type)) {
@@ -1108,9 +1109,11 @@ static struct dma_chan *sun6i_dma_of_xlate(struct of_phandle_args *dma_spec,
 
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
@@ -1171,6 +1174,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 };
 
 /*
@@ -1200,6 +1204,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 };
 
 static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
@@ -1224,6 +1229,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 };
 
 /*
@@ -1257,6 +1263,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 };
 
 /*
@@ -1284,6 +1291,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 };
 
 /*
@@ -1311,6 +1319,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 	.has_mbus_clk = true,
 };
 
@@ -1339,6 +1348,7 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 	.has_mbus_clk = true,
 };
 
@@ -1369,6 +1379,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	.num_channels_per_reg = DMA_IRQ_CHAN_NR,
 };
 
 static const struct of_device_id sun6i_dma_match[] = {

-- 
2.54.0


