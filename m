Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FC067877F
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jan 2023 21:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjAWUTb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Jan 2023 15:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjAWUTV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Jan 2023 15:19:21 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3887367F7;
        Mon, 23 Jan 2023 12:18:52 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id n8so11479352oih.0;
        Mon, 23 Jan 2023 12:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9TsVviuOODJWqPa0qVN9YfAyBsPjmf84LKhNhzNHe4=;
        b=ikg+WXLpXUW9owNV6qT++Lvoumtehu90i7SOkg1TPkJ+zxUmd1FSdZc3bnJ/7+OIp6
         QDSqUlHbOE4u+D8eBE6PMsi0FvMPtkhotjRW6+/bohnz+qy66CAG29ssxZ/yMDMSoiaL
         2q54ujx3m0XS6A3E+5MQw8OkvNbEw3v0gtIm81T8hoY8dYrQjjFTUgViqOBPdYuTZQOz
         jSBJmR+Vrsqw70qg+H1S50Yritt37vHXi586Q6CTMhL4GUGZ3yOc+GcT0iI1HXBHjQ69
         mQ5Olz2VeR82RTvlftXy/KV2lee2R9iR5jbTK9v/9Hcdv40J69ud0mcBNHcDhsHZVPIY
         RjzQ==
X-Gm-Message-State: AFqh2kpDUSiND4ZSMwbn5dYVD3HWG4NrDCZ1XWmyG12PVqLZ0anB1Iwi
        NzfLrYkk2mwZzlPy1xFTwA==
X-Google-Smtp-Source: AMrXdXt5T2+J150uc85qX/a/e7OoRAT8w8CmhGAUYbfvTzt6sNah2y7/iS9iRApYVIYYdn6OfeHWPg==
X-Received: by 2002:a05:6808:280b:b0:36e:c24b:85f5 with SMTP id et11-20020a056808280b00b0036ec24b85f5mr5096100oib.22.1674505131237;
        Mon, 23 Jan 2023 12:18:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g16-20020a9d6490000000b00684e09b43bdsm105528otl.13.2023.01.23.12.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:18:50 -0800 (PST)
Received: (nullmailer pid 2455776 invoked by uid 1000);
        Mon, 23 Jan 2023 20:18:48 -0000
Date:   Mon, 23 Jan 2023 14:18:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?77+9ZXI=?= <povik+lin@cutebit.org>,
        linux-mediatek@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-sunxi@lists.linux.dev,
        Bjorn Andersson <andersson@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Long Cheng <long.cheng@mediatek.com>,
        Green Wan <green.wan@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-tegra@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Palmer Debbelt <palmer@sifive.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Peng Fan <peng.fan@nxp.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        devicetree@vger.kernel.org,
        Olivier Dautricourt <olivierdautricourt@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        - <chuanhua.lei@intel.com>, Rajesh Gumasta <rgumasta@nvidia.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-actions@lists.infradead.org,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Stefan Roese <sr@denx.de>, linux-riscv@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        asahi@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-msm@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: dma: drop unneeded quotes
Message-ID: <167450512824.2455711.11173604781836638882.robh@kernel.org>
References: <20230118180144.364756-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118180144.364756-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 18 Jan 2023 19:01:43 +0100, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml        | 2 +-
>  .../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml       | 2 +-
>  .../devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml        | 2 +-
>  Documentation/devicetree/bindings/dma/altr,msgdma.yaml          | 2 +-
>  Documentation/devicetree/bindings/dma/apple,admac.yaml          | 2 +-
>  Documentation/devicetree/bindings/dma/arm-pl08x.yaml            | 2 +-
>  Documentation/devicetree/bindings/dma/dma-controller.yaml       | 2 +-
>  Documentation/devicetree/bindings/dma/dma-router.yaml           | 2 +-
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml             | 2 +-
>  Documentation/devicetree/bindings/dma/ingenic,dma.yaml          | 2 +-
>  Documentation/devicetree/bindings/dma/intel,ldma.yaml           | 2 +-
>  Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml    | 2 +-
>  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml        | 2 +-
>  Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml | 2 +-
>  Documentation/devicetree/bindings/dma/owl-dma.yaml              | 2 +-
>  Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml         | 2 +-
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml             | 2 +-
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml    | 2 +-
>  Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml      | 2 +-
>  Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml  | 2 +-
>  Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml     | 2 +-
>  .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml         | 2 +-
>  Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml   | 2 +-
>  Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml     | 2 +-
>  .../devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml    | 2 +-
>  .../devicetree/bindings/dma/socionext,uniphier-xdmac.yaml       | 2 +-
>  Documentation/devicetree/bindings/dma/st,stm32-dma.yaml         | 2 +-
>  Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml      | 2 +-
>  Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml        | 2 +-
>  Documentation/devicetree/bindings/dma/stericsson,dma40.yaml     | 2 +-
>  30 files changed, 30 insertions(+), 30 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
