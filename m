Return-Path: <dmaengine+bounces-1238-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C29586FAA8
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 08:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12CF2842D5
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 07:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD113AFB;
	Mon,  4 Mar 2024 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHkPhrNt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B8134BE
	for <dmaengine@vger.kernel.org>; Mon,  4 Mar 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537006; cv=none; b=LJaufycsgnUe265J1nubOR6pALN8crMPiJJu5w6952lNZk+cWIU8CWVtnOboPTUb1cpJs076R4ef+obKwpC5464HXwdkZmyQ09ETmn4sfdmCMD70rQK121MlyY0otuG2B/lxlQLSnIzDCHS7t7Pw8NMyIWZIbSL8fwdC5uxMS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537006; c=relaxed/simple;
	bh=M03hxy49tZj3JEHn2dTWKxfoGsKeX4oy3shfwcKmMIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpE7F+V/icroZa/HEL24WMdVlGxsGTf/p/LC4ZHWlDlj1W9qSEgqH3CGhRnR5UtOpxFPOHbnKeBekcD4h53C26O7Hz6Y/i/kvhjDO6wiiH3tKZUY0ySDaUMUHpt2VzUc2YhaWou0ghsGLvYMH3RlgdhnB+/g+XD7mggXt89OcMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qHkPhrNt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d146737e6so3054298f8f.0
        for <dmaengine@vger.kernel.org>; Sun, 03 Mar 2024 23:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709537003; x=1710141803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvv2RvqAKR32wfF6dMhJCec7pDLoBXFhK3YVJX0dABw=;
        b=qHkPhrNtzRyFswmUGV+qgKpThNuzH4z8aCB9miC28TGgwuJ1XQktR8CXmk66dZ2mCy
         ujRTt4fZVCFZeYergXIICvbUBtqczeNM6LyLA78HLIlKAcQu2et8hYRbSvzkwO8MHXA0
         v14SMkaQNBMLNFrAYgByePaCffEgB8kubd6ZkAesoi40dpkdI6yD92LbhA//lyCzgxN+
         GQRMq5wQYwIQHhd0WWn+HjYtDLvFVRO8nYUMS74Vg0oilukE8fv8AH8KTudrlcbAl/C5
         582nXfOL49/nHcxbR1cQt1erteRedrtgU8JO6Tzqyk8ECnr2fYGaLRk/PnxqT/mKhs7E
         Qspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709537003; x=1710141803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvv2RvqAKR32wfF6dMhJCec7pDLoBXFhK3YVJX0dABw=;
        b=NNvolkWZ6650RMFyM5YeWBPFbh7qB0czbkO0lik1UNBAfgPaIRMYX0K96LEaxd4UK7
         lMn1omZdJekL3EVijulb/HBPCLV8iIGHylAyjsgax1VB6Tpqp8ieoqZ4B0wgutf63ZGY
         zZ/ZK1wigA1EBagy/Ob/Nmm4EhhU+4JqL9YPa4T2gxNz+3FJJoMeaiqqhU9pJqJGFi3I
         NtzA2pyIPXbjQNW6ctv4gR+Jqcwa+OJLK4GySZYjRi7BWesM8qKoBFXz1r6VjsN7rWZ3
         ou9P1zkjA+qjjG9lCCUxAPbCsh8OlM4n8Mb9fHO5vy3FtZPSFvjviRI5Dl2u6uhLFr8W
         fVTA==
X-Forwarded-Encrypted: i=1; AJvYcCXzFNuRpoKyrF1oXTI/3AGNig1N0qIDPLGYd/+TBMGRssl4dJGDGIVn9LT5+ZP7xGC3hJOMbkXWhbmoFzVuPuQcVKxFPrI5IcGV
X-Gm-Message-State: AOJu0Yz2r9AyuVAumM2DJEiECnp20BBP/EadseBTxNEfex4+LFZrBbaU
	ZqTWvS4TGtwwW/ZTpOTCXnsFmGwOegdQz5K91vLAv1v1qwJEJMn3Hwufl870EGc=
X-Google-Smtp-Source: AGHT+IE7ALsJqhDpVZxE7usDUH7HTanZGu45qUCRfZCLZQ3L36mu/z7mahNw7Pce9HumilUFcN9K2A==
X-Received: by 2002:adf:e643:0:b0:33d:c5c7:4182 with SMTP id b3-20020adfe643000000b0033dc5c74182mr5737767wrn.7.1709537002828;
        Sun, 03 Mar 2024 23:23:22 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id h8-20020a056000000800b0033d2ae84fafsm8098930wrx.52.2024.03.03.23.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 23:23:22 -0800 (PST)
Message-ID: <9c1f74b9-468b-4243-a21e-fd18183aa4b1@linaro.org>
Date: Mon, 4 Mar 2024 08:23:20 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains'
 property
To: Frank Li <Frank.li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, imx@lists.linux.dev,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org
References: <20240301214536.958869-1-Frank.Li@nxp.com>
 <20240301214536.958869-2-Frank.Li@nxp.com>
 <885501b5-0364-48bd-bc1d-3bc486d1b4c6@linaro.org>
 <ZeNI1nG1dmbwOqbb@lizhi-Precision-Tower-5810>
 <31e62acf-d605-4786-80a1-df52c8490913@linaro.org>
 <ZeNWXxzFBzNj0gM1@lizhi-Precision-Tower-5810>
 <e1d0aafe-e54f-4331-8505-135b9a8f9bff@linaro.org>
 <ZeNYG1IUfniWkhcp@lizhi-Precision-Tower-5810>
 <32d4a6c9-1cc3-4e9a-81a6-744a33bc6bee@linaro.org>
 <ZeU/UQVPj/q4kD3p@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZeU/UQVPj/q4kD3p@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 04:26, Frank Li wrote:
> On Sun, Mar 03, 2024 at 08:55:10AM +0100, Krzysztof Kozlowski wrote:
>> On 02/03/2024 17:47, Frank Li wrote:
>>> On Sat, Mar 02, 2024 at 05:43:01PM +0100, Krzysztof Kozlowski wrote:
>>>> On 02/03/2024 17:39, Frank Li wrote:
>>>>> On Sat, Mar 02, 2024 at 05:20:42PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 02/03/2024 16:42, Frank Li wrote:
>>>>>>> On Sat, Mar 02, 2024 at 02:59:39PM +0100, Krzysztof Kozlowski wrote:
>>>>>>>> On 01/03/2024 22:45, Frank Li wrote:
>>>>>>>>> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
>>>>>>>>> it.
>>>>>>>>>
>>>>>>>>> Fixed below DTB_CHECK warning:
>>>>>>>>>   dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>>>>>>>>>
>>>>>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Notes:
>>>>>>>>>     Change from v1 to v2
>>>>>>>>>     - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
>>>>>>>>>     - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
>>>>>>>>>     or fsl,imx8qm-edma
>>>>>>>>>
>>>>>>>>>  .../devicetree/bindings/dma/fsl,edma.yaml         | 15 +++++++++++++++
>>>>>>>>>  1 file changed, 15 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>>>>>>> index cf0aa8e6b9ec3..76c1716b8b95c 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>>>>>>> @@ -59,6 +59,10 @@ properties:
>>>>>>>>>      minItems: 1
>>>>>>>>>      maxItems: 2
>>>>>>>>>  
>>>>>>>>> +  power-domains:
>>>>>>>>> +    minItems: 1
>>>>>>>>> +    maxItems: 64
>>>>>>>>
>>>>>>>> Hm, this is odd. Blocks do not belong to almost infinite number of power
>>>>>>>> domains.
>>>>>>>
>>>>>>> Sorry, what's your means? 'power-domains' belong to 'properties'. 
>>>>>>> 'maxItems' belong to 'power-domains'.It is similar with 'clocks'. what's
>>>>>>> wrong? 
>>>>>>
>>>>>> That one device belong to 64 power domains. That's just random code...
>>>>>
>>>>> Yes, each dma channel have one power domain. Total 64 dma channel. So
>>>>> there are 64 power-domains.
>>>>
>>>> OK, then how about extending the example to be complete?
>>>
>>> Let's add 8qxp example at next version.
>>
>> You have already enough of examples there and your change here claims
>> they user power domains, so why this cannot be added to existing examples?
> 
> Only imx8qxp/8qm need power-domains now. The example in yaml is vf610, 7ulp

Need? Hardware is either part of power domain or not. It's not dual-state.

> and imx93. If add power-domains at existed example, it will mislead reader.

Then please disallow the domains for other variants. You can convert
imx93 to imx95 example, because it's no different than other one. There
is little point in putting so many same examples in the binding. You are
just duplicating DTS.

Best regards,
Krzysztof


