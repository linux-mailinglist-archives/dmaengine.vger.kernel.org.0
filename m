Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0B2789BA7
	for <lists+dmaengine@lfdr.de>; Sun, 27 Aug 2023 09:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjH0HG5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 27 Aug 2023 03:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjH0HGu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 27 Aug 2023 03:06:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E8D1A6;
        Sun, 27 Aug 2023 00:06:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500760b296aso2667735e87.0;
        Sun, 27 Aug 2023 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693120006; x=1693724806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkjF5she7UB2ljrXeMoCqa57v0rZqp9RycOLvAQ5IBI=;
        b=O2sCTNInG427q7ohexaFYYZZer3Yv3kMVyhFQW113Cjh6Ikl3i9NDB2trbTraCuwm+
         IH1rcqVu3AGCARGWN4HUxEoZDNr/2Tk1d+V99Bipph+Kb2Kl9N3RTubzl0iiIyAoxKDM
         XddduD3p8s8udOlcbxsdmbkpJGu7Qa4biRLA7qh/jDgGZj0zXZ/6KK4ys+L0FOtHmCLW
         WYaNKILcWu19CoKdSScTQt1rAiieSZ0GhKGV1qNHAzqJszW2pwmBCSDHF3NHJiLjfw/J
         8vaxEmVCNTv30LFcmjRAy5P0VLBJQVXrI1P1GALepKkrhpPvB4obvUy5Q1e5LxrvcXJ/
         3m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120006; x=1693724806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkjF5she7UB2ljrXeMoCqa57v0rZqp9RycOLvAQ5IBI=;
        b=gmvRLmpXOysLd9Ij+f3+ZDFS/lRO7ztp5j7Tle6a723LrShjXih9w2Z9KS64mS6npe
         2zdFM+4ZKfq1vK2eTe6xpyzLNPNa6YMd+/EwUuDEW9mvxFHU4EYGKA6rjlYfYdBPqtuy
         YycR2uiOxHp4t0kYBrgcZ4wy98/PTJzdfjd97rJU4l931a/l1Z3Y4cF2j9M712iO5I2q
         TaOzKAbmMlzbNpDbyrapJIWeroOtLeAGWW9y896A5O9k3MLqkIP9P2IwjqbfBArcpv7L
         txG42cYC09rhwRnH3UzKOSQU72af1gE0PT4F0ZeBc1Jm2QbBYaMUji+II312iy/LTuun
         FzGg==
X-Gm-Message-State: AOJu0YxV0UTIMkucj9idA1r2v/7qc3prvNg2QlDiULBFQgqS0N7IxwTl
        tK83uM7Xz+l5UroYrdl2Kbw=
X-Google-Smtp-Source: AGHT+IEZnvTP31rSNtj7ZBtqVy9JsE+B+3aRQDrWf0k9YBD6NoLuMUamPcOGu3t97IjhM7Mz33mDfg==
X-Received: by 2002:ac2:4e01:0:b0:4f9:56b8:45e5 with SMTP id e1-20020ac24e01000000b004f956b845e5mr8619154lfr.25.1693120005575;
        Sun, 27 Aug 2023 00:06:45 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id f20-20020ac25334000000b004fe4a1f046asm1006193lfh.266.2023.08.27.00.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 00:06:45 -0700 (PDT)
Message-ID: <717acd48-b2fa-4baa-bb94-86490c1b92ef@gmail.com>
Date:   Sun, 27 Aug 2023 10:06:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: dma: ti: k3-bcdma: Describe cfg register
 regions
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230810174356.3322583-1-vigneshr@ti.com>
 <20230810174356.3322583-2-vigneshr@ti.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230810174356.3322583-2-vigneshr@ti.com>
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



On 10/08/2023 20:43, Vignesh Raghavendra wrote:
> Block copy DMA(BCDMA)module on K3 SoCs have ring cfg, TX and RX
> channel cfg register regions which are usually configured by a Device
> Management firmware. But certain entities such as bootloader (like
> U-Boot) may have to access them directly. Describe this region in the
> binding documentation for completeness of module description.
> 
> Keep the binding compatible with existing DTS files by requiring first
> five regions to be present at least.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 25 +++++++++++++------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> index 4ca300a42a99..d166e284532b 100644
> --- a/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> @@ -37,11 +37,11 @@ properties:
>  
>    reg:
>      minItems: 3
> -    maxItems: 5
> +    maxItems: 8
>  
>    reg-names:
>      minItems: 3
> -    maxItems: 5
> +    maxItems: 8
>  
>    "#dma-cells":
>      const: 3
> @@ -161,14 +161,19 @@ allOf:
>        properties:
>          reg:
>            minItems: 5
> +          maxItems: 8
>  
>          reg-names:
> +          minItems: 5
>            items:
>              - const: gcfg
>              - const: bchanrt
>              - const: rchanrt
>              - const: tchanrt
>              - const: ringrt
> +            - const: cfg
> +            - const: tchan
> +            - const: rchan
>  
>        required:
>          - ti,sci-rm-range-bchan
> @@ -216,12 +221,16 @@ examples:
>              main_bcdma: dma-controller@485c0100 {
>                  compatible = "ti,am64-dmss-bcdma";
>  
> -                reg = <0x0 0x485c0100 0x0 0x100>,
> -                      <0x0 0x4c000000 0x0 0x20000>,
> -                      <0x0 0x4a820000 0x0 0x20000>,
> -                      <0x0 0x4aa40000 0x0 0x20000>,
> -                      <0x0 0x4bc00000 0x0 0x100000>;
> -                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
> +                reg = <0x00 0x485c0100 0x00 0x100>,
> +                      <0x00 0x4c000000 0x00 0x20000>,
> +                      <0x00 0x4a820000 0x00 0x20000>,
> +                      <0x00 0x4aa40000 0x00 0x20000>,
> +                      <0x00 0x4bc00000 0x00 0x100000>,
> +                      <0x00 0x48600000 0x00 0x8000>,

This is BCDMA_RING region and named as 'cfg'?

> +                      <0x00 0x484a4000 0x00 0x2000>,
> +                      <0x00 0x484c2000 0x00 0x2000>;
> +                reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
> +                            "cfg", "tchan", "rchan";

If you do this then add the bchan region also?

>                  msi-parent = <&inta_main_dmss>;
>                  #dma-cells = <3>;
>  

-- 
Péter
