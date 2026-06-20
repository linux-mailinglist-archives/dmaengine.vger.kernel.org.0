Return-Path: <dmaengine+bounces-11677-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XI/KIBzNNmpPFAcAu9opvQ
	(envelope-from <dmaengine+bounces-11677-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:25:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C116A95DE
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:25:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kjQZtOwx;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11677-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11677-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58EC63001F81
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC32E62B7;
	Sat, 20 Jun 2026 17:25:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AFE2EC08C
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 17:25:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976341; cv=none; b=CL7K5xZ2v+jgGCuk0+N3SFtZBGk4A6A8elrm2vs5d5AaPGnC9PkYi0e8IRoLuCsW7tjKG4IMbDF8tgs45v2Lj7jboYgLDfvhsgHt5zZbxQXQafDMEUjHw4r8F/qxtl1qVc3gMnWGUO8An5zdeanE8zPlUgyqWvy+ZVTJ6RVj4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976341; c=relaxed/simple;
	bh=1hpMkfmqk/WpEGfwf6h5Pxgc9nnq5kaZ0y7q7/Wukvg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qGul+3miHFCUh0i+f+jfu8ZzGgL7PhG1nmfEl+0qJRf0QQhqhuOZ8NykcRHp0J3OxbgbHfbgL1Tp2cZKSHjJLc9upPBsdBgxqRV5Y5N97i7z+K3X34Aeena26yjhXx1osQlcsQz6iDdWwyBYX5UOQ5Kh4DhicSz9qwEFWcOfVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjQZtOwx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD20E1F000E9;
	Sat, 20 Jun 2026 17:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976340;
	bh=BJlXFCbMZDOxEyQxINSI6ZPJZ6mbw2VLJhUvPfLzN20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjQZtOwxrBFvpJcl6OFx7HwqnQCijGrlsQEHJjsyDPdPjz864dd78x1uKdvaDIzfr
	 XviUEduP7cprLNDi7HTdxd39r6511/GYfqPXTHWXQM6IB1J/RG569HrvBCl0P1oXcI
	 U5OYU+Z5PBi6PuJl8Gr3TPC9PCzbDguAof7+2rXOokD5Nu+Hf9NRG3ZE9H2xXA/b3X
	 ALxs4zKNuZDppEEk1zHG/mYU98r3F96OdhZamgRGXE3z7Mg1PFVo94s+MVC90Dta/O
	 JFwX6vV2t5fnWbbIS1N0CX3BPqweVxfm3DFbU/sulxMBB0xXxTgxKGjQRq32QCsogn
	 tmkDRIghXoYYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/13] dmaengine: dw-edma: Add delegated channel
 request helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260620170040.3756043-4-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:25:39 +0000
Message-Id: <20260620172539.DD20E1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11677-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70C116A95DE

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Delegating a channel to a remote host fails to mask its hardwa=
re interrupts locally, resulting in an unrecoverable infinite IRQ storm and=
 permanent IRQ disablement.
- [High] Calling `dw_edma_release_delegated_chan` with `quiesce=3Dtrue` for=
cefully disables the entire DMA direction on eDMA v0, disrupting all other =
active channels.
- [Medium] Lockless modification of shared hardware registers `int_mask`, `=
int_clear`, and `engine_en` in `dw_edma_v0_core_dir_off()` races with chann=
el start.

Pre-existing issues:
- [High] `dw_edma_device_terminate_all()` accesses and modifies channel sta=
te locklessly, causing a TOCTOU data race with the interrupt handler.
--

commit e6b7ee23ebe516f403f0d3278b28713356c19ade
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Add delegated channel request helpers

Endpoint functions that expose endpoint-local DesignWare eDMA channels
to a remote host need to reserve exact hardware channels and hand
interrupt ownership to the remote side before publishing the channels.
This commit adds helpers to request hardware channels through DMAengine
and switch the interrupt routing after reservation. It also adds a
matching release helper that can optionally quiesce the channel.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 7a24248b84e94..ca0504eac1fca 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> @@ -1192,6 +1192,87 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> +
> +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		return -EINVAL;
> +	if (chan->configured || chan->status !=3D EDMA_ST_IDLE ||
> +	    chan->request !=3D EDMA_REQ_NONE)
> +		return -EBUSY;
> +
> +	chan->irq_mode =3D DW_EDMA_CH_IRQ_REMOTE;

[Severity: Critical]
Does setting the software irq_mode to DW_EDMA_CH_IRQ_REMOTE without updating
the hardware interrupt mask leave the local hardware interrupts enabled?

If a channel was previously used locally, dw_edma_v0_core_start() clears its
interrupt mask bit in the hardware int_mask register.

When delegated to a remote host, the remote host programs and starts a
transfer, eventually asserting the DONE or ABORT interrupt line.

The local interrupt handler dw_edma_v0_core_handle_int() checks the channel:

dw_edma_v0_core_handle_int() {
        ...
        if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
                continue;
        ...
}

Because dw_edma_core_ch_ignore_irq() returns true for a remote-routed
channel, the handler skips clearing the interrupt and returns IRQ_NONE.

Can this result in an unrecoverable infinite IRQ storm and permanent IRQ
disablement for all active local DMA channels?

> +
> +	return 0;
> +}

[ ... ]

> +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	if (!dchan)
> +		return;
> +
> +	chan =3D dchan2dw_edma_chan(dchan);
> +	if (quiesce)
> +		dw_edma_core_ch_quiesce(chan);

[Severity: High]
Does calling dw_edma_core_ch_quiesce() here destructively abort all other
active channels in the same direction on eDMA v0 hardware?

When dw_edma_core_ch_quiesce() is called on v0 hardware, it maps to
dw_edma_v0_core_dir_off():

dw_edma_v0_core_ch_quiesce() {
        ...
        dw_edma_v0_core_dir_off(chan->dw, chan->dir);
        ...
}

Which then forcefully zeros out the global engine_en register and masks
interrupts for the entire direction:

dw_edma_v0_core_dir_off() {
        ...
        SET_RW_32(dw, dir, engine_en, 0);
        ...
}

If other independent software clients are actively using different channels
in the same direction, will they be disrupted?

[Severity: Medium]
Is it safe to call dw_edma_core_ch_quiesce() without acquiring the dw->lock
spinlock?

dw_edma_v0_core_dir_off() performs lockless writes to shared direction-wide
registers like int_mask and engine_en:

dw_edma_v0_core_dir_off() {
        ...
        SET_RW_32(dw, dir, int_mask,
                  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
        ...
}

Concurrently, another CPU could be running dw_edma_v0_core_start() for a
different channel in the same direction, which performs a read-modify-write
on the exact same int_mask register while holding dw->lock:

dw_edma_v0_core_start() {
        ...
        raw_spin_lock_irqsave(&dw->lock, flags);
        tmp =3D GET_RW_32(dw, chan->dir, int_mask);
        ...
        SET_RW_32(dw, chan->dir, int_mask, tmp);
        ...
}

Could this data race result in lost updates to the interrupt mask?

> +	chan->irq_mode =3D dw_edma_get_irq_mode(chan);
> +	dma_release_channel(dchan);
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);

[ ... ]

[Severity: High]
This is a pre-existing issue, but does dw_edma_device_terminate_all()
evaluate and manipulate channel state locklessly?

dw_edma_device_terminate_all() {
        ...
        if (!chan->configured) {
                /* Do nothing */
        } else if (chan->status =3D=3D EDMA_ST_PAUSE) {
        ...
}

Concurrently, dw_edma_done_interrupt() handles completed transfers and
manipulates the exact same fields while holding the chan->vc.lock:

dw_edma_done_interrupt() {
        ...
        spin_lock_irqsave(&chan->vc.lock, flags);
        vd =3D vchan_next_desc(&chan->vc);
        if (vd) {
                switch (chan->request) {
        ...
}

Can this lack of synchronization corrupt the DMA channel's state machine,
leading to leaked descriptors or failures to properly abort ongoing
transfers if terminate_all races with the interrupt handler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170040.3756=
043-1-den@valinux.co.jp?part=3D3

