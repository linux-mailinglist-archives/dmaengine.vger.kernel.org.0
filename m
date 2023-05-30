Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F99716489
	for <lists+dmaengine@lfdr.de>; Tue, 30 May 2023 16:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjE3Ol6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 May 2023 10:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjE3Ol6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 May 2023 10:41:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF4CB0
        for <dmaengine@vger.kernel.org>; Tue, 30 May 2023 07:41:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-970028cfb6cso881257666b.1
        for <dmaengine@vger.kernel.org>; Tue, 30 May 2023 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685457715; x=1688049715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZ55BKQe5vzGyKOw1n9AfdmJAZ4/YqSEcizV/peiawc=;
        b=dxSdSpU7OGIj4962KNBkgW1KbqPrzRKBhU9L5IBdAAvsWc2bKREhNjl4OUwgp2Yjz6
         57RGn+qRr5GHadFP7aiwF9FNWndp3Ea+PktAySTiFwxOChucyZGyNnax4I06uYsZEOCG
         1WYIY/zUsJSKO++7OVVxo5/s96vjvzDibfYVtb8XcOatHLDfxB5ivqFkWiTwX2PoL/42
         NjSz2sA5OhnD4p1Dq1HTFDzg0NIr/l16awbBKW0tmzU2spc1IX9Jl+orMMhxktBbJl8q
         fX79Rn48OqxJNi14gOKbkaTHiXsjnF/UH7uX3+D6kOOlepg0hj57LFeRRoS1gbTboW3m
         AK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457715; x=1688049715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZ55BKQe5vzGyKOw1n9AfdmJAZ4/YqSEcizV/peiawc=;
        b=J9LVOQ4fJn6vVLQa1cYjBCdMvD9q0YJ9SvdGav6pwl6fv9ntkbIZQK50AawkNrw5eg
         Ns1ERLIRoKORyx5i255ZXjCbz5s7ZsajRwKRTxkIXb8foWJANrsl+uktipP0PCJOMwoA
         I0C7w6dUeO18p8X67OUqp3w9aOnWZ4MIAfkWJD0shbJal5tfa1YxVwSe6h6Ql0HMr66e
         GMuITvkLk3lERyUWz9JfgTp2R30PZhm2PURK+LNGYjlK2b81UVbzkti+QUA11EckZ4Z9
         QH7qBpy/izLJSiHS19Jsaf32DrmGv4/Y8XW6V52Il4OORqxt0nSHCuvzBZxEE1WlC0wn
         vyJg==
X-Gm-Message-State: AC+VfDx/WHCl5+LBrdx2a2Lm5NaALCaHxWKKWgZocLqr0ntrHtIOpOBl
        pOPVNHr+wMEGkJ0gCjXh/FicyA==
X-Google-Smtp-Source: ACHHUZ7BxBV9LFJWkXWwzhZqkFq1FAFu83njQb+13RZvNUWZRprYqN594V5GTTGTi3Y5+Zght+O7Dw==
X-Received: by 2002:a17:907:97d3:b0:94e:5679:d950 with SMTP id js19-20020a17090797d300b0094e5679d950mr2593647ejc.72.1685457714905;
        Tue, 30 May 2023 07:41:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id fi13-20020a170906da0d00b0096fbc516a93sm7380282ejb.211.2023.05.30.07.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 07:41:54 -0700 (PDT)
Message-ID: <f0edb172-46e7-e734-d469-dea1925d0a03@linaro.org>
Date:   Tue, 30 May 2023 16:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3
 compatible string
Content-Language: en-US
To:     Frank Li <Frank.li@nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, peng.fan@nxp.com,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        shenwei.wang@nxp.com
References: <20230529200453.1423796-1-Frank.Li@nxp.com>
 <20230529200453.1423796-13-Frank.Li@nxp.com>
 <65e7b6df-b83b-2d7c-5093-f5822050827a@linaro.org>
 <ZHYAuOA6JHv6LYwl@lizhi-Precision-Tower-5810>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZHYAuOA6JHv6LYwl@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30/05/2023 15:57, Frank Li wrote:
> On Tue, May 30, 2023 at 03:08:48PM +0200, Krzysztof Kozlowski wrote:
>>> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>> index 5fd8fc604261..eed12687b0c9 100644
>>> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
>>> @@ -21,6 +21,10 @@ properties:
>>>        - enum:
>>>            - fsl,vf610-edma
>>>            - fsl,imx7ulp-edma
>>> +          - fsl,imx8qm-edma
>>> +          - fsl,imx8qm-adma
>>> +          - fsl,imx93-edma3
>>> +          - fsl,imx93-edma4
>>
>> What are these last two? What is "3" and "4"?
> 
> imx93 edma have two version, edma3(AHB) and edma4(AXI).
> There are little bit difference at channel space size.
> 
> +static struct fsl_edma_drvdata imx93_data3 = {
> +	.version = v3,
> +	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK,
> +	.chreg_space_sz = 0x10000,
> +	.chreg_off = 0x10000,
> +	.setup_irq = fsl_edma3_irq_init,
> +};
> +
> +static struct fsl_edma_drvdata imx93_data4 = {
> +	.version = v4,
> +	.flags = FSL_EDMA_DRV_HAS_CHMUX | FSL_EDMA_DRV_HAS_DMACLK,
> +	.chreg_space_sz = 0x8000,
> +	.chreg_off = 0x10000,
> +	.setup_irq = fsl_edma3_irq_init,

OK

> +};
> 
>>
>>>        - items:
>>>            - const: fsl,ls1028a-edma
>>>            - const: fsl,vf610-edma
>>> @@ -101,6 +105,22 @@ allOf:
>>>          reg:
>>>            maxItems: 2
>>>  
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            anyOf:
>>> +              - const: fsl,imx8qm-edma
>>> +              - const: fsl,imx8qm-adma
>>> +              - const: fsl,imx93-edma3
>>> +              - const: fsl,imx93-edma4
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          maxItems: 1
>>> +        interrupts:
>>> +          maxItems: 64
>>
>> That's odd. What about the names? What about minItems? Anyway, this
>> wasn't tested - you will have failures with dtbs_check.
> 
> It passed dtbs_check. interrupt-names is optional property, which
> will no used after edma v3.
> 
> Planned dts look like:
> 
> +                       edma1: dma-controller@44000000{
> +                               compatible = "fsl,imx93-edma3";
> +                               reg = <0x44000000 0x200000>;
> +                               #dma-cells = <3>;
> +                               dma-channels = <31>;
> +                               interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +                                            <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +                                            <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> 						....

So add here interrupt-names and double check the result... Optional
means it can appear.

Best regards,
Krzysztof

