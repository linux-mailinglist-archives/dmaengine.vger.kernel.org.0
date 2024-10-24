Return-Path: <dmaengine+bounces-3483-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB13A9AECA8
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 18:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E901F22F95
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2024 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0DD1F81B9;
	Thu, 24 Oct 2024 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrqSXV9k"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8A11F76DA;
	Thu, 24 Oct 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788732; cv=none; b=uxafxieP6aQ/TkBIHNOb/JjvBTZNUWQPC3FmHVqzdmCiueVDotGAMYvR1BTXbAmwDamoPGOwbndiZ/tM1V/v0O8dydyPSlg8jpK2vxwLzKA9pFkwmYBp18T6RQGcRmz6YA6n8i+tI1KCGrb6Qw78XrqgmbjQxmaXgtAJgHuN3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788732; c=relaxed/simple;
	bh=r3tslcMdhzBd/TeShHIMCrP8oQyKFhtQOLSCSOVBUHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2c83hcpqrOKJ4teMouGsZAZHZrQiLR1tRHymoIhe8mRGw89jg+IFuEbRuMHDdlZdyEyc5QHWihpVQJ59KDW9u8kDxEfXaAv3rrnTGPuI79TFRXXvxH+HHrzjAXpXebT6Gl1vXvvWzFNV3CmK3zPYnrD44Z2rJMojYEDYI3lMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrqSXV9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352A2C4CEC7;
	Thu, 24 Oct 2024 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729788731;
	bh=r3tslcMdhzBd/TeShHIMCrP8oQyKFhtQOLSCSOVBUHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrqSXV9kUF3TqpF51VSGPHx7GUuoHwWa106yRznXQL0hWK/fa6CC6cMUWYAHASav/
	 QxMfRcVTwt5oIBZO05VyaH0YLS9TF9Lu57YmrLN/GLMOh0xI6KQGK1v4s3nleucnTf
	 xKpxu3R4l/xcluPYtRg8/OFi1ZGVQFuB7Puzyq0IWBHl0isJCZae7iwDIKyAoVRESx
	 3HXiAZLMe7jAN7S71KzIhfapz4Z28x4X6Wj8oZju+pLZJpohL2KojYHbfSDtI3Rnip
	 E7YNpC2kld+KtMQNCjUspX65R4EDUUfn4mfN0qexDQobOS3Su+5pNMWiLE4hykD1cI
	 MpiuxpYRQ2AGw==
Date: Thu, 24 Oct 2024 17:52:05 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 03/10] dt-bindings: dmaengine: Add Allwinner suniv
 F1C100s DMA
Message-ID: <20241024-recycler-borrowing-5d4296fd4a56@spud>
References: <13ab5cec-25e5-4e82-b956-5c154641d7ab@prolan.hu>
 <20241024064931.1144605-4-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CqzdtQmyY58U3O5U"
Content-Disposition: inline
In-Reply-To: <20241024064931.1144605-4-csokas.bence@prolan.hu>


--CqzdtQmyY58U3O5U
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 08:49:24AM +0200, Cs=F3k=E1s, Bence wrote:
> Add compatible string for Allwinner suniv F1C100s DMA.

> [ csokas.bence: reimplemented in YAML ]

This implies you took someone else's work and modified it, so I would
expect to see them mentioned here. However, I don't personally think a
compatible name is copyrightable and would suggest just dropping this.

<2 minutes later> I checked the rest of the series, you've got a lot of
missing signoffs from yourself on other patches. You sent them, so you
need to sign off even if you didn;t author them.

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Cs=F3k=E1s, Bence <csokas.bence@prolan.hu>
> ---
>  .../devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dm=
a.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
> index 02d5bd035409..9b5180c0a7c4 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml
> @@ -22,7 +22,9 @@ properties:
>        number.
> =20
>    compatible:
> -    const: allwinner,sun4i-a10-dma
> +    enum:
> +      - allwinner,sun4i-a10-dma
> +      - allwinner,suniv-f1c100s-dma
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20
>=20

--CqzdtQmyY58U3O5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxp7NQAKCRB4tDGHoIJi
0kVVAQDIf6oJhRhzclI1CTid5giOG/kvB2MGrzj6VU6YX5l7agD/fGR3sowa78na
7GbS6JuJbow5pjzpsrjPdU2IMejCogo=
=6eZ/
-----END PGP SIGNATURE-----

--CqzdtQmyY58U3O5U--

