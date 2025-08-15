Return-Path: <dmaengine+bounces-6046-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A1BB27B1A
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 10:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41945E002B
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 08:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB5155CBD;
	Fri, 15 Aug 2025 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGKmw4Ap"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD42836F;
	Fri, 15 Aug 2025 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246726; cv=none; b=FCkzRitowD0OLjitKkKR0/fac6EKihHkW4FUXv/OpFT8bVEacpMFouEvb/ZjpQ8L4/TobG8RY/GmIeeVxFuIUGTMea4ql1UsXC7Tmg9q0VrEGwVZRhj+4n5qxpbSoczaYL9ok0+KBuBh5Fn69PHgMWMoRFgI93io1a1NcdZkbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246726; c=relaxed/simple;
	bh=9+8DBXXTptKn2ZWjjVXEiRdMpDFZWM3gMPQi3jbFQpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T4SxRqEKs7aQzZgZmgMETsdetP9PIao+qcLMwtWvKkH7oNmgpx5o2do+p1dmk71QMO6qDan3UhYMrl6Tu0sAyOSU1lmYvgilm+qIkZ1dLi4VBlT90M8kd4nfH3LesEqfShG2zI99hi7qnqlkn9KfbJ2fApY28IZZ8iltLClhHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGKmw4Ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB08C4CEEB;
	Fri, 15 Aug 2025 08:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755246726;
	bh=9+8DBXXTptKn2ZWjjVXEiRdMpDFZWM3gMPQi3jbFQpo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gGKmw4ApnoAQgJHg1XK47rQAiNYIEjjgwwIhqNFK6ERKqG4u7IVccY2UFnrMSBStm
	 sz5q3KxAdYXKTy0p3/TL/9sGVsMn1NNgBM6ouiShqAuSiC6guZ22DOg20vQr4P9fFW
	 SXezbAyppmwK64z0mTKArt4u2eRAVONKUFi1YPAIMnALVbxDeksWetbZc3splGLGEK
	 oyhLYG66x+B/TaT2jVFT/jhxX5oOmmjtrXnrJhNcT0fIrgIn9NkHgv/kZqnv/mRy8Q
	 Y3NhUsU/A2QPeCiYFQRnUt8gMpkON08DjuZ/ZWa7p71U806+3jZbdHjxbRVKmVQfeF
	 sRWEZeDtelq3Q==
Message-ID: <a0a1bc99-0322-4f63-a903-12983facddc9@kernel.org>
Date: Fri, 15 Aug 2025 10:32:01 +0200
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <SA1PR19MB490961745C428F56D7E114F7C234A@SA1PR19MB4909.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2025 09:07, Yi xin Zhu wrote:
> Hi Krzysztof,
> 
> On 08/08/2025 14:10, Krzysztof wrote:
>>
>>
>> Where is the changelog?
>>
> Sorry for missing the changelog.  I will include it in V3 patch.
> 
>>> +  intel,dma-sw-desc:
>>> +    type: boolean
>>> +    description:
>>> +      Indicates that the DMA driver should operate in 
>>> + software-managed
>> mode.
>>> +      If this property is not present, it implies that DMA 
>>> + descriptors are
>> managed and generated by another hardware component that controls the 
>> DMA engine.
>>
>> Nothing improved:
>> 1. Still wrongly wrapped.
>> 2. Still SW property.
>>
>> I don't think you read the feedback. You need to describe hardware, not SW.
>>
>> Best regards,
>> Krzysztof
> 
> Could you please give me some advice with regarding to the device tree attribute?
> My understanding is if I can create a phandle link to describe the DMA descriptors are provided by some HW component.  
> That follows the comments. Something like this:
> 
> intel,dma-desc-provider = <&xxx_hw>;
> 
> Then it describes some HW component manages the DMA descriptors.


It is not sufficient to tell. Creating phandles representing fake
hardware is still not hardware description.

> Without it, it means SW manage the DMA descriptors.
> Please correct me if my understanding is wrong.


Yes, it is wrong, because you focus on syntax instead of on the hardware
problem or hardware characteristic.

> 
> However, in the existing driver,  HW manages descriptor mode is the default mode.
> I can't create such link in the device tree without breaking the devicetree ABI.
> So, is it okay I create an attribute like below ?
> 
> Intel,dma-desc-provider = "CPU";   // it means CPU manage DMA descriptors.
> 
> Intel,dma-desc-provider = "XXX_HW";  // it means XX_HW manage DMA descriptors.


And how is it not a OS policy? Bring reasoning and arguments, otherwise
I cannot help you. Your reply above has zero hardware-related arguments,
zero facts, zero hardware description.

Best regards,
Krzysztof

