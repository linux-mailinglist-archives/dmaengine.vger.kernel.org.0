Return-Path: <dmaengine+bounces-4637-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF763A4C83C
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 17:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0D817616C
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2E267396;
	Mon,  3 Mar 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEh7YJUK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE6266F1D;
	Mon,  3 Mar 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019519; cv=none; b=ngjoizi+J4QtXVMs8f3astSR8KVuTRDwBeJeXggiHgrqwPWuYkFAxbmzt2MBwmdZ93M+y+PVLjru5sK0UBwk5MDod7z7U7wsWX9Vf3/FuNyGmsbcYqB9t+XX+PWzfIT1t0hoihMGCqLq0k6LsWwWoQUxj75MWCaRg69GUbYDgGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019519; c=relaxed/simple;
	bh=59vFLZvHUoSxpczTYUQZKEeXJgGnJtz5NQZHwHzt73U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHHFxOBwoB8Q25WpwO+lO3uBjHvYxXY2Zsq80empNSZh2EpjCc4NEI0Ou3FiTWlb5J8q+KRy/CUB9jiNDqqWiGnop4MyLW/78rFEIVU9eWt2XNzL355fWfJ76kjax0uJ/GGt41Yas6GT5zVg7DtIhl3kH06GxT7WsD0x85U+gy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEh7YJUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5563C4CEE4;
	Mon,  3 Mar 2025 16:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019518;
	bh=59vFLZvHUoSxpczTYUQZKEeXJgGnJtz5NQZHwHzt73U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEh7YJUKMzh6a2Az24xFOmx2Oq5LQRsBZu1AnqQU3niJZXZgcaDhUa4umh29igLGr
	 mwKtNrVTOddw8plCoaFuT0fWhHK+GRrjv2cK/z8MItAR+gQ42xqC8/D++OrPGsD6L0
	 Xpyuo1XW7RDjxgJ2JNZaI5Q3JGgeJD2o5U5v6TLcn6D7QHdrGs9d063Kg/2BxCKqSd
	 48AlqfHuQkK49q/snf3hrUnKGHOng10npw8eDZrsFNKQdPXsLvTM1Qc7jtY1BW60Kp
	 tFPlxp9jBNcRsYaoA+ZZRKw2YP6Ktc5EET6T0dErxGIYe0ggLx8um3U8GqqcdSCcjV
	 7DVKU18k2CusA==
Date: Mon, 3 Mar 2025 16:31:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] dt-bindings: dma: snps,dw-axi-dmac: Allow devices to be
 marked as noncoherent
Message-ID: <20250303-repacking-grouped-adc43e4b602c@spud>
References: <20250303065649.937233-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="55R7XdofnJQSEfF1"
Content-Disposition: inline
In-Reply-To: <20250303065649.937233-1-inochiama@gmail.com>


--55R7XdofnJQSEfF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2025 at 02:56:48PM +0800, Inochi Amaoto wrote:
> A RISC-V platform can have both DMA coherent/noncoherent devices.
> Since the RISC-V architecture is marked coherent, devices should
> be marked as noncoherent when coherent devices exist.
>=20
> Add dma-noncoherent property for snps,dw-axi-dmac device. It will
> be used on SG2044, and it has other coherent devices.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
> Related discussion for this property.
>=20
> https://lore.kernel.org/all/20250221013758.370936-1-inochiama@gmail.com/
> ---
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml =
b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 525f5f3932f5..935735a59afd 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -59,6 +59,8 @@ properties:
>      minimum: 1
>      maximum: 8
>=20
> +  dma-noncoherent: true

I'd probably also add mutual exclusion, but I think that's something for
dt-schema and not for individual bindings.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +
>    resets:
>      minItems: 1
>      maxItems: 2
> --
> 2.48.1
>=20

--55R7XdofnJQSEfF1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8XZegAKCRB4tDGHoIJi
0mbTAQDWwBpU1nT5NS6U/bmm3rXSSm4aXMCwWFelufMYrmW+VwD/ZbFzEMY91XDn
HAXfWjGCnIVXEDVN7eAgWb4qaaKb2A8=
=GmVd
-----END PGP SIGNATURE-----

--55R7XdofnJQSEfF1--

