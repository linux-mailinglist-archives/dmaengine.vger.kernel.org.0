Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4B6C7DB7
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 13:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjCXMIt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCXMIs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 08:08:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB08999
        for <dmaengine@vger.kernel.org>; Fri, 24 Mar 2023 05:08:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t11so1987691lfr.1
        for <dmaengine@vger.kernel.org>; Fri, 24 Mar 2023 05:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679659725; x=1682251725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKWvw7b+JAS44FVyD0FLI3tZGRETXw2/xRa06dfHw0k=;
        b=afr9y2A1iS13xzsG4ZbEpuOwpHzB94ZjEYQ8femJ88V1SChdcim0pr/d5rq1pZ0ENH
         9NMtrGFFOPc5Hby8mA7uqg9Hwq1c0LoHr5h9OlTI/y6TWpCAfYRKLuYzRgo/ZldDhEhP
         K4/CgRvzYaY0dtiGaiBC0qD5kLhzYigv7P53TQ8NNJ29f6HSfrHpTdADqPCXVBqpDW9c
         Z4vw8hoaoVDz9Y1/gUfxR6t0qH+d1mMKaB9UtZC3K4tE9Ll8ni1C1dbVV8MJlHkb7w2j
         UmGHqjdywccrNSa0vAQhwzeqXDQP8ic7E5S6/4eHmLbe03/pPu3mm0uYV1hiJIWzY0Ks
         ECsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679659725; x=1682251725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKWvw7b+JAS44FVyD0FLI3tZGRETXw2/xRa06dfHw0k=;
        b=XHQ/RsN4bNLNV6qS11I7CLXXEWhpJaHVtMdCqnMLDjidBlnlGstlhONp2PKDkhqSk6
         H5LIvxTd0Q3RhrtzhW8KmyyBoeGlpxdovPBQsAji2/v+zDaJAgppVDxEEST8fcx6AVtC
         VHlt+nTJwjocfeCTbyz6DQ4yIyFLyyZ53nAwObfm5nG3L5KaeXVaFkDfZwuiQvlMiJPE
         fq2SctTfe8IthtB+QP10pH4DH41OTbvwLGrLgci4sZ396Li/VvZGCUxP1K9p3E8AUJd4
         gQKVYwueMsf/0GfomrGAMHctb5Y4j4wXWovg+AitZ6vzgNCFnyUnfIWCOZT8uuF2ARg/
         wQuA==
X-Gm-Message-State: AAQBX9cQX5TsyywGK3yfGQrxWDWD2lWNSbdodic8xPf93YdHXmtWKH8C
        xvjlIrIS3yGaXG07uSQgoff60A==
X-Google-Smtp-Source: AKy350a+AxVBqGyixTZ2LohqdfaVCcjTRMp0giVBa0/MZtDLKCnA5uRBslMBZXkINHhhFKF4sl/OMg==
X-Received: by 2002:ac2:52b9:0:b0:4d2:c70a:fdfa with SMTP id r25-20020ac252b9000000b004d2c70afdfamr538404lfm.4.1679659725083;
        Fri, 24 Mar 2023 05:08:45 -0700 (PDT)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id h8-20020a197008000000b004dc6070e121sm3329137lfc.83.2023.03.24.05.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 05:08:44 -0700 (PDT)
Message-ID: <7b26e32d-6f3e-4e1f-33a7-0a994ae8526d@linaro.org>
Date:   Fri, 24 Mar 2023 14:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 1/2] dt-bindings: dma: Add support for SM6115 and QCS2290
 SoCs
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com, vkoul@kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org
References: <20230320071211.3005769-1-bhupesh.sharma@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20230320071211.3005769-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Bhupesh,

On 3/20/23 09:12, Bhupesh Sharma wrote:
> Add new compatible for BAM DMA engine version v1.7.4 which is
> found on Qualcomm SM6115 and QCS2290 SoCs.
> 
> While at it, also update qcom,bam-dma bindings to add comments
> which describe the BAM DMA versions used in SM8150 and SM8250 SoCs.
> This provides an easy reference for identifying the actual BAM DMA
> version available on Qualcomm SoCs.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> index f1ddcf672261..4c8536df98fe 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -20,8 +20,10 @@ properties:
>         - qcom,bam-v1.3.0
>           # MSM8974, APQ8074 and APQ8084
>         - qcom,bam-v1.4.0
> -        # MSM8916 and SDM845
> +        # MSM8916, SDM845, SM8150 and SM8250
>         - qcom,bam-v1.7.0
> +        # SM6115 and QRB2290
> +      - qcom,bam-v1.7.4
>   
>     clocks:
>       maxItems: 1

apparently it's a good time to implement a switch in compatible values
similar to the one done for QCE:

https://lore.kernel.org/linux-arm-msm/20230222172240.3235972-6-vladimir.zapolskiy@linaro.org/

If this is done in the nearest time, then new platfrom QCE changes
can be seamlessly added after the next merge window, also the change
in the compatible values model shall resolve multiple technical
concerns including the one above about 1/1 change in the series.

--
Best wishes,
Vladimir
