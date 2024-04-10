Return-Path: <dmaengine+bounces-1803-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 484BF89EAE9
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 08:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B711F235E8
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 06:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C219C15D;
	Wed, 10 Apr 2024 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zM7BzafQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300B2C695
	for <dmaengine@vger.kernel.org>; Wed, 10 Apr 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730754; cv=none; b=RpZdrLTj/OI7O8b7s4aI1WOzPrGesys3/R1mn1dZfusEBlT0ZHBwjMWKE09Z4w7oV/tgFu6yDxpvGY+G/FOkJrJYQz4NyG9D7YOzdUmJVNygWRDmJ0ltQKb4NFAdZeGhkDTEeziDrCFJJyUI6tgMupE0gfs+A4253MsvtT10ydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730754; c=relaxed/simple;
	bh=tqpijNMZVhaemUA7jcJvu2ULxhVHVLvCejLdP80YXEE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QB1GgRGSs+5xdU51ovD21+VUdz0lyBEn/GHZZdLfYjuTYNIP7D0QsDGvYkyNbu76D/hHtlpKIP/+jEIdtXKD8h/pXLeacVWNw1dJiU8d9x4hPckjmKmZ/Biquux9sXsTugL2ucS+rBXxymHECYhw8bH8Ed19ETnL7vfk5+sF0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zM7BzafQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51a1c8d931so597773466b.0
        for <dmaengine@vger.kernel.org>; Tue, 09 Apr 2024 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712730751; x=1713335551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o7EWNXZ7ahmiyoCceER4yIyMNYDrhM2QQjatZB79UKA=;
        b=zM7BzafQ7lQPbofgwlCh7jP/rCY/NfZXSN4DlJWijUjBwuBrvW51rCDN/Ho2XvHqF2
         NFUfV70I9TiZrS5N0d/eJXr7Pl4wvjipbfZpX4qrwlTp7hp/dUR2f5rzJiQvp00Q02A1
         i0yBzedmX3GTdfmqP5BOk5pNLNhw6+5Zws8ULX5F4DACiOiCpSRUL/Wn2pynxIoXgG7v
         rKA+dzleE3qpauVsNAI4bNBmFbxU3qvG1jmPD20f0hI2Cxbp86sBHYEhp/W1JKGhka9k
         AxJ0ndS+03rhm166nTaFvUFB/AzR1qDn9iMH0eE50heTrmT2tV9Z/5Z6v9MxqOR7NlbC
         HKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730751; x=1713335551;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7EWNXZ7ahmiyoCceER4yIyMNYDrhM2QQjatZB79UKA=;
        b=jujhOSUMED/AjLt43b1W+mcEKmQbWUvDRO6zz995KSjGsLum0lWTlJqFCI9FRGh7P0
         lqZ5MXTVKNDoUtYTcr8AF6Q9uk3T5I5amB9UYE3Owvhk1gUKDAczW63yKUnzEsYm38v/
         DdTBxhK1ciU93coafpGjU/I9K7wXARHD+vwOy9+J6p2pRSDa0Y/9UqkLhd405Wf1dVmr
         +yD6Mxz/YtNDv99VmK0J3bSwa6w0o9UgBfBlWM3ZEG3EsJoECNq7eezRkcuqcPtJ1PUS
         lcDNCiLLQf5kyoaDsnoSo6S6zTz9nhZx2rmp+aALXe4OaSKuWzlxfdT2N5CxBtdM8nkT
         3J3A==
X-Forwarded-Encrypted: i=1; AJvYcCXjZnKAzoFdATlCzWw5GdaaM4jsVnkuTfPd3l6rSd9zsY2E6rkHlPPE8ehlxNxd1kBFnsjRNgEiNP8zgtKcC5bh9a+IFlMZzplb
X-Gm-Message-State: AOJu0Yz1nc+Oq4EEjmY8SpJ27PNZV7oHVoZIYgWalXiNTu6jbIsr2AsO
	CRr2taqKft7/NCMvMJ3UkzRiH2dfI4bOOtf2yJYkPwMEq1VbdomSrFdHruuBTDA=
X-Google-Smtp-Source: AGHT+IEEsAQcH/oLWPV/JGlZ4uSssWErulLZ/+Oov+2FXWP1SnehGQ427YNJfD5zABFDW2w/qKkpRA==
X-Received: by 2002:a17:906:91c8:b0:a51:f142:e550 with SMTP id b8-20020a17090691c800b00a51f142e550mr887280ejx.29.1712730751059;
        Tue, 09 Apr 2024 23:32:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id q26-20020a170906b29a00b00a51dd500071sm2893449ejz.169.2024.04.09.23.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 23:32:30 -0700 (PDT)
Message-ID: <383141cd-7f6f-4ed0-945b-7761833ecc35@linaro.org>
Date: Wed, 10 Apr 2024 08:32:28 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: dma: fsl-edma: remove 'clocks' from
 required
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org, imx@lists.linux.dev,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 peng.fan@nxp.com, robh@kernel.org, vkoul@kernel.org
References: <20240409185416.2224609-1-Frank.Li@nxp.com>
 <b15ad271-037e-4ee3-ad88-e8068d31c8c8@linaro.org>
 <ZhWuetC8bRvDyxgX@lizhi-Precision-Tower-5810>
 <680f8830-6cd8-433b-85b7-439070bc528f@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <680f8830-6cd8-433b-85b7-439070bc528f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2024 08:30, Krzysztof Kozlowski wrote:
> On 09/04/2024 23:09, Frank Li wrote:
>> On Tue, Apr 09, 2024 at 10:02:32PM +0200, Krzysztof Kozlowski wrote:
>>> On 09/04/2024 20:54, Frank Li wrote:
>>>> fsl,imx8qm-adma and fsl,imx8qm-edma don't require 'clocks'. Remove it from
>>>> required and add 'if' block for other compatible string to keep the same
>>>> restrictions.
>>>>
>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>> ---
>>>>
>>>> Notes:
>>>>     Change from v2 to v3
>>>>       - rebase to dmaengine/next
>>>
>>> This fails...
>>
>> What's wrong? 
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next
>>
>>>
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>> index 825f4715499e5..657a7d3ebf857 100644
>>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>> @@ -82,7 +82,6 @@ required:
>>>>    - compatible
>>>>    - reg
>>>>    - interrupts
>>>> -  - clocks
>>>>    - dma-channels
>>>>  
>>>>  allOf:
>>>> @@ -187,6 +186,22 @@ allOf:
>>>>          "#dma-cells":
>>>>            const: 3
>>>>  
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +	  contains:
>>>
>>> It does not look like you tested the bindings, at least after quick
>>> look. Please run `make dt_binding_check` (see
>>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>>> Maybe you need to update your dtschema and yamllint.
>>
>> Strange, Test passed
>>
>> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,edma.yaml
>>   LINT    Documentation/devicetree/bindings
>>   DTEX    Documentation/devicetree/bindings/dma/fsl,edma.example.dts
>>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>>   DTC_CHK Documentation/devicetree/bindings/dma/fsl,edma.example.dtb
> 
> Nope, you tested other patch. Just look at your second patch for this.
> When reviewer points to errors to your code, please investigate?
> 
> NAK, fix your patches.

And to prove it, so you will stop wasting my time:
../Documentation/devicetree/bindings/dma/fsl,edma.yaml:192:1: found
character that cannot start any token

../Documentation/devicetree/bindings/dma/fsl,edma.yaml:192:1: [error]
syntax error: found character '\t' that cannot start any token (syntax)

../Documentation/devicetree/bindings/dma/fsl,edma.yaml:192:1: found
character that cannot start any token

Documentation/devicetree/bindings/dma/fsl,edma.yaml: ignoring, error
parsing file


Best regards,
Krzysztof


