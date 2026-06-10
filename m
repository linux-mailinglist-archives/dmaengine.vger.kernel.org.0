Return-Path: <dmaengine+bounces-11393-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gn+DEOkOKWo+PgMAu9opvQ
	(envelope-from <dmaengine+bounces-11393-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 09:14:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C559166686D
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 09:14:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iZk6AJ3g;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11393-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11393-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0FE9303EA7A
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 07:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08A2383334;
	Wed, 10 Jun 2026 07:12:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B2382368
	for <dmaengine@vger.kernel.org>; Wed, 10 Jun 2026 07:12:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075574; cv=none; b=Udj5BHeGpFyNQ0HeZYuyYV0dvmvHj3VzQb/idWt3w4vXtAygHQmBs9AfuFKcVVFeYhIvLHDVHVKNRaczv1NtPVGlvib1egcjc3Qej9LDBgEENM6wovfaZiqf/nFt+DyJ3lYoOTjMV1mHz3StN62reNQbe2Ik/PHl/L8BvByxyfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075574; c=relaxed/simple;
	bh=XcUR4TipeKSJlpL/FwBbC0b7DSS0B/OP+SRcQFP6l08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n1iSoA0ekKKxhLKyl5amQEy2nEZm5DnXtIk3hLztPvXKJkivv8Z9QmC7VvbVR/bAou7QDEGiue8Jwvs7A9E+unkZU5HBr7mYjpV8iuhJpE9eXkdFT9yS9h/t6w6ziQXzrHS8bK0HsO2Leii89Bj7EmZcVcKNgjGnYo4G9RVcYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZk6AJ3g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA771F00893;
	Wed, 10 Jun 2026 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781075573;
	bh=ULpFM0AIuOHLSjCazzfIHEcDLoHuhH2Nb5IPAJq+UrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iZk6AJ3ghGv0eJObFr/cYHjbmCQLrEm/EOnoUW4M5IZemf//FOOwJaOi5/iPOBWB9
	 +J4vjztcfrl4hm2QrSeyxmzhWoTq0jhrIJCV8/U3FNOrWX0UU/q6zsTxOt2vqpwl80
	 oGGt8hlNJgm0EsvzfSbvoi74gztfQlMg5eVpmZQ5yffND7qxYD3mNYel9L8NFd2V5j
	 fAfFt5ltyWB9Y17pnsK3kZNQ+4dfAvHMrFpUlfOsp0IDO0heN3Zr6RGAa9UCeK4vI0
	 xOZHj/TQsLzQqU1VYe+VSyqNIOyKq5h2bkRrTQNfh5A6RZBBXllVhLnYoajNIkCh4j
	 0Y/M2J3BtvRbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] dma: mv_xor: use devm for dma pool and irq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260610065737.118211-4-rosenp@gmail.com>
References: <20260610065737.118211-4-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 07:12:52 +0000
Message-Id: <20260610071252.CFA771F00893@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11393-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C559166686D

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Calling `irq_dispose_mapping()` before `devm_request_irq()` teardo=
wn leaks the `irqaction` and causes a potential use-after-free.

Pre-existing issues:
- [High] Missing `tasklet_kill()` during channel teardown leads to a potent=
ial Use-After-Free.
- [High] The self-test functions fail to stop the DMA engine on timeout, le=
ading to memory corruption.
- [High] The interrupt handler is registered and unmasked before the channe=
l's spinlock and lists are initialized.
--

commit 37fd86f976ff0d9115db485708892518119901a0
Author: Rosen Penev <rosenp@gmail.com>

dma: mv_xor: use devm for dma pool and irq
   =20
Replace dma_alloc_wc with dmam_alloc_attrs and request_irq
with devm_request_irq. This eliminates the need for
manual cleanup of the dma pool and irq in both the channel
remove function and the channel add error labels, removing
the err_free_irq and err_free_dma labels entirely.

> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 3fc39cca7cbd3..2ac7f01155fe8 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1013,8 +1013,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan=
 *mv_chan)
> =20
>  	dma_async_device_unregister(&mv_chan->dmadev);
> =20
> -	dma_free_wc(dev, MV_XOR_POOL_SIZE,
> -			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
>  	dma_unmap_single(dev, mv_chan->dummy_src_addr,
>  			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
>  	dma_unmap_single(dev, mv_chan->dummy_dst_addr,
> @@ -1025,8 +1023,6 @@ static int mv_xor_channel_remove(struct mv_xor_chan=
 *mv_chan)
>  		list_del(&chan->device_node);
>  	}
> =20
> -	free_irq(mv_chan->irq, mv_chan);
> -

[Severity: High]
This is a pre-existing issue, but does this function also need a call to
tasklet_kill(&mv_chan->irq_tasklet) before returning?

The mv_chan structure is allocated via devm_kzalloc() and will be freed by
devres upon device removal or probe failure. If the tasklet is scheduled by=
 an
interrupt just before removal, it might execute asynchronously after the
mv_chan memory has been freed, causing a use-after-free panic.

>  	return 0;
>  }
> =20

[ ... ]

> @@ -1112,10 +1108,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
>  	/* clear errors before enabling interrupts */
>  	mv_chan_clear_err_status(mv_chan);
> =20
> -	ret =3D request_irq(mv_chan->irq, mv_xor_interrupt_handler,
> +	ret =3D devm_request_irq(&pdev->dev, mv_chan->irq, mv_xor_interrupt_han=
dler,
>  			  0, dev_name(&pdev->dev), mv_chan);

[Severity: High]
By switching to devm_request_irq() here, could we cause an irqaction leak a=
nd
potential use-after-free during device unbind or probe error?

There are manual irq_dispose_mapping() calls in the error paths of
mv_xor_probe() and inside mv_xor_remove() which were not converted:

drivers/dma/mv_xor.c:mv_xor_remove() {
    ...
    for (i =3D 0; i < MV_XOR_MAX_CHANNELS; i++)
        if (xordev->channels[i]) {
            mv_xor_channel_remove(xordev->channels[i]);
            if (pdev->dev.of_node)
                irq_dispose_mapping(xordev->channels[i]->irq);
        }
}

Calling irq_dispose_mapping() will unmap and delete the IRQ descriptor from
the sparse IRQ tree. When the devres cleanup later attempts to free the
devm-managed IRQ, irq_to_desc() will return NULL, and free_irq() will
return without actually freeing the struct irqaction memory.

[Severity: High]
This is a pre-existing issue, but is it safe to request and unmask
the interrupt before the channel's lock and lists are initialized?

The interrupt is requested here, and unmasked shortly after:

	mv_chan_unmask_interrupts(mv_chan);

However, the spinlock and lists are initialized further down:

	spin_lock_init(&mv_chan->lock);
	INIT_LIST_HEAD(&mv_chan->chain);

If an interrupt fires immediately (e.g. from a previous bind/unbind or a sh=
ared
IRQ), the handler will schedule the tasklet, which then attempts to acquire=
 the
uninitialized spinlock and access the uninitialized lists in
mv_chan_slot_cleanup(), potentially causing a crash.

>  	if (ret)
> -		goto err_free_dma;
> +		goto err_unmap_dst;
> =20
>  	mv_chan_unmask_interrupts(mv_chan);
> =20
> @@ -1138,14 +1134,14 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
>  		ret =3D mv_chan_memcpy_self_test(mv_chan);
>  		dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
>  		if (ret)
> -			goto err_free_irq;
> +			goto err_unmap_dst;

[Severity: High]
This is a pre-existing issue, but if the DMA self-test times out, are we mi=
ssing
a hardware abort before freeing the destination buffer?

In mv_chan_memcpy_self_test() and mv_chan_xor_self_test(), if the DMA hardw=
are
times out, the function jumps to the free_resources label:

drivers/dma/mv_xor.c:mv_chan_memcpy_self_test() {
    ...
	if (mv_xor_status(dma_chan, cookie, NULL) !=3D DMA_COMPLETE) {
		dev_err(dma_chan->device->dev,
			"Self-test copy timed out, disabling\n");
		err =3D -ENODEV;
		goto free_resources;
	}
    ...
free_resources:
	dmaengine_unmap_put(unmap);
	mv_xor_free_chan_resources(dma_chan);
out:
	kfree(src);
	kfree(dest);
	return err;
}

The code unmaps the DMA buffers and frees the destination memory via kfree(=
),
but never attempts to halt or reset the underlying hardware channel. If the
delayed hardware completes the transfer later, will it write the DMA results
directly into the freed kernel memory pages?

>  	}
> =20
>  	if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
>  		ret =3D mv_chan_xor_self_test(mv_chan);
>  		dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
>  		if (ret)
> -			goto err_free_irq;
> +			goto err_unmap_dst;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610065737.1182=
11-1-rosenp@gmail.com?part=3D3

