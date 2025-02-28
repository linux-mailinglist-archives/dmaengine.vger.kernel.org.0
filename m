Return-Path: <dmaengine+bounces-4618-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAFBA4A136
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 19:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499613BC241
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 18:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BE626F44B;
	Fri, 28 Feb 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNOTwHYB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B851BD01D;
	Fri, 28 Feb 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766437; cv=none; b=AkAuZvfwbqATTuBTX5w4PdCXuyNYvnvKFEEiZFiAf8jqY7hLr5o5Sk/m2o+Wupzu5nlmsbko6NuTNj7UR1qMYtmkbIyEMQHAVkpB6zJlBLLfz5fWV1d/LrbWzofTRR58oeQp1kVnSUa5X3/edZPUFoIrym9MJDrk/rn8mzZI/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766437; c=relaxed/simple;
	bh=ujaLWoGzRpD5bp+OaKn0XkWzJ+NPJTlHvgtHU9Kct5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K57QseZTZGH0LBJqWZ0Pja/3I14aPo/SXO545p1yQDaVaFOOO2l8wsnyn4ELqRX74Siwoi6aLxfytST4zFDROBwRLR6GtFtVuKMHBf+lkMIrLAJA+rtjS3S3csvWP0V5nmY2H/KpvE2DNO4M30KuDyBifUN3AyFMPZsZbSt/yHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNOTwHYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7B8C4CED6;
	Fri, 28 Feb 2025 18:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740766435;
	bh=ujaLWoGzRpD5bp+OaKn0XkWzJ+NPJTlHvgtHU9Kct5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNOTwHYBSzMUSGZtW237K6ohmPV1n6y669RasxiCor9SnzKctUazO1qZOk90onpUD
	 fIHqxLBpTR9MvIxBh4TK+6J5O1tyYjLAcXNiBt7KQ9R4+IJ2+0BCPUjOK7FHE7E81z
	 fckX75em+/P+f1MzArcZ5WNfr4OqeayjqIlE1+RpcgUapPG8Gy/9k4Zw4RPfRzEiY7
	 MxUJS5pHxiJknpnbO1QpRJeidGW1mwRFwqpYwO5UibDHX8s5G6X8tlAwSmvo1yyR20
	 f3gyUqhDWUPU3xAbdGS09zyz1AHJF7oSq2392i1+AAcm/6OYnta+G0ezVI35FD/N9b
	 7LkgSueZGbcRA==
Date: Fri, 28 Feb 2025 18:13:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: dma: fsl-edma: increase maxItems of
 interrupts and interrupt-names
Message-ID: <20250228-frown-caretaker-4e3e3f2533e9@spud>
References: <20250228-edma_err-v1-0-d1869fe4163e@nxp.com>
 <20250228-edma_err-v1-1-d1869fe4163e@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ecjyfAuBw3hDMQz"
Content-Disposition: inline
In-Reply-To: <20250228-edma_err-v1-1-d1869fe4163e@nxp.com>


--7ecjyfAuBw3hDMQz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:42:03PM -0500, Frank Li wrote:
> From: Joy Zou <joy.zou@nxp.com>
>=20
> The edma controller support optional error interrupt, so update interrupts
> and interrupt-names's maxItems.

This seems like something were you would know based on the soc (or
compatible) whether or not 64 or 65 is the correct maximum for that
device?

>=20
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Docume=
ntation/devicetree/bindings/dma/fsl,edma.yaml
> index 4f925469533e7..900170b3606ef 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -40,11 +40,11 @@ properties:
> =20
>    interrupts:
>      minItems: 1
> -    maxItems: 64
> +    maxItems: 65
> =20
>    interrupt-names:
>      minItems: 1
> -    maxItems: 64
> +    maxItems: 65
> =20
>    "#dma-cells":
>      description: |
>=20
> --=20
> 2.34.1
>=20

--7ecjyfAuBw3hDMQz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8H83gAKCRB4tDGHoIJi
0iDIAQCAJibbrUSAhVgbcDTkSVf5JBxg4PcLzFSvWqN50xN88QD/bgebSksIAxxy
dvxF1HJNIum9n6cLpDMLCb8ISj3fag0=
=grw2
-----END PGP SIGNATURE-----

--7ecjyfAuBw3hDMQz--

