Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16F65F1FC5
	for <lists+dmaengine@lfdr.de>; Sat,  1 Oct 2022 23:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJAVUZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Oct 2022 17:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJAVUZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Oct 2022 17:20:25 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B1A2DA9C
        for <dmaengine@vger.kernel.org>; Sat,  1 Oct 2022 14:20:20 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0D9982005F;
        Sat,  1 Oct 2022 23:20:17 +0200 (CEST)
Message-ID: <d2d540d6-4694-64fa-7bde-9b78869c8d61@somainline.org>
Date:   Sat, 1 Oct 2022 23:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: add gpi-dma fallback compatible
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
References: <20221001211934.62511-1-mailingradian@gmail.com>
 <20221001211934.62511-4-mailingradian@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221001211934.62511-4-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 1.10.2022 23:19, Richard Acayan wrote:
> The dt schema for gpi-dma has been updated with a new fallback
> compatible string. Add the compatible strings to existing device trees.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 6 +++---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index cef8c4f4f0ff..281d5109ac3b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -887,7 +887,7 @@ gcc: clock-controller@100000 {
>  		};
>  
>  		gpi_dma0: dma-controller@800000 {
> -			compatible = "qcom,sm8150-gpi-dma";
> +			compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
>  			reg = <0 0x800000 0 0x60000>;
>  			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
> @@ -1222,7 +1222,7 @@ spi7: spi@89c000 {
>  		};
>  
>  		gpi_dma1: dma-controller@a00000 {
> -			compatible = "qcom,sm8150-gpi-dma";
> +			compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
>  			reg = <0 0xa00000 0 0x60000>;
>  			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
> @@ -1471,7 +1471,7 @@ spi16: spi@a94000 {
>  		};
>  
>  		gpi_dma2: dma-controller@c00000 {
> -			compatible = "qcom,sm8150-gpi-dma";
> +			compatible = "qcom,sm8150-gpi-dma", "qcom,sdm845-gpi-dma";
>  			reg = <0 0xc00000 0 0x60000>;
>  			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index a5b62cadb129..5d5de7eead08 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -936,7 +936,7 @@ rng: rng@793000 {
>  		};
>  
>  		gpi_dma2: dma-controller@800000 {
> -			compatible = "qcom,sm8250-gpi-dma";
> +			compatible = "qcom,sm8250-gpi-dma", "qcom,sdm845-gpi-dma";
>  			reg = <0 0x00800000 0 0x70000>;
>  			interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>,
> @@ -1187,7 +1187,7 @@ spi19: spi@894000 {
>  		};
>  
>  		gpi_dma0: dma-controller@900000 {
> -			compatible = "qcom,sm8250-gpi-dma";
> +			compatible = "qcom,sm8250-gpi-dma", "qcom,sdm845-gpi-dma";
>  			reg = <0 0x00900000 0 0x70000>;
>  			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
> @@ -1505,7 +1505,7 @@ spi7: spi@99c000 {
>  		};
>  
>  		gpi_dma1: dma-controller@a00000 {
> -			compatible = "qcom,sm8250-gpi-dma";
> +			compatible = "qcom,sm8250-gpi-dma", "qcom,sdm845-gpi-dma";
>  			reg = <0 0x00a00000 0 0x70000>;
>  			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
