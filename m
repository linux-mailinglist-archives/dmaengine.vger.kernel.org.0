Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498B5679446
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jan 2023 10:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjAXJdF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Jan 2023 04:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjAXJdE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Jan 2023 04:33:04 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70B610DC;
        Tue, 24 Jan 2023 01:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1674552777; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oba3BeWPgFJyMEvrnjFlCbBYFFmIWrkGDj08PiIGVwY=;
        b=16ayxAYqXVXoB0h+8PAArjiMZwPFD/yahWfUd9Gmzfcwh4bEqvWEayKQECPlPbqNQhG64x
        qwWvJAWA0SK9tWWYktu8NmlKndRD0FcXR0AOqLrVGZY4RD7qs7C4vKl7CLAzWdf4enIfVs
        td+HAo5uvDoYLvgQyOUQc2j3L9uiErY=
Message-ID: <cdd02d07be433524f6e3d8256eedb90c2a113ca5.camel@crapouillou.net>
Subject: Re: [PATCH v2 1/2] dt-bindings: dma: drop unneeded quotes
From:   Paul Cercueil <paul@crapouillou.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
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
        ?er <povik+lin@cutebit.org>, Peng Fan <peng.fan@nxp.com>,
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
Cc:     Rob Herring <robh@kernel.org>
Date:   Tue, 24 Jan 2023 09:32:50 +0000
In-Reply-To: <20230124081117.31186-1-krzysztof.kozlowski@linaro.org>
References: <20230124081117.31186-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Krzysztof,

Le mardi 24 janvier 2023 =C3=A0 09:11 +0100, Krzysztof Kozlowski a =C3=A9cr=
it=C2=A0:
> Cleanup by removing unneeded quotes from refs and redundant blank
> lines.
> No functional impact except adjusting to preferred coding style.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com> # mediatek
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Hector Martin <marcan@marcan.st> # apple

For ingenic:
Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0.../devicetree/bindings/dma/allwinner,sun4i-a10-dma.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0.../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0.../devicetree/bindings/dma/allwinner,sun6i-a31-dma.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/altr,msgdma.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/apple,admac.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/arm-pl08x.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/dma-controller.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/dma-router.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/fsl,edma.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/ingenic,dma.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/intel,ldma.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml=C2=A0=
=C2=A0=C2=A0 | 2
> +-
> =C2=A0.../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/owl-dma.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/qcom,gpi.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml=C2=A0=
=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml=C2=
=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml=C2=A0=
=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0.../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml=C2=A0=
=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml=C2=A0=
=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0.../devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml=C2=A0=
=C2=A0=C2=A0 | 2
> +-
> =C2=A0.../devicetree/bindings/dma/socionext,uniphier-xdmac.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/st,stm32-dma.yaml=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A0Documentation/devicetree/bindings/dma/stericsson,dma40.yaml=C2=A0=
=C2=A0=C2=A0=C2=A0 | 2
> +-
> =C2=A030 files changed, 30 insertions(+), 30 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun4i-
> a10-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun4i-
> a10-dma.yaml
> index 26d0d8ab7984..02d5bd035409 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-
> dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun4i-a10-
> dma.yaml
> @@ -11,7 +11,7 @@ maintainers:
> =C2=A0=C2=A0 - Maxime Ripard <mripard@kernel.org>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 "#dma-cells":
> diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun50i-
> a64-dma.yaml
> b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> index bd599bda2653..ec2d7a789ffe 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-
> dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-
> dma.yaml
> @@ -11,7 +11,7 @@ maintainers:
> =C2=A0=C2=A0 - Maxime Ripard <mripard@kernel.org>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 "#dma-cells":
> diff --git a/Documentation/devicetree/bindings/dma/allwinner,sun6i-
> a31-dma.yaml b/Documentation/devicetree/bindings/dma/allwinner,sun6i-
> a31-dma.yaml
> index 344dc7e04931..5d554bcfab3d 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-
> dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun6i-a31-
> dma.yaml
> @@ -11,7 +11,7 @@ maintainers:
> =C2=A0=C2=A0 - Maxime Ripard <mripard@kernel.org>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 "#dma-cells":
> diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> index b53ac7631a76..391bf5838602 100644
> --- a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> @@ -14,7 +14,7 @@ description: |
> =C2=A0=C2=A0 intellectual property (IP)
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/apple,admac.yaml
> b/Documentation/devicetree/bindings/dma/apple,admac.yaml
> index 97282469e4af..05163d124ec3 100644
> --- a/Documentation/devicetree/bindings/dma/apple,admac.yaml
> +++ b/Documentation/devicetree/bindings/dma/apple,admac.yaml
> @@ -18,7 +18,7 @@ maintainers:
> =C2=A0=C2=A0 - Martin Povi=C5=A1er <povik+lin@cutebit.org>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> index 9193b18fb75f..ab25ae63d2c3 100644
> --- a/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> +++ b/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> @@ -11,7 +11,7 @@ maintainers:
> =C2=A0
> =C2=A0allOf:
> =C2=A0=C2=A0 - $ref: /schemas/arm/primecell.yaml#
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0# We need a select here so we don't match all nodes with
> 'arm,primecell'
> =C2=A0select:
> diff --git a/Documentation/devicetree/bindings/dma/dma-
> controller.yaml b/Documentation/devicetree/bindings/dma/dma-
> controller.yaml
> index 538ebadff652..04d150d4d15d 100644
> --- a/Documentation/devicetree/bindings/dma/dma-controller.yaml
> +++ b/Documentation/devicetree/bindings/dma/dma-controller.yaml
> @@ -10,7 +10,7 @@ maintainers:
> =C2=A0=C2=A0 - Vinod Koul <vkoul@kernel.org>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-common.yaml#"
> +=C2=A0 - $ref: dma-common.yaml#
> =C2=A0
> =C2=A0# Everything else is described in the common file
> =C2=A0properties:
> diff --git a/Documentation/devicetree/bindings/dma/dma-router.yaml
> b/Documentation/devicetree/bindings/dma/dma-router.yaml
> index f8d8c3c88bcc..346fe0fa4460 100644
> --- a/Documentation/devicetree/bindings/dma/dma-router.yaml
> +++ b/Documentation/devicetree/bindings/dma/dma-router.yaml
> @@ -10,7 +10,7 @@ maintainers:
> =C2=A0=C2=A0 - Vinod Koul <vkoul@kernel.org>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-common.yaml#"
> +=C2=A0 - $ref: dma-common.yaml#
> =C2=A0
> =C2=A0description:
> =C2=A0=C2=A0 DMA routers are transparent IP blocks used to route DMA requ=
est
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index 050e6cd57727..5fd8fc604261 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -64,7 +64,7 @@ required:
> =C2=A0=C2=A0 - dma-channels
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0=C2=A0 - if:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> index fd5b0a8eaed8..37400496e086 100644
> --- a/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/ingenic,dma.yaml
> @@ -10,7 +10,7 @@ maintainers:
> =C2=A0=C2=A0 - Paul Cercueil <paul@crapouillou.net>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> index a5c4be783593..d6bb553a2c6f 100644
> --- a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> +++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
> @@ -11,7 +11,7 @@ maintainers:
> =C2=A0=C2=A0 - mallikarjunax.reddy@intel.com
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/mediatek,uart-
> dma.yaml b/Documentation/devicetree/bindings/dma/mediatek,uart-
> dma.yaml
> index 9ab4d81ead35..dab468a88942 100644
> --- a/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/mediatek,uart-dma.yaml
> @@ -14,7 +14,7 @@ description: |
> =C2=A0=C2=A0 for the UART peripheral bus.
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-
> gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-
> gpc-dma.yaml
> index 851bd50ee67f..a790e5687844 100644
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-
> dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-
> dma.yaml
> @@ -16,7 +16,7 @@ maintainers:
> =C2=A0=C2=A0 - Rajesh Gumasta <rgumasta@nvidia.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra210-
> adma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra210-
> adma.yaml
> index fef804565b88..4003dbe94940 100644
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra210-adma.yaml
> @@ -14,7 +14,7 @@ maintainers:
> =C2=A0=C2=A0 - Jon Hunter <jonathanh@nvidia.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/owl-dma.yaml
> b/Documentation/devicetree/bindings/dma/owl-dma.yaml
> index 93b4847554fb..ec8b3dc37ca4 100644
> --- a/Documentation/devicetree/bindings/dma/owl-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/owl-dma.yaml
> @@ -15,7 +15,7 @@ maintainers:
> =C2=A0=C2=A0 - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> index 003098caf709..f1ddcf672261 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -11,7 +11,7 @@ maintainers:
> =C2=A0=C2=A0 - Bjorn Andersson <andersson@kernel.org>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index 1dec506cd4f7..fc5de7b6f19e 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -14,7 +14,7 @@ description: |
> =C2=A0=C2=A0 peripheral buses such as I2C, UART, and SPI.
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-
> dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rcar-
> dmac.yaml
> index 89b591a05bce..03aa067b1229 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml
> @@ -10,7 +10,7 @@ maintainers:
> =C2=A0=C2=A0 - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-
> dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,rz-
> dmac.yaml
> index 1e25c5b0fb4d..f638d3934e71 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -10,7 +10,7 @@ maintainers:
> =C2=A0=C2=A0 - Biju Das <biju.das.jz@bp.renesas.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rzn1-
> dmamux.yaml b/Documentation/devicetree/bindings/dma/renesas,rzn1-
> dmamux.yaml
> index d83013b0dd74..ee9833dcc36c 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
> @@ -10,7 +10,7 @@ maintainers:
> =C2=A0=C2=A0 - Miquel Raynal <miquel.raynal@bootlin.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-router.yaml#"
> +=C2=A0 - $ref: dma-router.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-
> dmac.yaml b/Documentation/devicetree/bindings/dma/renesas,usb-
> dmac.yaml
> index ab287c652b2c..17813599fccb 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
> @@ -10,7 +10,7 @@ maintainers:
> =C2=A0=C2=A0 - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-
> pdma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-
> pdma.yaml
> index 3271755787b4..a1af0b906365 100644
> --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-
> pdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-
> pdma.yaml
> @@ -23,7 +23,7 @@ description: |
> =C2=A0=C2=A0 https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/snps,dma-
> spear1340.yaml b/Documentation/devicetree/bindings/dma/snps,dma-
> spear1340.yaml
> index c13649bf7f19..5da8291a7de0 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dma-spear1340.yaml
> @@ -11,7 +11,7 @@ maintainers:
> =C2=A0=C2=A0 - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-
> dmac.yaml
> index ad107a4d3b33..2bedab1f74e0 100644
> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
> @@ -13,7 +13,7 @@ description:
> =C2=A0=C2=A0 Synopsys DesignWare AXI DMA Controller DT Binding
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git
> a/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-
> dmac.yaml b/Documentation/devicetree/bindings/dma/socionext,uniphier-
> mio-dmac.yaml
> index e7bf6dd7da29..23c8a7bf24de 100644
> --- a/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-
> dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-mio-
> dmac.yaml
> @@ -14,7 +14,7 @@ maintainers:
> =C2=A0=C2=A0 - Masahiro Yamada <yamada.masahiro@socionext.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git
> a/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> b/Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> index 371f18773198..da61d1ddc9c3 100644
> --- a/Documentation/devicetree/bindings/dma/socionext,uniphier-
> xdmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/socionext,uniphier-
> xdmac.yaml
> @@ -15,7 +15,7 @@ maintainers:
> =C2=A0=C2=A0 - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 compatible:
> diff --git a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
> b/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
> index 158c791d7caa..329847ef096a 100644
> --- a/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
> @@ -53,7 +53,7 @@ maintainers:
> =C2=A0=C2=A0 - Amelie Delaunay <amelie.delaunay@foss.st.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 "#dma-cells":
> diff --git a/Documentation/devicetree/bindings/dma/st,stm32-
> dmamux.yaml b/Documentation/devicetree/bindings/dma/st,stm32-
> dmamux.yaml
> index 3e0b82d277ca..e722fbcd8a5f 100644
> --- a/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
> +++ b/Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
> @@ -10,7 +10,7 @@ maintainers:
> =C2=A0=C2=A0 - Amelie Delaunay <amelie.delaunay@foss.st.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-router.yaml#"
> +=C2=A0 - $ref: dma-router.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 "#dma-cells":
> diff --git a/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
> b/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
> index 08a59bd69a2f..3874544dfa74 100644
> --- a/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
> @@ -53,7 +53,7 @@ maintainers:
> =C2=A0=C2=A0 - Amelie Delaunay <amelie.delaunay@foss.st.com>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 "#dma-cells":
> diff --git
> a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> index 8bddfb3b6fa0..664ee61a00d8 100644
> --- a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> +++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> @@ -10,7 +10,7 @@ maintainers:
> =C2=A0=C2=A0 - Linus Walleij <linus.walleij@linaro.org>
> =C2=A0
> =C2=A0allOf:
> -=C2=A0 - $ref: "dma-controller.yaml#"
> +=C2=A0 - $ref: dma-controller.yaml#
> =C2=A0
> =C2=A0properties:
> =C2=A0=C2=A0 "#dma-cells":

