Return-Path: <dmaengine+bounces-3330-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E05E998FA7
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 20:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCFC1C23159
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B31CDFD3;
	Thu, 10 Oct 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr0HYA5P"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F270193419;
	Thu, 10 Oct 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584208; cv=none; b=DUU6UBtPJlYEEzwQb2bu5jp5kH9Is6QMUmCXGwyl4bomXcZbSglHEU8nKldVfvJaG2bdHilcsn6WtYwijcKTTI955NLbGwgEePgmv5R3HCgZquDveh9iR1pFZpKGd/h4IBEwG7f3WwqivX0pEoDesv2sxJ7c0ugLqRwmV5dQxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584208; c=relaxed/simple;
	bh=xPm3PVW2xYEBnBhwN7Jk99JqhG0NN+6Z1eKHd0Tobmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ7N2LwiZip4Qph92a4Nw6QSGwmXDCP7y9oDSTUlG/CJ0QJD3te3QKvUh5QhxM0aLoDVXb1DaqoPDcpVYTsTCgOiLTS1Aq+iOwDkYZs+juXJeuY0fNgViS+Jsr6/7t95dexSXzm6ghqbcw9vMWxv7kbC9ZzgvYDp8UrAxrJctJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr0HYA5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8424CC4CEC5;
	Thu, 10 Oct 2024 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728584207;
	bh=xPm3PVW2xYEBnBhwN7Jk99JqhG0NN+6Z1eKHd0Tobmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tr0HYA5P2vYjIUDOUUHyBLgzLQ1gkXFeLRYVluR6DGw91nprWgbXC1DJvQkEBaV84
	 vcLFsUzxvgenW8U18YWY4HkKah/7osO6XgaGqFv1eLfIBa9TkQNeXiQDGlRM73qtMt
	 +lPyDCn1sUr+2qwpjeE9Gb/MjsPEe/jifyiZCkkkcByl6pZTdFNv12hT+37TC15iTb
	 VWDidTouIS9qWl25HjBYOA5h6gRl7TxWAO8mpoSFl8HgaWoNK0JK3IXu99e2QQiZnl
	 JR4rgf7wR9JeXCFi580jcPyY5MTNVBCfvjBJjrNkY8OcRsUBuT4fHVOziEMXXwNMpJ
	 8/8XNQZZWYuzA==
Date: Thu, 10 Oct 2024 13:16:45 -0500
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] dt-bindings: dma: stm32-dma3: introduce
 st,axi-max-burst-len property
Message-ID: <20241010181645.GA2121939-robh@kernel.org>
References: <20241010-dma3-mp25-updates-v1-0-adf0633981ea@foss.st.com>
 <20241010-dma3-mp25-updates-v1-6-adf0633981ea@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-dma3-mp25-updates-v1-6-adf0633981ea@foss.st.com>

On Thu, Oct 10, 2024 at 04:27:56PM +0200, Amelie Delaunay wrote:
> DMA3 maximum burst length (in unit of beat) may be restricted depending
> on bus interconnect.
> 
> As mentionned in STM32MP2 reference manual [1], "the maximum allowed AXI
> burst length is 16. The user must set [S|D]BL_1 lower or equal to 15
> if the Source/Destination allocated port is AXI (if [S|D]AP=0)".

This should be implied by the SoC specific compatible.

> 
> Introduce st,axi-max-burst-len. If used, it will clamp the burst length
> to that value if AXI port is used, if not, the maximum burst length value
> supported by DMA3 is used.
> 
> [1] https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  .../devicetree/bindings/dma/stm32/st,stm32-dma3.yaml          | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> index 38c30271f732e0c8da48199a224a88bb647eeca7..90ad70bb24eb790afe72bf2085478fa4cec60b94 100644
> --- a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> +++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> @@ -51,6 +51,16 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  st,axi-max-burst-len:
> +    description: |
> +      Restrict AXI burst length in unit of beat by value specified in this property.
> +      The value specified in this property is clamped to the maximum burst length supported by DMA3.
> +      If this property is missing, the maximum burst length supported by DMA3 is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 256
> +    default: 64
> +
>    "#dma-cells":
>      const: 3
>      description: |
> @@ -137,5 +147,6 @@ examples:
>                     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>        clocks = <&rcc CK_BUS_HPDMA1>;
>        #dma-cells = <3>;
> +      st,axi-max-burst-len = <16>;
>      };
>  ...
> 
> -- 
> 2.25.1
> 

