Return-Path: <dmaengine+bounces-11688-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZJXKFhpbOGq6bQcAu9opvQ
	(envelope-from <dmaengine+bounces-11688-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:43:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FB56ABA24
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:43:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GwPhXutF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11688-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11688-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 585E4303C031
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38DA37104D;
	Sun, 21 Jun 2026 21:41:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9237107F
	for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 21:41:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078094; cv=none; b=uPE6zGEQv5RriPLvtWj4sT7X57hJV/qWrVVltynnReuKel5GjZvhwk8eUSSDM0uYpXGTWcnjPAW/pRTGcsSyTECUaO7bRnyAbUaOUwfmNWvlkrRRZrHJAC2lAZTxX1BSNiZB7qUJEqkvoZzUxYx7aw/6xKfyu6B8Wt6Jkd19LYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078094; c=relaxed/simple;
	bh=dQJRxOtJBIdsX16Td7qmdew1G14whihD+vf5uq3M+Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oZObZPyTq9MMHn+NE1xlM6Neig4ZP//ThjMwrqEjKeYuM0SeeS3vZD62uDfUfyRXpjxXOg8EHflsRKVH2TqMaII4zeC7JgAlL2Jw3oFerxHZY8SEEcTbrVUr1pQz4oktXiaONi4eXSMt0BDy70WmPQv9i8Xb5e9Dp/en34EU7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwPhXutF; arc=none smtp.client-ip=209.85.219.54
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8e066990ff9so14839886d6.0
        for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782078092; x=1782682892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDRD6LBgJnjsi6QsqIJwMXkO05zRf+ayGk9t0C1JISo=;
        b=GwPhXutFIb0Z8xEIkrT2W5QW+2Dh4H8Gh6AON0G4g8xVY2QXyiKxMZPWgQWg+WprrU
         ZgaO7ZDVgJOJ5NINz6qHFLp+xQwTFxhHAB7Pu3Xy32YkMvjLcKOgDb9WIt9BX+dFe1Ym
         q2z5zPQ1sz3xAdlt6OQ30bnTKNNZc2tujr/RzCx4Q6k/FsA3RbGl04dzBoo8yfO06TMY
         v1qpFHT3G7sKtkCOY7s1v5qz37wDYYJT/9hCXRe+KrTnGVlgEMNhFJvEeDYmetTjsek2
         gVz/FiRB9YscmRlzqrlL2tEYdzTbwXc21TbC75yKDOVbl+4Y6tEoOZtnfIyjbEofaeEz
         5Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782078092; x=1782682892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gDRD6LBgJnjsi6QsqIJwMXkO05zRf+ayGk9t0C1JISo=;
        b=HNyjEAop9tUriIrL4x6Jnsk5kA8HUx3Zw1+iJFxOPLfItj4gfvm7KudLuLpPF3ZB9A
         En4ZbJ0u9utpc5oLc6pkqry6fME+gS38qshjezgDaZCwqIcz27q1Pyn36LPpFzTzRuSY
         9yd4ioIfMT6e7pQyQ32yyy/Z1mUfcGgCbGRbRIkTaq9ih83ffEo70Kvv0zIAnX00hDG8
         ml7kBD6J1gKCftsZpGXM9kmSPn835VDhlcEaxl3PkSjjj3T5susqeDtx7ApoDx84yTqJ
         dueIeteZVil6ce+7RwrByDb08pe9Npeom3AXUX721+/wyUn3sWkEyWd3DdjFo/m0cB1A
         kovA==
X-Forwarded-Encrypted: i=1; AHgh+RqsMIu99avgh+Ht8Pan0qOMQDYFp1twprabHjH/WwLMxWyGOS/3Yam+EXPA8AZ1pWYSwIAv5MaTGIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPWlZ1kCQ8TPrCGhAbJOZNmFk8fKLD6z0zGtxymY2/5QhirfL
	YHKle6X0gnIOqMyAuxSB4A/AYIwtOpVBtDSq3JOHMDl6RB9JjuCQh7+O
X-Gm-Gg: AfdE7cnQMzgKaiN1SKjg9D01crsuIU9pHE+gp0l1G6ddEcCo1YJW9A+eowz1PtycBXw
	Fo2QumLf7Kq+WOyZ38Lk/gyGblyhnSEPTJG+uKdjtyH93C3j3Z/YnOL0gEiuLWdC2g24DLjmcwW
	EOAs3qORMFsg2xHkXprz71q3kdmayHGluGzFAPU2s4flqlTJ9v2MFVDkG9MugUh6WmLRxFTEpLe
	vkpJCNVl12n1ROyeUOqAo0BXZQmvmHuS+toBHPoz0+XmowgM0fHGNalpcF9oAZ3r1z9sx/QAYZk
	yAuIOuOKvIdoObdT2Eq/iGc5B2+kdOWqI64TTzKDWJDNNJmSUt6CLO9nmYTjAn/DbbobmH4gokl
	nSE3bj9mmkCpZsXwytXTCq/tWm++IslBIu08xyiTMX8oVo8a7ZFzUYwqzbzGlj063EIHP/W8VqW
	0hkPoSRLd5+fWx0Q==
X-Received: by 2002:a0c:e004:0:b0:8cc:f3a0:20aa with SMTP id 6a1803df08f44-8de4c46b4admr132602906d6.20.1782078091871;
        Sun, 21 Jun 2026 14:41:31 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde9ecsm76274676d6.24.2026.06.21.14.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 14:41:31 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Sun, 21 Jun 2026 21:40:55 +0000
Subject: [PATCH v2 2/5] dmaengine: sun6i-dma: Add set_addr function pointer
 for variable address widths
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-sun60i-a733-dma-v2-2-340f205891cc@gmail.com>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
In-Reply-To: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: Yuanshen Cao <alex.caoys@gmail.com>, dmaengine@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11688-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:mripard@kernel.org,m:alex.caoys@gmail.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:alexcaoys@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexcaoys@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99FB56ABA24

The A733 DMA controller supports higher address (up to 32G) compared to
previous generations. The existing `sun6i_dma_set_addr` function uses a
hardcoded logic for setting the high-address bits in the LLI parameters.

By moving `set_addr` into the `sun6i_dma_config` structure, we can
provide specialized implementations for different hardware. This allows
the A733 to use a version of `set_addr` that correctly handles its
specific `SRC_HIGH_ADDR_32G` and `DST_HIGH_ADDR_32G` in the `set_addr`
register later in the series.

Changes:
- Added `set_addr` function pointer to `struct sun6i_dma_config`.
- Refactored `sun6i_dma_set_addr` and introduced
  `sun6i_dma_set_addr_a31/a100` (keeping the logic for previous
  generations).
- Updated all existing configuration structs to include the new
  `set_addr` pointer.
- Removed `has_high_addr` since the logic is replaced by
  `sun6i_dma_set_addr_a100`.

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 drivers/dma/sun6i-dma.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index ef3052c4ab36..9984b9033cbb 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -112,6 +112,7 @@
 
 /* forward declaration */
 struct sun6i_dma_dev;
+struct sun6i_dma_lli;
 
 /*
  * Hardware channels / ports representation
@@ -138,6 +139,8 @@ struct sun6i_dma_config {
 	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
 	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
 	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
+	void (*set_addr)(struct sun6i_dma_dev *sdev, struct sun6i_dma_lli *v_lli,
+		dma_addr_t src, dma_addr_t dst);
 	void (*dump_com_regs)(struct sun6i_dma_dev *sdev);
 	u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg);
 	void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val);
@@ -147,7 +150,6 @@ struct sun6i_dma_config {
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
-	bool has_high_addr;
 	bool has_mbus_clk;
 };
 
@@ -673,16 +675,30 @@ static int set_config(struct sun6i_dma_dev *sdev,
 	return 0;
 }
 
-static inline void sun6i_dma_set_addr(struct sun6i_dma_dev *sdev,
+static void sun6i_dma_set_addr_a31(struct sun6i_dma_dev *sdev,
+				      struct sun6i_dma_lli *v_lli,
+				      dma_addr_t src, dma_addr_t dst)
+{
+	v_lli->src = lower_32_bits(src);
+	v_lli->dst = lower_32_bits(dst);
+}
+
+static void sun6i_dma_set_addr_a100(struct sun6i_dma_dev *sdev,
 				      struct sun6i_dma_lli *v_lli,
 				      dma_addr_t src, dma_addr_t dst)
 {
 	v_lli->src = lower_32_bits(src);
 	v_lli->dst = lower_32_bits(dst);
 
-	if (sdev->cfg->has_high_addr)
-		v_lli->para |= SRC_HIGH_ADDR(upper_32_bits(src)) |
-			       DST_HIGH_ADDR(upper_32_bits(dst));
+	v_lli->para |= SRC_HIGH_ADDR(upper_32_bits(src)) |
+				DST_HIGH_ADDR(upper_32_bits(dst));
+}
+
+static inline void sun6i_dma_set_addr(struct sun6i_dma_dev *sdev,
+				      struct sun6i_dma_lli *v_lli,
+				      dma_addr_t src, dma_addr_t dst)
+{
+	sdev->cfg->set_addr(sdev, v_lli, src, dst);
 }
 
 static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
@@ -1156,6 +1172,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1180,6 +1197,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1199,6 +1217,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1225,6 +1244,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr_a31,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1247,6 +1267,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr_a31,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1269,6 +1290,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_h6,
 	.set_mode         = sun6i_set_mode_h6,
+	.set_addr         = sun6i_dma_set_addr_a100,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1279,7 +1301,6 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
-	.has_high_addr = true,
 	.has_mbus_clk = true,
 	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
@@ -1293,6 +1314,7 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_h6,
 	.set_mode         = sun6i_set_mode_h6,
+	.set_addr         = sun6i_dma_set_addr_a31,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1320,6 +1342,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr_a31,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |

-- 
2.54.0


