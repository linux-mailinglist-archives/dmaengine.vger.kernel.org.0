Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46471789BBB
	for <lists+dmaengine@lfdr.de>; Sun, 27 Aug 2023 09:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjH0HTh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 27 Aug 2023 03:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjH0HTL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 27 Aug 2023 03:19:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912B81B9;
        Sun, 27 Aug 2023 00:18:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso33116511fa.3;
        Sun, 27 Aug 2023 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693120727; x=1693725527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4MoG6zmEIEoss5hF5T8Ph2HnNBlyXezvZ47IyvuMWs=;
        b=DXgZAE0zCyc+FSH4PBq0dSS9GLZEq5FKnhRYPebwZcI2Eu261Ax7MOlZbfOjCx/F+t
         y2qlqnrYh5PfFD4KWMxbC27um40xkBOtfg2e4dUr5hZTULGDAdL4h+jsodYlMpuJkjZk
         xmI5S4+J5aP8oBMFAFdHBJVnMvCLmgIpRj7b3MkLZNgXbvbbwWzb6LdwO3fj3mcZtm96
         KtgdawTNz9Ag1nHE7v0bLHrHCbBWrfC2ThoqYZD8jsQDND9vC1aiIEfEvhclfeTkWM8g
         /GN9c4JAseu6+uBf3IJRwOQr97VexGMREG0qRzdOLI8isJWJTAhFZjuLurslnNgzmIOv
         L4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120727; x=1693725527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4MoG6zmEIEoss5hF5T8Ph2HnNBlyXezvZ47IyvuMWs=;
        b=g6HFGu7+KO0mEM+ZcmacuK13r7JdUvZicelva1FMFN2sAHVpGMlBxqlTtcj8UdyoLP
         KR14ofDZJEomDpF+ALWtAE1uyr2bGv6W2g8LIn6e7KwLimEkycPGi9fb92F+s1um1aXe
         o1U1cZtCxorSAM1CDw/MkwV/kVFiulE0R9ymasUS+XWDVJicRMSkj5bgiCwVOAU4siv/
         FcZlaRPn6b9NH+b4WHZUpBDaox9PmTGdRJXkj6q0IOYP7Dv3mwkkQs5R6frjk8j/bdiE
         6YV/qTj4Yj2WSgJIHxc7u+r0W1XJS/J6N840nu9jz4fNHJaYtp6xnxXLjspPRxNCRfTn
         spKw==
X-Gm-Message-State: AOJu0YwOU2jvPR8ciOY5+1hnOTZGxq4QRAQqQSyNI7Xs6H9QgXMDKPDn
        3R/ppNMk1nwMp6cL1vhk77M=
X-Google-Smtp-Source: AGHT+IGGsas71egMkpg/1x1jfdb/gWUoBY+smY73Pdlp3F6BUUHz+zbpxF21GiXcjtEdlh4IXmTXUg==
X-Received: by 2002:a2e:a314:0:b0:2bc:d38e:b500 with SMTP id l20-20020a2ea314000000b002bcd38eb500mr11892233lje.42.1693120726926;
        Sun, 27 Aug 2023 00:18:46 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id a5-20020a05651c010500b002bcc5e9aa66sm1114746ljb.101.2023.08.27.00.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 00:18:46 -0700 (PDT)
Message-ID: <00bf501f-6829-4be3-bf1d-40ae8495d970@gmail.com>
Date:   Sun, 27 Aug 2023 10:18:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] dt-bindings: dma: ti: k3* : Update optional reg
 regions
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230810174356.3322583-1-vigneshr@ti.com>
 <9a8f06e0-b986-4434-a194-9679c82035ca@gmail.com>
 <1d2ab22e-9bbc-f876-f059-980f543551d4@ti.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <1d2ab22e-9bbc-f876-f059-980f543551d4@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vignesh,

On 11/08/2023 19:04, Vignesh Raghavendra wrote:
> 
> There is been a relook at the arch post this driver was upstreamed. 
> System firmware (SYSFW) is now two separate components:  TI Foundational 
> Security (TIFS) running in a secure island and Device Management (DM) 
> firmware (runs on boot R5 core) [0] shows boot flow diagram for AM62x.

I see, I cannot argue with that.
Is this change affecting the entire K3 family or only the new members?
If the later then I would seek for conditionality for the new regions as
non relooked SoCs these regions are off-limit for the SW.

> Security critical items such as PSIL pairing, channel firewalls and 
> credential configurations are under TIFS and is handled via TI SCI calls 
> at all times.
> 
> But, things related to resource configuration (to ensure different cores 
> dont step on each other) is under DM. Linux still needs to talk to DM 
> for configuring these regions. But, when primary bootloader (R5 SPL) is 
> running, there isn't a DM firmware (as it runs on the same core after R5 
> SPL), it would need to configure DMA resources on its own. 
> 
> This update is mainly to aid R5 SPL to reuse kernel DT as is. 
> Hope that helps

Right, so Linux will need to use these soon ;)

> 
> 
> [0] https://u-boot.readthedocs.io/en/latest/board/ti/am62x_sk.html?highlight=am62#boot-flow
> (Similar boot flow for rest of K3 devices barring am65 and am64)

OK, if the R5 needs to use DMA before DM then surely there is a need to
configure the channel(s).
I expect that R5 or DM will reset things back before booting the main CPU.

> 
>>
>>>
>>> Vignesh Raghavendra (3):
>>>    dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
>>>    dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
>>>    dt-bindings: dma: ti: k3-udma: Describe cfg register regions
>>>
>>>   .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 25 +++++++++++++------
>>>   .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 18 ++++++++++---
>>>   .../devicetree/bindings/dma/ti/k3-udma.yaml   | 14 ++++++++---
>>>   3 files changed, 43 insertions(+), 14 deletions(-)
>>>
>>
> 

-- 
Péter
