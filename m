Return-Path: <dmaengine+bounces-9545-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDGIHhojvGkptQIAu9opvQ
	(envelope-from <dmaengine+bounces-9545-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:23:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B632CEBB3
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 17:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B45A530367E9
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ABB3E715F;
	Thu, 19 Mar 2026 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQf3kgBC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750F61C3BF7;
	Thu, 19 Mar 2026 16:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937332; cv=none; b=DQs8PwADcyKSs9Nq8csC6dd9zOgS82dUrrJyV7nL1LhDKgdWdC5cwD+Cq3eRt9hHV48ydt4mqQxfJqhyHxiTwsEFJvjCuoXYzCLgf+LDslKUrANEvvg7QhzWxjdhL/NKWkqXnH15qCTTQ2vPuTtJAOon7synJkXkHQe1Ukbz03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937332; c=relaxed/simple;
	bh=iy3MeSA1uG9awnTTpbd86p02bVpAzL1FkXvQsaijl4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn3lhRTwrEnrlkhwSdW8dJIuqAN4/Vd6zDDj78z0oQL9N8Rlgj1ie66EkpKs30ZOEJyLUUzKRdG66bQu91S1JFzXCA8Yc/nLIJkjeY+ytulfhdKuvMsOx2oYE3KO7oEHlHP4+BT5pWcVffm6qb24foVF8oU5pCxqmjiKTKWsjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQf3kgBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74006C19424;
	Thu, 19 Mar 2026 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773937332;
	bh=iy3MeSA1uG9awnTTpbd86p02bVpAzL1FkXvQsaijl4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQf3kgBCnof/ZaYwMhoDO6G4keSnpbBFIUoefTUXMF1FRPriUNksDVh6ZLYdNBVXE
	 9eTymtpa8cFlrC46bUhG1xCW2YnGgSxCT5EPLVJA2pdmOJWu1rZe5PSkVaatYm8ivU
	 FqUlhf7WKiLqzYCFwXBqp+hsSIhf9wJOTLfhkq09NwkhdZITP/LBb5LjCWFSBUZaw8
	 bpzdkL5HSYuba/3URhFJQq8x7W3eS68QOp5V9SveFzoMzbPgdYNifin1EsPzBOmTJH
	 fk9VWOpLdCFx+wH7s8WIDtOuh4nugdPkhBnusO6u6nJkjusJJ3n/1vMMzlaR0e4uMx
	 5ILF66Isu27yQ==
Date: Thu, 19 Mar 2026 16:21:55 +0000
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
Subject: Re: [PATCH 00/22] ASoC: rsnd: Add audio support for the Renesas
 RZ/G3E SoC
Message-ID: <b2347c14-7f29-4453-938b-8287f45aa5fd@sirena.org.uk>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M0S6hMqfqBLF2RTC"
Content-Disposition: inline
In-Reply-To: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
X-Cookie: Given my druthers, I'd druther not.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9545-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[glider.be,renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22B632CEBB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--M0S6hMqfqBLF2RTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2026 at 04:53:12PM +0100, John Madieu wrote:

> This series includes:
>   - Clock driver support for audio clocks and resets
>   - DT bindings update for DMA ACK signal field
>   - IRQ chip extension for DMA ACK signal routing
>   - RZ-DMAC driver updates for ACK signal support
>   - R-Car Sound driver updates for RZ/G3E support
>   - System suspend/resume support
>   - Device tree nodes for RZ/G3E SMARC EVK

Are there any non-runtime dependencies between the various patches here?
It's a fairly large series touching multiple subsystems, we'll need to
work out how it gets merged.  It looks to be mainly ASoC but perhaps the
other subsystem changes are independent and can just go via their tree?

--M0S6hMqfqBLF2RTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm8IqMACgkQJNaLcl1U
h9BHmAf+PMcOwgB9Gct8b6c7m1InEsr2pIiF/SbmLSRFXBzS58ook4aVD+JEvFm8
tKmogJ2YDakAc/hOjP05KONmSns3bClBoV2BL3GPQHHvOH0Dw0LJQZwuyp3tH9zQ
LZsnisVHORxfPABK2tUcbD31y+ZY2fqFF9goE3FxPLR4itZx7HjT2xSq2SFvlRxF
FA1VMRYasUfV6TaJKcTJS3jxv/hpjgQADhFhT739qU4RvwAuZcfnMj0XzTOcHite
Rl1Pj6kKEzO9KrHeu4Bx07Tg7VbiDNOQPy8dXeM7E/Cfr7G8lZPFh2V2edly312V
nhRXGGvo8aAh6qR1ZNILCsdFMRzVsA==
=PFGf
-----END PGP SIGNATURE-----

--M0S6hMqfqBLF2RTC--

