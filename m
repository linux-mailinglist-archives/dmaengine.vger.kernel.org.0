Return-Path: <dmaengine+bounces-10924-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AndAG9sFWoIVAcAu9opvQ
	(envelope-from <dmaengine+bounces-10924-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:48:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E1B5D3ADD
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE35303EF59
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACF73D3328;
	Tue, 26 May 2026 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+QsiMt2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFF3D6CCF
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788504; cv=none; b=HXS+hZwuwwhERy74IMiyGLJQI5Kcq5bbmgTFSXDwUCXcpygPXGIQGFqCdK6mVXqinxObKV9LGUE3v6Zfm9PHtCIrQGmcCbav8REu48TKNg74xee+vyeIMIOs7I3ODXwcaCibNgZhfwwQs/KRgkcXDxQQdYOcg4UaTSOzMBoFs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788504; c=relaxed/simple;
	bh=UddJJGSRWEvpiDeGKFK7SlznexuXZeKMsdddGovSSlI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rRlgWoE1OOOzSFQ/NxBfOBvz/76FR51HhwZxJ2gnlbMaQEutO1u9Q6AooQIKgj/ssoNapZLCPEaDsZAV2fWGzo3CMf0JqkT/oQMj8SEGX+izjVhMWgz8Th0jHqgULioQ4TsiaraEm/e7M3n6msEnKeK4VQWpNPoPAOkrua6MPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+QsiMt2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FAF1F000E9;
	Tue, 26 May 2026 09:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788503;
	bh=TEJWrcFwsFePQTz+2PWw7rBagaYlrd26aqRPUB0//4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a+QsiMt2yVi9IhGJh1tzhpxwELxxEG8jj6Wfip09L7zGmhu23xUWQCaOvQTiaq2zO
	 Nsgo65JL2yIZVTGNcfal2Aki1HVGwjr1bbwHgMaXZpHaOXNcYYQzgFicgVtW3KyOH9
	 HGV/FZdQkvk/prlygr1HAbtfbD0/ETs7xD9sfAz/0R95ASOsbzIukMRbml5NLj15SP
	 z9HBtI4xCHZ8AcB9N0sBWV5GbKEi54yxK3oGbKdwLyvEsz+7W26BhLcnIn2W0ZZkTQ
	 c+wKFSjEXHgolcv0DQz+3acXP+YZbbkErz2ai/w5+uNpME0PWHzjeRsaMYjVhB6Kfx
	 U/eyYNHo0nweg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/18] dmaengine: sh: rz-dmac: Save the start LM
 descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260526084710.3491480-7-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-7-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:41:41 +0000
Message-Id: <20260526094142.42FAF1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,renesas.com:email,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10924-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 67E1B5D3ADD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced `start_lmdesc` field can be dereferenced whil=
e `NULL` in `rz_dmac_calculate_residue_bytes_in_vd()`.

Pre-existing issues:
- [High] Multiple MEMCPY transfers overwrite each other's hardware descript=
ors causing data corruption.
- [High] Missing `dma_wmb()` memory barrier before setting the Link Valid (=
`HEADER_LV`) bit in DMA descriptors.
- [High] Silent ring buffer overflow when preparing slave SG descriptors if=
 the scatterlist exceeds 64 entries.
--

commit 1282aed7089327e34eb2eeee4b69973599e70406
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Save the start LM descriptor
   =20
This commit saves the start LM descriptor in the channel's descriptor=20
structure to avoid unnecessary iterations from the beginning of the list=20
when calculating residue bytes.

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

[Severity: High]
This isn't a bug introduced by this patch, but does=20
rz_dmac_prepare_desc_for_memcpy() overwrite hardware descriptors of an=20
already active memcpy transfer?

The transfer is configured at channel->lmdesc.tail, but the tail pointer is=
=20
never advanced (unlike in the slave_sg path). If rz_dmac_issue_pending()=20
is called while a memcpy transfer is already active, the new transfer is=20
prepared into the exact same channel->lmdesc.tail slot currently being read=
=20
by the active DMA hardware.

Can this cause memory corruption and unpredictable hardware behavior?

I note this is fixed later in the series in commit d09437d0a9b5a=20
("dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor=20
processing"), which adds a !channel->desc check.

[ ... ]

> @@ -377,6 +380,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct=
 rz_dmac_chan *channel)
>  	}
> =20
>  	lmdesc =3D channel->lmdesc.tail;
> +	d->start_lmdesc =3D lmdesc;
> =20
>  	for (i =3D 0, sg =3D sgl; i < sg_len; i++, sg =3D sg_next(sg)) {
>  		if (d->direction =3D=3D DMA_DEV_TO_MEM) {

[Severity: High]
This isn't a bug introduced by this patch, but does this loop lack a=20
bounds check for sg_len?

The driver iterates over sg_len without checking if it exceeds the hardware=
=20
ring buffer size (DMAC_NR_LMDESC, which is 64).

If a client submits a scatterlist with more than 64 entries, the loop will=
=20
wrap around and overwrite the beginning of the very same transfer it is=20
currently preparing.

Could this result in a corrupted DMA ring buffer and an infinite hardware=20
loop?

[Severity: High]
This is a pre-existing issue, but does setting the Link Valid (HEADER_LV)=20
bit require a dma_wmb() barrier?

The DMA descriptors (lmdesc) are allocated in coherent memory. The driver=20
writes the payload (sa, da, tb, chcfg) and then sets the HEADER_LV bit to=20
indicate to the hardware that the descriptor is ready:

rz_dmac_prepare_descs_for_slave_sg() {
    ...
    lmdesc->tb =3D sg_dma_len(sg);
    lmdesc->chitvl =3D 0;
    lmdesc->chext =3D 0;
    if (i =3D=3D (sg_len - 1)) {
        lmdesc->chcfg =3D (channel->chcfg & ~CHCFG_DEM);
        lmdesc->header =3D HEADER_LV;
    ...
}

Because writes to Normal Non-Cacheable memory can be reordered by the CPU=20
write buffer, is a dma_wmb() barrier strictly required before setting=20
lmdesc->header =3D HEADER_LV?

Without it, if the hardware is executing the chain and polling for the=20
next descriptor, it might see the HEADER_LV bit set before the payload=20
writes have completed.

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

[Severity: High]
Can desc->start_lmdesc be NULL here and cause a kernel panic when=20
accessing lmdesc->nxla?

Because struct rz_dmac_desc is allocated via kzalloc_obj(), start_lmdesc=20
is initially NULL and only assigned when the descriptor is prepared by the=
=20
hardware.

Due to the driver's internal queue management, if a descriptor is prepared=
=20
but not yet submitted, an unrelated IRQ or issue_pending call can move it=20
from ld_queue to ld_active without processing it.

If rz_dmac_chan_get_residue() is then called and matches this descriptor's=
=20
cookie, it will unconditionally dereference the NULL pointer.

I note this is addressed later in the series by commit d09437d0a9b5a=20
("dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor=20
processing"), which completely removes ld_queue and ld_active.

>  	struct dma_chan *chan =3D &channel->vc.chan;
>  	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>  	u32 residue =3D 0, i =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D6

