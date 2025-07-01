Return-Path: <dmaengine+bounces-5701-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF4BAEEFCF
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09AF3B6CA8
	for <lists+dmaengine@lfdr.de>; Tue,  1 Jul 2025 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0D21019E;
	Tue,  1 Jul 2025 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLAhX1pG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5D72601;
	Tue,  1 Jul 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355332; cv=none; b=iwjvVoGv9zSqptXfDLrcAhqQDE/a5XXhQM07jL37qD9mJ9KYFD3CmBzGwLLb1ZQaTKqJh1/n9jzninNw/uoYFbzioSEKBIIAcnRJZGk+Xc+2NzDoMW+97o/6s7a05NLvGzHj8k3+MmrpD9OHNNZJqdWCh2RNVfGAcc2qM4cOYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355332; c=relaxed/simple;
	bh=e2EpXBFjaYIIp6kEDbtynlAx+t4UZrjkqzi6BdYvlKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zj0CKmhASBkos9j0uT6V6Prx+r0dffy7m2HWWiv0MwxVhbnI/PJiRuDjfR93DkxPCJKnFZEVHclfECVT+y0Rsl6Df3gQUj74azPLr79DQHAK8QdEibXRGX/FM+00a+y4MJ9zv8xQa/rFXNqgzI/zpmX4afm2ca/bA+47HxH6KzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLAhX1pG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D15C4CEEB;
	Tue,  1 Jul 2025 07:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751355331;
	bh=e2EpXBFjaYIIp6kEDbtynlAx+t4UZrjkqzi6BdYvlKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gLAhX1pGfGHjJorK/JnsksT/+iVcm91wV04/z6EM/WS7ODCB8SYcSuurvEnlXu7P6
	 fQS0rEvYSjb1PNiJl7hGzna84hApy+ap84u7HFvCNxtoVTH+R1xlYKFViF/2/Kwa+1
	 5sNmLmToXJYi9sjqYM5CfWkYjFOb3KG2aRx4MDRxUaa83a56haZD0gsvW6WxnLD7rI
	 x0ybO0USKdiZp9rs7Kt8M8w18gg8BP2e3WOQlXHaJSjYEyH688HlZuIf3VeYkDhb6a
	 qRI7iFNnxoWIG4erxx7xkX+Omq1wv5AXWAzdWTNe8GQUPF2hMkyXhM4dyrd8t43wyn
	 OwWT+qKdRWjSw==
Message-ID: <de965773-bab1-4c50-b111-19896465e53e@kernel.org>
Date: Tue, 1 Jul 2025 09:35:24 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: dma: marvell,mmp-dma: Add SpacemiT K1
 PDMA support
To: Guodong Xu <guodong@riscstar.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
References: <20250701-working_dma_0701_v2-v2-0-ab6ee9171d26@riscstar.com>
 <20250701-working_dma_0701_v2-v2-1-ab6ee9171d26@riscstar.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250701-working_dma_0701_v2-v2-1-ab6ee9171d26@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/07/2025 07:36, Guodong Xu wrote:
> Add "spacemit,k1-pdma" compatible string to support SpacemiT K1 PDMA
> controller. This variant requires:

Why is this marvell? This should be explained here, it's really unexpected.

> - clocks: Clock controller for the DMA
> - resets: Reset controller for the DMA
> 
> Also add explicit #dma-cells property definition with proper constraints:
> - 2 cells for marvell,pdma-1.0 and spacemit,k1-pdma
>     - (request number + unused)
> - 1 cell for other variants
>     - (request number only)
> 
> This fixes "make dtbs_check W=3" warnings about unevaluated properties.

How can I reproduce these warnings? Looks like this is not relevant
here. Each patch is applied one after another and commit msg must be
correct at this point.


> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v2:
> - Used more specific compatible string "spacemit,k1-pdma"
> - Enhanced DT bindings with conditional constraints:
>   - clocks/resets properties only required for SpacemiT K1
>   - #dma-cells set to 2 for marvell,pdma-1.0 and spacemit,k1-pdma
>   - #dma-cells set to 1 for other variants, ie.
>       marvell,adma-1.0 and  marvell,pxa910-squ
> ---
>  .../devicetree/bindings/dma/marvell,mmp-dma.yaml   | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> index d447d5207be0436bc7fb648dffe31f8b780b491d..7b5f7ccfc9dbb69bfef250146cba5434548f3702 100644
> --- a/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/marvell,mmp-dma.yaml
> @@ -18,6 +18,7 @@ properties:
>        - marvell,pdma-1.0
>        - marvell,adma-1.0
>        - marvell,pxa910-squ
> +      - spacemit,k1-pdma
>  
>    reg:
>      maxItems: 1
> @@ -32,6 +33,19 @@ properties:
>        A phandle to the SRAM pool
>      $ref: /schemas/types.yaml#/definitions/phandle
>  
> +  clocks:
> +    description: Clock for the controller
> +    maxItems: 1
> +
> +  resets:
> +    description: Reset controller for the DMA controller
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    description:
> +      DMA specifier, consisting of a phandle to DMA controller plus the
> +      following integer cells

Why do you need it here? Isn't this coming from dma common schemas?
> +
>    '#dma-channels':
>      deprecated: true
>  
> @@ -52,12 +66,47 @@ allOf:
>            contains:
>              enum:
>                - marvell,pdma-1.0
> +              - spacemit,k1-pdma
>      then:
>        properties:
>          asram: false
>      else:
>        required:
>          - asram
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,k1-pdma
> +    then:
> +      required:
> +        - clocks
> +        - resets
> +    else:
> +      properties:
> +        clocks: false
> +        resets: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - marvell,pdma-1.0
> +              - spacemit,k1-pdma
> +    then:
> +      properties:
> +        '#dma-cells':
> +          const: 2
> +          description:
> +            The first cell contains the DMA request number for the peripheral
> +            device. The second cell is currently unused but must be present for
> +            backward compatibility.
> +    else:
> +      properties:
> +        '#dma-cells':
> +          const: 1
> +          description:
> +            The cell contains the DMA request number for the peripheral device.


It's getting complicated. I suggest to make your own schema. Then you
would also switch to preferred 'sram' property instead of that legacy
'asram'.

Really, ancient schemas should not be grown for new, completely
different platforms.


Best regards,
Krzysztof

