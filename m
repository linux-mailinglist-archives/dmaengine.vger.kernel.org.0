Return-Path: <dmaengine+bounces-11086-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNVnOSbiHGozTwkAu9opvQ
	(envelope-from <dmaengine+bounces-11086-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 03:36:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC3618A44
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 03:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC6BB300398B
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 01:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384A198A17;
	Mon,  1 Jun 2026 01:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWDpBCat"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16D1EB5CE
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780277792; cv=none; b=AfAuHGMtLZ3tJhA63yJ44NVY8ceY0/25vB6PSrlGynsPkjvEBgi5zWP6s807F2TTbyef3adFj9PSeX5VzPzJ22J8ozObjB7Zk2ECW12LDD5aSF7r19lClDyEV83AfRWsCaA2EgXGcCF6/8KeI4sgfnSlN21+PJ6H5J4ZH4vdvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780277792; c=relaxed/simple;
	bh=sftAr9se8+44PxL3VCCBN+FreTbSpf83GAa6vU8cM+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iSuAMDPl06G4PPx9NgTy3qSpSQdGZCC4588x6X0cYZlOmIUQzgE6WJmLTdpFGWLgAfnT0OL/hFuAorfEnSNejuLdu5SFdNA7aHIq6fw3su7X6yTnxHHbCltK06lr1hRg5VY8+8Lup0CgBAUv/6B+3WfUGX85NUCwHQS/UKKMNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWDpBCat; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9351F00893;
	Mon,  1 Jun 2026 01:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780277789;
	bh=L45yuUp4kbyLdi19DGvyXBHeRWI96V9zqDADqrJz07Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OWDpBCatyXLDhYzFhyQQyc4u2wxxXxxEI7W/zVPLUIPdPLa9CGPs87lUGSXZRF30m
	 S50kw8a0ULboO3lI8sRqepNd1kKGlaV/pL1EUHA/6Z2xqRXop7+cyWE2aba6xQnC0Z
	 9fSADpF3hjyX0xlJtQ+krMIWdLAIItQsQeeo/DZJAbO3/R9isah/49lI+lsdx3JqjM
	 wotgfYrNtkfnwQCLLEhyf9vdFEvwixvmvFZMMkxHQoNUPfhKecTZBye+ND0MNUTVtp
	 udkCQ3egIDjAY9WMf6oAa0V0Ose2POJPfOWCZvWYGhrHq737puiiLSnlsKQ5pS4NO0
	 2fSUc9Jvhmpug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] dmaengine: ti: omap-dma: use devm for dmaengine
 registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260601003553.72573-6-rosenp@gmail.com>
References: <20260601003553.72573-6-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 01:36:28 +0000
Message-Id: <20260601013629.3D9351F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11086-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 5DDC3618A44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deferring `dma_async_device_unregister()` to devres causes channel=
 unregistration to be bypassed, leading to massive memory/IDA leaks and use=
-after-free vulnerabilities via sysfs.
--

commit 84422286fe64ab8c41da494ee410b719bf268fc6
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: use devm for dmaengine registration

This commit switches to dmaenginem_async_device_register() to handle
unregistration automatically via devres. It removes the explicit
dma_async_device_unregister() calls from the probe error path and remove
function.

>     - The explicit dma_async_device_unregister() in the
>       of_dma_controller_register error path (devres unwind runs it
>       after omap_dma_free() has emptied the channels list, making the
>       iteration a safe no-op).

[Severity: High]
Is it actually safe for the channels list to be emptied before
dma_async_device_unregister() runs?

The commit message mentions this is a safe no-op, but looking at
omap_dma_free(), it empties the channel list and frees the structs:

drivers/dma/ti/omap-dma.c:omap_dma_free() {
    ...
    while (!list_empty(&od->ddev.channels)) {
        c =3D list_first_entry(&od->ddev.channels, ...);
        list_del(&c->vc.chan.device_node);
        ...
        kfree(c);
    }
}

Later, when the devres-managed dma_async_device_unregister() executes, it
iterates over the now-empty list:

drivers/dma/dmaengine.c:dma_async_device_unregister() {
    ...
    list_for_each_entry_safe(chan, n, &device->channels, device_node)
        __dma_async_device_channel_unregister(device, chan);
    ...
}

Since the core unregistration iteration is bypassed, won't this silently
skip channel teardown? It looks like this would leak IDAs and leave active
sysfs nodes with dangling pointers to the freed channel memory. If userspace
accesses these sysfs attributes later, could it lead to a use-after-free?

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 8c32b7ab50f63..4bf34569d82bb 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c

[ ... ]

> @@ -1878,8 +1876,6 @@ static void omap_dma_remove(struct platform_device =
*pdev)
>  	if (pdev->dev.of_node)
>  		of_dma_controller_free(pdev->dev.of_node);
> =20
> -	dma_async_device_unregister(&od->ddev);
> -
>  	if (!omap_dma_legacy(od)) {
>  		spin_lock_irq(&od->irq_lock);
>  		od->irq_enable_mask =3D 0;

[ ... ]

> @@ -1888,10 +1884,6 @@ static void omap_dma_remove(struct platform_device=
 *pdev)
>  		omap_dma_glbl_read(od, IRQENABLE_L1);
>  	}
> =20
> -	irq =3D platform_get_irq(pdev, 1);
> -	if (irq > 0)
> -		devm_free_irq(&pdev->dev, irq, od);
> -
>  	omap_dma_free(od);
> =20
>  	if (od->ll123_supported)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601003553.7257=
3-1-rosenp@gmail.com?part=3D5

