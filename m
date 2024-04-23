Return-Path: <dmaengine+bounces-1936-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0F18AEAED
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 17:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65444285638
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A78413C839;
	Tue, 23 Apr 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrUlTSEm"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8F5820E;
	Tue, 23 Apr 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885732; cv=none; b=mnsdgZfeZHtS0j4ma6xdcQbHBZNXlIeLhh8RrkdbSbvYZslXYcwATdwmTaZVyC5Ri1sVih9b9P+EsoSCsofenbWh1ou52nlvMVQhdh0p9xxv8AHhWdjEaxfwpd6i0A+yLexbpojxzeeNsCdEe5lAJcDKbB5VVbfKu489kfsEKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885732; c=relaxed/simple;
	bh=ckdRXGNIvwKMnyRaf5FG0K/hkMCAzdQEnbjUWTuh2Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvT6bKXTQrTgiD2YoM9dOvZPWHoJ0lPGaSOuOMedjXK2m5So0oXCX4bX9EDcTzsX/iDT44BD3uV/Q3xIZVrsOtYRJcW026rBC6xFaVmyvsxKHHCZIzxMOqOQYtGqxE53WC1YLaB+0luL4IalZiM5w7o/VIrEHh7g3tRpBXOVK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrUlTSEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6652C116B1;
	Tue, 23 Apr 2024 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713885732;
	bh=ckdRXGNIvwKMnyRaf5FG0K/hkMCAzdQEnbjUWTuh2Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrUlTSEmO7wAG1Vx7ILRzfbopP2BCS5ofCH7r/97jibToM3DYik0p4RbpC+YTeiP2
	 yShsobB/4JGfSEeMXW44RxaMz8tOiwiIkeawcScoAt+Lodw8AeLpxeiLDvopx7EnNA
	 TVy6q7D4MVmbs3QwbEovo285A6w0nYYUhO3cr5betQa92hWZtH68L43IzkgO39F6d7
	 XMrDAArdQL6zRp/F4vDFPJcv9wedtrjhGU4Lt81bZbQ+ABjbjKr4Yr5EQxtVFy1/f6
	 w5oX720ri04WNyNvEEbfQa1c4SB6+vX6C+YnteZVfHhSzNlsewAbyWIXHkUTdzqX21
	 VQHaXTzy2VHHQ==
Date: Tue, 23 Apr 2024 10:22:09 -0500
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 04/12] dt-bindings: dma: Document STM32 DMA3 controller
 bindings
Message-ID: <20240423152209.GA318680-robh@kernel.org>
References: <20240423123302.1550592-1-amelie.delaunay@foss.st.com>
 <20240423123302.1550592-5-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423123302.1550592-5-amelie.delaunay@foss.st.com>

On Tue, Apr 23, 2024 at 02:32:54PM +0200, Amelie Delaunay wrote:
> The STM32 DMA3 is a Direct Memory Access controller with different features
> depending on its hardware configuration.
> The channels have not the same capabilities, some have a larger FIFO, so
> their performance is higher.
> This patch describes STM32 DMA3 bindings, used to select a channel that
> fits client requirements, and to pre-configure the channel depending on
> the client needs.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  .../bindings/dma/stm32/st,stm32-dma3.yaml     | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> new file mode 100644
> index 000000000000..ea4f8f6add3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/stm32/st,stm32-dma3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 DMA3 Controller
> +
> +description: |
> +  The STM32 DMA3 is a direct memory access controller with different features
> +  depending on its hardware configuration.
> +  It is either called LPDMA (Low Power), GPDMA (General Purpose) or
> +  HPDMA (High Performance).
> +  Its hardware configuration registers allow to dynamically expose its features.
> +
> +  GPDMA and HPDMA support 16 independent DMA channels, while only 4 for LPDMA.
> +  GPDMA and HPDMA support 256 DMA requests from peripherals, 8 for LPDMA.
> +
> +  Bindings are generic for these 3 STM32 DMA3 configurations.
> +
> +  DMA clients connected to the STM32 DMA3 controller must use the format described
> +  in the ../dma.txt file, using a four-cell specifier for each channel.
> +  A phandle to the DMA controller plus the following three integer cells:

This description should be part of #dma-cells.

> +    1. The request line number
> +    2. A 32-bit mask specifying the DMA channel requirements
> +      -bit 0-1: The priority level
> +        0x0: low priority, low weight
> +        0x1: low priority, mid weight
> +        0x2: low priority, high weight
> +        0x3: high priority
> +      -bit 4-7: The FIFO requirement for queuing source and destination transfers
> +        0x0: no FIFO requirement/any channel can fit
> +        0x2: FIFO of 8 bytes (2^2+1)
> +        0x4: FIFO of 32 bytes (2^4+1)
> +        0x6: FIFO of 128 bytes (2^6+1)
> +        0x7: FIFO of 256 bytes (2^7+1)
> +    3. A 32-bit mask specifying the DMA transfer requirements
> +      -bit 0: The source incrementing burst
> +        0x0: fixed burst
> +        0x1: contiguously incremented burst
> +      -bit 1: The source allocated port
> +        0x0: port 0 is allocated to the source transfer
> +        0x1: port 1 is allocated to the source transfer
> +      -bit 4: The destination incrementing burst
> +        0x0: fixed burst
> +        0x1: contiguously incremented burst
> +      -bit 5: The destination allocated port
> +        0x0: port 0 is allocated to the destination transfer
> +        0x1: port 1 is allocated to the destination transfer
> +      -bit 8: The type of hardware request
> +        0x0: burst
> +        0x1: block
> +      -bit 9: The control mode
> +        0x0: DMA controller control mode
> +        0x1: peripheral control mode
> +      -bit 12-13: The transfer complete event mode
> +        0x0: at block level, transfer complete event is generated at the end of a block
> +        0x2: at LLI level, the transfer complete event is generated at the end of the LLI transfer,
> +             including the update of the LLI if any
> +        0x3: at channel level, the transfer complete event is generated at the end of the last LLI
> +
> +maintainers:
> +  - Amelie Delaunay <amelie.delaunay@foss.st.com>
> +
> +allOf:
> +  - $ref: /schemas/dma/dma-controller.yaml#
> +
> +properties:
> +  "#dma-cells":
> +    const: 3
> +
> +  compatible:
> +    const: st,stm32-dma3

SoC specific compatible needed.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 4
> +    maxItems: 16

I assume this is 1 interrupt per channel? But I shouldn't have to 
assume. Either you need to list every interrupt out or you can keep this 
adding some description if they are all the type of interrupt (e.g. per 
channel).

> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    dma-controller@40400000 {
> +      compatible = "st,stm32-dma3";
> +      reg = <0x40400000 0x1000>;
> +      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&rcc CK_BUS_HPDMA1>;
> +      #dma-cells = <3>;
> +    };
> +...
> -- 
> 2.25.1
> 

