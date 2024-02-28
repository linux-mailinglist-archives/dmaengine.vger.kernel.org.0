Return-Path: <dmaengine+bounces-1149-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904186ACCF
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 12:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2F41C2251C
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9343112CD87;
	Wed, 28 Feb 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhLoNFaK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681727A728;
	Wed, 28 Feb 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119160; cv=none; b=Zxn8fMkRMiz1ztB81gcZBLJu7D5PO0vup9UtxP+gYDja5jxY6uroKVR1UpEW6o28ymPvWIvtgZIxUsD5tR9XDVrD2UljXGGuKW582vlnVem4RFFf841ZCyRc8TWXylA4a2dhOkP3QvAObaFkfUogt877cadtTctjg0QTg4uLUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119160; c=relaxed/simple;
	bh=k9YHtI7jHipmokPKQWwD0PwKV0bONau5eJ2uz027Y+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8rmmgjiInA/xCjMvm25XbUDt8M5zXtQ55raSqfVpjMvHJ9mzIv/aCgVLOze81noU3p/FCnpwy60/n23CKav+afa7tseqmg+d/S9+BnVeGN0iOJA9uFh9jBEtfqVb/IPatB6XdWrGeIg6yYTU6pRMBs8PyNzTrFR0gGEDp84w2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhLoNFaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC640C433C7;
	Wed, 28 Feb 2024 11:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709119160;
	bh=k9YHtI7jHipmokPKQWwD0PwKV0bONau5eJ2uz027Y+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhLoNFaKAQdVot2WS3QbJN46t2xwvd5iAZeyv1fJxI0L0G0bNHvBAiBibtz4Tebbt
	 NZ4+7MJdH4KmZ3Eu134/XgIKniJfaivXns3Tl+/tOtwggGPIya21SKzB2zRqyjGcHi
	 kHi+UK/Nu+1lhk/cGCWh9+7kHoB2tPmOsKYvV2gf/J+MkItLm5I6dCvdNZuuGA9Nzg
	 kxhDinCnPoc1AkKOQqICR9jq05wRfN1wKN6gcwjmpmuhhX6Yy6z9i45IQ9OfFA1cyd
	 v1bqleQhztYAFc86kbu5VsASnA2cxDmhkZwVHyF++Oc2RXrMw2efRTVfuVQvFTabFo
	 JfuKnV9PZE+KA==
Date: Wed, 28 Feb 2024 11:19:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: crypto: starfive: Add jh8100 support
Message-ID: <20240228-margarita-glory-73db09c5fc91@spud>
References: <20240227163758.198133-1-jiajie.ho@starfivetech.com>
 <20240227163758.198133-2-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6rTo2fkA4bSImk4p"
Content-Disposition: inline
In-Reply-To: <20240227163758.198133-2-jiajie.ho@starfivetech.com>


--6rTo2fkA4bSImk4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:37:53AM +0800, Jia Jie Ho wrote:
> Add compatible string and additional interrupt for StarFive JH8100
> crypto engine.
>=20
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../crypto/starfive,jh7110-crypto.yaml        | 30 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/starfive,jh7110-cry=
pto.yaml b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.=
yaml
> index 71a2876bd6e4..d44d77908966 100644
> --- a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> +++ b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> @@ -12,7 +12,9 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    const: starfive,jh7110-crypto
> +    enum:
> +      - starfive,jh8100-crypto
> +      - starfive,jh7110-crypto
> =20
>    reg:
>      maxItems: 1
> @@ -28,7 +30,10 @@ properties:
>        - const: ahb
> =20
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: SHA2 module irq
> +      - description: SM3 module irq
> =20
>    resets:
>      maxItems: 1
> @@ -54,6 +59,27 @@ required:
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: starfive,jh7110-crypto
> +
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          const: starfive,jh8100-crypto
> +
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 2
> +
>  examples:
>    - |
>      crypto: crypto@16000000 {
> --=20
> 2.34.1
>=20

--6rTo2fkA4bSImk4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8WswAKCRB4tDGHoIJi
0scyAQCyzlNaU4MW+ttTttfD9zVood2a3GWnh9luZay5NWSbwAD/YoGkkKgWc9jh
Gk/AToNTyc/NecNiJZkRXrDV7ig7FwU=
=byAE
-----END PGP SIGNATURE-----

--6rTo2fkA4bSImk4p--

