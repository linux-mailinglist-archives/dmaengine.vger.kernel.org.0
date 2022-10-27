Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D560F44A
	for <lists+dmaengine@lfdr.de>; Thu, 27 Oct 2022 12:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiJ0KCQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Oct 2022 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiJ0KB5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Oct 2022 06:01:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A345F48;
        Thu, 27 Oct 2022 03:01:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 21AAC66028CF;
        Thu, 27 Oct 2022 11:01:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666864880;
        bh=AB1aP9kwM/VwRRkN+/wjhOvonTMwp6saazq/+FJtpWc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nRjRmmzVvgQJpr/h0Tp/P1Qf9rpckVNTKqkO+iB9FyWrDTZGi3veSqviqNneNshhP
         W0BMm5lonVgi70d0R38IoxZJKZRDXXsyoeQ5MGmG0m+X4ovpN1eE/CjGIQX1o4aP3g
         b2souJy9giA0QrMaZH0kXbny4gyuFBE17CX8yFLvc3yrWesoauIbndfHnZOjS+b2N0
         QCruCMKZ4rdlvzW3+ix9e9OVePdHvcTAQbodDLoJ9bwYZ2/lg3ppdaYeMS1MrqCuS0
         4QaCOjwyBbbjH3LDyh15SKpdLjKDqOJcH8OMsPwm2DVankGQJTDsE8fwcvJujlvMgr
         cypZa0SBjqEFw==
Message-ID: <3b09d15a-2cc2-c485-5045-820ccd5863c3@collabora.com>
Date:   Thu, 27 Oct 2022 12:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 7/7] arm64: dts: mediatek: Add support for MT6795 Sony
 Xperia M5 smartphone
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        fparent@baylibre.com, sam.shih@mediatek.com,
        sean.wang@mediatek.com, long.cheng@mediatek.com,
        wenbin.mei@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220729104441.39177-1-angelogioacchino.delregno@collabora.com>
 <20220729104441.39177-8-angelogioacchino.delregno@collabora.com>
 <a8fa9e22-8c3f-60b2-a0db-01cfd5c37765@somainline.org>
 <17139e24-d33c-8240-cd4a-d87fb3b29276@collabora.com>
 <9ced2822-a9d2-2e59-fe40-6c6f690be487@somainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <9ced2822-a9d2-2e59-fe40-6c6f690be487@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Il 27/10/22 11:40, Konrad Dybcio ha scritto:
> 
> On 27/10/2022 11:28, AngeloGioacchino Del Regno wrote:
>> Il 29/07/22 14:00, Konrad Dybcio ha scritto:
>>>
>>>
>>> On 29.07.2022 12:44, AngeloGioacchino Del Regno wrote:
>>>> Add a basic support for the Sony Xperia M5 (codename "Holly")
>>>> smartphone, powered by a MediaTek Helio X10 SoC.
>>>>
>>>> This achieves a console boot.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>> <angelogioacchino.delregno@collabora.com>
>>
>> Hello Konrad,
>> First of all, I'm sorry for the very late reply.
>>
>>>> ---
>>>>   arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>>>>   .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 90 +++++++++++++++++++
>>>>   2 files changed, 91 insertions(+)
>>>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile 
>>>> b/arch/arm64/boot/dts/mediatek/Makefile
>>>> index af362a085a02..72fd683c9264 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>>> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
>>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-sony-xperia-m5.dtb
>>> -holly.dtb?
>>>
>>
>> I prefer using the commercial name to identify the device.
>> "Holly" is the smartphone project codename and that is mentioned almost nowhere:
>> the aim here is to enhance readability as to make it immediately understandable
>> that this devicetree is for the Xperia M5 device.
> 
> Ok, sounds good.
> 
> 
>>
>>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>>>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts 
>>>> b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
>>>> new file mode 100644
>>>> index 000000000000..94d011c4126c
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
>>>> @@ -0,0 +1,90 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (c) 2022, Collabora Ltd
>>>> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +#include "mt6795.dtsi"
>>>> +
>>>> +#include <dt-bindings/gpio/gpio.h>
>>> Looks unused.
>>>
>>
>> Right, I'll remove that in v2.
>>
>>>> +
>>>> +/ {
>>>> +    model = "Sony Xperia M5";
>>>> +    compatible = "sony,xperia-m5", "mediatek,mt6795";
>>> sony,holly?
>>>
>>
>> I'm sorry, but I can't understand the sense of adding that compatible string to
>> the mix. To the kernel, it doesn't mean anything - and we already have another
>> string advertising the specific machine, which is "sony,xperia-m5".
> 
> I was suggesting replacing xperia-m5 with holly, but since we agreed on keeping
> 
> m5 in the dtb name, I suppose it's fine for this one to stay too.
> 
> 
>>
>> Of course, there is no Xperia M5 with a different SoC and, even if there was a
>> xperia-m5 with a different SoC, we anyway have both a machine compatible and a
>> SoC compatible in here, so that would still not pose any issue.
>>
>>>> +    chassis-type = "handset";
>>>> +
>>>> +    aliases {
>>>> +        mmc0 = &mmc0;
>>>> +        mmc1 = &mmc1;
>>>> +        serial0 = &uart0;
>>>> +        serial1 = &uart1;
>>>> +    };
>>>> +
>>>> +    memory@40000000 {
>>>> +        device_type = "memory";
>>>> +        reg = <0 0x40000000 0 0x1E800000>;
>>> Lowercase hex in size. Also, doesn't the bootloader fill it in?
>>>
>>
>> Updating the device to the latest software version will give you a bootloader
>> that fills that in, but the first-ever software release contains one that will
>> not do that in particular conditions (fastboot boot).
> 
> Ugh. If only vendors tested their software before shipping it to users..
> 
> I think it's worth to adding a comment mentioning that, though.
> 
> 
>>
>>>> +    };
>>>> +
>>>> +    reserved_memory: reserved-memory {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +        ranges;
>>>> +
>>>> +        /* 128 KiB reserved for ARM Trusted Firmware (BL31) */
>>> Is that true for all devices with this SoC, or..? If so, it may be worth
>>> moving this into mt6795.dtsi.
>>>

Sorry again, I forgot to reply to this question, so addressing that now:
no, that's not true for all devices with this SoC.

I'm practically sure that all commercial devices that were shipped at that time
require the same, but here upstream we also have a MT6795 dev board devicetree,
which uses a much newer bootloader and possibly needs a different secmon carveout,
if any at all.

Hence, this one cannot be transferred to mt6795.dtsi.

