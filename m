Return-Path: <dmaengine+bounces-5384-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590E2AD5C19
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8521E1D3C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0043F1EB5D0;
	Wed, 11 Jun 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of69h1mo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C291714AC;
	Wed, 11 Jun 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659240; cv=none; b=G2Rgn0wF3+LostotEAsGlAKVKmkfDV4lYqiZz2LoMIpmMDFADrUGO7LwNqChSh7P0DiQzRGH3s05ThD66P9YygxTGQSD34MvYwgSfrEgLNoGw0Mq7VyH9RJM28kU6hJgkyFA8qBzkGD2FlGzMkBnCOlZ7FfeAYahpkVIlzBMFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659240; c=relaxed/simple;
	bh=TtXVw+PkPXOitHU74/zipxEl0FGTF6GQcOkD9yWCbmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2DxVWIYcHIv7XisqMD3MFRXddyhh1o1KPBdcWxR5CLXdXPfgPJo5B/T8F07eZUVMEtZQS3k6n1wiSIZKstrqPBEEfI+ENyj5AMH4njsj2ydUbFV4S9Zb/OXBjKWMeGzOfHlvsDjD6KKhON31lA/w6+hQ2w6/ZCe79oHNrm9jIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of69h1mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA55FC4CEE3;
	Wed, 11 Jun 2025 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659237;
	bh=TtXVw+PkPXOitHU74/zipxEl0FGTF6GQcOkD9yWCbmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Of69h1moi0kvk/wUGfC8qUrYlhnSf5HEF+Y08XuY4uWhQgQIfpaKOOUbCMBEfU5Xk
	 m/JmMjypFT5H6Z6KZT9Xv21j9YKSR30BKLl/NooP9nZIhmaUOfKcyzJA2elWTRd3P9
	 hFJ624oP/nZmvLkDU/piWDaokPP0F1GVWpqbJR7jkfAplrVxOzjdVU26f2IpGcog7O
	 mg5HZ8bMfTz3ruS03ExOSyhMCWXHURuTNmaa98JNQ9U8OpEQ1m0e+kNssvJYZBijpf
	 y6GipI71Y3uYOfaC45cKAzEi5+mYe9X9xhkHHxx9GgsD0Y++ECkyvhmT32xNjnDd7H
	 EaRKgPT4P2IKA==
Date: Wed, 11 Jun 2025 17:27:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlan@gentoo.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, drew@pdp7.com,
	emil.renner.berthing@canonical.com, inochiama@gmail.com,
	geert+renesas@glider.be, tglx@linutronix.de,
	hal.feng@starfivetech.com, joel@jms.id.au, duje.mihanovic@skole.hr,
	elder@riscstar.com, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 1/8] dt-bindings: dma: marvell,mmp-dma: Add SpacemiT PDMA
 compatibility
Message-ID: <20250611-kabob-unmindful-3b1e9728e77d@spud>
References: <20250611125723.181711-1-guodong@riscstar.com>
 <20250611125723.181711-2-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="82h4siQLdNk8igEh"
Content-Disposition: inline
In-Reply-To: <20250611125723.181711-2-guodong@riscstar.com>


--82h4siQLdNk8igEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 08:57:16PM +0800, Guodong Xu wrote:
> Add "spacemit,pdma-1.0" compatible string to support SpacemiT PDMA
> controller in the Marvell MMP DMA device tree bindings. This enables:
>=20
> - Support for SpacemiT PDMA controller configuration
> - New optional properties for platform-specific integration:
>   * clocks: Clock controller for the DMA
>   * resets: Reset controller for the DMA
>=20
> Also, add explicit #dma-cells property definition to avoid
> "make dtbs_check W=3D3" warnings about unevaluated properties.
>=20
> The #dma-cells property is defined as 2 cells to maintain compatibility
> with existing ARM device trees. The first cell specifies the DMA request
> line number, while the second cell is currently unused by the driver but
> required for backward compatibility with PXA device tree files.
>=20
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  .../bindings/dma/marvell,mmp-dma.yaml           | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml b=
/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> index d447d5207be0..e117a81414bd 100644
> --- a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> @@ -18,6 +18,7 @@ properties:
>        - marvell,pdma-1.0
>        - marvell,adma-1.0
>        - marvell,pxa910-squ
> +      - spacemit,pdma-1.0

You need a soc-specific compatible here.

> =20
>    reg:
>      maxItems: 1
> @@ -32,6 +33,21 @@ properties:
>        A phandle to the SRAM pool
>      $ref: /schemas/types.yaml#/definitions/phandle
> =20
> +  clocks:
> +    description: Clock for the controller
> +    maxItems: 1
> +
> +  resets:
> +    description: Reset controller for the DMA controller
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 2
> +    description:
> +      The first cell contains the DMA request number for the peripheral
> +      device. The second cell is currently unused but must be present for
> +      backward compatibility.

These properties are only valid for your new device, right?
If so, please restrict them to only the spacemit platform.

> +
>    '#dma-channels':
>      deprecated: true
> =20
> @@ -52,6 +68,7 @@ allOf:
>            contains:
>              enum:
>                - marvell,pdma-1.0
> +              - spacemit,pdma-1.0
>      then:
>        properties:
>          asram: false
> --=20
> 2.43.0
>=20

--82h4siQLdNk8igEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEmuXgAKCRB4tDGHoIJi
0qVeAQDGipWedss8FsQk82+JZZWNvXPOTFMRXZ9UZDbpVDtD9AD9HKL4/k0Gara+
cP7bfGhZRfjr9QcvF763N1YHTn34eg0=
=BguH
-----END PGP SIGNATURE-----

--82h4siQLdNk8igEh--

