Return-Path: <dmaengine+bounces-12008-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c255KXDaRmqFegsAu9opvQ
	(envelope-from <dmaengine+bounces-12008-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:38:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4376FCFF9
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:38:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nf84cJtV;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12008-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12008-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28317302DE32
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B73396D2E;
	Thu,  2 Jul 2026 21:38:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A243537F1;
	Thu,  2 Jul 2026 21:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028332; cv=none; b=SMyFN4IuGJD8EHcwIaNbuGDGrhqZm+S1gfc5gfVtlVH8A5Wd4LmLvTmUx6P8gbRqZDgoc198vAVJ2Bix9fYva4vtstESFQdjYJulNBOzPemQLsTDSjOgoAU9mzlsjXFaHEjYVBGNJFip1qYsAzcCVt34U1im5cBAjxDX61QhsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028332; c=relaxed/simple;
	bh=eFbO8OVT2SHKZKt8IytfP1vYyNbZRKfJZKuxRmo52qc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hm6THH/XsTeA1GbruEdNH1fIVV6YlBNgMhD3wm5jcHanj67JF+oHq5FmDnvgzE0j05Zh92rlCFwBeF0EizxmCQ7APg9kWaUq/zv9fXIrK2D2+mUDaLfbaYsGixIZOGBSLPRY1A75ojDPRbvbRY0Gpo3MeWci66hCbwPHYSAVbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf84cJtV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE091F000E9;
	Thu,  2 Jul 2026 21:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028331;
	bh=/UFBByPAWB+DEO0T7OGS4i8TtLhVKIn1focQJsNHYEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nf84cJtV1DmirYNA6fAXqTlfq3EvyM7DfFzYvbY6OwEQK/BKdTz00wt6N676hoocX
	 9HbMSxvd8uUgdyT68awVKyP7CItalo9H4JhZyJ7YMa3VUDThXwYCKLenGtysahjDvr
	 TomQDivmZ6URmJYZv3WBOLEGElDJNtJNd+LIySiff2xuOlL/fDJXUiuorKLCEZN/mw
	 Do74T+iiWFBUNegwil27J258Dugxhz3Pic3zNvqk5XyCj3SgHnoDSwVoixHZATifpo
	 RL6G2yg5GWowp6JEe7EzXLotnsu1VQNDzJblwVl1Erp6/+3XdhUYgDRJHfV7OSLqH+
	 +WWQfUgej3VzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] dmaengine: dw-edma: Remove struct
 dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702-edma_ll-v3-10-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-10-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:38:50 +0000
Message-Id: <20260702213850.EFE091F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12008-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.103.45.18:received,100.90.174.1:received];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D4376FCFF9

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The loop in `dw_edma_core_start` uses an incorrect upper bound=
 for multi-chunk DMA transfers, causing out-of-bounds heap slab reads, inva=
lid DMA programming, and missing completion interrupts.
- [Medium] Incorrect DMA residue calculation in `dw_edma_device_tx_status` =
under-reports remaining bytes due to an off-by-one array index.
- [Low] Dead fields remain in `struct dw_edma_desc` after the removal of th=
e chunk layer.
--

commit bff8cdb94c387e71cb6eb50f2573846d0ceb45ec
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Remove struct dw_edma_chunk

This commit removes the intermediate linked-list layer (struct dw_edma_chun=
k)
from the DMA descriptor layout. It moves the burst array directly into
struct dw_edma_desc and uses start_burst and done_burst to track progress.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
[ ... ]
> -static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
> +static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
>  {
> -	struct dw_edma_chan *chan =3D chunk->chan;
> +	struct dw_edma_chan *chan =3D desc->chan;
>  	u32 i =3D 0;
> =20
>  	if (chan->non_ll) {
> -		if (chunk->nburst =3D=3D 1)
> -			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
> +		chan->dw->core->non_ll_start(chan, &desc->burst[desc->start_burst]);
> +		desc->done_burst =3D desc->start_burst;
> +		desc->start_burst +=3D 1;
>  		return;
>  	}
> =20
> -	for (i =3D 0; i < chunk->nburst; i++)
> -		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
> -				     i =3D=3D chunk->nburst - 1);
> +	for (i =3D 0; i < desc->nburst; i++) {
> +		if (i =3D=3D chan->ll_max - 1)
> +			break;
> +
> +		dw_edma_core_ll_data(chan, &desc->burst[i + desc->start_burst],
> +				     i, desc->cb,
> +				     i =3D=3D desc->nburst - 1 || i =3D=3D chan->ll_max - 2);
> +	}

[Severity: Critical]
Is the loop bound desc->nburst correct when resuming a partially completed
transfer?

For a DMA transfer where the total bursts exceed the hardware chunk limit
(chan->ll_max - 1), desc->start_burst advances after the first chunk. On
subsequent chunks, the loop limit doesn't account for the bursts already
processed. This allows the index calculation i + desc->start_burst to
exceed the size of the allocated desc->burst array, resulting in an
out-of-bounds slab read.

Additionally, does the terminal IRQ condition i =3D=3D desc->nburst - 1 ever
evaluate to true on the final chunk? Since i is a relative chunk index and
desc->nburst is the absolute total, this could prevent the final completion
interrupt from firing.

> +
> +	desc->done_burst =3D desc->start_burst;
> +	desc->start_burst +=3D i;
> =20
> -	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
> +	dw_edma_core_ll_link(chan, i, desc->cb, chan->ll_region.paddr);
> =20
>  	if (first)
>  		dw_edma_core_ch_enable(chan);
[ ... ]
> @@ -337,8 +299,10 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma=
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

[Severity: Medium]
Could this residue calculation under-report the remaining bytes?

When querying the status of a partially complete multi-chunk transfer
(desc->done_burst > 0), this subtracts the cumulative transfer size at
desc->burst[desc->done_burst].xfer_sz. This array index actually holds the
transfer size including the first burst of the currently executing chunk.

Should this use desc->done_burst - 1 instead, to subtract only the bytes
from fully completed chunks?

>  	}
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
> =20
[ ... ]
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-=
edma-core.h
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -66,6 +59,12 @@ struct dw_edma_desc {
> =20
>  	u32				alloc_sz;
>  	u32				xfer_sz;
> +
> +	u32				done_burst;
> +	u32				start_burst;
> +	u8				cb;
> +	u32				nburst;
> +	struct dw_edma_burst            burst[] __counted_by(nburst);
>  };

[Severity: Low]
Since the chunk linked-list layer was removed in this commit, are the
chunk_list and chunks_alloc fields still necessary in struct dw_edma_desc?

It appears xfer_sz might also be unused now that the previous transfer size
tracking was removed from dw_edma_start_transfer().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D10

