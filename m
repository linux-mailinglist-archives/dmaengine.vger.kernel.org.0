Return-Path: <dmaengine+bounces-5178-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1950AB8266
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 11:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD421B65F88
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D8628AB11;
	Thu, 15 May 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTauZgz0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67715289E03;
	Thu, 15 May 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300964; cv=none; b=uSHd9rwrzi444fbT7zHOrSCxz03NlihhdkpfpYccY7EY2Y2hoSknkqOfLsx8DudCTvf9CwATJUlcBG27X/dlchGCawcL1wcJsbupjno5zKAFMUU3GaKJK19eFpeRQWpdERlxUiKaxvcIU26nwatE/+HLeKBiySiuty4iC7L+Hso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300964; c=relaxed/simple;
	bh=09psgg/FDIgxF3WszEeFUp1upo+WVfhoS0WFJ5ThPzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1dCaj962hkg+cKF8xmnTVcWk5stRk6wMCiz6GkIhVoZGjlqF6pmpORFM9xoaxVcykeFUf7+PqPhBVbg+eYRBLDkSAjIVf4NQv27/Edp6IuwGB/E/nQWsuR/1hBQqNZumBj5nt0BHFOE8wUGI3lpp+ta+zsM2y57+XbcITA1J2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTauZgz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4DEC4CEE7;
	Thu, 15 May 2025 09:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747300963;
	bh=09psgg/FDIgxF3WszEeFUp1upo+WVfhoS0WFJ5ThPzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTauZgz0HZn5DsUlIaSxS6Xagzd8AziP1XStFm3Jt2dV4YjGOu9KP03KWV4m6zbJ+
	 gqotrf1hy/DvzOr0lZM+qJqdGHXc7Ba6/mpIYabCJ6C2+7Wq20OLC4PgviEMxPTgDP
	 jW4nVGr0cnat8geUD0HXFabpdw/rlcUWoWPzg3nS98yclZsWwJe7NA78HZjk1po9wD
	 9MEcTnDm/CAXzP70gJ8W91+zk6bKs9bomcr2TYd3IhN/8gfMzPTu9/teIkz1Jtt8SG
	 ydnVS1OhJZHd4YSgFgLI5Zi/fONKW2vnuOoJ6XxyXptZLg71PyXThuRKnHD51rN1Sp
	 E2OG/W1aflNVg==
Date: Thu, 15 May 2025 11:22:38 +0200
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v6 0/2] Add `devm_dma_request_chan()` to simplify probe
 path in atmel-quadspi.c
Message-ID: <aCWyXsJ2iRXRUmOi@finisterre.sirena.org.uk>
References: <20250515083132.255410-1-csokas.bence@prolan.hu>
 <aCWpjplhAXUvr9fj@finisterre.sirena.org.uk>
 <e4e6c7a9-9b7a-4012-8bda-75804229ec95@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lsS54prYZ+c1tDdi"
Content-Disposition: inline
In-Reply-To: <e4e6c7a9-9b7a-4012-8bda-75804229ec95@prolan.hu>
X-Cookie: Well begun is half done.


--lsS54prYZ+c1tDdi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 11:14:22AM +0200, Cs=F3k=E1s Bence wrote:
> On 2025. 05. 15. 10:45, Mark Brown wrote:

> > I can't tell what the plan is here, or what the status is for the first
> > patch (since I'm not CCed).  The second patch depends on a new API
> > introduced in the first patch so it can't be merged independently.

> Yes, the situation is a bit convoluted. Obviously 2/2 will be applied aft=
er
> 1/2, in a similar vein than the former PM series.

> So what I was trying to say: Vinod should be able to apply 1/2 to his bra=
nch
> (dma/next) right now, which can then be merged to spi/for-next. This merg=
ed
> branch should be able to then cleanly apply 2/2.

I wouldn't expect to pull the whole DMA tree in, that'll have a huge
amount of extra stuff in it - if I was going to pull something I'd
expect a topic branch.  Wouldn't it be simpler for me to just apply both
patches at this point if there's no conflicts with the DMA tree?  We're
at -rc6 now...

--lsS54prYZ+c1tDdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmglsl0ACgkQJNaLcl1U
h9CkSQf/aHhDgShaJOuGnP6gxQePQyEyifKpyjggCAaRO0Sesc+kJpLP+WmA0tu5
zR8dncLAeFAWIhOnoiv/TvWp37UG0ZMzmoMeVYSzQNijpT1i3K3Hj59K/7Xj7pOY
DfM+te9RzU6zFCqQCBsG/HzrtmN135ZWSITtrqSZIMerQPzwj1gRxn739aVsdeEu
uMpbZiLJ5kCiQrzKGo8Ixui87RlSho7whEs38ryCVpHsHdKIqHhu6KdqbAIdtbse
o9sgfNAOjjua7YHhcNiEqCmUoj9cbzMjXA8YAYuWXfJwj4w8bys8xRCi3nGF7zXc
nVbkjKLI5vJuum8GbeDZrTefcfktBw==
=bjGy
-----END PGP SIGNATURE-----

--lsS54prYZ+c1tDdi--

