Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A9762BCFA
	for <lists+dmaengine@lfdr.de>; Wed, 16 Nov 2022 13:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKPME6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Nov 2022 07:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiKPMD4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Nov 2022 07:03:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A29C48741
        for <dmaengine@vger.kernel.org>; Wed, 16 Nov 2022 03:55:32 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d6so29083482lfs.10
        for <dmaengine@vger.kernel.org>; Wed, 16 Nov 2022 03:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfLbodZyN74OlW0fHxrGtLIy7WkT5ufiJ1ZQXyiLZg8=;
        b=KNiyFKTSSrMYybD64ySLswEdRPlf8yMAWSL07lBU4mobn/x8iaqAFWJczlT5/nuDXF
         hEvXhFzhJ7ivbnTqKstK2P0StLtZYWxt7nhl1+v3Th7mdh7gOYkwf1rny6Ywer8rfp8+
         6PH+TAZuehie5mz6bdEfuMkbe1HNPu8ReQHIBLb4Z7yXoEi22L2805Q/4iPy0T2ANs9S
         Axji9nb+WkI0Kj3C9wLk0uWVxxMm1cEkrzSlGUMJh+qszlIDBO4y5mjUnvG11nsjtpYs
         OfLxET10Rq8jDerNzf0FFdySV6GoPfdJqiIO3VxSI7dMLl0vNNvZj2GG5enThhla6PiX
         LWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfLbodZyN74OlW0fHxrGtLIy7WkT5ufiJ1ZQXyiLZg8=;
        b=XJ46GzevSvJlRSkzE+KdB0g0yumPIjQQwnISaOnlz62qBdgyIb2LVd+R7Cj/vQoO6H
         voP15xoPaHa32mxPKpqKhhUFneo3ljjqwwDhB5xViA0MdmLhVNmihmkvTES2GSoxFZwC
         BHWeNfZ2/MfqYo9sPCbDqO6Af5AaKlsZu8ASZDjk09F8+DeebIV6FxcjhRSrb6/ptetD
         hmDlv0+4YOzwkHJhbGpHfej6irJ7iRU3RZRY/TmEd+oZxoUWALKMp8w6GLkDl6TqRUI+
         taSPzqtyLiHNtiLPGnZ73+S4xErb6bB6xt96/bysl/TFLgrP2ghJD2nll+06zvJH8xfP
         0Ngw==
X-Gm-Message-State: ANoB5ploL+ONQkNSQAAO+i+CX7qcL8BaRFOpMyrM1w9cSyA9uRMqvkS2
        FV3bbU2DLPx9Ml0UuVFZFmjPNA==
X-Google-Smtp-Source: AA0mqf5KzB6TgQN02BtYUHtFhcnG9qFoNCWT8HkdjZpVteEAUvk4mELslcDcOwbuxUQJM4Z9zdiXYw==
X-Received: by 2002:a05:6512:10c8:b0:499:d6f9:5b3d with SMTP id k8-20020a05651210c800b00499d6f95b3dmr6754511lfg.69.1668599730915;
        Wed, 16 Nov 2022 03:55:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j9-20020a056512344900b004b1907d85e9sm2564046lfr.161.2022.11.16.03.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:55:30 -0800 (PST)
Message-ID: <96c05268-d0c8-ddfe-ecae-28df16743054@linaro.org>
Date:   Wed, 16 Nov 2022 12:55:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] crypto: qce: core: Add new compatibles for SM8550
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-qce-v1-0-31b489d5690a@linaro.org>
 <20221114-narmstrong-sm8550-upstream-qce-v1-4-31b489d5690a@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-qce-v1-4-31b489d5690a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16/11/2022 11:23, Neil Armstrong wrote:
> Add the compatible for the Qualcomm Crypto core found in the SM8550 SoC.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/crypto/qce/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index ef774f6edb5a..fae578ba3e30 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -302,6 +302,7 @@ static const struct of_device_id qce_crypto_of_match[] = {
>  	{ .compatible = "qcom,sdm845-qce", },
>  	{ .compatible = "qcom,sm8150-qce", },
>  	{ .compatible = "qcom,sm8250-qce", },
> +	{ .compatible = "qcom,sm8550-qce", },

The same problem as in your dependency. No need for this. Use fallbacks.

Best regards,
Krzysztof

