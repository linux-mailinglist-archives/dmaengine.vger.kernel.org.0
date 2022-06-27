Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066CC55D107
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiF0VNV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 17:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiF0VNU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 17:13:20 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBBD167C7;
        Mon, 27 Jun 2022 14:13:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id by38so12468809ljb.10;
        Mon, 27 Jun 2022 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Apd1Cl8iWlr7VPj1iuOe666SC1Q2pQo9qEBUCr9vf6Q=;
        b=ilyEOtv07N3ArdjBB7bMKwAqjb/e0wlxydgdur1zOwDRqzH4IPqX2FlQxVaGAXw6Kc
         Gc0VmznO21rzcUs44XvprgCJ41kZL5S9X1gx6kQ+guwTI6uiSc4zItEWOnsDW3kNAVlF
         sfGw15jYmTuWW1FxW/Lb57dg0O1NF3p/fPa5o15TUnzZIQmB98u2AvQRL0iesgljp0tc
         xc9//5AKa4Iw3dQz5Ksx+KmaP7act61c7ia75qFkgn5dlsfLCparb572EaPCLMdTHnjX
         0Dp5EEprtNhtw/ZXAV6oYcWZi6HDJptcetDIzhKexpPO7ZBBmv8UMK0X2PqLjPdeMC7b
         JSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Apd1Cl8iWlr7VPj1iuOe666SC1Q2pQo9qEBUCr9vf6Q=;
        b=mejYong5MDR9uk8cJkLhT9piKk/avBZg1NnjCyyJLI1w8IqYqtuZXdmFKTGpFnUE9L
         6wpzwHvuQHobi2lKX5psMS5rd9sqwdikDtaVC4mzhRPMYGVpz/mBwH5xunDxZ7mJevXt
         31OXPmaOD+zfRIuYsupecxqirhsSe8TYDzWpqekcg3Ehr5Lab8uwtELugCNaph06LKRn
         XmNFQLDuG2xa3HjSTN5dwwPYFaVhMnpv3o/EGJ5hO/uGyaEoNZn2vB1GZfXWBvNx0hQC
         L0c2vea+rNYYBe93efkQ03+VhxG0LraqvfPMk2XP68GnXCSvSzpgX0D7WFW8aU+ikot2
         3MUQ==
X-Gm-Message-State: AJIora9cx/8Rx4rvJkmOdWvHW2YfW1998uzcAwHZCZpoIMfuX6CiOWoQ
        tLyU9mtRRpDfN6WLf3V4g6M=
X-Google-Smtp-Source: AGRyM1t9VxFwTJAlhP264dX7IvF0c94LGOWuU36vJO57G/WRfCPD7iXEUNRYkA0yEtu/rvZ1Rje57Q==
X-Received: by 2002:a2e:9191:0:b0:25a:8858:f60d with SMTP id f17-20020a2e9191000000b0025a8858f60dmr7495670ljg.423.1656364397334;
        Mon, 27 Jun 2022 14:13:17 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id z9-20020a2eb529000000b0025bc79181b4sm358400ljm.36.2022.06.27.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:13:16 -0700 (PDT)
Date:   Tue, 28 Jun 2022 00:13:14 +0300
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
Subject: Re: [PATCH v2 06/16] dt-bindings: timer: add Canaan k210 to Synopsys
 DesignWare timer
Message-ID: <20220627211314.dc2hempelyl5ayjg@mobilestation>
References: <20220627194003.2395484-1-mail@conchuod.ie>
 <20220627194003.2395484-7-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627194003.2395484-7-mail@conchuod.ie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 27, 2022 at 08:39:54PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The Canaan k210 apparently has a Sysnopsys Designware timer but
> according to the documentation & devicetree it has 2 interrupts rather
> than the standard one. Add a custom compatible that supports the 2
> interrupt configuration and falls back to the standard binding (which
> is currently the one in use in the devicetree entry).
> 

> Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 58

Firstly, it's page 51 in the framework of the document pages
enumeration.

Judging by the comment in the document above and what the HW reference
manual says regarding the IRQ signals, what you really have on K210 is
the DW APB Timer IP-cores each configured with two embedded timers.
It's done by the IP-core synthesize parameter NUM_TIMERS={1..8}, which
in your case equals to 2. A similar situation is on our SoC and, for
instance, here:

arch/arm/boot/dts/berlin2q.dtsi
arch/arm/boot/dts/berlin2.dtsi
arch/arm/boot/dts/berlin2cd.dtsi
(Though the Berlin2 APB Timer have been configured with 8 timers.)

So the correct modification would be:
1. Split up the nodes into two ones with one IRQ per each node.
2. Make sure I was right by testing the new dts out.
3. Update the DT-node only and leave the DT-bindings as is.

-Sergey

> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/timer/snps,dw-apb-timer.yaml     | 28 +++++++++++++++----
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
> index d33c9205a909..9a76acc7a66f 100644
> --- a/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
> +++ b/Documentation/devicetree/bindings/timer/snps,dw-apb-timer.yaml
> @@ -12,6 +12,9 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - const: canaan,k210-apb-timer
> +          - const: snps,dw-apb-timer
>        - const: snps,dw-apb-timer
>        - enum:
>            - snps,dw-apb-timer-sp
> @@ -21,9 +24,6 @@ properties:
>    reg:
>      maxItems: 1
>  
> -  interrupts:
> -    maxItems: 1
> -
>    resets:
>      maxItems: 1
>  
> @@ -41,7 +41,23 @@ properties:
>  
>    clock-frequency: true
>  
> -additionalProperties: false
> +unevaluatedProperties: false
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: canaan,k210-apb-timer
> +
> +then:
> +  properties:
> +    interrupts:
> +      maxItems: 2
> +
> +else:
> +  properties:
> +    interrupts:
> +      maxItems: 1
>  
>  required:
>    - compatible
> @@ -60,8 +76,8 @@ oneOf:
>  examples:
>    - |
>      timer@ffe00000 {
> -      compatible = "snps,dw-apb-timer";
> -      interrupts = <0 170 4>;
> +      compatible = "canaan,k210-apb-timer", "snps,dw-apb-timer";
> +      interrupts = <0 170 4>, <0 170 4>;
>        reg = <0xffe00000 0x1000>;
>        clocks = <&timer_clk>, <&timer_pclk>;
>        clock-names = "timer", "pclk";
> -- 
> 2.36.1
> 
