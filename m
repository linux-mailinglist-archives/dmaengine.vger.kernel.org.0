Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE75667924C
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jan 2023 08:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjAXHwu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Jan 2023 02:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjAXHwt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Jan 2023 02:52:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE7DD
        for <dmaengine@vger.kernel.org>; Mon, 23 Jan 2023 23:52:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so10275419wmq.0
        for <dmaengine@vger.kernel.org>; Mon, 23 Jan 2023 23:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAe2WJH+upW322dDk1bEGZ4cZcCC0V7GrzqFfjdJrMg=;
        b=hGPTxpSwZUv2ubxuT/5nHbDe+A30AqGBmtvji/Iv7jd9BR1eURErdOE+Ld8kUkcKcV
         KBpMd+yZB0HVRMSv788IXaCQQxdg9P9UVfVih3M/pen+O2tI+hvtR5R6cbWPe7F48Hqb
         ExACdlVSsYE6TI+k3v/pOyJomrx6/HBSc4EsF3l9xMz8Uj2+xwf7DVxSUixIp9lITiFV
         6yOGgpOTV+n/yLZlsoLSx3vLvV/ml+6ZI023vAbywjGDGOjFDrxp+r82czeY0Jb8dexv
         CP5uWx6pW85Lp7lztlLRVLu4x+/zCR5SutP5JmJbQ2uCG/SEL2XnmQFMRKINlPjQweee
         wnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAe2WJH+upW322dDk1bEGZ4cZcCC0V7GrzqFfjdJrMg=;
        b=jwT+spTPL+C/6aLY0xMBn0vgYrt4qu0n2RbPPNFqKB4chPCSeP0NA6jGfhaizFvY9c
         128rb0xwPPHTqKMk0DloxL/sZf8/NZm8V1i9Bp9+IHlVvQoY3ry6rS3Xqd85nnQlqOyY
         96ml6DEDQYTht325sMAQt1vtQWrQOcMrqGQ8BoueAVrFBYUxIVGiPulcry6oZ/UNm8vx
         cAWfIa7DSMQKghGoleK7194R0CeJSjuGgt5TeGtl9NSOhZdZFTmTqu+tD53CKi8sNnO1
         j1lWjhgfb6sbsA2pJIt1WJecypWN+ecNT2aqyl2ShGMnfRWccR5+7TWF+lSvejfUf5bU
         478w==
X-Gm-Message-State: AFqh2krh0MF4fSkc+62r8QR9YZCuEBfbaXaPN7AUqUQO3f7FXjnVijtC
        XizeW8icKbprBkLT4OJLpQhBkA==
X-Google-Smtp-Source: AMrXdXtUIbnTklwYfp0Ur7d3WG5zlOuPOMpIoOKsMyOMySKmH3lI7Ra+GFxs1Sh1FysqHT0LgtpI4A==
X-Received: by 2002:a05:600c:3488:b0:3d2:370b:97f4 with SMTP id a8-20020a05600c348800b003d2370b97f4mr34735239wmq.16.1674546760714;
        Mon, 23 Jan 2023 23:52:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bcb9a000000b003db2dede1a2sm12401412wmi.26.2023.01.23.23.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 23:52:40 -0800 (PST)
Message-ID: <b88bacbb-9da2-2175-3f59-7156c3aad4e3@linaro.org>
Date:   Tue, 24 Jan 2023 08:52:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] dt-bindings: dma: cleanup examples - indentation,
 lowercase hex
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Olivier Dautricourt <olivierdautricourt@gmail.com>,
        Stefan Roese <sr@denx.de>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Green Wan <green.wan@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?B?77+9ZXI=?= <povik+lin@cutebit.org>,
        Peng Fan <peng.fan@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        - <chuanhua.lei@intel.com>, Long Cheng <long.cheng@mediatek.com>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Palmer Debbelt <palmer@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org
References: <20230118180144.364756-1-krzysztof.kozlowski@linaro.org>
 <20230118180144.364756-2-krzysztof.kozlowski@linaro.org>
 <20230123202010.GA2455859-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123202010.GA2455859-robh@kernel.org>
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

On 23/01/2023 21:20, Rob Herring wrote:
> On Wed, Jan 18, 2023 at 07:01:44PM +0100, Krzysztof Kozlowski wrote:
>> Cleanup examples:
>>  - use 4-space indentation (for cases when it is neither 4 not 2 space),
>>  - use lowercase hex.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 36 +++++++++----------
>>  .../bindings/dma/stericsson,dma40.yaml        |  4 +--
>>  2 files changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> index 2bedab1f74e0..d34d0fa62ab5 100644
>> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> @@ -113,21 +113,21 @@ additionalProperties: false
>>  
>>  examples:
>>    - |
>> -     #include <dt-bindings/interrupt-controller/arm-gic.h>
>> -     #include <dt-bindings/interrupt-controller/irq.h>
>> -     /* example with snps,dw-axi-dmac */
>> -     dmac: dma-controller@80000 {
>> -         compatible = "snps,axi-dma-1.01a";
>> -         reg = <0x80000 0x400>;
>> -         clocks = <&core_clk>, <&cfgr_clk>;
>> -         clock-names = "core-clk", "cfgr-clk";
>> -         interrupt-parent = <&intc>;
>> -         interrupts = <27>;
>> -         #dma-cells = <1>;
>> -         dma-channels = <4>;
>> -         snps,dma-masters = <2>;
>> -         snps,data-width = <3>;
>> -         snps,block-size = <4096 4096 4096 4096>;
>> -         snps,priority = <0 1 2 3>;
>> -         snps,axi-max-burst-len = <16>;
>> -     };
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    /* example with snps,dw-axi-dmac */
>> +    dmac: dma-controller@80000 {
> 
> Drop unused labels while you are here.

Ack

> 
>> +        compatible = "snps,axi-dma-1.01a";
>> +        reg = <0x80000 0x400>;
>> +        clocks = <&core_clk>, <&cfgr_clk>;
>> +        clock-names = "core-clk", "cfgr-clk";
>> +        interrupt-parent = <&intc>;
>> +        interrupts = <27>;
>> +        #dma-cells = <1>;
>> +        dma-channels = <4>;
>> +        snps,dma-masters = <2>;
>> +        snps,data-width = <3>;
>> +        snps,block-size = <4096 4096 4096 4096>;
>> +        snps,priority = <0 1 2 3>;
>> +        snps,axi-max-burst-len = <16>;
>> +    };
>> diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
>> index 664ee61a00d8..57395a810719 100644
>> --- a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
>> +++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
>> @@ -147,9 +147,9 @@ examples:
>>      #include <dt-bindings/interrupt-controller/irq.h>
>>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>>      #include <dt-bindings/mfd/dbx500-prcmu.h>
>> -    dma-controller@801C0000 {
>> +    dma-controller@801c0000 {
>>        compatible = "stericsson,db8500-dma40", "stericsson,dma40";
>> -      reg = <0x801C0000 0x1000>, <0x40010000 0x800>;
>> +      reg = <0x801c0000 0x1000>, <0x40010000 0x800>;
>>        reg-names = "base", "lcpa";
>>        interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>>        #dma-cells = <3>;
> 
> Indentation?

Ack

Best regards,
Krzysztof

