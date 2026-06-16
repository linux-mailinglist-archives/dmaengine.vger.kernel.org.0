Return-Path: <dmaengine+bounces-11548-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3rYEGjvGMGoOXQUAu9opvQ
	(envelope-from <dmaengine+bounces-11548-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 05:42:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B813368BBA4
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 05:42:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xk6Hc9cB;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11548-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11548-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83BCD3045DC6
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 03:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06D13C4141;
	Tue, 16 Jun 2026 03:42:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AB258EE9;
	Tue, 16 Jun 2026 03:42:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581368; cv=none; b=Hh0K7Oa+vMgOoUWgrfUlAEA72kQdB+Io61Y8Q6w5IpNOvGFTEwy8QdPNNHMZVY7Vj5kED0B93y/nCFDKPNHSn1DTsEAXQoS3CzFeVLCV9mBYaPbxiN8KCwFsXBGVUDOJxhJcoY+XXH41ZbXxxUXqN4ZlwvzAT7LYbVTzle/yEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581368; c=relaxed/simple;
	bh=5HvhChO84wmlM27wM35DWBfw63ikaa5ga+qPMDYA97w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sVH44u3zZC9X697GRpiGI+hxu1kc6x3/hC44TE5CWXjldBbt25NQQbPDwAUDO2q3bDBuiGDj5v1vpC7Q2vpSr+cOFCHpv2WuZzUIeThWTkS7VXf4ABY96ViTQP/ULLr7IMvbfK6yawWdr0Wo0a9q9SEl/no/kxV4yXeyM3oDg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk6Hc9cB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13F91F000E9;
	Tue, 16 Jun 2026 03:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781581367;
	bh=nJGK8DZ1qGsbwBI82msughNJiJgj6+HL+M1gyGPG6S8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xk6Hc9cBk44xLqbF7PvM3fBE10vvd7DCZlO4fFYKdHyg0xNT50eqCJmRdaqyHODIG
	 rbmF26b44oFfgWm9WxW7naxjr/dPNUgoAjCbs3zD6TdTB6vEDpb8PL/Jogoe05vDwT
	 DUUon7AXAdBNDBchlGcaUW8503wWc/pIPAh2C1zg9gupog7s38rB7JSOfsJWCoR7PK
	 Y92P8z94K6aRopCSyRu+GgSjhOqPls8dIZj6o4699xr++n/XoOB5K3o+1LVmK0c5BB
	 wAkdlKTYoCMzadfPUSTK3Xk4WRuq1LLmCSUFK5wPh2NcEVPJWJ7yJJCCoKbH9N7UG+
	 sj1BqnJI342hQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: sun6i-dma: Fix memory leak in
 sun6i_dma_terminate_all
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260616033116.23490-1-zenghongling@kylinos.cn>
References: <20260616033116.23490-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 03:42:46 +0000
Message-Id: <20260616034246.E13F91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11548-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email,smtp.kernel.org:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:linux-sunxi@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B813368BBA4

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The patch unconditionally adds the active descriptor `pchan->desc`=
 to `vc->desc_completed` in `sun6i_dma_terminate_all()`, causing list corru=
ption and a potential use-after-free for non-cyclic transfers.

Pre-existing issues:
- [High] A TOCTOU race condition between `sun6i_dma_interrupt()` and `sun6i=
_dma_terminate_all()` allows the interrupt handler to dereference a NULL `p=
chan->desc` pointer.
- [High] Use-after-free when calculating residue for a recently completed t=
ransfer in `sun6i_dma_tx_status()`.
- [High] Deadlock risk due to acquiring `sdev->lock` with plain `spin_lock(=
)` in process context, which is vulnerable to softirq preemption.
- [High] The interrupt handler locklessly reads `pchan->vchan`, which races=
 with channel reallocation and can prematurely complete a newly started tra=
nsfer.
--

commit c1c2a26ec23500f38a915dc234fa3b40c6cbad7d
Author: Hongling Zeng <zenghongling@kylinos.cn>

dmaengine: sun6i-dma: Fix memory leak in sun6i_dma_terminate_all

This commit fixes a memory leak in sun6i_dma_terminate_all() for non-cyclic
DMA transfers. It ensures that both cyclic and non-cyclic active descriptors
are added to the desc_completed list before setting pchan->desc to NULL.

> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a9a254dbf8cb9..7f9414e3a3814 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -945,16 +945,14 @@ static int sun6i_dma_terminate_all(struct dma_chan =
*chan)
> =20
>  	spin_lock_irqsave(&vchan->vc.lock, flags);

[Severity: High]
This isn't a bug introduced by this patch, but just above this line in
sun6i_dma_terminate_all(), there is a plain spin_lock() used in process
context:

	spin_lock(&sdev->lock);
	list_del_init(&vchan->node);
	spin_unlock(&sdev->lock);

Does this risk an infinite spinlock deadlock? Since sun6i_dma_terminate_all=
()
is callable from process context, a hardirq can preempt execution while
sdev->lock is held. When the hardirq finishes, the pending softirqs would r=
un
sun6i_dma_tasklet on the same CPU, which attempts to acquire the lock using
spin_lock_irqsave(&sdev->lock, flags), potentially deadlocking.

> -	if (vchan->cyclic) {
> -		vchan->cyclic =3D false;
> -		if (pchan && pchan->desc) {
> -			struct virt_dma_desc *vd =3D &pchan->desc->vd;
> -			struct virt_dma_chan *vc =3D &vchan->vc;
> +	if (pchan && pchan->desc) {
> +		struct virt_dma_desc *vd =3D &pchan->desc->vd;
> +		struct virt_dma_chan *vc =3D &vchan->vc;
> =20
> -			list_add_tail(&vd->node, &vc->desc_completed);
> -		}
> +		list_add_tail(&vd->node, &vc->desc_completed);

[Severity: High]
Does unconditionally adding the descriptor to desc_completed risk list
corruption for non-cyclic transfers?

When a non-cyclic transfer completes, sun6i_dma_interrupt() calls
vchan_cookie_complete(), which places the descriptor on vc->desc_completed,
sets pchan->done =3D pchan->desc, and schedules the vchan_complete tasklet.
However, pchan->desc isn't cleared until sun6i_dma_tasklet runs.

If sun6i_dma_terminate_all() executes during this window, it observes a
non-NULL pchan->desc and executes list_add_tail() again. Since the descript=
or
is already on the list (or has been spliced/freed by the completion tasklet=
),
this double-add could corrupt the linked list pointers. Should this check
if (pchan->desc !=3D pchan->done) first?

[ ... ]

[Severity: High]
This is a pre-existing issue, but is there a TOCTOU race condition between
sun6i_dma_interrupt() and sun6i_dma_terminate_all()?

In sun6i_dma_interrupt(), pchan->vchan is read locklessly. If
sun6i_dma_terminate_all() runs concurrently on another CPU, it can acquire =
the
channel lock, set pchan->desc =3D NULL, and release the lock:

CPU1 (sun6i_dma_terminate_all):
    if (pchan) {
        ...
        pchan->desc =3D NULL;
    }

CPU2 (sun6i_dma_interrupt):
    spin_lock(&vchan->vc.lock);
    vchan_cookie_complete(&pchan->desc->vd);

Could this cause a fatal NULL pointer dereference when &pchan->desc->vd
evaluates to NULL inside vchan_cookie_complete()?


[Severity: High]
This is a pre-existing issue, but does sun6i_dma_tx_status() have a
use-after-free risk when calculating residue?

When a transfer finishes, the vchan_complete tasklet completes the callback
and frees the descriptor memory. However, pchan->desc is not cleared until
the separate sun6i_dma_tasklet runs.

If dmaengine_tx_status() is called in this window, vchan_find_desc() returns
NULL, and the code falls back to checking pchan && pchan->desc. It then cal=
ls
sun6i_get_chan_size(pchan), which accesses the descriptor:

drivers/dma/sun6i-dma.c:sun6i_get_chan_size() {
    ...
    for (lli =3D txd->v_lli; lli; lli =3D lli->v_lli_next) {
    ...
}

Will this dereference the already-freed descriptor memory?


[Severity: High]
This is a pre-existing issue, but does the interrupt handler risk premature=
ly
completing a newly started transfer?

sun6i_dma_terminate_all() stops the physical channel but leaves pending
interrupt bits set in the hardware DMA_IRQ_STAT register. The
sun6i_dma_tasklet can immediately reallocate this physical channel to a
new virtual channel and start it.

If the delayed hardware interrupt from the old transfer fires,
sun6i_dma_interrupt() reads pchan->vchan locklessly:

drivers/dma/sun6i-dma.c:sun6i_dma_interrupt() {
    ...
    vchan =3D pchan->vchan;
    if (vchan && (status & vchan->irq_type)) {
    ...
}

If it evaluates as the newly assigned vchan, and non-cyclic transfers share
the same irq_type bitmask, could the handler incorrectly acquire the new
vchan->vc.lock and prematurely complete the new transfer's descriptor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616033116.2349=
0-1-zenghongling@kylinos.cn?part=3D1

