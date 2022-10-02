Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DE5F21EC
	for <lists+dmaengine@lfdr.de>; Sun,  2 Oct 2022 10:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJBIPR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Oct 2022 04:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJBIPO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Oct 2022 04:15:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C9027DF2
        for <dmaengine@vger.kernel.org>; Sun,  2 Oct 2022 01:15:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c2so6309493lfb.10
        for <dmaengine@vger.kernel.org>; Sun, 02 Oct 2022 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=s2Uh3PpT13mJBJ1e61WOr6LFLJbasTKO+1hejNf0JLE=;
        b=G8Azz3hP9CXBtBE70r+A+65q7ULxWW7RN2y0u3zIhkmPtS2nzuDLJhbxrhvbMHpdGo
         JLmPnJRv2l6Ob3CX5KU7JeTM7KLtYb0xNsTSw5+dG8ECARBt7LR772vanwbvZWKQLDHH
         cA6wksS99Tlgom9wuzMqaQCXRYMe9MxToDEKm3bpSSH67ysad3D6QTz+VV02PswMOVk2
         Es6WKaGusYax+Mq1Qw7WfU/HoFJWGAO9y2g7dwZuWo1B2uHFz9K8fpbDQ0mTqt8Thrpc
         m7b0/cFCUJ2kvof+03yDdIs0thFrWLMG82fIzPkINnKKbX6tuEVtCCUIAD9Y1JuT6JaB
         pZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=s2Uh3PpT13mJBJ1e61WOr6LFLJbasTKO+1hejNf0JLE=;
        b=74ehlH10cyDlBxZXtQh2hrimT52ZYCYiUw4TeyNrHBCLYC6LvBoXXBQvZxaybhN1VR
         SJ0uBrw1m7ZZz0Tux0AlKx3RRX2GUIEUs2aY3sQwbRv+BUs0L0AqJwOYUnpYjJYBHtro
         cjxNpchrkniZ1AgG4Rxu4uEY4kAAS/qjBe4fcUW62rG3YbpxBKPlZ1EHvor/wlf4SLql
         LAkpM3LsB3tLxoDY16zQJIr4JWSlgJ90yHcvYFqODLaPmU+CC6iTes2i2yfn+dp2DLIH
         g3f6699Y+/dSFMt/lbuFQJOLzGvWfEcUBOvDrloQUdHEvnMOu8qFGj33bukONUw9uaU2
         AhWg==
X-Gm-Message-State: ACrzQf33VBzUSWB+s8RUZxIfq4kgxoW/O3HtRhXVlxhXBwBEZOLna2H6
        t5X16I84wKRCMXR5Ez8pTfj0Vw==
X-Google-Smtp-Source: AMsMyM4Sj6uZkC2lA6Ka+K7fj8c8gZXyehTdGN5ox47TbrEQoI19qCfeJZhga1vrP3W16jlm3hWlvg==
X-Received: by 2002:a05:6512:1047:b0:49d:a875:8d90 with SMTP id c7-20020a056512104700b0049da8758d90mr6007164lfb.630.1664698509667;
        Sun, 02 Oct 2022 01:15:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d6-20020a2e96c6000000b0026c3ecf9a39sm592594ljj.38.2022.10.02.01.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 01:15:09 -0700 (PDT)
Message-ID: <dc5c1c52-efb2-34a6-5aee-e63453fc91c7@linaro.org>
Date:   Sun, 2 Oct 2022 10:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm6125: Add GPI DMA nodes
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001185526.494095-1-martin.botka@somainline.org>
 <20221001185526.494095-3-martin.botka@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001185526.494095-3-martin.botka@somainline.org>
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

On 01/10/2022 20:55, Martin Botka wrote:
> This commit adds and configures GPI DMA nodes.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 37 ++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index d35ea4474234..7e135041bd42 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/clock/qcom,dispcc-sm6125.h>
>  #include <dt-bindings/clock/qcom,gcc-sm6125.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/dma/qcom-gpi.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -1076,6 +1077,42 @@ sdhc_2: mmc@4784000 {
>  			status = "disabled";
>  		};
>  
> +		gpi_dma0: dma-controller@4a00000 {
> +			compatible = "qcom,sm6125-gpi-dma";

You will need here sdm845 fallback.

> +			#dma-cells = <5>;
> +			reg = <0x04a00000 0x60000>;
> +			iommus = <&apps_smmu 0x0136 0x0>;
> +			dma-channels = <8>;
> +			dma-channel-mask = <0x1f>;
> +			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "okay";

No need, its okay by default.

Both comments apply everywhere.

Best regards,
Krzysztof

