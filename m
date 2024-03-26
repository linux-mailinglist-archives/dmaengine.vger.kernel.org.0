Return-Path: <dmaengine+bounces-1507-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E888C0AA
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 12:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1955CB21BC2
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DF455798;
	Tue, 26 Mar 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtPu2Jfo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0810548F7
	for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452684; cv=none; b=rGhGh+jQcR0ErHhZbOaw85IrkGjd0FopBPdgPjzGW0634ZUvljBIaxgsOE2NGBFTH5li11dw0p1r3ZGDSe4MT4EWltQHJFsYoI0mXyqNsxnmjF1oUUSkMIk93xQlBSmadMvYPb4g3ZzegIy9QsLGZ/JswnxwicFYAD5NlbQ0HVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452684; c=relaxed/simple;
	bh=gdiFA8JUXDACIb1ZE3whn4Tbk48UFrMO3Kz+rHzfM04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbqHtj3pOEiOBMBT6mk+e93PdfwVdMqABUQbgR4e8s0SpdCsXaelLufbIiKpdvT1nVQmlZDXT+tBlonqKdWLLQE+5b2pfqep9vo6qaY2eFtCLa6q7o16E4+4d5OdkrhSRaggv/cvhkf7fBTp028dDtRyMZwkSjHrpTi3JzlaZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WtPu2Jfo; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a45f257b81fso625935266b.0
        for <dmaengine@vger.kernel.org>; Tue, 26 Mar 2024 04:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711452681; x=1712057481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6TiHBhLMtrxG4Kj/hIOTgJQ1RkjuHVilX+bsy0WXGMU=;
        b=WtPu2JfoLtWYrppfRJPogdnun6AomuL9GzumzLYxG7vh5JvYtHPKr462LriQDfl43n
         geWS09akTEH+UeKCJYm1SLoUcoYc1igITPw4VMD7A+qyhyvZJodEIyqxJWv37e6qZxqe
         IqiTIZDYCnZ4i/Jf/8mzPFqDGdwIrkkCt42h/V0Y2YxE29VsxIV1nuv/WjBv0KqKX/qz
         cYCJ3fWR81j1NTNADiv5t1pAZq++4IAT4xiR6bMyGuJecgfGJPfNbSeD6KTTqo4/bZEB
         d/ZC4Lp40bQ3iMPsm2EKlXTuDj1CovswR0XzOpovzNhDoNbmtsWKlT/uY+jQw/DmAfVW
         6LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711452681; x=1712057481;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TiHBhLMtrxG4Kj/hIOTgJQ1RkjuHVilX+bsy0WXGMU=;
        b=T4oTEtOPmNR7zD1uNScbcCCG8khNHcWpOfqKGCJcMDN2UyB/lIV29102UPNtreVneQ
         NDKrJQLJmstmuGwAQMBGnepQpg2cAGJp1czpZrJu8WHSQu7NTQswJaBwRz/zOsYeySNn
         OeJe26s/O2XFJ3+fQ0oWOnd9CVjtCrmTBthZFKhrApULRFHDIEwsUqhOtPLqUOmAT123
         5G9DFowkk1EX5APg0TaaRojH8mV/c7mdYbosWUGn65U+6jFB2ERuB8CfEs1mYF4S3zzZ
         rmiQgYlpvW7oc4dPsyxJOzMhrrhDzPTIJs3kIPcjb+SJuF+Rnp3Xk0fqqqB7c+AdIhWO
         YXxw==
X-Forwarded-Encrypted: i=1; AJvYcCUDuMk/CV/d8UmessF8Bho5rUH9GYnEWqtATL5GS0dciqz1SfMWG6YCGWYyvAn6FOTeQ5HTMB3cxwFf41Hk0sgiqR8orMeMzjqr
X-Gm-Message-State: AOJu0YyvtZThQxcn2VV+uU2F+5idXRlLsAa2kCLBa2QWqtGuMUcNV+mC
	HJQCrq0r4MooLSKKfSFkVcIPffpDMqFEqO+vq0e9SEsnWf08HAGa8LmHDkvgl18=
X-Google-Smtp-Source: AGHT+IFuPeRhJNmuBK0vDtgUjM9MnvsrbbO41q3BvDAYXHZuDMXzDqNTRU6iszlhwig3CMcQfVxteg==
X-Received: by 2002:a17:906:5810:b0:a47:1b77:7c4 with SMTP id m16-20020a170906581000b00a471b7707c4mr7089215ejq.48.1711452680880;
        Tue, 26 Mar 2024 04:31:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906081500b00a4df251a601sm725639ejd.77.2024.03.26.04.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 04:31:20 -0700 (PDT)
Message-ID: <cf42e020-9a5b-48bb-bc14-c0cc9498627b@linaro.org>
Date: Tue, 26 Mar 2024 12:31:18 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <57398ee0-212c-4c82-bfed-bf38f4faa111@linaro.org>
 <IA1PR20MB4953EDEEFC3128741F8E152EBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <473528ac-dce2-41e3-a6d7-28f8c53a89ef@linaro.org>
 <IA1PR20MB4953517450F0E622A66E9A7DBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
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
In-Reply-To: <IA1PR20MB4953517450F0E622A66E9A7DBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 12:15, Inochi Amaoto wrote:
> On Tue, Mar 26, 2024 at 09:53:09AM +0100, Krzysztof Kozlowski wrote:
>> On 26/03/2024 08:35, Inochi Amaoto wrote:
>>>>> +
>>>>> +required:
>>>>> +  - '#dma-cells'
>>>>> +  - dma-masters
>>>>> +
>>>>
>>>>
>>>> I don't understand what happened here. Previously you had a child and I
>>>> proposed to properly describe it with $ref.
>>>>
>>>> Now, all children are gone. Binding is supposed to be complete. Based on
>>>> your cover letter, this is not complete, but why? What is missing and
>>>> why it cannot be added?
>>>>
>>>
>>> The binding of syscon is removed due to a usb phy subdevices, which needs 
>>> sometime to figure out the actual property. This is why the syscon binding 
>>> is removed.
>>>
>>> I think it is better to use the origianl syscon series to evolve after
>>> the usb phy binding is submitted. The subdevices of syscon may need
>>> much reverse engineering to know its parameters. So at least for now,
>>> the syscon binding is hard to be complete.
>>
>> Some explanation why dma-router is gone would be useful, but fine.
>>
> 
> OK, I will add some comments on the why it is gone.
> 
>>>
>>>>
>>>>> +additionalProperties: false
>>>>> +
>>>>> +examples:
>>>>> +  - |
>>>>> +    dma-router {
>>>>> +      compatible = "sophgo,cv1800-dmamux";
>>>>> +      #dma-cells = <2>;
>>>>> +      dma-masters = <&dmac>;
>>>>> +      dma-requests = <8>;
>>>>> +    };
>>>>> diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
>>>>> new file mode 100644
>>>>> index 000000000000..3ce9dac25259
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/dma/cv1800-dma.h
>>>>
>>>> Filename should match bindings filename.
>>>>
>>>
>>> Thanks.
>>>
>>>>
>>>> Anyway, the problem is that it is a dead header. I don't see it being
>>>> used, so it is not a binding.
>>>>
>>>
>>> This header is not used because the dmamux node is not defined at now.
>>
>> In the driver? The binding header is supposed to be used in the driver,
>> otherwise it is not a binding.
>>
> 
> The driver does use this file.

I checked and could not find. Please point me to specific parts of the code.

> 
>>> And considering the limitation of this dmamux, maybe only devices that 
>>> require dma as a must can have the dma assigned. 
>>> Due to the fact, I think it may be a long time to wait for this header
>>> to be used as the binding header.
>>
>> I don't understand. You did not provide a single reason why this is a
>> binding. Reason is: mapping IDs between DTS and driver. Where is this
>> reason?
>>
> 
> It seems like that I misunderstood something. This file provides one-one
> mapping between the dma device id and cpuid, which is both used in the
> dts and driver. For dts, it provides device id and cpu id mapping. And
> for driver, it is used as the directive to tell how to write the mapping
> register.

So where is it? I looked for DMA_TDM0_RX - nothing. Then DMA_I2C1_RX -
nothing. Then any "DMA_" - also looks nothing.

Best regards,
Krzysztof


