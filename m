Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFEB6A1CE8
	for <lists+dmaengine@lfdr.de>; Fri, 24 Feb 2023 14:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBXNVc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Feb 2023 08:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjBXNVb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Feb 2023 08:21:31 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE8069AC3
        for <dmaengine@vger.kernel.org>; Fri, 24 Feb 2023 05:21:25 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cy6so49226359edb.5
        for <dmaengine@vger.kernel.org>; Fri, 24 Feb 2023 05:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZyflOORFuzAU5BULEoWaY0vuPe5ZUd6mweprOBGP7n4=;
        b=eEGf8AL+6iX6ix7igIArls0uX4woeA0Icw/G+F3GhaIH0WKf1pteL+EEp/5D5voScK
         QXJSbogrGgJb059hs7A0Dv7UMrG9AIajzfIAwo4bfpy8M0TiF8bv00PhDa9H0zxJgSEb
         520bsEZ1Cl92FhcSMTMskoZ3ZLuxA0IEnYdfiCWdjyOV395WmAjbDCzeE5cBgzOBa9ve
         36lKYVNVqORoRDhbXrxKrTzVHaBR7Pt98o5SWqpi+5p42MTb2GNFnjGCSHvdh9MBD1Ul
         gR7MuEowqHHhoSNgQiFW1mzH3nb6hGV38h4nF6qe6dt0Jn/xqBNjZr/ZSZOiYuJhMjPA
         TIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyflOORFuzAU5BULEoWaY0vuPe5ZUd6mweprOBGP7n4=;
        b=6xh/3+5dgIDYJXhCJlRdcGsDIwaiNqHa8iMDWKQHdq0/Zge4cP9PpuRiUTZB2o7kK5
         t7apmOmfpHHqECtZ+IgaebeqagvZm4VTAkpYo/VS4rIk+UH67et1o+hYJJqGytF9jaTa
         C3Q+AFETfjZLnwF99foOCMkQbDnwMZwYllztYvSRQa4U6XJD9nhaH6koXjuWTo8/c16S
         uTb7J5BCiRQHJrZJR3PzbeqJO6NMBNYz154bosm+h9/8GM4HWWdgbUuGaP8a0D8hB6t4
         D/2QZZ5c9JzKlEFZmNm6P/jIzjtoiBFoDMnxbPW0NxGNz/4kGf1vqAbOm8MDAA/fHPI4
         4twg==
X-Gm-Message-State: AO0yUKX6Q5Wh4zUvljlwn5U7Tr7gVJuDTTg9GhLM0Mg2yOkAPZs20yFP
        PybpzVFR4KIuVjjPZCr4IemUWw==
X-Google-Smtp-Source: AK7set+7MBWjsuB8yva8Fc5p8aC5aN5uYqqryTPqCXjxKK3H5HjlkWNP4KGkPHf5peiWVdp8nCUvCw==
X-Received: by 2002:a17:906:f212:b0:8a9:f870:d25b with SMTP id gt18-20020a170906f21200b008a9f870d25bmr22004320ejb.15.1677244883698;
        Fri, 24 Feb 2023 05:21:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id kx20-20020a170907775400b008b17de96f00sm9947077ejc.151.2023.02.24.05.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 05:21:23 -0800 (PST)
Message-ID: <6ebf87aa-4422-1f84-7e76-276ac4d884c3@linaro.org>
Date:   Fri, 24 Feb 2023 14:21:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: snps,dw-axi-dmac: Add reset
 items
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230221140424.719-1-walker.chen@starfivetech.com>
 <20230221140424.719-2-walker.chen@starfivetech.com>
 <1467f7c5-07eb-97db-c6f2-573a4208cc28@linaro.org>
 <d0984638-3f7f-7e4e-fe3e-5e1f88375dca@starfivetech.com>
 <36188e04-332f-e944-9c58-f6f2b74987da@linaro.org>
 <bd4301c5-d79f-6ba5-a840-95b733d2d44e@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bd4301c5-d79f-6ba5-a840-95b733d2d44e@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24/02/2023 14:09, Walker Chen wrote:
> 
> 
> On 2023/2/24 18:51, Krzysztof Kozlowski wrote:
>> On 24/02/2023 11:14, Walker Chen wrote:
>>>>>    resets:
>>>>> -    maxItems: 1
>>>>> +    maxItems: 2
>>>>
>>>> This breaks ABI and all other users. Test your changes before sending.
>>>
>>> I think 'minItems' should be added here. So like this:
>>> resets:
>>>   minItems: 1
>>>   maxItems: 2
>>>
>>> Other platform/users will not be affected by this.
>>
>> Which will allow two resets on all platforms. Is this correct for these
>> platforms? Do they have two resets?
>>
> In kernel 6.2, only two platforms use this DMA controller (see 'arch/arc/boot/dts/hsdk.dts' and 'arch/riscv/boot/dts/canaan/k210.dtsi').

What about all out-of-tree platforms, bootloaders and FW?

> There is one reset on k210, while there is no reset of DMA on hsdk at all.
> If here minItems with value 1 is added and the value of maxItems is changed to 2, after my testing,
> whether it is one reset or two resets, even no reset, there is no errors occur when doing dtbs_check,

Yeah, I know how this works.

> the DMA initialization shall not be affected either on their platforms.

I asked whether the hardware physically have two resets. dtbs_check
checks the DTS, not the hardware. You know allow two resets for each
other variant. What's more, you call first reset axi for all variants.
This does not look correct, e.g. k210.dtsi does not indicate this is axi
reset line but reset for entire block.

Thus your change should be constrained per your variant (min/max in
top-level, allOf:if:then allowing two lines for you, disallowing for
others).



Best regards,
Krzysztof

