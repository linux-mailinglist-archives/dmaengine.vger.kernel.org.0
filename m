Return-Path: <dmaengine+bounces-1517-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71A988CC10
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 19:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92547307AA9
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 18:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC185293;
	Tue, 26 Mar 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPBVhnlf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E2366;
	Tue, 26 Mar 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477964; cv=none; b=RG9v0HGbETkSJPfIiLTSPHT7DCJK73VPwSsvX/+Qy25t4XRwhbxWVE5XUhXaflCaa5f36V95Q5ixo1lhpc69GVqjKDG5EdSiEcRNiaB5yFueET3T8spxyBh/Wf/h189t+k+SH9iOOu9txsAgF9vDW9lHQA8uGnTcUr03UFKL8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477964; c=relaxed/simple;
	bh=NUM/VQUj1n9cy0CvGlCZX+P9uXr4/dy72JoGSLHufxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl4b3YngjDYlvkXuZeiiFG6n0vmcOq+qfYZ2G+x0rLYOD5YefijSGCxB51zoqQIeoyiYHiNh6vj2F9Skgdo+qtNO4aHX4OslwEjS7RSktYYx1T5kT6mTCp/dRxyLN36lU4zDUvdKGMfSM4T4ZUjrJjcKXooXQ7o1LVGFR0AJi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPBVhnlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485F5C433F1;
	Tue, 26 Mar 2024 18:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711477963;
	bh=NUM/VQUj1n9cy0CvGlCZX+P9uXr4/dy72JoGSLHufxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPBVhnlf3WgVLSfhU2d3qPkER6edrVKGY0wPi+vl9sFQP3kSNWNPDsQ6i4JcXR7vn
	 WiZwKCOzJ/NuPL5hLeBH97lnMywL0RrCLN6opS+iIlkrJ9Hsf0qpBYCUOHcL2qQKs3
	 N6vZzXHUZB2Yi0vERUjybqVDqAYHybjE/jXZUFgSwow0x9v4i4E6/If7v9KCzzEq4A
	 xQq/4w++Jy4axdgvEHOCyY4+UJASVNs2Kqf13epHbcQydYdvhl3ZzbIKUN6NA3ENKC
	 4WGOAiiFqhAV7nR0nA5o7QAsnpXZbgwgDgvcUfvKwEwgxqBrCPpZ8EG7bHUdAeeFrG
	 Pmw2uyGN9iV6A==
Date: Tue, 26 Mar 2024 18:32:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Tan Chun Hau <chunhau.tan@starfivetech.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jee Heng Sia <jeeheng.sia@starfivetech.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add JH8100
 support
Message-ID: <20240326-maternity-alive-6cb8f6b2e037@spud>
References: <20240326095457.201572-1-chunhau.tan@starfivetech.com>
 <20240326095457.201572-2-chunhau.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hN0bqbopRWGDKaVk"
Content-Disposition: inline
In-Reply-To: <20240326095457.201572-2-chunhau.tan@starfivetech.com>


--hN0bqbopRWGDKaVk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 02:54:56AM -0700, Tan Chun Hau wrote:
> Add support for StarFive JH8100 SoC in Sysnopsys Designware AXI DMA
> controller.

Your commit message should explain what makes this incompatible with
existing devices. That inforatiion does appear to be in the driver
patch, but should also be here. Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
> ---
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml =
b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 363cf8bd150d..525f5f3932f5 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -21,6 +21,7 @@ properties:
>        - snps,axi-dma-1.01a
>        - intel,kmb-axi-dma
>        - starfive,jh7110-axi-dma
> +      - starfive,jh8100-axi-dma
> =20
>    reg:
>      minItems: 1
> --=20
> 2.25.1
>=20

--hN0bqbopRWGDKaVk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMUxwAKCRB4tDGHoIJi
0vGxAP0e/9BfT/Cc5S7oAvgGnrjYwSinfk93mUrAKWU7SUAcWgD9EksxI511Ha//
B3vFWbGOJJZDcakWwlM9rjiatGEljAQ=
=Dmpe
-----END PGP SIGNATURE-----

--hN0bqbopRWGDKaVk--

