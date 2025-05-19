Return-Path: <dmaengine+bounces-5205-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA5ABC412
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DE5166B61
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE362874E7;
	Mon, 19 May 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDBWRwUo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE22857F2;
	Mon, 19 May 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670995; cv=none; b=hXmx8u/kWCLKfimC718dePwfGPpfFSp8nrek7LWEBNhxcB1j8kV1Y7dVNaOaCWQGw1CQkaA4C9wwo/Vhgu5bwFZlIZy9Hm54HnMmi7Rscolha9oedsBaaUdAaNnKftSIlcQB1gNYnZlwxKS11yXJRnwmWkJuMSrbpYxunb9iPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670995; c=relaxed/simple;
	bh=1oyMEAm8syprjDKhm1/+o2fhCi0dwq1oZtTbjGNBLDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAWlsjqZxe6MFs/IuRo9zelQMkTX9TxNhuy//lg8R4ZGlWRd9ARXzf0q8VU9pLmOtYs4QYFeFVWpGKSMwU0sOW4z4bSu4PaK3JSFyMaA+L3kIa906CHT8njxjLplC28QkQx55QB7H6rwgHOEn8qG3BYzUgcb1r3X3Ppo6ypmlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDBWRwUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E371FC4CEE4;
	Mon, 19 May 2025 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747670994;
	bh=1oyMEAm8syprjDKhm1/+o2fhCi0dwq1oZtTbjGNBLDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDBWRwUo29k0F2K6AxfHVE9oVhEALISnJwTbyo2hjI6KwFPdPYdoe1jSzA/gp32Cz
	 5kPB8WcVi2tkKrMoWBSu/Aenza4j0BLkdjSb3g2HCFSlfJQzlznnjlAH4Me4dPAS9g
	 kG0z31zgyjdPYBncryoSXNReZX4DymSstAqe9mL9BJ6/dRsytsxeg/avvJd20uHFlo
	 jpWujuA48q45mjr9XZtO1Vv10WEyhFSVZfm/kksf2eLuJycgqiXRWjOOBR7iMgMc8f
	 QN03D9bk0Hz9RTaJQcVgvXoAZVk0itId4hbHk4DLWGyZE+QuWmr7+HuhZF4mvIabMY
	 UMPiiwVRhwE+A==
Date: Mon, 19 May 2025 17:09:50 +0100
From: Conor Dooley <conor@kernel.org>
To: adrianhoyin.ng@altera.com
Cc: dinguyen@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: snps,dw-axi-dmac: Add iommus
 dma-coherent and dma bit-mask quirk
Message-ID: <20250519-palm-clunky-d10f84e7f37d@spud>
References: <cover.1747630638.git.adrianhoyin.ng@altera.com>
 <c9d1ae618b43b328b3b8775334987e5acdaf2490.1747630638.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I/yCyKkPgBhExs6w"
Content-Disposition: inline
In-Reply-To: <c9d1ae618b43b328b3b8775334987e5acdaf2490.1747630638.git.adrianhoyin.ng@altera.com>


--I/yCyKkPgBhExs6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 01:09:38PM +0800, adrianhoyin.ng@altera.com wrote:
> From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
>=20
> Intel Agilex5 address bus only supports up to 40 bits. Add dma-bit-mask
> property to allow configuration of dma bit-mask size. Add iommu property
> for SMMU support. Add dma-coherent property for cache coherent support.
>=20
> Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>
> ---
>  .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml =
b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 935735a59afd..f0a54a1031e7 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -42,6 +42,9 @@ properties:
>      minItems: 1
>      maxItems: 8
> =20
> +  iommus:
> +    maxItems: 1
> +
>    clocks:
>      items:
>        - description: Bus Clock
> @@ -61,6 +64,8 @@ properties:
> =20
>    dma-noncoherent: true
> =20
> +  dma-coherent: true
> +
>    resets:
>      minItems: 1
>      maxItems: 2
> @@ -101,6 +106,14 @@ properties:
>      minimum: 1
>      maximum: 256
> =20
> +  snps,dma-bit-mask:

This property seems incorrectly named to me, from the description this
does not seem like a bitmask cos you cannot have a 64-bit bitmask in a
u32... Instead, this property is being fed into the DMA_BIT_MASK()
macro, and is actually just the number of bits to use for dma (as the
description correctly points out). Please adjust the naming accordingly.

> +    description:
> +      Defines the number of addressable bits for DMA.
> +      If this property is missing, the default 64bit will be used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 32
> +    maximum: 64

Missing a default: 64, that's what you should do rather than mention in
text form.

> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.49.GIT
>=20

--I/yCyKkPgBhExs6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCtXzgAKCRB4tDGHoIJi
0tz2AQCnwB3M/8X3IrZnzee4IP9Y4MKVCzK1K8sqwgJ9Tgq6cAD/S9iTRND7dhx0
2cdd9GZejRuC+l9gPIFgOmr2Pm39TA0=
=FKiq
-----END PGP SIGNATURE-----

--I/yCyKkPgBhExs6w--

