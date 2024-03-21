Return-Path: <dmaengine+bounces-1462-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C500E8855B2
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 09:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA001F23F7A
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650FED516;
	Thu, 21 Mar 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnZrNLBW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92CCA47
	for <dmaengine@vger.kernel.org>; Thu, 21 Mar 2024 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009823; cv=none; b=GMOfuQz05qq7O7V2gJLBmHBVzZFKG7J7KqsOsjiFO9BeUl0DslJeFbdsS5+EVwpVAbB+795801xO7C60H+PsHINIdA9/SWtML6t8D5R56p6MZjehMI/4FP5PtRT6GlEdi/CSL3GtAY8X7UpkeLGLAfCMQHs/YhNQpPmk06RNj94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009823; c=relaxed/simple;
	bh=HsRhN+duvTrY3XPtjwHlYhQBN5UQvr1V1Pj8yD5+gJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcENwdxM1+YhX/9rRaUQaVTQjwbL8/7G1lb+A5cwQHQszSRC0HE5Yv7YUsZbALlQprGRisQ3N7WGJ8jQUFRuoJwNbp846//nhD7WacZvER3Ru1k4K+guLHU505ptqf6cPdX6Hw6Z30YtEcGYslT66TLiiBrPwY4FdkCGRVUql9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HnZrNLBW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso655753a12.3
        for <dmaengine@vger.kernel.org>; Thu, 21 Mar 2024 01:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711009820; x=1711614620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=55Jd54rSk1a0z8KIdTUOdYyilUIgNXSyH+PmVwJ3RS0=;
        b=HnZrNLBWRewe3KdIc6bn6rjsygqeLpbGXQ9CtYDD+o/vNsSWSwnUwCW9PRlbQJCYX9
         D9lOqiuo4CkcjVKrfHQGP7zWBkX2db+f2gOBPr5zVi7Azoma1sSCOiXGRQAoeSZMtXEA
         HoQUzEekXX/omYbWJDcczkkcDqdyDHWB3hwrT0ETgvA4LmYtKh4Maat79n3uP071BXRN
         orVq3Ei04AG94e6qRlJXhWskno72wZD+8iMEdf55IhZm6Mg7l6AAvp/4up0qcmRQwlAQ
         CmHKNpIt0TuBJPU5hR4fghUEcaKfAVvdXsrVdKXVRT+GTZGqhWJElErdr8rs605P+PZI
         F5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711009820; x=1711614620;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55Jd54rSk1a0z8KIdTUOdYyilUIgNXSyH+PmVwJ3RS0=;
        b=pYWrE/qLd6D+a5wxt6flgPGf4zSOrRbvG+Sc3WBiCAzQmhXgp7dYGbT/HuhT1fYJzH
         TvBXuAkJfNS7dm4shSzYiGR0R0PIKjL2NKxLJNyR19XkLKqqVMk67fUiHPdxEuTWdSL6
         ZuLXecR7NGRdNeBAOkNlvxKCbMeQ3twNdilFrCO2mIU78+gKJXRShQk7ws/18/s7Px63
         c+5pRA8T0M7oEgif7PRL9BP/CFyvCULBVfSOw9/qqZYGhERhawQ5LkNmZFSLsPtGcwrM
         jsvalbx2Rd5tl+JF4+WBt+I822qi8gSFpn+lwCiUXvCff31tjnMsM+xSm9MmX6Wjqqn6
         xAZw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Mni+aeWo9SPKHB/o6Gmyxjm6mgTRnVTMBnz+esYnv0k2pGvEEWrUWeGHdqCbMIFsDXYZVrcm8HQE8LKJwbBSKWMAY04V9Ygt
X-Gm-Message-State: AOJu0YzQ0ROIzcpONs9qZHcff2Os3BGexp7EeE0NGPjEfGTZ4rbU3M5P
	JO2/Lr16dwdGVjOAZHSMLdwdQAPnmPqE9duPpeqsvUsgapHN0ykT1O5moqHMc0C7zB6VOhWD9yW
	I
X-Google-Smtp-Source: AGHT+IEZJMJs3qFCoXfACFACARdbdMU5MSSKWQPXBGtUGzQVlGkFsIHuFUPWEtlOTSC2FQ3Pr+qAMw==
X-Received: by 2002:a17:906:4889:b0:a46:d304:fd0d with SMTP id v9-20020a170906488900b00a46d304fd0dmr6537275ejq.11.1711009820020;
        Thu, 21 Mar 2024 01:30:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id vi2-20020a170907d40200b00a45c8b6e965sm8198845ejc.3.2024.03.21.01.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 01:30:19 -0700 (PDT)
Message-ID: <87f66ba9-1692-4d89-a537-a6ff648a6ce3@linaro.org>
Date: Thu, 21 Mar 2024 09:30:17 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: ingenic: add Ingenic PDMA controller
 support.
To: bin.yao@ingenic.com, vkoul@kernel.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 1587636487@qq.com
References: <20240321080228.24147-1-bin.yao@ingenic.com>
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
In-Reply-To: <20240321080228.24147-1-bin.yao@ingenic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 09:02, bin.yao@ingenic.com wrote:
> From: "bin.yao" <bin.yao@ingenic.com>
> 
> This module can be found on ingenic victory soc.
> 
> Signed-off-by: bin.yao <bin.yao@ingenic.com>
> ---
>  drivers/dma/Kconfig        |    6 +
>  drivers/dma/Makefile       |    1 +
>  drivers/dma/ingenic-pdma.c | 1356 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1363 insertions(+)
>  create mode 100644 drivers/dma/ingenic-pdma.c
> 

You did not even compile this code... You don't have ingenic-pdma.h
header at this point.

Best regards,
Krzysztof


