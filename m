Return-Path: <dmaengine+bounces-11261-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cXRNJepqI2pGtgEAu9opvQ
	(envelope-from <dmaengine+bounces-11261-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:33:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3362864C05E
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:33:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="XOtQ/BZb";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11261-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11261-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58E133029B0C
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A171AF4E9;
	Sat,  6 Jun 2026 00:33:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A691A6823;
	Sat,  6 Jun 2026 00:33:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780706023; cv=none; b=f6SYxKIuHjIDWYv8aY9ZHrWDsulFUxE+y6Oh4CKdPH/QaxyJ7VrX/JRbrPCvwJ+KXdA28lT6Nse3nLj0ARSRDxQOgR2UTLs+B9j5ZPBq5I9c+LWEhwz/IO+VniTScgpTqBNJ0uhqAZ+PSAFuvoPGkEoolWZq+3Dn1Ua9KW2I/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780706023; c=relaxed/simple;
	bh=vi464gPYA4pfNbbbiX3Giq6bO3gstato/M6d4KM2AOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B5oZ5egcvYo0RukAXOOO5SfDIxReVdQ6szfw/nbw4ew/A8tavUj88Iv+Ri9JavWTPe1wxu4GBllJSHS7lwEz/+lQeV9Dkj8DRuRGrNw605mPLyaSQhxQoJpjF2gVh7cDN2fUcA6O1WlyP4r3J1gmpsmxu+dYF+J/6Ggf3d7bGfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOtQ/BZb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7871F00893;
	Sat,  6 Jun 2026 00:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780706022;
	bh=anqn+SiGpBJNvjnOW60t2BneAFJ6xkEhDQQ1IS475u0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XOtQ/BZbkxDsT1KXyNoOYMY88zvGM0B/eP+bwJ/TYrAxPIUj5yToODhHKNDbaEcNf
	 6bFnja+l3U5ekqcv2e01cHT2nHazt3Rl2rRW+r7pjHoSEqiE4Q9lbnbAGbnjGwwxot
	 sCoDvbbHWGutzq+kSoKnNvckXXGwftNORBp/eXnN9SEez7li1Ah8QHBQbP1MYu0BxN
	 PoESnSpZ4dCVdkrBg5CnV0R3Ku2KChESryRN0ILNXo9P9PHLL5cO94/jrWtmmuYxoP
	 +8G8w/7fm8qBgjLDNQ//2xCuKQK3Q1XrcNPX9mj9pKp9RHapCybN/T8x2axYs9Y82e
	 3uQIYQyuBz5lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 23/23] dmaengine: sdxi: Add DMA engine provider
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260605-sdxi-base-v3-23-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-23-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:33:41 +0000
Message-Id: <20260606003341.DA7871F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TAGGED_FROM(0.00)[bounces-11261-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3362864C05E

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Polling timeout in `sdxi_dma_synchronize()` or `sdxi_stop_cxt(=
)` frees the completion status block while the hardware DMA engine may stil=
l write to it.
- [Critical] The interrupt handler silently ignores DMA hardware errors, tr=
eating failed transfers as successful and masking data corruption.
- [High] `sdxi_dma_terminate_all()` fails to abort or reclaim issued transf=
ers, violating `dmaengine_terminate_all` semantics and causing DMA Use-Afte=
r-Free.
- [High] Error paths in `sdxi_dma_synchronize()` bypass `vchan_synchronize(=
)` and leave uninitialized holes in the hardware ring, permanently stalling=
 the channel.
- [High] `sdxi_tx_status()` returns `DMA_ERROR` without unlinking the error=
ed descriptor, causing destructive state inconsistencies.
- [High] Polling `sdxi_tx_status()` completes descriptors out of order, str=
anding older unpolled transfers in `desc_issued`.
- [High] Freeing an unsubmitted descriptor leaves invalid slots in the hard=
ware ring, permanently hanging the DMA channel.
- [Medium] Missing error check for `sdxi_dma_register` in `sdxi_device_init=
` ignores registration failures.
--

commit c729c81d44b7c609574437378a8416c4d4f6cf2b
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Add DMA engine provider

Register a DMA engine provider that implements memcpy. The number of
channels per SDXI function can be controlled via a module
parameter (dma_channels). The provider uses the virt-dma library.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 26be376c9545f..d6097a6d8992a 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -321,6 +322,7 @@ static int sdxi_device_init(struct sdxi_dev *sdxi)
>  	if (err)
>  		return err;
> =20
> +	sdxi_dma_register(sdxi);

[Severity: Medium]
Is it intentional to ignore the return value of sdxi_dma_register() here?

If registration fails, the device probe will succeed even though the DMA
provider interface isn't actually registered.

>  	return 0;
>  }
> =20
> diff --git a/drivers/dma/sdxi/dma.c b/drivers/dma/sdxi/dma.c
> new file mode 100644
> index 0000000000000..01c85cc2763d8
> --- /dev/null
> +++ b/drivers/dma/sdxi/dma.c
[ ... ]
> +static void sdxi_tx_desc_free(struct virt_dma_desc *vdesc)
> +{
> +	struct sdxi_dma_desc *sddesc =3D to_sdxi_dma_desc(vdesc);
> +
> +	sdxi_completion_free(sddesc->completion);
> +	kfree(to_sdxi_dma_desc(vdesc));
> +}

[Severity: High]
If a client frees a prepared descriptor without submitting it, won't the
reserved hardware slots be left in the ring with their valid bits cleared?

When subsequent descriptors are submitted, it seems the hardware will
permanently hang waiting for these abandoned slots to become valid.

[ ... ]
> +static enum dma_status sdxi_tx_status(struct dma_chan *chan,
> +				      dma_cookie_t cookie,
> +				      struct dma_tx_state *state)
> +{
[ ... ]
> +	if (!sdxi_completion_signaled(sddesc->completion))
> +		return DMA_IN_PROGRESS;
> +
> +	if (sdxi_completion_errored(sddesc->completion))
> +		return DMA_ERROR;

[Severity: High]
If sdxi_completion_errored() returns true, this returns DMA_ERROR without
unlinking the descriptor from the desc_issued list.

Will the interrupt handler sdxi_dma_cxt_irq() then process this errored
descriptor, ignore the error, and successfully complete it via
vchan_cookie_complete()? Does this cause subsequent polling to report
DMA_COMPLETE and destroy the error state?

> +
> +	list_del(&vdesc->node);
> +	vchan_cookie_complete(vdesc);

[Severity: High]
If this function successfully calls vchan_cookie_complete(), doesn't it
unconditionally set chan->completed_cookie to this single descriptor's cook=
ie?

If there are older, uncompleted descriptors preceding it in desc_issued, wi=
ll
subsequent status checks for those older descriptors return DMA_COMPLETE
early?

> +
> +	return dma_cookie_status(chan, cookie, state);
> +}
[ ... ]
> +static int sdxi_dma_terminate_all(struct dma_chan *dma_chan)
> +{
> +	struct virt_dma_chan *vchan =3D to_virt_chan(dma_chan);
> +	u64 dbval =3D 0;
[ ... ]
> +	scoped_guard(spinlock_irqsave, &vchan->lock) {
> +		struct virt_dma_desc *vdesc;
> +		LIST_HEAD(head);
> +
> +		list_splice_tail_init(&vchan->desc_allocated, &head);
> +		list_splice_tail_init(&vchan->desc_submitted, &head);

[Severity: High]
Does this completely ignore the desc_issued list and fail to halt the
hardware context using sdxi_stop_cxt()?

If the desc_issued list is ignored, won't the hardware continue executing
active transfers and writing to destination buffers that the client may have
already freed after calling terminate_all?

> +
> +		if (list_empty(&head))
> +			return 0;
[ ... ]
> +static void sdxi_dma_synchronize(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_cxt *cxt =3D to_sdxi_dma_chan(dma_chan)->cxt;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_desc *nop;
> +	int err;
> +
> +	/* Submit a single nop with fence and wait for it to complete. */
> +
> +	if (sdxi_ring_reserve(cxt->ring_state, 1, &resv))
> +		return;
> +
> +	struct sdxi_completion *comp __free(sdxi_completion) =3D sdxi_completio=
n_alloc(cxt->sdxi);
> +	if (!comp)
> +		return;

[Severity: High]
If sdxi_completion_alloc() fails and returns early, does this leave the
reserved hardware slot completely uninitialized with a valid bit of 0?

Will the hardware permanently hang when it encounters this slot on a
subsequent doorbell ring? Also, does returning early bypass
vchan_synchronize() while the channel might still be active?

> +
> +	nop =3D sdxi_ring_resv_next(&resv);
> +	sdxi_serialize_nop(nop);
> +	sdxi_completion_attach(nop, comp);
> +	sdxi_desc_set_fence(nop);
> +	sdxi_desc_make_valid(nop);
> +	sdxi_cxt_push_doorbell(cxt, sdxi_ring_resv_dbval(&resv));
> +
> +	err =3D sdxi_completion_poll(comp);
> +	WARN_ONCE(err, "got %d polling cst_blk", err);

[Severity: Critical]
If sdxi_completion_poll() times out and returns -ETIMEDOUT, the function
returns and comp is automatically freed by the __free() cleanup wrapper.

Does this return the physical memory to the DMA pool while the hardware DMA
engine retains the physical address pointer?

If the hardware eventually processes the descriptor, will it blindly write
status updates to freed DMA memory that may have been reallocated?

(Note: this identical polling timeout issue also seems to affect
sdxi_stop_cxt() in context.c)

> +
> +	vchan_synchronize(to_virt_chan(dma_chan));
> +}
> +
> +static irqreturn_t sdxi_dma_cxt_irq(int irq, void *data)
> +{
> +	struct sdxi_dma_chan *sdchan =3D data;
> +	struct virt_dma_chan *vchan =3D &sdchan->vchan;
> +	struct virt_dma_desc *vdesc;
> +	bool completed =3D false;
> +
> +	guard(spinlock_irqsave)(&vchan->lock);
> +
> +	while ((vdesc =3D vchan_next_desc(vchan))) {
> +		struct sdxi_dma_desc *sddesc =3D to_sdxi_dma_desc(vdesc);
> +
> +		if (!sdxi_completion_signaled(sddesc->completion))
> +			break;
> +
> +		list_del(&vdesc->node);
> +		vchan_cookie_complete(&sddesc->vdesc);
> +		completed =3D true;
> +	}

[Severity: Critical]
Does this interrupt handler blindly process signaled descriptors without
calling sdxi_completion_errored() to check for hardware errors?

If the hardware reported an error bit, does this mask the failure and treat
the transfer as successful, potentially causing undetected data corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D23

