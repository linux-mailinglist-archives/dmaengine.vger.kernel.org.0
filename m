Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDF064FE6A
	for <lists+dmaengine@lfdr.de>; Sun, 18 Dec 2022 11:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLRKXm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Dec 2022 05:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiLRKXl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 18 Dec 2022 05:23:41 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AE364E1
        for <dmaengine@vger.kernel.org>; Sun, 18 Dec 2022 02:23:40 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 17B551F7B6;
        Sun, 18 Dec 2022 11:23:38 +0100 (CET)
Date:   Sun, 18 Dec 2022 11:23:36 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm6125: Add GPI DMA nodes
Message-ID: <20221218102336.io5epil54gwlqqqh@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221216231528.1268447-1-marijn.suijten@somainline.org>
 <20221216231528.1268447-3-marijn.suijten@somainline.org>
 <f5496b92-ac1f-5920-1b3f-2bf0e710623b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5496b92-ac1f-5920-1b3f-2bf0e710623b@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022-12-17 15:35:18, Konrad Dybcio wrote:
> 
> 
> On 17.12.2022 00:15, Marijn Suijten wrote:
> > From: Martin Botka <martin.botka@somainline.org>
> > 
> > Add nodes for GPI DMA hosts on SM6125.
> > 
> > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > [Marijn: reorder properties, use sdm845 fallback compatible, disable by
> >  default, use 3 instead of 5 dma cells]
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6125.dtsi | 37 ++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > index a205121ab4a7..abcd634c4f6d 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > @@ -5,6 +5,7 @@
> >  
> >  #include <dt-bindings/clock/qcom,gcc-sm6125.h>
> >  #include <dt-bindings/clock/qcom,rpmcc.h>
> > +#include <dt-bindings/dma/qcom-gpi.h>
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/power/qcom-rpmpd.h>
> > @@ -510,6 +511,42 @@ sdhc_2: mmc@4784000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		gpi_dma0: dma-controller@4a00000 {
> > +			compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
> > +			reg = <0x04a00000 0x60000>;
> > +			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
> > +			dma-channels = <8>;
> > +			dma-channel-mask = <0x1f>;
> > +			iommus = <&apps_smmu 0x0136 0x0>;
> The stream id does not need the leading zero.

Good catch!  Will clean this up for V2.

> You made the mask a decimal zero in the previous patchset, please
> decide on one convention. Masks are generally more useful as hex,
> but for zero values I suppose zero is less noise for the same thing..

The _vast majority_ of qcom dts uses 0x0, I'll fix that in the previous
patch series.  Looks like I did even clean that up when directly
transplanting that patch ("Add apps_smmu with streamID to SDHCI 1/2
nodes") to sm6350 even...

> The DMA nodes however, look good otherwise.

And they work great, too!

- Marijn
