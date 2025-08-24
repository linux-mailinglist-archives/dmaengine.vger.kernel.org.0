Return-Path: <dmaengine+bounces-6185-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0A4B32EFD
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 12:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC84A171EBA
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D949A22172D;
	Sun, 24 Aug 2025 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TysKFbNG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A63FF1;
	Sun, 24 Aug 2025 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756031221; cv=none; b=nlDm9YrmVTfZcLZ4e61ZvlI/yCzOt8d34ke4LdUV+kJ9pWjw70jhjFgCDSadkGPN+Rtq9Ffjy7Vqoro83MQTriAmdCf3i+OkTd/x5pwDkJC3q4ZQ8qwxZyaRGUB2rcnnT4/hwkCdO3/tsddMi6mANHlLDlk/dT0gdX+tvKK4fbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756031221; c=relaxed/simple;
	bh=2fFxf047dZ/bxH4koaGiZYykN/ur/aYx1D1ION5XVOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jx5UbCfE97dXL1qO/Nw8NvuRisqDX3NkYns+no/TAMtGwWDPl3UtDDzpORBW2bn5PwR2uFuzOOxdJ/isjIAc3m4G5w/jEhoqMBmai0XHSgt3gDmH/Ske0d7kaVIAMrOOdbLm9MzE6kkuElUgVycdEydTiK19GRYGT7XTu0DEkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TysKFbNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6141EC4CEEB;
	Sun, 24 Aug 2025 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756031221;
	bh=2fFxf047dZ/bxH4koaGiZYykN/ur/aYx1D1ION5XVOc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TysKFbNG5j5fN/aVTQlhPJ6ATcYT5e4wK+s+ZeK7bcz3tKBbw9HOzhwF1EWPCa++V
	 GfnaR7363aaewlMy9OfNfMIMwP5rXjssBaVcgeNBdylNCdh4DpH2npt9ltIpRpK1LP
	 jaRxfL1b/2ywPRAg8nLAFRkq1J8FEl2AhbV0tneaZ8F9N9QEWOLf1Hq7gkfPK13g2Y
	 c1/+FJYV/4txaspZmsunP5nif/Lqin0m25nNFSzzzKdFJ/r4TNmpyBEOtBQwPxkTUf
	 fbyz879zFzGaVHwTz5UZVRFW6XvWDIsTXvG2zdVGDbH9YEdMMxukKGVL1IFi1pbfJq
	 7YJ8MWzSG9YAw==
Message-ID: <5c7f78ae-01d8-40e3-a370-76953921ade9@kernel.org>
Date: Sun, 24 Aug 2025 12:26:56 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: lgm-dma: Added intel,dma-sw-desc
 property.
To: Yi xin Zhu <yzhu@maxlinear.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "kees@kernel.org" <kees@kernel.org>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "av2082000@gmail.com" <av2082000@gmail.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250808032243.3796335-1-yzhu@maxlinear.com>
 <32a2ec88-b9b8-4c4d-9836-838702e4e136@kernel.org>
 <SA1PR19MB490961745C428F56D7E114F7C234A@SA1PR19MB4909.namprd19.prod.outlook.com>
 <a0a1bc99-0322-4f63-a903-12983facddc9@kernel.org>
 <SA1PR19MB4909BA87E8CE98B5A6389349C234A@SA1PR19MB4909.namprd19.prod.outlook.com>
 <1826bd7a-621d-49d0-b6ff-7ff723ec9f2c@kernel.org>
 <SA1PR19MB490914561C8ADF3012814D69C231A@SA1PR19MB4909.namprd19.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <SA1PR19MB490914561C8ADF3012814D69C231A@SA1PR19MB4909.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2025 10:41, Yi xin Zhu wrote:
> Hi Krzysztof,
> 
> On 15/08/2025 18:40, Krzysztof wrote:
>>
>>
>> What is a "SoC level configuration"?
>>
>> From your explanation 1+2 it feels like consumer chooses it. Where is a full DTS
>> showing all this?
>>
>>
>>> of the DMA instances work in hardware descriptor mode while other DMA
>>> instances work in software descriptor mode or all in HW/SW mode.
>>>
>>
>> Best regards,
>> Krzysztof
> 
> In the LGM SoC,  The DMA instances are default connected to CBM(central buffer manager) to automate the DMA descriptors.  
> It can also be detached from CBM to use it in different use cases individually.
> 
> In the HW descriptor case,  the device tree would be like:
> 
> dma1tx: dma-controller@e7300000 {
>       compatible = "intel,lgm-dma1tx";
>       reg = <0xe7300000 0x1000>;
>       ...
>       #dma-cells = <3>;
>       intel,dma-poll-cnt = <16>;
> };
> 
> cbm: cbm@e1000000 {
>    dmas = <&dma1tx 0 0 64>, <&dma1tx 1 0 64> ... <&dma1tx 15 0 64>;
>    
> };
> 
> DMA HW feature, desc_fod(descriptor fetch on demand) and desc_in_sram are turned on in the DMA controller in this case.
> These HW features are defined in platform data in the existing DMA driver as default enabled.
> static const struct ldma_inst_data dma1tx = {
> 	...
> 	.desc_fod = true;
> 	.desc_in_sram = true;
> };
> 
> In the SW descriptor management case,  the device tree would be like:
> 
> dma1tx: dma-controller@e7300000 {
>       compatible = "intel,lgm-dma1tx";
>       reg = <0xe7300000 0x1000>;
>       ...
>       #dma-cells = <3>;
>       intel,dma-poll-cnt = <16>;
>       intel,dma-sw-desc;

That's then implied by compatible, no? If you disagree, please post
complete upstream DTS.

Best regards,
Krzysztof

