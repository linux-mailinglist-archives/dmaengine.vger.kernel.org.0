Return-Path: <dmaengine+bounces-11071-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xj+lCm6gG2qDEwkAu9opvQ
	(envelope-from <dmaengine+bounces-11071-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:43:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6608D6143F8
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 04:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3348C302D96B
	for <lists+dmaengine@lfdr.de>; Sun, 31 May 2026 02:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C132D9EFF;
	Sun, 31 May 2026 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa3lFUAU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9347A22424C
	for <dmaengine@vger.kernel.org>; Sun, 31 May 2026 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780195434; cv=none; b=Ng75DG8b9XxCu6mugJ3AWx6mA+FRokJydwwvxXSFJP6CS/GboPfEf1hgWVK8eMoyTbE3vZ3UjLLc+j4TqRUSq79UOyUbw4f8Tqjnv2o7bMUrNSiNrWbx4RYqQGPjtatpBDIiVZOk+cOtPuXZenTqinznA3saO9uYnJ3xNtFq0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780195434; c=relaxed/simple;
	bh=Hqw0ohWWSLEd2EbMSxg6AxZ2prK/79GGstweZqrPv4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cS5jZkvlyUOcJNPqRjYZvPizWSzb2edzcLPNUhwFZziBT8uONZbsVQV8q/g0hIP5vnlUYFVNMqbqjhtpcYM+B3kHALXYZXy7QFYEUOFogN1rwr1pOJNuLDvWjfW3SbC0fG2iXkoNFBhRwMnjEkyqfjISO6t8Bal7APnhCWowsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa3lFUAU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51461F00893;
	Sun, 31 May 2026 02:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780195433;
	bh=NatqT1uBZTULBnBQ3uIVQqPmArXnaPRvoI7MGUkL32c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oa3lFUAU9z67WScBrmtMXDFktAujAq5FoX3dK1G8XOLlBTaPGE3hGGQrKFP1j9VbM
	 KhOeVuHJ0lB56vGvh+1KVUlFowl1ha3uOz8LVJkzqAdyvYaQjhQoaKOgzj/b2Vig7T
	 f3J7OC1xYLsUCb9dsYZzfeTM9p/Air262hgKbBa8EUcMKJ3xtcT6W8PtmEUorfXKiK
	 HI4g971pPh/nx8ZGctVgZwDWxDJtTx0xR0EmvI4TOLdDCpBP/vlQO4FcCi1SZBHeqe
	 wp4QxhOwrwiAm4rlgcK8nC8AuMxk8JlfNKBsHWzDVy5JgourUtMSMyNmID1IwX75wJ
	 wPdVFnb36H79w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] dmaengine: ti: omap-dma: fix interrupt handling in
 remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260531020535.594460-5-rosenp@gmail.com>
References: <20260531020535.594460-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 02:43:52 +0000
Message-Id: <20260531024352.E51461F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11071-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 6608D6143F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Data race when modifying IRQ enable mask leaves interrupts vulnera=
ble to storms.

Pre-existing issues:
- [Critical] Use-after-free of DMA channels during forced unbind.
- [High] Missing IO flush before freeing the shared IRQ handler allows unha=
ndled interrupts.
--

commit cf02a74f5cf0d9275769507da876fed12689ebdf
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: fix interrupt handling in remove

This commit aims to fix three interrupt handling bugs in the remove path.
It changes the interrupt disable logic to write to IRQENABLE_L1 instead
of IRQENABLE_L0, disables hardware interrupts before freeing the shared
IRQ handler, and adds a return value check for platform_get_irq().

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index fd1ad3b4268c9..ad90ca226db35 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1859,16 +1859,17 @@ static void omap_dma_remove(struct platform_devic=
e *pdev)
>  	if (pdev->dev.of_node)
>  		of_dma_controller_free(pdev->dev.of_node);
> =20
> -	irq =3D platform_get_irq(pdev, 1);
> -	devm_free_irq(&pdev->dev, irq, od);
> -
>  	dma_async_device_unregister(&od->ddev);
> =20
>  	if (!omap_dma_legacy(od)) {
> -		/* Disable all interrupts */
> -		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
> +		od->irq_enable_mask =3D 0;
> +		omap_dma_glbl_write(od, IRQENABLE_L1, 0);

[Severity: High]
Does clearing od->irq_enable_mask and writing to IRQENABLE_L1 without
holding spin_lock_irq(&od->irq_lock) introduce a data race?

If an interrupt fires concurrently, the IRQ handler (omap_dma_irq) might
read the cleared mask, evaluate status &=3D 0, and return IRQ_NONE without
acknowledging the pending hardware interrupt.

Furthermore, if a client releases a channel concurrently:

omap_dma_free_chan_resources() {
    spin_lock_irqsave(&od->irq_lock, flags);
    ...
    omap_dma_glbl_write(od, IRQENABLE_L1, od->irq_enable_mask);
    spin_unlock_irqrestore(&od->irq_lock, flags);
}

This could write a non-zero mask to IRQENABLE_L1 immediately after this
remove path disabled it, leaving hardware interrupts active right before
devm_free_irq() removes the handler.

[Severity: High]
This isn't a bug introduced by this patch, but does the posted write to
IRQENABLE_L1 require a dummy read to flush the interconnect's write
buffers before freeing the IRQ?

Because there is no subsequent flush before devm_free_irq() is called,
the hardware disable command may not reach the DMA controller in time.

If the controller asserts an interrupt during this window, the CPU will
see an unhandled interrupt on a shared line, which can prompt the
generic IRQ subsystem to permanently disable the shared IRQ line.

>  	}
> =20
> +	irq =3D platform_get_irq(pdev, 1);
> +	if (irq > 0)
> +		devm_free_irq(&pdev->dev, irq, od);
> +
>  	omap_dma_free(od);

[Severity: Critical]
This is a pre-existing issue, but can the call to omap_dma_free() result
in a use-after-free if a manual sysfs unbind occurs?

omap_dma_free() unconditionally frees all channel structures:

omap_dma_free() {
    while (!list_empty(&od->ddev.channels)) {
        ...
        kfree(c);
    }
}

Since the DMA subsystem does not automatically create strict device links
for consumers, a sysfs unbind of the DMA controller will not synchronously
unbind its consumers.

Active clients will thus continue to access their held channels and
eventually call dma_release_channel() on the freed memory.

> =20
>  	if (od->ll123_supported)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531020535.5944=
60-1-rosenp@gmail.com?part=3D4

