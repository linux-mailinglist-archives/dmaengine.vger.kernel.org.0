Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5E455CE07
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiF0X3Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 19:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbiF0X3X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 19:29:23 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F02E0;
        Mon, 27 Jun 2022 16:29:22 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id m13so11310849ioj.0;
        Mon, 27 Jun 2022 16:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9G9xzfoHgo3vygEsJjR4zL+mofIOaG7ELAHu9EXTEgk=;
        b=yqYAwuyoJKZSa312XTnivAQHPii87hASp8fSD23h96MXfF55DyKtOsOkdE+7H/myeI
         WtDpvLz5iY2z7QGMVcjEHNy5oOHMuPOqkbEIC+NjuBaM5NZxzbSHq8VqLwTH7x+L7tNZ
         pB/13F7ZCiObiF/QeifRoIg/rXXNPU1sL18ryRuJBj9hL/KTFaWaSQkrCRoGu7C5JCtv
         6riterv80nscCBEpC9BFTm+VcufYH7NvuL2zcKWWx9E3zT6psggXMmLzC0PK3NjjJQS4
         idEH6FV9f4m2WncrC0S2JxSjp9TDiA97TPHLvjVvqRhdqDvHl8WtnoJC4nZnQ0vM3BdQ
         dbrQ==
X-Gm-Message-State: AJIora9KzyTtlhlVWC7564NccuB9opvmX6D9HgiW6J+2AAckfHySJG18
        hNxLDKXjD2jKuM2w+jD8JQ==
X-Google-Smtp-Source: AGRyM1sVaI1eYRG04ScJ+CraadBpgnU6qQ4m5lVSPiS05KYADu+ifYinUFBXyTBFNfTqo7J/F/cw+w==
X-Received: by 2002:a05:6602:729:b0:675:243e:a859 with SMTP id g9-20020a056602072900b00675243ea859mr6337527iox.58.1656372562103;
        Mon, 27 Jun 2022 16:29:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i39-20020a023b67000000b00339e90e57e6sm5279502jaf.104.2022.06.27.16.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:29:21 -0700 (PDT)
Received: (nullmailer pid 3167512 invoked by uid 1000);
        Mon, 27 Jun 2022 23:29:19 -0000
Date:   Mon, 27 Jun 2022 17:29:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 04/14] dt-bindings: dma: add Canaan k210 to Synopsys
 DesignWare DMA
Message-ID: <20220627232919.GA3158390-robh@kernel.org>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-5-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618123035.563070-5-mail@conchuod.ie>
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

On Sat, Jun 18, 2022 at 01:30:26PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The Canaan k210 apparently has a Sysnopsys Designware AXI DMA
> controller, but according to the documentation & devicetree it has 6
> interrupts rather than the standard one. Add a custom compatible that
> supports the 6 interrupt configuration which falls back to the standard
> binding which is currently the one in use in the devicetree entry.

But it works with only 1 interrupt?

> 
> Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 58
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 35 ++++++++++++++-----
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 4324a94b26b2..bc85598151ef 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -18,9 +18,13 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - snps,axi-dma-1.01a
> -      - intel,kmb-axi-dma
> +    oneOf:
> +      - items:
> +          - const: canaan,k210-axi-dma
> +          - const: snps,axi-dma-1.01a

I would drop this depending on your need for compatibility. Are you sure 
on the IP version? It's not really compatible if the number of 
interrupts is different.

> +      - enum:
> +          - snps,axi-dma-1.01a
> +          - intel,kmb-axi-dma
>  
>    reg:
>      minItems: 1
> @@ -33,9 +37,6 @@ properties:
>        - const: axidma_ctrl_regs
>        - const: axidma_apb_regs
>  
> -  interrupts:
> -    maxItems: 1
> -
>    clocks:
>      items:
>        - description: Bus Clock
> @@ -92,6 +93,22 @@ properties:
>      minimum: 1
>      maximum: 256
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: canaan,k210-axi-dma
> +
> +then:
> +  properties:
> +    interrupts:
> +      maxItems: 6
> +
> +else:
> +  properties:
> +    interrupts:
> +      maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -105,7 +122,7 @@ required:
>    - snps,priority
>    - snps,block-size
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> @@ -113,12 +130,12 @@ examples:
>       #include <dt-bindings/interrupt-controller/irq.h>
>       /* example with snps,dw-axi-dmac */
>       dmac: dma-controller@80000 {
> -         compatible = "snps,axi-dma-1.01a";
> +         compatible = "canaan,k210-axi-dma", "snps,axi-dma-1.01a";
>           reg = <0x80000 0x400>;
>           clocks = <&core_clk>, <&cfgr_clk>;
>           clock-names = "core-clk", "cfgr-clk";
>           interrupt-parent = <&intc>;
> -         interrupts = <27>;
> +         interrupts = <27>, <28>, <29>, <30>, <31>, <32>;

Does the example really need changing? The old one was correct, right?

>           #dma-cells = <1>;
>           dma-channels = <4>;
>           snps,dma-masters = <2>;
> -- 
> 2.36.1
> 
> 
