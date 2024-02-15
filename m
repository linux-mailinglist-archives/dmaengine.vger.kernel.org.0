Return-Path: <dmaengine+bounces-1020-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7F5856DB2
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 20:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53ACD1F26AB8
	for <lists+dmaengine@lfdr.de>; Thu, 15 Feb 2024 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEE313959D;
	Thu, 15 Feb 2024 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESSBPCq6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF04369A;
	Thu, 15 Feb 2024 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025278; cv=none; b=TDs1FiGK95YqX0ZFMsapsiNuBtT2YedLcDdc6wveNMUHHyVj+i9r5j5BiFx2TEPRg6p1Otboyi1PB6udFJ2isGsxW4OkQ3MYMecntPXyt1qVNPhw6wl4VOslfAVx9IrtL0SFPzCOPkQrDKOcqP7FUfv7GPN1fGgESCAxcPjCYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025278; c=relaxed/simple;
	bh=B78tA8mwIJHcwuf2kjNoy1MeVZF1wEVHnLOpPqSiT6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/YL5jQO0ffedJKpRONiTKUqCKsv+aCSskkD9BY8lWIoWqnTljHb0hRDEOut9rSkbfq759C3EDJcDEZzhYsNsOOGno4k75nthjzL61Yh3prZz7QRogOAf6OVHp9hnzLcd6nRYmpYc4qw+OKYz+GNEBAzzpx8EsrSMPNIOgtFfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESSBPCq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCCBC433C7;
	Thu, 15 Feb 2024 19:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708025277;
	bh=B78tA8mwIJHcwuf2kjNoy1MeVZF1wEVHnLOpPqSiT6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESSBPCq6Mv09IKJYpnk+10FnNRAqmX1wv+FDoOylq3zXzhHDIPbmL35QKW0qOOL44
	 e/MzsY4QXAz1EBrUnfP+RPWibnwRFcVMHII27qacd/1jKbv5aG798jc0ED5ClHO1oB
	 1bAYTYN2OCUi2AiusQ1IKRcW1YUaurJBuqCtM7nnOJiBU+jk9dbp5lTLueW4HiUNqV
	 ZBboK1JdCnD/aiNj4rV0m9f40N6LhfN2pK9AGCsvnz/LP7lUJX+Pi3a7PA9M8I5tHn
	 6HeSZBPQRabsIAgV89MOfsnO6E5Ns4GQF4nNMfG5WMHWoqfAujfDYccHMO9a261IvL
	 cMdGdzThwyXSg==
Date: Thu, 15 Feb 2024 19:27:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Durai Manickam KR <durai.manickamkr@microchip.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: convert atmel-dma.txt to YAML
Message-ID: <20240215-broken-emu-64a6dabc43e2@spud>
References: <20240215-dmac-v1-1-8f1c6f031c98@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/iXZ72FAuAF0yk9f"
Content-Disposition: inline
In-Reply-To: <20240215-dmac-v1-1-8f1c6f031c98@microchip.com>


--/iXZ72FAuAF0yk9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 04:15:44PM +0530, Durai Manickam KR wrote:
> Added a description, required properties and appropriate compatibles
> for all the SoCs that are supported by microchip.
>=20
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> ---
>  .../devicetree/bindings/dma/atmel-dma.txt          | 42 -------------
>  .../bindings/dma/microchip,at91-dma.yaml           | 71 ++++++++++++++++=
++++++
>  2 files changed, 71 insertions(+), 42 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/atmel-dma.txt b/Docume=
ntation/devicetree/bindings/dma/atmel-dma.txt
> deleted file mode 100644
> index f69bcf5a6343..000000000000
> --- a/Documentation/devicetree/bindings/dma/atmel-dma.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -* Atmel Direct Memory Access Controller (DMA)
> -
> -Required properties:
> -- compatible: Should be "atmel,<chip>-dma".
> -- reg: Should contain DMA registers location and length.
> -- interrupts: Should contain DMA interrupt.
> -- #dma-cells: Must be <2>, used to represent the number of integer cells=
 in
> -the dmas property of client devices.
> -
> -Example:
> -
> -dma0: dma@ffffec00 {
> -	compatible =3D "atmel,at91sam9g45-dma";
> -	reg =3D <0xffffec00 0x200>;
> -	interrupts =3D <21>;
> -	#dma-cells =3D <2>;
> -};
> -
> -DMA clients connected to the Atmel DMA controller must use the format
> -described in the dma.txt file, using a three-cell specifier for each cha=
nnel:
> -a phandle plus two integer cells.
> -The three cells in order are:
> -
> -1. A phandle pointing to the DMA controller.
> -2. The memory interface (16 most significant bits), the peripheral inter=
face
> -(16 less significant bits).
> -3. Parameters for the at91 DMA configuration register which are device
> -dependent:
> -  - bit 7-0: peripheral identifier for the hardware handshaking interfac=
e. The
> -  identifier can be different for tx and rx.
> -  - bit 11-8: FIFO configuration. 0 for half FIFO, 1 for ALAP, 2 for ASA=
P.
> -
> -Example:
> -
> -i2c0@i2c@f8010000 {
> -	compatible =3D "atmel,at91sam9x5-i2c";
> -	reg =3D <0xf8010000 0x100>;
> -	interrupts =3D <9 4 6>;
> -	dmas =3D <&dma0 1 7>,
> -	       <&dma0 1 8>;
> -	dma-names =3D "tx", "rx";
> -};
> diff --git a/Documentation/devicetree/bindings/dma/microchip,at91-dma.yam=
l b/Documentation/devicetree/bindings/dma/microchip,at91-dma.yaml
> new file mode 100644
> index 000000000000..a0a582902e4d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/microchip,at91-dma.yaml

Filename matching the compatible please.

> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/microchip,at91-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Direct Memory Access Controller (DMA)
> +
> +maintainers:
> +  - Ludovic Desroches <ludovic.desroches@microchip.com>
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
> +
> +description: |

The | is not needed.

> +  The Atmel Direct Memory Access Controller (DMAC) transfers data from a=
 source
> +  peripheral to a destination peripheral over one or more AMBA buses. On=
e channel
> +  is required for each source/destination pair. In the most basic config=
uration,
> +  the DMAC has one master interface and one channel. The master interfac=
e reads
> +  the data from a source and writes it to a destination. Two AMBA transf=
ers are
> +  required for each DMAC data transfer. This is also known as a dual-acc=
ess transfer.
> +  The DMAC is programmed via the APB interface.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - atmel,at91sam9g45-dma
> +          - atmel,at91sam9rl-dma
> +  reg:
> +    description: Should contain DMA registers location and length.

Drop the description from these common properties.

> +    maxItems: 1
> +
> +  interrupts:
> +    description: Should contain the DMA interrupts associated to the DMA=
 channels.
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    description:
> +      Must be <2>, used to represent the number of integer cells in the =
dmas
> +      property of client devices.

You've lost the description of how these cells work, which is somewhat
unique and needs to be preserved.
This is the only property that needs a description.

> +    const: 2
> +
> +  clocks:
> +    description: Should contain a clock specifier for each entry in cloc=
k-names.
> +    maxItems: 1
> +
> +  clock-names:
> +    description: Should contain the clock of the DMA controller.
> +    const: dma_clk

This is a new addition? You should call out in the commit message wat
you've added that was not in th text binding.

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
> +    dma0: dma-controller@ffffec00 {

Drop the label, its not used.

Thanks,
Conor.

> +            compatible =3D "atmel,at91sam9g45-dma";
> +            reg =3D <0xffffec00 0x200>;
> +            interrupts =3D <21>;
> +            #dma-cells =3D <2>;
> +            clocks =3D <&pmc 2 20>;
> +            clock-names =3D "dma_clk";
> +    };
> +
> +...
>=20
> ---
> base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
> change-id: 20240214-dmac-5f48fd7f3b9d
>=20
> Best regards,
> --=20
> Durai Manickam KR <durai.manickamkr@microchip.com>
>=20

--/iXZ72FAuAF0yk9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5luAAKCRB4tDGHoIJi
0pZ7AP9n//Tc16Y7sathkrqYZctgnGZndX8EG6lO9YREEHFWSgEA9A8snBLnm4Gz
wPMTjmPK3L6Re/0FWReZcHxvibMJeAU=
=4pGP
-----END PGP SIGNATURE-----

--/iXZ72FAuAF0yk9f--

