Return-Path: <dmaengine+bounces-7571-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3776CB65FB
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 16:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7FE301E14E
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C9D313294;
	Thu, 11 Dec 2025 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfvCS6+t"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501A309DC4;
	Thu, 11 Dec 2025 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765467969; cv=none; b=GobRBalB+OPqyr/OcCVALyaFtT8o1hrY/WjcCNIUlAuudCisgzW06xex51QusxN6D9c9UnmQTSy0Kf0BXiTgNRHZHI0j86owudWpwP8MD7OxQlKijh1KDTGYvZehHjMMAIMA+G+UNQVmot6MHrwGNPF2v8KF9GtGYQgtdo+vK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765467969; c=relaxed/simple;
	bh=PfBG80RN7262mEQOLmBr2avLG5hAVKp75w6T3XnvR1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnENc+Zew1Sq1ZTnk/h1fU5sHzSWkA48S1CCj5b1P2wgMIsXlyeJSglUDHP6Ljt7haHWpe12lHTYMmzv2AwAiv4FQpm1kjy6ulF2/QFNS5OIsxDZq8JbObcNkhFp/fkNVTpXr1aJq63C6PZEzLDCBZfntQ3Yq/Y01jmsoZ0gh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfvCS6+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D9EC4CEFB;
	Thu, 11 Dec 2025 15:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765467967;
	bh=PfBG80RN7262mEQOLmBr2avLG5hAVKp75w6T3XnvR1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfvCS6+tBOA0hZo7ktdcjzeS3HhlHWBgGQVp+LM2Y3XPIJhRhkSvGIvZm1jlOF6kw
	 40IHwJcDnLIQ1EMMhn4QkhlZ069Z5STKIO6BiOyMqLsrRN61x3gimyTeqmGL+qir+n
	 7E0pFt3AIwBNJGnZX6I9nJ6Sx9TnxL1l3mv30jJeMWq7bI1PHRoHf0P4f7+w0aYVO2
	 LKsmdy+CQxCRdhE3Xjw8CDEXfXPZGKbp4sRPXm4GItTeCf5e6GGg1yNkwRqcEV03Ex
	 9RWV/AyZ/xxDAx1tiiynY1aB61AvB5XEpeTkkUWF3duNjna4OzGIKPX6z6WlhT9rAw
	 xBClxMrvlloBQ==
Date: Thu, 11 Dec 2025 09:46:04 -0600
From: Rob Herring <robh@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add
 compatible string for Agilex5
Message-ID: <20251211154604.GB1464056-robh@kernel.org>
References: <cover.1765425415.git.khairul.anuar.romli@altera.com>
 <21ceb1207564d9962c90d8235282f1e462df6875.1765425415.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ceb1207564d9962c90d8235282f1e462df6875.1765425415.git.khairul.anuar.romli@altera.com>

On Thu, Dec 11, 2025 at 12:40:36PM +0800, Khairul Anuar Romli wrote:
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
> Changes in v3:
> 	- Simple dma-ranges property with true and without description
> Changes in v2:
> 	- Add dma-ranges
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml           | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index a393a33c8908..1f4dcf3092c3 100644
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
> @@ -104,6 +108,8 @@ properties:
>      minimum: 1
>      maximum: 256
>  
> +  dma-ranges: true
> +

You no longer need this because it is in the bus node.

Rob

