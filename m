Return-Path: <dmaengine+bounces-10923-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBvfJ7RoFWqyUwcAu9opvQ
	(envelope-from <dmaengine+bounces-10923-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:32:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C10E5D3603
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3189303B17A
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468C53B7741;
	Tue, 26 May 2026 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQmSTIZL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048683B7770
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787882; cv=none; b=USIte8FOUNnrAlAZ53s5dh1xv7Bn5f+NjXGOP7m21VwmyNrH718/FOoN5KNKK/CNqE8slrhM2xp1FQKe2Mr1Rgj+gJ3Awt8wTy0MpUViBUKhcHMPvhkYSryrhhdPCvSyndD3wAtNv4TvGl/0T47MnVE2vd3SKZZuwjZbvnpbhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787882; c=relaxed/simple;
	bh=YVvZ+l+LMFPkn44GouzXSL3fYnXt+8NC7GRmnYbXtCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iCEstoq+E+amTXCH8LfFBw/h9hsZNmt5+uynW39CmFw/4Wa+dBmaZ5SoP5OfXxShmG/EDB3SR8+LsdC9M60yXfXOjFBRQ29AWPJvrqgzpOPwPaKcJ1x2TkBulSNBGGVzdRoB5PwX6cFcHMJfBX1di/F/4gfNQIilxAtrQngca3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQmSTIZL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C0D1F00A3A;
	Tue, 26 May 2026 09:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779787880;
	bh=qsSpI/QgfguIqi68b046CVH6OKWnC9fHB6ot5ceQwCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQmSTIZL9qIBvkqqu0Tblu8cZCXACp1IkwufmPxLnAsdFXKXM3ZQcdh6X16Z6BmtX
	 QJ6RduZu4+lOwxqc1lLN24HH1xFFNX/6TCIvsHYot59LYZ8yXt1eIAzgfrHr3i5jtM
	 9P9nCEWhh+YBcIErcCUVQTQ/ObmRVy7g5toOUFQ5iD03OWJ0f42Vo0SnhYvgf6Yz+Q
	 wcVn0lnMlcpi0NwO2fq/OglvKjQ0NBgB96Gbekx/Q04Mueq+VMThUw32VhS+0vvMTN
	 e9Z3a/iqVEVrXCegL8IVlJgb9mYU8afkj9JcUVVzPG++2Bf79ozsCU8+rL0vCbxl45
	 +EbpqnNv6I89A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/18] dmaengine: sh: rz-dmac: Add cyclic DMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com, vkoul@kernel.org
In-Reply-To: <20260526084710.3491480-13-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-13-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:31:19 +0000
Message-Id: <20260526093120.76C0D1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,renesas.com:email,smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10923-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 1C10E5D3603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Using a global channel status flag to track cyclic transfer state =
causes race conditions, incorrect handling of concurrent transfers, and sta=
te leaks.
- [High] The calculation of residue for cyclic transfers evaluates to errat=
ic, mathematically incorrect values.
--

commit 0cfb7df401a4633fd8fdbdc75fec6ad11e0803e3
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Add cyclic DMA support

Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is
introduced to mark cyclic channels and is set during the DMA prepare
callback. The IRQ handler checks this status bit and calls
vchan_cyclic_callback() accordingly.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index c9c00650ddd5d..8fd8a4bd9cc90 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c

[ ... ]

> @@ -733,9 +841,18 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(str=
uct rz_dmac_chan *channel,
>  	}
> =20
>  	/* Calculate residue from next lmdesc to end of virtual desc */
> -	while (lmdesc->chcfg & CHCFG_DEM) {
> -		residue +=3D lmdesc->tb;
> -		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
> +		u32 start_lmdesc_addr =3D rz_dmac_lmdesc_addr(channel, desc->start_lmd=
esc);
> +
> +		while (lmdesc->nxla !=3D start_lmdesc_addr) {
> +			residue +=3D lmdesc->tb;
> +			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		}

[Severity: High]
Does this loop calculate the remaining bytes correctly for cyclic
transfers?

The earlier loop leaves lmdesc pointing to the descriptor preceding the
currently executing one. If the loop here sums lmdesc->tb from this
preceding descriptor up to (but excluding) the last descriptor, won't the
returned residue values be cyclically shifted by one period?

For example, in a 3-period buffer (A, B, C), if the hardware is executing
period B, summing the transfer bytes of A and B would return
crtb + 2 * period_len instead of the correct crtb + period_len. Could this
cause audio cyclic pointers to jump erratically backwards and forwards?

> +	} else {
> +		while (lmdesc->chcfg & CHCFG_DEM) {
> +			residue +=3D lmdesc->tb;
> +			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		}
>  	}

[ ... ]

> @@ -928,10 +1045,14 @@ static irqreturn_t rz_dmac_irq_handler_thread(int =
irq, void *dev_id)
>  	if (!desc)
>  		return IRQ_HANDLED;
> =20
> -	vchan_cookie_complete(&desc->vd);
> -	channel->desc =3D NULL;
> +	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
> +		vchan_cyclic_callback(&desc->vd);

[Severity: High]
Should this check desc->type =3D=3D RZ_DMAC_DESC_CYCLIC instead of the glob=
al
channel status?

If a cyclic transfer is prepared while a non-cyclic transfer is currently
executing, the global channel status will be updated immediately. When the
active non-cyclic transfer finishes, won't this logic incorrectly call
vchan_cyclic_callback() for the non-cyclic descriptor?

This could skip vchan_cookie_complete() and rz_dmac_xfer_desc(), which
would leak the descriptor and stall the DMA channel.

> +	} else {
> +		vchan_cookie_complete(&desc->vd);
> +		channel->desc =3D NULL;
> =20
> -	rz_dmac_xfer_desc(channel);
> +		rz_dmac_xfer_desc(channel);
> +	}
> =20
>  	return IRQ_HANDLED;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D12

