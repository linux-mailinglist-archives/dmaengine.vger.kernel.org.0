Return-Path: <dmaengine+bounces-4044-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EAA9F84AA
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 20:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B11116B391
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 19:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C061A9B32;
	Thu, 19 Dec 2024 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hrgewuum"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F0155342;
	Thu, 19 Dec 2024 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734637587; cv=none; b=I1/oO6mFbL+35IFWIQ/EOH3t8D5LgP1FEy1ZFKM8dUvwzEqYneW0Zf2dpCT5drlBopP7JTS/F+Ul2elc+Jht8YgSB7MNtIGGZ0HwFoCFZ6SZQF3dP6xaxxi4K95mhG2eQ9zmjXoopwLbw/Og6Ol8mo0ao0xQejjyMSsXwy938wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734637587; c=relaxed/simple;
	bh=/yKlAn4q9y+NKelA/FCmuub7mWVPyF1ED2mjrCwazvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+r7Ha2lSkjFoaYRYkl0978O82z0jbYavTZ51DmTFyYm3bJExYGIjvsrqT/qtGUJwRGYSKny7ChBWjHVAHBELHk9njl9H7djGVCG+Jl6tulPVpWjvyJPhWtlnhsl5sWfLzd8sPipfX6RgbncuDLvmEmUboJc5hQWp7uxhOSEO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hrgewuum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009BBC4CECE;
	Thu, 19 Dec 2024 19:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734637586;
	bh=/yKlAn4q9y+NKelA/FCmuub7mWVPyF1ED2mjrCwazvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HrgewuumJXxYLkI/WyOw1o1FeQccEqymQxr6LRtaWurLQsPTKxv+e5AwcLe27UXSj
	 YOiNzcaYRhTppbMVLC9mPJjjLw0dH7M6VHxyfrD7xSjkJYvk6IhAinShdQThVTVy68
	 UVfMVkzG+8gU6bOE0P8VixxV8w433ItYZUJ5ljUAkGeGmiS2XFIuepvnL8SNAPf1Dq
	 jd6L1WYKK/kx4AnNMDT3vg+OdMn5ReMk3E3HlrLRock+xQwZMLvXwgH/4qzqsdA2Dt
	 zNxJp0hthnBQ5J73iB8mz0TilHggGZ1FlMp+Bu+9moKDjHb84sRCB+yN7EMvUbYFVy
	 JosA4YeQ62KSw==
Date: Thu, 19 Dec 2024 19:46:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Larisa Grigore <larisa.grigore@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	s32@nxp.com, Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: dma: fsl-edma: add nxp,s32g2-edma
 compatible string
Message-ID: <20241219-flirt-gab-dbacc809cca4@spud>
References: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
 <20241219102415.1208328-4-larisa.grigore@oss.nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b4mx9kuD5NC/YPny"
Content-Disposition: inline
In-Reply-To: <20241219102415.1208328-4-larisa.grigore@oss.nxp.com>


--b4mx9kuD5NC/YPny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 12:24:12PM +0200, Larisa Grigore wrote:
> Introduce the compatible strings 'nxp,s32g2-edma' and 'nxp,s32g3-edma' to
> enable the support for the eDMAv3 present on S32G2/S32G3 platforms.
>=20
> The S32G2/S32G3 eDMA architecture features 32 DMA channels. Each of the
> two eDMA instances is integrated with two DMAMUX blocks.
>=20
> Another particularity of these SoCs is that the interrupts are shared
> between channels in the following way:
> - DMA Channels 0-15 share the 'tx-0-15' interrupt
> - DMA Channels 16-31 share the 'tx-16-31' interrupt
> - all channels share the 'err' interrupt
>=20
> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,edma.yaml     | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Docume=
ntation/devicetree/bindings/dma/fsl,edma.yaml
> index d54140f18d34..4f925469533e 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -26,9 +26,13 @@ properties:
>            - fsl,imx93-edma3
>            - fsl,imx93-edma4
>            - fsl,imx95-edma5
> +          - nxp,s32g2-edma
>        - items:
>            - const: fsl,ls1028a-edma
>            - const: fsl,vf610-edma
> +      - items:
> +          - const: nxp,s32g3-edma
> +          - const: nxp,s32g2-edma
> =20
>    reg:
>      minItems: 1
> @@ -221,6 +225,36 @@ allOf:
>        properties:
>          power-domains: false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,s32g2-edma

Your property ordering below is a bit odd, but it matches what exists
currently so
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: dmamux0
> +            - const: dmamux1
> +        interrupts:
> +          minItems: 3
> +          maxItems: 3
> +        interrupt-names:
> +          items:
> +            - const: tx-0-15
> +            - const: tx-16-31
> +            - const: err
> +        reg:
> +          minItems: 3
> +          maxItems: 3
> +        "#dma-cells":
> +          const: 2
> +        dma-channels:
> +          const: 32
> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.47.0
>=20

--b4mx9kuD5NC/YPny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2R4DQAKCRB4tDGHoIJi
0hnoAP96Hinx+4A5/mpFd+0F0Z4+SQ+5s5nXXR8/PUeQRrFoCgEAzNky6HWb+Mp2
FawjONnWoqiSjHEGEwKYMSRodQVNVgY=
=qSZ7
-----END PGP SIGNATURE-----

--b4mx9kuD5NC/YPny--

