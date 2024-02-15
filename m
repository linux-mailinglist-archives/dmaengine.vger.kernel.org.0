Return-Path: <dmaengine+bounces-1021-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A6856DD2
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 20:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8C51F2728A
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1813A885;
	Thu, 15 Feb 2024 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcxBanyL"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9C1386AE;
	Thu, 15 Feb 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025685; cv=none; b=gaQrmeVk1pLVDo2rhRRGIdgMoBcEfe856gzg3pLXd5lKSX+aT3dT5aSRBmFgzXX9jCBMDoTD6bDRf86fSCohxhs1tr1kDojGCK4uNldLvMlKsqWHQ61LSQPReQ5nPx3OnejUB8FHmCcyD4TKmpAzAarH5/+VELCQcOzrNThE5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025685; c=relaxed/simple;
	bh=yRnLyISh3ozdfGzOQyeO/YUOe2fAUcXlNVFlHde4M6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8JKyHnbp8JR0XmavFbLGW2e7DBZiIiyUqfxabCczRpW24VXAoIPEkSPXWROAKZEVZLxA98MOYuvLTEH3b+qeDA/Twr7C45siYm23ZfB7x2jiAriJrG+6+DWAl9n7vx9wGh75Dby8uUiA5UR0WSqat9rUpZnJerS1Ot3LMqvZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcxBanyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D989C433C7;
	Thu, 15 Feb 2024 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708025684;
	bh=yRnLyISh3ozdfGzOQyeO/YUOe2fAUcXlNVFlHde4M6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcxBanyLQEEN6fX42vS/bUklK63T/N6Rwy5XBP0I5CnNlTL7f1HtGGJLePgvd/uO4
	 3/1JJYefxII4USHvReXc3uKbI2dZgEGsyR4smQXzrUvoXR0P9jhtBchK1CUhwMwKo3
	 QZP5/c37D/Zg1bI4rE7nO7Ur+AUmtAC7i/CWwbHzKQ2/6tq3pKNSAEe+5rVphEXPdr
	 2h5lbxOXn8jZCGwUELfWVzg0X9A0h3p+JOXzR2TRL3GUicxZ83I26A5/v5bdYKNfHi
	 QtkONIKQdtF3KlCs8Z/XOKqRn/J8mYzjWShJAk9KwLh0HemfW92ggpIDKpPVWJdf/8
	 YK1J1J8qEQZbQ==
Date: Thu, 15 Feb 2024 19:34:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: convert atmel-xdma.txt to YAML
Message-ID: <20240215-snowstorm-quack-fdb7f9c35c2e@spud>
References: <20240215-xdma-v1-1-1139960cf096@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2uNUAPuRLcz3Tc2D"
Content-Disposition: inline
In-Reply-To: <20240215-xdma-v1-1-1139960cf096@microchip.com>


--2uNUAPuRLcz3Tc2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 04:25:15PM +0530, Durai Manickam KR wrote:
> Added a description, required properties and appropriate compatibles
> for all the SoCs that are supported by microchip for the XDMAC.
>=20
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  .../devicetree/bindings/dma/atmel-xdma.txt         | 54 ---------------
>  .../bindings/dma/microchip,at91-xdma.yaml          | 77 ++++++++++++++++=
++++++
>  2 files changed, 77 insertions(+), 54 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Docum=
entation/devicetree/bindings/dma/atmel-xdma.txt
> deleted file mode 100644
> index 76d649b3a25d..000000000000
> --- a/Documentation/devicetree/bindings/dma/atmel-xdma.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -* Atmel Extensible Direct Memory Access Controller (XDMAC)
> -
> -* XDMA Controller

> -- interrupts: Should contain DMA interrupt.
> -- #dma-cells: Must be <1>, used to represent the number of integer cells=
 in
> -the dmas property of client devices.
> -  - The 1st cell specifies the channel configuration register:
> -    - bit 13: SIF, source interface identifier, used to get the memory
> -    interface identifier,
> -    - bit 14: DIF, destination interface identifier, used to get the per=
ipheral
> -    interface identifier,
> -    - bit 30-24: PERID, peripheral identifier.
> -
> -Example:
> -
> -dma1: dma-controller@f0004000 {
> -	compatible =3D "atmel,sama5d4-dma";
> -	reg =3D <0xf0004000 0x200>;
> -	interrupts =3D <50 4 0>;
> -	#dma-cells =3D <1>;
> -};
> -
> -
> -* DMA clients
> -DMA clients connected to the Atmel XDMA controller must use the format
> -described in the dma.txt file, using a one-cell specifier for each chann=
el.
> -The two cells in order are:
> -1. A phandle pointing to the DMA controller.
> -2. Channel configuration register. Configurable fields are:
> -    - bit 13: SIF, source interface identifier, used to get the memory
> -    interface identifier,
> -    - bit 14: DIF, destination interface identifier, used to get the per=
ipheral
> -    interface identifier,
> -  - bit 30-24: PERID, peripheral identifier.
> -
> -Example:
> -
> -i2c2: i2c@f8024000 {
> -	compatible =3D "atmel,at91sam9x5-i2c";
> -	reg =3D <0xf8024000 0x4000>;
> -	interrupts =3D <34 4 6>;
> -	dmas =3D <&dma1
> -		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> -		 | AT91_XDMAC_DT_PERID(6))>,
> -	       <&dma1
> -		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
> -		| AT91_XDMAC_DT_PERID(7))>;
> -	dma-names =3D "tx", "rx";
> -};
> diff --git a/Documentation/devicetree/bindings/dma/microchip,at91-xdma.ya=
ml b/Documentation/devicetree/bindings/dma/microchip,at91-xdma.yaml
> new file mode 100644
> index 000000000000..0bd79c7b5e6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/microchip,at91-xdma.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/microchip,at91-xdma.yaml#

Filename matching a compatible please.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Extensible Direct Memory Access Controller (XDMAC)
> +
> +maintainers:
> +  - Durai Manickam KR <durai.manickamkr@microchip.com>
> +
> +description: |

The | is not needed, you've no formatting to preserve.

> +  The Atmel Extensible Direct Memory Access Controller (XDMAC) performs =
peripheral
> +  data transfer and memory move operations over one or two bus ports thr=
ough the
> +  unidirectional communication channel. Each channel is fully programmab=
le and
> +  provides both peripheral or memory-to-memory transfers.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - atmel,sama5d4-dma
> +          - microchip,sama7g5-dma
> +          - microchip,sam9x7-dma

The text binding says:
> -- compatible: Should be "atmel,sama5d4-dma", "microchip,sam9x60-dma" or
> -  "microchip,sama7g5-dma" or
> -  "microchip,sam9x7-dma", "atmel,sama5d4-dma".
That's not what you have here at all.

> +      - items:
> +          - const: atmel,sama5d4-dma
> +          - const: microchip,sam9x60-dma

This looks backwards.

> +  reg:
> +    description: Should contain DMA registers location and length.
> +    maxItems: 1

Same comments here about descriptions for well known properties as the
other DMA controller.

> +
> +  interrupts:
> +    description: Should contain the DMA interrupts associated to the DMA=
 channels.
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    description: |
> +      Must be <1>, used to represent the number of integer cells in the =
dmas
> +      property of client device.
> +      -The 1st cell specifies the channel configuration register:
> +      -bit 13: SIF, source interface identifier, used to get the memory
> +               interface identifier,
> +      -bit 14: DIF, destination interface identifier, used to get the pe=
ripheral
> +               interface identifier,
> +      -bit 30-24: PERID, peripheral identifier.
> +    const: 1
> +
> +  clocks:
> +    description: Should contain a clock specifier for each entry in cloc=
k-names.
> +    maxItems: 1

And here about adding properties. Please explain in your commit message
where the new properties came from.

> +
> +  clock-names:
> +    description: Should contain the clock of the DMA controller.
> +    const: dma_clk
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma0: dma-controller@f0004000 {

And same here about the label :)

Cheers,
Conor.

> +            compatible =3D "atmel,sama5d4-dma";
> +            reg =3D <0xffffec00 0x200>;
> +            interrupts =3D <50 4 0>;
> +            #dma-cells =3D <1>;
> +            clocks =3D <&pmc 2 20>;
> +            clock-names =3D "dma_clk";
> +    };
> +
> +...
>=20
> ---
> base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
> change-id: 20240215-xdma-36e8bdbf8141
>=20
> Best regards,
> --=20
> Durai Manickam KR <durai.manickamkr@microchip.com>
>=20

--2uNUAPuRLcz3Tc2D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5nTwAKCRB4tDGHoIJi
0mWeAQDyxMRExEs8PvvE6a8W3mU1c68idO13L6qbJOJZzZggbwD+PeCtNY1Irgpl
9q5poFzXZZ7w/mux7+IUq6SBm6lUzA4=
=pFvp
-----END PGP SIGNATURE-----

--2uNUAPuRLcz3Tc2D--

