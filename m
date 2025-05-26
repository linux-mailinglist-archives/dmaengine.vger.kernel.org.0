Return-Path: <dmaengine+bounces-5270-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CE0AC423D
	for <lists+dmaengine@lfdr.de>; Mon, 26 May 2025 17:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6836188CBD1
	for <lists+dmaengine@lfdr.de>; Mon, 26 May 2025 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9172520E717;
	Mon, 26 May 2025 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBMR/EqD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F217A29;
	Mon, 26 May 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748273293; cv=none; b=t33S2AOALnxKQaiBy6k5hIq1v2phQfCt7Mz2iExdKTvlI8K8hwura4jTl18labHCfhmAAZl7yuQIVHJJcuR8UmN3xdJOlFTF+McudJbbABtuGZYNT5GdggWXgp8NXB+JGGmYhCrwiSqC0rZ32ttHXU2zrr6Es9jirMs+Ill8M1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748273293; c=relaxed/simple;
	bh=kx4yqtWDGweZsbDr2gCws1oaqd0WX7/rjIqEa7ApGPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcgL21kFLJkjUjc4W5RUVNn5I4QVFP9zyFaXaiZLvKnAojTwv4JAhkEClpWBG1sBiHnyrndtcy9FdKuvsaWI7fzzLtE+djMZrbTFlERJZpcWoNcCOYAWLKzUkhe+ICcMQ3G5pm01RH3Tv6vrjb/ul9SsYXHXZjSEV7uaC39UOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBMR/EqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056F7C4CEE7;
	Mon, 26 May 2025 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748273292;
	bh=kx4yqtWDGweZsbDr2gCws1oaqd0WX7/rjIqEa7ApGPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBMR/EqD2LP6ZMPrdhAz5GKwgLaYU5OLWEXKKEkRkERaLW6tj3NPmH/yJY93BrIkk
	 oqhH7jAiRBVQcPG8g2HSodJ6bqNVI0hfwhyM6AECHauRn9OegoVXNa6MsBuljNAHXl
	 Bh8gi698WLTIYN4jHrMbqEfV6Bo2r88Nojmim5EzU7ADtUTBNVPZb+vJr7HIgZIs7m
	 pD47cXG4K0/jnaNIvsGj3unpYEYQGXpBiChV28o6VDLuOJR9qyObJB/iG8Gw8RxdRV
	 1OPb8D1rvBE42FwZn3wJDxzPF+GreVTUVfNRFNL/03trQQiVjyhbOcNgXaunhxpMIc
	 JJIjF0XDCr7qA==
Date: Mon, 26 May 2025 16:28:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: dma: fsl-mxs-dma: allow interrupt-names
 for fsl,imx23-dma-apbx
Message-ID: <20250526-plural-nifty-b43938d9f180@spud>
References: <20250523213252.582366-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6/eZI3GwQY5emfaK"
Content-Disposition: inline
In-Reply-To: <20250523213252.582366-1-Frank.Li@nxp.com>


--6/eZI3GwQY5emfaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 05:32:52PM -0400, Frank Li wrote:
> Allow interrupt-names for fsl,imx23-dma-apbx and keep the same restriction
> for others.

The content of the patch seems okay, but why are you doing this? What is
the value on this particular platform but not the others?

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/dma/fsl,mxs-dma.yaml  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml b/Doc=
umentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> index 75a7d9556699c..9102b615dbd61 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,mxs-dma.yaml
> @@ -23,6 +23,35 @@ allOf:
>        properties:
>          power-domains: false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx23-dma-apbx
> +    then:
> +      properties:
> +        interrupt-names:
> +          items:
> +            - const: audio-adc
> +            - const: audio-dac
> +            - const: spdif-tx
> +            - const: i2c
> +            - const: saif0
> +            - const: empty0
> +            - const: auart0-rx
> +            - const: auart0-tx
> +            - const: auart1-rx
> +            - const: auart1-tx
> +            - const: saif1
> +            - const: empty1
> +            - const: empty2
> +            - const: empty3
> +            - const: empty4
> +            - const: empty5
> +    else:
> +      properties:
> +        interrupt-names: false
> +
>  properties:
>    compatible:
>      oneOf:
> @@ -54,6 +83,10 @@ properties:
>      minItems: 4
>      maxItems: 16
> =20
> +  interrupt-names:
> +    minItems: 4
> +    maxItems: 16
> +
>    "#dma-cells":
>      const: 1
> =20
> --=20
> 2.34.1
>=20

--6/eZI3GwQY5emfaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDSIhwAKCRB4tDGHoIJi
0oP3AQDZKIfwzE9jpzhzxeBf1nNcdt6Ict2IVltCQIp8aS+xsQD/d6XIOMs1ZvRC
LNdQl78nksXIYJ53eDc742UHjVpsyQ8=
=hMch
-----END PGP SIGNATURE-----

--6/eZI3GwQY5emfaK--

