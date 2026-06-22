Return-Path: <dmaengine+bounces-11712-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IutHD9uVOGpteAcAu9opvQ
	(envelope-from <dmaengine+bounces-11712-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:54:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5516ABFE1
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:54:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bImxTYcW;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11712-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11712-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4651E300B444
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4638257845;
	Mon, 22 Jun 2026 01:54:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918651A9FB7;
	Mon, 22 Jun 2026 01:54:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782093272; cv=none; b=CdO0Om8IeaMuzd24FbNbtD/CcVRoPeX1U/wrgHMU/zXCEcPfv2g1BQ+EHwG0xPR6shVeMJaJ0FcrTQ5JlWoA2wbktAckD9xuvrWgQSfTvD1QV7JCV9JMwQGbXW9s6bQqyi8GZM/DVeTGEGyb4jNBPiK954TxTq4sdlBCkln4A9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782093272; c=relaxed/simple;
	bh=PlklY/IpzFyXfv37Sn9oCQbFJiSvX+lLW9uKUPZRQF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I1Y7Wt/NZ3drioIYbu+mzL4HQpemXbaAQqKx2RHbd1ZxG40zZ/IILn4TRMm4MXch0Iqnb2lrC+XUtZIWVliLnIkslGQqFj/exMJrH3bCY7JS8OlZ4obFbOtacRmMJ6jSi5tcqVIrrNktNoqXgIjL7i6J3Hgp4EIxjDesNt6L+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bImxTYcW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0091F000E9;
	Mon, 22 Jun 2026 01:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782093271;
	bh=Ecfz4mA83WT7F/AZKptu6avpYNvT/o0NMdfAAmc8McM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bImxTYcWIZss1dP+6Tj2+1zYyPPwFCmW8w2WF1Ee4VR4SuQiyyBg9CIgtFwea+Ern
	 9d0pIFRsSglDGHvVdORTHLw7f+M3PANgm7YzGJXQKooqef10IS+O65VaqDmCEVsYS7
	 8nDfJQMA+IWLef+4GsgwCF59mlyk7+vjukP87xSxQI4ULge3bxjeU06/PLq1BpOu4Q
	 nNVDd2YilA5e6wnqGetB+PdxXcXKbPJILxxYCnJwk932ivyD8DK5Tz4yAoO+qkA6wy
	 LDApwzOHd8b3DW8Xavaw0X5sRDM/uQhXQ/8fEYYau7G+3UPqzBIWuIsfdlPMYX/p5j
	 0Zz6gy9rpBSvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] dmaengine: sun6i-dma: Refactor to support A733
 interrupt and register handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuanshen Cao" <alex.caoys@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, robh@kernel.org, dmaengine@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260622-sun60i-a733-dma-v3-1-f697ef296cbc@gmail.com>
References: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com>
 <20260622-sun60i-a733-dma-v3-1-f697ef296cbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 01:54:30 +0000
Message-Id: <20260622015430.7C0091F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11712-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:robh@kernel.org,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-sunxi@lists.linux.dev,m:alexcaoys@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
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
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D5516ABFE1

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer division truncates the channel check in the interrupt hand=
ler, causing interrupts for channels >=3D 8 to be completely ignored on SoC=
s where the number of channels is not a multiple of 8.
- [High] Incorrect calculation of the physical channel pointer in the inter=
rupt handler aliases upper hardware channels to lower software channels, ca=
using Use-After-Free and data corruption.
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in `sun6i_k=
ill_tasklet` allows a concurrent tasklet to re-enable interrupts after they=
 were intentionally disabled, causing an unhandled interrupt storm after th=
e IRQ is freed.
--

commit 4e47cdc0e212cbdd5c17510fa923b572eb14fb54
Author: Yuanshen Cao <alex.caoys@gmail.com>

dmaengine: sun6i-dma: Refactor to support A733 interrupt and register handl=
ing

Refactor to support the Allwinner A733 DMA controller by moving interrupt
handling and register dumping functions into the sun6i_dma_config structure.
This allows a polymorphic approach determined by hardware configuration
during device probing.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..ef3052c4ab363 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -347,6 +352,26 @@ static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mod=
e, s8 dst_mode)
[ ... ]
> +static void sun6i_write_irq_en(struct sun6i_dma_dev *sdev, u32 irq_reg, =
u32 irq_val)
> +{
> +	writel(irq_val, sdev->base + DMA_IRQ_EN(irq_reg));
> +}

[Severity: High]
This is a pre-existing issue, but does disabling interrupts leave a race
condition?

In sun6i_kill_tasklet(), hardware interrupts are disabled via write_irq_en(=
0)
before tasklet_kill() is called:

sun6i_kill_tasklet()
    for (i =3D 0; i < ...; i++)
        sdev->cfg->write_irq_en(sdev, i, 0);
    atomic_inc(&sdev->tasklet_shutdown);
    devm_free_irq(sdev->slave.dev, sdev->irq, sdev);
    tasklet_kill(&sdev->task);

If sun6i_dma_tasklet() runs concurrently and calls sun6i_dma_start_desc(),
could it perform a read-modify-write on the IRQ_EN register without a lock?

This could re-enable the interrupt after sun6i_kill_tasklet() explicitly
disabled it. When devm_free_irq() is called, an active DMA channel might
then assert an unhandled IRQ, leading to an interrupt storm.

[ ... ]
> @@ -549,14 +574,14 @@ static irqreturn_t sun6i_dma_interrupt(int irq, voi=
d *dev_id)
>  	u32 status;
> =20
>  	for (i =3D 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {

[Severity: High]
This is a pre-existing issue, but does integer division truncate the channel
check here?

If num_pchans is not a multiple of 8 (like 12 on H3), dividing by 8 yields =
1.
This would mean the loop only checks channels 0-7 and ignores the second
interrupt register for channels 8-11.

Could this cause unacknowledged level-triggered interrupts from those upper
channels, leading to an interrupt storm?

> -		status =3D readl(sdev->base + DMA_IRQ_STAT(i));
> +		status =3D sdev->cfg->read_irq_stat(sdev, i);
>  		if (!status)
>  			continue;
> =20
>  		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
>  			str_high_low(i), status);
> =20
> -		writel(status, sdev->base + DMA_IRQ_STAT(i));
> +		sdev->cfg->write_irq_stat(sdev, i, status);
> =20
>  		for (j =3D 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
>  			pchan =3D sdev->pchans + j;

[Severity: High]
This isn't a bug introduced by this patch, but does the physical channel
pointer calculation alias upper hardware channels to lower software channel=
s?

The calculation sdev->pchans + j ignores the register index i.

For upper channels (where i =3D 1, meaning channels 8-15), would the handler
map the active hardware interrupt back to software channels 0-7?

It seems this might cause the driver to process and complete descriptors for
the wrong channels while the hardware is still writing to them, potentially
causing data corruption and use-after-free conditions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-sun60i-a73=
3-dma-v3-0-f697ef296cbc@gmail.com?part=3D1

