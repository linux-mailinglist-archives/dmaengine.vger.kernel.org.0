Return-Path: <dmaengine+bounces-11486-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NWINEqwmK2ol3QMAu9opvQ
	(envelope-from <dmaengine+bounces-11486-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:20:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E50675693
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:20:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=a3zsIAw8;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11486-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11486-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D553060302
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4F37E2F2;
	Thu, 11 Jun 2026 21:20:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9888C34EF0F
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:20:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212841; cv=none; b=SqQXL9Acf72AYXyQvSyu7qcqJmPHzM9DDm9FAmMwIqTQJGZwsrMfAITh3BBu5DQilaq9n54FWe5sfkLD3HxPNgMPoGtMg0cx3AImvl3yb5BtUAEKLLG/joY7txGZ1jJzCiUZZKRFb4UwOYPSDDjGrDQe/v2YE8sLx1xVC0XOWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212841; c=relaxed/simple;
	bh=ZxvbyFx7iAc989WGR0KhHA/SjKkw7l8qeUQ69YgQHc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bC3XxTgVPdYMjmscVFex0eh9kLJc7J6akVSThu75Jy0Mw2BM1hpCy++1Uq3WBPHT4ocGd+HFj+uCX9BjvJOEdw8KIgih3I8M6BevCTBHrdoHeseMB4VO0AaPtV0HbeTeAjSF8Bw/Aw77CzLawkVPFHeBzLZzQywpWYlnZ92F+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3zsIAw8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100B51F000E9;
	Thu, 11 Jun 2026 21:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781212840;
	bh=s3cRUFbPNs8m9ou8+k6gybbBN3sJr00Hy+/f1yPnakY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a3zsIAw86UwtVEGsOkHqYmakJjUmUROcn2Q1F2G0ptZ6DlAfSkkPU58GegG0Mtuzu
	 T2fEiUm1m8OYTPXu/S8wmv3BQvLe8Uc4VwingX5jIULkjf9O2a1OA3gHmuD0Cy+4Kj
	 JrBnvpkwKjQVf5Fh+E64l4ZfBYhKiPvPyzIiB8WvYg0S7IDOM593XnKCHPgWwVPNlg
	 B+k2iecMHCV67/NmyhM5Tp8SqdLP2P9zFFJo+NM3vqYGHyAy7KA4e/zmY54fxCtzvL
	 GX7nFFjDnJWxLdsvz7UcgpGzDhIuJryJpD3XIWYO8hV9sHzTFzwPvi8v/MiPJKx4xN
	 Ugp9M1e7Rru6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 1/9] dmaengine: mv_xor: initialize chan state before
 requesting IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260611210721.81979-2-rosenp@gmail.com>
References: <20260611210721.81979-2-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 21:20:39 +0000
Message-Id: <20260611212040.100B51F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11486-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93E50675693

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `tasklet_kill()` on error paths and during channel removal=
 can lead to a use-after-free of the channel structure.
- [High] Unprotected concurrent access to shared MBUS window hardware regis=
ters and `xordev` arrays across multiple DMA channels.
- [High] DMA descriptor slots are permanently leaked if `mv_xor_add_io_win(=
)` fails during DMA prep.
- [High] Missing `dma_wmb()` before updating the hardware chain descriptor.
- [High] Cache-line tearing risk due to unaligned embedded DMA buffers.
--

commit ea8e635be2ff110a83818007cc43ae217683e3c9
Author: Rosen Penev <rosenp@gmail.com>
Subject: dmaengine: mv_xor: initialize chan state before requesting IRQ

This commit fixes a potential race condition in the mv_xor driver by
initializing the channel's spinlock, lists, and tasklet before registering
the IRQ. This prevents a scenario where an immediately firing interrupt
could access uninitialized structures and cause undefined behavior.

> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 25ed61f1b0899..93a8e9f7c529a 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1054,6 +1054,18 @@ mv_xor_channel_add(struct mv_xor_device *xordev,

[ ... ]

> +	spin_lock_init(&mv_chan->lock);
> +	INIT_LIST_HEAD(&mv_chan->chain);
> +	INIT_LIST_HEAD(&mv_chan->completed_slots);
> +	INIT_LIST_HEAD(&mv_chan->free_slots);
> +	INIT_LIST_HEAD(&mv_chan->allocated_slots);
> +	mv_chan->dmachan.device =3D dma_dev;
> +	dma_cookie_init(&mv_chan->dmachan);
> +
> +	mv_chan->mmr_base =3D xordev->xor_base;
> +	mv_chan->mmr_high_base =3D xordev->xor_high_base;
> +	tasklet_setup(&mv_chan->irq_tasklet, mv_xor_tasklet);

[Severity: High]
This isn't a bug introduced by this patch, but since you are moving the
tasklet setup here, could this trigger a cache-line tearing issue?

Looking at struct mv_xor_chan in drivers/dma/mv_xor.h, dummy_src and
dummy_dst are embedded as 128-byte character arrays without cacheline
alignment annotations.

Shortly after this tasklet_setup(), dummy_src is mapped with
DMA_FROM_DEVICE:

mv_chan->dummy_src_addr =3D dma_map_single(dma_dev->dev,
        mv_chan->dummy_src, MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);

Since the array shares a cache line with adjacent struct fields like
irq_tasklet and op_in_desc which are initialized before the mapping, won't
the DMA cache invalidation destroy any recent CPU writes to these fields?

[ ... ]

>  	if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask)) {
>  		ret =3D mv_chan_memcpy_self_test(mv_chan);
>  		dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
>  		if (ret)
>  			goto err_free_irq;
>  	}

[ ... ]

> err_free_irq:
> 	free_irq(mv_chan->irq, mv_chan);
> err_free_dma:

[Severity: High]
This is a pre-existing issue, but does the error path here miss a
tasklet_kill() call?

If the probe fails after tasklet_setup() and request_irq(), the error
path frees the IRQ but leaves a pending tasklet that might execute and use
the soon-to-be freed channel structure. Should tasklet_kill() be called
during channel removal and in this error path?


While reviewing this driver, I also noticed a few other pre-existing issues
in drivers/dma/mv_xor.c that might need attention:

[Severity: High]
This is a pre-existing issue, but is there a missing lock when accessing
the shared MBUS window registers?

In mv_xor_add_io_win(), the function reads WINDOW_BAR_ENABLE(0), searches
for a free window index, and updates both xordev->win_start[i] and the
hardware registers:

drivers/dma/mv_xor.c:mv_xor_add_io_win() {
        ...
        win_enable =3D readl(base + WINDOW_BAR_ENABLE(0));
        i =3D ffs(~win_enable) - 1;
        ...
        xordev->win_start[i] =3D addr;
        xordev->win_end[i] =3D addr + size;
        ...
}

Since xordev is shared across multiple XOR channels and the DMA engine
framework allows concurrent device_prep_dma_* calls, can concurrent
operations pick the same window index and overwrite each other's target
mappings?

[Severity: High]
This is a pre-existing issue, but does mv_xor_prep_dma_xor() leak DMA
descriptor slots if mv_xor_add_io_win() fails?

If mv_xor_add_io_win() fails, the function returns NULL directly:

drivers/dma/mv_xor.c:mv_xor_prep_dma_xor() {
        ...
        ret =3D mv_xor_add_io_win(mv_chan, src[src_cnt]);
        if (ret)
                return NULL;
        ...
}

Since the descriptor slot was previously allocated and moved to
mv_chan->allocated_slots, returning NULL here without returning the
descriptor to mv_chan->free_slots appears to permanently leak the slot.
Could this eventually exhaust the channel's descriptor pool?

[Severity: High]
This isn't a bug introduced by this patch, but is a memory barrier required
before updating the hardware chain descriptor?

In mv_xor_tx_submit(), when appending a new descriptor to an active chain,
the code modifies the previous descriptor in write-combined memory:

drivers/dma/mv_xor.c:mv_xor_tx_submit() {
        ...
        /* fix up the hardware chain */
        mv_desc_set_next_desc(old_chain_tail, sw_desc->async_tx.phys);
        ...
}

Without a dma_wmb() before this assignment, could the hardware read the
updated phy_next_desc before the new descriptor's contents are flushed
from the CPU write-combine buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611210721.8197=
9-2-rosenp@gmail.com?part=3D1

