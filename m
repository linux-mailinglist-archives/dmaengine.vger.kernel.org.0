Return-Path: <dmaengine+bounces-7550-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB19CB12E5
	for <lists+dmaengine@lfdr.de>; Tue, 09 Dec 2025 22:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 196BF3019AE1
	for <lists+dmaengine@lfdr.de>; Tue,  9 Dec 2025 21:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7821328B57;
	Tue,  9 Dec 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkzkHfTn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847E32862D;
	Tue,  9 Dec 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315563; cv=none; b=i5jsFrMY4Gh9Mw93glF1DBmlfTomSjyyfpC72PWm0nRTHuasEwvYoDwoG2QMzx+QOQixmdlFKU8Mau3JVsIgxYVEGwdu02XZJJwm1CrISarOISqM0Oyt4RXNucEBBkOlQt1f/Vb3MnzNVv+H01cwyYs2JfwsLFj48JwWy5cLjwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315563; c=relaxed/simple;
	bh=8lt/IYU9pvWInN+j0Z3Fl+N3wE3gjeOae/ELFJBEqgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLyei2BfWdChk4QBwB1aR94ZRNP6WF3Hs5KPRBi9peauiU4G1NZflmdrCKUiprl1ORGPKpX4ASfJr5v7DjEzabEmFMeVCMiZWQYYcmk1YJivWU7s8rtVo704WkklHgPn7nneXAJN/F/ORD7tqqQv6OCz56jggr1pIfNJ+htIsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkzkHfTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ED9C4CEF5;
	Tue,  9 Dec 2025 21:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765315563;
	bh=8lt/IYU9pvWInN+j0Z3Fl+N3wE3gjeOae/ELFJBEqgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkzkHfTnpqs6T97TXXfvKB9BMfk1/MTB71BN+3s0QIGDXZba6hb37CvLOZfnSkx6s
	 Vb6ohNWJW2lmPuvPURLfjM/mnjf/CZYSVa001G/nj8IXa19ietflK+amFn3jjok3J0
	 Rn0y2zFoAq9XRpPR8yi8kT3NWW2X+Y7tLwp3sttmRuG192iJTSs+8iINcfFnFmoP+e
	 RN0/uzvQqe24byWsUGtn6SGJMwWu/CgZW8RcK0+IeTqbF87aTkgl/9bDjhPcZzRKB7
	 i8TYABflIPi0GMhHFCJaNKtIej6OFZDzIBHdh68jSceIWsf8LXYOOxRJX/iYsLnnI8
	 /fGoggFH2PybA==
Date: Tue, 9 Dec 2025 15:26:00 -0600
From: Rob Herring <robh@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: dma: snps,dw-axi-dmac: Add
 #address-cells and #size-cells
Message-ID: <20251209212600.GA1133021-robh@kernel.org>
References: <cover.1764927089.git.khairul.anuar.romli@altera.com>
 <d2aae30e01537a737c3a47c0210e6deb79d160d6.1764927089.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2aae30e01537a737c3a47c0210e6deb79d160d6.1764927089.git.khairul.anuar.romli@altera.com>

On Mon, Dec 08, 2025 at 09:57:43AM +0800, Khairul Anuar Romli wrote:
> Add '#address-cells' and '#size-cells' to resolved the dt-schema build
> build issue when dma-ranges is presence. Without address-cells and
> size-cells presence in DT, kernel panic is observed due to of_base driver
> treats address-cells as two and size-cells as one.

Why are you fixing a problem the previous patch created?

Thinking about this some more, really 'dma-ranges' is supposed to be in 
a bus node, not the device node. So you should probably move the dma 
controllers down a level adding another simple-bus node with dma-ranges. 
Then you only need to add the new compatible.

> 
> Defining these cells explicitly ensures the binding correctly documents the
> necessary structure for nodes that describe the DMA-accessible memory
> space.
> 
> The supported enumeration for both properties is [1, 2], accommodating both
> 32-bit and 64-bit address/size representations.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v2:
> 	- Add address-cells and size-cells patch into the series
> ---
>  .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 1a1800d9b544..2b542ff9a6cd 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -33,6 +33,16 @@ properties:
>        - description: Address range of the DMAC registers
>        - description: Address range of the DMAC APB registers
>  
> +  '#address-cells':
> +    description: The number of cells used to represent physical base address
> +      in the host address space.
> +    enum: [1, 2]
> +
> +  '#size-cells':
> +    description: The number of cells used to represent the size of an address
> +      range in the host address space.
> +    enum: [1, 2]
> +
>    reg-names:
>      items:
>        - const: axidma_ctrl_regs
> -- 
> 2.43.7
> 

