Return-Path: <dmaengine+bounces-12420-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +C5PHB0fVWrekAAAu9opvQ
	(envelope-from <dmaengine+bounces-12420-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:23:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A1D74DFB3
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:23:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G1QJtE1F;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12420-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12420-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C170B30690FF
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749BE12E1DC;
	Mon, 13 Jul 2026 17:22:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B233C182;
	Mon, 13 Jul 2026 17:22:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963324; cv=none; b=qPx0dSWFDg07dP68p2MV/+tv1aJ8R+UDer4rk35vtoMyCSbmjRL7aj4VPG6fALONBPe1NRuU5rSdc2LiFf+/HDtnXkbHMX5N9LLilsVS3qTvldiSXuo8O3Ph/hX8pMDPjA2piluR83yzTqSnXxP47LdNF4UBWMOZHqPQZQmDMOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963324; c=relaxed/simple;
	bh=WS4X36LUEb259/X0wCCpQ0W1Z1rRI3d2IVkHfZwsMKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DwXBJ9fzngFo6sS2CdWKreBiZQ7uLOUUFsf+dkoGV9Rolawz5OdoisogCPD/w+ewpCyXxwpbhAljO/T7MDOn1eW3kqkb/0niHE7Rw9SISHGCmVDPjXAvTE6eGOzdLv1/53ZRFAc9KhTs7uPFmn+g/jsfPXAf6JU15oRBvFOL3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1QJtE1F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E6C1F000E9;
	Mon, 13 Jul 2026 17:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783963322;
	bh=FoLkTBYmT+b/hHCu2OkpYr/PNHJrAiJcCFPF/mCoIYA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G1QJtE1F67RKq4bzEvaJAGsOpL+TiMDJKbnPESK+RMmrhn4MkU/2qpC9HtfGPkTt2
	 h4RC7F/fbY35CRN7gjfxPOb2Mq2ALsxg1AKEDwIwP6sgtmOnHPbR8oGevOtnU30kcY
	 9HBF/V2jk1c0QlMk0vsDZ4dEx44GEH8vsk6Xn04g2ygHKDiTykGeg+RL26m9ah+tWt
	 9+K0rUodB9RrDr/lGKde0zJdwCMG51djKLcZNFO+wAnrl0bfvqU3CLdyFD43O5/H3Y
	 PD0ilL7Z50VtafEd1ZMAsjmpDbbSSQ2oZM70z0fj3h9soSejCi3p/5SOw3VCXXkwXp
	 823kfoiDxYoGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] dmaengine: dw-edma: Remove struct
 dw_edma_chunk
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260713-edma_ll-v7-10-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-10-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:22:02 +0000
Message-Id: <20260713172202.70E6C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12420-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: B7A1D74DFB3

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Replacing bounded chunk descriptors with a single contiguous GFP_N=
OWAIT allocation breaks large DMA transfers due to memory fragmentation.
- [High] Resuming a paused DMA channel causes an out-of-bounds array read i=
f the active descriptor was fully completed at the time it was paused.
- [Medium] Uninitialized trailing DMA bursts are submitted to hardware if S=
G iteration breaks early.
- [Medium] Stale DMA residue is reported during a channel pause because `de=
sc->done_burst` lags by one batch.

Pre-existing issues:
- [High] Missing `chan->vc.lock` acquisition in `dw_edma_device_resume` and=
 `dw_edma_device_pause` leads to data races and virt-dma list corruption.
--

--- Patch [10]: [PATCH v7 10/10] dmaengine: dw-edma: Remove struct dw_edma_=
chunk ---
commit ac4e11776f7ec8bd87ba4484bd079463058cc76d
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Remove struct dw_edma_chunk

This patch flattens the DMA descriptor layout by moving the burst array
directly into struct dw_edma_desc and removing the linked-list chunk layer.
It uses start_burst and done_burst to track current hardware submissions.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index c028011cc61ca..30eeb7bffad80 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> @@ -40,82 +40,54 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan=
, phys_addr_t cpu_addr)
> -static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
> +static struct dw_edma_desc *
> +dw_edma_alloc_desc(struct dw_edma_chan *chan, size_t nburst)
>  {
>  	struct dw_edma_desc *desc;
> =20
> -	desc =3D kzalloc_obj(*desc, GFP_NOWAIT);
> +	desc =3D kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);

[Severity: High]
Does allocating this unbounded descriptor array at once with GFP_NOWAIT
introduce a risk of memory fragmentation failures?

Large DMA transfers previously used bounded chunk allocations. With this
change, could a large scatter-gather or interleaved transfer spuriously fail
with -ENOMEM since GFP_NOWAIT cannot sleep or perform direct reclaim?

>  	if (unlikely(!desc))
>  		return NULL;

[ ... ]

> @@ -107,18 +79,27 @@ static void dw_edma_core_start(struct dw_edma_desc *=
desc, bool first)
> -	for (i =3D 0; i < chunk->nburst; i++)
> -		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
> -				     i =3D=3D chunk->nburst - 1);
> +	for (i =3D 0; i + desc->start_burst < desc->nburst; i++) {
> +		u32 idx =3D i + desc->start_burst;
> =20
> -	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
> +		if (i =3D=3D chan->ll_max)
> +			break;
> +
> +		dw_edma_core_ll_data(chan, &desc->burst[idx],
> +				     i, desc->cb,
> +				     idx =3D=3D desc->nburst - 1 || i =3D=3D chan->ll_max - 1);
> +	}
> +
> +	desc->done_burst =3D desc->start_burst;
> +	desc->start_burst +=3D i;

[Severity: Medium]
Will this cause stale residue to be reported during a channel pause?

Because desc->done_burst is updated to match start_burst only when the next
batch starts, it appears to lag behind the actual completion if the channel
is paused immediately after an interrupt. This lagging index is then used by
dw_edma_device_tx_status() for residue calculation.

> =20
>  	if (first)
>  		dw_edma_core_ch_enable(chan);

[ ... ]

> @@ -355,13 +321,11 @@ static struct dma_async_tx_descriptor *
>  		fsz =3D xfer->xfer.il->frame_size;
>  	}
> =20
> +	desc =3D dw_edma_alloc_desc(chan, cnt);
> +	if (unlikely(!desc))
> +		return NULL;
> +
>  	for (i =3D 0; i < cnt; i++) {
>  		if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg)
>  			break;
> =20
> -		if (!(i % bursts_max)) {
> -			u32 n =3D min(cnt - i, bursts_max);
> -
> -			chunk =3D dw_edma_alloc_chunk(desc, n);
> -			if (unlikely(!chunk))
> -				goto err_alloc;
> -		}
> -
> -		burst =3D chunk->burst + (i % bursts_max);
> +		burst =3D desc->burst + i;

[Severity: Medium]
If this loop breaks early due to !sg, is desc->nburst left un-updated?

If desc->nburst retains the originally overestimated count,
dw_edma_core_start() will loop up to the original nburst. Does this risk
submitting uninitialized (zeroed) DMA bursts to hardware, potentially
leading to IOMMU faults or hardware hangs?

> =20
>  		if (xfer->type =3D=3D EDMA_XFER_CYCLIC)
>  			burst->sz =3D xfer->xfer.cyclic.len;

[ ... ]

> @@ -625,7 +574,7 @@ static void dw_edma_done_interrupt(struct dw_edma_cha=
n *chan)
>  		case EDMA_REQ_PAUSE:
>  			chan->request =3D EDMA_REQ_NONE;
>  			chan->status =3D EDMA_ST_PAUSE;
>  			break;

[Severity: High]
If a descriptor completes exactly when the channel is paused, could this
lead to an out-of-bounds array read upon resuming?

If the PAUSE handler breaks out here without checking whether
desc->start_burst >=3D desc->nburst, a fully completed descriptor remains on
the list. When dw_edma_device_resume() is later called,
dw_edma_start_transfer() would unconditionally fetch it and pass it to
dw_edma_core_start(), which will access desc->burst[desc->start_burst].
Since start_burst =3D=3D nburst in this scenario, would this read past the =
end
of the flexible array?

[Severity: High]
This is a pre-existing issue, but is it safe that dw_edma_device_pause()
and dw_edma_device_resume() modify chan->request and traverse virt-dma
descriptors without acquiring chan->vc.lock?

Concurrent calls to dmaengine_pause() or dmaengine_resume() alongside the
DMA completion interrupt could lead to data races and virt-dma descriptor
list corruption.

> =20
>  		default:
>  			break;
>  		}
>  	}
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D10

