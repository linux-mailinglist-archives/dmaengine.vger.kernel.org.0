Return-Path: <dmaengine+bounces-797-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55AF8370D5
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 19:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81661C22C00
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 18:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F003E486;
	Mon, 22 Jan 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZVtshFo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028253D99D;
	Mon, 22 Jan 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947499; cv=none; b=ak2Az8aBRxEeTiBmyz9E79qbRVvPFQ08I+Ky1u1791seyrF9a11pOKziAFsYAVzSOunjZOQjThmCfshHVXtmeUliIEAXa9lbqzZQT9kdWXdo/KuEZCCYmTXgl2TtIfVmPs1ADSuZ4cFHFtuDVN/LET6O6Dgb2gbYALOJs2MCz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947499; c=relaxed/simple;
	bh=2usFrpfFbvgtllKuc13YKWjWHiLTD42R7HKFi/spe1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFmxQtwEqg8g6rUuZCY4C+NvxBlDMrbC/8fTPOV1rQ3rgHNvO7Gxr+s6jJ06/1cP6bypP0bOr6ExH2IRIvwNXeeSL+heRj9fizEA6GtjSGt/KuH/EfyGGxZR9Rb0qjryeePUWfeDiZuPW9ub/qOd3qcBe3hRESDlIjJ3tAQqIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZVtshFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9208C433F1;
	Mon, 22 Jan 2024 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947498;
	bh=2usFrpfFbvgtllKuc13YKWjWHiLTD42R7HKFi/spe1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZVtshFoH3qE8Y19hWmbNEnsrrQWORDUdoLvMqOpB8fuKw/mgCKX3F0AiOC5lDjD/
	 ip/FkCB0CCepVd83zeSbnpw476NSnJXYQZAkKcwACqPdF8vBthzE0RsLnzJ01we9Ic
	 ICmqpLjOU3sIMMQp1LVNs6Hpg6hZchZVa+2RMVgF7qTI5Ht5FDOtbuMeqxVD2gh1k9
	 GbkOACxvO3PIHVNWRIIBJljZbAIDi3UQ10E0gUKi+Xq+SNqTL7lBEGZ4lw9YcDKeLt
	 R4kS3B/h3x+DF05EQPPty7N61T7BmGXFz7POhZptSwXs6bR3MUkKBUjMf9YIOgMY7K
	 tAEp+jU0a7CtQ==
Date: Mon, 22 Jan 2024 18:18:12 +0000
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
Subject: Re: [PATCH 4/7] dt-bindings: dma: allwinner,sun50i-a64-dma: Add
 compatible for H616
Message-ID: <20240122-resemble-nearness-60dafde2e25d@spud>
References: <20240122170518.3090814-1-wens@kernel.org>
 <20240122170518.3090814-5-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uMkVNq/eMDtdcPET"
Content-Disposition: inline
In-Reply-To: <20240122170518.3090814-5-wens@kernel.org>


--uMkVNq/eMDtdcPET
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:05:15AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The DMA controllers found on the H616 and H618 are the same as the one
> found on the H6. The only difference is the DMA endpoint (DRQ) layout.
>=20
> Since the number of channels and endpoints are described with additional
> generic properties, just add a new H616-specific compatible string and
> fallback to the H6 one.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/dma/allwinner,sun50i-a64-dma.yaml    | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-d=
ma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.ya=
ml
> index ec2d7a789ffe..e5693be378bd 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> @@ -28,6 +28,9 @@ properties:
>        - items:
>            - const: allwinner,sun8i-r40-dma
>            - const: allwinner,sun50i-a64-dma
> +      - items:
> +          - const: allwinner,sun50i-h616-dma
> +          - const: allwinner,sun50i-h6-dma
> =20
>    reg:
>      maxItems: 1
> @@ -59,10 +62,14 @@ required:
>  if:
>    properties:
>      compatible:
> -      enum:
> -        - allwinner,sun20i-d1-dma
> -        - allwinner,sun50i-a100-dma
> -        - allwinner,sun50i-h6-dma
> +      oneOf:
> +        - enum:
> +            - allwinner,sun20i-d1-dma
> +            - allwinner,sun50i-a100-dma
> +            - allwinner,sun50i-h6-dma
> +        - items:
> +            - const: allwinner,sun50i-h616-dma
> +            - const: allwinner,sun50i-h6-dma

Instead of introducing this complexity, could you instead use "contains"
here? Unless I am missing soemthing, you can achieve the same thing here
with:
|if:
|  properties:
|    compatible:
|      constains:
|        enum:
|          - allwinner,sun20i-d1-dma
|          - allwinner,sun50i-a100-dma
|          - allwinner,sun50i-h6-dma

--uMkVNq/eMDtdcPET
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6xZAAKCRB4tDGHoIJi
0uhrAQCnxXs/YZMWmhTaL2/x37/8c6V1hW8i0Fcy+4pF/j9FagD+PzvoVb1uq4Xb
caz2uxuyDai5nYCpKQMlFDgQp1wcIgs=
=u1wG
-----END PGP SIGNATURE-----

--uMkVNq/eMDtdcPET--

