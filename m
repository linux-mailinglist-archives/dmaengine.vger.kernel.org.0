Return-Path: <dmaengine+bounces-12302-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bwReEimtUGol3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12302-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:28:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5B738747
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:28:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cDWBD+TC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12302-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12302-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7F673058511
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEA13EF642;
	Fri, 10 Jul 2026 08:24:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0053EFFC8
	for <dmaengine@vger.kernel.org>; Fri, 10 Jul 2026 08:24:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671877; cv=none; b=O8sXLKroJSooMRNR77MTMwbSSs+mykrVFuV3fN7vGYah9b1ZLHPt+4GGJEfClJbfN+PbxpDO4L7hFI6AuF6W6RlQLcgVjlpE0ANJE96lT2LENQDsI7DWDBVjHjAxEGxmNDaD/gjeHV7BCAtpIv+fc5i14dk9VL4SqMRcvUBgh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671877; c=relaxed/simple;
	bh=6rJMblQ7XBJgBSsPRzq3f7XRy+deovC0WOnE+ceZaK4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NASeoljdD4h7DZqJKQ7rvyx9SyM9Kvq/f17X8HFv5RG2S6cZGIZUTlw1Acm4K4Cx2gL1WJJDpsirAiLlztD8Bw8MfcS5BbiPTBynvAJ4WBvG5492UXcu1nl3ceQ4Ycl4bB2CIyZFmytSgPMB8Zda+hSCrIrHHdU0cvgN+1ShdVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDWBD+TC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCAE1F000E9;
	Fri, 10 Jul 2026 08:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783671875;
	bh=Gk4OKRymeNqXv7nN7QmZIsOXzelO1HgfI5A1hrLLb6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cDWBD+TC9alG3uMxMRU89lyNZsDQyNNynQyzM4QPBfhJovG6qUu8pSgHkHsW6Vs+U
	 NhbuL18UYjnp7XVWKL5vPdB9CyRtVgWMYAoXH9twUopeSj9qfr3mCXTfqzzCrr8Clp
	 2e4oRT3r1NHhl2U6alETLm4B1tU3eUcBit39tHtyoJVlF2wBnQiZxO9aC4RWFGvnXg
	 3rt9y2lz8DSy+VSXfadIGHxLw2ygtV+XkzG5f69E9L/jTSVfl7ew1mWISF1ullb3rU
	 jSFaNcb7POYUgduKCPh0pe7pb9LrFuvQqhq4op9f0sX0v05WXhDvKekxHUpaLEda1Y
	 /IFFqtmvYLAJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] dmaengine: dw-edma: Defer channel IRQ handling to
 workqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260710080903.2392888-8-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 08:24:34 +0000
Message-Id: <20260710082435.1FCAE1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12302-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,valinux.co.jp:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AE5B738747

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] chan->irq_pending is not cleared when deferred IRQ work is cancell=
ed, leaving stale events that corrupt subsequent transfers.

Pre-existing issues:
- [High] The driver requests shared interrupts before initializing the per-=
channel structures, causing a guaranteed NULL pointer dereference if an int=
errupt fires early.
- [High] The `dma_device` and `dw_edma_chan` structures are freed by devres=
 while DMA clients may still hold references to them.
--

--- Patch [7]: [PATCH 7/7] dmaengine: dw-edma: Defer channel IRQ handling t=
o workqueue ---
commit 47745d1148d964a79c090cf3e2315c193e04da4d
Author: Koichiro Den <den@valinux.co.jp>
Subject: dmaengine: dw-edma: Defer channel IRQ handling to workqueue

This commit defers channel IRQ handling to a workqueue to reduce
contention on the hard IRQ handler. It introduces work items to process
per-channel completion and abort events asynchronously.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 5664421c6f15b..704d8f9746e8b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> @@ -930,6 +973,7 @@ static void dw_edma_device_synchronize(struct dma_cha=
n *dchan)
>  	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> =20
>  	dw_edma_wait_termination(dchan);
> +	cancel_work_sync(&chan->irq_work);

[Severity: High]
Does this code leave stale events in chan->irq_pending?

When the work is cancelled here, the work item won't execute, but it looks
like chan->irq_pending is never cleared.

If a hardware interrupt had set DW_EDMA_IRQ_ABORT in irq_pending just before
the channel was stopped, won't that stale event remain in the atomic
variable?

When the client later configures the channel and starts a new transfer,
wouldn't the next legitimate hardware interrupt cause dw_edma_irq_work() to
see both events and erroneously abort the new active transfer?

>  	vchan_synchronize(&chan->vc);
>  }

[ ... ]

> @@ -1185,10 +1231,21 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	/* Disable eDMA, only to establish the ideal initial conditions */
>  	dw_edma_core_off(dw);
> =20
> +	/*
> +	 * Deferred IRQ works are queued from the hard IRQ handlers, so the
> +	 * workqueue must exist before any IRQ is requested.
> +	 */
> +	dw->wq =3D alloc_workqueue("dw-edma:%s", WQ_UNBOUND | WQ_HIGHPRI, 0,
> +				 dev_name(chip->dev));
> +	if (!dw->wq)
> +		return -ENOMEM;
> +
>  	/* Request IRQs */
>  	err =3D dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);

[Severity: High]
This is a pre-existing issue, but could this sequence cause a NULL pointer
dereference if the shared interrupt fires early?

During probe, dw_edma_irq_request() requests the shared interrupt before
dw_edma_channel_setup() completes:

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_irq_request() {
    ...
    err =3D request_irq(irq, dw_edma_interrupt_common,
                      IRQF_SHARED, dw->name, &dw->irq[0]);
    ...
}

At this point, dw->irq[i].dw is still NULL because it's only initialized
later in dw_edma_channel_setup():

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_channel_setup() {
    ...
    irq->dw =3D dw;
    ...
}

If the interrupt fires immediately after request_irq(), wouldn't the handler
crash here when dereferencing dw_irq->dw?

drivers/dma/dw-edma/dw-edma-core.h:dw_edma_core_handle_int() {
    return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
}

> -	if (err)
> +	if (err) {
> +		destroy_workqueue(dw->wq);
>  		return err;
> +	}
> =20
>  	/* Allocate a dedicated virtual IRQ for interrupt-emulation doorbells */
>  	err =3D dw_edma_emul_irq_alloc(dw);

[ ... ]

> @@ -1235,6 +1293,11 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
>  	dw_edma_emul_irq_free(dw);
> =20
> +	for (i =3D 0; i < dw->wr_ch_cnt + dw->rd_ch_cnt; i++)
> +		cancel_work_sync(&dw->chan[i].irq_work);
> +
> +	destroy_workqueue(dw->wq);
> +
>  	/* Deregister eDMA device */
>  	dma_async_device_unregister(&dw->dma);

[Severity: High]
This is a pre-existing issue, but is there a risk of a Use-After-Free here
during driver unbind?

The dw->chan array and dw context are allocated using devres (devm_kcalloc
and devm_kzalloc).

When dma_async_device_unregister() is called, it removes the device from the
DMA engine subsystem but doesn't block waiting for active clients to drop
their channel references.

Once remove() returns, the devres mechanism will automatically free the
memory. If a client still holds a reference to a channel, won't subsequent
use or a later call to dma_release_channel() dereference freed memory?

>  	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
>  				 vc.chan.device_node) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710080903.2392=
888-1-den@valinux.co.jp?part=3D7

