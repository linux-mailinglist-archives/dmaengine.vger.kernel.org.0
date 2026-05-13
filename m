Return-Path: <dmaengine+bounces-10450-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKNSCq4OBWrcRwIAu9opvQ
	(envelope-from <dmaengine+bounces-10450-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 01:52:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5EB53C248
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 01:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA473014105
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 23:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE073B635F;
	Wed, 13 May 2026 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brfv00W1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBFF2D29C8
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716331; cv=none; b=qSu8D8zqChUmGNMpoN7EceIhb3LUpreG+Z5emKeQ8KdjCEf7n0MvwIIIVmuDEVtuoSvkbTWKPwqX5RGJIwqr6PBsVUktdkXmYoguqcvSFlmFiOYAUVQqmKF9IeZfK9hBIpnID8YlNfHsXPFJc5fZcSkBCQoeTfQ1WWybMobCGMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716331; c=relaxed/simple;
	bh=A7ZxtJGxeulD2Bd+rq7FuMivOw3kl3sYuypVtLU+MdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mt8645WK4JczzdUZNiBZAarF2AEaMBOwiviensL6zGWwiR+zjhKhKNInNCycm7sX178z5FmYEZuRZdhMk2uQUteOOQPiQV+hHcCSQpbc182SkyNRwbnPiNjUbzJHdkmqEmrHDBgT+xE8i/pdkXVePiVn9sgsWFda7G6TMODtic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brfv00W1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7A4C19425;
	Wed, 13 May 2026 23:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778716331;
	bh=A7ZxtJGxeulD2Bd+rq7FuMivOw3kl3sYuypVtLU+MdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=brfv00W1FyNyO9zT57cbmLdkFzu9yZWnaqAhddYVtHw8Y4Md0fDsVLyGA4bmckQ4y
	 +ym4l3aZ86ow+sany+U7w1nloW6gvpjQpgNVoMoZ4RD7BJdZCfm6EJa48X+v4AToje
	 FPn3lwFeghYs9fpHyM9tKdgVoRZqy6fNEmQ192xVbOIbEfR4QwLtltNwB9q+aCib84
	 r9NbFoRdkxCb3PPhJv+djdhsHIFksjTvCzyjzjuai0e/BXG04Fjs1KB/ZJ/S3hMjwu
	 D00kjB7LquoJTpB3DLlcQB+WchO+/X/Nuv/VAg0zEWihORsunMNkqW1YX20aiLP94d
	 +L44KszTfJZOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/17] dmaengine: sh: rz-dmac: Save the start LM
 descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260512121219.216159-7-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-7-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:52:10 +0000
Message-Id: <20260513235210.EB7A4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 7F5EB53C248
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10450-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Uninitialized pointer dereference causing a kernel panic in `rz_dm=
ac_calculate_residue_bytes_in_vd`.
- [High] Pre-existing bug: `rz_dmac_prepare_desc_for_memcpy` does not advan=
ce the hardware ring buffer tail, causing active descriptor corruption.
- [High] Pre-existing bug: Fundamentally broken residue calculation in `rz_=
dmac_calculate_residue_bytes_in_vd()`.
- [Medium] The patch fails to prevent the unnecessary loop iterations it cl=
aims to fix (Placebo Fix).
--

commit 4d414b3c13389eee6de9985a5483dae47daf52b4
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Save the start LM descriptor

Save the start LM descriptor to avoid looping through the entire
channel's LM descriptor list when computing the residue. This avoids
unnecessary iterations.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index c48858b68dee6..d3926ecd63ac1 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c

[ ... ]

> @@ -343,6 +344,8 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz=
_dmac_chan *channel)
>  	struct rz_dmac_desc *d =3D channel->desc;
>  	u32 chcfg =3D CHCFG_MEM_COPY;
> =20
> +	d->start_lmdesc =3D lmdesc;
> +
>  	/* prepare descriptor */
>  	lmdesc->sa =3D d->src;
>  	lmdesc->da =3D d->dest;

This isn't a bug introduced by this commit, but I noticed
rz_dmac_prepare_desc_for_memcpy() does not appear to advance the hardware r=
ing
buffer tail.

If multiple memcpy transfers are queued, will each new preparation overwrite
the exact same slot in the DMA hardware's ring buffer memory?

If a new memcpy transfer is prepared while a previous one is currently
executing from that slot, could this physically overwrite the active hardwa=
re
descriptor and lead to unpredictable hardware behavior and memory corruptio=
n?

[ ... ]

> @@ -693,9 +697,10 @@ rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, stru=
ct rz_lmdesc *lmdesc)
>  	return next;
>  }
> =20
> -static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *ch=
annel, u32 crla)
> +static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *ch=
annel,
> +						 struct rz_dmac_desc *desc, u32 crla)
>  {
> -	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
> +	struct rz_lmdesc *lmdesc =3D desc->start_lmdesc;

Can desc->start_lmdesc be uninitialized here and cause a panic?

If a client driver prepares and submits a descriptor but delays calling
dma_async_issue_pending(), the descriptor enters ld_queue but not desc_issu=
ed.
If a prior transfer completes, rz_dmac_irq_handler_thread() attempts to
process ld_queue by calling rz_dmac_xfer_desc().

Because the new descriptor is not in desc_issued, vchan_next_desc() returns
NULL, and rz_dmac_xfer_desc() returns 0 without executing the prepare
functions, leaving start_lmdesc as NULL.

The IRQ handler then interprets the 0 return as success, moving this
unprepared descriptor to ld_active. A subsequent call to
dmaengine_tx_status() triggers rz_dmac_calculate_residue_bytes_in_vd(), whi=
ch
would dereference the NULL start_lmdesc.

I see this is fixed later in the patch series by commit "dmaengine: sh:
rz-dmac: Use virt-dma APIs for channel descriptor processing" which correct=
ly
handles vchan_next_desc() returning NULL, but could this cause bisectability
issues here?

>  	struct dma_chan *chan =3D &channel->vc.chan;
>  	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>  	u32 residue =3D 0, i =3D 0;

Does the while (lmdesc->nxla !=3D crla) loop below this still iterate throu=
gh
the whole list, missing the intended optimization mentioned in the commit
message?

If the hardware is actively processing the first descriptor, crla is the
address of that first descriptor. Since lmdesc is initialized to
desc->start_lmdesc (which is also the first descriptor), lmdesc->nxla will
point to the second descriptor.

This will not match crla, so it appears the loop will still iterate through
all 64 elements of the ring buffer to find the descriptor preceding the
first one.

Also, a pre-existing issue unrelated to this patch: is the underlying resid=
ue
arithmetic correct for multi-segment transfers?

When processing a multi-segment scatter-gather list, the function attempts =
to
find the descriptor preceding the currently executing one. Once found, it
iterates forward using:

    while (lmdesc->chcfg & CHCFG_DEM)

Because it starts from the descriptor preceding the current one, if crla is
the second descriptor (L2), the loop starts at L1, adds L1->tb, and termina=
tes
because L2's CHCFG_DEM is 0.

It then adds crtb (the bytes of the current segment). Does the final return=
ed
value double-count the already transferred L1 and completely miss the sizes=
 of
all future segments in the virtual transfer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D6

