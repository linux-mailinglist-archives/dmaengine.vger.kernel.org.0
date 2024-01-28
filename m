Return-Path: <dmaengine+bounces-840-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D329A83F542
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jan 2024 12:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74BFAB21B45
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jan 2024 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2901F958;
	Sun, 28 Jan 2024 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgdmjXpE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634341F93F;
	Sun, 28 Jan 2024 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706442737; cv=none; b=Iu/semMTlUlZmlAtaFzsYK/Bqhrw39yu1tf2VK03sllq6I+kfIpXcV/8ExN15jcTJbbTC3nKGRWDZgSH5zqcn0OX4SzCmFPqQgESqZzzl9e/jxWAQBzolCrSJbQn7U9xOiEs4Cvmm8QjDsN/1YA3LsSIpUHsspbwk9KUjzRoAuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706442737; c=relaxed/simple;
	bh=DWUruREuV56XioT1JmC92e6/6xkEVGX5lxDBmEj2D5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkHWIc9GEBc6xahxElnudEOkk6bLQAMo9WknvNxbLmBj3Hu7RThGf4OjLSkgw6S0XNcPCyZnS5bPnvTqSKmIAMpvwPH/nPE4IuadEcMmWLqYnzGEo/O5b6GMzCmAmppscamXQ9pyUERvfVGcRGDxbGh0IehtjvH7sqh7guoQ/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgdmjXpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDBAC433F1;
	Sun, 28 Jan 2024 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706442737;
	bh=DWUruREuV56XioT1JmC92e6/6xkEVGX5lxDBmEj2D5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgdmjXpEgJk67VqXsN/zDeYuy0OptjdBSDw39FktwLwmTqcsAoSXpRBIBZANfLehK
	 wy0KUZpPdmxNMndX0pwFTw7Jx+E+kfY3XLYOjoOhF53V9fvHsi1rpt+o/JdeZ3q4PL
	 QVaIy6eLbpaJFs6lb/khwIApPWmj9Vnc2bjguARZf44nwF4aYCKRjXZtjK4TsHwyE6
	 6rGM6LQwsRH7yjVCbi49/Q91TJ7IZnjr6aCZrKuVXe3X096FKxVoAHletP2Z8qk8w2
	 4QH8DEiibMl4buLDDW+iJnc7J3Qz4sofy/fIRqLDsk/QZ1XifrU495T3cyDxU7rkcb
	 aZzkivNci53Iw==
Date: Sun, 28 Jan 2024 11:52:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] dt-bindings: dma: allwinner,sun50i-a64-dma: Add
 compatible for H616
Message-ID: <20240128-lumber-turban-a32709039bca@spud>
References: <20240127163247.384439-1-wens@kernel.org>
 <20240127163247.384439-5-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3filDIpPgYvC6Gxr"
Content-Disposition: inline
In-Reply-To: <20240127163247.384439-5-wens@kernel.org>


--3filDIpPgYvC6Gxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 12:32:44AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The DMA controllers found on the H616 and H618 are the same as the one
> found on the A100. The only difference is the DMA endpoint (DRQ) layout.
>=20
> Since the number of channels and endpoints are described with additional
> generic properties, just add a new H616-specific compatible string and
> fallback to the A100 one.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> Changes since v1:
> - Switch to "contains" for if-properties statement
> - Fall back to A100 instead of H6
>=20
>  .../bindings/dma/allwinner,sun50i-a64-dma.yaml       | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-d=
ma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.ya=
ml
> index ec2d7a789ffe..0f2501f72cca 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> @@ -28,6 +28,9 @@ properties:
>        - items:
>            - const: allwinner,sun8i-r40-dma
>            - const: allwinner,sun50i-a64-dma
> +      - items:
> +          - const: allwinner,sun50i-h616-dma
> +          - const: allwinner,sun50i-a100-dma
> =20
>    reg:
>      maxItems: 1
> @@ -59,10 +62,11 @@ required:
>  if:
>    properties:
>      compatible:
> -      enum:
> -        - allwinner,sun20i-d1-dma
> -        - allwinner,sun50i-a100-dma
> -        - allwinner,sun50i-h6-dma
> +      contains:
> +        enum:
> +          - allwinner,sun20i-d1-dma
> +          - allwinner,sun50i-a100-dma
> +          - allwinner,sun50i-h6-dma
> =20
>  then:
>    properties:
> --=20
> 2.39.2
>=20

--3filDIpPgYvC6Gxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbY/5wAKCRB4tDGHoIJi
0s+/AQDVwz+WvIMq2mM9erSGJtAYznAC59P2JyZJYmURWme/qQD/fGChAVqdsgui
AX8DW7Jlp09pnmhWFzpPSLMz9MyJfg0=
=hlqD
-----END PGP SIGNATURE-----

--3filDIpPgYvC6Gxr--

