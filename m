Return-Path: <dmaengine+bounces-11085-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICIXLvjfHGrTTgkAu9opvQ
	(envelope-from <dmaengine+bounces-11085-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 03:27:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75F618A05
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 03:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73ED630082A4
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C421A6815;
	Mon,  1 Jun 2026 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiItwIgP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E75B1EB
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780277237; cv=none; b=D45LiVvD2xJaZUhAZP9/XpaYAStJY9i5JvqLrACL3F0QdD0zEyKv8Ce2gY6Lm0d0qw6pyrsm3EPvlyANj+yc/oQ0AQx3XVRSoDKgS/GeZ8tuSK9MgTqnx7TQlmc3VHdVmA9/s+npiCb3ILye+RWe9pUpO5waK1yrju2ksFTz9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780277237; c=relaxed/simple;
	bh=InKjPL+YVFg6A2JrUzmJ3i1VaKLyVkUqwPVaRTQcEsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ibt4IFFvwh0XNf5EC10qxGrqYzU0ArfY3MGG/nu7HvbvSiZdJ7Xobp2bTqM2K672+SeeUGfyP5yoXYsYXxbkzUaOfZWmJgh4UdSVHlFjhqlVMnPCTDO67YLACuiZE7OuJKHw0otCMqYmmCzeSSKz+mIm38ndcZ09rHUAUxErTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiItwIgP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB0D1F00893;
	Mon,  1 Jun 2026 01:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780277236;
	bh=r/+gKU42Vg8yund8e/N8dtx7YwE53w6YBWAD06gyzEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jiItwIgPsoH6QKWQ8wuFBGYORJZT8ZLS4ctJMz4g/R4TOzvRgIQirn1WENGoKLwwe
	 qd18lEim8l9yxlIrIdfOThG6CIR/kZ8SPYN7uhUk+J2kZHPMQ+c65rb62q48eODleG
	 SYKg9QDAD8eOHdmhEGkRU4tbN/ZBuZMUZwVFjt4Ylsuoz4tE/BBpDRomtt3UYg0NlR
	 uFc5fKHyD/x4zKdRaOS6638fF+29ci6XC6mQHGjqvrSfwcgCf97ttTJfi1xtTT1jRW
	 wrOc7KER0cywoK9lyfR+uzwl6786vvATuqgG94ZIC6Cj/ufePV87l7D2QZPA0yFHYT
	 p5Aj3JDZIg0sQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] dmaengine: ti: omap-dma: fix interrupt handling
 in remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260601003553.72573-5-rosenp@gmail.com>
References: <20260601003553.72573-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 01:27:15 +0000
Message-Id: <20260601012716.2AB0D1F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11085-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1F75F618A05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Skipping the deallocation of active DMA channels introduces a memo=
ry leak and causes a Use-After-Free of the devres-managed parent controller.
- [Medium] Missing `!omap_dma_legacy(od)` guard in probe error paths trigge=
rs WARN_ON(1) on OMAP1 platforms.

Pre-existing issues:
- [High] Virtual channel resources and descriptor pools are unconditionally=
 freed before halting active hardware DMA channels, leading to memory corru=
ption.
--

commit bcbc46550255e29e4367dd3de0a5461fd2b35a92
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: fix interrupt handling in remove

This commit addresses several bugs in the driver's remove path, including
incorrect IRQ disabling and missing locks. It also changes omap_dma_free()
to avoid freeing channel memory if clients still hold references. The goal
is to ensure safe driver removal and prevent resource leaks.

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index dde270646bb94..8c32b7ab50f63 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1516,13 +1516,21 @@ static int omap_dma_chan_init(struct omap_dmadev =
*od)
> =20
>  static void omap_dma_free(struct omap_dmadev *od)
>  {
> +	struct omap_chan *c;
> +
>  	while (!list_empty(&od->ddev.channels)) {
> -		struct omap_chan *c =3D list_first_entry(&od->ddev.channels,
> -			struct omap_chan, vc.chan.device_node);
> +		c =3D list_first_entry(&od->ddev.channels,
> +				     struct omap_chan, vc.chan.device_node);
> =20
>  		list_del(&c->vc.chan.device_node);
>  		tasklet_kill(&c->vc.task);
>  		vchan_free_chan_resources(&c->vc);

[Severity: High]
This is a pre-existing issue, but does this prematurely free resources while
the hardware is still active?

In omap_dma_free(), virtual channel resources and descriptors are
unconditionally torn down before verifying if the client is still using the
channel and before halting active hardware DMA channels.

If a channel is actively transferring data, its physical descriptors are
returned to the pool before the hardware is stopped. When dma_pool_destroy()
is later called in omap_dma_remove(), won't the still-running DMA hardware
continue accessing the freed descriptor memory, leading to memory corruptio=
n?

> +		if (c->vc.chan.client_count) {
> +			dev_warn(od->ddev.dev,
> +				 "chan%d freed with %u client(s)\n",
> +				 c->dma_ch, c->vc.chan.client_count);
> +			continue;
> +		}

[Severity: High]
Does skipping the channel deallocation here introduce a Use-After-Free for
the parent controller?

By using continue here in omap_dma_free() without freeing the channel, we
leave the channel exposed to the active client. When omap_dma_remove()
finishes, devres will automatically free the parent controller struct
omap_dmadev.

When the client later attempts to release the channel:

drivers/dma/dmaengine.c:dma_release_channel() {
    ...
    if (--chan->device->privatecnt =3D=3D 0)
        dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
    ...
}

Doesn't this inevitably dereference the freed chan->device (which points to
the now-freed omap_dmadev), causing a Use-After-Free?

>  		kfree(c);
>  	}
>  }

[ ... ]

> @@ -1870,16 +1878,20 @@ static void omap_dma_remove(struct platform_devic=
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
> +		spin_lock_irq(&od->irq_lock);
> +		od->irq_enable_mask =3D 0;
> +		omap_dma_glbl_write(od, IRQENABLE_L1, 0);
> +		spin_unlock_irq(&od->irq_lock);
> +		omap_dma_glbl_read(od, IRQENABLE_L1);
>  	}

[Severity: Medium]
While this patch correctly adds the !omap_dma_legacy(od) guard here in
omap_dma_remove(), earlier patches in this series added similar IRQENABLE_L1
writes to the omap_dma_probe() error paths without this guard.

On OMAP1 legacy platforms where IRQENABLE_L1 is not defined in the reg_map
array, passing it to omap_dma_glbl_write() and omap_dma_glbl_read()
unconditionally triggers WARN_ON(1) during probe failure.

Should the probe error paths be updated to include this same
!omap_dma_legacy(od) check?

> =20
> +	irq =3D platform_get_irq(pdev, 1);
> +	if (irq > 0)
> +		devm_free_irq(&pdev->dev, irq, od);
> +
>  	omap_dma_free(od);
> =20
>  	if (od->ll123_supported)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601003553.7257=
3-1-rosenp@gmail.com?part=3D4

