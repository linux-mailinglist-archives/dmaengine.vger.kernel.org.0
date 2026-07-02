Return-Path: <dmaengine+bounces-11969-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cMGaBWduRmoJUwsAu9opvQ
	(envelope-from <dmaengine+bounces-11969-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 15:57:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB166F89DF
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 15:57:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CkJfEVTL;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11969-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11969-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E73D53002D37
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5174F4A3405;
	Thu,  2 Jul 2026 13:57:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6BA496919
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 13:57:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000625; cv=none; b=tau6N9is3kclNVeQFkymuMjW/5zY1KQ+5DF6oAhYJoL1y9IlGmOUHbX86HLl4DPqgHN96XmWJCyEuUwzr+1MGPPzcUqtlzbuAYeIe3kGu7X1y1Kb8jO7KO06Kk3OwuhRMSIIXk9SaS8jySLrm7cUIJUuAYy/8nsLY6+ZlqbMnwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000625; c=relaxed/simple;
	bh=acpRMogvP+QZ48wGPTUld9zPeR2eD8SXqAphZAC6Mg8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kelBW24ulrHbiGq287ogX5qwG1GybOUMuHiPUMizTh6koGdz8r5FmI8bSx1oTHmcBKcDS/5VvrZz9FsKTcp6qlwkkHPBLKEC+gjB2dL9nBY1Ph8cx4yvD6zzBJOFSDog0MSrJEWAfmi0tTvGmpTMPis396CqI0wm6JsYgca8Gqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkJfEVTL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A91C1F000E9;
	Thu,  2 Jul 2026 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783000623;
	bh=wJeVC1okBrh1kv0KkwG6ZlNO20ssR1bY9LdDcGARXtc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CkJfEVTLgpJm0jn/d7JRT+et0bAE1e9heV1u1fqKOda8W2udaTZVapzFQ93aeLQYK
	 w4osu1tJkHhLh0HQhVXPuYy30My0IkRmtXRJh+UG19opCy/msc1V3XDV6kUcgEBcNF
	 NW3mULQHmMW0MvibdM0QW7i5nVfR5r/WXPdtYetyzO6dKNsPLLi0lu3mrc2R+X/Qug
	 OxTY3UPuv8By0sJ2M/lIUYap4NJ6Fdy/kjhHPPE5jHtExo6G7ubPb3Y5WH8aicKzW/
	 Q2YohskgCxGrcSdY/q9P2sTgNNN6hF0Szmo09jrI9Q3N1Au/0GAYSqXhWT7ouxga72
	 WLk9/dm76uPYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: nbpfaxi: Fix setting channel irqs in probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Taedcke" <christian.taedcke@weidmueller.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com>
References: <20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 13:57:02 +0000
Message-Id: <20260702135703.7A91C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11969-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke@weidmueller.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBB166F89DF

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a heap buffer overflow and uninitialized memo=
ry read when assigning IRQs, which triggers if the error IRQ (`eirq`) is th=
e last element in `irqbuf`.

Pre-existing issues:
- [High] The probe function contains an infinite loop if the platform devic=
e is configured with fewer than 9 IRQs.
- [High] In the error path of `nbpf_desc_page_alloc()`, a memory page is le=
aked and the wrong size is passed to `dma_unmap_single()`.
- [High] The device's shared IRQs are requested before its clock is enabled=
, potentially causing kernel panics (data aborts) if an interrupt triggers =
early.
--

commit ece6c7ef191ef5f893ded32908010de168eac2be
Author: Christian Taedcke <christian.taedcke@weidmueller.com>

dmaengine: nbpfaxi: Fix setting channel irqs in probe()

This commit updates the loop iterating over channel irqs in the nbpfaxi dri=
ver
to iterate over all collected irqs instead of the channel count. This ensur=
es
that skipping the error irq does not lead to the last channel being left
without an assigned irq.

> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 05d7321629cc8..74ff7bd979e26 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1374,7 +1374,7 @@ static int nbpf_probe(struct platform_device *pdev)
>  		if (irqs =3D=3D num_channels + 1) {
>  			struct nbpf_channel *chan;
> =20
> -			for (i =3D 0, chan =3D nbpf->chan; i < num_channels;
> +			for (i =3D 0, chan =3D nbpf->chan; i < irqs;
>  			     i++, chan++) {
>  				/* Skip the error IRQ */
>  				if (irqbuf[i] =3D=3D eirq)

[Severity: High]
Does this loop write past the end of the nbpf->chan array if the error irq
happens to be the last element in irqbuf?

With the new loop condition i < irqs, chan is advanced unconditionally on
every iteration.

If the platform provides the error irq as the final entry, on the last
iteration chan will point past the end of the dynamically allocated
nbpf->chan array.

The code then increments i to skip the error irq and writes from
out-of-bounds stack memory at irqbuf[i] into the out-of-bounds chan->irq
pointer.


While reviewing the above, I also noticed a few pre-existing issues in this
driver.

drivers/dma/nbpfaxi.c:nbpf_probe() {
[ ... ]
	for (i =3D 0; irqs < ARRAY_SIZE(irqbuf); i++) {
		irq =3D platform_get_irq_optional(pdev, i);
		if (irq < 0 && irq !=3D -ENXIO)
			return irq;
		if (irq > 0)
			irqbuf[irqs++] =3D irq;
	}
[ ... ]
}

[Severity: High]
This is a pre-existing issue, but does this loop hang indefinitely if the
device is configured with fewer than 9 irqs?

If platform_get_irq_optional() returns -ENXIO, we ignore the error but do
not increment irqs or break out of the loop.

Since i continues to increment without irqs reaching ARRAY_SIZE(irqbuf), it
appears the driver will endlessly query for non-existent irqs.


drivers/dma/nbpfaxi.c:nbpf_probe() {
[ ... ]
	ret =3D devm_request_irq(dev, eirq, nbpf_err_irq,
			       IRQF_SHARED, "dma error", nbpf);
[ ... ]
	ret =3D clk_prepare_enable(nbpf->clk);
[ ... ]
}

[Severity: High]
This isn't a bug introduced by this patch, but could this cause a hard fault
if another device on the same shared irq line triggers an interrupt before
our clock is enabled?

We call devm_request_irq() with IRQF_SHARED here, but clk_prepare_enable()
isn't called until later in nbpf_probe().

If a shared interrupt fires in this window, the interrupt handler might
attempt to read unclocked memory-mapped registers.


drivers/dma/nbpfaxi.c:nbpf_desc_page_alloc() {
	struct nbpf_desc_page *dpage =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_=
DMA);
[ ... ]
unmap_error:
	while (i--) {
		ldesc--; hwdesc--;

		dma_unmap_single(dchan->device->dev, ldesc->hwdesc_dma_addr,
				 sizeof(hwdesc), DMA_TO_DEVICE);
	}

	return -ENOMEM;
}

[Severity: High]
This is a pre-existing issue, but does the unmap_error path leak the alloca=
ted
dpage?

Additionally, is the wrong size passed to dma_unmap_single()?

It uses sizeof(hwdesc), which is the size of the pointer, instead of
sizeof(*hwdesc).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-upstreamin=
g-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com?part=3D1

