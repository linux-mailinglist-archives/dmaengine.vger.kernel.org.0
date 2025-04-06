Return-Path: <dmaengine+bounces-4837-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C4BA7CF4D
	for <lists+dmaengine@lfdr.de>; Sun,  6 Apr 2025 19:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D1E7A3759
	for <lists+dmaengine@lfdr.de>; Sun,  6 Apr 2025 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F23195811;
	Sun,  6 Apr 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxYM27HB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1352318DB2F
	for <dmaengine@vger.kernel.org>; Sun,  6 Apr 2025 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743961392; cv=none; b=Dx/FzcGDrUmpshRhyMU5YQhPxdsfhQb+MhUhaSbdpXm/TBqEQLZHI9miZGr+dYYqHaP16oydRX//V+tHtMpLwcLMGKdyA4tcPzg7POPAoexE8+lsH+8bDbCwLlIPGwh0YYC47lZlxxH1FhocPjQYiZOzP/PEQevhBSKdzGuAKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743961392; c=relaxed/simple;
	bh=rJZV0G90x0J+4qYA5JGODt9/yrTs7P7YYGype4F4eq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZHKD2TrzOFYn5/jzfnitH8/U55+/QbE5/yhDP3q3h22kJQfT10H6xximyAx0TyWjpCkaSTXx5zpwwctJUhpNWryxnENyV9jfM0sRi5wO3X1dpY/u1uOsoQqu1KP/mlcxF0k3gDekCHMPw2gZdsOtN6EYcl15nBdcqa5gCnP65L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UxYM27HB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39127effa72so343515f8f.2
        for <dmaengine@vger.kernel.org>; Sun, 06 Apr 2025 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743961388; x=1744566188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUhpKvx4fBH9iWVzZ6YE2Z2g+R9flvc4QgoEqUeRJPs=;
        b=UxYM27HBXbZfffqlt8eUnnXI8taQavmyrloTSwM66/8wy4bxb5Oeirin2vCHmEklkr
         yuOZjInYnR+Ych9+KfZiSxpmsR1NZMI6Vtagogp/pyM1B385W+o4FKGguiEOBJzTduLJ
         V+CeeMr769FJzZqmaH1dFpXbK6k4hCls0EkO7FpuuFxxXeqbaLFwS1rdsCv7DCOww9Vh
         kdNvHWS8lEZ60aIsihaYnU0cAEKC5ortvVVIiBUP41knmhkjumPypz/5zF+3IfIUvdbN
         I8XKWb5u00lJBqKcNhHo2kX/MSk7Ad0c+SxWT90AiY9VjgBLOQzCufL6cWU9kcCQxchU
         Vzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743961388; x=1744566188;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUhpKvx4fBH9iWVzZ6YE2Z2g+R9flvc4QgoEqUeRJPs=;
        b=YOepX+9SARq6iWWVD4xc2xXT9tDyyjrL7lOrjGrAqbPvuoCIW0syAJ0/b0fjxx8jzM
         oB+lZYoUv50ELCN+MPvx5rz5oTs2qtwQLXlpvJFJ6WX0tDVqgeWRVZ9Y5HOfNqyCqEil
         47tqwFgmmUit+bZaEYGKDl6zvrfreoouDv9lsmoWRf9se4jCIubMCXZEdhXs5c8Hyt9v
         2tipdH/JPACrf5lnlJ2KhHnbbH9r/e0tC3K8p3GMFm2ZjEJBVf5F7rpTFQJ9qywTGzNJ
         dYS0l0Kbtpk9k419CYBywqqqKmTowDjr0CozpDOpQjQwOPxahNlfAb0L49ddfn/8F6/J
         iS0g==
X-Forwarded-Encrypted: i=1; AJvYcCWS9OjUKIjlJP5hr1dQRYxuU0Wo0/N+1B1yVtgP4WzO2jhwR5XZQ+oDcu06mzttFreJc1RevEkEiRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKBnN8WJjxFGN3k8f7eY92R1bYO6hQ+4qGw6MvuLbqJ8q0WKn2
	gcE+n8M69aViuaJI4nIaEb/UCvB4U/P288uGklU4H/JTsH36WjVo0qmx2puVUHU=
X-Gm-Gg: ASbGncvua9MGQDURopA0AvX/KMmELHbFO03QRH3hmAQiUtH56aC0pbErzAj0JX5Od8C
	r//zSsJ5W0kK4bOcCDWLQtE1TpUpUcLDtR46BKgny12RMIPxIwqBFmrf7+4i5TXP4FuA1CzuoW/
	+9APwSiyqEyXaGG1r0XxgxUeGdXW89xp+xEUOMEb/srohZwBBtaMDgATCIAMllDfTbM95Z4wyCP
	Y5ETEG/TlHWRb3C+FKt8DcaZ5bBh5j+/oj3+1gxfoNCWLRXHkzlv1c0gkS1fK5ID42s361tfS8X
	C6RTxHFsMORSdNjENU09B2QzrhNRTihOZAEwshNpY0zqr47Po2R7XWrUxsuMYYnS
X-Google-Smtp-Source: AGHT+IGzHMK4flsGk4xl8C6hBzmImNR5FM1T9MGeAQ9eadcap3jSKN01u23R9cYYDfo7R8FmbaQZeA==
X-Received: by 2002:a05:600c:5492:b0:43b:c825:6cde with SMTP id 5b1f17b1804b1-43ecf883ef7mr22800115e9.3.1743961388323;
        Sun, 06 Apr 2025 10:43:08 -0700 (PDT)
Received: from [192.168.1.106] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1630de9sm109058435e9.1.2025.04.06.10.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 10:43:07 -0700 (PDT)
Message-ID: <2f0e8807-d37c-4491-be6e-c04e3e9032e6@linaro.org>
Date: Sun, 6 Apr 2025 19:43:05 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: ti: Do not enable by default during
 compile testing
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
 <20250404122114.359087-2-krzysztof.kozlowski@linaro.org>
 <033fe56b-3f07-4fa7-98a1-84ad53034ace@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
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
In-Reply-To: <033fe56b-3f07-4fa7-98a1-84ad53034ace@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/04/2025 18:08, Péter Ujfalusi wrote:
> 
> 
> On 4/4/25 3:21 PM, Krzysztof Kozlowski wrote:
>> Enabling the compile test should not cause automatic enabling of all
>> drivers.
> 
> The scope of compile test has changed?

No, it's the same.

> These drivers will likely not going to be compile tested from now on in

Why? They are. That's why allyesconfig you have.

> practice on other that the platforms they are used?
> 
> It gave a piece of mind to know that the code compiles on ppc/x86/etc
> also or it is no longer important sanity check?

And nothing changes here. They will be compile tested on all these other
archs the same as all other arch/soc specific drivers, which do exactly
what I am doing here.

Best regards,
Krzysztof

