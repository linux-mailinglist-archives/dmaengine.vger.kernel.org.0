Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC14FD111
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 08:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351024AbiDLG5F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 02:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351776AbiDLGyX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 02:54:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E4BC27
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 23:44:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bg10so35325686ejb.4
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 23:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gdMXT9TzsyH4/nxmkBNQPgpVjR8VBr666pmrMpmTXZI=;
        b=Sf9531F6U+Pwb0a1JtSz+UJf/7y7GtDmQlZZhYfSi+mfIvdBuA4l0w7/WatdjA9Ad6
         TvV1/c+RE7sUGKS1/vUuU2MhBpzDMSR5e27v5CWt4Y1uEERO4rzy1WFE7UFOUTkys8y4
         CrAZELDcitDaBEG070MG6AnwITJStO2p0wpebyOBC/F8c4E4tcDxGW0/DG5QxVW1sIpV
         8p0pgBHVk3S74bwGfrfbc9v6owVXngqPs+TyhlqZ2FJ8kqVHCNvX0K4QrJKpDWlQQ4ZP
         fgucKqXTCFSYrEFgMqiDfOIFe4mCpdCXVpFSuD1BRgEDhCuvS5dXmNhhvfMGmg+v/lcO
         ESgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gdMXT9TzsyH4/nxmkBNQPgpVjR8VBr666pmrMpmTXZI=;
        b=bEln92jKD+8pbRykwnE+SwRqDCiINejVHpGJsasuS+qq0GPFgmS6TPuys4lq1xuxMX
         5xWJZN9WmHc+H+lRBo/se6lFa6mps4gcRAk5iIS7jaMXDul5+0NLubLl7Nl591F2gsnI
         Nt68BPWK+7DRcEXLLascddJHjE0EbXVje1yLcOzMhQmV3SKG/WJzy1wzR3Ew8QoBZanG
         PHoMHS12O7Ya8CI/BRIN4VjXjhw0Y8STa9wuCEuYg/BXTAB2+dSN4d6VUgEQAhWGlvlw
         NcP8ub4PeIHUkB13gbxxdSqYPbgOfmMblm7VRjleJn+79q1Auf9RIvbG+Ybt879u+/6v
         0rlQ==
X-Gm-Message-State: AOAM533ubl7b2MPDe95TrWw8DaaC59UJYMq1+JZyhimmksdWeuDfjoAT
        PukINff1P4i07twMOWZseT+3XA==
X-Google-Smtp-Source: ABdhPJzlMIXt07hedFNdXekcNnAvfM3k0nzYSnt57hMcEFauFmO4UC80WvnBdB/kePIRmAW6KtUX+g==
X-Received: by 2002:a17:907:1b06:b0:6e7:f58a:9b91 with SMTP id mp6-20020a1709071b0600b006e7f58a9b91mr34377224ejc.291.1649745840798;
        Mon, 11 Apr 2022 23:44:00 -0700 (PDT)
Received: from [192.168.0.193] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c1-20020a50cf01000000b0041cb7e02a5csm14566517edk.87.2022.04.11.23.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 23:44:00 -0700 (PDT)
Message-ID: <8ff07720-3c52-99e6-8046-501f4ae28518@linaro.org>
Date:   Tue, 12 Apr 2022 08:43:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA binding
 to json format
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
 <20220410175056.79330-7-singh.kuldeep87k@gmail.com>
 <14ecb746-56f0-2d3b-2f93-1af9407de4b7@linaro.org>
 <20220411105810.GB33220@9a2d8922b8f1>
 <50defa36-3d91-80ea-e303-abaade1c1f7e@linaro.org>
 <20220412061953.GA95928@9a2d8922b8f1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412061953.GA95928@9a2d8922b8f1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/04/2022 08:19, Kuldeep Singh wrote:
> On Mon, Apr 11, 2022 at 01:38:41PM +0200, Krzysztof Kozlowski wrote:
>> On 11/04/2022 12:58, Kuldeep Singh wrote:
>>>> This is something new and it seems only one SoC defines it (not even one
>>>> BAM version). I wonder whether this is actually correct or this
>>>> particular version of BAM is slightly different. Maybe someone could
>>>> clarify it, but if no - looks ok.
>>>
>>> Yes, sdm845.dtsi uses 4 entries and rest 1.
>>
>> Yes, I know. This does not solve my wonder.
>>
>>>
>>>>
>>>>> +
>>>>> +  num-channels:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description:
>>>>> +      Indicates supported number of DMA channels in a remotely controlled bam.
>>>>> +
>>>>> +  qcom,controlled-remotely:
>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>
>>>> type: boolean
>>>
>>> Boolean comes under flag in types.yaml
>>>
>>> definitions:
>>>   flag:
>>>     oneOf:
>>>       - type: boolean
>>>         const: true
>>>       - type: 'null'
>>>
>>> I have seen other boolean properties(spi-cpol, spi-cpha and bunch of
>>> others) using type flag. I think we should keep flag here.
>>
>> type:boolean is just shorter and example-schema recommends it. If you
>> want to base on something (as a template, pattern) then the
>> example-schema is the source, the preferred one.
> 
> I had seen other spec using flag and that's why kept same here.

I understand, you mentioned it before. However other spec is not the
example-schema...

> Which example schema are you talking about?

There is only one example-schema.
$ find ./linux -name 'example-schema*'

>>>> clocks, clock-names, qcom-ee - these are required according to old bindings.
>>>
>>> I missed qcom,ee. Will add in v3.
>>>
>>> For clocks and clock-names , there are two platforms(msm8996.dtsi,
>>> sdm845.dtsi) where these properties are missing. And I don't want to add
>>> some random values. Shall I skip them here? and let board owners add
>>> them later.
>>
>> These are required, so the SoC DTSI should be fixed. Not with random
>> clocks but something proper. :)
> 
> Yes absolutely :-)
> I have kept Srinivas in copy, who sent initial support for both the
> dtsi. Probably he can confirm provided his email doesn't bounce.
> 
> Anyway Krzysztof, can you confirm the same as you have been actively
> contributing to Qcom peripherals. I will add credit in follow-up
> submission.

Honestly not now, because I don't have access to related datasheets (I
am working on this). You can though try to look at original (vendor)
sources:
https://git.codelinaro.org/clo/la/kernel/msm-4.19 (sdm845)
https://git.codelinaro.org/clo/la/kernel/msm-3.18 (msm8996)


Best regards,
Krzysztof
