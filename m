Return-Path: <dmaengine+bounces-7663-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBE6CC45F4
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 17:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AE2930D9E56
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2138E16E;
	Tue, 16 Dec 2025 12:43:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C085438E156;
	Tue, 16 Dec 2025 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888996; cv=none; b=NZJx4jjMITgPjnkWhHxkiTD1zrH21kJn1USXFuc5kFoV0jf+TvgdnK9TATnbLrVidb35PWHxU2YmilZZoDkxna0YbuWCl/n0q7GdA2UgjcvamjJfcFhu5nBaXWiGl/GRQYMQAKShbywTVPcP8ssBEQIYFs6IICquwMPAI7PYK00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888996; c=relaxed/simple;
	bh=GWWMNA7kXHTwxvnmlwFDb6c/u6dTQsrwBV98UQHxvhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RV8OwMoe07KLi7FyIkjQQ9p45y3xqyk04JzNnjunMlS1PFRXEIHxBPyyghfr+VtrvvFUwnB0qZ2SP3bzbhB5B1V34gAM3tXvlQ94e5FjEAGK73QQvx0dtBfe9KTTkUM08wbVooNEDBeqCS+5k0iBxlB8C1uPk9NUA4UMXYl3bJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77086FEC;
	Tue, 16 Dec 2025 04:43:05 -0800 (PST)
Received: from [10.57.43.186] (unknown [10.57.43.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DC973F694;
	Tue, 16 Dec 2025 04:43:09 -0800 (PST)
Message-ID: <9d4c274f-3e4c-49a1-9b2a-a95e9a48a4a6@arm.com>
Date: Tue, 16 Dec 2025 12:43:07 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: arm-dma350: update DT binding
 docs for cix sky1 SoC
To: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com,
 fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org, jelly.jia@cixtech.com
References: <20251216123026.3519923-1-jun.guo@cixtech.com>
 <20251216123026.3519923-2-jun.guo@cixtech.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251216123026.3519923-2-jun.guo@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-16 12:30 pm, Jun Guo wrote:
> Add SoC-specific compatible strings to the DT binding documents to support
> cix sky1 SoC.
> 
> When adding support for a new SoC that uses the arm dma controller,
> future contributors should be encouraged to actually add SoC-specific
> compatible strings. The use of the "arm,dma-350" compatible string in
> isolation should be disallowed.

No, you've missed the point - however many channels the hardware 
implements, the DT should list that many interrupt specifiers; it 
doesn't matter whether any of them happen to be the same.

Thanks,
Robin.

> Signed-off-by: Jun Guo <jun.guo@cixtech.com>
> ---
>   .../devicetree/bindings/dma/arm,dma-350.yaml  | 31 +++++++++++++------
>   1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> index 429f682f15d8..78bcc7f9aa8b 100644
> --- a/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> +++ b/Documentation/devicetree/bindings/dma/arm,dma-350.yaml
> @@ -14,7 +14,11 @@ allOf:
>   
>   properties:
>     compatible:
> -    const: arm,dma-350
> +    oneOf:
> +      - items:
> +          - enum:
> +              - cix,sky1-dma-350
> +          - const: arm,dma-350
>   
>     reg:
>       items:
> @@ -22,15 +26,22 @@ properties:
>   
>     interrupts:
>       minItems: 1
> -    items:
> -      - description: Channel 0 interrupt
> -      - description: Channel 1 interrupt
> -      - description: Channel 2 interrupt
> -      - description: Channel 3 interrupt
> -      - description: Channel 4 interrupt
> -      - description: Channel 5 interrupt
> -      - description: Channel 6 interrupt
> -      - description: Channel 7 interrupt
> +    maxItems: 8
> +    description: |
> +      The DMA controller may be configured with separate interrupts for each channel,
> +      or with a single combined interrupt for all channels, depending on the SoC integration.
> +    oneOf:
> +      - items:
> +          - description: Channel 0 interrupt
> +          - description: Channel 1 interrupt
> +          - description: Channel 2 interrupt
> +          - description: Channel 3 interrupt
> +          - description: Channel 4 interrupt
> +          - description: Channel 5 interrupt
> +          - description: Channel 6 interrupt
> +          - description: Channel 7 interrupt
> +      - items:
> +          - description: Combined interrupt shared by all channels
>   
>     "#dma-cells":
>       const: 1


