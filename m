Return-Path: <dmaengine+bounces-2816-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4B194AE80
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 18:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5583B1F2217A
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3514313A896;
	Wed,  7 Aug 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu6N9rJk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1713A276;
	Wed,  7 Aug 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049844; cv=none; b=UzuNxcEpZrmIpFYamVC1TL7x+ZPpEFr7dbSMiorAFmBRKximJN9I0pmLgiPQ89pVixOnaaOVDhxOqw0x1Ad4UPU0zMygEh7IL+tPzwvqBXH8T6Zh7tpd47oaIUQ38pAQEWOIPxQGHkeeQGGH3XUkM2DtghS+9/FGQHeaYMkicNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049844; c=relaxed/simple;
	bh=keez4POY0NFqfBD0t3YaXqLe3R3SAlTbYgVCNpixHFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghqi8k8RCs3/IqpzL4ne5GFW6xdCE57fYG6V9GLpI7fbPZikSaR4T2Frwz3zS4CfndMFcvDbuAmyfgqf6sQ2DVP9AriHFCBi46AYEdOERXDcAU5fKYclbNoZYnOtQbwUojpKeOY4UOyFRzCQSlJM9UF8LcRlx/XpXtnwBavT+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu6N9rJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F0EC4AF0D;
	Wed,  7 Aug 2024 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723049843;
	bh=keez4POY0NFqfBD0t3YaXqLe3R3SAlTbYgVCNpixHFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gu6N9rJkJRbawh/2fmcp0vsA3EX9rkdrUtetaKCcSrbWh6/NZX+4gFV3xKmSI8MbL
	 b1THXUMijTPcCtVkEdEpw6GCRISQ1jcaWMmu92LQjMYDsvaI8eIgPTjlAhHx+y7rbk
	 YtfaMIK4PBV6wNj87COY88sFm1+Uxdhl7Nq+6kva3V3YAU/5xSHjoLuhI5BgCYk2q0
	 fPc03r9p0IYI3FfqXvk65qb0hDlXw3AQCRsIk65Fc92TFS0kx3D1BosQwg5O9Xpbgo
	 mlJst4IVmhSv5Cp6PjOi1Yy5LUDvDBZxIuwZzregV+6I3RBGQAA0ez5ppCWzp5cBw/
	 4LMES6mcjonmQ==
Date: Wed, 7 Aug 2024 17:57:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] dt-bindings: dma: fsl,imx-dma: Document the DMA clocks
Message-ID: <20240807-error-robin-9290e918d6ac@spud>
References: <20240807164654.53472-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lKp0K71b96koTt/A"
Content-Disposition: inline
In-Reply-To: <20240807164654.53472-1-festevam@gmail.com>


--lKp0K71b96koTt/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 01:46:54PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> Document the IPG and AHB clocks that are needed by the DMA hardware.

Sure it is an ABI break, but these clocks should be required if they are
"needed" by the hardware, no? Obviously the driver would need to
tolerate the absence.

>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  .../devicetree/bindings/dma/fsl,imx-dma.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml b/Doc=
umentation/devicetree/bindings/dma/fsl,imx-dma.yaml
> index 902a11f65be2..5cf80040565f 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,imx-dma.yaml
> @@ -28,6 +28,14 @@ properties:
>        - description: DMA Error interrupt
>      minItems: 1
> =20
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: ahb
> +
>    "#dma-cells":
>      const: 1
> =20
> @@ -47,10 +55,14 @@ additionalProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/clock/imx27-clock.h>
> +
>      dma-controller@10001000 {
>        compatible =3D "fsl,imx27-dma";
>        reg =3D <0x10001000 0x1000>;
>        interrupts =3D <32 33>;
>        #dma-cells =3D <1>;
>        dma-channels =3D <16>;
> +      clocks =3D <&clks IMX27_CLK_DMA_IPG_GATE>, <&clks IMX27_CLK_DMA_AH=
B_GATE>;
> +      clock-names =3D "ipg", "ahb";
>      };
> --=20
> 2.34.1
>=20

--lKp0K71b96koTt/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrOnbwAKCRB4tDGHoIJi
0uRNAP9cDOCh5Gq4ExBjJdkQjj/tCyZeKkR3LLTguUw1TrdVuQEAwcSR6iDdnXkY
ZAIpLIU2izzg1n+9cggiSu+FoSxbtQc=
=H0O/
-----END PGP SIGNATURE-----

--lKp0K71b96koTt/A--

