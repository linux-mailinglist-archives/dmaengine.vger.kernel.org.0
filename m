Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBB3501896
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiDNQP1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353068AbiDNP5p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 11:57:45 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40E19BAC6;
        Thu, 14 Apr 2022 08:43:43 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id z8so5820076oix.3;
        Thu, 14 Apr 2022 08:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JwzywWnYsLK2qsKFyUyGxPHHhlixxv4Ryj+et5T0mBk=;
        b=7iUQWe8drjnupSnaAhhjkgbE4wtCdgF+XgHDssLzi8/mb2RjB9YMkUZ2ZgWIx4sNuD
         igfiM4MP8pr0KseYZM5DvautW2+YW89EksBlCqPqwMpsY52dBQVvhitvGKBohuELnUQm
         KVs4fRqXIBEoXqA/3URWnjo+UQj0ffTaiQIve9XHr8/yyfJCcN5+iQQX3K68ESPGuOsk
         UZjp+XG1iLZFstEONjcuj8wacY8cWkd+zHjfCQZY3lmL9g5fyKcuujjTrNChmDM6P3SJ
         jCQXVjgJaEPSGmEFk9pTWWWCrcny+R+bU0nGXGXUZd8LO8cxc1I7wyjnw2FEpBci6MJf
         mW+A==
X-Gm-Message-State: AOAM533l6kcXrRgw5y8BtV39f4kUThFI1Nja1YXfSQCnfMSi8hog+G4r
        26S8uPxN9/cGcRWGSvtf+A==
X-Google-Smtp-Source: ABdhPJwvStdbp/ksTUd/RSAUo/zNuKkOAxOU97uJ44mgjN+nke943fmBTvNBRu6nOAc8h3mM7nh8Pw==
X-Received: by 2002:a05:6808:b13:b0:2ec:a7d0:124b with SMTP id s19-20020a0568080b1300b002eca7d0124bmr1863244oij.85.1649951021543;
        Thu, 14 Apr 2022 08:43:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be21-20020a056808219500b002fa6227ba8dsm154517oib.34.2022.04.14.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:43:41 -0700 (PDT)
Received: (nullmailer pid 2110080 invoked by uid 1000);
        Thu, 14 Apr 2022 15:43:40 -0000
Date:   Thu, 14 Apr 2022 10:43:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: Add Apple ADMAC
Message-ID: <YlhBLJQVYvTGlx4o@robh.at.kernel.org>
References: <20220411222204.96860-1-povik+lin@cutebit.org>
 <20220411222204.96860-2-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411222204.96860-2-povik+lin@cutebit.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 12, 2022 at 12:22:03AM +0200, Martin Povišer wrote:
> Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio
> samples on SoCs from the "Apple Silicon" family.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
> 
> After the v1 discussion, I dropped the apple,internal-irq-destination
> property and instead the index of the usable interrupt is now signified
> by prepending -1 entries to the interrupts= list. This works when I do
> it like this:
> 
>   interrupt-parent = <&aic>;
>   interrupts = <AIC_IRQ 0xffffffff 0>,
>                <AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;


BTW, just use '-1'. dtc takes negative values (and other expressions).

> 
> I would find it neat to do it like this:
> 
>   interrupts-extended = <0xffffffff>,
>                         <&aic AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;
> 
> but unfortunately the kernel doesn't pick up on it:
> 
> [    0.767964] apple-admac 238200000.dma-controller: error -6: IRQ index 0 not found
> [    0.773943] apple-admac 238200000.dma-controller: error -6: IRQ index 1 not found
> [    0.780154] apple-admac 238200000.dma-controller: error -6: IRQ index 2 not found
> [    0.786367] apple-admac 238200000.dma-controller: error -6: IRQ index 3 not found
> [    0.788592] apple-admac 238200000.dma-controller: error -6: no usable interrupt

We should make this case work. It is less fragile IMO as it doesn't 
depend on the provider's translation of cells.

> 
>  .../devicetree/bindings/dma/apple,admac.yaml  | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml b/Documentation/devicetree/bindings/dma/apple,admac.yaml
> new file mode 100644
> index 000000000000..bbd5eaf5f709
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/apple,admac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Audio DMA Controller (ADMAC)
> +
> +description: |
> +  Apple's Audio DMA Controller (ADMAC) is used to fetch and store audio samples
> +  on SoCs from the "Apple Silicon" family.
> +
> +  The controller has been seen with up to 24 channels. Even-numbered channels
> +  are TX-only, odd-numbered are RX-only. Individual channels are coupled to
> +  fixed device endpoints.
> +
> +maintainers:
> +  - Martin Povišer <povik+lin@cutebit.org>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t6000-admac
> +          - apple,t8103-admac
> +      - const: apple,admac
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 1
> +    description:
> +      Clients specify single cell with channel number.
> +
> +  dma-channels:
> +    maximum: 24
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 4

I'm now confused why this is variable. Put -1 entries on the end if 
that's why it is variable.

This needs some description about there being 1 of 4 outputs being 
connected.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#dma-cells'
> +  - dma-channels
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    admac: dma-controller@238200000 {
> +      compatible = "apple,t8103-admac", "apple,admac";
> +      reg = <0x38200000 0x34000>;
> +      dma-channels = <24>;
> +      interrupt-parent = <&aic>;
> +      interrupts = <AIC_IRQ 0xffffffff 0>,
> +                   <AIC_IRQ 626 IRQ_TYPE_LEVEL_HIGH>;
> +      #dma-cells = <1>;
> +    };
> -- 
> 2.33.0
> 
> 
