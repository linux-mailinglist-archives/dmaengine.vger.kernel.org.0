Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091236546DF
	for <lists+dmaengine@lfdr.de>; Thu, 22 Dec 2022 20:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiLVTrd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Dec 2022 14:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiLVTr2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Dec 2022 14:47:28 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0609186B7
        for <dmaengine@vger.kernel.org>; Thu, 22 Dec 2022 11:47:25 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b13so4257305lfo.3
        for <dmaengine@vger.kernel.org>; Thu, 22 Dec 2022 11:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8NgwXERUKhNSJZQWMYuge/ry0x9I6WYR0sM01t06s0=;
        b=bbzH3g1gRAHvzwo8GTQ6XClYMbkx5gU0KV/HaxOXDWk5UjjJkipKsv87WlL4LbKSRj
         Nd6XJVTBK5LWzGpUV7C4G92pS4ZmNQ15mAHewNdvngveAcbkDC5YfiL84cRlxzjG0Mrz
         /4h42avJAm+I9FD+bgVCRmO72kpXJ9TMKZIQlQ7xjFo+tN2OmuI2CjGkuh5G9Vay6F5f
         FAd251i+mwrgwgNrTXXTNxWsRWUJt9JmGnNMJMb5682w8e7umTuzG4qvbV1OFZkshsx4
         ytREtyEu7bugA+kkgHOVV8Xs4b/in1EFevSwzj1ifSvOlUFmPYHmWf1qpE+MT4e1ke/r
         rsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8NgwXERUKhNSJZQWMYuge/ry0x9I6WYR0sM01t06s0=;
        b=RZ+AuX8TnnpFSRDFMRVqNoyXUO0f//i8IPVi7a8b+eCa2W43VAGCnqOu/Q8If3D66z
         txeqIeTbTSvgMTQLbvhhJOv1zPOtSv4TkjepdB4MzH2ZQ/mEGvyBuABlzJY9pKAvAb2Z
         66vQctq6xueSbQhpFQ+QHKbAzV0v4vIgRngy9rmib4E4x+XjpZf1vVCmW1CEVpamn63P
         WcV4T+EFMRSJacmGx7rqTRKZBseSybSLPF8dSXVhiI4Kb48MUD/0nB4KX/B3EQizyGBI
         +BjAB6G0kAt7YBhMW3XGRoLN3DXZVPHCVGLugFLkaANBJBizGciT7rtIA1NMUnLOqxKf
         qq3w==
X-Gm-Message-State: AFqh2kro7jApUX/INetn1cItugTZNr//tcKYm9RHUTXtzsicz0sgkLW7
        O+3k9fEi8yNhzyHz3sZr2jumBA==
X-Google-Smtp-Source: AMrXdXsX9bjV3cSBoR62uGY4csjneEp5yAry3R9DZBQ7Po6MyaDjh00JD6pgLxDz1/HR/p7299yJjg==
X-Received: by 2002:a05:6512:691:b0:4b6:fdc3:a668 with SMTP id t17-20020a056512069100b004b6fdc3a668mr2080075lfe.31.1671738444194;
        Thu, 22 Dec 2022 11:47:24 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id r21-20020ac25f95000000b004b5a4cf69dfsm178714lfe.261.2022.12.22.11.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 11:47:23 -0800 (PST)
Message-ID: <979c2896-cab5-1e2d-f587-b9eb3aa70dfb@linaro.org>
Date:   Thu, 22 Dec 2022 20:47:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm6125: Add GPI DMA nodes
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
        Luca Weiss <luca.weiss@fairphone.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221222194600.139854-1-marijn.suijten@somainline.org>
 <20221222194600.139854-3-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221222194600.139854-3-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 22.12.2022 20:46, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Add nodes for GPI DMA hosts on SM6125.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> [Marijn: reorder properties, use sdm845 fallback compatible, disable by
>  default, use 3 instead of 5 dma cells]
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 37 ++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 7c326368e30d..6f9b56a937c6 100644
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
> +			iommus = <&apps_smmu 0x136 0x0>;
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
> +			iommus = <&apps_smmu 0x156 0x0>;
> +			#dma-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		usb3: usb@4ef8800 {
>  			compatible = "qcom,sm6125-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;
