Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E675789BAE
	for <lists+dmaengine@lfdr.de>; Sun, 27 Aug 2023 09:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjH0HKX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 27 Aug 2023 03:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjH0HKD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 27 Aug 2023 03:10:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE14E4;
        Sun, 27 Aug 2023 00:10:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5009d4a4897so3382760e87.0;
        Sun, 27 Aug 2023 00:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693120199; x=1693724999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzOMGTlsUXfchyGera0EDmmhjbWGxdlJgkRc3qJ1V74=;
        b=Hbj3Q0bIJNKETVveN6SO4qN5rM3fQv4iUdIS5vgGfpVglyQ7ZjbMuO7ioMDjDiTUBb
         b7r8U/n+I1gCweak+Ar/7QiDatqhS4/eurDyzfei7JTBXgljAYQyWfEHT83r/RBKZoD4
         /NEAX28gk+CpfCbJJLtg92K7w+ognbJIZMTJwraFtywwrMEcKkz3pAYjvaK2fy32pQM9
         oQrHnQePLU54XXNTThBjW8OuJTuwwOyUdQaPqlc00MqDfK/4xEW1RPbE5TVdCnKOX0Mr
         QfldmIfpdCokR1CoNLgjwqjrt3towj+CCRIScA4uslBbwqUhLvZ4QFMVhnhKWseIwU5g
         hXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693120199; x=1693724999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzOMGTlsUXfchyGera0EDmmhjbWGxdlJgkRc3qJ1V74=;
        b=RKkbF9bxkJZ4vABewqxpIoLKzRXpxNQCdBjkqB3vlf53GgR4Ko1WNMxOD+Wj05ns9F
         9fEX3xulk4tWh6AkIhefFgFlwSFhICiytO0aSy2dg/Z2SlfOQ6yk/FUVuAfgHGnhlYwp
         ABEt2V6/1E8f+EO9PblPDXw/FsBfBduWjj+mewDTm8wrWxMMrzOG1l71KhC2HYSlm/Rm
         ooC4P8I+83rnKRONDjphyfuIB8+9EUUcxuoXTSAOyBLAeQ0IkSyGXYAGrxKt4yAgraCP
         FKvZjrpmw8dflvh6ud8tLdI2E3pRgDdlv94+/7HKvGHIRgB+bF7y9ro7BM5/lCGkNo0P
         ST5w==
X-Gm-Message-State: AOJu0YyyDsVYMJK7NT3gbqTnVwA/zPt86YjGOcB8ZmcbbsTn2wXRlKDc
        CoxPMwdof8lGjVeFvjhJmAU=
X-Google-Smtp-Source: AGHT+IFvuXonDoK3DoXZNe2l0wFzs17CVwkuaiDqsboRy1omHg2mR7/E6Tinu1/0f0jAz77iQxkceA==
X-Received: by 2002:a19:791d:0:b0:4fe:711:2931 with SMTP id u29-20020a19791d000000b004fe07112931mr15704328lfc.22.1693120198823;
        Sun, 27 Aug 2023 00:09:58 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id f17-20020ac25331000000b00500a2091e2bsm1025065lfh.99.2023.08.27.00.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 00:09:58 -0700 (PDT)
Message-ID: <26d10fbf-8b85-47bd-ad8a-6b885575f714@gmail.com>
Date:   Sun, 27 Aug 2023 10:10:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: dma: ti: k3-pktdma: Describe cfg
 register regions
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230810174356.3322583-1-vigneshr@ti.com>
 <20230810174356.3322583-3-vigneshr@ti.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230810174356.3322583-3-vigneshr@ti.com>
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
> Packet DMA (PKTDMA) module on K3 SoCs have ring cfg, TX and RX channel
> cfg and RX flow cfg register regions which are usually configured by a
> Device Management firmware. But certain entities such as bootloader
> (like U-Boot) may have to access them directly. Describe this region in
> the binding documentation for completeness of module description.
> 
> Keep the binding compatible with existing DTS files by requiring first
> four regions to be present at least.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/dma/ti/k3-pktdma.yaml  | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
> index a69f62f854d8..5f9ba4bb05f6 100644
> --- a/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml
> @@ -45,14 +45,20 @@ properties:
>        The second cell is the ASEL value for the channel
>  
>    reg:
> -    maxItems: 4
> +    minItems: 4
> +    maxItems: 8
>  
>    reg-names:
> +    minItems: 4
>      items:
>        - const: gcfg
>        - const: rchanrt
>        - const: tchanrt
>        - const: ringrt
> +      - const: cfg
> +      - const: tchan
> +      - const: rchan
> +      - const: rflow
>  
>    msi-parent: true
>  
> @@ -136,8 +142,14 @@ examples:
>                  reg = <0x0 0x485c0000 0x0 0x100>,
>                        <0x0 0x4a800000 0x0 0x20000>,
>                        <0x0 0x4aa00000 0x0 0x40000>,
> -                      <0x0 0x4b800000 0x0 0x400000>;
> -                reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
> +                      <0x0 0x4b800000 0x0 0x400000>,
> +                      <0x00 0x485e0000 0x00 0x20000>,

This is RING (PKTDMA_RING), why it is named cfg?

> +                      <0x00 0x484a0000 0x00 0x4000>,
> +                      <0x00 0x484c0000 0x00 0x2000>,
> +                      <0x00 0x48430000 0x00 0x4000>;
> +                reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
> +                            "cfg", "tchan", "rchan", "rflow";
> +
>                  msi-parent = <&inta_main_dmss>;
>                  #dma-cells = <2>;
>  

-- 
Péter
