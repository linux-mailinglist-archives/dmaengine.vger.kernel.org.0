Return-Path: <dmaengine+bounces-1223-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B086F12B
	for <lists+dmaengine@lfdr.de>; Sat,  2 Mar 2024 17:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393431F21F95
	for <lists+dmaengine@lfdr.de>; Sat,  2 Mar 2024 16:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E61B277;
	Sat,  2 Mar 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjChQJC1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF7E17557
	for <dmaengine@vger.kernel.org>; Sat,  2 Mar 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396449; cv=none; b=MOyxqyr2vFUNvk48VwPRXFSG3QH7nPL9ScO0rnzkvEcl4AqKSsMf634anDa2r0n09etvoWFJs0ibY7/e9W3Se/feMLRT6Ps4M1y3xPRQttkZ+ziPGJJN0gw2yccSuimjsZV78zsvGQ5TW6J/EKBmRipjqm0vmJ/r6VP5GxCvF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396449; c=relaxed/simple;
	bh=Wln++snoA40x+qWEZZcKKhppP2VMixbKmdhLjLItlZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FB4PN1njc6HFZjvbiwlQMhfdXjAWRp1/61h6PUJmdG2hx4MFDEeyBMD5MHbmkwcolhP9Pem3luoBpGl7fDjPskDKod95o78MpQHHaCvFUj/SHpIVl4da3KJBLknHDaqKXB4e0MfLuhC63wbohQkallddweVDWk4NrKO/2ra/0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IjChQJC1; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so36586011fa.3
        for <dmaengine@vger.kernel.org>; Sat, 02 Mar 2024 08:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709396445; x=1710001245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5OXnrbutt/Uv6uRhzZrmNOJKAYvvA2TzcK2pYWprYqQ=;
        b=IjChQJC1ddl2mkZf00DByY8gcgTtdfUdk1FQCqZv2Ryn5Tb3W4Sub9y5KV15y5Z6E+
         7S+DeWV924r+jkyR2/8gQZRMxeeYGe95ABaaST+Z/tvfxcoNPeU40hSCjLyzwfVzTXLH
         E+qxI8BB/dxIBDiEgx+pG3X4xANFodbjsmqLHg1c+JPdGbh8Lgj7afNdp+94wWPsnrdQ
         fZ2ZZbaeBKbebv9VGeRp0X7HHWFYjzpD1kiag60jB2WU8HyCQeDBWWy5SphYp61Y4iQh
         3p5tKIBinnSE82kiTAPESiElJHAvJFr8x2rTxJ+C6Ozz2+rUv0LlIX3TmVVb7MNb9uUR
         3fnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709396445; x=1710001245;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OXnrbutt/Uv6uRhzZrmNOJKAYvvA2TzcK2pYWprYqQ=;
        b=fgPWJI5UkNogtzYVjeu/tGdIztZOMmdEDEOkAs63VVKVsCiasS4lHhFKGnlbSIqkCr
         ANbiXTKWT9ml163YY7wdEasTIa0yKZ/2XYmY1IUbc672BrcTv+b3q4HsfdatW6kEHjT4
         +JyE6KwG70m5A6yQlk27iTY0iCjof6zmIRlq2Bv0q+HCVldzZ8yjiR2bDDNVxZ9xFhLB
         caZdHPcfZZrs4hpYybD6JL6HL2eamzmbqvocPoru9k+P+GGIuxbkgyb9thahg3zSb0TA
         BSd7HxDAh+ReFf4LZFay6ryidCrxU4srU5K1PiOE4tuS2fXra3iVlYcm9DChMcM2o34V
         7dfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfXCbfd8EB6dmBXDZXYDKPjFbSPJgUlTmI6jZme3DnWkFFE1oooi7ce31TCwBKTisAhSlSWspQO64A1h8G3/1Z33tDu5ASvnAE
X-Gm-Message-State: AOJu0YyzmEC2OWXPpIhn+xe72MHFg/4ehIplQV3INezV9zcmgJUvWKYV
	Gs94j1d2mNiY+70vbqt/XGTH+yAOStsPMeN992jAZKknd702+lGEPZmvHiF/wmU=
X-Google-Smtp-Source: AGHT+IFCfAHe3vqhVH3b8KkO5v+8RaT1HDEedOzzDIti23+vVOzJJjjnubfyY0iN25A1mUB9oygrwQ==
X-Received: by 2002:a2e:9201:0:b0:2d2:7781:3842 with SMTP id k1-20020a2e9201000000b002d277813842mr3538422ljg.38.1709396445416;
        Sat, 02 Mar 2024 08:20:45 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id y26-20020a056402135a00b0056694006fa7sm2699540edw.70.2024.03.02.08.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 08:20:44 -0800 (PST)
Message-ID: <31e62acf-d605-4786-80a1-df52c8490913@linaro.org>
Date: Sat, 2 Mar 2024 17:20:42 +0100
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
Content-Language: en-US
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
In-Reply-To: <ZeNI1nG1dmbwOqbb@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/03/2024 16:42, Frank Li wrote:
> On Sat, Mar 02, 2024 at 02:59:39PM +0100, Krzysztof Kozlowski wrote:
>> On 01/03/2024 22:45, Frank Li wrote:
>>> Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
>>> it.
>>>
>>> Fixed below DTB_CHECK warning:
>>>   dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>
>>> Notes:
>>>     Change from v1 to v2
>>>     - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
>>>     - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
>>>     or fsl,imx8qm-edma
>>>
>>>  .../devicetree/bindings/dma/fsl,edma.yaml         | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>> index cf0aa8e6b9ec3..76c1716b8b95c 100644
>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>> @@ -59,6 +59,10 @@ properties:
>>>      minItems: 1
>>>      maxItems: 2
>>>  
>>> +  power-domains:
>>> +    minItems: 1
>>> +    maxItems: 64
>>
>> Hm, this is odd. Blocks do not belong to almost infinite number of power
>> domains.
> 
> Sorry, what's your means? 'power-domains' belong to 'properties'. 
> 'maxItems' belong to 'power-domains'.It is similar with 'clocks'. what's
> wrong? 

That one device belong to 64 power domains. That's just random code...

Best regards,
Krzysztof


