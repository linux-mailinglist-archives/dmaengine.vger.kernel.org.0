Return-Path: <dmaengine+bounces-11629-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 175TAKDLNGrMhAYAu9opvQ
	(envelope-from <dmaengine+bounces-11629-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 06:54:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185D6A3DF1
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 06:54:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Qk2yLyCZ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11629-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11629-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E56E43026468
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 04:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51D7331221;
	Fri, 19 Jun 2026 04:54:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDD32ED39
	for <dmaengine@vger.kernel.org>; Fri, 19 Jun 2026 04:54:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781844872; cv=none; b=AX+uRJUWci92XXSgQ3CoVWcnGFDTi5vEsbssSU7kHBGqO3aarwRUkkeru3HfJ2sOyeogMniEzbSmrdv9CUindhnEujyDGKLFn+JEPRk5mEBMp8KoubfI9lbW2OaHM2/x4o4RPJIHTQQ/tB6Ckxd8AhGoyAI/RgvYDv3bH1BhIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781844872; c=relaxed/simple;
	bh=7jkweAVlDub3sDgn0UmgLN1vsZX1f1ymTmCOlDqSb5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQUNeEWFBaAFxBzU0Wkt3OwxIJVv0nOUh5lyMNp+Ti5ZkKY6nLxIt0S5Ig5MZJzr1GVq7xqvm25F+NaXoGVjkpDTwbfRmoEntSAl+12Qd1CWzzYY6PlP7zxN38NOpk3smbpFHd8ywaet0Pj2DbDoowdNYSuStUnWvtEjDojlLuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk2yLyCZ; arc=none smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-519e7faecf1so6088331cf.0
        for <dmaengine@vger.kernel.org>; Thu, 18 Jun 2026 21:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781844869; x=1782449669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCbRPFVxEt0WZgFCBiNC0T/3UAfEsH3DPRtt1y+Tp+Y=;
        b=Qk2yLyCZt1PEclifj0YqriRDtfxsMBjHWgtV986pDAEWC6pg0Om6LNmq6G+oixf4bZ
         IgJS4JdVvd6O0ShjOcJhL2Z3+aN/fH9Yh0P23J8MXWJanhpxfpoT/Ato/7UzHdowJ3vm
         f+U8Cdnuq5Lbxs8sGp0lMe+YbTWS37kRPMfQohjpDFGO5Vfl9m/oVXmW5FSTBipO0onC
         mge21BWQivsWRftJXI3waNCIBkh7p+CsSd/hxrIDU7RAMhCexZXr0uuvdlf1njdJ+Fzv
         YBBL8uJxNegPz7fwJblLwuLFcSTNEQiJPDyCYBePneU0vgARXcUJd2hhjl+K2aPla+ON
         lL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781844869; x=1782449669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rCbRPFVxEt0WZgFCBiNC0T/3UAfEsH3DPRtt1y+Tp+Y=;
        b=N30u2CMmjh6sTNBbTWSvszjwxAvyaGrK87o/JGSJ6SKrTUnOuIWqGiEUmw4INjZP3o
         H2KYjOqWjwziR/NKO5YXEnH/rJPk+vWHqvApRHa4Jhl+BWEdRF9NYRJBhTjIzvCaxMan
         VOvkhxzdsevnN6WWoMfX4HZ2zcPKH+bya3lseE+x1zr5p7ET/ax7gWJ/c3NJIqkMrFGj
         lr6fnwwbcFyifNauMSPjmj3Cfj2SwQIdTl5gTVoJ0s0EQdNNWkdHKAx4CntQLyiO31qr
         5cdvUJjDccgvePr2wv7M3Y3JTOTATbk3Uzz8xMxxzNr5C6CU+5oUHflnEaVv1ddC2uOn
         LpQQ==
X-Gm-Message-State: AOJu0YwRXdGbpd0MBpKNhc6U7Rjc3zp6WnVW2MRH40xgM18x/p+VRqyJ
	XK2jaAuDFoHyF5ge9aqvgjklwKEW5Y0i6kXxjvXWb+BCLZXt5t1iyeho
X-Gm-Gg: AfdE7ckFEa5nsiaPyT+i2RxMX2Gk/GW4+ywC47jRY6GZUpd4v+RKkHdUCvc/Jy/FTX3
	DOvWvOg1bDVlPmFtYjbAPPU/n0qY4L9T0EPD05ffsjsEd+lKto7QCkHbwpS4SbAEGQ47r5UZ5oZ
	Klp2lotM82JVF37Oc4nbG5ML0FVfnM80aWlpY71gX//eWsuUXRlFz3QIACFckmRAbaTSIZVzNx3
	XoaeFEEwc/DuIf4W8pvrPy5RBWOwMmXamA/SaBr+hBlTNemZy0/1WSraAfrpnjSQys7J/+IuKhn
	wLgukCyz7QLoo3o0KlZ+k26zGSx5opqiRXEb3Na6cUFAeweYN1oRUaVX0/MKP13ii6PHQIXBMnT
	FgzRo+r5vd1YhGT8j0ApOuArc4SiyfuGED6XcTylLmBavMouBLIuLKlPJYsTU0+0Pa/EaCD+uEK
	XxhOiiY+PfMoYP2Q==
X-Received: by 2002:a05:620a:2592:b0:915:efa6:d714 with SMTP id af79cd13be357-92092b3e2efmr316863785a.52.1781844869229;
        Thu, 18 Jun 2026 21:54:29 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a425448asm134464485a.23.2026.06.18.21.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:54:28 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Fri, 19 Jun 2026 04:53:30 +0000
Subject: [PATCH 1/5] dmaengine: sun6i-dma: Refactor to support A733
 interrupt and register handling
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-sun60i-a733-dma-v1-1-da4b649fc72a@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-11629-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 2185D6A3DF1

This patch is the first step in a refactoring effort to support the
Allwinner A733 DMA controller. Currently, the `sun6i-dma` driver has
several functions related to interrupt handling (reading/writing
interrupt enable and status registers) and register dumping that are
hardcoded.

To support the A733, which has different register layouts and interrupt
handling logic, these functions are being moved into the
`sun6i_dma_config` structure as function pointers. This allows the
driver to use a polymorphic approach where the specific implementation
is determined by the hardware configuration assigned during device
probing.

Changes:
- Added function pointers to `struct sun6i_dma_config` for:
    - `dump_com_regs`
    - `read_irq_en`
    - `write_irq_en`
    - `read_irq_stat`
    - `write_irq_stat`
- Implemented generic `sun6i_read/write_irq_*` functions for existing
  hardware.
- Updated existing `sun6i_dma_config` instances (A31, A23, H3, A64,
  A100, H6, V3S) to use these new function pointers.

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 drivers/dma/sun6i-dma.c | 74 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a9a254dbf8cb..d92e702320d9 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -138,6 +138,11 @@ struct sun6i_dma_config {
 	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
 	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
 	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
+	void (*dump_com_regs)(struct sun6i_dma_dev *sdev);
+	u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 chan_num);
+	void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 chan_num, u32 irq_val);
+	u32 (*read_irq_stat)(struct sun6i_dma_dev *sdev, u32 chan_num);
+	void (*write_irq_stat)(struct sun6i_dma_dev *sdev, u32 chan_num, u32 status);
 	u32 src_burst_lengths;
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
@@ -347,6 +352,25 @@ static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
 		  DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
 }
 
+static u32 sun6i_read_irq_en(struct sun6i_dma_dev *sdev, u32 chan_num)
+{
+	return readl(sdev->base + DMA_IRQ_EN(chan_num));
+}
+
+static void sun6i_write_irq_en(struct sun6i_dma_dev *sdev, u32 chan_num, u32 irq_val)
+{
+	writel(irq_val, sdev->base + DMA_IRQ_EN(chan_num));
+}
+static u32 sun6i_read_irq_stat(struct sun6i_dma_dev *sdev, u32 chan_num)
+{
+	return readl(sdev->base + DMA_IRQ_STAT(chan_num));
+}
+
+static void sun6i_write_irq_stat(struct sun6i_dma_dev *sdev, u32 chan_num, u32 status)
+{
+	writel(status, sdev->base + DMA_IRQ_STAT(chan_num));
+}
+
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 {
 	struct sun6i_desc *txd = pchan->desc;
@@ -460,16 +484,16 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 
 	vchan->irq_type = vchan->cyclic ? DMA_IRQ_PKG : DMA_IRQ_QUEUE;
 
-	irq_val = readl(sdev->base + DMA_IRQ_EN(irq_reg));
+	irq_val = sdev->cfg->read_irq_en(sdev, irq_reg);
 	irq_val &= ~((DMA_IRQ_HALF | DMA_IRQ_PKG | DMA_IRQ_QUEUE) <<
 			(irq_offset * DMA_IRQ_CHAN_WIDTH));
 	irq_val |= vchan->irq_type << (irq_offset * DMA_IRQ_CHAN_WIDTH);
-	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
+	sdev->cfg->write_irq_en(sdev, irq_reg, irq_val);
 
 	writel(pchan->desc->p_lli, pchan->base + DMA_CHAN_LLI_ADDR);
 	writel(DMA_CHAN_ENABLE_START, pchan->base + DMA_CHAN_ENABLE);
 
-	sun6i_dma_dump_com_regs(sdev);
+	sdev->cfg->dump_com_regs(sdev);
 	sun6i_dma_dump_chan_regs(sdev, pchan);
 
 	return 0;
@@ -549,14 +573,14 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 	u32 status;
 
 	for (i = 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
-		status = readl(sdev->base + DMA_IRQ_STAT(i));
+		status = sdev->cfg->read_irq_stat(sdev, i);
 		if (!status)
 			continue;
 
 		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
 			str_high_low(i), status);
 
-		writel(status, sdev->base + DMA_IRQ_STAT(i));
+		sdev->cfg->write_irq_stat(sdev, i, status);
 
 		for (j = 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
 			pchan = sdev->pchans + j;
@@ -1124,6 +1148,11 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.dump_com_regs    = sun6i_dma_dump_com_regs,
+	.read_irq_en      = sun6i_read_irq_en,
+	.write_irq_en     = sun6i_write_irq_en,
+	.read_irq_stat    = sun6i_read_irq_stat,
+	.write_irq_stat   = sun6i_write_irq_stat,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1147,6 +1176,11 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.dump_com_regs    = sun6i_dma_dump_com_regs,
+	.read_irq_en      = sun6i_read_irq_en,
+	.write_irq_en     = sun6i_write_irq_en,
+	.read_irq_stat    = sun6i_read_irq_stat,
+	.write_irq_stat   = sun6i_write_irq_stat,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1165,6 +1199,11 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.dump_com_regs    = sun6i_dma_dump_com_regs,
+	.read_irq_en      = sun6i_read_irq_en,
+	.write_irq_en     = sun6i_write_irq_en,
+	.read_irq_stat    = sun6i_read_irq_stat,
+	.write_irq_stat   = sun6i_write_irq_stat,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1190,6 +1229,11 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.dump_com_regs    = sun6i_dma_dump_com_regs,
+	.read_irq_en      = sun6i_read_irq_en,
+	.write_irq_en     = sun6i_write_irq_en,
+	.read_irq_stat    = sun6i_read_irq_stat,
+	.write_irq_stat   = sun6i_write_irq_stat,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1211,6 +1255,11 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.dump_com_regs    = sun6i_dma_dump_com_regs,
+	.read_irq_en      = sun6i_read_irq_en,
+	.write_irq_en     = sun6i_write_irq_en,
+	.read_irq_stat    = sun6i_read_irq_stat,
+	.write_irq_stat   = sun6i_write_irq_stat,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1232,6 +1281,11 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_h6,
 	.set_mode         = sun6i_set_mode_h6,
+	.dump_com_regs    = sun6i_dma_dump_com_regs,
+	.read_irq_en      = sun6i_read_irq_en,
+	.write_irq_en     = sun6i_write_irq_en,
+	.read_irq_stat    = sun6i_read_irq_stat,
+	.write_irq_stat   = sun6i_write_irq_stat,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1255,6 +1309,11 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_h3,
 	.set_drq          = sun6i_set_drq_h6,
 	.set_mode         = sun6i_set_mode_h6,
+	.dump_com_regs    = sun6i_dma_dump_com_regs,
+	.read_irq_en      = sun6i_read_irq_en,
+	.write_irq_en     = sun6i_write_irq_en,
+	.read_irq_stat    = sun6i_read_irq_stat,
+	.write_irq_stat   = sun6i_write_irq_stat,
 	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
@@ -1281,6 +1340,11 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.set_burst_length = sun6i_set_burst_length_a31,
 	.set_drq          = sun6i_set_drq_a31,
 	.set_mode         = sun6i_set_mode_a31,
+	.dump_com_regs    = sun6i_dma_dump_com_regs,
+	.read_irq_en      = sun6i_read_irq_en,
+	.write_irq_en     = sun6i_write_irq_en,
+	.read_irq_stat    = sun6i_read_irq_stat,
+	.write_irq_stat   = sun6i_write_irq_stat,
 	.src_burst_lengths = BIT(1) | BIT(8),
 	.dst_burst_lengths = BIT(1) | BIT(8),
 	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |

-- 
2.54.0


