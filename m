Return-Path: <dmaengine+bounces-10925-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JKyANFsFWoYVAcAu9opvQ
	(envelope-from <dmaengine+bounces-10925-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:50:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ECD5D3B21
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 11:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EFFB3059A6B
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBEE3D9023;
	Tue, 26 May 2026 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaiZ+pjn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799993D9035
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788591; cv=none; b=UWoqS+aIX0Wib4KsrDY8IF+R86qorWoI4Lw/Ni8HBTRofAOUtAEywP42nxD+o4dQLbaStEmV63J1ibloyozP/5uJ/3gOTUYQ/egcw7K1PJygriPL94k1+rJd+s+OrAuKGlA6WTirR5wtj9AdPOgWH7vpq1VOhIz0U6v0I52ppBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788591; c=relaxed/simple;
	bh=xt+pWEtU4Zyeck6siShLZG5Yhuu4hj8eiaHYiIvUJbE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M4yqEliyb43bQyTeOono5vdVwO1kdTHONQIVOJJ3hV84Zum//xve1i2+6HNuWi7EgcP+Ft/CdQWKobtvLH4Ogiqb4jAdJ0bEFzAnRHZ08NJDVU3lmgM3R/5pHBqrh4EkkPWqfFSqxpu+t8lST7yUak80Cl49wxIcEJFrWiE3830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaiZ+pjn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3316C1F000E9;
	Tue, 26 May 2026 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788590;
	bh=Wf1hbnV4EW8RBBUEkyMtmTqyA/vftPL6E0NhSKhgvms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FaiZ+pjnPeH8j7LGNqE0vW4ZbOxY7Am0VLxPY9/2VPcBwUpwwpDeyUGLcsEQkShvo
	 m5gUWWEJWNvYA2Y1GLEcxE96j25IqZsZSgcSWMEtQcZxdrJKnSFySl1F1pRDCdeWC7
	 +4skz3je5BaL1BsCwWuwzS2l/tF19CcFTXezidgFyaqB5Q2IU6iizgtnba7Mznb3Ag
	 XaxU6EfeXtkZk5McUpdVuSPzJXPWnZj+Iu2JnaflgFQEUEBBzUbOSncld+sGaxEX6d
	 SDv/BOe82QbJKORREbGr+HPr9ZxzbEI6eZhEyZiWZSHjmA+67sssK2JyWVJ2hiksqP
	 wk5hzrgj/YGrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/18] dmaengine: sh: rz-dmac: Set the Link End (LE)
 bit on the last descriptor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260526084710.3491480-19-claudiu.beznea@kernel.org>
References: <20260526084710.3491480-19-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 09:43:09 +0000
Message-Id: <20260526094310.3316C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,renesas.com:email,smtp.kernel.org:mid];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10925-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 46ECD5D3B21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation for `sg_len` in `rz_dmac_prep_slave_sg` and `pe=
riods` in `rz_dmac_prep_dma_cyclic` leads to either an infinite loop (kerne=
l hard lockup) or descriptor ring buffer overflow and silent data corruptio=
n.
- [High] The DMA residue calculation logic in `rz_dmac_calculate_residue_by=
tes_in_vd` is broken due to incorrect descriptor matching and off-by-one er=
rors, resulting in bogus residue reports.
--

commit 1936bc22a913ae590a18e0828fe08cbdd4e5a588
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last descriptor

This patch sets the Link End (LE) bit on the last descriptor of a transfer
to inform the DMA engine that it is the final descriptor. This prevents the
DMA engine from loading an invalid descriptor and raising a descriptor erro=
r.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 2a7124e4aea3a..f1174d25da849 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
[ ... ]
> @@ -425,7 +426,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct=
 rz_dmac_chan *channel)
>  		lmdesc->chext =3D 0;
>  		if (i =3D=3D (sg_len - 1)) {
>  			lmdesc->chcfg =3D (channel->chcfg & ~CHCFG_DEM);

[Severity: High]
This is a pre-existing issue, but is the DMA residue calculation broken?

The logic to calculate remaining bytes in
rz_dmac_calculate_residue_bytes_in_vd() appears to have several issues:

1) The search loop while (lmdesc->nxla !=3D crla) erroneously matches the n=
ext
link address against the current link address (crla), causing lmdesc to
incorrectly resolve to the descriptor preceding the currently executing one.

2) The subsequent sum adds the total bytes (lmdesc->tb) of this
already-completed preceding descriptor, and then double-counts the current
descriptor (whose remaining bytes are already added via crtb).

3) Because CHCFG_DEM is intentionally cleared on the final descriptor here,
the accumulation loop while (lmdesc->chcfg & CHCFG_DEM) terminates early
and fails to include the byte count of the last descriptor.

Could this impact subsystems like ALSA audio and serial UART that rely on
precise DMA residue?

> -			lmdesc->header =3D HEADER_LV;
> +			lmdesc->header =3D HEADER_LV | HEADER_LE;

[Severity: High]
This is a pre-existing issue, but does the lack of validation for sg_len and
periods cause problems?

If dma_map_sg() returns 0 and the client passes sg_len =3D=3D 0, the
initialization loop is skipped entirely, leaving all descriptor headers as =
0.

When rz_dmac_enable_hw() is called, rz_dmac_lmdesc_recycle() enters an
infinite loop because no descriptor has the HEADER_LV bit set:

	while (!(lmdesc->header & HEADER_LV))

This could cause a kernel hard lockup with spinlocks held.

Additionally, if a client submits a transfer with more than 64 segments
(sg_len or periods > DMAC_NR_LMDESC), the fixed-size ring buffer overflows
and wraps around.

Because the last segment will overwrite the beginning of the transfer
with the HEADER_LE bit added by this patch, the hardware will only execute
the corrupted tail of the scatterlist and immediately stop.

Could this lead to silent data corruption?

>  		} else {
>  			lmdesc->chcfg =3D channel->chcfg;
>  			lmdesc->header =3D HEADER_LV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526084710.3491=
480-1-claudiu.beznea@kernel.org?part=3D18

