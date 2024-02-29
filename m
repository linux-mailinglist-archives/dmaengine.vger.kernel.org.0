Return-Path: <dmaengine+bounces-1196-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A15C86CE9A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 17:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F81C2245E
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305287A127;
	Thu, 29 Feb 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTeJNH/j"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9387A122
	for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222309; cv=none; b=kyknrcpaXoM+ailNbsZQ63v1NCcvtExlbGAFr3NFJoVM7mNzTS3bIteeSHThjfqYMUldrnLqKXEwt6BKPFzLJyXQACbULrCd7rigYR/lMiWojyHOXU8amOyqrmnaqxAeQxQSqUPSshnSc2xhaDZ7YVVeQ3VNCIQWk6oiW47Gkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222309; c=relaxed/simple;
	bh=3tf4NQCYAowqTqv1FcOVo/z26fMA/xtvIX8z01+H5fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmTF6XTaUkGXSFv+bowB2L1zlfGzxH5XOnUi27S/UY2EcHbcLLV+Nu2KVpWSItMru4ZLF898IAF+S8REEJpzr6IUMEXfXL1P3k55/jeE1uP86lhlJjmQo8UfnKtCf4oRHYv09UBL1OKIk3dLXeXHKEq7zP7Eec5svbGedluYGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LTeJNH/j; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565b434f90aso1709493a12.3
        for <dmaengine@vger.kernel.org>; Thu, 29 Feb 2024 07:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709222306; x=1709827106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LTOfx2GQ4CBnGepMff9R5kxjiek93kg9AQREW+HsbQ=;
        b=LTeJNH/jaQja//EXrW0ELTupuRfKWgr7W2fGvpgLV263xLcRYkgl4YnZXeGsbUAKj5
         3FyqePjElDrPIiYDFJfA1n3MdgA/JRgzRpk4g5rgt0guhwTGQu8uc9QI7rky9a+ig9aK
         O7eTc9D5ynRFKb/V9RjNdJuz9SrlgWuT2StCDlStchzbJB5x30LWew53Q2339VACBCdu
         8yHDg0eFfh6vI5o4BrNIcL4hijVUeTabD71HFGcpcS0m1XXFdAT4na4l98PYzrKUxtBY
         HU9betXCU7zmlxlInl7/26eaBKUSP1KNkZgZXb0kEix82fvN8+dW5RFhTqClxFNCrf8w
         /deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709222306; x=1709827106;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LTOfx2GQ4CBnGepMff9R5kxjiek93kg9AQREW+HsbQ=;
        b=kXVJ197FKmHpfFoaxxt6OhmMf2vWVVg8frs+udA+womSru5E+ePSQoTNARcJ3tWY06
         4LeAITb6mW65xStXi38WfDfJ4qnHhU/UWiOWSOz3UtLPdNiZHtO1uDW9/mx38DesdWKg
         AAOOQvhkKGWV2QQS9WZtURzNcGCU3Hje4viTJ+2KL9MvF706SwQ6s6m/qAC1zfiYt39W
         BmI+CB6Cv2OvrfptniUISGm+XxemdXIqbRbg9gbSdNgrtn1rGvCRMQ4EnPYcnzDot4jO
         yU5CInLGBhulalpNgVk/uRCP4Qf8rIPqWwSNM0qGKM8GXK6yO9mFv8JOwpvBdcl59zJc
         Lshw==
X-Forwarded-Encrypted: i=1; AJvYcCUPon7nwDOoNgswrgXE7SkaHCJcF6X90jqaXRJ9AA0qC3JkuHN7csOsdRSG1K2c/St2CJ2bEDSwjdzYXC72eGGSUKiiH87MSmoN
X-Gm-Message-State: AOJu0YxRTjYO96MOpsznAjbhJ09m2RmcxSvgiVVxX6NSjvaayVH8DgBe
	IIqKcn9Co4jEBQNhCcqE/yXT7CB9a1h+XfdvaTh3JNEmPmQQMZRthIk5xzUtmZU=
X-Google-Smtp-Source: AGHT+IHTGeLGUGjtiB1k+eXZpXGYhVOB/sIIBY0nmIrddEjUJPgB9ttQaeo1rZgsB2tq84eA/L0rYg==
X-Received: by 2002:a05:6402:2156:b0:566:4a85:ceba with SMTP id bq22-20020a056402215600b005664a85cebamr1729228edb.1.1709222306044;
        Thu, 29 Feb 2024 07:58:26 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id e20-20020a056402105400b0056518035195sm718183edu.69.2024.02.29.07.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:58:25 -0800 (PST)
Message-ID: <ec835855-49f6-4b9a-9c58-e3fb90946c26@linaro.org>
Date: Thu, 29 Feb 2024 16:58:23 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: fsl-dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 imx@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Joy Zou <joy.zou@nxp.com>
References: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
 <20240227-8ulp_edma-v1-4-7fcfe1e265c2@nxp.com>
 <bb3b61b6-4f39-4123-be50-0e2c8f07eb99@linaro.org>
 <ZeCooFQtOK9MuuJn@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZeCooFQtOK9MuuJn@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 16:54, Frank Li wrote:
> On Thu, Feb 29, 2024 at 10:49:43AM +0100, Krzysztof Kozlowski wrote:
>> On 27/02/2024 18:21, Frank Li wrote:
>>>  
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: fsl,imx8ulp-edma
>>> +    then:
>>> +      properties:
>>> +        clock:
>>> +          maxItems: 33
>>> +        clock-names:
>>> +          items:
>>> +            - const: dma
>>> +            - pattern: "^CH[0-31]-clk$"
>>> +        interrupt-names: false
>>> +        interrupts:
>>> +          maxItems: 32
>>> +        "#dma-cells":
>>> +          const: 3
>>
>> Why suddenly fsl,vf610-edma can have from 2 to 33 clocks? Constrain
>> properly the variants.
> 
> Suppose you talk about 'fsl,imx8ulp-edma' instead 'fsl,vf610-edma'.
> 
> imx8ulp each channel have one clk, there are 32 channel. 1 channel for core
> controller. So max became 32.
> 
> I can add above information in commit message.

No, I meant Vybrid. Quick look at this code and the actual file suggest
that you allow vybrid with 30-whatever clocks. Test it.

Best regards,
Krzysztof


