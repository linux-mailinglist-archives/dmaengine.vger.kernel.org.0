Return-Path: <dmaengine+bounces-12167-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nrQyOUB4T2pDhQIAu9opvQ
	(envelope-from <dmaengine+bounces-12167-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 12:30:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC8872F9BA
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 12:30:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Zv/Yqn39";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12167-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12167-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 718C531E1739
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341B8403B1B;
	Thu,  9 Jul 2026 10:11:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD437B027
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 10:11:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591886; cv=none; b=hIwhjQlWMgdVVopFY/X+N6ieIf3qCLfE+SLaeb9OyJAV72IH20IPXwA/RUoX6S7zsH5ajdGZMr0py3Jw9qbhBmrUflZQR1wTLeHY46Fcn4n3ZMzFILMunvTQ10W99jVJy3VYemexfP+Jdz9fmMtYmYH1DoG/0/SZfBRyKW5wdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591886; c=relaxed/simple;
	bh=3lL4ffgVehF9xZFZtFbIvv678CrquJS/CFVUO402Pjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UW8yvvaGO5M8/paaVKrW9E0HywbJnj1Rm5MB9mvv2Myjm9HF4DwQFc0aqNyhYkU8ro6KSAst1VveR1efwFlrOZHEs1qxGCWsOoAjLKzD59Ie/ffIPWnuuTROcP/FMUJLmCI+ZnZMXdHcexoTezd5V+rMOxnaMq7bzr4V6htXABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv/Yqn39; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3561F00A3E;
	Thu,  9 Jul 2026 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783591884;
	bh=BDPKQZ0kFp5xFtEeeMa3RdyatZ8NRpGbw2HnioA9H+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zv/Yqn39WknhasVhHly2u9MIP+FP35F/TwGamWpL3fftnjHIBrBCA/+sltZCN9lLP
	 YyoU9FsYAKWdpTdjFSNEMd0PUuOCyq93bL02xaStYz1/DVUTgfKbw0g4Y5UaeighsH
	 lF/hPDAE9070Ob5xscayPpOTTWZFM39kCgTHXEgHe8u5dNHjEpNPa8CgLRI7hNT4Wc
	 fadGRhMin/JbflMmq5zT9A9s4jNSwLyPpLPkHGuAxORoFbDqKiyPjpIyixwGRgyBLv
	 wMdu6KZAzEHb+5g8TMJKLWFdMhMsaPvn4/aUnusDI2oEgir52m+LS2aiN5cwRd8Jrv
	 KYtiY2/usTX9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 4/4] dmaengine: xilinx_dma: Extend metadata handling
 for AXI DMA and MCDMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260708100652.603074-5-srinivas.neeli@amd.com>
References: <20260708100652.603074-1-srinivas.neeli@amd.com>
 <20260708100652.603074-5-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:11:24 +0000
Message-Id: <20260709101124.AB3561F00A3E@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12167-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:srinivas.neeli@amd.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,amd.com:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BC8872F9BA

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying `chan->free_seg_list` without holding `chan->lock` cause=
s linked list corruption.
--

--- Patch [4]: [PATCH V3 4/4] dmaengine: xilinx_dma: Extend metadata handli=
ng for AXI DMA and MCDMA ---
commit 7c1e9fcfa16f54b84c1fd0328dc790510cde97be
Author: Suraj Gupta <suraj.gupta2@amd.com>

dmaengine: xilinx_dma: Extend metadata handling for AXI DMA and MCDMA
   =20
This commit extends metadata handling for AXI DMA and MCDMA to expose
status and sideband information. The metadata pointer now starts at the
descriptor status word instead of the APP fields, and probe logic is
updated to attach metadata_ops when an AXI Stream interface is present.

> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 9b8b6f1acd4ea..03c45369086b8 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c

[ ... ]

> @@ -2623,6 +2653,9 @@ xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, =
struct scatterlist *sgl,
>  		segment->hw.control |=3D XILINX_MCDMA_BD_EOP;
>  	}
> =20
> +	if (chan->xdev->has_axistream_connected)
> +		desc->async_tx.metadata_ops =3D &xilinx_dma_metadata_ops;
> +
>  	return &desc->async_tx;
> =20
>  error:
>  	xilinx_dma_free_tx_descriptor(chan, desc);

[Severity: High]
This isn't a bug introduced by this patch, but does this error path corrupt
the channel's free segment list?

When xilinx_mcdma_prep_slave_sg() encounters an error, it calls
xilinx_dma_free_tx_descriptor() without holding chan->lock. This eventually
cascades to xilinx_mcdma_free_tx_segment() and xilinx_dma_free_tx_segment(),
which add the segment back to chan->free_seg_list:

xilinx_mcdma_free_tx_segment()
    list_add_tail(&segment->node, &chan->free_seg_list);

If another CPU core concurrently calls xilinx_aximcdma_alloc_tx_segment(),
which acquires chan->lock to remove items from this same list, could this
unprotected modification lead to linked list corruption?

This unprotected error path also appears to be present in
xilinx_dma_tx_submit() when chan->cyclic is true.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100652.6030=
74-1-srinivas.neeli@amd.com?part=3D4

