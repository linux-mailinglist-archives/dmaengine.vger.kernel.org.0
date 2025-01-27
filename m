Return-Path: <dmaengine+bounces-4216-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20122A1DD87
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 21:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AC71653B7
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2025 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1312195811;
	Mon, 27 Jan 2025 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khvpONAK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FDB18E756;
	Mon, 27 Jan 2025 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738010775; cv=none; b=jh0EpkYMOdr2IZmfq8aJvXHayzQ0Ma+UhefVG9VdSWIcNMUJuo4N104lI6L3khLnFS4qjFOs4M/U1wxlDA6mo5jR0T9FaN7VeC8EDs7AkC5TQMRLXCB0Ui9G7kL3J+jEegfQWCnGM/cIfktPB/dnoGtJSTjip85pLEHI5gmQwhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738010775; c=relaxed/simple;
	bh=xcZUmOduASjcFU2l+TPt7JE9O9AsRQh+pMzUv+ptJHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt8rUsdvMagcjYc8WN591KIIAjBE0pFu6y/4WCahc0s5kqRXn/LxzYKvKwtSEZGiWylAfu93rK1p0TvinCIGfhh/NNvjrfvkYB0omg9gTrkZvGfA87T+HZVEneHcNjb/AVXbaL25V82KVw2EGnK4CXpXVYWa5LlQNaAgotVAf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khvpONAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FFCC4CED2;
	Mon, 27 Jan 2025 20:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738010774;
	bh=xcZUmOduASjcFU2l+TPt7JE9O9AsRQh+pMzUv+ptJHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khvpONAKiR1DtKZJ2UCgl6U//jcW6XTfUiAFHlfEAxRNNbH1etcuw5z/RLFswNQR/
	 cHA5zIBXfElNqzx8lODH7OlPxDw5X6Zr3Yp+yUBNKTJmRj7IVFuaUAE5DJY7g7Oes1
	 NYDIwT9Ihoxs9wXaCFbw+OGCysISDtjJ6PPuwZvyNOsirwGdUXUdJ0CqUqhBZntH7u
	 6UpTp+Br+j4tnZbPBuMC8Bic9LHs7SltPvxXwGPSX6WqbamHj9TUpj1TV4v/im+Yza
	 pAUH/Ro999TQ5aClY+4VUUXZYsc7JisZ1EPxiZydP8EGMjiEE0zcviV7zXm5rtsU6t
	 wSIldBurN9vmA==
Date: Mon, 27 Jan 2025 14:46:13 -0600
From: Rob Herring <robh@kernel.org>
To: Charan Pedumuru <charan.pedumuru@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: dma: convert atmel-dma.txt to YAML
Message-ID: <20250127204613.GA820642-robh@kernel.org>
References: <20250127-test-v3-1-1b5f5b3f64fc@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127-test-v3-1-1b5f5b3f64fc@microchip.com>

On Mon, Jan 27, 2025 at 03:51:58PM +0530, Charan Pedumuru wrote:
> From: Durai Manickam KR <durai.manickamkr@microchip.com>
> 
> Add a description, required properties, appropriate compatibles and
> missing properties like clocks and clock-names which are not defined in
> the text binding for all the SoCs that are supported by microchip.
> Update the text binding name `atmel-dma.txt` to
> `atmel,at91sam9g45-dma.yaml` for the files which reference to
> `atmel-dma.txt`. Drop Tudor name from maintainers.
> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
> ---
> Changes in v3:
> - Renamed the text binding name `atmel-dma.txt` to
>   `atmel,at91sam9g45-dma.yaml` for the files which reference to
>   `atmel-dma.txt`.
> - Removed `oneOf` and add a blank line in properties.
> - Dropped Tudor name from maintainers.
> - Link to v2: https://lore.kernel.org/r/20250123-dma-v1-1-054f1a77e733@microchip.com
> 
> Changes in v2:
> - Renamed the yaml file to a compatible.
> - Removed `|` and description for common properties.
> - Modified the commit message.
> - Dropped the label for the node in examples.
> - Link to v1: https://lore.kernel.org/all/20240215-dmac-v1-1-8f1c6f031c98@microchip.com
> ---
>  .../bindings/dma/atmel,at91sam9g45-dma.yaml        | 66 ++++++++++++++++++++++
>  .../devicetree/bindings/dma/atmel-dma.txt          | 42 --------------
>  .../devicetree/bindings/misc/atmel-ssc.txt         |  2 +-
>  MAINTAINERS                                        |  2 +-
>  4 files changed, 68 insertions(+), 44 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml b/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
> new file mode 100644
> index 000000000000..d6d16869b7db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/atmel,at91sam9g45-dma.yaml
> @@ -0,0 +1,66 @@
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
> +
> +description:
> +  The Atmel Direct Memory Access Controller (DMAC) transfers data from a source
> +  peripheral to a destination peripheral over one or more AMBA buses. One channel
> +  is required for each source/destination pair. In the most basic configuration,
> +  the DMAC has one master interface and one channel. The master interface reads
> +  the data from a source and writes it to a destination. Two AMBA transfers are
> +  required for each DMAC data transfer. This is also known as a dual-access transfer.
> +  The DMAC is programmed via the APB interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91sam9g45-dma
> +      - atmel,at91sam9rl-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    description:
> +      Must be <2>, used to represent the number of integer cells in the dmas
> +      property of client devices.

You failed to address Conor's comment on this. The above is useless 
because the schema says it is 2 and the description is for any #dma-cells. 

What's missing is answering "what do the 2 cells contain exactly?" That 
was captured in this text:

> -The three cells in order are:
> -
> -1. A phandle pointing to the DMA controller.
> -2. The memory interface (16 most significant bits), the peripheral interface
> -(16 less significant bits).
> -3. Parameters for the at91 DMA configuration register which are device
> -dependent:
> -  - bit 7-0: peripheral identifier for the hardware handshaking interface. The
> -  identifier can be different for tx and rx.
> -  - bit 11-8: FIFO configuration. 0 for half FIFO, 1 for ALAP, 2 for ASAP.

Adapt this for the description. (Note it is phandle plus 2 cells, not 3 
cells, so you *can* omit the phandle part.)

Rob

