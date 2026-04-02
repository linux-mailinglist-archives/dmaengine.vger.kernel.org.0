Return-Path: <dmaengine+bounces-9853-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMI8KpFbzmmgnAYAu9opvQ
	(envelope-from <dmaengine+bounces-9853-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 14:05:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF8388C94
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB6273072C4E
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE25935F5F3;
	Thu,  2 Apr 2026 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIv+5W85"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E03644BE;
	Thu,  2 Apr 2026 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130929; cv=none; b=mxVfKFugbGguXmNgpvPiuWP1EwGADRzYR7MNtwpVwMXAbSMiA9XcfojYlcnIWRR6VdZEtlokDpv1Hn7P4W6+FVx7g4YXIFmU6nP3c04tZzPD8e6jzk4s2fW8KAlSDCe9gqYtbHqE3bBYqTtB0n78pTnunPbe4cYPOLCZvR6tt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130929; c=relaxed/simple;
	bh=V7yEqjb63NM1xNoEYdg0sNIEwHGZ2Gv7vhBDNOGUmdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPb+6Di2vp2C2MxsHBCFh+ItSdUg8nmQn87GMrl+tISaLPGfIYEc4qkLatyou4aj7gCYKInT+FDMiMa38+oJet56Wm1ndYo0Q3o8tIvk25VkdwChtKNLel7jV15qML0irEyt7pEx2tcsr6pUOcbZbhGn9Auqh9wu3tA6jnEY4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIv+5W85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DDEC116C6;
	Thu,  2 Apr 2026 11:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775130928;
	bh=V7yEqjb63NM1xNoEYdg0sNIEwHGZ2Gv7vhBDNOGUmdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIv+5W85XENi/fxklryH7DxRO63EugHlfpOCKSGeTri+Hpu544quH0fOhEHtaHbIe
	 IGuqw4GbqRdWF69fzCxr9VhW3HwAnIxCHqiOQsNUdY46awhh1x8AgSuAprsB7Q/1QX
	 swMNkNddsfD+/iTn99XjfuLze73n49QJxhEKch6K7D/UCif2LtKH/+KjBytnGJooyY
	 OfKboLgTTBqSnODUsU+ySA+p4qH4Ml47A6owrOEGwQNQkOcufExY3f8J7FI0exK3UW
	 bDT6RPiUBqVweVQ9aI6pX4zo2au8KLlzC9IzO6bpxQUdL+e/8SgsYBpGi8YgX5gO5V
	 Ww0fsoiEZmg9A==
Date: Thu, 2 Apr 2026 12:55:20 +0100
From: Mark Brown <broonie@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 00/24] ASoC: rsnd: Add audio support for the Renesas
 RZ/G3E SoC
Message-ID: <0c5afdbd-1348-4c61-b036-89adafeb5109@sirena.org.uk>
References: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CkH7niCKfa0KXZAX"
Content-Disposition: inline
In-Reply-To: <20260402090524.9137-1-john.madieu.xa@bp.renesas.com>
X-Cookie: <doogie> dpkg has bugs?  no way!
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9853-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[glider.be,renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A6FF8388C94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--CkH7niCKfa0KXZAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026 at 11:04:59AM +0200, John Madieu wrote:

> This series adds audio support for the Renesas RZ/G3E SoC and enables
> it on the SMARC EVK board with the Dialog DA7212 codec.

> The RZ/G3E audio subsystem is based on R-Car Sound IP but has several
> differences requiring dedicated handling:
>   - SSI operates exclusively in BUSIF mode (no PIO)
>   - 2 BUSIF channels per SSI instead of 4/8 on R-Car
>   - Different register offsets for SCU, ADG, SSIU, and SSI
>   - Per-SSI ADG and SSIF supply clocks
>   - DMA ACK signal routing through ICU
>=20
> This series includes:
>   - Clock driver support for audio clocks and resets
>   - DT bindings update for DMA ACK signal field
>   - IRQ chip extension for DMA ACK signal routing
>   - RZ-DMAC driver updates for ACK signal support
>   - R-Car Sound driver updates for RZ/G3E support
>   - System suspend/resume support
>   - Device tree nodes for RZ/G3E SMARC EVK

You said you were going to separate out the serieses:

https://lore.kernel.org/all/TY6PR01MB173779BDE4BE11739D3B7DAACFF4FA@TY6PR01=
MB17377.jpnprd01.prod.outlook.com/

--CkH7niCKfa0KXZAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnOWSgACgkQJNaLcl1U
h9C68wf+MZsj0US6d4TmQr2yaV8ls0gzIbG9DnDhrRPorWZumeaFME9qPxyfIALP
BT8JNC0R2KuT9nqmMMqJdKr+xpfcRaReczt8bENJXiHsU5ET/XxMR+C4Rqll+3gK
VLV3NbYkbSLFeFvp/dpqwV5Y1PihtISdaYvIR6QNCyKGchmZ4aeVKB4ecuXNfI8b
8E9Y6Mz6nweYfeJu0F2OHX3uqaVUQOIgkn2Y0xM8KwvtTfyAHolUJXljnO9QnJ3C
4NjER7nMS713jJK8gwE9mBXo2NhBDyMDLT9mD7BMovknFIpj2F+omSqJ8TzF/2wr
X6JijFphydiaJjgzrnILLf06j1vY4Q==
=D/sa
-----END PGP SIGNATURE-----

--CkH7niCKfa0KXZAX--

