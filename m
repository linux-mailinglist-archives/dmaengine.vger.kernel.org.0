Return-Path: <dmaengine+bounces-11694-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sC0mCXxdOGoRbgcAu9opvQ
	(envelope-from <dmaengine+bounces-11694-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:54:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DBC6ABAA9
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:54:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ifz51Np7;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11694-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11694-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07061300F14A
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 21:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1AD371880;
	Sun, 21 Jun 2026 21:53:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16037081A;
	Sun, 21 Jun 2026 21:53:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078838; cv=none; b=JsrUx7eCO1Z6bFU7dCUj5QmWVy63szougKZ9IDGqe9e6pD7yefGzLi19jftTOJ6yNnaqdnidj3bqISfrh6h4Paw9a5R3HSgHbQe/CVqqVPZZwHN4GpisjH1/jgI/35hmP4T7AroMW9ap6SNZ5dHqfSjzkUfRFWASj/7LKoYyrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078838; c=relaxed/simple;
	bh=AhS+K7Ayi8/5kB6BzLSDCIfMwnXBUOemJ+CPxm6KtYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S/mjtthanj2WiFIs4uAGQBFf+Frl8kRoZGuLvSqyPhqjeGE8QCFKyV81/Prk3HDvmD1Xh1844EORd6wNbUjSNBySUaE1Xp24YktRFtwoBI42xJGO5P3XBmt+7N7ag57Dpth5FbUl20wA0vtiLPfcRkPC6IeX47pD93+HYO4UEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifz51Np7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8961F000E9;
	Sun, 21 Jun 2026 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078837;
	bh=W6Y+YCZKJYANSq4CJcdcokz8/zSDiGldY3OPOQLeTcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ifz51Np71ZAx5x5Jo3akJL9ex3+mm1ziGn3BTAuaH4OA3+OqElGNyWw4z5PVF/GBK
	 Mqszsj5WWtsuPh8h/2GL4MdSAlH25Tfaorz4qHzdKeapiFsaLre2I6YJpvkf/MX9F4
	 n19cQKx/k4MAbo8Yk0fydq0HZ3oVPTy+/N3bU0r40wLLMWsDxaO2HvoxmQhv1odU3w
	 /G2Z64+YdWbpRY4FLRZlzf/4E6stNdHw+ECW/FheQdrEV35XgsfCr9yR75dF0kgtN3
	 Lo4u2GiXSUP4zSgq7RiQFKBUm+FdFtJR6EV0BX2WYQbwXBfddBB9u2K4/sEMTsm1Mq
	 4ebWhLyGaVx/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] dmaengine: sun6i-dma: Implement support for
 Allwinner A733 DMA controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuanshen Cao" <alex.caoys@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260621-sun60i-a733-dma-v2-5-340f205891cc@gmail.com>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
 <20260621-sun60i-a733-dma-v2-5-340f205891cc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 21:53:56 +0000
Message-Id: <20260621215356.EC8961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11694-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-sunxi@lists.linux.dev,m:devicetree@vger.kernel.org,m:dmaengine@vger.kernel.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:alexcaoys@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85DBC6ABAA9

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incorrect physical channel indexing in the interrupt handler m=
aps all A733 physical channel interrupts to `sdev->pchans[0]`.
- [High] Integer division truncation in the interrupt handler's outer loop =
condition causes upper DMA channels to be completely ignored.
--

commit 5f14cc2c94bb065f85b3b101369ba127ddd3a538
Author: Yuanshen Cao <alex.caoys@gmail.com>

dmaengine: sun6i-dma: Implement support for Allwinner A733 DMA controller

This patch adds support for the Allwinner A733 DMA controller by defining
its specific register macros and interrupt structures. It introduces
a new sun60i_a733_dma_cfg with A733-specific configuration, notably setting
the number of channels per interrupt register to 1.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 196a0d73b2212..4808015934ccb 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c

[ ... ]

> @@ -1339,6 +1398,33 @@ static struct sun6i_dma_config sun50i_h6_dma_cfg =
=3D {
>  	SUN6I_DMA_IRQ_A31_COMMON_OPS
>  };
> =20
> +/*
> + * The A733 binding uses the number of dma channels from the
> + * device tree node.
> + */
> +static struct sun6i_dma_config sun60i_a733_dma_cfg =3D {
> +	.clock_autogate_enable =3D sun6i_enable_clock_autogate_h3,
> +	.set_burst_length =3D sun6i_set_burst_length_h3,
> +	.set_drq          =3D sun6i_set_drq_h6,
> +	.set_mode         =3D sun6i_set_mode_h6,
> +	.set_addr         =3D sun6i_dma_set_addr_a733,
> +	.dump_com_regs    =3D sun6i_dma_dump_com_regs_a733,
> +	.read_irq_en      =3D sun6i_read_irq_en_a733,
> +	.write_irq_en     =3D sun6i_write_irq_en_a733,
> +	.read_irq_stat    =3D sun6i_read_irq_stat_a733,
> +	.write_irq_stat   =3D sun6i_write_irq_stat_a733,
> +	.src_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
> +	.dst_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
> +	.src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	.dst_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES),
> +	.num_channels_per_reg =3D DMA_IRQ_CHAN_NR_A733,

[Severity: High]
This is a pre-existing issue, but I wanted to ask about how the current
interrupt handling interacts with num_channels_per_reg.

In sun6i_dma_interrupt() in drivers/dma/sun6i-dma.c, the outer loop
determines the number of registers to check using integer division:

    for (i =3D 0; i < sdev->num_pchans / sdev->cfg->num_channels_per_reg; i=
++) {
        status =3D sdev->cfg->read_irq_stat(sdev, i);

If the number of physical channels is not a perfectly divisible multiple
(e.g., a controller with 12 channels and 8 channels per register), the
division truncates to 1. Will this cause the handler to ignore the upper
registers entirely, leading to silent timeouts on upper channels?

[Severity: Critical]
This is also a pre-existing issue, but how does sun6i_dma_interrupt()
resolve the physical channel when i > 0?

    for (j =3D 0; (j < sdev->cfg->num_channels_per_reg) && status; j++) {
        pchan =3D sdev->pchans + j;
        vchan =3D pchan->vchan;

The calculation pchan =3D sdev->pchans + j ignores the register index i.

Because DMA_IRQ_CHAN_NR_A733 is 1, j will always be 0. Doesn't this mean
every interrupt on the A733 controller will incorrectly map to channel 0,
causing channel 0 to complete spuriously while the actual triggering
channel hangs?

> +	.has_mbus_clk =3D true,
> +};
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-sun60i-a73=
3-dma-v2-0-340f205891cc@gmail.com?part=3D5

