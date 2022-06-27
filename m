Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F3F55DC0E
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbiF0Xad (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 19:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiF0Xab (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 19:30:31 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AA2D54;
        Mon, 27 Jun 2022 16:30:29 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id a16so7075052ilr.6;
        Mon, 27 Jun 2022 16:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x8JlGuBlsyv8u11qNoGLGDrkEldcGlScrLvA1xIrWcM=;
        b=qt7+fpuKX5G1NeZmhbolrtM+hLR1hBtYZx41xJ30DhLXJVGVCgP/mkh773Xn45uoxu
         4Hs2VYCJDD15KPNDEREPC4+re3a549fS5VN2XhrOIjNSXELZFxyPgAdlDTZqiF7xkER0
         yMgySKEHN8EM638I8C/By6Q1G82ZWTJDmyHwF/ATvg/asjSi1oU3+rpjDpYCzzDYmpTh
         qLRCwd2sUw4ooWrL9ZOMege66/Xn3IRN0EMx3KNLGGLz4zhfqnbbZHriZJbdL8obnYk9
         rPPO14aUiZ4vOU9nidlLwxJ+vhZuOmk7pVuvAkPVE52XcxLUn1E/N6lwnjL1WKrpg+A5
         WxaQ==
X-Gm-Message-State: AJIora/KXRTB4Qq1diY0yDAYtZbXUyXK755ZUOr6XMfnJQqMdPeJ0g08
        1U5hIFrYVCTdxBpEw58XWw==
X-Google-Smtp-Source: AGRyM1v++vx5C2PZ1+V37WXzVu58JZoOtbgG4MxkB9S8u2iPl6cebvqf5cCXt4rpl+8ThnjePE2X0Q==
X-Received: by 2002:a05:6e02:1d19:b0:2d9:1705:892b with SMTP id i25-20020a056e021d1900b002d91705892bmr8430986ila.61.1656372628833;
        Mon, 27 Jun 2022 16:30:28 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d9290000000b00672f405e911sm5910587iom.38.2022.06.27.16.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:30:28 -0700 (PDT)
Received: (nullmailer pid 3169022 invoked by uid 1000);
        Mon, 27 Jun 2022 23:30:25 -0000
Date:   Mon, 27 Jun 2022 17:30:25 -0600
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
Subject: Re: [PATCH 05/14] dt-bindings: timer: add Canaan k210 to Synopsys
 DesignWare timer
Message-ID: <20220627233025.GA3167724-robh@kernel.org>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-6-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618123035.563070-6-mail@conchuod.ie>
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

On Sat, Jun 18, 2022 at 01:30:27PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The Canaan k210 apparently has a Sysnopsys Designware timer but
> according to the documentation & devicetree it has 2 interrupts rather
> than the standard one. Add a custom compatible that supports the 2
> interrupt configuration and falls back to the standard binding (which
> is currently the one in use in the devicetree entry).
> 
> Link: https://canaan-creative.com/wp-content/uploads/2020/03/kendryte_standalone_programming_guide_20190311144158_en.pdf #Page 58
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

When more than 1, you need to define what they are and the order.

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
> 
