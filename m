Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D645ED6F1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiI1H5W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 03:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiI1H5U (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 03:57:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67B622B12
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 00:57:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a2so19154342lfb.6
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ynd/xAvWC6vKNbicq++SlrgjNGg+i18HhsCYT0nkTrE=;
        b=EA2Bu8g+PgVaQF7VlHojkLmDuEnSY7rho9cz94Ruffz4Kzy05Y8NJqrI/GKNB7FnbC
         Xz0FJrva0gvzhSYYgfEuaGd3MgzC4nrddTHTb+xy6Zfr6vBEDs5fTjDcjjKWH1dRtoTk
         yyprf/1TftD9xN1TJ1D7vZTZZtrngDpx35xs8YQhRQJ0fYWjaHIfPSXnVtYUjA4D+muo
         0DtvL0Arjs9yd6s7R2AWnZr+IDuDU/W3nLVLhDeUAbx5PX4iDd8e/lNqCIRJ0vvJcYfx
         PIQqeX0FcmCQ02ABuJirM+58Q4OscoOxpzLFofQNPhIqa03nXwx+95q7J/ghB/gyKXEW
         qQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ynd/xAvWC6vKNbicq++SlrgjNGg+i18HhsCYT0nkTrE=;
        b=YsDEfGh0n16GpHD+cjXXfMhkR9OYRyC5OS0v3MzOVwTd3B6OfwbH+SKTO99U3we0Jd
         Sp1f/CZseG+ITZuUtAhDjRYzKampD6+pguKJcT6HoenvwkcuAlHFAcPKcrDMZxBEmafq
         EsmMt+46U4Bmcs92AZO8w3mOOBMMeFiMGQVx0Ob/gsguHogJTmQx5YrXYJLKLKOjSsR9
         NDPXD2ghgM/VNHUyqWH1gWASnYqlFJPi8zpyZzshlQ51eiRQ0Sxiideg6gFanA/zkYqD
         Im+FeTZT23QcHyeu32AWAsEHBV3EFgF9ditpVIpo2xMx9vCs2wmjn63zIwq5RH5T+9O8
         8ofg==
X-Gm-Message-State: ACrzQf2Jq9f2XOh5QnERpIJxCFpfRb0lC9HD7tBs9vr5E37XsguDnkJz
        1vtmFHOYue+TvgXVwMZ6HDg1Cg==
X-Google-Smtp-Source: AMsMyM5+7qBM9MwC95S/RfbFL20p37wwYy1DuBfKNARyBNJ0cO4PoB0F/2BReamTyueYn4ib6nL9yw==
X-Received: by 2002:a05:6512:3c88:b0:499:c78:5bb1 with SMTP id h8-20020a0565123c8800b004990c785bb1mr12427112lfv.503.1664351837179;
        Wed, 28 Sep 2022 00:57:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t26-20020a05651c205a00b00261ca0f940esm357461ljo.62.2022.09.28.00.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:57:16 -0700 (PDT)
Message-ID: <c6fcde71-9aff-bcd9-e3a4-231e10778c83@linaro.org>
Date:   Wed, 28 Sep 2022 09:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/4] dt-bindings: dma: qcom: gpi: add fallback
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>, robh@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220923210934.280034-1-mailingradian@gmail.com>
 <20220923210934.280034-2-mailingradian@gmail.com>
 <7b066e11-6e5c-c6d9-c8ed-9feccaec4c0c@linaro.org>
 <20220923222028.284561-1-mailingradian@gmail.com>
 <20220926231238.GA3132756-robh@kernel.org>
 <20220927015321.33492-1-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927015321.33492-1-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27/09/2022 03:53, Richard Acayan wrote:
>> On Fri, Sep 23, 2022 at 06:20:28PM -0400, Richard Acayan wrote:
>>>> On 23/09/2022 23:09, Richard Acayan wrote:
>>>>> The drivers are transitioning from matching against lists of specific
>>>>> compatible strings to matching against smaller lists of more generic
>>>>> compatible strings. Add a fallback compatible string in the schema to
>>>>> support this change.
>>>>
>>>> Thanks for the patch. I wished we discussed it a bit more. :)
>>>
>>> Ah, sorry for not replying to your original suggestion. I didn't see the
>>> opportunity for discussion as this new series wasn't that hard to come up
>>> with.
>>>
>>>> qcom,gpi-dma does not look like specific enough to be correct fallback,
>>>> at least not for all of the devices. I propose either a IP block version
>>>> (which is tricky without access to documentation) or just one of the SoC
>>>> IP blocks.
>>>
>>> Solution 1:
>>>
>>> Yes, I could use something like qcom,sdm845-gpi-dma. It would be weird to
>>> see the compatible strings for that, though:
>>
>> Why is it weird? That's how 'compatible' works. You are saying a new 
>> implementation is compatible with an older implementation.
> 
> Oh, I didn't think of it like that. I found it weird how I need to specify both
> sm8150 and sdm845 in the same dts, but now it makes sense. I guess I thought
> fallback needed to be generic, and didn't think it could just specify an older
> version of the hardware.

It's all over the tree. One big user of such pattern is iMX.

> 
>>
>>
>>>     compatible = "qcom,sdm670-gpi-dma", "qcom,sdm845-gpi-dma";
>>>
>>
>>>     // This would need to be valid in dt schema, suggesting solution 2
>>>     compatible = "qcom,sdm845-gpi-dma";
>>>     // This just doesn't make sense
>>>     compatible = "qcom,sdm845-gpi-dma", "qcom,sdm845-gpi-dma";
>>
>> Is your question how to get the first one to work, but not the second 
>> one? You need 'oneOf' with at least an entry for each case with 
>> different number of compatible strings (1 and 2 entries). There are 
>> lot's of examples in the tree.
> 
> No, I thought it would be tempting to use the first one for other device trees,
> but you maintainers know not to allow that so it doesn't matter as much.
> 
>>
>>>
>>>     compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
>>>
>>>     compatible = "qcom,sm8250-gpi-dma", "qcom,sdm845-gpi-dma";
>>>
>>> Solution 2:
>>>
>>> I could stray from the "soc-specific compat", "fallback compat" and just
>>> have "qcom,sdm845-gpi-dma" for every SoC.
>>
>> No.
>>
>>> Solution 3:
>>>
>>> I found the original mailing list archive for this driver:
>>>
>>> https://lore.kernel.org/linux-arm-msm/20200824084712.2526079-1-vkoul@kernel.org/
>>> https://lore.kernel.org/linux-arm-msm/20200918062955.2095156-1-vkoul@kernel.org/
>>>
>>> It seems like the author originally handled the ee_offset as a dt property
>>> and removed it. It was removed because it was a Qualcomm-specific property.
>>> One option would be to bring this back against the author's wishes (or ask
>>> the author about it, since they are a recipient).
>>
>> No.
> 
> Ah, simple rejections with one word. You don't have to elaborate, I see why
> these aren't a good fit.
> 
>>
>>>
>>> Solution 4:
>>>
>>> You mentioned there being an xPU3 block here:
>>>
>>> https://lore.kernel.org/linux-arm-msm/e3bfa28a-ecbc-7a57-a996-042650043514@linaro.org/
>>>
>>> Maybe it's fine to have qcom,gpi-dma-v3?
>>
>> I don't like made up version numbers. QCom does or did have very 
>> specific version numbers, but in the end they it tended to be 1 or maybe 
>> 2 SoCs per version. So not really beneficial.
> 
> I got this from using the number in xPU3, because I thought xPU3 was the
> specific hardware that had ee_offset = 0. This might not be what Krzysztof meant
> and perhaps I just wasn't reading properly.

We could go here with the versions, because indeed Qualcomm versions
them a lot. But as Rob pointed, sometimes these versions change with
every release of the SoC, so then easier for everyone is to use the SoC
number. Mapping to versions can be always mentioned in commit msg.

That's even more confusing with few IP blocks which in Qualcomm
downstream sources have a version (e.g. bwmon v4, bwmon v5) but it's
nowhere to be found in documentation of the blocks.

Then another point are people without access to Qualcomm documentation.
They cannot verify the version numbering, which one is where. Even when
I had access to Samsung SoC documentation (kind of extract of it, not
the one for hardware engineers) the versions were pretty often not
explained and even we could not figure out which block is what.

So based on that, just easier/better/readable is to use SoC numbers.

Best regards,
Krzysztof

