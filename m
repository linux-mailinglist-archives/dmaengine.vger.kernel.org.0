Return-Path: <dmaengine+bounces-1762-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3179289B0F0
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 15:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F36F1C2093E
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB537160;
	Sun,  7 Apr 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCL8egCB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B525745;
	Sun,  7 Apr 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495047; cv=none; b=k7tfhrIiGOKK99gSVn7Gl8XvZo93KnMeHmN2jK4mp2LgX+zpmgMX5dQ+oFMKlSyI/ZHPr4lUE7Ky18o0FFv9Z/LeqFqPHLvMCc5yItnCxJMDnsOlWr9U9oY3vhuwjzYKNK30cSbPjovwWZaX8A/mm3ceGGbg0iNgCHMsCflnhL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495047; c=relaxed/simple;
	bh=yF0em7+RzPDN0jJHxiei/K8GcHR0GT2K/oI/lhIRxSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtljpQNv+xCEYIzf3IomeyPMbFNcTcgKw8VL+bVb3lm+JqJ/OIKz1Zw/Ot3RjRl3ir+Ccg6WIna/rnK82gQRlWr+Kk5xsRm4N9DWMqbNrFYJpQbwLoCmNzlWRw31reREK9QayURp54wQXr0PseehtxoPLwmLSo8JPSv/OcHHz5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCL8egCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7832AC43390;
	Sun,  7 Apr 2024 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495047;
	bh=yF0em7+RzPDN0jJHxiei/K8GcHR0GT2K/oI/lhIRxSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCL8egCBveInAmu0WP7u8xyNuTdFsyngB8kNXAfScBREoTjnK6XtvU3ZLkz58r0Lq
	 CEHoot0bCboYCUy71YbXTRxeiQeTOkx0TSF9heLS5XQcFJrARSWwZIJlU9eil/gA/f
	 ZupuS7lNBqaObti3V3tMPQ1qWyjjhc7/2rNkRrGXV3qhUoInZLGT8Kqvu+3wjJgi3n
	 TEJmgyBu3euBByeUohu+nzpWopL0vn/2XGqHLYdoxjmvSvmmfwp1aQ5I/gNXAOueJw
	 k2KB3KHNqUzJffo8DD0FPWRLmtg8sk99G3xQaBnBNKq+OVeMOQ+L6y2hIPnXwb9DTr
	 Y0fiWTDW3zrtw==
Date: Sun, 7 Apr 2024 18:34:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: snps,dma-spear1340: Fix data{-,_}width
 schema
Message-ID: <ZhKZwp4n7RYlprP-@matsya>
References: <20240311222522.1939951-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311222522.1939951-1-robh@kernel.org>

On 11-03-24, 16:25, Rob Herring wrote:
> 'data-width' and 'data_width' properties are defined as arrays, but the
> schema is defined as a matrix. That works currently since everything gets
> decoded in to matrices, but that is internal to dtschema and could change.

This fails to apply on dmaengine/next.

Can you please rebase?

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/dma/snps,dma-spear1340.yaml      | 38 +++++++++----------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> index 5da8291a7de0..7b0ff4afcaa1 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> @@ -93,10 +93,9 @@ properties:
>    data-width:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description: Data bus width per each DMA master in bytes.
> +    maxItems: 4
>      items:
> -      maxItems: 4
> -      items:
> -        enum: [4, 8, 16, 32]
> +      enum: [4, 8, 16, 32]
>  
>    data_width:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> @@ -106,28 +105,26 @@ properties:
>        deprecated. It' usage is discouraged in favor of data-width one. Moreover
>        the property incorrectly permits to define data-bus width of 8 and 16
>        bits, which is impossible in accordance with DW DMAC IP-core data book.
> +    maxItems: 4
>      items:
> -      maxItems: 4
> -      items:
> -        enum:
> -          - 0 # 8 bits
> -          - 1 # 16 bits
> -          - 2 # 32 bits
> -          - 3 # 64 bits
> -          - 4 # 128 bits
> -          - 5 # 256 bits
> -        default: 0
> +      enum:
> +        - 0 # 8 bits
> +        - 1 # 16 bits
> +        - 2 # 32 bits
> +        - 3 # 64 bits
> +        - 4 # 128 bits
> +        - 5 # 256 bits
> +      default: 0
>  
>    multi-block:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description: |
>        LLP-based multi-block transfer supported by hardware per
>        each DMA channel.
> +    maxItems: 8
>      items:
> -      maxItems: 8
> -      items:
> -        enum: [0, 1]
> -        default: 1
> +      enum: [0, 1]
> +      default: 1
>  
>    snps,max-burst-len:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> @@ -138,11 +135,10 @@ properties:
>        will be from 1 to max-burst-len words. It's an array property with one
>        cell per channel in the units determined by the value set in the
>        CTLx.SRC_TR_WIDTH/CTLx.DST_TR_WIDTH fields (data width).
> +    maxItems: 8
>      items:
> -      maxItems: 8
> -      items:
> -        enum: [4, 8, 16, 32, 64, 128, 256]
> -        default: 256
> +      enum: [4, 8, 16, 32, 64, 128, 256]
> +      default: 256
>  
>    snps,dma-protection-control:
>      $ref: /schemas/types.yaml#/definitions/uint32
> -- 
> 2.43.0

-- 
~Vinod

