Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423FA601B6B
	for <lists+dmaengine@lfdr.de>; Mon, 17 Oct 2022 23:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJQVok (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 17:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJQVob (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 17:44:31 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA380500
        for <dmaengine@vger.kernel.org>; Mon, 17 Oct 2022 14:37:29 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a5so7547746qkl.6
        for <dmaengine@vger.kernel.org>; Mon, 17 Oct 2022 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35URIFUA0QlEjx+bYH8KEH0hehoTBL1Y1MvYu0561w0=;
        b=ALkZoIBGSbbgToNxOeTOkHIwIXBZSnWKxcGugZsfsfiDwxyn1gyxs7HESM+v0jQWFh
         ymq5JE2P7cGJdRrdQ7vdesKH3o6UShSSe2+koO8Fv7wb0tERmze3ewPjBfja4a6Xqrft
         odNaWfdNDqan0OkeSWda1unB4cLz0KUEpbbEVI3qEtMYy6OObsSHM0sBDpPaz0Lj2ZES
         Gn+kAvMmsW8P1JWNNNYG6PAv7mfj4SRa5b4GNNed7rjouzIACpRRhAwpHM62L2MrUm3F
         R/ubFqyMHO2dRgGKZlG9fo9FEOPLVbZI0GVdzXM3XaR9LBc31hfwXMkKBaV5f1cOIMSV
         OzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35URIFUA0QlEjx+bYH8KEH0hehoTBL1Y1MvYu0561w0=;
        b=lV9WwRXKFTe3NpsBi5raIEdFpjAXuxWhxrxrpg7548op3lkEkbnzRSyjvvNdn9IZSi
         NEgRYDFxKg0r/nnqW/ZmscsXeunfVBCP8vIRVHD1EpdTcjaorTG6JonN2vgVcxh+7+Un
         eJ0Wf/MqQIY/aDtwt9Emyq7dh2ppf5VkDOMYv/sYWZHfmbjkXS7q0GcyD6Ypm0NbQjVe
         0ztc0wv1Uiy686alQ4AF1bWYXUXgr9xbcUzOJVBd6eTRjyQkI1TGqFQYpx03+Yi3uU2D
         0KzSDrCF12GyoccsBszDOaqNRxyXakM6b+gsuzzHaDJykcvWDabp95ypqGForoCakEdG
         PfKA==
X-Gm-Message-State: ACrzQf1pZd+2lkSSwpsp0jyxMW2RVGoXTXYv5CYYoZ2qK4lXab8HCD3+
        gjrujvKMyn0QAY2tLJK02rgMTQ==
X-Google-Smtp-Source: AMsMyM6IxEBaJFiDyOfSUudaNpu0aO7zN16YE1XLQ6btlmGI41k9o93UaRCwgXI/JIMUQi+fB7RdIQ==
X-Received: by 2002:ae9:e315:0:b0:6ee:761d:4b8b with SMTP id v21-20020ae9e315000000b006ee761d4b8bmr9216782qkf.748.1666042648678;
        Mon, 17 Oct 2022 14:37:28 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id t12-20020ac8530c000000b0039a55f78792sm562481qtn.89.2022.10.17.14.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:37:28 -0700 (PDT)
Message-ID: <98c595dc-0dfb-e87d-aa1e-38198f942525@linaro.org>
Date:   Mon, 17 Oct 2022 17:37:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 1/3] dt-bindings: dma: qcom: gpi: add fallback
 compatible
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
References: <20221007213640.85469-1-mailingradian@gmail.com>
 <20221007213640.85469-2-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221007213640.85469-2-mailingradian@gmail.com>
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

On 07/10/2022 17:36, Richard Acayan wrote:
> The drivers are transitioning from matching against lists of specific
> compatible strings to matching against smaller lists of more generic
> compatible strings. Use the SDM845 compatible string as a fallback in
> the schema to support this change.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/dma/qcom,gpi.yaml     | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index eabf8a76d3a0..081b8a2d393d 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -18,14 +18,19 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,sc7280-gpi-dma
> -      - qcom,sdm845-gpi-dma
> -      - qcom,sm6350-gpi-dma
> -      - qcom,sm8150-gpi-dma
> -      - qcom,sm8250-gpi-dma
> -      - qcom,sm8350-gpi-dma
> -      - qcom,sm8450-gpi-dma
> +    oneOf:
> +      - enum:
> +          - qcom,sc7280-gpi-dma
> +          - qcom,sdm845-gpi-dma
> +          - qcom,sm6350-gpi-dma
> +          - qcom,sm8350-gpi-dma
> +          - qcom,sm8450-gpi-dma
> +

Drop the empty line, please.

Best regards,
Krzysztof

