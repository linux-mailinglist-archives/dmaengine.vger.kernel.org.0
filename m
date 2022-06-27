Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55855DFC8
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbiF0XWq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 19:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbiF0XWp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 19:22:45 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EDF2409C;
        Mon, 27 Jun 2022 16:22:44 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id p13so7097381ilq.0;
        Mon, 27 Jun 2022 16:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3lHtHF5zI7QaQustjx+BDaBkfu/L3JJ+u5pFItRPzJ4=;
        b=ZHQGDQOf6e0vfhfQaEpTdLdWnfcrGp+FNWavP5+dRxMsiw5WWZDGFQM5GNdmvnN+zv
         OwnVXnQU9enB7aaT3lVvSlOCk3X1pJi9m0wBO0aXUEoni2JrDwScb9dvd3pSEwyzgbZM
         b4UvxfOX/uGX4f0U60FPg047J8oJ3srfhLPn58lFGxqNcm42r1ReKiYv6srp3qyJHo/s
         sKgLDtSDxfsoOqjafnaHHX2tHQzStEJFN5mw5GFmHvWV6PlUVgDG9yPhglzVJ05d/7C8
         l4pt4dKCJ3CvQu6CLge5diylhn0DzxtC3RQZtTmxQefzf1CbTI7CZIIoC8MKAif9a0Om
         QI5w==
X-Gm-Message-State: AJIora9H32CbuhbataZY/gtcP0Ifo8ZTP7ox5ngt2AlyCwth/YZb6Mtw
        vhwrUI2riJfzS0xOxIDHHA==
X-Google-Smtp-Source: AGRyM1uuZgM8JkppOyMZE7iD5zoRFs4rpAokBWSho/964cJTForbd85QtIKVpY1IbCabypfEAIEcAA==
X-Received: by 2002:a05:6e02:154d:b0:2da:9539:3093 with SMTP id j13-20020a056e02154d00b002da95393093mr4871207ilu.131.1656372163678;
        Mon, 27 Jun 2022 16:22:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m3-20020a92d703000000b002d9344d4d6bsm5094310iln.79.2022.06.27.16.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:22:43 -0700 (PDT)
Received: (nullmailer pid 3158136 invoked by uid 1000);
        Mon, 27 Jun 2022 23:22:40 -0000
Date:   Mon, 27 Jun 2022 17:22:40 -0600
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
Subject: Re: [PATCH 03/14] ASoC: dt-bindings: convert designware-i2s to
 dt-schema
Message-ID: <20220627232240.GA3156149-robh@kernel.org>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-4-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618123035.563070-4-mail@conchuod.ie>
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

On Sat, Jun 18, 2022 at 01:30:25PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Convert the Synopsys DesignWare I2S controller binding to dt-schema.
> There was no listed maintainer but Jose Abreu was the last editor of the
> txt binding so add him as maintainer.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/sound/designware-i2s.txt         | 35 -------
>  .../bindings/sound/snps,designware-i2s.yaml   | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/designware-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
> deleted file mode 100644
> index 6a536d570e29..000000000000
> --- a/Documentation/devicetree/bindings/sound/designware-i2s.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -DesignWare I2S controller
> -
> -Required properties:
> - - compatible : Must be "snps,designware-i2s"
> - - reg : Must contain the I2S core's registers location and length
> - - clocks : Pairs of phandle and specifier referencing the controller's
> -   clocks. The controller expects one clock: the clock used as the sampling
> -   rate reference clock sample.
> - - clock-names : "i2sclk" for the sample rate reference clock.
> - - dmas: Pairs of phandle and specifier for the DMA channels that are used by
> -   the core. The core expects one or two dma channels: one for transmit and
> -   one for receive.
> - - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
> -
> -Optional properties:
> - - interrupts: The interrupt line number for the I2S controller. Add this
> -   parameter if the I2S controller that you are using does not support DMA.
> -
> -For more details on the 'dma', 'dma-names', 'clock' and 'clock-names'
> -properties please check:
> -	* resource-names.txt
> -	* clock/clock-bindings.txt
> -	* dma/dma.txt
> -
> -Example:
> -
> -	soc_i2s: i2s@7ff90000 {
> -		compatible = "snps,designware-i2s";
> -		reg = <0x0 0x7ff90000 0x0 0x1000>;
> -		clocks = <&scpi_i2sclk 0>;
> -		clock-names = "i2sclk";
> -		#sound-dai-cells = <0>;
> -		dmas = <&dma0 5>;
> -		dma-names = "tx";
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
> new file mode 100644
> index 000000000000..5ac9c00157bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/snps,designware-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DesignWare I2S controller
> +
> +maintainers:
> +  - Jose Abreu <joabreu@synopsys.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: canaan,k210-i2s
> +          - const: snps,designware-i2s
> +      - enum:
> +          - snps,designware-i2s
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      The interrupt line number for the I2S controller. Add this
> +      parameter if the I2S controller that you are using does not
> +      support DMA.
> +    maxItems: 1
> +
> +  clocks:
> +    description: Sampling rate reference clock

How many?

> +
> +  clock-names:
> +    const: i2sclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: TX DMA Channel
> +      - description: RX DMA Channel
> +    minItems: 1
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +    minItems: 1
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: canaan,k210-i2s
> +
> +then:
> +  properties:
> +    "#sound-dai-cells":
> +      const: 1
> +
> +else:
> +  properties:
> +    "#sound-dai-cells":
> +      const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +oneOf:
> +  - required:
> +      - dmas
> +      - dma-names
> +  - required:
> +      - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    soc_i2s: i2s@7ff90000 {
> +      compatible = "snps,designware-i2s";
> +      reg = <0x7ff90000 0x1000>;
> +      clocks = <&scpi_i2sclk 0>;
> +      clock-names = "i2sclk";
> +      #sound-dai-cells = <0>;
> +      dmas = <&dma0 5>;
> +      dma-names = "tx";
> +    };
> -- 
> 2.36.1
> 
> 
