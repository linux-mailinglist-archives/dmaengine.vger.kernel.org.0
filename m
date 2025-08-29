Return-Path: <dmaengine+bounces-6290-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2AB3B9B5
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 13:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A118188BC4A
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F53C313E1F;
	Fri, 29 Aug 2025 11:08:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDEF31282F;
	Fri, 29 Aug 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465728; cv=none; b=lAa020fG7+Kei5SsNP4L0+HJgUIvF89jUk0YrHugEOfsR4XdGYy9Azb5IEKKkAr68O43hQwHPyVag3S47bxyx/xbAHJcOo8JfOL2OVqgbjwDb6DNzrEX30dpmoLgrggH3cC4uy2UQx6mPrS0eJpkaf/HHhWig7VdesPuABWjzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465728; c=relaxed/simple;
	bh=JH9+5xWCRS+y0xr4rLS+aEPLZZBo64/HbQylL0LRVfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeBnvLNmR9g0aid3eEq0X27SfbNPrT6YH5zkATtA5Ygr1i3sBWml9P5JTLMz3lT6Pgh3ZMpIoMBvN3Fhszq0yww1vsL4KaflbKsZr9ZU/CmsjFf3UOI6VTk76sIX7TUOYcxx1t3/gBJR0WkhoL6vB7f2RZ3ZjdVMOuNHsecrpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AC8519F0;
	Fri, 29 Aug 2025 04:08:37 -0700 (PDT)
Received: from [10.57.2.173] (unknown [10.57.2.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B8C53F738;
	Fri, 29 Aug 2025 04:08:44 -0700 (PDT)
Message-ID: <7230cb2a-2a66-49d4-bb37-b0df2a79f7d0@arm.com>
Date: Fri, 29 Aug 2025 12:08:41 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] dt-bindings: dma: dma350: Document interrupt-names
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-9-jszhang@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250823154009.25992-9-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-23 4:40 pm, Jisheng Zhang wrote:
> Currently, the dma350 driver assumes all channels are available to
> linux,

No, it doesn't - the CH_CFG_HAS_CMDLINK check is designed to safely skip 
channels reserved for Secure world (or that don't exist due to an FVP 
bug...), since their CH_BUILDCFG1 will as zero.

> this may not be true on some platforms, so it's possible no
> irq(s) for the unavailable channel(s). What's more, the available
> channels may not be continuous. To handle this case, we'd better
> get the irq of each channel by name.

Unless you're suggesting these channels physically do not have their 
IRQs wired up to anything at all, what's wrong with describing the 
hardware in DT? Linux won't request IRQs for channels it isn't actually 
using, and nor should any other reasonable DT consumer - precisely 
because channels *can* be arbitrarily taken by the Secure world, and 
that can be entirely dynamic based on firmware configuration even for a 
single hardware platform.

And even in the weird case that some channel literally has no IRQ, my 
thought was we'd just have a placeholder entry in the array, such that 
attempting to request it would fail.

Thanks,
Robin.

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   Documentation/devicetree/bindings/dma/arm,dma-350.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> index 429f682f15d8..94752516e51a 100644
> --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> @@ -32,6 +32,10 @@ properties:
>         - description: Channel 6 interrupt
>         - description: Channel 7 interrupt
>   
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 8
> +
>     "#dma-cells":
>       const: 1
>       description: The cell is the trigger input number
> @@ -40,5 +44,6 @@ required:
>     - compatible
>     - reg
>     - interrupts
> +  - interrupt-names
>   
>   unevaluatedProperties: false


