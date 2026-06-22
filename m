Return-Path: <dmaengine+bounces-11703-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HzvLKiOSOGqOdwcAu9opvQ
	(envelope-from <dmaengine+bounces-11703-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:38:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2518E6ABF35
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:38:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="oyBuNH/z";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11703-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11703-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19647300AEF2
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 01:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7945025B082;
	Mon, 22 Jun 2026 01:38:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58D1519B4
	for <dmaengine@vger.kernel.org>; Mon, 22 Jun 2026 01:38:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782092320; cv=none; b=RX1Y47MInE/HGedaQqPlgIpa+nwqcfbiagZ1hW6D3De5vQNuAIOZcLbfuxYdiGPLsHyutR6zPGowsUIhGi7BGbESmtpnNu3NgwwvAaSK4liVhRDGiYmgeTaV1Dd0RUGNb+vN9UzW354Waxhp+FsJbholaaFAMBBNOBDU0nh36Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782092320; c=relaxed/simple;
	bh=7WQMevtDEMWZ3MVhKm46AMdsaGQMum4hlSPXmXykx7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mi6PyfpkGXO250GF0mxvhkh+mF0aBlz9ZsEpoFcD21ZahYnBNL5mioGtBkqBdDX1GoqAhl2kpohq3gnkXmjGCHsmmCa8CyqVDFOa8seMJTIlAStxCjD3BZpnsKkXX5a7xIxlS70UkvbmMwMe3aNcenSv3HwNB3JUTXsOUKHl2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oyBuNH/z; arc=none smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517dc520840so41767901cf.3
        for <dmaengine@vger.kernel.org>; Sun, 21 Jun 2026 18:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782092318; x=1782697118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOQx0t/yoBTjIlmpwlhy2Xp5tYNVpfWuWDWWOowITKk=;
        b=oyBuNH/z01ZQakg5udljbuGH9B7YS9h1mEYm5gA8Po4Lnj2HV5lLNmrM1pG1sE5QLt
         lVhrd0vS2+yXYsyAxV6CqYcfX/mrgN4HcWJRbWohlfUBD5BsJUaAKPnK66T+VrUFVgi/
         TLHoTT+CI/BpBgJ+h/NRkTlQj+ayKrnTmsUqFGPt2pkV1qFMkQZ8au7iEJobpC0Gt6wa
         tj9FTwF9ZanVz305dMTKmZdgI4MAME4R8MFdlXkka5mBjkN0a6JtbhJQZ3bYwp2A67Cr
         ziZ3PCEBRMEjyemAlCoaUlVAs7tPEybRx9TvuS5XplPHLb8qpdGnoqAv2voIlRUASKmX
         kKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782092318; x=1782697118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sOQx0t/yoBTjIlmpwlhy2Xp5tYNVpfWuWDWWOowITKk=;
        b=nMxtsdcvaQELKwLhQ/LFxoaHrum3Fk644FwHjqlZVadHHL2wvTYMi8iLIzzwUA71g/
         GYXNZJt3qyVamk7hnd8LoumIirb76giX3H8qNnO1EP+j0lxIer0GDKD8VMMsAhNSJf2e
         I1T6Ex0uMdoDOhnVMtscinzXyIqXmeamHjJ5B2Nb4OmIpEVjqi6sYs4nS48A782hXHPY
         sybF5EIub7wJDzGSdkBFaBYOc8w5qg53YFqBXcorOaSqD78fByhmsmMnxu92qVpVcQvN
         qMyPmYIk5iVkVFWL3VrihC+xyWCGLtWqQvnoxIlvGy0GVOIQ5iPDvQHxkDPwRO3wm4An
         fKEg==
X-Forwarded-Encrypted: i=1; AFNElJ+BKnYsUnlMZLeyL9SMz1oh9rEP7sxfinxqYiS2PooUd+M61nJvZcUwzEpzxgHxD9DG5qO67qBH4bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+LNkySQ1WD20c/gU6IKAqZLMrpxY5sarp7guPQdNgvRIOrOY
	DuXk3g4dm62/DQDHFcdTrWYZfvswdb0mKgDpUR7oeNBhRukJDtN0jcAk
X-Gm-Gg: AfdE7cnx/JpO8RrWfoUwbztT4KudsoKww3oNetV4e9jud4cKHTUxKwGe6VbcGDUKzup
	lHw5Tcyf4KHeTqr8Z5pgWkzIYGL+/5eacoCKNFviUITGs8UTjWDWWOk86kBS28nofg/xXgDkqD5
	8Li0Yu6zrlZr56D7HpEPUehJikU7RaOv7cnXIIUXYKkjPuYUzLdK6mkEJICi20Lx88PWv1UFPRn
	yhKkqkyNQhi9nzg0Ksqbk5zhan2z6G41FgD0uW82QUcPowts7WE9uVP2uaol4i0JZLFghKwf/dS
	8DucP/5euzBucS5kupD4qpgQle6gsmIWtndVK0SVXm6jJQMmZvl+p6BKmhFVpSyGgPSggXiT/nF
	RS+DNTYXNMtMIAyZ/TYAfKfAnWlkWZGFD37x05wMar/UQXO8WBIOLWZUM15sl8VzUY2R0mRpzba
	L1JJkGyLYVt4q5rQ==
X-Received: by 2002:a05:622a:14d0:b0:517:6665:2a9a with SMTP id d75a77b69052e-519e4e0acdemr186803381cf.50.1782092317978;
        Sun, 21 Jun 2026 18:38:37 -0700 (PDT)
Received: from [172.17.0.2] ([138.28.231.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a098e287csm55778831cf.29.2026.06.21.18.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 18:38:37 -0700 (PDT)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Mon, 22 Jun 2026 01:36:23 +0000
Subject: [PATCH v3 1/5] dmaengine: sun6i-dma: Refactor to support A733
 interrupt and register handling
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-sun60i-a733-dma-v3-1-f697ef296cbc@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11703-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2518E6ABF35

Refactor to support the Allwinner A733 DMA controller. Currently, the
`sun6i-dma` driver has several functions related to interrupt handling
(reading/writing interrupt enable and status registers) and register
dumping that are hardcoded.

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
- Added a macro and updated existing `sun6i_dma_config` instances (A31,
  A23, H3, A64, A100, H6, V3S) to use these new function pointers.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 drivers/dma/sun6i-dma.c | 50 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a9a254dbf8cb..ef3052c4ab36 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -138,6 +138,11 @@ struct sun6i_dma_config {
 	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
 	void (*set_drq)(u32 *p_cfg, s8 src_drq, s8 dst_drq);
 	void (*set_mode)(u32 *p_cfg, s8 src_mode, s8 dst_mode);
+	void (*dump_com_regs)(struct sun6i_dma_dev *sdev);
+	u32 (*read_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg);
+	void (*write_irq_en)(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val);
+	u32 (*read_irq_stat)(struct sun6i_dma_dev *sdev, u32 irq_reg);
+	void (*write_irq_stat)(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 status);
 	u32 src_burst_lengths;
 	u32 dst_burst_lengths;
 	u32 src_addr_widths;
@@ -347,6 +352,26 @@ static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
 		  DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
 }
 
+static u32 sun6i_read_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg)
+{
+	return readl(sdev->base + DMA_IRQ_EN(irq_reg));
+}
+
+static void sun6i_write_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 irq_val)
+{
+	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
+}
+
+static u32 sun6i_read_irq_stat(struct sun6i_dma_dev *sdev, u32 irq_reg)
+{
+	return readl(sdev->base + DMA_IRQ_STAT(irq_reg));
+}
+
+static void sun6i_write_irq_stat(struct sun6i_dma_dev *sdev, u32 irq_reg, u32 status)
+{
+	writel(status, sdev->base + DMA_IRQ_STAT(irq_reg));
+}
+
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 {
 	struct sun6i_desc *txd = pchan->desc;
@@ -460,16 +485,16 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 
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
@@ -549,14 +574,14 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
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
@@ -1101,6 +1126,13 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
 	}
 }
 
+#define SUN6I_DMA_IRQ_A31_COMMON_OPS	\
+	.dump_com_regs    = sun6i_dma_dump_com_regs,	\
+	.read_irq_en      = sun6i_read_irq_en,	\
+	.write_irq_en     = sun6i_write_irq_en,	\
+	.read_irq_stat    = sun6i_read_irq_stat,	\
+	.write_irq_stat   = sun6i_write_irq_stat,
+
 /*
  * For A31:
  *
@@ -1132,6 +1164,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
 /*
@@ -1155,6 +1188,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
 static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
@@ -1173,6 +1207,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
 /*
@@ -1200,6 +1235,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
 /*
@@ -1221,6 +1257,7 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
+	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
 /*
@@ -1244,6 +1281,7 @@ static struct sun6i_dma_config sun50i_a100_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
 	.has_high_addr = true,
 	.has_mbus_clk = true,
+	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
 /*
@@ -1266,6 +1304,7 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg = {
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
 	.has_mbus_clk = true,
+	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
 /*
@@ -1289,6 +1328,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
+	SUN6I_DMA_IRQ_A31_COMMON_OPS
 };
 
 static const struct of_device_id sun6i_dma_match[] = {

-- 
2.54.0


