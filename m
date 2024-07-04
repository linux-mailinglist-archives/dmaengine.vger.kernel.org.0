Return-Path: <dmaengine+bounces-2624-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42221927B5E
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 18:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D66B22E70
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEDF1B29C0;
	Thu,  4 Jul 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alD/m3LG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424021AE859;
	Thu,  4 Jul 2024 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111364; cv=none; b=tFUsdI8WHjv/iTNQe6yKNfuzwUMD031hS02MOMCPdcibk+1hx+tpheUjN/SteX3PpMKAaT8p7wsNPyNur/dh7Oh1wjTk56hWAZ5fj+8e1Wd20oGPwVBA4ELOJSBViowXsqzVphlRbDGbob1GnCnwKkxZq37s7e1zDjDqN1YTZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111364; c=relaxed/simple;
	bh=eeSRZPc0GFcTVhsv3N5E/PNUztswCxlsehpY3IxZYqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i019gZQ6VC4LgC3kQXVXbVwZJ94+M22sDkEA7iono1ZE5wS0nHnUg7Xm1qn+24RDUODBiivhuR8KapSOyazAzOqWQRtEjjHc58+p138ylM8ml518PwN/TvZ4CRFMpHKFOIIda4WCEc1NrZIE9wUD2EwiPRXNO+gI+T2wBTxa/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alD/m3LG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FA7C3277B;
	Thu,  4 Jul 2024 16:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720111363;
	bh=eeSRZPc0GFcTVhsv3N5E/PNUztswCxlsehpY3IxZYqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alD/m3LGZJUsUSGCOKaTtVruY9uKZRjC3G6ua+uGy8J4/gWgLaMt15SwwAEwwa9mZ
	 XDtXWucktidAl03ZKoOQdoW3k447HQJwRnYQrykcfKjZlhXAuONXu9kNbVyTglnuQs
	 zK9WBnXADWuLzM/xwgh/ihdkBo7CxdsUZtu3Kbnv2EHSxzyqY057J0YpA5seGPkBX4
	 lyh0+vndl9O0/N6MrqADb6smVkNluqAzf3R+GKHIAHC5FqyCV0z+NeDgueV6fQG+D1
	 vqOfSk0Krkr5ohrN65WdmCjx5GgqOB4MomQUx5YEDC9i3C1cZ4FYVCp2J4gVqCJzZq
	 E1wHQbdeIzmFA==
Date: Thu, 4 Jul 2024 17:42:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: sprd,sc9860-dma: convert to YAML
Message-ID: <20240704-underuse-preacher-b5bb77f92ebf@spud>
References: <Zoa9MfYsAuqgh2Vb@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KPS6unqfua+VIL9/"
Content-Disposition: inline
In-Reply-To: <Zoa9MfYsAuqgh2Vb@standask-GA-A55M-S2HP>


--KPS6unqfua+VIL9/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 05:18:09PM +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC9860 DMA bindings to DT schema.
>=20
> Changes during conversion:
>   - rename file to match compatible
>   - make interrupts optional, the AGCP DMA controller doesn't need it
>   - describe the optional ashb_eb clock for the AGCP DMA controller
>=20
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
>  .../bindings/dma/sprd,sc9860-dma.yaml         | 92 +++++++++++++++++++
>  .../devicetree/bindings/dma/sprd-dma.txt      | 44 ---------
>  2 files changed, 92 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/sprd,sc9860-dma=
=2Eyaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/sprd-dma.txt
>=20
> diff --git a/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml b=
/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
> new file mode 100644
> index 000000000000..e1639593d26d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/sprd,sc9860-dma.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/sprd,sc9860-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum SC9860 DMA controller
> +
> +description: |
> +  There are three DMA controllers: AP DMA, AON DMA and AGCP DMA. For AGCP
> +  DMA controller, it can or do not request the IRQ, which will save
> +  system power without resuming system by DMA interrupts if AGCP DMA
> +  does not request the IRQ.
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: sprd,sc9860-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    oneOf:
> +      - const: enable
> +      # The ashb_eb clock is optional and only for AGCP DMA controller
> +      - items:
> +          - const: enable
> +          - const: ashb_eb

This is better written as:
  clock-names:
    minItems: 1
    items:
      - const: enable
      - const: ashb_eb

> +
> +  '#dma-cells':
> +    const: 1
> +
> +  dma-channels:
> +    const: 32
> +
> +  '#dma-channels':
> +    const: 32
> +    deprecated: true

If there are no users of this, I'd be inclined to just drop it from the
binding.

Cheers,
Conor.

--KPS6unqfua+VIL9/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZobQ/wAKCRB4tDGHoIJi
0uRJAQC7IZ/CUR4rddC+6+XFL4PEWSqzi0Gxks2hITA+tHUbQgEAjyWszLz3QFCo
BdZ6EMVXHzRccKVfvyypfR9XKg6tWgk=
=jqib
-----END PGP SIGNATURE-----

--KPS6unqfua+VIL9/--

