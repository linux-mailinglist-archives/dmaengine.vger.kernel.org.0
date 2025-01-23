Return-Path: <dmaengine+bounces-4179-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E37F2A1A9C9
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2025 19:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9C16316B
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2025 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD28514D71A;
	Thu, 23 Jan 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcsoVOsY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8A15746B;
	Thu, 23 Jan 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657993; cv=none; b=FaP9I3UmfgdJz7vKUy/voZHuQMEekV5z1XlbWxRgJACcCGE8MNUotZlOqSdzJnF5uMRu5Qh0tHLlVXeAOfX79PnkE1vgs/l0uprCxnWMYBbf1a3vljUuRy0bYgOV97kbxdexNKcEwqjWKjswT1T5AnU1yezirTcQ0CawrYb2K9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657993; c=relaxed/simple;
	bh=xRs52lnDW+3EPY7W1diAkuIowIIBS5h+ZR8ZnRYlmzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9uFfdpItjVk2Gk6ufZi3UBT8/Mr75qbwEkUjAlm9WAnYET4l6MA7A0Df3WcMNrqrTLUP4wK1l/e0KJ/Xw2wK6095urI23e1TizFj9M8Zyie73c+fC8JMe5ty9xUaN9NRYs4XxySA6amndCZAjTDxLBB4+cngBVJOc+Jp6D1zBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcsoVOsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED4DC4CED3;
	Thu, 23 Jan 2025 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737657993;
	bh=xRs52lnDW+3EPY7W1diAkuIowIIBS5h+ZR8ZnRYlmzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcsoVOsYhlA3/ktn1A28fZL/qamOfSb69vNnRHZ+Coo/Dyd1ghedXYE9e7P5KTQBv
	 6l+StJwvpCLUY1SXLif+6kXE8Xl3Dx1sQrUM54AhbIVrIdcp1bO2jTrTSdbaF/G0SX
	 gA7HVvE2W/1WIPVBs7FPUtuRp9rGHrZm1acQaDeNvcwaqzsE89NOm4fotvusPNtUOB
	 8tnW9GHA3+n6fuXfIR6JtkSgBZmyv7KOPS1N29/0k5GS9HPb68Vgu+LAswGZVLamGs
	 2UZZu7k+soKHtupNJN2ML6a+31dkrTpplwEOplV1m2glK3C24TwdAbzVMc1X7jizCE
	 fOYbvYaX3TdEw==
Date: Thu, 23 Jan 2025 18:46:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Charan Pedumuru <charan.pedumuru@microchip.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: Re: [PATCH v2] dt-bindings: dma: convert atmel-dma.txt to YAML
Message-ID: <20250123-crucial-yelp-de4a63b0e3b5@spud>
References: <20250123-dma-v1-1-054f1a77e733@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="USuX8QMl72gqtfih"
Content-Disposition: inline
In-Reply-To: <20250123-dma-v1-1-054f1a77e733@microchip.com>


--USuX8QMl72gqtfih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 02:58:01PM +0530, Charan Pedumuru wrote:
> From: Durai Manickam KR <durai.manickamkr@microchip.com>
>=20
> Add a description, required properties, appropriate compatibles and
> missing properties like clocks and clock-names which are not defined in
> the text binding for all the SoCs that are supported by microchip.
>=20
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
> ---
> Changes in v2:
> - Renamed the yaml file to a compatible.
> - Removed `|` and description for common properties.
> - Modified the commit message.
> - Dropped the label for the node in examples.
> - Link to v1: https://lore.kernel.org/all/20240215-dmac-v1-1-8f1c6f031c98=
@microchip.com
> ---
>  .../bindings/dma/atmel,at91sam9g45-dma.yaml        | 67 ++++++++++++++++=
++++++
>  .../devicetree/bindings/dma/atmel-dma.txt          | 42 --------------
>  2 files changed, 67 insertions(+), 42 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.=
yaml b/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
> new file mode 100644
> index 000000000000..8d0d68786cbc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/atmel,at91sam9g45-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Direct Memory Access Controller (DMA)
> +
> +maintainers:
> +  - Ludovic Desroches <ludovic.desroches@microchip.com>
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>
> +
> +description:
> +  The Atmel Direct Memory Access Controller (DMAC) transfers data from a=
 source
> +  peripheral to a destination peripheral over one or more AMBA buses. On=
e channel
> +  is required for each source/destination pair. In the most basic config=
uration,
> +  the DMAC has one master interface and one channel. The master interfac=
e reads
> +  the data from a source and writes it to a destination. Two AMBA transf=
ers are
> +  required for each DMAC data transfer. This is also known as a dual-acc=
ess transfer.
> +  The DMAC is programmed via the APB interface.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:

compatible:
 enum:

You only have one option in your oneOf list.

> +          - atmel,at91sam9g45-dma
> +          - atmel,at91sam9rl-dma

Blank line here please.

> +  reg:
> +    maxItems: 1

--USuX8QMl72gqtfih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5KOgwAKCRB4tDGHoIJi
0t3xAP9LuhUuGfr5V4YXaUTK/z6aZn5QphsTGsu+j2FxTWKPBwEA2L8ZpbVYVkzA
sY6/DEzfAl4U+5LlJFfTSIilXui4xAk=
=UYo6
-----END PGP SIGNATURE-----

--USuX8QMl72gqtfih--

