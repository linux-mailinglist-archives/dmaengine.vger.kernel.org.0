Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AC672AAAA
	for <lists+dmaengine@lfdr.de>; Sat, 10 Jun 2023 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjFJJ1A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Jun 2023 05:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJJ1A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Jun 2023 05:27:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65DDAB
        for <dmaengine@vger.kernel.org>; Sat, 10 Jun 2023 02:26:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-977c89c47bdso467248066b.2
        for <dmaengine@vger.kernel.org>; Sat, 10 Jun 2023 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686389217; x=1688981217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iW0IFdJ2visMWM7LxTWXXt4WCl5RIYV8ZLooUjiB3F8=;
        b=Lk8sSDMO07OVN4bc95Zfj8fyn4zhfBlk7q/8qXgmoaEc4PE2PxACmSJw47YIRH+Irq
         Dy5Ja8Yhu3DTX5DLmIYwo0CwS3QJFmRs63/6aZy6pq2a5cv6d9XepSIW/+/ugfEmqJN+
         B7vVe8Jo9Xc6PMPFw/aK6k3e9k2/NPuGKMbSJkNxyvVJbAEwLtUMHItcBQTITHbx1owf
         jxTZ1UUs6M+nIGkembMkkA7YPWkzGJr6dcSQm7xQPo9KUwaaNrNsygQNaBlVssivgZXy
         Hch+LJzSHqZ3a/OOYhStzKCjzoqO4uXQP/4fFeAM5Ni427z1s3N7MPAb6jjoTFeeH+f6
         dfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686389217; x=1688981217;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iW0IFdJ2visMWM7LxTWXXt4WCl5RIYV8ZLooUjiB3F8=;
        b=lIusDDxkjE8ScppVY/DLVE2aYT51StwEuSGvu1n8iZZML70gJFJTNoq6F/vhYiHvOH
         dFy6/IMrdH+e2V6/0ubgiyiJGsQyxnlyF7LrzNRMgL5XZM5/i4vg49A0D4m2/OyL+bM6
         EO0puT2jlq0p91BHZLMaaaKC2cCM6rfFSdFdDx+KCfNFHSxWv2KxMKFJdInyE6NO0/S8
         ESS72c7rpFaAVqXeQMW/kM3fl6AUrUqFVhpFf08jNFhwrSpMH3KKupweedFwx4nP1j5y
         xnGDN9jefnHk9ZP7j6tlbjVtqKFo8FKvZwRtOH1pbjP2S+qaDLFovEdgqJ8hpwbiBRP2
         zj0g==
X-Gm-Message-State: AC+VfDxrf7TzD94okvE3/0mLeapUjrX46Byne6GxnsH1rKYe5+ASHcua
        6mezqmoqFpWxOVB0T0DowrVvsA==
X-Google-Smtp-Source: ACHHUZ6I2N1VhbYFzh7avlcgvmLESziO91Lcx5Mq2YqOB7W/6BZ3VUlE95Mgm8ZF4JvM3Amn7Kb+Hw==
X-Received: by 2002:a17:907:8a12:b0:970:1bc9:2eeb with SMTP id sc18-20020a1709078a1200b009701bc92eebmr5423427ejc.30.1686389217251;
        Sat, 10 Jun 2023 02:26:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g13-20020a056402114d00b0051830f22825sm199320edw.90.2023.06.10.02.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 02:26:56 -0700 (PDT)
Message-ID: <d1d04801-beed-c694-b6bb-0c0aa86ea014@linaro.org>
Date:   Sat, 10 Jun 2023 11:26:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: dmaengine: Add Loongson LS2X
 APB DMA controller
Content-Language: en-US
To:     Binbin Zhou <zhoubb.aaron@gmail.com>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, Yingkun Meng <mengyingkun@loongson.cn>,
        Conor Dooley <conor.dooley@microchip.com>
References: <cover.1686192243.git.zhoubinbin@loongson.cn>
 <bb2d5985a3d9fd8e7ccbe2794842d93a8978d8a6.1686192243.git.zhoubinbin@loongson.cn>
 <68bb3816-d707-3a21-59a2-8785dce7210a@linaro.org>
 <CAMpQs4JF-HtHpb_3YJBUNo2x6_E=S-gf1p9kJ7vp01S62PYSxw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMpQs4JF-HtHpb_3YJBUNo2x6_E=S-gf1p9kJ7vp01S62PYSxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10/06/2023 07:35, Binbin Zhou wrote:
> On Sat, Jun 10, 2023 at 12:49 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 08/06/2023 04:55, Binbin Zhou wrote:
>>> Add Loongson LS2X APB DMA controller binding with DT schema
>>> format using json-schema.
>>>
>>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>>
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: loongson,ls2k1000-apbdma
>>> +      - items:
>>> +          - const: loongson,ls2k0500-apbdma
>>> +          - const: loongson,ls2k1000-apbdma
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  "#dma-cells":
>>> +    const: 1
>>> +
>>> +  dma-channels:
>>> +    const: 1
>>
>> If it is const, why do you need it?
>>
> Hi Krzysztof:
> 
> IMO, although it is a single-channel DMAC, the "dma-channels" are
> still needed for a more comprehensive description of the hardware.

How does it describe more the hardware if it is obvious and always the
same? If so, why you didn't add properties like reg-io-width,
dma-requests, clock-frequency, clocks (BTW, this actually is missing),
dma-channel-mask and hundreds of others?

No, drop, it does not make sense.


Best regards,
Krzysztof

