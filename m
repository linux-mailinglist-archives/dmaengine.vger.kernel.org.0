Return-Path: <dmaengine+bounces-11981-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D61RDE2JRmpUYAsAu9opvQ
	(envelope-from <dmaengine+bounces-11981-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:52:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 250476F9B59
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 17:52:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EWlU3JeQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11981-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11981-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8CF33020ED4
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D105433E91;
	Thu,  2 Jul 2026 15:40:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58704433E8C
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 15:40:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006853; cv=none; b=X+P8rpIFlEXWi2vAzBFDdhEp8/sUYRL0lY/9D+NUvMyzjaBo/fcG7tRBOVkeDic06rv45CrVWD/DCHeDtXcEpU00s2YFQpSamWKdXufFm6hdeQ/4Bnhby49DyWD2UnbEcJeMVQkg1hIHc/JN/bsTqOGQd4AVuoDqcqKsWewe5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006853; c=relaxed/simple;
	bh=cCOJep1KgzYznCab4LSFT8Bvt9y4e7d4ygZbs1EjrRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GGTzUtxOJCFN2DVDuI5kRN0XJp3RtJz51L5aYsTrFGeM8MARGl9Zy9s4ZLINqQR5YYzjLQr4X6FeyBUCTLbh15VKBNtA58PmGN6pSfbkQYIjElYDtmC7Mk5YKdierzT588kU1BJpFDt5o1FoH8z+m74XqynK0oKFXOfA1cnGSOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWlU3JeQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F091F000E9;
	Thu,  2 Jul 2026 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006852;
	bh=NPAb/lAT7pzB1zLfCufwxfOHcA2ZJrywOg3M36OAGNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EWlU3JeQRzCVtMxalrqEvTY1/RyoFdjNxV6NihxXPuJaB9i2lD6cZGAindv+Es1nn
	 yac1S61fHwsuuL66lJG1VxPDDhY+LzLpfEQcqzPE/JPS11pg92DJ2J3FZaPB4oVKSX
	 yRw4QopcbZIse7OwzAiNreyHPkB0uv77qotbAQPVejt+GnpSIYdHFHGB7Ci4K5ofXH
	 MlFIIn10X8O1e3JGzlphtIlY6CzUC3zozTDERObR3T/tJU0gWmqxS3OSV6Qr+Dg48O
	 1G0j2wW3EI168F+7KnzKIVR3Ugu1zG3lts1djJSkHx8FUZinyC1zW0/2xG0cMfMZ50
	 cpxkfWoMWHJyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Taedcke" <christian.taedcke@weidmueller.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com>
References: <20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:40:51 +0000
Message-Id: <20260702154051.C3F091F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11981-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke@weidmueller.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lists.linux.dev:replyto,weidmueller.com:email,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 250476F9B59

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Heap buffer overflow in channel IRQ assignment loop if the 'error'=
 IRQ is not in `irqbuf`.

Pre-existing issues:
- [High] Infinite loop in `nbpf_probe()` if the device tree provides fewer =
than 9 interrupts.
- [High] Use-after-free on probe error paths due to missing `tasklet_kill()=
`.
--

commit 20180c724c3634307b1f833b241c0ea7d9e4c009
Author: Christian Taedcke <christian.taedcke@weidmueller.com>

dmaengine: nbpfaxi: Fix setting channel irqs in probe()

This commit changes the per-channel IRQ assignment loop to iterate over the
total number of collected IRQs instead of the channel count. This ensures
that skipping the error IRQ does not prematurely terminate the loop and lea=
ve
the last channel without an assigned IRQ.

> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 05d7321629cc8..bcfab62a71d75 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1374,14 +1374,12 @@ static int nbpf_probe(struct platform_device *pde=
v)
>  		if (irqs =3D=3D num_channels + 1) {
>  			struct nbpf_channel *chan;
> =20
> -			for (i =3D 0, chan =3D nbpf->chan; i < num_channels;
> -			     i++, chan++) {
> +			for (i =3D 0, chan =3D nbpf->chan; i < irqs; i++) {
>  				/* Skip the error IRQ */
>  				if (irqbuf[i] =3D=3D eirq)
> -					i++;
> -				if (i >=3D ARRAY_SIZE(irqbuf))
> -					return -EINVAL;
> +					continue;
>  				chan->irq =3D irqbuf[i];
> +				chan++;
>  			}

[Severity: High]
If a malformed device tree causes the 'error' interrupt to not match any
of the interrupts in irqbuf, the continue statement will never be reached.
Could this lead to chan being incremented num_channels + 1 times, causing an
out-of-bounds write to the nbpf->chan array on the final iteration?

[Severity: High]
This is a pre-existing issue, but looking earlier in nbpf_probe(),
there appears to be a problem if the device tree provides fewer than 9
interrupts:

drivers/dma/nbpfaxi.c:nbpf_probe() {
	...
	for (i =3D 0; irqs < ARRAY_SIZE(irqbuf); i++) {
		irq =3D platform_get_irq_optional(pdev, i);
		if (irq < 0 && irq !=3D -ENXIO)
			return irq;
		if (irq > 0)
			irqbuf[irqs++] =3D irq;
	}
	...
}

If platform_get_irq_optional() returns -ENXIO, irqs is not incremented.
Would this cause an infinite loop where i increments endlessly because irqs
never reaches ARRAY_SIZE(irqbuf)?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential use-after-free
later in nbpf_probe() during error handling:

drivers/dma/nbpfaxi.c:nbpf_probe() {
	...
	ret =3D clk_prepare_enable(nbpf->clk);
	if (ret < 0)
		return ret;
	...
}

If clk_prepare_enable() fails, the function returns without killing the
tasklets initialized in nbpf_chan_probe(). If a shared interrupt fires befo=
re
the devres framework frees the IRQ and memory, could this schedule a tasklet
that accesses the freed nbpf structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-upstreamin=
g-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com?part=3D1

