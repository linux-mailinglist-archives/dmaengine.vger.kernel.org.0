Return-Path: <dmaengine+bounces-5046-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FEAAA6C13
	for <lists+dmaengine@lfdr.de>; Fri,  2 May 2025 09:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAABF1BA2AC8
	for <lists+dmaengine@lfdr.de>; Fri,  2 May 2025 07:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A22266B77;
	Fri,  2 May 2025 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDfSpXFc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB5F2BB13;
	Fri,  2 May 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746172728; cv=none; b=q1pojwbC707UvVbxdfsNx67YSE7iQvS8Vjn6N4sehhBmIUw4Y1ehL7DjpGk8GIbGEcwUbykX3EGNoao/TLQVTmMzQUHjQWvrr8NgEyxmRdExPiC6m2hxBDviSQReD1Mx85wuSh0Ck7Lb6npOOXN9YRqupz0M6AAD/uwSSTzR1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746172728; c=relaxed/simple;
	bh=Bks/IXRrnO56d/u9kmjniZJHwryYfuhVSZbHIvNCFhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8TxznmV5nvqF41bb6bZYCfc8forVtCNrmzyf9sCUFuftwlVYF6zdJWIU2PkONmb14z8cudUWCr8y5vxDt0jOFv8QqICZRDFTZ4THSFtWzFKc8prd1tVZV7b2e2c0/ypgTRhiphxgi6RsDdVVvk6nPaE9ESw1T5+eZn8PMhYMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDfSpXFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BC7C4CEE4;
	Fri,  2 May 2025 07:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746172728;
	bh=Bks/IXRrnO56d/u9kmjniZJHwryYfuhVSZbHIvNCFhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDfSpXFc/tl2zJxLM+UIlti0OMiWjPiozjXL4MdTv/1DB8nPLs3DM5SmE25wGSEkN
	 7H1bT0FoWGr2s4XIkhCzaFYsxxuG4zIRAmxPeZtVUZlrVs7RZEfQaVeOC1rooTKaTG
	 AkupqShRLST2/bsa9Ir3EcC3HBOq9vtPBHwo1PAyCiiWr4ybapxGZjnDYoivyz1DCl
	 5niaRTY+Y9ijxtFfEEg5EObxtSowrsJla6jIqVwzQ+qX4aSiGElGHe7Yuz/oBFYSOD
	 NIS9hYEuRAuNrjUCwJu7X6eSDCkZ7f8+VSzozxXLOylC754jsxcVAygU7RZHOyV1nn
	 qx+nQ0rrYJsXw==
Date: Fri, 2 May 2025 09:58:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: convert text based binding to json
 schema
Message-ID: <20250502-lush-resolute-cheetah-a8ceee@kuoka>
References: <20250501-nvidea-dma-v1-1-a29187f574ba@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250501-nvidea-dma-v1-1-a29187f574ba@gmail.com>

On Thu, May 01, 2025 at 01:12:36PM GMT, Charan Pedumuru wrote:
> Update text binding to YAML.
> Changes during conversion:
> - Add a fallback for "nvidia,tegra30-apbdma" as it is
>   compatible with the IP core on "nvidia,tegra20-apbdma".
> - Update examples and include appropriate file directives to resolve
>   errors identified by `dt_binding_check` and `dtbs_check`.
> 

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Missing final nvidia,tegra20-apbdma prefix.


> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>  .../bindings/dma/nvidia,tegra20-apbdma.txt         | 44 -----------
>  .../bindings/dma/nvidia,tegra20-apbdma.yaml        | 90 ++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 44 deletions(-)
> 

...

> +$id: http://devicetree.org/schemas/dma/nvidia,tegra20-apbdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra APB DMA Controller
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The NVIDIA Tegra APB DMA controller is a hardware component that
> +  enables direct memory access (DMA) on Tegra systems. It facilitates
> +  data transfer between I/O devices and main memory without constant
> +  CPU intervention.
> +
> +maintainers:
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra20-apbdma
> +      - items:
> +          - const: nvidia,tegra30-apbdma
> +          - const: nvidia,tegra20-apbdma
> +
> +  "#dma-cells":
> +    description:
> +      Must be <1>. This dictates the length of DMA specifiers
> +      in client node's dmas properties.

Drop description, you are not telling here anything new except
explaining basically DT syntax.

> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1

reg is the second property. Old binding even had it correct.

> +
> +  interrupts:
> +    description:
> +      Should contain all of the per-channel DMA interrupts in
> +      ascending order with respect to the DMA channel index.
> +    minItems: 1
> +    maxItems: 32
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: dma
> +
> +required:
> +  - compatible
> +  - reg

And here the order is correct...

> +  - interrupts
> +  - clocks

But here different. Keep the same order as in properties.

> +  - resets
> +  - reset-names
> +  - "#dma-cells"
> +

missing allOf: to dma-controller

> +additionalProperties: false

unevaluatedProperties instead. Just open any other DMA binding.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>

You included this...

> +    #include <dt-bindings/reset/tegra186-reset.h>
> +    dma@6000a000 {

Doesn't look like correct name. Schema requires specific name.

> +        compatible = "nvidia,tegra30-apbdma", "nvidia,tegra20-apbdma";
> +        reg = <0x6000a000 0x1200>;
> +        interrupts = <0 136 0x04>,

... so use it.

Best regards,
Krzysztof


