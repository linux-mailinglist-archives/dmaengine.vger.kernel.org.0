Return-Path: <dmaengine+bounces-5176-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C64AB8143
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 10:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA259E07AA
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011C5283FC3;
	Thu, 15 May 2025 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFv3CN6R"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7415288508;
	Thu, 15 May 2025 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298707; cv=none; b=im1Y2vwu6t4b9Ukt9bS7JSKQqqLMbGL8MJZscJ2w9jdAasvVZCw/UsgQ1l6rrmXs92tCJ1xGTjK7gt7EtnpRsRRXUx8hVMXZnry4/J1RFQilkkyXzj7KsnmfnmrWJtY+0Toyo7ULGIojBr7n+xl5eSvzVVc8iBArWq4O/KcBlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298707; c=relaxed/simple;
	bh=SEgT+ObynvSN+V3bQsdKbGCKxjclg4N/cQwSPBeFXNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiNHNWplZrncsPnkcbGJOAvqAjkeYRZvz825FDOrGRKyFehbsmMuG/8Vs8UZztCJL80GKKiwtI/kzEcmwUhxgplnmWW/NyDPaWvE3ikICeyrVHsAWFMXPQyqcF6zaT4JcXW9JguGUToC/ukey9mOf4tGmoC0m6ZjgyzQMVCaiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFv3CN6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B22C4CEE7;
	Thu, 15 May 2025 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747298707;
	bh=SEgT+ObynvSN+V3bQsdKbGCKxjclg4N/cQwSPBeFXNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RFv3CN6RVuD3ZWfspaJ6Nbe4PN+U/ZhA10RKSVE21YGj3E/0I5Jv+9TR+YVUdUAUC
	 xSEGqo2J3PayIZLfGF8jIfq7LB7VJdgOiqVy6NJ2ldnAfkv/xnBg+ArFnTXJwOcLNS
	 MNyJCtcDvhnQPfAmcNz445xrxRJh7yLA1h04kLSrJiLGVrPGr6Lav4jdjyp2VBPPW+
	 G2RXqtm06alizQnWHnBxVs5TbuS2Qu/DW1jXqf7siUs0v87yyel8qVtAjpzrpwHeAQ
	 Paz449iCB4bMwoSkIdjz3DW3ooWQJtwpsbdN0nKkE4Cy4/3qVDNyViE1wjRSv7YeEs
	 tgX+yGPozcc4A==
Date: Thu, 15 May 2025 10:45:02 +0200
From: Mark Brown <broonie@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
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
Message-ID: <aCWpjplhAXUvr9fj@finisterre.sirena.org.uk>
References: <20250515083132.255410-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/tGn05cm9PgSmYgZ"
Content-Disposition: inline
In-Reply-To: <20250515083132.255410-1-csokas.bence@prolan.hu>
X-Cookie: Well begun is half done.


--/tGn05cm9PgSmYgZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 10:31:28AM +0200, Bence Cs=F3k=E1s wrote:

> Change in v4:
> * split PM imbalance fix (now merged) and DMA cleanup (this series)
> Change in v6:
> * rebase to spi/for-next, see note below:
>=20
> There is currently no difference in drivers/dma/dmaengine.c between it and
> dma/next [1], therefore PATCH 1/2 should be safe for Vinod to apply. But
> this way PATCH 2/2 is trivial to apply. I didn't want to pull the whole
> linux-next tree, but if any ofyou run into problems, let me know, and I'll
> rebase the series on it instead.

I can't tell what the plan is here, or what the status is for the first
patch (since I'm not CCed).  The second patch depends on a new API
introduced in the first patch so it can't be merged independently.

--/tGn05cm9PgSmYgZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmglqY0ACgkQJNaLcl1U
h9DFVQf/RG3qVgLW9iXPcAUZnHYKemB71ZgR+Yrj0yChBw9ccK7Ns8JmX1XBzjJ6
KHRzwnny3bbg2tsX5/n66nch3/Xfl98SRYHNnmeQQsKDAuehwMGDnCr7i5QNNzJ3
m0H0qoCgYrjoye1vqrIWHqzYnU8lhZS5ywzOKZfzS8UXs+I+6ZIc/u2AzSMg7f+f
YEaKmv2tch11ks57fRmyI9cqVu1nSBUrEHbn+/wxsleBaed2LURNQz0pO1547z+V
P6Y8zAxD4wGLQvSIPlU8+/b58zLeZmhIBf3eBKFNk2pXAHI3GpBmr68i9YbmrRGz
tH3l2/oUsumQn6krkGQ42z0TOmIddQ==
=HOSf
-----END PGP SIGNATURE-----

--/tGn05cm9PgSmYgZ--

