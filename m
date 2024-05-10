Return-Path: <dmaengine+bounces-2025-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEE78C2B84
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 23:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C8A1F257C6
	for <lists+dmaengine@lfdr.de>; Fri, 10 May 2024 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313DC13B58E;
	Fri, 10 May 2024 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjsmvqaT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62150A93;
	Fri, 10 May 2024 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715375288; cv=none; b=Sh4KUdfowHZIkXdFNSvxjirEOvSbXJiNYAEmETjo1SHNmuN2iNKnLb1tPKbxQ2BT+bJamk5284uEc9Nuy6QFC+/GYZGT9h7Mu1wVmg00SzhjICcNrBwDbjEvAPXQY9YlS6DlaZk8uj15mfSKBlW/Sh5YGIVXy6TAl6+p0wuk3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715375288; c=relaxed/simple;
	bh=iuyU2fi3wbAe6BlxGsKzyO7Cs/+6WA8IXxbgGdJ7t28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFYv8/mBUK2Mmnp8oY9+mPCMEEAfiuYl515XzX9bAu291wEiq9r6Q2whwW40i98lCMbkqP8wUyBCPYtasaLrffXJRX6/uWumCybmWj6K/xGpjlRLVHLjhdgu8gssFVzVnSLWCsLFmbiibAo0wOb267ae7JmaIil7aH2CvlcnxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjsmvqaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B14CC113CC;
	Fri, 10 May 2024 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715375287;
	bh=iuyU2fi3wbAe6BlxGsKzyO7Cs/+6WA8IXxbgGdJ7t28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjsmvqaTp7p9qTQs1z4KIaeUU9+6/mB7ODhfe0HnUXmxk1X3zijVvAr0FAuZrOP3T
	 qhNVv3o0hoqc2p2POO4n/HvE9r4Et4jqPbAoP+RXY/rdItpLcTZk25zMxgJ/4vLECn
	 6wCb683NNGI03Ry8YUzcd4WI6J4a7S6f5jje8Mp22JVP1LviIEKxDSP8J5d0eLQogN
	 QBUq6wbi34Ohz180vu00W2JBLLaBoc4ZZpeaEmxlZS2tbOJifj0zFzlrWnFfrb3+F8
	 DxMdLtwWNaBZOAvgpPLBxtzs4bffRi8YbcsQSsKHY8np1OZfzjZVcwZmUpEU5ok1yx
	 ptLNjczT19OwA==
Date: Fri, 10 May 2024 16:08:06 -0500
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
Subject: Re: [PATCH v2 04/12] dt-bindings: dma: Document STM32 DMA3
 controller bindings
Message-ID: <20240510210806.GA746731-robh@kernel.org>
References: <20240507125442.3989284-1-amelie.delaunay@foss.st.com>
 <20240507125442.3989284-5-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507125442.3989284-5-amelie.delaunay@foss.st.com>

On Tue, May 07, 2024 at 02:54:34PM +0200, Amelie Delaunay wrote:
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
> v2:
> - DMA controller specific information description has been moved and
>   added as description of #dma-cells property
> - description has been added to interrupts property specifying the
>   expected format for channel interrupts
> - compatible has been updated to st,stm32mp25-dma3 (SoC specific)
> ---
>  .../bindings/dma/stm32/st,stm32-dma3.yaml     | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> new file mode 100644
> index 000000000000..ed2a84fe2535
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/stm32/st,stm32-dma3.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/stm32/st,stm32-dma3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 DMA3 Controller
> +
> +description: |
> +  The STM32 DMA3 is a direct memory access controller with different features depending on its
> +  hardware configuration.
> +  It is either called LPDMA (Low Power), GPDMA (General Purpose) or HPDMA (High Performance).
> +  Its hardware configuration registers allow to dynamically expose its features.
> +
> +  GPDMA and HPDMA support 16 independent DMA channels, while only 4 for LPDMA.
> +  GPDMA and HPDMA support 256 DMA requests from peripherals, 8 for LPDMA.
> +
> +  Bindings are generic for these 3 STM32 DMA3 configurations.
> +
> +  DMA clients connected to the STM32 DMA3 controller must use the format described in "#dma-cells"
> +  property description below, using a three-cell specifier for each channel.

Wrap lines at 80 unless there is some exception to go to 100.

> +
> +maintainers:
> +  - Amelie Delaunay <amelie.delaunay@foss.st.com>
> +
> +allOf:
> +  - $ref: /schemas/dma/dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-dma3
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 4
> +    maxItems: 16
> +    description: |

Don't need '|' if no formatting to preserve.

With those fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


> +      Should contain all of the per-channel DMA interrupts in ascending order with respect to the
> +      DMA channel index.

