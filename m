Return-Path: <dmaengine+bounces-4556-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965CCA3FDAC
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 18:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA89423E39
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E07250BE1;
	Fri, 21 Feb 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXUX2fjP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41112500D0;
	Fri, 21 Feb 2025 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159828; cv=none; b=Ab313hkU/xHQL6ixsE7nUOhbv14FXMUd5Lov/ij6fJMFdIEhKdkgW32tsuqwSF7pPYmPZbVhQ+ggtzPMMflZQHzasRj+BpYk7glQf1gFU2IvYAi7/LyxAHBFVCOjEMnfypO4OEoZjitzGYc6RrQhGkHzQZEJ0fHS1HKDOHW3p40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159828; c=relaxed/simple;
	bh=5Ib6rKfHINsbnOm48l+ZXnY4AfYdhht8jM5s78b/8XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2cx4ZkUPfjQRtvnOT0OmVhaQ2mKXV3Hy1yZeg0xTdcseiJGPHJIl06apkt0qUsrZGMaJ9NQlf906080i1MvlWw9nQyWGgSVzlT1JIvxyTUanpyBFNraxYCIYWkODZhZTMXe86SC4dvzdd0WbaeDpgcVgvGOXFmVo9XfDXcsFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXUX2fjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06D3C4CED6;
	Fri, 21 Feb 2025 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740159827;
	bh=5Ib6rKfHINsbnOm48l+ZXnY4AfYdhht8jM5s78b/8XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXUX2fjPTdPkddCLjxFq148N3V+JXOTDhx/eDmB1+qUI4wNqwtmHfh1rXUBD3LseX
	 OLHyrFOiej0POnFf8YoIlFoBxSuVrljGAh86IeiODg3iatYPxrHrSQWlcrRF2G0FDf
	 mHyMl3aMXUphYezwx9cDfFMvi5sgf1aqcwSkht1M/+u77c5uoMFDIyoFQ5BDdUtRge
	 ZxNQsjDG8aMcccze/ycqJR5tbs7mbj0sIEm9Ey8uW7bSn36wXEbOBOG20utwyvagfW
	 TxNMzaJXwQIqAmli8INMhUbvvcqtlrdWUX3R3XX822U2WkoN6XlgPl2ljm00UVTvXn
	 CcBnH1krkkD/A==
Date: Fri, 21 Feb 2025 17:43:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: dma: rz-dmac: Restrict properties
 for RZ/A1H
Message-ID: <20250221-saline-thousand-de76cce72b11@spud>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-3-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AU7iG86wlH1begqX"
Content-Disposition: inline
In-Reply-To: <20250220150110.738619-3-fabrizio.castro.jz@renesas.com>


--AU7iG86wlH1begqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 03:01:05PM +0000, Fabrizio Castro wrote:
> Make sure we don't allow for the clocks, clock-names, resets,
> reset-names. and power-domains properties for the Renesas
> RZ/A1H SoC because its DMAC doesn't have clocks, resets,
> and power domains.
>=20
> Fixes: 209efec19c4c ("dt-bindings: dma: rz-dmac: Document RZ/A1H SoC")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--AU7iG86wlH1begqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7i7TgAKCRB4tDGHoIJi
0sviAP9NRM8MOgyy6lNUzNi8XzYpY+vRsiYCqO6Ojzdsv5CsMgEA8sfztDMtmWuJ
f5IjZaGVWFMXetmmbDAttFGz5u7UOQw=
=EJQ5
-----END PGP SIGNATURE-----

--AU7iG86wlH1begqX--

