Return-Path: <dmaengine+bounces-12461-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +AD7NcnjVWo9uwAAu9opvQ
	(envelope-from <dmaengine+bounces-12461-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:22:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE4751CD8
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:22:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gwjetAIu;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12461-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12461-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13D71303AA30
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 07:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3315D3EC2EF;
	Tue, 14 Jul 2026 07:22:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4428643A
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 07:22:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013766; cv=none; b=mSV7wZ9Oj+gSKIEbJCtzKUR8SeG18jCf3kUYr5NFs3o27LNEZqQnBDhLURXLvx7MGqG5HnrlJvSZrUWoO+At1MhPcV2emWOupxdT3+WYZtfbLklnEmv1iyqiTLLJiedjt15BUrMCkannpalA/+xoATyAQyd2CbS4BssNC+/LOoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013766; c=relaxed/simple;
	bh=bGFMZjD6rWvEHa8aF5xQZKIp/TRqhPIWZYZRaFQZdZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m5iiSqIOqBOXuc1hVOLjvi6aKLH4O2NLAUf+7VvfTLchhd2ZHDZSo49xgBPeE47vD5T7D8tlMYgqrbIS1Dl1WAFKoEj+LVx+RXmiNua9liHFgUIRoF7lsimYG0EDvXjLf6iLRlwYyM2/swEBV73f4J71qC6JPU+xGu/mp++9Ynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwjetAIu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B5E1F00A3D;
	Tue, 14 Jul 2026 07:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784013764;
	bh=2Nxu2pKedIDitv3byo+t2t7P8Bf+q6khMaPxH5B5I6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gwjetAIu+qpv1MsSLhU3FYXtt+QM9gD2G81iQtJwDQhYlYM8oHUvzCwstViuKZzy2
	 jXruFobiF8QvJtXu1R7Lsvs5lIZnBDqAyVmkbuq2QW3ZdvG3dCJsjUl1hRKyCGI5S+
	 U2B5V1si8ikBkl8/lnv0vjct7dCwsmQ0MHY2+UcfDY+OfZsCFhq+FMoxKQ5RL+ObXQ
	 EMpekCKMf87fMunajEqiyo/wnLTrDMe+BvdOz5Gl9MgM9h26PWuuAIBN9kFWT9vmoP
	 4zSLb9UPRpr7kNx/Je8G4M5vLlkyW1zrW//yGhYgZZMt0rtPHnFtdBXQBIlVJvwhHe
	 wngkIx7bZs2Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] dmaengine: xilinx_dma: Extend metadata handling
 for AXI DMA and MCDMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260713072146.45269-5-srinivas.neeli@amd.com>
References: <20260713072146.45269-1-srinivas.neeli@amd.com>
 <20260713072146.45269-5-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 07:22:44 +0000
Message-Id: <20260714072244.63B5E1F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12461-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:srinivas.neeli@amd.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88EE4751CD8

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] xilinx_dma_get_metadata_ptr() incorrectly returns the End-Of-Fra=
me (EOF) descriptor's metadata for TX (MM2S) operations, breaking TX metada=
ta offload and corrupting completion status.

Pre-existing issues:
- [High] Providing a scatterlist with zero `sg_len` or zero `sg_dma_len` en=
tries results in an empty `desc->segments` list, causing out-of-bounds memo=
ry corruption in prep functions.
- [High] Missing channel lock when freeing DMA segments on descriptor prepa=
ration error paths leads to `free_seg_list` corruption.
--

--- Patch [4]: [PATCH v4 4/4] dmaengine: xilinx_dma: Extend metadata handli=
ng for AXI DMA and MCDMA ---
commit 416ce331f02cd7e51a8987299d3d59436877b288
Author: Suraj Gupta <suraj.gupta2@amd.com>

dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA

This patch extends metadata handling to AXI MCDMA and exposes descriptor=20
status words in addition to the APP fields. It modifies the metadata API=20
to fetch fields from the End-Of-Frame descriptor, and attaches metadata=20
operations for MCDMA when an AXI Stream interface is present.

> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 9b8b6f1acd4ea..0b7bc6ab27cbe 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -649,18 +649,49 @@ static inline void xilinx_aximcdma_buf(struct xilin=
x_dma_chan *chan,

[ ... ]

>  static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor =
*tx,
>  					 size_t *payload_len, size_t *max_len)
>  {
>  	struct xilinx_dma_tx_descriptor *desc =3D to_dma_tx_descriptor(tx);
> -	struct xilinx_axidma_tx_segment *seg;
> +	struct xilinx_dma_chan *chan =3D to_xilinx_chan(tx->chan);
> +
> +	if (chan->xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIMCDMA) {
> +		struct xilinx_aximcdma_tx_segment *seg =3D
> +			list_last_entry(&desc->segments,
> +					struct xilinx_aximcdma_tx_segment, node);

[Severity: Medium]
Does using list_last_entry() unconditionally for both directions break TX=20
(MM2S) metadata offload?

Hardware strictly reads transmit control, sideband, and APP data from the=20
Start-Of-Frame (SOP) descriptor, not the EOF descriptor.

Additionally, for MCDMA, since the returned pointer overlays the mm2s_statu=
s=20
field, could a client writing to this array before submission accidentally=
=20
set the completion bit and cause premature descriptor completion?

> -
> -	*max_len =3D *payload_len =3D sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
> -	seg =3D list_first_entry(&desc->segments,
> -			       struct xilinx_axidma_tx_segment, node);
> -	return seg->hw.app;
> +
> +		/*
> +		 * The union members overlay the same words, so one pointer and
> +		 * length cover both directions (see the layout above).
> +		 */
> +		*max_len =3D *payload_len =3D sizeof(seg->hw.s2mm_status) +
> +					  sizeof(seg->hw.s2mm_sideband_status) +
> +					  sizeof(seg->hw.app);
> +		return &seg->hw.s2mm_status;
> +	}

[ ... ]

> @@ -2623,6 +2654,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, =
struct scatterlist *sgl,
>  		segment->hw.control |=3D XILINX_MCDMA_BD_EOP;
>  	}

[Severity: High]
This is a pre-existing issue, but if a client provides a scatterlist with a
zero sg_len or where all entries have zero length, desc->segments will be=20
empty after the loop.

Looking slightly above this context in xilinx_mcdma_prep_slave_sg(), the co=
de=20
calls list_first_entry() and list_last_entry() on desc->segments without=20
checking if it is empty:

xilinx_mcdma_prep_slave_sg() {
    ...
    segment =3D list_first_entry(&desc->segments, ...);
    desc->async_tx.phys =3D segment->phys;
    ...
    if (chan->direction =3D=3D DMA_MEM_TO_DEV) {
        segment->hw.control |=3D XILINX_MCDMA_BD_SOP;
        ...
}

Doesn't this evaluate to an out-of-bounds pointer within desc->async_tx,=20
potentially corrupting desc->async_tx.callback when segment->hw.control is=
=20
overwritten? The same pattern appears to exist in xilinx_dma_prep_slave_sg(=
).

> =20
> +	if (chan->xdev->has_axistream_connected)
> +		desc->async_tx.metadata_ops =3D &xilinx_dma_metadata_ops;
> +
>  	return &desc->async_tx;
> =20
>  error:

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in=20
xilinx_mcdma_prep_slave_sg() corrupt chan->free_seg_list?=20

When jumping to the error label, xilinx_dma_free_tx_descriptor() is called,=
=20
which subsequently calls xilinx_mcdma_free_tx_segment(). This adds the=20
segment to chan->free_seg_list via list_add_tail() without acquiring=20
chan->lock.

Can this race with concurrent successful allocations (which acquire the loc=
k)=20
and tasklet cleanups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713072146.4526=
9-1-srinivas.neeli@amd.com?part=3D4

