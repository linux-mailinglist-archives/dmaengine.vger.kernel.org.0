Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E555C835
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiF0Ve6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiF0Ve5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 17:34:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F7336;
        Mon, 27 Jun 2022 14:34:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b23so12535242ljh.7;
        Mon, 27 Jun 2022 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r50n64wyDXc98klCxenqB007ebeUTjgGTq3cHnewLs4=;
        b=eTl8RIM33/VhG6tyN0u1F7fh7bD9vwV9Nzl/DTA5Ny2T+C6Zz9CjWOXxw7tIRCfdSF
         JYJ+vK6VW6ow6XLR5ZnJoODpvohnt2Z+3t+vZDZHvM57s96TKZNFnlBSRDHDoYRnNnyQ
         N0k44RLYsM83fxNhFomNU3IiMDIB4LHzbT4UomKmLLPc0fcxeMBuZkZoILf+4d9CFzu5
         UGEjxpB5ZDTuXmtB4swbT0dDHmqosyfnMddfaHNphkAj8y6jxGlSDFIcL0nXRbbh3k9b
         NayiDEFJxxACHU3nhoe6LL8qnnNmGMIoh2ujOpxj9PuVm+6S9FPq9eujRABge7XAKiJx
         lZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r50n64wyDXc98klCxenqB007ebeUTjgGTq3cHnewLs4=;
        b=IU0snQ5YY2kXt4pHW7rFqfovGK9wGTngUud7fRrjSna+RyM/Gdqb7cycuLGWHAR8xL
         aIyh+jB+mk5C7mf0HBWnt1R8p80X1ICyuQYbjF+ExT5zwFe784NqgpT65lO9kLQE96d9
         DKc3GMi6yVWE8R/fJGpQSZA2MijOT9KrYO6XxxVXX/UYUZtCRecO95OY2qRIP0VCv+8X
         ro5rv5+uBEOCnU4TJpciR3JzdweJemjSOmM9tuod+G79flpewNbtoPY1aJN8kg8OPUuy
         RhdYbuhjXPtXqpXz3h45PH/90pOqrMm7FcnIwPxSWwsVhHJW7X5N9qwwpDSUJzWCBWhm
         JqpQ==
X-Gm-Message-State: AJIora9/qIeuzYtahJD2olyalzvHCwQs0guxLGtuvmOWWmsiBFdpx97x
        Pus2pltCaegtBdy8PcsPDuA=
X-Google-Smtp-Source: AGRyM1s2Xww9mZJQuItbTSCpLvPnTOre5lxdTZAquDOY9Sz5QQprbSClbPdC4vgd++PPS48AGvyOcw==
X-Received: by 2002:a2e:702:0:b0:253:bc1a:8a8c with SMTP id 2-20020a2e0702000000b00253bc1a8a8cmr7961986ljh.128.1656365693778;
        Mon, 27 Jun 2022 14:34:53 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id y1-20020ac24461000000b0047fb3ea0659sm1929044lfl.292.2022.06.27.14.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:34:53 -0700 (PDT)
Date:   Tue, 28 Jun 2022 00:34:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
Subject: Re: [PATCH v2 05/16] dt-bindings: dma: add Canaan k210 to Synopsys
 DesignWare DMA
Message-ID: <20220627213450.ukqai4bsjzcwhnlp@mobilestation>
References: <20220627194003.2395484-1-mail@conchuod.ie>
 <20220627194003.2395484-6-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627194003.2395484-6-mail@conchuod.ie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 27, 2022 at 08:39:53PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The Canaan k210 apparently has a Sysnopsys Designware AXI DMA
> controller, but according to the documentation & devicetree it has 6
> interrupts rather than the standard one. Add a custom compatible that
> supports the 6 interrupt configuration which falls back to the standard
> binding which is currently the one in use in the devicetree entry.
> 
> Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 58

I believe what you've got here is the per-channel IRQs, which is
activated for the DW AXI DMAC by setting IP-core synthesize parameter
DMAX_INTR_IO_TYPE=1 (CHANNEL AND COMMONREG). That's why there are six
IRQ signals and six DMA-channels available.

Seeing such setting isn't the Canaan k210 specific, but is the DW AXI
DMA controller common property, what would be right in this case is to
unconditionally extend the number of IRQs in the DT-bindings schema.

Please note the DW AXI DMAC driver currently doesn't support the
per-channel IRQs. So most likely the DMA will only work with using the
channel 0 only.

-Sergey

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
>           #dma-cells = <1>;
>           dma-channels = <4>;
>           snps,dma-masters = <2>;
> -- 
> 2.36.1
> 
