Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB3C64F967
	for <lists+dmaengine@lfdr.de>; Sat, 17 Dec 2022 15:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLQOfY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Dec 2022 09:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLQOfX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Dec 2022 09:35:23 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36650FAF7
        for <dmaengine@vger.kernel.org>; Sat, 17 Dec 2022 06:35:22 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id h10so4925302ljk.11
        for <dmaengine@vger.kernel.org>; Sat, 17 Dec 2022 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2NbXIefrhDpmJKbJe0p5pGtCPv/H1p/XKFgPNAP5e8=;
        b=DGT+hxjwqBvNruxpVyh3pSYJl+25hKQPJfVlKBxisxPwf8p0k/KF1E1kDDfPNsyA6S
         iuF9+ByLJceYuDXMNMiwAmWurFEOOXpKc2XarKoN+hizrQgwvWspH5lmeGscPF0D5yb+
         mxg4RT54rgmaHIGVUB8ivp5TzlDpiUdV+1+5CjZPgOYo17T+FfB0Dn9BHjrp+S4OLgo8
         DzceOp8NpjRKCWgXv55S8k8qxkWKErYo6oronSe1iZya6I+Zd+dKda9lFakQliY9V0qh
         nR8UyzrxYilspb6Nil6O5Ov49K7W1usNcPtHLRZRacn7kbN12woR3zOGUMfE6DkrWmmV
         oTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2NbXIefrhDpmJKbJe0p5pGtCPv/H1p/XKFgPNAP5e8=;
        b=q+cNRyFKucNCF7AufFVC3ed6d4bJAfiCVefM+tWrpTV8DfPIe1DlO2i/ki9HjAI2rb
         4dQLQmpfbXAMTBMU/gWEcPbp+vMDIkuQ0tZ9o3bWDsaeAvRTAMpHWHZZ1qJQleynRXBA
         fD2oliwlKfl55Y6PjTUY653wINwFzOcvFf5kbG3HPqQDtlVbkbb2khzJZ9idmJ6A53DY
         xKGpHCR98uzcHeqYAh8h2u6M+j+vuc8vDG9TYRUmJLguK7qE/JnWTAU4aCoMqvaWztHz
         k6Bwe3N3GZMyEyvj05638/LIJea6ktxeub+wQioZhDexATHzj/tpZVDgnB6Fqx6azDfT
         s6tA==
X-Gm-Message-State: ANoB5pkONHUzddyWLn2EG1N0zgxouGnsLBtQoWUsxHVde/rrDf7ZKNEq
        JmBVUy+1IjxJLb9Qi/0GwDFE9A==
X-Google-Smtp-Source: AA0mqf4sAUxGPRGY1t+nFac9lB8vlD4k06aGikbGf39u4uxX/tEv2+gvhycZZ7fuQsKobeUHW+EwYA==
X-Received: by 2002:a2e:b947:0:b0:279:edec:808b with SMTP id 7-20020a2eb947000000b00279edec808bmr9484632ljs.9.1671287720565;
        Sat, 17 Dec 2022 06:35:20 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id bd8-20020a05651c168800b00279e0b8bae7sm347057ljb.65.2022.12.17.06.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 06:35:20 -0800 (PST)
Message-ID: <f5496b92-ac1f-5920-1b3f-2bf0e710623b@linaro.org>
Date:   Sat, 17 Dec 2022 15:35:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm6125: Add GPI DMA nodes
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221216231528.1268447-1-marijn.suijten@somainline.org>
 <20221216231528.1268447-3-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221216231528.1268447-3-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 17.12.2022 00:15, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Add nodes for GPI DMA hosts on SM6125.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> [Marijn: reorder properties, use sdm845 fallback compatible, disable by
>  default, use 3 instead of 5 dma cells]
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 37 ++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index a205121ab4a7..abcd634c4f6d 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -5,6 +5,7 @@
>  
>  #include <dt-bindings/clock/qcom,gcc-sm6125.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/dma/qcom-gpi.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -510,6 +511,42 @@ sdhc_2: mmc@4784000 {
>  			status = "disabled";
>  		};
>  
> +		gpi_dma0: dma-controller@4a00000 {
> +			compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
> +			reg = <0x04a00000 0x60000>;
> +			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-channels = <8>;
> +			dma-channel-mask = <0x1f>;
> +			iommus = <&apps_smmu 0x0136 0x0>;
The stream id does not need the leading zero.
You made the mask a decimal zero in the previous patchset, please
decide on one convention. Masks are generally more useful as hex,
but for zero values I suppose zero is less noise for the same thing..

The DMA nodes however, look good otherwise.

Konrad
> +			#dma-cells = <3>;
> +			status = "disabled";
> +		};
> +
> +		gpi_dma1: dma-controller@4c00000 {
> +			compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
> +			reg = <0x04c00000 0x60000>;
> +			interrupts = <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-channels = <8>;
> +			dma-channel-mask = <0x0f>;
> +			iommus = <&apps_smmu 0x0156 0x0>;
> +			#dma-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		usb3: usb@4ef8800 {
>  			compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;
