Return-Path: <dmaengine+bounces-5933-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FEDB187BA
	for <lists+dmaengine@lfdr.de>; Fri,  1 Aug 2025 21:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0FC1781D2
	for <lists+dmaengine@lfdr.de>; Fri,  1 Aug 2025 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074528E578;
	Fri,  1 Aug 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCWzLlIw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB74F28E574;
	Fri,  1 Aug 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076605; cv=none; b=R2rnfTaeFzMzfVceKVGwGIr4aKiyO3CBkE+OBIqsVZiOxUul0JE5oYB42rCgG97U4dMZg5o89bdUQjYj/v46YI39eXv6LJot5i+9o6GY/KZennurD29/m6jHEzmpgNJsXqaB4ylygNbdLPdjnCsH4Kkcmu3jqNA3v0K6EVKMpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076605; c=relaxed/simple;
	bh=QIvDp326hx442oBNoCgvRKhpRZCrpyZ4MgfHtvxx6IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWNqtLaXAal73KYjj5HiHNXyw0rr6eWrSo2Vgd4PZeOw/BoEOYslJdBAfJRX6jOCePeuy+ekgqaMAZSYz48laHCtnjSTueO5Xg9iBDsoObxMWWNC2xJTxpu0+i/KH8oE2jBAdhvA7unwvpzSo4fZg0UjFhzvnxiEkifJ+j/28jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCWzLlIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9DDC4CEF9;
	Fri,  1 Aug 2025 19:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754076605;
	bh=QIvDp326hx442oBNoCgvRKhpRZCrpyZ4MgfHtvxx6IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCWzLlIwA5rDCTigq8lmDf6xXVWEH5l56fpQ1pITJxnI/fmNgoB6H3Pw74iGDw4HO
	 TlZ22QHpVCkxkQ6th79r4Trrpul16lQao0LebbJN15zjjS52eSClE2IIZxH3CRg08A
	 jmH/8sb91gI/7KL7A/C0WRPVAaCxEC6xUnHupP3oXEPBR7+nz5XcA7+IhUTUBkwCVa
	 50Nl8g8Kw1l+J0RqbdIEGkMb5zYZHYg0+0KOeccfKiAZpy8gEvZ6Pk+rWwn6fH5B3L
	 H35pt1PEfxDfi8ACewevcQbTXWBYqVRV3uUM5uoi4JZp8YUFlO5EG3tfG0cw1QAcjN
	 U5sCjPuDNzCrw==
Date: Fri, 1 Aug 2025 20:29:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/G3E family of
 SoCs
Message-ID: <20250801-tinfoil-revenue-6fec31c1f099@spud>
References: <20250801084825.471011-1-tommaso.merciai.xr@bp.renesas.com>
 <20250801084825.471011-3-tommaso.merciai.xr@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cJFA5TX8jbyuGS70"
Content-Disposition: inline
In-Reply-To: <20250801084825.471011-3-tommaso.merciai.xr@bp.renesas.com>


--cJFA5TX8jbyuGS70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2025 at 10:48:22AM +0200, Tommaso Merciai wrote:
> The DMAC block on the RZ/G3E SoC is identical to the one found on the
> RZ/V2H(P) SoC.
>=20
> No driver changes are required, as `renesas,r9a09g057-dmac` will be used
> as a fallback compatible string on the RZ/G3E SoC.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--cJFA5TX8jbyuGS70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaI0VtwAKCRB4tDGHoIJi
0oBYAP9dYasfH1OnF5QpY61qg4/gKEjB/ZtQBUyYa/Ehppx0awEAqZg8y8ipVZkW
4s+38ILPHghdhASqX4rkk+zv7fP+Ogc=
=ML3I
-----END PGP SIGNATURE-----

--cJFA5TX8jbyuGS70--

