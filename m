Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BB6ED242
	for <lists+dmaengine@lfdr.de>; Mon, 24 Apr 2023 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjDXQQD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Apr 2023 12:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjDXQQC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Apr 2023 12:16:02 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7CB109;
        Mon, 24 Apr 2023 09:16:00 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-187993bab0cso3750151fac.3;
        Mon, 24 Apr 2023 09:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352960; x=1684944960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+2Yk4a01Bn2f05FQpsQZmSCjCKmzUH6QNR1QudU5n0=;
        b=kbzasH5OfuHfiz3E8m/+ojrmsVY6WThdydUoFiIRIUv4T0dU//+pmKnvbLLddmwepb
         fq9f8WnzTK9qhCP0Y0P67mLqGqcufR+8uiVXl6yXCWvND5k0YGSwoLWSOHjPOuroCGEd
         tP3wgItkzqTQY8HFeTNzqebiNrrbeEdZWTgr4Qa0oYcC49WpyPT60KolyZiOVBudEPbZ
         5Lj/p/DT3VfY+296/b7TMqv+EPX9/8meCxiGaaCpodE9w0XK/8AuIxQgMJ6+gtWZbVdZ
         jWHi8jZ2V0pu62uE1s8azyR+pLsnC/ppZephbZv4ykJBmFgbTo+oQP84y7KD0MosmOK9
         F4jA==
X-Gm-Message-State: AAQBX9cp2RUIBqje4s4HzeUKYuZ7KMw2aD/YTVSxqspUg/CsyPDo1v+m
        ErKocyQOwYha2Ht3ljP0TdXalT4+cg==
X-Google-Smtp-Source: AKy350a+wqxg5qrQwDGuF3oGvbsISbtR0qe7SKMhdM5kmlCe/GGlf/5NYYj7HWLgWkstZztFFFyo4A==
X-Received: by 2002:a05:6870:c1d4:b0:187:836f:d36a with SMTP id i20-20020a056870c1d400b00187836fd36amr10130124oad.0.1682352959966;
        Mon, 24 Apr 2023 09:15:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h22-20020a9d61d6000000b006a6168665f6sm4855964otk.43.2023.04.24.09.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:15:59 -0700 (PDT)
Received: (nullmailer pid 2766626 invoked by uid 1000);
        Mon, 24 Apr 2023 16:15:58 -0000
Date:   Mon, 24 Apr 2023 11:15:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/43] dt-bindings: dma: Add DT bindings ep93xx dma
Message-ID: <20230424161558.GF2701399-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-21-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-21-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Apr 24, 2023 at 03:34:36PM +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/dma/cirrus,ep93xx-dma-m2m.yaml   |  66 ++++++++++++
>  .../bindings/dma/cirrus,ep93xx-dma-m2p.yaml   | 102 ++++++++++++++++++
>  2 files changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2m.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2p.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2m.yaml b/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2m.yaml
> new file mode 100644
> index 000000000000..9a53ee9052a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2m.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/cirrus,ep93xx-dma-m2m.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logick ep93xx SoC DMA controller Device Tree Bindings
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>

Again, wrong person.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: cirrus,ep9301-dma-m2m

'items' can be dropped.

> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2

Need to define what each entry is.

> +
> +  clocks:
> +    items:
> +      - description: m2m0 channel gate clock
> +      - description: m2m1 channel gate clock
> +
> +  clock-names:
> +    items:
> +      - const: m2m0
> +      - const: m2m1
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 2

Need to define what each entry is.

> +
> +  dma-channels:
> +    minimum: 2
> +    maximum: 2

If the only possible number of channels is 2, why is this property 
needed?

> +
> +  '#dma-cells': false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +    dma1: dma-controller@80000100 {
> +        compatible = "cirrus,ep9301-dma-m2m";
> +        reg = <0x80000100 0x0040>,
> +                <0x80000140 0x0040>;
> +        clocks = <&syscon EP93XX_CLK_M2M0>,
> +                <&syscon EP93XX_CLK_M2M1>;
> +        clock-names = "m2m0", "m2m1";
> +        dma-channels = <2>;
> +        interrupt-parent = <&vic0>;
> +        interrupts = <17>, <18>;
> +    };
> +
> +...
> +
> diff --git a/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2p.yaml b/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2p.yaml
> new file mode 100644
> index 000000000000..51fd72b4e843
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/cirrus,ep93xx-dma-m2p.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/cirrus,ep93xx-dma-m2p.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logick ep93xx SoC M2P DMA controller Device Tree Bindings
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: cirrus,ep9301-dma-m2p
> +
> +  reg:
> +    minItems: 10
> +    maxItems: 10

Define each entry. Looks like it's just N entries for N channels. Just a 
description with that is enough.

> +
> +  clocks:
> +    items:
> +      - description: m2p0 channel gate clock
> +      - description: m2p1 channel gate clock
> +      - description: m2p2 channel gate clock
> +      - description: m2p3 channel gate clock
> +      - description: m2p4 channel gate clock
> +      - description: m2p5 channel gate clock
> +      - description: m2p6 channel gate clock
> +      - description: m2p7 channel gate clock
> +      - description: m2p8 channel gate clock
> +      - description: m2p9 channel gate clock
> +
> +  clock-names:
> +    items:
> +      - const: m2p0
> +      - const: m2p1
> +      - const: m2p2
> +      - const: m2p3
> +      - const: m2p4
> +      - const: m2p5
> +      - const: m2p6
> +      - const: m2p7
> +      - const: m2p8
> +      - const: m2p9
> +
> +  interrupts:
> +    minItems: 10
> +    maxItems: 10
> +
> +  dma-channels:
> +    minimum: 10
> +    maximum: 10
> +
> +  '#dma-cells': false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/cirrus,ep93xx-clock.h>
> +    dma0: dma-controller@80000000 {
> +        compatible = "cirrus,ep9301-dma-m2p";
> +        reg =   <0x80000000 0x0040>,
> +                <0x80000040 0x0040>,
> +                <0x80000080 0x0040>,
> +                <0x800000c0 0x0040>,
> +                <0x80000240 0x0040>,
> +                <0x80000200 0x0040>,
> +                <0x800002c0 0x0040>,
> +                <0x80000280 0x0040>,
> +                <0x80000340 0x0040>,
> +                <0x80000300 0x0040>;
> +        clocks = <&syscon EP93XX_CLK_M2P0>,
> +                <&syscon EP93XX_CLK_M2P1>,
> +                <&syscon EP93XX_CLK_M2P2>,
> +                <&syscon EP93XX_CLK_M2P3>,
> +                <&syscon EP93XX_CLK_M2P4>,
> +                <&syscon EP93XX_CLK_M2P5>,
> +                <&syscon EP93XX_CLK_M2P6>,
> +                <&syscon EP93XX_CLK_M2P7>,
> +                <&syscon EP93XX_CLK_M2P8>,
> +                <&syscon EP93XX_CLK_M2P9>;
> +        clock-names = "m2p0", "m2p1",
> +                "m2p2", "m2p3",
> +                "m2p4", "m2p5",
> +                "m2p6", "m2p7",
> +                "m2p8", "m2p9";
> +        dma-channels = <10>;
> +        interrupt-parent = <&vic0>;
> +        interrupts = <7>, <8>, <9>, <10>, <11>, <12>, <13>, <14>, <15>, <16>;
> +    };
> +
> +...
> +
> -- 
> 2.39.2
> 
