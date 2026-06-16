Return-Path: <dmaengine+bounces-11560-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zxmoFW9yMWpNjgUAu9opvQ
	(envelope-from <dmaengine+bounces-11560-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 17:57:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E96918F9
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 17:57:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="nCGtpJ1/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11560-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11560-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64B2630063B3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84944B69C;
	Tue, 16 Jun 2026 15:55:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6137C912
	for <dmaengine@vger.kernel.org>; Tue, 16 Jun 2026 15:55:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625327; cv=none; b=QoZdssjT0SNam2kyerXmWjbet+U/079mumip2FvTQDjSihyrVCBTvT7p2athcB3mPHo58fysA+VgukLBmeeHG80MOw+0UkBLu6XY/eADFmuljo4o8yre7t4Ny6vLy166R1VzQOjIpBxIkfEpNZihWLPIr2DU/J3ft3HWomvD/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625327; c=relaxed/simple;
	bh=GOrziSSBT5eKj4nqGGvuYGPQsPwNS7Uk1Uh4oCsIke4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eygQsO4KLNdMasCFd4G78eoi3xapu64nlZSiz3mZ/KxyZPtexaEK/qH6oDnOK4ToSeRE65jnUd+af8xS7zpptNQxRiKpO2g4A8tk32llOGbIZwKqm9Tb5elUZTeljFujlv8MN4GdEBTYoMdWnLa+dotis9MoyImhTepQ1a+pVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCGtpJ1/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D831F000E9;
	Tue, 16 Jun 2026 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625326;
	bh=8GfsZPNgEJEc0uoqs8KqZu6PK7/do0cN2nsV278Qyic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nCGtpJ1/cQU9EJ9xBo/9NwRG4KnvscjLKL8BMKdN48tPqBZNXuWRwcM/eRB6MGrzQ
	 csTBUhPGOAi6c4WHyr8Ytb9/7ZzFj8P7pQTxH4U4eVa/OjpafcuccuNABoNtLaPDSz
	 NvTsqtPK+aG2N7B7r1bNqL/oCR90GQDeZU3e/+puZc/eScrnSfl+oP2zZ/TicEL90T
	 aO1zFFPMvjjzByvCjLlDIFYFphnG8P28Lsksfuyge+/qMhDsXBKn4NNz4Es7ZoGtRY
	 usliqrUc8fouZXzySuhLpAJabsMFoBdsdPQ258KT8vUpIy1qkWcGRsN01kspFo5ISx
	 S25on17qOoEHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] dmaengine: Support address bus widths of 32
 bytes and above
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TnVubyBTw6EgdmlhIEI0IFJlbGF5?= <devnull+nuno.sa.analog.com@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260616-dmaengine-support-wider-dma-masks-v1-1-da23a8dcb756@analog.com>
References: <20260616-dmaengine-support-wider-dma-masks-v1-1-da23a8dcb756@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:55:25 +0000
Message-Id: <20260616155526.09D831F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11560-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nuno.sa.analog.com@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nuno.sa.analog.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp,analog.com:email,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B41E96918F9

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unsynchronized capabilities bitmask in `dma_get_slave_caps` breaks=
 consumer capability queries.
- [Medium] The helper `__dma_set_addr_mask` improperly rejects `DMA_SLAVE_B=
USWIDTH_UNDEFINED`, breaking driver migration.
--

commit 87eade13a70506a258fd058989e20b6c29344173
Author: Nuno S=C3=A1 <nuno.sa@analog.com>

dmaengine: Support address bus widths of 32 bytes and above

This commit introduces bitmap-based masks for source and destination address
widths to support widths of 32 bytes and above, alongside the legacy u32
fields. It updates dma_get_slave_caps() to fold legacy u32 capabilities into
the new bitmaps and adds helper functions to migrate controllers and
consumers incrementally.

> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 9049171df8578..a21bc9c140aa5 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
[ ... ]
> @@ -593,7 +593,25 @@ int dma_get_slave_caps(struct dma_chan *chan, struct=
 dma_slave_caps *caps)
>  		return -ENXIO;
> =20
>  	caps->src_addr_widths =3D device->src_addr_widths;
> +	if (bitmap_empty(device->src_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX))=
 {
> +		bitmap_zero(caps->src_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
> +		bitmap_from_arr32(caps->src_addr_widths_mask,
> +				  &device->src_addr_widths, 32);
> +	} else {
> +		bitmap_copy(caps->src_addr_widths_mask,
> +			    device->src_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
> +	}
> +
>  	caps->dst_addr_widths =3D device->dst_addr_widths;
> +	if (bitmap_empty(device->dst_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX))=
 {
> +		bitmap_zero(caps->dst_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
> +		bitmap_from_arr32(caps->dst_addr_widths_mask,
> +				  &device->dst_addr_widths, 32);
> +	} else {
> +		bitmap_copy(caps->dst_addr_widths_mask,
> +			    device->dst_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
> +	}
> +

[Severity: High]
Will this initial bitmap population get out of sync when the channel-specif=
ic
device_caps() callback is invoked later in this function?

Currently, dma_get_slave_caps() copies the capabilities into the new
bitmasks here, but later calls:

        if (device->device_caps)
                device->device_caps(chan, caps);

If a legacy driver (like stm32-dma3) dynamically restricts capabilities by
modifying the u32 fields (e.g., caps->src_addr_widths &=3D ~BIT(...)), those
changes won't be reflected in caps->src_addr_widths_mask.

Could modernized consumers relying on the bitmap read stale capabilities
and potentially attempt unsupported hardware bus widths?

>  	caps->directions =3D device->directions;
>  	caps->min_burst =3D device->min_burst;
>  	caps->max_burst =3D device->max_burst;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index b3d251c9734e9..e249158aa4a5f 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
[ ... ]
> @@ -1678,4 +1692,82 @@ static inline struct device *dmaengine_get_dma_dev=
ice(struct dma_chan *chan)
>  	return chan->device->dev;
>  }
> =20
> +static inline enum dma_slave_buswidth
> +__dma_slave_caps_get_width_min(const unsigned long *bitmask)
[ ... ]
> +static inline int __dma_set_addr_mask(unsigned long *bitmask,
> +				      enum dma_slave_buswidth *widths,
> +				      unsigned int n_widths)
> +{
> +	for (unsigned int i =3D 0; i < n_widths; i++) {
> +		switch (widths[i]) {
> +		case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +		case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +		case DMA_SLAVE_BUSWIDTH_3_BYTES:
> +		case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		case DMA_SLAVE_BUSWIDTH_8_BYTES:
> +		case DMA_SLAVE_BUSWIDTH_16_BYTES:
> +		case DMA_SLAVE_BUSWIDTH_32_BYTES:
> +		case DMA_SLAVE_BUSWIDTH_64_BYTES:
> +		case DMA_SLAVE_BUSWIDTH_128_BYTES:
> +			break;
> +		default:
> +			return -EINVAL;

[Severity: Medium]
Does this strict validation unintentionally reject
DMA_SLAVE_BUSWIDTH_UNDEFINED?

Since DMA_SLAVE_BUSWIDTH_UNDEFINED is a valid capability bit (BIT(0))
actively advertised by several DMA drivers (such as xilinx_dpdma, dw/core,
and pl330), returning -EINVAL here might prevent these controllers from
migrating to the new bitmap API.

> +		}
> +
> +		__set_bit(widths[i], bitmask);
> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-dmaengine-=
support-wider-dma-masks-v1-0-da23a8dcb756@analog.com?part=3D1

