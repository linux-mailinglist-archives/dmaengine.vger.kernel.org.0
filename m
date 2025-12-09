Return-Path: <dmaengine+bounces-7549-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C381DCB1333
	for <lists+dmaengine@lfdr.de>; Tue, 09 Dec 2025 22:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3163230F8959
	for <lists+dmaengine@lfdr.de>; Tue,  9 Dec 2025 21:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B909C31A7F7;
	Tue,  9 Dec 2025 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifxuqgbi"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4C30E856;
	Tue,  9 Dec 2025 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315315; cv=none; b=plfiUAYP/dcH6XsEXg+xWzepnMXluokgKzrn2ZMUJrm9nhM9idY1aTxiAerGC3cnsBbz9hQlvX+Z+04+X+7+LM7Oh9zS2qXSNwlMfOT/0nsOOHno4j2vXI+uaxkJ/hO2tr8DXv6a1LJyvwJekhBlQH0kuVbgnZ3VREWeY77PyxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315315; c=relaxed/simple;
	bh=aOzN0wGw1DHRzBnSLWWtfycerLfPcbuHpGrDYMKFVMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCKF4nWtAqbPwtSHsjOlueVvwVna8oLPe/3/lSHB5Ys3FmWVNL+wIHzgHG3BB1fLfre/mpMb3yjctzR9kEO4a+aDPlCQIuzNFtOihgL7uyKWeShIb/bNWz9iJPZnpiHRh0mTHPqYwdmrRdPIsHyN9XlsOZiKMbceELPWgB7hTfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifxuqgbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDFFC4CEF5;
	Tue,  9 Dec 2025 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765315315;
	bh=aOzN0wGw1DHRzBnSLWWtfycerLfPcbuHpGrDYMKFVMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfxuqgbihooB8sWTh2eZILSbH3lrJX/hbV68bDigT9KUUBpWMH4puJ2kxuhpoOKjU
	 6UxDbxIdam7cTRRujUzOIToYiEvZotcXS4W6oYjQkyx1XYneRg1zLi1Tu9D1+NCdKV
	 szlBAOaqp3U8lFIpxgoY1DY2FFlDXh5SJiyT+WOAX8X+7btuIDhhYhUuVJN2VxaDtc
	 DxPJED4N9rgg/bjIsp2vQuUixwfCdwsTm4PrjlcxWLR5e5egsqRnxYFHzD8AefaagQ
	 oKuOKH5D3XypKfBmPKCZiJQkp1NEnMqBi8kfQSFpigk7WNfZCOn5lpMKAPCm5fydfq
	 etioegxkX8NBw==
Date: Tue, 9 Dec 2025 15:21:52 -0600
From: Rob Herring <robh@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: snps,dw-axi-dmac: Add
 compatible string for Agilex5
Message-ID: <20251209212152.GA1121752-robh@kernel.org>
References: <cover.1764927089.git.khairul.anuar.romli@altera.com>
 <09c56ccbd5b9cfa717c7901ac35d9235458bbc30.1764927089.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c56ccbd5b9cfa717c7901ac35d9235458bbc30.1764927089.git.khairul.anuar.romli@altera.com>

On Mon, Dec 08, 2025 at 09:57:42AM +0800, Khairul Anuar Romli wrote:
> The address bus on Agilex5 is limited to 40 bits. When SMMU is enable this
> will cause address truncation and translation faults. Hence introducing
> "altr,agilex5-axi-dma" to enable platform specific configuration to
> configure the dma addressable bit mask.
> 
> Add a fallback capability for the compatible property to allow driver to
> probe and initialize with a newly added compatible string without requiring
> additional entry in the driver.
> 
> Add dma-ranges to the binding schema to allow specifying DMA address
> mapping between the controller and its parent bus.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v2:
> 	- Add dma-ranges
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 23 +++++++++++++++----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index a393a33c8908..1a1800d9b544 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -17,11 +17,15 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - snps,axi-dma-1.01a
> -      - intel,kmb-axi-dma
> -      - starfive,jh7110-axi-dma
> -      - starfive,jh8100-axi-dma
> +    oneOf:
> +      - enum:
> +          - snps,axi-dma-1.01a
> +          - intel,kmb-axi-dma
> +          - starfive,jh7110-axi-dma
> +          - starfive,jh8100-axi-dma
> +      - items:
> +          - const: altr,agilex5-axi-dma
> +          - const: snps,axi-dma-1.01a
>  
>    reg:
>      minItems: 1
> @@ -104,6 +108,15 @@ properties:
>      minimum: 1
>      maximum: 256
>  
> +  dma-ranges:
> +    description: |
> +      Describe memory addresses translation between the DMA address and the
> +      CPU address. Each memory region, is declared with 3-6 32-bit cells
> +      parameters:
> +        - param 1: device base address
> +        - param 2: physical base address
> +        - param 3: size of the memory region.

No need to generically describe dma-ranges. Just 'dma-ranges: true' 
unless you define constaints on the number of entries or want to put 
some description about why it is needed here.

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.43.7
> 

