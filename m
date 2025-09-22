Return-Path: <dmaengine+bounces-6679-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A93B9270C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 19:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EA0189971B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13F314D34;
	Mon, 22 Sep 2025 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CknZkEfH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D27314B73;
	Mon, 22 Sep 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562313; cv=none; b=iLbBj+hAEeqgHZXu2J1+a4TITBhm1UdGEEIua9UiKMwAe/vLDkvsKWvRRrRj6vV/z5PUYuxQizzhGM0xbnKM1wekDd4ihj31lCNGcj66UaWzgRiklkCjNCerV7bF81s/jRx3O+/C1h7o+tJvjoNwyUZgYy2lxlAsRzd2/k0B+a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562313; c=relaxed/simple;
	bh=0Jaq62/wsiDis5Kxr3Xf68gcAS73LxwxMmQQZHfINbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxkErCHSDJpcbMqlbkI3klfNfiQyDDxtQXbJmilp2MfR6ojdkwlkxQhi1/kauT+CCoBFqqaYhZh0jVF+8+Z31hUScVHJjkwsHplsHnG7oFvjiv+jz03VEpr9zUfsnASPkYQANojImTp5Vpe1VrHFNQ9ZW1+gW8sidOjaP9Woo+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CknZkEfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B62C4CEF0;
	Mon, 22 Sep 2025 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562312;
	bh=0Jaq62/wsiDis5Kxr3Xf68gcAS73LxwxMmQQZHfINbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CknZkEfHsiB9PDl/Uko3MtMWJ4EMHoFDksYXfhYYMy2fJ2n30DT1HiZ8qqEVeiqEi
	 otM3gxMX6XyzuO1ZfMe8/JVVhKCoBq6aQtqfxKr1wMGdJhhDCtZ4LSUxphtSoGjswk
	 CphNBZPq4D6O+c+PJWHGjxXu2CidHdrh0kmB5IHxOX8iHZ5PR8YPNXqNc95BdMdSBn
	 SX4lvB9zhR5z6vdjpOfAymwdOV66fzvZkCPdeiwi2nvP9CcQD6bqm2Aoa9+QzbMi9C
	 JBoF5q5VFPiBnr6U6rirqTPkToA6VttjBbUj1ZMg3N9qAUFzJaXuKfgJ1/WxQowea6
	 dsAMq3pTQzArQ==
Date: Mon, 22 Sep 2025 12:31:50 -0500
From: Rob Herring <robh@kernel.org>
To: "Sheetal ." <sheetal@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sameer Pujar <spujar@nvidia.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: sound: Update ADMAIF bindings for
 tegra264
Message-ID: <20250922173150.GA506813-robh@kernel.org>
References: <20250918102009.1519588-1-sheetal@nvidia.com>
 <20250918102009.1519588-3-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918102009.1519588-3-sheetal@nvidia.com>

On Thu, Sep 18, 2025 at 03:50:07PM +0530, Sheetal . wrote:
> From: sheetal <sheetal@nvidia.com>
> 
> Update the ADMAIF bindings as tegra264 supports 64 channels, which includes
> 32 RX and 32 TX channels.
> 
> Signed-off-by: sheetal <sheetal@nvidia.com>
> ---
>  .../sound/nvidia,tegra210-admaif.yaml         | 49 +++++++++++++------
>  1 file changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
> index b32f33214ba6..f53ecef379b3 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
> @@ -93,20 +93,41 @@ then:
>      iommus: false
>  
>  else:
> -  properties:
> -    dmas:
> -      description:
> -        DMA channel specifiers, equally divided for Tx and Rx.
> -      minItems: 1
> -      maxItems: 40
> -    dma-names:
> -      items:
> -        pattern: "^[rt]x(1[0-9]|[1-9]|20)$"
> -      description:
> -        Should be "rx1", "rx2" ... "rx20" for DMA Rx channel
> -        Should be "tx1", "tx2" ... "tx20" for DMA Tx channel
> -      minItems: 1
> -      maxItems: 40
> +  if:

Try to avoid nested if/then/else if possible and put independent if/then 
schemas under 'allOf'.

> +    properties:
> +      compatible:
> +        contains:
> +          const: nvidia,tegra264-admaif
> +  then:
> +    properties:
> +      dmas:
> +        description:
> +          DMA channel specifiers, equally divided for Tx and Rx.
> +        minItems: 1
> +        maxItems: 64
> +      dma-names:
> +        items:
> +          pattern: "^[rt]x(3[0-2]|[1-2][0-9]|[1-9])$"
> +        description:
> +          Should be "rx1", "rx2" ... "rx32" for DMA Rx channel
> +          Should be "tx1", "tx2" ... "tx32" for DMA Tx channel
> +        minItems: 1
> +        maxItems: 64
> +  else:
> +    properties:
> +      dmas:
> +        description:
> +          DMA channel specifiers, equally divided for Tx and Rx.
> +        minItems: 1
> +        maxItems: 40
> +      dma-names:
> +        items:
> +          pattern: "^[rt]x(1[0-9]|[1-9]|20)$"
> +        description:
> +          Should be "rx1", "rx2" ... "rx20" for DMA Rx channel
> +          Should be "tx1", "tx2" ... "tx20" for DMA Tx channel
> +        minItems: 1
> +        maxItems: 40
>  
>  required:
>    - compatible
> -- 
> 2.34.1
> 

