Return-Path: <dmaengine+bounces-11207-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UvpgMQBLI2pwoAEAu9opvQ
	(envelope-from <dmaengine+bounces-11207-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:17:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6AF64B995
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:17:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YLtzgJET;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11207-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11207-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 707A6303B7EF
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AC237BE74;
	Fri,  5 Jun 2026 22:11:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BE38C41B
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:11:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697461; cv=none; b=Vdjp/tXb2nwHplxFCy4mPwjG/WBQgNhcEKQ9b5zmQO16OYiIcIW3fdm9PWRM60oPZ7zQp9y5m06eHJGtprsZaCwZQl4Ikk8ADAchFUW6LOw6Vhxs1N95HefFJDULVnnMkM9hnh+fk/CCd0atJr2kF+lDMVCr6PZSQytZ3YpgP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697461; c=relaxed/simple;
	bh=5RAMuuIGVzJXZtDB+vpADOLDnGzAQ7QdAAol9gDERfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YIyf9+rT1ZWHciox4JTCw1jbHF+jrytKea0Jeq0YFrmlaca2cG2tiUcCruJdSKLJhxibo1nek/6gdvI2bm7uOgPOj3ANcHfeZyT5nxPnQyhQzrgNTbNdCG+LUhwcm4xS84pV3k8SBxNA0/dsi2en+qMNq4jLGCxVlFtcULfxVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLtzgJET; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39921F00893;
	Fri,  5 Jun 2026 22:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780697460;
	bh=KBxCVF47RClkXA1s/tPsmVLRZKqYhbqlFIz3b+GdV5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLtzgJETA7WFPo9stRSkN8NIYoPNpNfK/yInOFWRn9+1r7lgPpE6/LgEKCjpTFQK2
	 HSHRmVHfwDzwH7aw0ykXuGuRHqIomWfVib81yFPxH+ybCL9+rUGJGYoF3pd5e06lh4
	 Fv5aADDNfxO92cSz+AcejMdW4eCBdTTQgTjZmnHCJjNL55KZI5x3Xn3orWm76E6M26
	 1Z5gl2Zpgo999qWjL7UeA5hKlw7dJgymXGNdYYVyRGSA9FZGhFCEZYMSvHg8a7IAaF
	 Mh0qYhRinWPru4rzBpfrcN8PDB+iRPcsPUbJJLKwvIRmsCZ24UXX6JOUXd5P3s49de
	 bpi/XSGfB7yFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] dmaengine: fsldma: replace irq_of_parse_and_map
 with of_irq_get
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605220134.43295-9-rosenp@gmail.com>
References: <20260605220134.43295-9-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 22:10:59 +0000
Message-Id: <20260605221059.F39921F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11207-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B6AF64B995

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch replaces `irq_of_parse_and_map()` with `of_irq_get()`, w=
hich can correctly return negative error codes such as `-EPROBE_DEFER` when=
 the interrupt controller is not yet ready. However, in `fsldma_request_irq=
s()`, the updated error handling block catches these negative codes but inc=
orrectly hardcodes the return value to `-ENODEV`. This squashes the actual =
error code and permanently fails the probe process, breaking probe deferral.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but DMA client callb=
acks are invoked with the channel lock (`chan->desc_lock`) held, which caus=
es an AB-BA self-deadlock if the client submits a new transaction from the =
callback. The DMAengine API explicitly allows clients to submit new transac=
tions from their completion callbacks. When a client does this, `fsl_dma_tx=
_submit()` is called, which unconditionally attempts to acquire `spin_lock_=
bh(&chan->desc_lock)`. Since `fsldma_cleanup_descriptors()` already holds t=
his non-recursive spinlock when invoking the callback via `dmaengine_desc_g=
et_callback_invoke()`, the system will deadlock.
--

commit b81f03cbd2cccca3be94e35a5c287310fb30a9de
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: replace irq_of_parse_and_map with of_irq_get

This commit replaces irq_of_parse_and_map() with of_irq_get() to handle
negative error codes appropriately. It updates the IRQ validation checks in
fsldma_request_irqs() to handle both 0 and negative error returns correctly.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 0d73ce3dbfe6a..79a268139b9f8 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1067,7 +1067,7 @@ static int fsldma_request_irqs(struct fsldma_device=
 *fdev)
>  		if (!chan)
>  			continue;
> =20
> -		if (!chan->irq) {
> +		if (chan->irq <=3D 0) {
>  			chan_err(chan, "interrupts property missing in device tree\n");
>  			ret =3D -ENODEV;

[Severity: High]
Does overriding the return value here to -ENODEV cause a regression with
probe deferral?

If of_irq_get() returns a valid negative error code like -EPROBE_DEFER
when the interrupt controller is not yet ready, catching it here but
hardcoding the return value to -ENODEV permanently squashes the actual
error code. This will cause the DMA controller to permanently fail to probe
if it initializes before its interrupt controller.

>  			goto out_unwind;
>  		}

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but I noticed an existing locking
issue with how DMA client callbacks are invoked.

Looking at fsldma_run_tx_complete_actions(), dmaengine_desc_get_callback_in=
voke()
is called synchronously without dropping chan->desc_lock.

If a client submits a new transaction from their completion callback, it wi=
ll
call into fsl_dma_tx_submit() which unconditionally attempts to acquire
spin_lock_bh(&chan->desc_lock). Since this non-recursive spinlock is already
held, this creates an AB-BA self-deadlock.

Could this be updated to drop the lock before invoking the callback, as the
DMAengine API explicitly allows clients to queue new transfers from their
completion callbacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605220134.4329=
5-1-rosenp@gmail.com?part=3D8

