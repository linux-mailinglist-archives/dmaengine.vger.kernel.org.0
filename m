Return-Path: <dmaengine+bounces-1399-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E987DD6F
	for <lists+dmaengine@lfdr.de>; Sun, 17 Mar 2024 15:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FD51F212D9
	for <lists+dmaengine@lfdr.de>; Sun, 17 Mar 2024 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575861A38E5;
	Sun, 17 Mar 2024 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKtr+Dwe"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D6634;
	Sun, 17 Mar 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710686439; cv=none; b=cn+dUE46GHSd0kblsIxORBRfXfMe+nVp5lf0H+EJQPDqE6FbvIGwt/oxkortqURSceEUizukSJ1R8S1vj9qFYDFQIHy00QeCKQj8HIfLa5O0CCun7X+qWRJ1bl9QwpS1Wxb9sNhmb/G8DPFLR9GsCiJwO3nliUtI1lCjaMIebn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710686439; c=relaxed/simple;
	bh=8EuWl5V+QQMbWGcfJ2pFCZ8np3id+nvKGueBQOIkTFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzgk83gRUX6UiVTvPQwPyPl782t7kZtnZ0RLLSpPK6wPlRvHSoKHnYyrPV24x30f0JiVEGsyKS3xaEiF8v5CBfOWX3qo+OaD1YPkkGncqeoD5SsV2XBncMJ4LVmNiip7d6deYOgGbTOI3VGZzr4R7EhdYDW/UU9OSzxtbhhS+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKtr+Dwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2F5C433C7;
	Sun, 17 Mar 2024 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710686438;
	bh=8EuWl5V+QQMbWGcfJ2pFCZ8np3id+nvKGueBQOIkTFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKtr+DweepUvkz9XmC6s6tFfVLDvg3NJQ53mdAWpe7D57rIPu/ywL0XiBMLGKX0S1
	 w0LgwNXL+JoayFB/OD7Hl87yJ5gsLnAfXaZqQWsZ2MbQTzG4CEtHtR8qFweaMy6LkZ
	 Bo/tblRLYVQi30EClPIuDIKRlO3FBHSoxIxKvf8tJweM4BumHKAq2iDfLqdpKaCqBa
	 7oslql+2UK4x5jEhLgC4g/wo86z26AxjpXmY9VtW0rr8782SnrZwbv1OuUfpU14eSD
	 XHHUp7Yk2KnjPa5xyQ/ZO35a+q7scUxJaB4wsB2c5+TzfE5WPdnZbVsEk3PgdNL7ZJ
	 XOmNyRoDF5ymg==
Date: Sun, 17 Mar 2024 14:40:34 +0000
From: Conor Dooley <conor@kernel.org>
To: keguang.zhang@gmail.com
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: dma: Add Loongson-1 DMA
Message-ID: <20240317-exorcist-spectator-90f5acb3fe2a@spud>
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <20240316-loongson1-dma-v6-1-90de2c3cc928@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="irsz1jOWazJ+F7GF"
Content-Disposition: inline
In-Reply-To: <20240316-loongson1-dma-v6-1-90de2c3cc928@gmail.com>


--irsz1jOWazJ+F7GF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 07:33:53PM +0800, Keguang Zhang via B4 Relay wrote:
> From: Keguang Zhang <keguang.zhang@gmail.com>
>=20
> Add devicetree binding document for Loongson-1 DMA.
>=20
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V5 -> V6:
>    Change the compatible to the fallback
>    Some minor fixes
> V4 -> V5:
>    A newly added patch
> ---
>  .../devicetree/bindings/dma/loongson,ls1x-dma.yaml | 66 ++++++++++++++++=
++++++
>  1 file changed, 66 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml=
 b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> new file mode 100644
> index 000000000000..06358df725c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/loongson,ls1x-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-1 DMA Controller
> +
> +maintainers:
> +  - Keguang Zhang <keguang.zhang@gmail.com>
> +
> +description:
> +  Loongson-1 DMA controller provides 3 independent channels for
> +  peripherals such as NAND and AC97.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: loongson,ls1b-dma
> +      - items:
> +          - enum:
> +              - loongson,ls1c-dma
> +          - const: loongson,ls1b-dma

Aren't there several more devices in this family? Do they not have DMA
controllers?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Each channel has a dedicated interrupt line.
> +    minItems: 1
> +    maxItems: 3

Is this number not fixed for each SoC?

> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - pattern: ch0
> +      - pattern: ch1
> +      - pattern: ch2

Why have you made these a pattern? There's no regex being used here at
all.

Cheers,
Cono4.

--irsz1jOWazJ+F7GF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcA4gAKCRB4tDGHoIJi
0lP/AP47luMqgw9H62E5Kh4XOy3gFu5oK9MKoTJGSLIkYe8yOAEA1syRMF+H+Mkd
ellE3fp+DlhtlN/nYHEjn78JkaMscAU=
=eCSd
-----END PGP SIGNATURE-----

--irsz1jOWazJ+F7GF--

