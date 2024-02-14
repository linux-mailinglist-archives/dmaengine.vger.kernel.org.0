Return-Path: <dmaengine+bounces-1015-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE9C85507F
	for <lists+dmaengine@lfdr.de>; Wed, 14 Feb 2024 18:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B01B2C2A9
	for <lists+dmaengine@lfdr.de>; Wed, 14 Feb 2024 17:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CAB83A09;
	Wed, 14 Feb 2024 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyQtJgzx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762085F865;
	Wed, 14 Feb 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932292; cv=none; b=J7sTJhGj8+fTEnJCQgPR4E3YGF/YGJZBp9SmRpbEforc/mJns8S78bdq2FYt040lb+1GjuLFWvvykD6+d+kCXPaoL1KG8ljNcs8j5if7yw/2vNHGhyNbjdPbMsa9TtSuy6sxOETRpYd7EA1z3gxaFrjW371buVjUehPjPg3KW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932292; c=relaxed/simple;
	bh=2g987+QeV6BjX5FxbpSo5Cc94BjBZogXoOU1Hub/pv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8LmyUbfk3o3lGLE4hX4KPTQ2P1q/gJHSEoRymq9DWeJkalmQy17UAH5tYeiIFSV6g6vnpd/x3gGvD2jT+S9LyiXSroKK3eX2Dk67WkIR3/yq/V/V2b6TWpwC4TpEKYT0oL61DvGzJCEdXQbpF6dSkelmb9/1/30hU2xXslkYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyQtJgzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34011C433F1;
	Wed, 14 Feb 2024 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707932291;
	bh=2g987+QeV6BjX5FxbpSo5Cc94BjBZogXoOU1Hub/pv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyQtJgzxGQKxyhAIUGZ4QgKlJYoHWG7/qEKlfWUOboMhI+lNjkDG+0Ut9L8rzv8SD
	 azNWzf87FRLt8nrgyFCOsyNHDE2KLUubyJ5ErH0eWEB0J3KtcyGiTlKEHrS1px+0eY
	 Ou/+M2isJKO1hCaDTlKqYNCsjGymwoSZJwQD/g8Of8dmeZGHkOJtdNsUezFDqu5WCG
	 +/0IfnVyi/m7oYuLvUqAv5t1oYUeILgdsWc6W9AHA1pCjFsI6d60sDfOI4RrHj/TCv
	 32WwdseXCCq+x9+Ij5wpgPMwkc+x+Jd8Okddim0nr353ViPXvKit0CIJp1QgOe/PGY
	 glRw5FrOHIxXw==
Date: Wed, 14 Feb 2024 17:38:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: renesas,rcar-dmac: Add r8a779h0 support
Message-ID: <20240214-kiln-grandly-50c0ad24c422@spud>
References: <96aad3b532ee401f19693e18038494f43ddb90e9.1707915609.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="16jjqY3nvciCb0bV"
Content-Disposition: inline
In-Reply-To: <96aad3b532ee401f19693e18038494f43ddb90e9.1707915609.git.geert+renesas@glider.be>


--16jjqY3nvciCb0bV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 02:00:34PM +0100, Geert Uytterhoeven wrote:
> Document support for the Direct Memory Access Controllers (DMAC) in the
> Renesas R-Car V4M (R8A779H0) SoC.
>=20
> Based on a patch in the BSP by Thanh Le.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> Changes compared to the BSP:
>   - Replace items/const by enum,
>   - Drop changes to non-upstream rate-{read,write} properties,
>   - Drop unneeded Channel register block change.
> ---
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml=
 b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> index 03aa067b1229f676..04fc4a99a7cb539a 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> @@ -46,6 +46,7 @@ properties:
>                - renesas,dmac-r8a779a0     # R-Car V3U
>                - renesas,dmac-r8a779f0     # R-Car S4-8
>                - renesas,dmac-r8a779g0     # R-Car V4H
> +              - renesas,dmac-r8a779h0     # R-Car V4M
>            - const: renesas,rcar-gen4-dmac # R-Car Gen4
> =20
>    reg: true
> --=20
> 2.34.1
>=20
>=20

--16jjqY3nvciCb0bV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcz6fgAKCRB4tDGHoIJi
0nynAQDGD09zV84EEd6FpyYh5mNiMR/+E0kAo+naUzQ5fyReMQD8Cgueoq2YEpdi
tA1xeZJ7XyPN3CTqJQaf4IRR3bvNXgU=
=bPN2
-----END PGP SIGNATURE-----

--16jjqY3nvciCb0bV--

