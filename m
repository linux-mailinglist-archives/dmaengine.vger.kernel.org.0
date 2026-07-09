Return-Path: <dmaengine+bounces-12259-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fG8hKBbET2pAoAIAu9opvQ
	(envelope-from <dmaengine+bounces-12259-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:53:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5683C73326B
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:53:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B5xxM+dJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12259-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12259-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C53A0303CAD0
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9242B723;
	Thu,  9 Jul 2026 15:53:55 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6542CB04;
	Thu,  9 Jul 2026 15:53:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612434; cv=none; b=e2yntLk60HIFHzz1pU2U+MfuSFWsMGuPJD00J5w89RlpGFdU1++Ljpf6hU25XpWabFYT6u6MliniMLbEhS2Pr2v1LpGSp6nUwkf6T+f038IBFmURErODfdVvdaZIqenYMa4w9yVYtepcViLV/XWK8fTv35vdcNd+10WKPFRUnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612434; c=relaxed/simple;
	bh=JdlkAZCgwrZl6G7E0YoJUl1TshJd8fAmikgzGCGedEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k9LDZMRpY/M9zY6uGQqeX/E1b2nR+48ZR3tfIoQ4vx17tdAz2Jij9Vf4eM/Yvuj/n+a4xqQpBY9GIKIzld5ihfiOZseXr1weTXLIyOAUYnP2eWIhUlxz5gzMznfN+OqOQ+9b/VtIRM3bVFNlpaKZFIEX5QIWtColn8M1cL+N6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5xxM+dJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B7F1F000E9;
	Thu,  9 Jul 2026 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783612431;
	bh=BpU6xBVrwZ7pEEMxWPwaehuCjxICqGXOCdqqSV7C7og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B5xxM+dJsjKCokV99dMXgUXnn4Sx6fluma06PzlTG2uBOyAXYr7S27haWpg2aSBfV
	 gOVrJsOt08lXPCQAaew0O51iE5YZVrL49RfPT75+cdlOlHitu2fFzrvIrV2zRm5hFS
	 jpIQ+QW5M1al8M/X5e9T4VLXiubyur4s0aogxDvJ+uNqur1vaMc26sgaXE8gz02dyo
	 1tLWtLus4DWlu4Sl2yvTtXsJ9lnudy5xh43pqmxn8xGdzpontVMyueYbJHalc6C0wX
	 Oi3cY9rMqWniOpbOrNi8oYxkeogxihocl2aQlQJSSMfYnAZq+8/5nmSTFEXUkPtCFS
	 Qbx+4tGsnRBQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/10] dmaengine: dw-edma: Remove struct
 dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260709-edma_ll-v5-10-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <20260709-edma_ll-v5-10-e199053d4300@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:53:51 +0000
Message-Id: <20260709155351.97B7F1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12259-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,nxp.com:email,lists.linux.dev:replyto];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5683C73326B

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Replacing dynamically allocated small chunks with a single flat ar=
ray creates a high risk of contiguous memory allocation failures for large =
scatter-gather lists.
- [High] If a channel is paused while the final burst is in flight, resumin=
g the channel causes an out-of-bounds access on the descriptor's flexible a=
rray.
- [High] An integer overflow in calculating the transfer count for interlea=
ved transfers leads to a zero-sized flexible array allocation, resulting in=
 out-of-bounds memory accesses.
- [Medium] Failure to update the descriptor's `nburst` field when the scatt=
er-gather loop terminates early causes uninitialized memory to be programme=
d into the hardware and incorrect residue calculations.
- [Low] Fields used to manage the removed chunk layer are left unused in `s=
truct dw_edma_desc`.

Pre-existing issues:
- [High] Cyclic DMA transfers do not increment the memory address per perio=
d, causing the hardware to overwrite the same memory block repeatedly.
--

--- Patch [10]: [PATCH v5 10/10] dmaengine: dw-edma: Remove struct dw_edma_=
chunk ---
commit f95bbeacc03c2793d791c26855c3782bd0ea8bc2
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Remove struct dw_edma_chunk

This commit removes the dw_edma_chunk linked list layer from the DMA
descriptor layout. It embeds the burst array directly into struct
dw_edma_desc as a flexible array, aiming to reduce memory allocation
overhead by allocating descriptors and bursts together.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 01bee22fe3b3e..30b034a94a815 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
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
Does allocating the entire burst array contiguously with GFP_NOWAIT introdu=
ce
a risk of allocation failures? Previously, chunking the allocations into si=
zes
bounded by chan->ll_max mitigated memory fragmentation. Now, large
scatter-gather lists (e.g., > 1000 entries) require large high-order
contiguous memory blocks, which might fail since reclaim and compaction
are disabled.

>  	if (unlikely(!desc))
>  		return NULL;
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

[Severity: High]
Can resuming a paused channel cause an out-of-bounds access here?

If a channel is paused (EDMA_REQ_PAUSE) right as its final burst completes =
in
dw_edma_done_interrupt(), the pause request skips the completion block,
leaving the fully completed descriptor on the active list. When resumed,
dw_edma_start_transfer() will retrieve the descriptor and call
dw_edma_core_start().

Because the chunk-list exhaustion check was removed, won't this blindly acc=
ess
desc->burst[desc->start_burst] when start_burst equals nburst, reading past
the end of the flexible array?

> +		desc->done_burst =3D desc->start_burst;
> +		desc->start_burst +=3D 1;
>  		return;
>  	}
[ ... ]
> @@ -452,19 +405,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xf=
er,
>  		fsz =3D xfer->xfer.il->frame_size;
>  	}
> =20
> +	desc =3D dw_edma_alloc_desc(chan, cnt);
> +	if (unlikely(!desc))
> +		return NULL;
> +

[Severity: High]
Could this allocation create a zero-sized flexible array if an integer
overflow occurs?

The cnt variable is a u32, but it is calculated just above using size_t fie=
lds
from the interleaved transfer:

    } else if (xfer->type =3D=3D EDMA_XFER_INTERLEAVED) {
        cnt =3D xfer->xfer.il->numf * xfer->xfer.il->frame_size;
        fsz =3D xfer->xfer.il->frame_size;
    }

If a client driver submits an interleaved transfer where numf * frame_size
equals a multiple of 4GB (e.g., 0x100000000), the product wraps to 0.
This would allocate a 0-length flexible array, leading to out-of-bounds
accesses later in dw_edma_start_transfer() and dw_hdma_set_callback_result(=
).

>  	for (i =3D 0; i < cnt; i++) {
>  		if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
>  			break;

[Severity: Medium]
Does desc->nburst need to be updated if this scatter-gather loop breaks ear=
ly?

If a client submits a scatter-gather list where len is greater than the act=
ual
mapped entries, the loop exits early, but desc->nburst remains set to the
artificially large cnt value. dw_edma_core_start() will then loop up to
desc->nburst and submit uninitialized bursts to the DMA engine. Furthermore,
dw_hdma_set_callback_result() will access the uninitialized last element to
calculate residue, causing it to subtract a zero xfer_sz and report incorre=
ct
results.

> =20
> -		if (!(i % chan->ll_max)) {
> -			u32 n =3D min(cnt - i, chan->ll_max);
> -
> -			chunk =3D dw_edma_alloc_chunk(desc, n);
> -			if (unlikely(!chunk))
> -				goto err_alloc;
> -		}
> -
> -		burst =3D chunk->burst + (i % chan->ll_max);
> +		burst =3D desc->burst + i;
> =20
>  		if (xfer->type =3D=3D EDMA_XFER_CYCLIC)
>  			burst->sz =3D xfer->xfer.cyclic.len;
> @@ -473,8 +422,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
>  		else if (xfer->type =3D=3D EDMA_XFER_INTERLEAVED)
>  			burst->sz =3D xfer->xfer.il->sgl[i % fsz].size;
> =20
> -		chunk->xfer_sz +=3D burst->sz;
>  		desc->alloc_sz +=3D burst->sz;
> +		burst->xfer_sz =3D desc->alloc_sz;
> =20
>  		if (dir =3D=3D DMA_DEV_TO_MEM) {
>  			burst->sar =3D src_addr;
>  			if (xfer->type =3D=3D EDMA_XFER_CYCLIC) {
>  				burst->dar =3D xfer->xfer.cyclic.paddr;

[Severity: High]
This is a pre-existing issue, but do cyclic DMA transfers fail to increment
the memory address per period here?

burst->dar (and similarly burst->sar for the opposite direction) is assigned
the fixed xfer->xfer.cyclic.paddr without adding any offset per period. Sin=
ce
the addresses are not incremented by the period size across iterations, won=
't
the hardware repeatedly overwrite or read the exact same memory block?

[ ... ]
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-=
edma-core.h
> index 4950c57fca34f..7f2ec871f5bd5 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
[ ... ]
> @@ -66,6 +59,12 @@ struct dw_edma_desc {
> =20
>  	u32				alloc_sz;
>  	u32				xfer_sz;
> +
> +	u32				done_burst;

[Severity: Low]
Since the struct dw_edma_chunk layer was removed, are the chunk_list,
chunks_alloc, and xfer_sz fields still needed in struct dw_edma_desc?
Looking at the full struct definition, they appear to be unused now,
and leaving them in wastes memory for every descriptor allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-edma_ll-v5=
-0-e199053d4300@nxp.com?part=3D10

