Return-Path: <dmaengine+bounces-1663-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CE38920A6
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 16:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C871C277E0
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFFC11182;
	Fri, 29 Mar 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPuJTw+U"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E21DDEA;
	Fri, 29 Mar 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726862; cv=none; b=M1QIVgw4prWTQk4WXsc3K57sYUJ8/tMq/rL0NePo8xAlW6QBUFUVZtma3n0M035jBycazgXPv6oeHJRZ1nR31inZ1WFGaF2s9yTdLqPD+EyUPzSo4nn0rn2WSo4f8aZounGhXCUHVP58pLBeQlz6wMKrJUxV2IcT6QvL6kCOYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726862; c=relaxed/simple;
	bh=bzeVKulJy/hP5GNpCoE2RYDk0i6XfvDfXpyD/AV4Lg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQWneDmnPQ/u7ICo2vjUJMcQ1CBZATdtzV2Gqiz9WEQGaUGD3us2yG6C94EgARiks47bVZrE9PlTPFlj6HIqZVbVgFxNDYUhBT+h/iKZchCQKxEgN6xLZYfEC7ipt7PyVA0Un0yiCjhLUuj6CYiUJPKUcDvsYcF5uS26v3aBOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPuJTw+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B77EC433F1;
	Fri, 29 Mar 2024 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711726861;
	bh=bzeVKulJy/hP5GNpCoE2RYDk0i6XfvDfXpyD/AV4Lg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPuJTw+U4Lwdm2PhfqOl7arf9uQWMGDioUT4VPWqocBfmxF5bvrua6lI0nk5bEpF6
	 S23TW/S8CiFM5Qf3RMQp6KaLR0dTfRYMP/FLCCA7LVkJ6+zws5TeYnIyJSuS9a+FED
	 WrMiY4ehrh6eoBrpVMO4ehijdQ9ocyo77sA1L93U7RRM9jgtR0pZw18rx8CfF/7q8y
	 J8aJWUSCZZg5OgGscongYcMrs+CBY3zwtHztIpc42MFTTbCB6JG8fhtiuNJjXjEaGu
	 +teoxnY9ElCdOZN+j29yFxogg4puEYmznow+hseIeYDj+UW25btqU4GNSA3z5emh9K
	 v9GWw22lvHLxg==
Date: Fri, 29 Mar 2024 15:40:57 +0000
From: Conor Dooley <conor@kernel.org>
To: keguang.zhang@gmail.com
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: dma: Add Loongson-1 APB DMA
Message-ID: <20240329-destruct-giggling-b27e373295ba@spud>
References: <20240329-loongson1-dma-v7-0-37db58608de5@gmail.com>
 <20240329-loongson1-dma-v7-1-37db58608de5@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0+H86LmlfZrUlS4b"
Content-Disposition: inline
In-Reply-To: <20240329-loongson1-dma-v7-1-37db58608de5@gmail.com>


--0+H86LmlfZrUlS4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 07:26:57PM +0800, Keguang Zhang via B4 Relay wrote:
> From: Keguang Zhang <keguang.zhang@gmail.com>
>=20
> Add devicetree binding document for Loongson-1 APB DMA.
>=20
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> Changes in v7:
> - Change the comptible to 'loongson,ls1*-apbdma' (suggested by Huacai Che=
n)
> - Update the title and description part accordingly
> - Rename the file to loongson,ls1b-apbdma.yaml
> - Add a compatible string for LS1A
> - Delete minItems of 'interrupts'
> - Change patterns of 'interrupt-names' to const
>=20
> Changes in v6:
> - Change the compatible to the fallback
> - Some minor fixes
>=20
> Changes in v5:
> - A newly added patch
> ---
>  .../bindings/dma/loongson,ls1b-apbdma.yaml         | 65 ++++++++++++++++=
++++++
>  1 file changed, 65 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1b-apbdma.y=
aml b/Documentation/devicetree/bindings/dma/loongson,ls1b-apbdma.yaml
> new file mode 100644
> index 000000000000..449da9fc2de1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/loongson,ls1b-apbdma.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/loongson,ls1b-apbdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-1 APB DMA Controller
> +
> +maintainers:
> +  - Keguang Zhang <keguang.zhang@gmail.com>
> +
> +description:
> +  Loongson-1 APB DMA controller provides 3 independent channels for
> +  peripherals such as NAND, audio playback and capture.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: loongson,ls1b-apbdma
> +      - items:
> +          - enum:
> +              - loongson,ls1a-apbdma
> +              - loongson,ls1c-apbdma
> +          - const: loongson,ls1b-apbdma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Each channel has a dedicated interrupt line.

If there's a respin, make this an items list. If you do, you can then
drop the maxItems and description. Ideally with that change made,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--0+H86LmlfZrUlS4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgbhCQAKCRB4tDGHoIJi
0obNAQDHSnU+L7QN0TvySd5Y0LJgYUIxoxrj+cqFE3M6JzCtuwD/elNAaXBx1lsH
jQzAYajJtRWsOWzHjRne3oSnDKRFmAg=
=Mb/N
-----END PGP SIGNATURE-----

--0+H86LmlfZrUlS4b--

