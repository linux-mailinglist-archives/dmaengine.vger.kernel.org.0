Return-Path: <dmaengine+bounces-9548-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FbRFog8vGlxvgIAu9opvQ
	(envelope-from <dmaengine+bounces-9548-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 19:12:24 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 694012D0A25
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 19:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E602B301D546
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526DE397E76;
	Thu, 19 Mar 2026 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYRSsWBS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89335CB89;
	Thu, 19 Mar 2026 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943894; cv=none; b=tGNpll3IQ93K3GBmE9CzSlJGhvdOEne4nKqPzANi8tqN/nZ4iyBnPa5Bi9Xtx7KypvMmZT4HrZ72eijFla2ThODHpoM+/vH9a1NE2EpbnMEEBwiYDgUI1xHV5rKQcZDYs35Dt6K4FXQTMyIv9y6URH5Ru/y6GYxOP8zqUOT5OxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943894; c=relaxed/simple;
	bh=PEuTwepKNSXXSpxI3aWzNMV/PyWqgVwaIgAdlvvTHwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXXoZaND7EuduFZkmpfXQ2D2QJfhcU5WkCLSE+c8HfUy4CXtMqYY0vEfj/nHZvo1MyBvxtDfHyr86CXijefIeB7nd6trOv2e0sSHQEqFLhWmQaojRwt6wfqPOiop6AxhoJLF9pAHIv9uLS0t5wsCTHQu6D0ynzgNlHhLtlNKDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYRSsWBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6524C19424;
	Thu, 19 Mar 2026 18:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773943893;
	bh=PEuTwepKNSXXSpxI3aWzNMV/PyWqgVwaIgAdlvvTHwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYRSsWBSzU0uWsM51ZdWbRkCPJJcqcoV49iXasGPhokhuAR8gkh6VLgsogt/4OeY1
	 7G96hOvs0VuyGPPdJCVs4MOKonwkL+ZJPMlfGcnFkmJw638KTqLjGUaEf0lEakhglK
	 nSo3z57eoykB1iOIX/b4SpVSTA83Lest612qAsP0fRDK12XTmKvfKO72sYNaM7Z1UN
	 IEIpc2gi1oNlzadzkAPKBpfuD4HaBp7k1wVSplQY1xCgLopN/kd/fucbgbCQneBC6k
	 5H9Jyu/rs4qwzUR905oYT3xWEVscWeHn8vszq0GNFkPOUo3QxVp3UBr9NHpWJRlHyz
	 Xb16k30UHcOfg==
Date: Thu, 19 Mar 2026 18:11:26 +0000
From: Mark Brown <broonie@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	"magnus.damm" <magnus.damm@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Claudiu.Beznea" <claudiu.beznea@tuxon.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	John Madieu <john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: [PATCH 00/22] ASoC: rsnd: Add audio support for the Renesas
 RZ/G3E SoC
Message-ID: <c5ecd391-5a58-411b-8a58-03e6fdc0aa5e@sirena.org.uk>
References: <20260319155334.51278-1-john.madieu.xa@bp.renesas.com>
 <b2347c14-7f29-4453-938b-8287f45aa5fd@sirena.org.uk>
 <TY6PR01MB1737704E431A765933FA6D097FF4FA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fMzgYkzZqeqbY0hA"
Content-Disposition: inline
In-Reply-To: <TY6PR01MB1737704E431A765933FA6D097FF4FA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
X-Cookie: Given my druthers, I'd druther not.
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9548-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[glider.be,renesas.com,kernel.org,baylibre.com,gmail.com,perex.cz,suse.com,pengutronix.de,tuxon.dev,bp.renesas.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.953];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 694012D0A25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--fMzgYkzZqeqbY0hA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2026 at 05:45:05PM +0000, John Madieu wrote:

> > Are there any non-runtime dependencies between the various patches here?
> > It's a fairly large series touching multiple subsystems, we'll need to
> > work out how it gets merged.  It looks to be mainly ASoC but perhaps the
> > other subsystem changes are independent and can just go via their tree?

> The series contains the full chunk of patches for audio IP to work, so they
> depend on each other for runtime to work. However, patches will go through
> different trees and will eventually meet in linux-next or a release.

> In addition to that, DMA (patch 06/22) has hard dependency on IRQ (path 05/22).

> The merge strategy could be:

>  * Patch 01, 03/22 => Clock
>  * Patches 05-06 /22 => DMA
>  * Patches 07-17/22 => ASoC
>  * Patches 02, 18-22/22 => DT

> Next time I'll take care of clarifying this in cover letter.

Please just split out the things that can go separately to their
subsystems, it'll make everything clearer.

--fMzgYkzZqeqbY0hA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm8PE0ACgkQJNaLcl1U
h9BZogf/dju696vjbtY2d6yxFZwNxwRKoyCm4LzmbNjYFofMnbkomP5pL1jKzT5I
bnBJiohxLx580f/u8Cjl7ZJzROu3oLTtjsUk9WSJ7Mje1d/mFoAAwAJhStS0bEit
us/yCS8YWqKyozxWxOrNkLrH8SZddZ5bzkRu1y7pbHpbmYqZTDSK5FWQlhMoIY1y
IIPEo6hQsGRjSKNsKoxs+Oesy88U47DvVyjSto3z3Ahakm87EvfZo5DsSoGJy52A
qQXLil2VJUhpVWXezAhF1tSS+hFUEW4xC5K+1FZ9xV5E/3acIyrf0INEgsTX+fu0
g3Y6IAB0ZWoo528O9j6n2cjioW7rKQ==
=eogU
-----END PGP SIGNATURE-----

--fMzgYkzZqeqbY0hA--

