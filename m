Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E855DCB7
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiF0Gz0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 02:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiF0GzZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 02:55:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D20E2DE0
        for <dmaengine@vger.kernel.org>; Sun, 26 Jun 2022 23:55:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q6so16958069eji.13
        for <dmaengine@vger.kernel.org>; Sun, 26 Jun 2022 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l8DLyJeTvw1xggLYIHIAs8lG/FP9YwAC/H3QcrJQQbM=;
        b=lfgBG6BcegbTxn3oISBf4RsaDUKM1nhVWAfcGq0zhvN4IJqH7WSK7JFr5tCQyT4LhR
         d3gzqK1269FOcBTTQRj6VW3qzmmFI2wXSc64Nt2UxGUePVjixulD3AFbREgmAsN+lFeL
         HwiLI3JD9ln4Ucm/7OFwUSa0edTyKBYwXARd8flIWAl5vo19z4kdrlu7947/py5QeJYl
         5geBx1o7hjeEa6/y+BjqBlLbb00NtPWXQVfDgYXenyBSH+m2KPcW22e8FAmdWrrzn1Kk
         jK5n1XfVEc+py+OgSpy6lqVFDccn0L+WAbGo6nrf6yeJtVi6tgZY/qojyRLDyAWyox7c
         /g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l8DLyJeTvw1xggLYIHIAs8lG/FP9YwAC/H3QcrJQQbM=;
        b=fZRQ/WmVZ86Be1CLcQrib9BZ+oXGkEE0S0f/XstPdwqM3xc7KKZLwjfktbZ1LTuLyI
         2FTebPGfC0VICuaj5D2wBVUqt/slwB3YeF18zuf6/Z55wUeDijki2u32QS09iTndfQ3C
         E+hXu3XEn0Zd/CRzLqlaWTdN/dYRdFusf5MuuHcz/9YREsqIm3nR8pNL7XnzYcj20+hb
         /5TrwNj4U+q+0QjKza0TKkAuhuRT+EBnulI5K4WCn1r0xUrfFnRaiNBHtqWlmhRn+9xt
         B/RNWxBPfHVa3+MM0ns6qQt28f4sgNUz6EB0FsShDt6ZqaQ4HlfxEQoI2Te7qIUrAMsH
         rRag==
X-Gm-Message-State: AJIora9P5axhqPwzR48V/xBtLeL2MwK9fxwzXDDpb/XL3ugoIeD0xas5
        Ag/sJyAFt3J3jnyF40zYbeUIgA==
X-Google-Smtp-Source: AGRyM1uOrGGFKIKFwX1OUL+TaKzbf/DR/DTxjj1a56xgid+qPv5S8NCnwy6OhwV1/zW1L8jkeok5qg==
X-Received: by 2002:a17:907:60d2:b0:725:5611:cea6 with SMTP id hv18-20020a17090760d200b007255611cea6mr11136755ejc.60.1656312922947;
        Sun, 26 Jun 2022 23:55:22 -0700 (PDT)
Received: from [192.168.0.246] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e17-20020a170906505100b006fece722508sm4615390ejk.135.2022.06.26.23.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 23:55:22 -0700 (PDT)
Message-ID: <70cd0066-9aa7-ca41-ad61-898d491328aa@linaro.org>
Date:   Mon, 27 Jun 2022 08:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 07/14] riscv: dts: canaan: fix the k210's memory node
Content-Language: en-US
To:     Conor.Dooley@microchip.com, damien.lemoal@opensource.wdc.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     fancer.lancer@gmail.com, tglx@linutronix.de, sam@ravnborg.org,
        mail@conchuod.ie, Eugeniy.Paltsev@synopsys.com,
        daniel.lezcano@linaro.org, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, masahiroy@kernel.org, geert@linux-m68k.org,
        lgirdwood@gmail.com, niklas.cassel@wdc.com,
        dillon.minfei@gmail.com, jee.heng.sia@intel.com,
        thierry.reding@gmail.com, joabreu@synopsys.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org, vkoul@kernel.org,
        palmer@dabbelt.com, broonie@kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        daniel@ffwll.ch
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-8-mail@conchuod.ie>
 <9cd60b3b-44fe-62ac-9874-80ae2223d078@opensource.wdc.com>
 <e1fbf363-d057-1000-a846-3df524801f15@microchip.com>
 <891cf74c-ac0a-b380-1d5f-dd7ce5aeda9d@opensource.wdc.com>
 <6c9de242-6ccf-49a2-8422-e6949c5169ff@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6c9de242-6ccf-49a2-8422-e6949c5169ff@microchip.com>
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

On 21/06/2022 11:49, Conor.Dooley@microchip.com wrote:
> On 20/06/2022 01:25, Damien Le Moal wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 6/20/22 08:54, Conor.Dooley@microchip.com wrote:
>>> On 20/06/2022 00:38, Damien Le Moal wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> On 6/18/22 21:30, Conor Dooley wrote:
>>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>>
>>>>> The k210 memory node has a compatible string that does not match with
>>>>> any driver or dt-binding & has several non standard properties.
>>>>> Replace the reg names with a comment and delete the rest.
>>>>>
>>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>>> ---
>>>>> ---
>>>>>   arch/riscv/boot/dts/canaan/k210.dtsi | 6 ------
>>>>>   1 file changed, 6 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
>>>>> index 44d338514761..287ea6eebe47 100644
>>>>> --- a/arch/riscv/boot/dts/canaan/k210.dtsi
>>>>> +++ b/arch/riscv/boot/dts/canaan/k210.dtsi
>>>>> @@ -69,15 +69,9 @@ cpu1_intc: interrupt-controller {
>>>>>
>>>>>        sram: memory@80000000 {
>>>>>                device_type = "memory";
>>>>> -             compatible = "canaan,k210-sram";
>>>>>                reg = <0x80000000 0x400000>,
>>>>>                      <0x80400000 0x200000>,
>>>>>                      <0x80600000 0x200000>;
>>>>> -             reg-names = "sram0", "sram1", "aisram";
>>>>> -             clocks = <&sysclk K210_CLK_SRAM0>,
>>>>> -                      <&sysclk K210_CLK_SRAM1>,
>>>>> -                      <&sysclk K210_CLK_AI>;
>>>>> -             clock-names = "sram0", "sram1", "aisram";
>>>>>        };
>>>>
>>>> These are used by u-boot to setup the memory clocks and initialize the
>>>> aisram. Sure the kernel actually does not use this, but to be in sync with
>>>> u-boot DT, I would prefer keeping this as is. Right now, u-boot *and* the
>>>> kernel work fine with both u-boot internal DT and the kernel DT.
>>>
>>> Right, but unfortunately that desire alone doesn't do anything about
>>> the dtbs_check complaints.
>>>
>>> I guess the alternative approach of actually documenting the compatible
>>> would be more palatable?
>>
>> Yes, I think so. That would allow keeping the fields without the DTB build
>> warnings.
> 
> Hmm looks like that approach contradicts the dt-schema;
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/memory.yaml
> 
> @Rob,Krzysztof what is one meant to do here?

Why do you think it contradict bindings? Bindings for memory allow
additional properties, so you just need to create binding for this one.
And make it a correct binding, IOW, be sure that these clocks are real etc.

Although usually we had separate bindings (and device drivers) for
memory controllers, instead of including them in the "memory" node.

Best regards,
Krzysztof
