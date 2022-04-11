Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344544FBB1A
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 13:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbiDKLlB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 07:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244753AbiDKLlA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 07:41:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B20645ACB
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 04:38:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bh17so30209931ejb.8
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 04:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2WZi02KGSxWTDOytghirv9WvF6kDbKHRt4IaYFgOoO0=;
        b=U4GXJiDRmHt1bqW4x998No2cKXzPTUXZgJdIOCYJpo1QImMW3dVp46ceiqpZW99d+1
         m/Z0eTaFvQpBlYDMpTjMmYPpK6ggi8t+kLWEcwLpn0zzFGhx5Wpy8V0hxHgBwZTDVZZb
         0eeXz7P7N95HKev3TZQKioZsZOq8ln2COWWTyQGliCAFADddSd+qXK0rWE8VYJQMXotF
         MLQDCbbZ1lYgyvCZ0RebEVLySV/JxBFbS75Yt02bonON78w+YAFA8kknJnPV7bufZ3fL
         RfKhYMCXLUWKvdjllZD9XP0llh4fkP2Z34QDLean86/axiTY9rybX4GOklYPPnQS34PA
         calA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2WZi02KGSxWTDOytghirv9WvF6kDbKHRt4IaYFgOoO0=;
        b=i1MZdasYWFFm0l9oYWgzHAkNH2ahZTC8dGEHRS6m9P5LsE6Ntes2A2Txf115e0DfdR
         Iz8eDXBJc6maSlkNcN1sCtAmpudrpv3KaIlqI21S/IRXK8/D6uZYq8z7YpnJlU3gXCnS
         u4cnOW3RfdydNFl9R+5JKu6Frhzvxw7+x7Z0pNi07Cwa+LGiJEat18RPqkFTCg+83ffa
         rjAptVHxOMgpanYE9XYZMdj4/SF4QVp2dK5UGsHylUaxoh1Jvlc+meXr+3XRRN7aJ71W
         o+9bzZhDTpKEbKd4Geu+gWgSRmm04t5UFlYfqvXX3gWOmJWjpmo1URPbb6GspFUDRakL
         MdgQ==
X-Gm-Message-State: AOAM532hqhVEEe6Mg7dPnbCyv7evv2rxgqfMsHEixVFjtvoCySPotz3l
        pHkKZc0Scy8Zl1qC0LQ/9VVxRg==
X-Google-Smtp-Source: ABdhPJz+mkumgARH9hMHncsnKm9xsZWueFxOttDZlUJ+QgYKfLL1kW2o5ag0mAr1aD1zbT3NeO+rLw==
X-Received: by 2002:a17:907:724c:b0:6e8:59c1:914c with SMTP id ds12-20020a170907724c00b006e859c1914cmr13259814ejc.172.1649677122864;
        Mon, 11 Apr 2022 04:38:42 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j23-20020a1709064b5700b006e87ae0c111sm2318025ejv.123.2022.04.11.04.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 04:38:42 -0700 (PDT)
Message-ID: <50defa36-3d91-80ea-e303-abaade1c1f7e@linaro.org>
Date:   Mon, 11 Apr 2022 13:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 6/6] dt-bindings: dma: Convert Qualcomm BAM DMA binding
 to json format
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220411105810.GB33220@9a2d8922b8f1>
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

On 11/04/2022 12:58, Kuldeep Singh wrote:
>> This is something new and it seems only one SoC defines it (not even one
>> BAM version). I wonder whether this is actually correct or this
>> particular version of BAM is slightly different. Maybe someone could
>> clarify it, but if no - looks ok.
> 
> Yes, sdm845.dtsi uses 4 entries and rest 1.

Yes, I know. This does not solve my wonder.

> 
>>
>>> +
>>> +  num-channels:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Indicates supported number of DMA channels in a remotely controlled bam.
>>> +
>>> +  qcom,controlled-remotely:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>
>> type: boolean
> 
> Boolean comes under flag in types.yaml
> 
> definitions:
>   flag:
>     oneOf:
>       - type: boolean
>         const: true
>       - type: 'null'
> 
> I have seen other boolean properties(spi-cpol, spi-cpha and bunch of
> others) using type flag. I think we should keep flag here.

type:boolean is just shorter and example-schema recommends it. If you
want to base on something (as a template, pattern) then the
example-schema is the source, the preferred one.

>>> +required:
>>> +  - compatible
>>> +  - "#dma-cells"
>>> +  - interrupts
>>> +  - reg
>>
>> clocks, clock-names, qcom-ee - these are required according to old bindings.
> 
> I missed qcom,ee. Will add in v3.
> 
> For clocks and clock-names , there are two platforms(msm8996.dtsi,
> sdm845.dtsi) where these properties are missing. And I don't want to add
> some random values. Shall I skip them here? and let board owners add
> them later.

These are required, so the SoC DTSI should be fixed. Not with random
clocks but something proper. :)

Best regards,
Krzysztof
