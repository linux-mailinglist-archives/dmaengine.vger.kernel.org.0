Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBDA67878A
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jan 2023 21:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjAWUUc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Jan 2023 15:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAWUUa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Jan 2023 15:20:30 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AB9367D5;
        Mon, 23 Jan 2023 12:20:13 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id m18-20020a05683026d200b0068661404380so8031141otu.2;
        Mon, 23 Jan 2023 12:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJIseX7fbuePlCt3lfYMHgc5yPjn6sJZXZh9GvE7Yuk=;
        b=MEb/+JI39ce0AogF0PuxwubSLof1UjvG4bMroBo0nt6jOEb17wqgEwlBD5fjwkWcg2
         Ts+zA+YlPt0gkasuxBsyzfU7XchoOZEJXSaNUV56uCYcqUGJDcAnzG8QffrTVCz+KPVH
         tJXW618z6PANQHuUqlh8fJyKp20CXPJmaRAagOgNMGagS2HHmmS74UAv21VQxuQfnfu5
         cKTtZJtxjV+BKID5xSeOkkf6G1KrZdqFumSCdaINCRZ6fr4LXLuFErxSS0tauSvrSxh6
         6JYpBB3v/4HroGpKeZuGZRVri6AAsW4TBK6Er60+IwKF+fCjbSurOAtyIutIBtwtCWp8
         CUBQ==
X-Gm-Message-State: AFqh2kpxpAoTvdcWca5BIljKt/EXat4bOkVQ4iyZt4x4oNHtOT4s7V59
        cYTaMWkR3Dm2PMfVbFLRBQ==
X-Google-Smtp-Source: AMrXdXtXo7dsxEuvQDVOZCdjfJoyKEoO2vYkeou3j0fcHEiMdz4hYCE8ilnCls8sDDy5APHHbusT7w==
X-Received: by 2002:a9d:370:0:b0:66c:dd2b:e1ad with SMTP id 103-20020a9d0370000000b0066cdd2be1admr23494564otv.23.1674505212954;
        Mon, 23 Jan 2023 12:20:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x17-20020a9d6291000000b00677714a440fsm52560otk.81.2023.01.23.12.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:20:12 -0800 (PST)
Received: (nullmailer pid 2457598 invoked by uid 1000);
        Mon, 23 Jan 2023 20:20:10 -0000
Date:   Mon, 23 Jan 2023 14:20:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
Subject: Re: [PATCH 2/2] dt-bindings: dma: cleanup examples - indentation,
 lowercase hex
Message-ID: <20230123202010.GA2455859-robh@kernel.org>
References: <20230118180144.364756-1-krzysztof.kozlowski@linaro.org>
 <20230118180144.364756-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118180144.364756-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 18, 2023 at 07:01:44PM +0100, Krzysztof Kozlowski wrote:
> Cleanup examples:
>  - use 4-space indentation (for cases when it is neither 4 not 2 space),
>  - use lowercase hex.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 36 +++++++++----------
>  .../bindings/dma/stericsson,dma40.yaml        |  4 +--
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> index 2bedab1f74e0..d34d0fa62ab5 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -113,21 +113,21 @@ additionalProperties: false
>  
>  examples:
>    - |
> -     #include <dt-bindings/interrupt-controller/arm-gic.h>
> -     #include <dt-bindings/interrupt-controller/irq.h>
> -     /* example with snps,dw-axi-dmac */
> -     dmac: dma-controller@80000 {
> -         compatible = "snps,axi-dma-1.01a";
> -         reg = <0x80000 0x400>;
> -         clocks = <&core_clk>, <&cfgr_clk>;
> -         clock-names = "core-clk", "cfgr-clk";
> -         interrupt-parent = <&intc>;
> -         interrupts = <27>;
> -         #dma-cells = <1>;
> -         dma-channels = <4>;
> -         snps,dma-masters = <2>;
> -         snps,data-width = <3>;
> -         snps,block-size = <4096 4096 4096 4096>;
> -         snps,priority = <0 1 2 3>;
> -         snps,axi-max-burst-len = <16>;
> -     };
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    /* example with snps,dw-axi-dmac */
> +    dmac: dma-controller@80000 {

Drop unused labels while you are here.

> +        compatible = "snps,axi-dma-1.01a";
> +        reg = <0x80000 0x400>;
> +        clocks = <&core_clk>, <&cfgr_clk>;
> +        clock-names = "core-clk", "cfgr-clk";
> +        interrupt-parent = <&intc>;
> +        interrupts = <27>;
> +        #dma-cells = <1>;
> +        dma-channels = <4>;
> +        snps,dma-masters = <2>;
> +        snps,data-width = <3>;
> +        snps,block-size = <4096 4096 4096 4096>;
> +        snps,priority = <0 1 2 3>;
> +        snps,axi-max-burst-len = <16>;
> +    };
> diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> index 664ee61a00d8..57395a810719 100644
> --- a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> +++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> @@ -147,9 +147,9 @@ examples:
>      #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/mfd/dbx500-prcmu.h>
> -    dma-controller@801C0000 {
> +    dma-controller@801c0000 {
>        compatible = "stericsson,db8500-dma40", "stericsson,dma40";
> -      reg = <0x801C0000 0x1000>, <0x40010000 0x800>;
> +      reg = <0x801c0000 0x1000>, <0x40010000 0x800>;
>        reg-names = "base", "lcpa";
>        interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>        #dma-cells = <3>;

Indentation?
