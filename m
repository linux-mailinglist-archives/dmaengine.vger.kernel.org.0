Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697D755271E
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 00:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243697AbiFTWtI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jun 2022 18:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiFTWtH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jun 2022 18:49:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECA415A0A
        for <dmaengine@vger.kernel.org>; Mon, 20 Jun 2022 15:49:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso8421387wms.3
        for <dmaengine@vger.kernel.org>; Mon, 20 Jun 2022 15:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hy0Xdesz3zE5Os2cbPhgUWle+TPKNOoLmrTtPiHUQEo=;
        b=ZYwDRlfKOOYKL+WIoMVmcZBHfH2hZEk5UjfT4f00kyzA1TsSsZ+LLvooOGasTgLcId
         /NSAyz9yGyNuvDaS+3NY3LrQJux2Kre3iqsxIzfjtaHz8yP2JPfiqTY0iIx54VZsLF75
         Bzqxx5NujcXuLdNFG/rKZtgfRcfumIOzcQjIFXgkYjJoapiB7NEOxkt7XIo+thbkpsDZ
         AXPYAD+vnORi81F2kP1c7A3xKDez+YBlJvfQsHH8b+VCDdx2BVjR6HFF0zFQyv0Thecj
         nsZQUG8VQSsn6ub9nbGGdLWLOvXLQCQP14tjSUiP3G3d/xo+501S04egjJ0MAwRhGLpS
         4+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hy0Xdesz3zE5Os2cbPhgUWle+TPKNOoLmrTtPiHUQEo=;
        b=n2Yf2xmSyFSCvfK33+6dlLk1STep+D9nVJIQtqfrMbYEMEK0Du7XVvmHlCgpUYOUmo
         2bu2DEXY5VncsALNoCjKzirn2Qs1/zznJmKu/gmtswm9VTwq0gDb4y5YBrHvq3qDPojX
         C7TOLnX4Xpqxhfs1vC5E0emgwUR2c6D83G9SJKZ7inko7lhAAPW7lu+EL4N2HXOV0NbF
         HZ/QsXmOrUX6E9qjgLvd9a1hl3CusHTpoRpwBKiWUWRcj5a061Zhzl4mR/LxbRXV46H/
         JtyFbguKreGOGzOsXY9qsjyUo/D7KzW9COx7QB8+MvBYrfTtXliDVv/sLlOQ0f1X3uz4
         sVjQ==
X-Gm-Message-State: AJIora/Vht7Qw+Gf79AVhv48YwqZw9UlWjcJ8zmiCoqkOb+pLb8jhTWm
        O7pj+9f+j9+ym/PU9m+H7T2taw==
X-Google-Smtp-Source: AGRyM1sWkC5yVB3Vh70iYg5zpUyg3STH8l29UNOqYvK+YL6zEEjsIRVCZulowHoh/WC9YX4xPFr8HA==
X-Received: by 2002:a05:600c:4f51:b0:39c:7f6c:a8d6 with SMTP id m17-20020a05600c4f5100b0039c7f6ca8d6mr26961636wmq.143.1655765344601;
        Mon, 20 Jun 2022 15:49:04 -0700 (PDT)
Received: from [192.168.2.222] ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d6989000000b0020c5253d8dcsm14187651wru.40.2022.06.20.15.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 15:49:03 -0700 (PDT)
Message-ID: <a2d85598-76d1-c9dc-d50d-e5aa815997cf@conchuod.ie>
Date:   Mon, 20 Jun 2022 23:49:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Conor.Dooley@microchip.com, fancer.lancer@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        sam@ravnborg.org, Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, daniel.lezcano@linaro.org,
        palmer@dabbelt.com, palmer@rivosinc.com, tglx@linutronix.de,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        masahiroy@kernel.org, geert@linux-m68k.org, niklas.cassel@wdc.com,
        dillon.minfei@gmail.com, jee.heng.sia@intel.com,
        joabreu@synopsys.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-7-mail@conchuod.ie>
 <20220620205654.g7fyipwytbww5757@mobilestation>
 <61b0fb86-078d-0262-b142-df2984ce0f97@microchip.com>
 <9a1fcb40-9267-d8e6-b3b6-3b03fd789822@opensource.wdc.com>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <9a1fcb40-9267-d8e6-b3b6-3b03fd789822@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 20/06/2022 23:46, Damien Le Moal wrote:
> On 6/21/22 06:06, Conor.Dooley@microchip.com wrote:
>> On 20/06/2022 21:56, Serge Semin wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On Sat, Jun 18, 2022 at 01:30:28PM +0100, Conor Dooley wrote:
>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>
>>>> snps,dwc-ssi-1.01a has a single user - the Canaan k210, which uses a
>>>> width of 4 for spi-{r,t}x-bus-width. Update the binding to reflect
>>>> this.
>>>>
>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>> ---
>>>>  .../bindings/spi/snps,dw-apb-ssi.yaml         | 48 ++++++++++++++-----
>>>>  1 file changed, 35 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>> index e25d44c218f2..f2b9e3f062cd 100644
>>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>> @@ -135,19 +135,41 @@ properties:
>>>>        of the designware controller, and the upper limit is also subject to
>>>>        controller configuration.
>>>>
>>>> -patternProperties:
>>>> -  "^.*@[0-9a-f]+$":
>>>> -    type: object
>>>> -    properties:
>>>> -      reg:
>>>> -        minimum: 0
>>>> -        maximum: 3
>>>> -
>>>> -      spi-rx-bus-width:
>>>> -        const: 1
>>>> -
>>>> -      spi-tx-bus-width:
>>>> -        const: 1
>>>> +if:
>>>> +  properties:
>>>> +    compatible:
>>>> +      contains:
>>>> +        const: snps,dwc-ssi-1.01a
>>>> +
>>>> +then:
>>>> +  patternProperties:
>>>> +    "^.*@[0-9a-f]+$":
>>>> +      type: object
>>>> +      properties:
>>>> +        reg:
>>>> +          minimum: 0
>>>> +          maximum: 3
>>>> +
>>>> +        spi-rx-bus-width:
>>>> +          const: 4
>>>> +
>>>> +        spi-tx-bus-width:
>>>> +          const: 4
>>>> +
>>>> +else:
>>>> +  patternProperties:
>>>> +    "^.*@[0-9a-f]+$":
>>>> +      type: object
>>>> +      properties:
>>>> +        reg:
>>>> +          minimum: 0
>>>> +          maximum: 3
>>>> +
>>>> +        spi-rx-bus-width:
>>>> +          const: 1
>>>> +
>>>> +        spi-tx-bus-width:
>>>> +          const: 1
>>>
>>> You can just use a more relaxed constraint "enum: [1 2 4 8]" here
>>
>> 8 too? sure.
>>
>>> irrespective from the compatible string. The modern DW APB SSI
>>> controllers of v.4.* and newer also support the enhanced SPI Modes too
>>> (Dual, Quad and Octal). Since the IP-core version is auto-detected at
>>> run-time there is no way to create a DT-schema correctly constraining
>>> the Rx/Tx SPI bus widths. So let's keep the
>>> compatible-string-independent "patternProperties" here but just extend
>>> the set of acceptable "spi-rx-bus-width" and "spi-tx-bus-width"
>>> properties values.
>>
>> SGTM!
>>
>>>
>>> Note the DW APB SSI/AHB SSI driver currently doesn't support the
>>> enhanced SPI modes. So I am not sure whether the multi-lines Rx/Tx SPI
>>> bus indeed works for Canaan K210 AHB SSI controller. AFAICS from the
>>> DW APB SSI v4.01a manual the Enhanced SPI mode needs to be properly
>>> activated by means of the corresponding CSR. So most likely the DW AHB
>>> SSI controllers need some specific setups too.
>>
>> hmm, well I'll leave that up to people that have Canaan hardware!
> 
> I will test this series.
> 

Cool, thanks.
I'll try to get a respin out tomorrow w/ the memory node "unfixed".
Conor.

>> Thanks,
>> Conor.
>>
>>>
>>> -Sergey
>>>
>>>>
>>>>  unevaluatedProperties: false
>>>>
>>>> --
>>>> 2.36.1
>>>>
>>
> 
> 
