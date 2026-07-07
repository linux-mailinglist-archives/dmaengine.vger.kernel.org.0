Return-Path: <dmaengine+bounces-12069-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pZv5K9QaTWqwvAEAu9opvQ
	(envelope-from <dmaengine+bounces-12069-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 17:27:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E3471D41B
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 17:27:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TivktELq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12069-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12069-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3922930230F3
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 15:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3497542CAED;
	Tue,  7 Jul 2026 15:26:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740341226E
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 15:26:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437966; cv=none; b=tixwQZTua8rFUMYp4yyi154C5erNU1JfJsKQt4q7zpzXsVY8lQ4wwqAuWzPSSkQfHtUJ2B/Gi3/x37LuTd2nvToJaihpY01vbn0Aq4+7zbtS+k2KZW8fLiUy4B97lbYZqAiTeVc5FG1GXm4ad8Lk8FRvjg+UJGvMi/5HjJObCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437966; c=relaxed/simple;
	bh=gWxwECSKxRACvJWLbl2tihLuDZSrRcobaw55YZicHEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQAsH7i6agDo6/T5X6Xx+Poe7fteq6bXd+bkU3vpR1a8yjcBsfffiKh7YWSPFZ8QKo/iS8ZlUCZQTeM5dP6r1F1/l4hFGT30Y3U/tPoBaGfeYG+Qc1d9xGRuzqIoGO7bAwOeG0Cbhehhi/IOACSIimo+p49Y1kw+qVu+r+bVEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TivktELq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C7D1F000E9;
	Tue,  7 Jul 2026 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783437964;
	bh=Hjoobx63WWPVBLIWgEjcP36K3dN0hQ3n94fxJEsqRFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TivktELq4gx1/m8FHXgYxsSud10uVow0pYf4K3uN4bgkAOMdw735hZmJZq00ubH46
	 t+KdOmnE6VoWvR69hZOm6XtQDEZEOl3RTxM6opjOGJvfOf0QOHjZQW92AVn2rzJn0J
	 WQbM6e8hoeCQZXmA6cHUEhdt9hePGyySFhe6kLR1pktsBT7SGcRWqCOpT9Sa0gLRrZ
	 XqX4UhGQ4UjWN4KXx1DP9jYaiYm0IbYRT4zXJDhpZxxDJ5l/NzQXlcoOmX5b5phfkh
	 bKjKlvMu1LtZyKbEnj1NivTPiq3hDSM5BQyGcxzyJHXyY35AKOtTsbVlIDgIHZa1Xp
	 FAZ1+2VTSMhvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: mmp_pdma: Check virtual channel before
 scheduling tasklet
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260707150356.2257833-1-ruoyuw560@gmail.com>
References: <20260707150356.2257833-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:26:03 +0000
Message-Id: <20260707152604.37C7D1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12069-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46E3471D41B

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch leaves a Time-Of-Check to Time-Of-Use (TOCTOU) race open=
 by taking two separate snapshots of `phy->vchan`.
- [High] Time-of-check to time-of-use (TOCTOU) races on `chan->phy` can lea=
d to NULL pointer dereferences when racing with channel termination.
- [High] Missing `tasklet_kill()` during channel teardown and driver remova=
l leads to use-after-free vulnerabilities.
- [High] A use-after-free write occurs on the error paths of the `prep_*` f=
unctions when freeing the descriptor list.
- [High] The DMA channel hangs indefinitely if multiple transactions are su=
bmitted before `issue_pending` is called.
- [Medium] Stale hardware interrupts are not reliably cleared when a physic=
al channel is disabled, risking state corruption upon reallocation.
--

--- Patch [1]: [PATCH] dmaengine: mmp_pdma: Check virtual channel before sc=
heduling tasklet ---
commit 4969ecc3a7a7a671c042835c34adbdf0229a2d70
Author: Ruoyu Wang <ruoyuw560@gmail.com>

dmaengine: mmp_pdma: Check virtual channel before scheduling tasklet

mmp_pdma_chan_handler() clears a physical-channel interrupt and then
unconditionally schedules phy->vchan->tasklet. The physical channel can
be detached from its virtual channel when the channel is terminated or
when no pending work remains, so a late or shared interrupt can reach the
handler with phy->vchan already NULL.

Snapshot phy->vchan in the interrupt path, skip tasklet scheduling when
there is no virtual channel, and use the same snapshot for the BUSERR
warning. Use WRITE_ONCE() for the matching attach/detach stores because
the IRQ path reads this pointer without taking phy_lock.

Fixes: c8acd6aa6bed ("dmaengine: mmp-pdma support")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index 386e85cd4882a..6f379e9f10017 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c

[ ... ]

> @@ -370,11 +372,16 @@ static int clear_chan_irq(struct mmp_pdma_phy *phy)
>  static irqreturn_t mmp_pdma_chan_handler(int irq, void *dev_id)
>  {
>  	struct mmp_pdma_phy *phy =3D dev_id;
> +	struct mmp_pdma_chan *vchan;
> =20
>  	if (clear_chan_irq(phy) !=3D 0)
>  		return IRQ_NONE;
> =20
> -	tasklet_schedule(&phy->vchan->tasklet);
> +	vchan =3D READ_ONCE(phy->vchan);

[Severity: High]
This isn't a bug introduced by this patch, but does taking two separate
snapshots of phy->vchan leave a time-of-check to time-of-use race open?

The commit message mentions using the same snapshot, but the implementation
takes one snapshot in clear_chan_irq() and a second one here in
mmp_pdma_chan_handler(). If an interrupt fires for an old virtual channel
exactly as the physical channel is reassigned to a new one, the two
READ_ONCE(phy->vchan) calls could fetch different virtual channels.

The interrupt would be cleared for the old channel, but the tasklet would be
scheduled for the new channel, prematurely completing its pending descripto=
rs.

Could this be fixed by returning the vchan pointer from clear_chan_irq()
instead of reading it twice?

> +	if (!vchan)
> +		return IRQ_HANDLED;
> +
> +	tasklet_schedule(&vchan->tasklet);
>  	return IRQ_HANDLED;
>  }

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer dereferen=
ce
due to a time-of-check to time-of-use race in mmp_pdma_residue()?

In mmp_pdma_residue(), chan->phy is checked and used locklessly:

drivers/dma/mmp_pdma.c:mmp_pdma_residue() {
    ...
    if (!chan->phy)
        return 0;

    if (chan->dir =3D=3D DMA_DEV_TO_MEM)
        curr =3D pdev->ops->read_dst_addr(chan->phy);
    ...
}

Concurrently, mmp_pdma_terminate_all() can call mmp_pdma_free_phy(), which
sets chan->phy =3D NULL. Because chan->phy is accessed without READ_ONCE() =
or
locks, the compiler might reload the variable from memory between the check
and its use, resulting in a NULL dereference.

[Severity: High]
This is a pre-existing issue, but does the channel teardown path miss a
tasklet_kill() call, potentially leading to a use-after-free?

In mmp_pdma_free_chan_resources(), the descriptor pool is destroyed without
synchronizing or killing active tasklets:

drivers/dma/mmp_pdma.c:mmp_pdma_free_chan_resources() {
    ...
    dma_pool_destroy(chan->desc_pool);
    chan->desc_pool =3D NULL;
    ...
}

Similarly, in mmp_pdma_remove(), the driver unregisters the device and allo=
ws
devres to free chan memory without first killing the tasklet. If a tasklet =
is
scheduled just before the DMA channel is freed, dma_do_tasklet() could run
concurrently with or after teardown, causing it to dereference chan after it
is freed or operate on chan->desc_pool after it is destroyed.

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in the
prep_* functions cause a use-after-free write when freeing the descriptor l=
ist?

In mmp_pdma_prep_memcpy(), newly allocated descriptors are appended using
list_add_tail(&new->node, &first->tx_list). If an allocation fails, the err=
or
path passes the dynamically embedded list head to the cleanup function:

drivers/dma/mmp_pdma.c:mmp_pdma_prep_memcpy() {
    ...
fail:
    if (first)
        mmp_pdma_free_desc_list(chan, &first->tx_list);
    ...
}

During cleanup in mmp_pdma_free_desc_list():

drivers/dma/mmp_pdma.c:mmp_pdma_free_desc_list() {
    ...
    list_for_each_entry_safe(desc, _desc, list, node) {
        list_del(&desc->node);
        dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
    }
    ...
}

Since first->tx_list is embedded in first, and first is freed during the
first iteration, subsequent iterations perform list_del(&desc->node). This
modifies the list head inside the already freed first descriptor, corrupting
the memory of the DMA descriptor pool.

[Severity: High]
This is a pre-existing issue, but does the DMA channel hang indefinitely if
multiple transactions are submitted before issue_pending() is called?

In start_pending_queue(), all pending transactions are moved to chain_runni=
ng,
but only the physical address of the first descriptor is programmed to the
hardware:

drivers/dma/mmp_pdma.c:start_pending_queue() {
    ...
    list_splice_tail_init(&chan->chain_pending, &chan->chain_running);

    /*
     * Program the descriptor's address into the DMA controller,
     * then start the DMA transaction
     */
    pdev->ops->write_next_addr(chan->phy, desc->async_tx.phys);
    ...
}

Since descriptors from different transactions are not linked, the controller
will stop after the first transaction. The tasklet in dma_do_tasklet() sees
that chain_running is not empty and leaves chan->idle =3D false:

drivers/dma/mmp_pdma.c:dma_do_tasklet() {
    ...
    chan->idle =3D list_empty(&chan->chain_running);

    /* Start any pending transactions automatically */
    start_pending_queue(chan);
    ...
}

However, start_pending_queue() returns immediately if chan->idle is false,
meaning the remaining transactions in chain_running are never started.

[Severity: Medium]
This isn't a bug introduced by this patch, but can stale hardware interrupt=
s be
incompletely cleared when a physical channel is disabled or enabled?

In disable_chan(), the read-modify-write sequence might miss W1C
(write-1-to-clear) interrupt bits that become asserted during the window:

drivers/dma/mmp_pdma.c:disable_chan() {
    ...
    dcsr =3D readl(phy->base + reg);

    if (phy->vchan) {
        struct mmp_pdma_device *pdev;

        pdev =3D to_mmp_pdma_dev(phy->vchan->chan.device);
        writel(dcsr & ~pdev->ops->run_bits, phy->base + reg);
    ...
}

If a hardware interrupt fires between readl() and writel(), the snapshot's
W1C interrupt bit is 0, so writel() writes 0, failing to clear the pending
interrupt.=20

Similarly, enable_chan() performs an unlocked read-modify-write on a W1C
register, blindly clearing any pending W1C bits without processing them. Wh=
en
the physical channel is later reassigned, this stale interrupt can trigger
the IRQ handler for the new channel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707150356.2257=
833-1-ruoyuw560@gmail.com?part=3D1

