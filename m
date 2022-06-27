Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFBD55CB79
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiF0JYW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiF0JYT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 05:24:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A893893
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 02:24:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ay16so17828581ejb.6
        for <dmaengine@vger.kernel.org>; Mon, 27 Jun 2022 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WheMo0jihvDqC8vkz7SeuHDX+Y7spNQBPItzd2n3lJ0=;
        b=L2p+vhW8V4W2qd7Xx3ICJgwuBfUCYsXAwPJ9+Y54ki6Mzrs21eZhOBQOQqzrdRq/ki
         q0wO1Kbml/A5MfI4+eCB/NgTIvhAWmZPe+KUVsiGeHeztxDvJQabWrZZSskL6GEP1urI
         di/+WaZWgQGlzKszgnTOuItTXx/H8QdR/6gx8NMdNwu9XtjumwRj0LLc8wZjyo/bYs0Y
         pGGhj20wTkxXzcozlbLzEubE27s5Z5Pdn8wEDc4jfG6uWnRvSPbNv0rV59MkXIyeNnyd
         zTqYMzzoQ/bRv2c90D5XQF1LkO+eUL1tVBNcnB2g7ZdGy97RIG1VFYU63ghv9apqNY+r
         07gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WheMo0jihvDqC8vkz7SeuHDX+Y7spNQBPItzd2n3lJ0=;
        b=nPJZAppZD9fUiawxVy9p1XXumJnQi7TVBh9sS0qqHlb95H3DSbZqtsbgKTSd/xA2Eb
         1yIWGqTf5mcD/78qDeCpecd0/Et6gI9/vE8nBNNloxqk/qaK5Jw1zX0BMrNUMtEZhvNo
         K8nOjXUZteqrjDXfA+NrLR0QAn7werLjc+hXvn0ZbY9foqYt+zesackq4vWYPRK+HgJi
         PuxzbWrEdaXUndRD8N/v7IKBZtKJw8HCF+N1/QgS6L6xfRUi+uyfjES8jMtVZddVe3m8
         xSLEz3XY0awIQoL6yc6+31d09aOj8gS7ZAmR8Jw7sPj6+xmCARXlo3ACmQVZF6TuP34c
         DyZg==
X-Gm-Message-State: AJIora+N4LSpVlm7z+6TF0CCZhqpsERwrxzkKcgUHQUhc/3WjrEQhQo8
        7vPLbdFJxxm+xT2iWAcIcFVEag==
X-Google-Smtp-Source: AGRyM1vmSw4PkoUJobIyZ+0PFFNkXJG8udoaIUyo4XAy6BtVMPROE7ZMi8N88/BWlX2w6+MlYxVhXQ==
X-Received: by 2002:a17:906:478e:b0:722:f84d:159f with SMTP id cw14-20020a170906478e00b00722f84d159fmr11897036ejc.182.1656321856221;
        Mon, 27 Jun 2022 02:24:16 -0700 (PDT)
Received: from [192.168.0.247] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906545000b006feb20b5235sm4820639ejp.84.2022.06.27.02.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 02:24:15 -0700 (PDT)
Message-ID: <430f5284-b107-e43c-7329-9e299093a352@linaro.org>
Date:   Mon, 27 Jun 2022 11:24:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 07/14] riscv: dts: canaan: fix the k210's memory node
Content-Language: en-US
To:     Conor.Dooley@microchip.com, damien.lemoal@opensource.wdc.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     fancer.lancer@gmail.com, tglx@linutronix.de, sam@ravnborg.org,
        Eugeniy.Paltsev@synopsys.com, daniel.lezcano@linaro.org,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        masahiroy@kernel.org, geert@linux-m68k.org, lgirdwood@gmail.com,
        niklas.cassel@wdc.com, dillon.minfei@gmail.com,
        jee.heng.sia@intel.com, thierry.reding@gmail.com,
        joabreu@synopsys.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, palmer@dabbelt.com,
        broonie@kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        daniel@ffwll.ch
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-8-mail@conchuod.ie>
 <9cd60b3b-44fe-62ac-9874-80ae2223d078@opensource.wdc.com>
 <e1fbf363-d057-1000-a846-3df524801f15@microchip.com>
 <891cf74c-ac0a-b380-1d5f-dd7ce5aeda9d@opensource.wdc.com>
 <6c9de242-6ccf-49a2-8422-e6949c5169ff@microchip.com>
 <70cd0066-9aa7-ca41-ad61-898d491328aa@linaro.org>
 <b8dce80e-2753-497e-1dd3-3eb0d248b74e@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b8dce80e-2753-497e-1dd3-3eb0d248b74e@microchip.com>
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

On 27/06/2022 09:06, Conor.Dooley@microchip.com wrote:
> 
> 
> On 27/06/2022 07:55, Krzysztof Kozlowski wrote:
>> On 21/06/2022 11:49, Conor.Dooley@microchip.com wrote:
>>> On 20/06/2022 01:25, Damien Le Moal wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On 6/20/22 08:54, Conor.Dooley@microchip.com wrote:
>>>>> On 20/06/2022 00:38, Damien Le Moal wrote:
>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>>>
>>>>>> On 6/18/22 21:30, Conor Dooley wrote:
>>>>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>>>>
>>>>>>> The k210 memory node has a compatible string that does not match with
>>>>>>> any driver or dt-binding & has several non standard properties.
>>>>>>> Replace the reg names with a comment and delete the rest.
>>>>>>>
>>>>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>>>>> ---
>>>>>>> ---
>>>>>>>    arch/riscv/boot/dts/canaan/k210.dtsi | 6 ------
>>>>>>>    1 file changed, 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
>>>>>>> index 44d338514761..287ea6eebe47 100644
>>>>>>> --- a/arch/riscv/boot/dts/canaan/k210.dtsi
>>>>>>> +++ b/arch/riscv/boot/dts/canaan/k210.dtsi
>>>>>>> @@ -69,15 +69,9 @@ cpu1_intc: interrupt-controller {
>>>>>>>
>>>>>>>         sram: memory@80000000 {
>>>>>>>                 device_type = "memory";
>>>>>>> -             compatible = "canaan,k210-sram";
>>>>>>>                 reg = <0x80000000 0x400000>,
>>>>>>>                       <0x80400000 0x200000>,
>>>>>>>                       <0x80600000 0x200000>;
>>>>>>> -             reg-names = "sram0", "sram1", "aisram";
>>>>>>> -             clocks = <&sysclk K210_CLK_SRAM0>,
>>>>>>> -                      <&sysclk K210_CLK_SRAM1>,
>>>>>>> -                      <&sysclk K210_CLK_AI>;
>>>>>>> -             clock-names = "sram0", "sram1", "aisram";
>>>>>>>         };
>>>>>>
>>>>>> These are used by u-boot to setup the memory clocks and initialize the
>>>>>> aisram. Sure the kernel actually does not use this, but to be in sync with
>>>>>> u-boot DT, I would prefer keeping this as is. Right now, u-boot *and* the
>>>>>> kernel work fine with both u-boot internal DT and the kernel DT.
>>>>>
>>>>> Right, but unfortunately that desire alone doesn't do anything about
>>>>> the dtbs_check complaints.
>>>>>
>>>>> I guess the alternative approach of actually documenting the compatible
>>>>> would be more palatable?
>>>>
>>>> Yes, I think so. That would allow keeping the fields without the DTB build
>>>> warnings.
>>>
>>> Hmm looks like that approach contradicts the dt-schema;
>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/memory.yaml
>>>
>>> @Rob,Krzysztof what is one meant to do here?
>>
>> Why do you think it contradict bindings? Bindings for memory allow
> 
> Because when I tried to write the binding, the memory node complained
> about the clock properties etc and referenced the dt-schema (which
> for memory@foo nodes has additionalProperties: false.

Ah, I see, I looked at wrong level. Indeed memory node cannot have
anything else.

> 
>> additional properties, so you just need to create binding for this one.
>> And make it a correct binding, IOW, be sure that these clocks are real etc.
>>
>> Although usually we had separate bindings (and device drivers) for
>> memory controllers, instead of including them in the "memory" node.
> 
> I guess changing to that format would probably require some changes on
> the U-Boot side of things. Taking "calxeda,hb-ddr-ctrl" as an example,
> looks like the clocks etc go in a controller node, which seems like a
> "better" way of doing it - 

Yes, because I think memory node is kind of special. It describes the
physical memory layout for the system, not the memory controller or
memory characteristics (like timings).

What U-Boot needs is indeed memory controller node. It's not only
calxeda but also few others using JEDEC LPDDR bindings.

> but would break existing dts in U-Boot
> without changes to handle both methods there.

Yes, that's a bit inconvenient but also a price someone has to pay for
introducing DTS properties without bindings.

Best regards,
Krzysztof
