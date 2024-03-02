Return-Path: <dmaengine+bounces-1225-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46E86F163
	for <lists+dmaengine@lfdr.de>; Sat,  2 Mar 2024 17:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089321F22233
	for <lists+dmaengine@lfdr.de>; Sat,  2 Mar 2024 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24A41EB3C;
	Sat,  2 Mar 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3DTeHpu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D918E1D
	for <dmaengine@vger.kernel.org>; Sat,  2 Mar 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709397787; cv=none; b=otAnZtg9mBijR2yAx+wHrsBtZBMRV6cJcmeKwglGt+MCUDEqVmtaZyg/km+29MFvp4a4M5hal1pv/3uVhC9MWL5/NiSkAl+Ct6eCOEVdmmE39gJam663fUQB8+P+Gr8vYX1mCIeybq+gvd6hQ2r0lshgr4VE4R6Hypd75Pau7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709397787; c=relaxed/simple;
	bh=iY2uv6tQ8oAWtbCpRxATIB+TmZmeWRIJZ0VO7Gv8xIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMcvrRakUlZ88z38kGbPcJgIzQLtf/U1QvkB95/SQ6yAKhDnEUQ/V8rJiLr00ETbdTXUw3EAfBP27uSMGoA+P9CfqmzxVGdfbZqJTloF30Ozhdj+2Fs90/piROeULnSZ/tNWUjQ5qOTPxGKSeYgxzIKpOlcPMz1O2TMeYQKWMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3DTeHpu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412cb54f086so7440675e9.3
        for <dmaengine@vger.kernel.org>; Sat, 02 Mar 2024 08:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709397783; x=1710002583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYdZ5zGQ9fikWU+RdgNG0JWTvwrS/XBdL5T1cZ9o+tg=;
        b=r3DTeHpuqciefRwntDPj+mo+xsrRsIQIb8Yd0dF8+KXJqtSqzpHJmusBbfIFyjOoNP
         iM0tdbZaEyVgqGQERr1cppFIDMhnpuIuMcVJ3+Fekshw07L55helmvwg/fKhXbrL7uUr
         oIBcBPI4r69zn026M1x/EJZuj1u4AgczebSUCOaA/BRSKpUgMX21xmTbf5W+jYVUuI0a
         KNkZZHSacGpxBQy3lEeFwk5VSGqk4c5i5/ZvTFwT2snG+5kRkGtOjcFRLiLFiCKLz4eF
         Uu8CTP81U1GBPjOn71jZgDiSsC4QKy50cxTnQ0cp8CiSu2XATbVw8p94LA/7ndx9d1YO
         cHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709397783; x=1710002583;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYdZ5zGQ9fikWU+RdgNG0JWTvwrS/XBdL5T1cZ9o+tg=;
        b=fdRrp086gScBN2Nue7h92BRJKOI5kBAkSp6W9g4OiBVXZ65zaN/l4nvMyvQhE7vOSz
         wh6jhoEP4szY1W1DMsWbAb/x248wboRDfiT82C7xoOL0bn6xcCy2/bo9xIUuViYn7J4H
         WmfCLZrdHV0n2oMvj+vIeIoq5cqVwlFrMMxZISo8tlhYwAdTe2QZ+1FFD4QKXYEeCRVR
         Z+jeD6cNY1oVt76OBvAQbWCgSoplezJR6d6aY5BERYmWi81trKDb6b127XbSLgp9gzPA
         cf2bM1U/97VrwP5vRwUuRjupQMni/gGXnNshV4WwXvPhHyc/nKlZjy5gt49C4JuLmlfC
         YssA==
X-Forwarded-Encrypted: i=1; AJvYcCVdtf5fS/c5OmtmKKp5i6NRH8CZpzMa6upwcLaec+OQYy8DbmN3WFmaZD4tzSesWA3ULBbl8q/4iGIyx+P/pYALpv1flamkp/Tr
X-Gm-Message-State: AOJu0YyRTFpIzboSXE8aqDfrgj30vSd2un1FqA95ASql3ZyBp1x083Ef
	Q69WijbfdYOo4Ly/ulZZPb7KZtaTE01+HNMQXsvlpmO/xpFMSJB+/FfR8Bf7u/4=
X-Google-Smtp-Source: AGHT+IEPqjVenlVlKA6dKUFh+8+c5WU6t57JINMGvqCa6BAEO/eWtZxvuuXTQWxOLmQ/WRgA0lfxUg==
X-Received: by 2002:a05:600c:474d:b0:412:c1d4:da7d with SMTP id w13-20020a05600c474d00b00412c1d4da7dmr4397093wmo.33.1709397783200;
        Sat, 02 Mar 2024 08:43:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id fa24-20020a05600c519800b00412cb60ac0esm4117575wmb.15.2024.03.02.08.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 08:43:02 -0800 (PST)
Message-ID: <e1d0aafe-e54f-4331-8505-135b9a8f9bff@linaro.org>
Date: Sat, 2 Mar 2024 17:43:01 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains'
 property
Content-Language: en-US
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZeNWXxzFBzNj0gM1@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/03/2024 17:39, Frank Li wrote:
> On Sat, Mar 02, 2024 at 05:20:42PM +0100, Krzysztof Kozlowski wrote:
>> On 02/03/2024 16:42, Frank Li wrote:
>>> On Sat, Mar 02, 2024 at 02:59:39PM +0100, Krzysztof Kozlowski wrote:
>>>> On 01/03/2024 22:45, Frank Li wrote:
>>>>> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
>>>>> it.
>>>>>
>>>>> Fixed below DTB_CHECK warning:
>>>>>   dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>>>>>
>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>     Change from v1 to v2
>>>>>     - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
>>>>>     - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
>>>>>     or fsl,imx8qm-edma
>>>>>
>>>>>  .../devicetree/bindings/dma/fsl,edma.yaml         | 15 +++++++++++++++
>>>>>  1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>>> index cf0aa8e6b9ec3..76c1716b8b95c 100644
>>>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>>>> @@ -59,6 +59,10 @@ properties:
>>>>>      minItems: 1
>>>>>      maxItems: 2
>>>>>  
>>>>> +  power-domains:
>>>>> +    minItems: 1
>>>>> +    maxItems: 64
>>>>
>>>> Hm, this is odd. Blocks do not belong to almost infinite number of power
>>>> domains.
>>>
>>> Sorry, what's your means? 'power-domains' belong to 'properties'. 
>>> 'maxItems' belong to 'power-domains'.It is similar with 'clocks'. what's
>>> wrong? 
>>
>> That one device belong to 64 power domains. That's just random code...
> 
> Yes, each dma channel have one power domain. Total 64 dma channel. So
> there are 64 power-domains.

OK, then how about extending the example to be complete?

Best regards,
Krzysztof


