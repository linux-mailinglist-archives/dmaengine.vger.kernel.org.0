Return-Path: <dmaengine+bounces-11630-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5LyJDqPLNGrPhAYAu9opvQ
	(envelope-from <dmaengine+bounces-11630-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 06:54:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F2E6A3DF7
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 06:54:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VVOQnQn5;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11630-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11630-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F0E4302C68B
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 04:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969C2336897;
	Fri, 19 Jun 2026 04:54:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE813331EAD
	for <dmaengine@vger.kernel.org>; Fri, 19 Jun 2026 04:54:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844873; cv=none; b=ankE3jyNN38SEZdTpE20A+jpu86aLZxeeoWizULgxyOGU1WNuuS9cPtrwB4ajcCOrsxvU3KtcrCw+RFdXuNFt7lbjzMLViUxYlYIpN0oR9m28kLa5IIJ1KQjp62ASRSF7jl9CRH6OQbEP3vl8NER9kWGxZZ+9QigX+aRQaYnHqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844873; c=relaxed/simple;
	bh=dgeGyS+sC8NkGMnX16tGpIauM/4socL5tcePF9QgX6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVqOps3OK95bqhJqxSIdqm8JX8pUYh9WY1KpvplYXdIGRUtjoxqR/6vBGAJVkKCSvrOyKvIEE48lHYhjTR/4Mpxggn6ji+9egwHl2CIbOrhNMcKo9dDrvjuD/MONjptEqi2pkvPQSIXtt/aNf6fbRRXv8qd3Fu4Pi7bO2bUf+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVOQnQn5; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9157d3f2098so200543085a.3
        for <dmaengine@vger.kernel.org>; Thu, 18 Jun 2026 21:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781844871; x=1782449671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nu3ld+/x/4fnowny6tKRb6y8649sFddF48H2SIfvkLE=;
        b=VVOQnQn5p5tmTlIvvt0cTiBh5d/I5UN7adyed4xocO5ygMnpmGTICBBNhXdIaOHcXc
         qJiT1/q9tysMiABCaMUTAjWU5xgPqB6Jxc7Ug3ZfM552M3CDuMm0DJFKjWQ4e7t7Q+nD
         IGgWPy0xpPDexmNz+L66dVBFecQHM8HALyM63KW3zsk5gEShdimQxX8C3NxUJ3lYSpdr
         95opI463IxaZCyWa/V0nnQfDb5v7jtyR+ibiOB72vQNMYGZoASXjxrY0Uuh7zjUSEhWo
         B3YyZfj0H4AhhIMnpb9LhmFZcD2sORLR+cIlyBCe6Z9/KtNjl0EhljQH26DLEEA+LH+y
         hYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844871; x=1782449671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nu3ld+/x/4fnowny6tKRb6y8649sFddF48H2SIfvkLE=;
        b=b5aGYGXSnIL8k8ZQtJMBOQ+QTxrf14kSkn5W1Mxim06mye5NZXTqzzJe69ajCMWDNJ
         u2751/v19U5P1/KCMcuC3FFfnsHUxFQYpcuO7guVqAXIM4xNnpnl8uuMTbC2Na3LgfCb
         OXwvJJvZMNwEVcvuF/cO9EQTisbVIGtaL3b+N9PYaIPP0t9h2pqgZNNfZMAWAdD81/qG
         MlOMIXEXOx0glZFpyNMkvGdM/FVXpF96JfGZ9YvzsR+3L+yjut/7kSFL7zkeywDnhMtT
         tteec+PQEMdVFvKx2S+grcvONuOiMsVlfRivoZ+Btdt2Ht7REYlenOBpJTh0XSbT1yLU
         TZbg==
X-Gm-Message-State: AOJu0Yw8QcGSxc4Qrvvxs0FEtgU1hUR/TCDfgdRr4vbdhUDFOdeT7qpj
	8Tbx9kK42IRZNtBCFApim2hmZPqMQZzFcD29wjA3Hvop8wpWU5g1V0SP
X-Gm-Gg: AfdE7ckosYBCk8zgiixF5y60nRuj59rIbkf932ihHPzzpaUDYpViJEz/IYz4AnM/CqL
	vB5bN+/E5gwbAMFm+o1jpGfQ5/4fzQo+rEDXv+Pa4njMz0q8dBlDKsv3Ck/Vn+IkP2ldLrvd5Mi
	zNdvjGAkssh+22fqvZweOo37GdechZ3uNko5NKWODTDqb0mS9NqEDjJJUmS1ilQ3dM+zp/3LLGB
	mGmjwP2AVrB+83pT+w9vZbroaozPhLyzOepMaq6V9o3aqusECMX4bsuzLFDeSe2dIhWFdK6qIpU
	Z9/5JbaJ5NsAv+TZq8sBpDaxXjXtAFfnW8eNFtsS2WeESLuQzkYwSMCdwv9IznppuyfhIMvgcYk
	jHqUIMmqwiHX0BrRGNwJrGQ+/VguhhHLjEl/4JL2wPcdNsakhWpLvXF3wtLX1y+SAgZmpSUJ1xb
	SKz4E0jP2dy6oGKw==
X-Received: by 2002:a05:620a:4590:b0:915:a6ca:f12a with SMTP id af79cd13be357-920d480da3bmr150184285a.54.1781844870874;
        Thu, 18 Jun 2026 21:54:30 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a425448asm134464485a.23.2026.06.18.21.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:54:30 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Fri, 19 Jun 2026 04:53:31 +0000
Subject: [PATCH 2/5] dmaengine: sun6i-dma: Add set_addr function pointer
 for variable address widths
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-sun60i-a733-dma-v1-2-da4b649fc72a@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11630-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 68F2E6A3DF7

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
  `sun6i_dma_set_addr_a100` (keeping the logic for high address
  support).
- Updated all existing configuration structs to include the new
  `set_addr` pointer.
- Removed `has_high_addr` since the logic is replaced by
  `sun6i_dma_set_addr_a100`.

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 drivers/dma/sun6i-dma.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index d92e702320d9..059455425e19 100644
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
 	u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 chan_num);
 	void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 chan_num, u32 irq_val);
@@ -147,7 +150,6 @@ struct sun6i_dma_config {
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
-	bool has_high_addr;
 	bool has_mbus_clk;
 };
 
@@ -675,13 +677,20 @@ static int set_config(struct sun6i_dma_dev *sdev,
 static inline void sun6i_dma_set_addr(struct sun6i_dma_dev *sdev,
 				      struct sun6i_dma_lli *v_lli,
 				      dma_addr_t src, dma_addr_t dst)
+{
+	v_lli->src = lower_32_bits(src);
+	v_lli->dst = lower_32_bits(dst);
+}
+
+static inline void sun6i_dma_set_addr_a100(struct sun6i_dma_dev *sdev,
+				      struct sun6i_dma_lli *v_lli,
+				      dma_addr_t src, dma_addr_t dst)
 {
 	v_lli->src = lower_32_bits(src);
 	v_lli->dst = lower_32_bits(dst);
 
-	if (sdev->cfg->has_high_addr)
-		v_lli->para |= SRC_HIGH_ADDR(upper_32_bits(src)) |
-			       DST_HIGH_ADDR(upper_32_bits(dst));
+	v_lli->para |= SRC_HIGH_ADDR(upper_32_bits(src)) |
+				DST_HIGH_ADDR(upper_32_bits(dst));
 }
 
 static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
@@ -714,7 +723,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 
 	v_lli->len = len;
 	v_lli->para = NORMAL_WAIT;
-	sun6i_dma_set_addr(sdev, v_lli, src, dest);
+	sdev->cfg->set_addr(sdev, v_lli, src, dest);
 
 	burst = convert_burst(8);
 	width = convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
@@ -773,7 +782,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		v_lli->para = NORMAL_WAIT;
 
 		if (dir == DMA_MEM_TO_DEV) {
-			sun6i_dma_set_addr(sdev, v_lli,
+			sdev->cfg->set_addr(sdev, v_lli,
 					   sg_dma_address(sg),
 					   sconfig->dst_addr);
 			v_lli->cfg = lli_cfg;
@@ -787,7 +796,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 				sg_dma_len(sg), flags);
 
 		} else {
-			sun6i_dma_set_addr(sdev, v_lli,
+			sdev->cfg->set_addr(sdev, v_lli,
 					   sconfig->src_addr,
 					   sg_dma_address(sg));
 			v_lli->cfg = lli_cfg;
@@ -858,7 +867,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 		v_lli->para = NORMAL_WAIT;
 
 		if (dir == DMA_MEM_TO_DEV) {
-			sun6i_dma_set_addr(sdev, v_lli,
+			sdev->cfg->set_addr(sdev, v_lli,
 					   buf_addr + period_len * i,
 					   sconfig->dst_addr);
 			v_lli->cfg = lli_cfg;
@@ -870,7 +879,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 				&sconfig->dst_addr, &buf_addr,
 				buf_len, flags);
 		} else {
-			sun6i_dma_set_addr(sdev, v_lli,
+			sdev->cfg->set_addr(sdev, v_lli,
 					   sconfig->src_addr,
 					   buf_addr + period_len * i);
 			v_lli->cfg = lli_cfg;
@@ -1148,6 +1157,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr,
 	.dump_com_regs    = sun6i_dma_dump_com_regs,
 	.read_irq_en      = sun6i_read_irq_en,
 	.write_irq_en     = sun6i_write_irq_en,
@@ -1176,6 +1186,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr,
 	.dump_com_regs    = sun6i_dma_dump_com_regs,
 	.read_irq_en      = sun6i_read_irq_en,
 	.write_irq_en     = sun6i_write_irq_en,
@@ -1199,6 +1210,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr,
 	.dump_com_regs    = sun6i_dma_dump_com_regs,
 	.read_irq_en      = sun6i_read_irq_en,
 	.write_irq_en     = sun6i_write_irq_en,
@@ -1229,6 +1241,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr,
 	.dump_com_regs    = sun6i_dma_dump_com_regs,
 	.read_irq_en      = sun6i_read_irq_en,
 	.write_irq_en     = sun6i_write_irq_en,
@@ -1255,6 +1268,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr,
 	.dump_com_regs    = sun6i_dma_dump_com_regs,
 	.read_irq_en      = sun6i_read_irq_en,
 	.write_irq_en     = sun6i_write_irq_en,
@@ -1281,6 +1295,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_h6,
 	.set_mode         = sun6i_set_mode_h6,
+	.set_addr         = sun6i_dma_set_addr_a100,
 	.dump_com_regs    = sun6i_dma_dump_com_regs,
 	.read_irq_en      = sun6i_read_irq_en,
 	.write_irq_en     = sun6i_write_irq_en,
@@ -1296,7 +1311,6 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
-	.has_high_addr = true,
 	.has_mbus_clk = true,
 };
 
@@ -1309,6 +1323,7 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_h6,
 	.set_mode         = sun6i_set_mode_h6,
+	.set_addr         = sun6i_dma_set_addr,
 	.dump_com_regs    = sun6i_dma_dump_com_regs,
 	.read_irq_en      = sun6i_read_irq_en,
 	.write_irq_en     = sun6i_write_irq_en,
@@ -1340,6 +1355,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.set_addr         = sun6i_dma_set_addr,
 	.dump_com_regs    = sun6i_dma_dump_com_regs,
 	.read_irq_en      = sun6i_read_irq_en,
 	.write_irq_en     = sun6i_write_irq_en,

-- 
2.54.0


