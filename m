Return-Path: <dmaengine+bounces-842-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3FB83F886
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jan 2024 18:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACEC1C21672
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jan 2024 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D6D288A7;
	Sun, 28 Jan 2024 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpNQvyge"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40792D044;
	Sun, 28 Jan 2024 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706462888; cv=none; b=VJA/hxeyunhTBfsV/QoaoTHfuERB6CgDYEi6sNJAeck25zz6KVwom0jXBFI8e0Ifty62zDHEri8krvW6U4erZwwBwL9uD/71QKjWbT5TWzxFCMEUbVmPqSYurRr4r+lqTDX/pv2crwvJFnGESV5XXqrJ5cDRRnrnV5iWZ7dVRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706462888; c=relaxed/simple;
	bh=d48xGCfdHgQFf8NpyiDWQFPtYzrREixBaUNB9/MDMRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFRmz5WzI8S2rd8RtQRNciMU22r2xVZKKT70PYyj0pp/2AkoLtTMETbwv+KTRCm+e/xavjF+m01Dg++w43qV2v8eZ6IBEiJKzyTFKazhJs1/lTIH6srh1uB7Pj3LTRBqNhWYEvut2SnakdDU6Y+5X6V5z7QAafCsDCShU3LEdfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpNQvyge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E493C433F1;
	Sun, 28 Jan 2024 17:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706462887;
	bh=d48xGCfdHgQFf8NpyiDWQFPtYzrREixBaUNB9/MDMRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpNQvygeP1kIb4jcRwrWzShjUPJi7+MCYpyhtJ6xVOF5HBZw61OUpGyi0kAO9Car+
	 i8BXxlXBSZEdxa+ZFt3ZTzETuYDEBMqBfl8HNDNGDNqa16AV8LIZP8m5EdZKl66edV
	 aY+qUJTj5D0yf+p1RI/ouX0UoERCqJCGYhHr7Xw6rfhtOLZUkzxg2o65vk8Ln0XpLz
	 0ODuet16dx/eY5UcEP8aKsS9XR9/WOQsdIC0ZVvmW2jS+d2KUwEWH2Q+V8cYqdkhNA
	 TyShHsrqj7XzwLJmYcUPUAxoSefLw+sHbxtvWbAbqLaShsOhXS7jm4uRfD5Nkcq57j
	 bekYc02qspRPA==
Date: Sun, 28 Jan 2024 17:28:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmp-dma: convert to YAML
Message-ID: <20240128-feminine-sulfite-8891c60ec123@spud>
References: <20240127-pxa-dma-yaml-v1-1-573bafe86454@skole.hr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FsqycuUB7fyG5ylo"
Content-Disposition: inline
In-Reply-To: <20240127-pxa-dma-yaml-v1-1-573bafe86454@skole.hr>


--FsqycuUB7fyG5ylo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sat, Jan 27, 2024 at 05:53:45PM +0100, Duje Mihanovi=C4=87 wrote:
> Convert the Marvell MMP DMA binding to YAML.
>=20
> The TXT binding mentions that the controller may have one IRQ per DMA
> channel. Examples of this were dropped in the YAML binding because of
> dt_binding_check complaints (either too many interrupt cells or
> interrupts) and the fact that this is not used in any of the in-tree
> device trees.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---
>  .../devicetree/bindings/dma/marvell,mmp-dma.yaml   | 82 ++++++++++++++++=
++++++
>  Documentation/devicetree/bindings/dma/mmp-dma.txt  | 81 ----------------=
-----
>  2 files changed, 82 insertions(+), 81 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml b=
/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> new file mode 100644
> index 000000000000..fe94ba9143e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/marvell,mmp-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell MMP DMA controller
> +
> +maintainers:
> +  - Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> +
> +description:
> +  Marvell MMP SoCs may have two types of DMA controllers, peripheral and=
 audio.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - marvell,pdma-1.0
> +      - marvell,adma-1.0
> +      - marvell,pxa910-squ
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt lines for the controller, may be shared or one per DMA c=
hannel
> +    minItems: 1
> +
> +  '#dma-channels':
> +    deprecated: true
> +
> +  '#dma-requests':
> +    deprecated: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#dma-cells'
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - marvell,adma-1.0
> +              - marvell,pxa910-squ
> +    then:
> +      properties:
> +        asram:
> +          description:
> +            phandle to the SRAM pool
> +          minItems: 1
> +          maxItems: 1
> +        iram:
> +          maxItems:=20

These properties are not mentioned in the text binding, nor commit
message. Where did they come from?

That said, for properties that are only usable on some platforms, please
define them at the top level and conditionally permit/constrain them.

> +unevaluatedProperties: false
> +
> +examples:
> +  # Peripheral controller
> +  - |
> +    pdma0: dma-controller@d4000000 {

The label is not needed here or below.
In fact, I'd probably delete the second example as it shows nothing that
the first one does not.

thanks,
Conor.

> +        compatible =3D "marvell,pdma-1.0";
> +        reg =3D <0xd4000000 0x10000>;
> +        interrupts =3D <47>;
> +        #dma-cells =3D <2>;
> +        dma-channels =3D <16>;
> +    };
> +
> +  # Audio controller
> +  - |
> +    squ: dma-controller@d42a0800 {
> +        compatible =3D "marvell,pxa910-squ";
> +        reg =3D <0xd42a0800 0x100>;
> +        interrupts =3D <46>;
> +        #dma-cells =3D <2>;
> +        dma-channels =3D <2>;
> +    };

--FsqycuUB7fyG5ylo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbaOowAKCRB4tDGHoIJi
0m+3AP9YxodicQITyEr/b/mKRwodDU8jOXJAYo19Ub+5NXgh3QEAjNIVJuDzLiYE
yllcgmsNqNpWgE9hTaQcUSvqNwkinQc=
=hw/+
-----END PGP SIGNATURE-----

--FsqycuUB7fyG5ylo--

