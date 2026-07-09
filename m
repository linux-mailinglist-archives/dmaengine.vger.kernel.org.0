Return-Path: <dmaengine+bounces-12215-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kgNUAiywT2oimwIAu9opvQ
	(envelope-from <dmaengine+bounces-12215-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:29:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 953247323D3
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:28:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Gw4L0+F+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12215-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12215-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BD513006B74
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A9D21E098;
	Thu,  9 Jul 2026 14:16:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE55A1A0712
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:16:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606613; cv=none; b=Ocpthnj1Gnts6q8+oFIXtkBnLTftN5n4HncZJHu10Z8xrIUSKPD4CN3F6ENkr+7HaggVKph4PWJLgoDeWCui/q2WJkOtuXL1kpXtSofd7mDrtC73qq2jZRTE3A1ThMEAHC1I150EqFE9uj5Hk5dhuNy8qJv+4pejye6Z/52XXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606613; c=relaxed/simple;
	bh=4CS9OqfWaehv+GcfuJieEPvy7eUgRV+hCARvel4RzaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dYWyZdn4c9DF0Cxyeq5ZCWogG6cukURCEyVwUTutCtMCFPamp3lrl+mkMrqg7Ym3TW6wdyZ1f65beKLZzPKK5LRENCKM9HjWDedHKXUHlF7KlSbyPyJqNZa8ibId4FfO5augVebmGiP2KBagp7hi2X3bCo0RrW8Bec/s7bjTptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw4L0+F+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CDC1F00A3F;
	Thu,  9 Jul 2026 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606612;
	bh=DlT5gF1eQvJ7O0ZrmgVU347xNWM9NAah5A/v7GEBHUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gw4L0+F+XPRF7QbXaPmahelVVBQtbYUtffIG5eKQEPqg9Uyvso5+F/Ln0s0O0B7rC
	 Nw90JlaN/GuL39D5xRE1QJPJS5QZRFOBWt/SKOew6LvsfYp6kngsde5R0T7BzHfvDy
	 RA3xSKd6OFgOK6yxzDtbjFjFGbEDr6p/l+/VE0tBSO/QyGoaRqu2psN/1GBOPcTZx8
	 Q1/AznjD7/GGIk2EA4FL/g1/XaTjZjTpoyD4EKia53uVlOTVi/RdFvonULNW0nZT08
	 8JGCgHkEvuFVdoMrEZM0zPxT7o5wXG2V9uziGbiA8lXNK5rp8rt1Gt0DsEWl3nwOE8
	 E2Gw5rZllpQQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/26] dmaengine: moxart-dma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260709135846.97972-8-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-8-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:16:51 +0000
Message-Id: <20260709141652.35CDC1F00A3F@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12215-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,vivo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 953247323D3

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a missi=
ng NULL pointer check for `txstate` in `moxart_tx_status()`, which will cau=
se a kernel panic if a caller passes a NULL state.
- [High] This problem wasn't introduced by this patch, but there is a Time-=
Of-Check to Time-Of-Use (TOCTOU) race condition in the interrupt handler `m=
oxart_dma_interrupt()` accessing `ch->desc` outside of its spinlock, leadin=
g to a NULL pointer dereference.
- [High] This problem wasn't introduced by this patch, but there is a lifec=
ycle mismatch where `dma_device` is allocated with `devm_kzalloc`, leading =
to a Use-After-Free if the driver is unbound while clients hold channel ref=
erences.
--

--- Patch [7]: [PATCH 07/26] dmaengine: moxart-dma: Remove redundant dev_er=
r()/dev_err_probe() ---
commit 9d354e585688446b04a5e03b938d46845d466dab
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: moxart-dma: Remove redundant dev_err()/dev_err_probe()

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
> index 442f5aa16031f..16a14a5179c17 100644
> --- a/drivers/dma/moxart-dma.c
> +++ b/drivers/dma/moxart-dma.c
> @@ -600,10 +600,8 @@ static int moxart_probe(struct platform_device *pdev)
> =20
>  	ret =3D devm_request_irq(dev, irq, moxart_dma_interrupt, 0,
                                         ^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but there is a Time-Of-Check to
Time-Of-Use (TOCTOU) race condition in moxart_dma_interrupt() accessing
ch->desc outside of its spinlock:

drivers/dma/moxart-dma.c:moxart_dma_interrupt() {
...
		if (ctrl & APB_DMA_FIN_INT_STS) {
			ctrl &=3D ~APB_DMA_FIN_INT_STS;
			if (ch->desc) {
				spin_lock(&ch->vc.lock);
				if (++ch->sgidx < ch->desc->sglen) {
...
}

If a concurrent call to moxart_terminate_all() on another CPU acquires the
lock, frees ch->desc, sets it to NULL, and releases the lock between the if
check and the spin_lock, the interrupt handler will unconditionally derefer=
ence
ch->desc via ch->desc->sglen.

Does this race condition lead to a NULL pointer dereference?

>  			       "moxart-dma-engine", mdc);
> -	if (ret) {
> -		dev_err(dev, "devm_request_irq failed\n");
> +	if (ret)
>  		return ret;
> -	}
>  	mdc->irq =3D irq;
> =20
>  	ret =3D dma_async_device_register(&mdc->dma_slave);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but there is a lifecycle mismatch
where dma_device is allocated with devm_kzalloc.

Earlier in moxart_probe():
	mdc =3D devm_kzalloc(dev, sizeof(*mdc), GFP_KERNEL);

And during unbind:
drivers/dma/moxart-dma.c:moxart_remove() {
...
	dma_async_device_unregister(&m->dma_slave);
...
}

The DMA engine subsystem independently refcounts the dma_device via kref_in=
it().
If the driver is unbound via sysfs while DMA clients hold references to the
channels, moxart_remove() returns and devres frees the mdc structure memory
immediately.

When the clients later drop their references, does this trigger a
Use-After-Free on the freed memory?

While reviewing the driver, I also noticed an issue in moxart_tx_status():

drivers/dma/moxart-dma.c:moxart_tx_status() {
...
	if (vd) {
		d =3D to_moxart_dma_desc(&vd->tx);
		txstate->residue =3D moxart_dma_desc_size(d, 0);
...
	} else if (ch->desc && ch->desc->vd.tx.cookie =3D=3D cookie) {
		txstate->residue =3D moxart_dma_desc_size_in_flight(ch);
...
}

[Severity: High]
This isn't a bug introduced by this patch, but there is a missing NULL poin=
ter
check for txstate in moxart_tx_status().

The dmaengine API allows callers to pass a NULL state argument to
dmaengine_tx_status() if they only want to query the completion status and
do not need the residue. However, this function unconditionally dereferences
txstate.

Will this cause a kernel panic if a caller passes a NULL state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D7

