Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12F265089A
	for <lists+dmaengine@lfdr.de>; Mon, 19 Dec 2022 09:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiLSIhB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Dec 2022 03:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiLSIhB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Dec 2022 03:37:01 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838DDA19A
        for <dmaengine@vger.kernel.org>; Mon, 19 Dec 2022 00:36:59 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z26so12560287lfu.8
        for <dmaengine@vger.kernel.org>; Mon, 19 Dec 2022 00:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tw82uGtfw4j/ICrEyc+5YGeRq4afCiCWZJZFy+P3dQs=;
        b=oFRr8wZyClBWsLtnCP8nmxudjmIWGatrqm11Eq+ttQJp3XrY9MLQoK7qLX5IKkUsTG
         yU3HVMWvZekOc+KXDEvTDTvdCBh5BduC2ePz42i/itW3bAGcMnhAqJbPYEJIY/ZngWI5
         TzQYF7lmodjpegenz56I/f6uTvNuUjl82eGfIt71QPFRu3wt7LmvQknavbhx1/LfsugL
         ZCxgxjg2HCZl8HuHbp/s9aGrIcC6O3KAtiPwteGkC9+ThEKnHPeRpLYQnRCcRIiFd9qr
         no/yd131uRgzutoSzQWGNgZOXm/Fuzvo8+dF9dzj383wYXTH62rBM25rpI3ju2y44PhY
         v/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw82uGtfw4j/ICrEyc+5YGeRq4afCiCWZJZFy+P3dQs=;
        b=hUATRU8Dx5eRIyxL6wlxaEFpSazvKpWSxBwsY205VPqEW4doWhptSv9NSuRS1ZZZh/
         XUsoAZVGewXdjXtkJWHhktiTyoCqjD38KU6hcD0P0NjXl5bCuWEiRsPjR/NEN/8MSOGq
         2UOy8Nc2T+L0Lr7W082EaBxWeGrvSIhsi51rUvx+BGuzuctBM8z+jqZ8MB2lYLJcQehf
         U1WV7PZkgosGD+ICA3Vtz0n2pkoeT0uU6KcUh3XjVe8N07Eq8cIfoJRfU1xUCkgFh+JO
         KJf/OBaM0z8Vi95/sTINKg3rYF+72BXMWtYmtpA+7195rdjxtEMKm3Y4DScv34WMglIC
         4gPA==
X-Gm-Message-State: ANoB5pmlQS/aMgvauD+1tg7OiV3oNg2Hz+HGlDpr6PZy3Bx7cCTHbgXJ
        6YEQfwkLCh6yvsVf7OgZGhNNZA==
X-Google-Smtp-Source: AA0mqf75a/3UmVUQmgTrG0a2haSzoyfoVkCiR3+NDoLeIUOcoHIi0uWf/kHtgnM5iJb2+VXXbrM/Fg==
X-Received: by 2002:a05:6512:298c:b0:4b5:b2b1:69a9 with SMTP id du12-20020a056512298c00b004b5b2b169a9mr10498398lfb.20.1671439017779;
        Mon, 19 Dec 2022 00:36:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a5-20020a056512200500b00498f570aef2sm1044475lfb.209.2022.12.19.00.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 00:36:57 -0800 (PST)
Message-ID: <40956c61-ed9e-2ca3-868b-445510ea1c05@linaro.org>
Date:   Mon, 19 Dec 2022 09:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: dma: fsl-mxs-dma: Convert MXS DMA to DT
 schema
To:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221217010724.632088-1-marex@denx.de>
 <b74776b4-0885-f519-8ef7-e01048a8be15@linaro.org>
 <ba05612d-fd3b-3e49-4ada-21f3b3c74e23@denx.de>
 <a5bb28a7-c7d3-be98-9621-996d38656d98@linaro.org>
 <58b96f52-30ae-c868-8434-a0ca9e996bcd@denx.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <58b96f52-30ae-c868-8434-a0ca9e996bcd@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18/12/2022 20:06, Marek Vasut wrote:
> On 12/18/22 19:46, Krzysztof Kozlowski wrote:
>> On 18/12/2022 00:12, Marek Vasut wrote:
>>> On 12/17/22 12:05, Krzysztof Kozlowski wrote:
>>>
>>> [...]
>>>
>>>>> +allOf:
>>>>> +  - $ref: dma-controller.yaml#
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          not:
>>>>
>>>> I think "not:" goes just after "if:". Please double check that it's correct.
>>>>
>>>> Anyway it is easier to have this without negation and you already
>>>> enumerate all variants (here and below).
>>>
>>> About this part, I don't think that works. See this:
>>>
>>> $ git grep -A 15 'imx2[38]-dma-apb[hx]' arch/ | grep
>>> '\(imx2[38]-dma-apb[hx]\|dma-channels\)'
>>> arch/arm/boot/dts/imx23.dtsi: compatible = "fsl,imx23-dma-apbh";
>>> arch/arm/boot/dts/imx23.dtsi- dma-channels = <8>;
>>> arch/arm/boot/dts/imx23.dtsi: compatible = "fsl,imx23-dma-apbx";
>>> arch/arm/boot/dts/imx23.dtsi- dma-channels = <16>;
>>> arch/arm/boot/dts/imx28.dtsi: compatible = "fsl,imx28-dma-apbh";
>>> arch/arm/boot/dts/imx28.dtsi- dma-channels = <16>;
>>> arch/arm/boot/dts/imx28.dtsi: compatible = "fsl,imx28-dma-apbx";
>>> arch/arm/boot/dts/imx28.dtsi- dma-channels = <16>;
>>> arch/arm/boot/dts/imx6qdl.dtsi: compatible = "fsl,imx6q-dma-apbh",
>>> "fsl,imx28-dma-apbh";
>>> arch/arm/boot/dts/imx6qdl.dtsi- dma-channels = <4>;
>>> arch/arm/boot/dts/imx6sx.dtsi: compatible = "fsl,imx6sx-dma-apbh",
>>> "fsl,imx28-dma-apbh";
>>> arch/arm/boot/dts/imx6sx.dtsi- dma-channels = <4>;
>>> arch/arm/boot/dts/imx6ul.dtsi: compatible = "fsl,imx6q-dma-apbh",
>>> "fsl,imx28-dma-apbh";
>>> arch/arm/boot/dts/imx6ul.dtsi- dma-channels = <4>;
>>> arch/arm/boot/dts/imx7s.dtsi: compatible = "fsl,imx7d-dma-apbh",
>>> "fsl,imx28-dma-apbh";
>>> arch/arm/boot/dts/imx7s.dtsi- dma-channels = <4>;
>>> arch/arm64/boot/dts/freescale/imx8mm.dtsi: compatible =
>>> "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
>>> arch/arm64/boot/dts/freescale/imx8mm.dtsi- dma-channels = <4>;
>>> arch/arm64/boot/dts/freescale/imx8mn.dtsi: compatible =
>>> "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
>>> arch/arm64/boot/dts/freescale/imx8mn.dtsi- dma-channels = <4>;
>>>
>>> So I think what we have to do to validate that, is, say
>>>
>>> default: 4
>>>
>>> if does not match on 6q/6sx/7d/23-apbx/28-abbh/28-apbx then 8
>>>
>>> if does not match on 6q/6sx/7d/23-apbh then 16
>>>
>>> But if there is a better way to validate the above, please do tell.
>>
>> Then your existing if:then: is also not correct because you require for
>> fsl,imx28-dma-apbh (as it is not in second if:then:) const:16. Just
>> don't require it.
> 
> So, shall I just drop the entire allOf: section ?

No, what about the interrupts?

Best regards,
Krzysztof

