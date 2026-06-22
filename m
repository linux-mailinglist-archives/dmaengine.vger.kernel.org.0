Return-Path: <dmaengine+bounces-11710-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RRTeMLeUOGoyeAcAu9opvQ
	(envelope-from <dmaengine+bounces-11710-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:49:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D66ABFBD
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 03:49:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JK9ddE5i;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11710-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11710-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CBD03001865
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 01:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED3245008;
	Mon, 22 Jun 2026 01:49:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D261A9FB7;
	Mon, 22 Jun 2026 01:49:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782092980; cv=none; b=b9XJO7cKAGDsUlpmvijYM/PfuabLeMMkJZx/4Rvg8K/T45aigx9QyZzCb511DutpJxYp9d1e406Sf/8wgLwqQY/FGmOhCzwYoKXoCeKM3s+bVmv/kBaQCgRQfSCayCQCQGxRp/C6bY7O+wjWOz7a2YmhKWvykzgo+nL2A3ThbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782092980; c=relaxed/simple;
	bh=FyK2KsZ5IDjVB3KoSl3zTc2fECYuoStdgYTiY/4hMfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nIhfeHCxAmYf4f1ONQrFQ9cIF8+IyjJ1928WIy1/2Gjpr61gPFnn+hVjDpab6PAcysF15u9FzRauqDy65RqlUO/joh9GnhtLNGAwWCFwxM5F+yj23anZho9iWdUtUAKRHRmveuB/Xfo2l/fHBtmijzIpBop+SHVU31baoZDR1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK9ddE5i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4631F000E9;
	Mon, 22 Jun 2026 01:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782092979;
	bh=jf22AfT2+1Jhu3hvn0/cZp6NbObYUckEvwqOTuD48rY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JK9ddE5i7CqHClmsqNYVGjDW38e/bdo29NskwUAcA244O1IKRJQ4/z+XeiTXjbgoU
	 9IPOppKU8I3Ile92xdJE6jC2F6w8gY4l5JJbXR1TcsVNzYIZMNkVJs9lizd97Rf19k
	 i1c8XF0916LmY6vOdSu+g/1OcrrobQhmvPrbz0n6Ul/GydqQIvDKp4qij5aDbb6Xm9
	 CgzYICuHTis6FJLDsMPY7q0lclvHCyeDvTqRQD0mPB5uo0KVgd0cgk1aIcDN/mMHJw
	 zrDj0+YCV6Uk+MMcZtqFw4KLBZTlfpjO5skVrAxIx07noRmiqqulhum9Qm7mUF1cIf
	 j+fUrCWWPBUsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] dmaengine: sun6i-dma: Add num_channels_per_reg
 for flexible interrupt mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuanshen Cao" <alex.caoys@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, vkoul@kernel.org, robh@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260622-sun60i-a733-dma-v3-3-f697ef296cbc@gmail.com>
References: <20260622-sun60i-a733-dma-v3-0-f697ef296cbc@gmail.com>
 <20260622-sun60i-a733-dma-v3-3-f697ef296cbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 01:49:37 +0000
Message-Id: <20260622014938.3A4631F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11710-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex.caoys@gmail.com,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-sunxi@lists.linux.dev,m:vkoul@kernel.org,m:robh@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:alexcaoys@gmail.com,m:conor@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C4D66ABFBD

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Loop bound truncation in `sun6i_dma_interrupt` ignores higher phys=
ical channels.
- [High] The physical channel index computation in `sun6i_dma_interrupt` co=
mpletely ignores the register offset.
--

commit 60cc97cd5f987f5b25e3c1a483094c243658c5e5
Author: Yuanshen Cao <alex.caoys@gmail.com>

dmaengine: sun6i-dma: Add num_channels_per_reg for flexible interrupt mappi=
ng

The patch introduces num_channels_per_reg to sun6i_dma_config to support
different SoC interrupt structures where channels per register may differ.
It replaces hardcoded IRQ register calculations and sets DMA_MAX_CHANNELS
to 16.

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
This is a pre-existing issue, but does this loop condition truncate the
channel count if it isn't an exact multiple of the channels per register?

For example, if an SoC has 12 channels and 8 channels per register, integer
division (12 / 8) yields 1, causing the loop to only process the first
register (channels 0-7) and skip the second register (channels 8-11).

If a transfer completes on a higher channel, could this result in an
unhandled interrupt storm since the status is never read or cleared? Should
this use DIV_ROUND_UP(sdev->num_pchans, sdev->cfg->num_channels_per_reg)?

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

[Severity: High]
This is a pre-existing issue, but does this physical channel lookup ignore
the register offset from the outer loop?

When processing the second interrupt register (i =3D 1, channels 8-15), the
inner loop accesses pchan indices 0 through 7 instead of offsetting by
i * num_channels_per_reg.

Could a legitimate hardware interrupt on channel 8 spuriously trigger the
completion callback for the client mapped to channel 0, while channel 8's
client waits indefinitely?

Should the lookup be:
pchan =3D sdev->pchans + (i * sdev->cfg->num_channels_per_reg) + j;

>  			vchan =3D pchan->vchan;
>  			if (vchan && (status & vchan->irq_type)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-sun60i-a73=
3-dma-v3-0-f697ef296cbc@gmail.com?part=3D3

