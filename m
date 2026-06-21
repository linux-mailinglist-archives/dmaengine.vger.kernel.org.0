Return-Path: <dmaengine+bounces-11695-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ekmyNbxdOGogbgcAu9opvQ
	(envelope-from <dmaengine+bounces-11695-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:55:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F00D6ABAAE
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 23:55:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=csv5pvDE;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11695-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11695-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAA88300951E
	for <lists+dmaengine@lfdr.de>; Sun, 21 Jun 2026 21:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B25370D54;
	Sun, 21 Jun 2026 21:55:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F102AE76;
	Sun, 21 Jun 2026 21:55:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078904; cv=none; b=AEWl05Kova2UN5WVNo/XUzGbdPnP8ep7WBV52ffB+OmffU+u+vO3JFqofzuTrIphdrk2Li4gFQXN005gh8MI+OoE8SUZbwILpsDUCmA7aOEGSsO5AGw1QGOgxWL9imax4WSskJJNM0ePP1pt3UGR+/IaId4OnSDHUnOnsdB2/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078904; c=relaxed/simple;
	bh=/7Y2RBoF5vQaTrf2VlHqNHlBqJ+1LC/Pyctm/frPd6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WugyXmADc4zmHgLGsNfl2WwSTMjAho4bPZDHehJ3Q5PzTz4NP80J8eiWCe4uxF9QPJ3chta0sCzm0GBBBLCtNEt1wCCoayr1MkYqjR677kM0w2XSaOZ3tDK/h8Lm7Nyecz+v9iRwdP98E1t/yJw/J1X2sVOeJm8V/9MmcNiVTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csv5pvDE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79791F000E9;
	Sun, 21 Jun 2026 21:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078903;
	bh=anAsEb2eGl0kqBiiNAX1mycaZqORBB2LIOYqyUQM4cc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=csv5pvDE6wbuVsLl+6apMDtUzrV9JIk8vdJwKiQsjU9zpJW/Jg11sMXwwPafUECJI
	 Pv3eglbGR8zy1SY76XsZGrbz4Mnf6AHl1klc+XyUJ6bX4K/z5kfVgS8Kl6XIxBKWNx
	 MaTXVNI6vGOcH9VaauOsaomZGmKv3mwwrNTaoXdbxop8S/BfB3RYNtqvTq2SumAb1M
	 IYsT7FdawAw2lvAfJLpruzPQyO3wnwxGCZp5EfG6OMGez70eyiNzQPwGaUeOqIn76E
	 +lbjMddXPwct5BLtd9Twg1SdoDlvxJO9xG/JK4ylYRyosf+tmVad2gPcqKgRf4OKoG
	 uNnCBHmW2jV8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] dmaengine: sun6i-dma: Add num_channels_per_reg
 for flexible interrupt mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuanshen Cao" <alex.caoys@gmail.com>
Cc: robh@kernel.org, linux-sunxi@lists.linux.dev, Frank.Li@kernel.org, dmaengine@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260621-sun60i-a733-dma-v2-3-340f205891cc@gmail.com>
References: <20260621-sun60i-a733-dma-v2-0-340f205891cc@gmail.com>
 <20260621-sun60i-a733-dma-v2-3-340f205891cc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 21:55:02 +0000
Message-Id: <20260621215502.B79791F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11695-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:robh@kernel.org,m:linux-sunxi@lists.linux.dev,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:vkoul@kernel.org,m:alexcaoys@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F00D6ABAAE

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The interrupt handler calculates the physical channel pointer =
without accounting for the register index `i`, erroneously aliasing all int=
errupts from secondary registers to the first group of channels.
- [High] The interrupt handler uses integer division to determine the numbe=
r of IRQ registers to poll, entirely missing trailing channels if `sdev->nu=
m_pchans` is not a multiple of `num_channels_per_reg`.
--

commit 8ce409f21992b8890893dbba369b1293cac22679
Author: Yuanshen Cao <alex.caoys@gmail.com>

dmaengine: sun6i-dma: Add num_channels_per_reg for flexible interrupt mappi=
ng

This commit introduces num_channels_per_reg to the sun6i_dma_config and
updates DMA interrupt handling to avoid hardcoded register limits. It also
changes DMA_MAX_CHANNELS to 16 to align with the new BSP code.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 9984b9033cbb9..196a0d73b2212 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c

[ ... ]

> @@ -575,7 +576,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void =
*dev_id)
>  	int i, j, ret =3D IRQ_NONE;
>  	u32 status;
> =20
> -	for (i =3D 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
> +	for (i =3D 0; i < sdev->num_pchans / sdev->cfg->num_channels_per_reg; i=
++) {

[Severity: High]
This is a pre-existing issue, but does this loop boundary condition truncate
the number of required registers to check?

In drivers/dma/sun6i-dma.c:sun6i_dma_interrupt(), the loop boundary conditi=
on
sdev->num_pchans / sdev->cfg->num_channels_per_reg uses integer division.
For configurations like sun8i_h3_dma_cfg, num_pchans is 12 and
num_channels_per_reg is 8. The division evaluates to 1, meaning the handler
will only check the first register (channels 0-7) and skip checking the
secondary register (channels 8-11).

If an interrupt triggers on channels 8-11, could the level-sensitive IRQ
remain asserted without being cleared, causing a continuous interrupt storm
that freezes the CPU core? Would using DIV_ROUND_UP prevent this truncation?

>  		status =3D sdev->cfg->read_irq_stat(sdev, i);
>  		if (!status)
>  			continue;
> @@ -585,7 +586,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void =
*dev_id)
> =20
>  		sdev->cfg->write_irq_stat(sdev, i, status);
> =20
> -		for (j =3D 0; (j < DMA_IRQ_CHAN_NR) && status; j++) {
> +		for (j =3D 0; (j < sdev->cfg->num_channels_per_reg) && status; j++) {
>  			pchan =3D sdev->pchans + j;

[Severity: Critical]
This is a pre-existing issue, but does this inner loop calculate the physic=
al
channel pointer correctly for secondary registers?

In sun6i_dma_interrupt(), the pchan pointer is resolved using only the
inner loop index j. This ignores the outer loop's register index i. If an
interrupt fires for a channel in a secondary register (for example, channel
8, where i =3D 1 and j =3D 0), the handler appears to erroneously fetch
sdev->pchans[0] instead of sdev->pchans[8].

Could this premature completion of an active transfer on channel 0 lead to
a use-after-free if the client frees the buffer while hardware DMA is still
running, while the actual requesting channel hangs indefinitely? Should the
index calculation include the register offset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-sun60i-a73=
3-dma-v2-0-340f205891cc@gmail.com?part=3D3

