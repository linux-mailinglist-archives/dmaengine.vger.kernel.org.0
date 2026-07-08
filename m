Return-Path: <dmaengine+bounces-12141-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ScmGN96bTmpbQgIAu9opvQ
	(envelope-from <dmaengine+bounces-12141-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:50:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6E729B59
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:50:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VCklBuQv;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12141-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12141-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 480E430C1521
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7608B3C3C0B;
	Wed,  8 Jul 2026 18:47:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14B26059D;
	Wed,  8 Jul 2026 18:47:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536451; cv=none; b=DhjOfN6ibtxNrpKaILbk7/m9srl5H5xyGt0GJo2FnT3Lp52oseIP9+nlpnKOhJ9B37k9byLUzpNQ0CoUmjzgPAAUp4ck4nHtM2g/u6RLuqsXHgq+nIwaPX0DGPtOZjB3KYGDsRrzcz3MUpLhDPvSGPY9SEtttEPYyUjOJBoN3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536451; c=relaxed/simple;
	bh=91SZ/RVkP8a8E0xWJTUA0MiWmjSVw24hHDfQbSXnZQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vr6YgYHRaakuRPcQQMKOrNAW6xk6V/mdJiajDGMLev24PtVbnrwERZopxramlUGxhe37V2g9nX10BZFhDWA+HfcwIvdfZEYw8WyJP5Wb3HsYZlkt6s6a1tilChjE7TyPokq3KpK99ypiLjmbtpneLkx821erF5m3t0Bsi4ArgpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCklBuQv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F182D1F00A3A;
	Wed,  8 Jul 2026 18:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536449;
	bh=hOY06aqNRCb+m8fxaLg3VfR0fgELFUNzj3G7nfxTMrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VCklBuQvpZT9cdv88H0UpI1j2xEoePN0nEVQNEUvs9CIY5dIndmMIyPRTTw2BhAAu
	 fN5GcdABocqnSBQAkaGuDcNt6ZoZNXkm+c0UaG/BqoQ+oiX3MjPs7DO/R7Is06ddbf
	 pTan2f4g58SlD0rMf9sDDcMZqEvdNKzUzq3h0yLhLGRjgFCFhfAE7v83jPG2JqhzMZ
	 IjLXrn0hQ02sySvBBit42DuRL/IkVW7P65U4qZBO8KFcYMDhT/sJ24bolnqKZtC6DR
	 8JHJmniZ0YR5RBC42+R+fzIDscHODiyjoBxL5Xr8HakWna7vy/z95EQCHRgs0opl9f
	 LFMNJSZZKFk5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/10] dmaengine: dw-edma: Remove struct
 dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260708-edma_ll-v4-10-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-10-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:47:28 +0000
Message-Id: <20260708184728.F182D1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12141-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82D6E729B59

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Replacing chunked allocations with a single, unbounded array alloc=
ation causes a severe risk of `GFP_NOWAIT` failures for large transfers.
- [High] The device TX status calculation incorrectly subtracts the size of=
 the uncompleted burst instead of the last completed burst, resulting in an=
 under-reported residue.
- [High] Double subtraction of the link descriptor limit in `dw_edma_core_s=
tart()` incorrectly limits chunk sizes and causes a hardware hang for small=
 link regions.

Pre-existing issues:
- [High] The functions `dw_edma_device_resume`, `dw_edma_device_pause`, and=
 `dw_edma_device_terminate_all` modify channel states and access descriptor=
 lists without holding `chan->vc.lock`.
--

--- Patch [10]: [PATCH v4 10/10] dmaengine: dw-edma: Remove struct dw_edma_=
chunk ---
commit 4d352ddf553a3f2f63c8953fcbcf205cb6c98a87
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Remove struct dw_edma_chunk

This commit removes the dw_edma_chunk layer to simplify the descriptor
layout, embedding the burst array directly into dw_edma_desc. It aims
to reduce the number of kzalloc calls when creating a DMA descriptor.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 01bee22fe3b3e..474debb53c470 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> @@ -40,82 +40,54 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan=
, phys_addr_t cpu_addr)
[ ... ]
> -static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
> +static struct dw_edma_desc *
> +dw_edma_alloc_desc(struct dw_edma_chan *chan, u32 nburst)
>  {
>  	struct dw_edma_desc *desc;
> =20
> -	desc =3D kzalloc_obj(*desc, GFP_NOWAIT);
> +	desc =3D kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);

[Severity: High]
Does this unbounded allocation risk failing under memory fragmentation?

The previous logic used bounded chunk sizes, but nburst is now passed direc=
tly
from the scatter-gather list length or interleaved frames in
dw_edma_device_transfer(), which could be thousands of entries. Allocating a
large contiguous array in an atomic context with GFP_NOWAIT seems highly pr=
one
to failure for large transfers.

>  	if (unlikely(!desc))
>  		return NULL;
[ ... ]
> -static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
> +static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
>  {
[ ... ]
> +	for (i =3D 0; i + desc->start_burst < desc->nburst; i++) {
> +		u32 idx =3D i + desc->start_burst;
> =20
> -	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
> +		if (i =3D=3D chan->ll_max - 1)
> +			break;

[Severity: High]
Does this double-subtract the link descriptor limit?

chan->ll_max is initialized elsewhere as (sz / EDMA_LL_SZ) - 1 to account f=
or
the link descriptor. If chan->ll_max is 1, breaking at i =3D=3D 0 submits a=
 batch
with 0 data elements. Could this immediately complete and fire an interrupt,
potentially triggering an infinite loop of 0-length transfers?

> +
> +		dw_edma_core_ll_data(chan, &desc->burst[idx],
> +				     i, desc->cb,
> +				     idx =3D=3D desc->nburst - 1 || i =3D=3D chan->ll_max - 2);
> +	}
[ ... ]
> @@ -337,8 +301,10 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma=
_cookie_t cookie,
>  	vd =3D vchan_find_desc(&chan->vc, cookie);
>  	if (vd) {
>  		desc =3D vd2dw_edma_desc(vd);
> -		if (desc)
> -			residue =3D desc->alloc_sz - desc->xfer_sz;
> +
> +		residue =3D desc->alloc_sz;
> +		if (desc && desc->done_burst)
> +			residue -=3D desc->burst[desc->done_burst].xfer_sz;

[Severity: High]
Should this calculation use desc->done_burst - 1 instead of desc->done_burs=
t?

desc->done_burst holds the index of the first burst currently executing in
hardware. Subtracting desc->burst[desc->done_burst].xfer_sz includes the si=
ze
of an unfinished burst, which under-reports the residue. This differs from
dw_hdma_set_callback_result() which uses desc->done_burst - 1.

>  	}
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but looking at
dw_edma_device_resume() and dw_edma_device_pause() in
drivers/dma/dw-edma/dw-edma-core.c:

dw_edma_device_resume()
    chan->status =3D EDMA_ST_BUSY;
    dw_edma_start_transfer(chan);

dw_edma_device_pause()
    chan->request =3D EDMA_REQ_PAUSE;

Can modifying the channel state and calling dw_edma_start_transfer() (which
accesses vc->desc_issued) locklessly cause data races?

Other functions like dw_edma_device_issue_pending() and
dw_edma_done_interrupt() protect these structures with
spin_lock_irqsave(&chan->vc.lock, flags).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D10

