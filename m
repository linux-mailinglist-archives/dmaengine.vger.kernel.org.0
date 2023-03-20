Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4AF6C0F8F
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 11:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCTKp7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 06:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjCTKpd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 06:45:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BCD28200
        for <dmaengine@vger.kernel.org>; Mon, 20 Mar 2023 03:43:39 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bi9so14253367lfb.12
        for <dmaengine@vger.kernel.org>; Mon, 20 Mar 2023 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679308926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k16MUxzAr7So06ek3jaPuSWRMbCu5blX7yixTU1VOIo=;
        b=yeL7UQSEl7jxwbF+hiCfIPXVpJOFWcmKPNTDVlbXSiMaDqQKl14bXg52B3O8Jd5bfj
         cnsiJshIg73GzFW0UqBuR+zMaCPyHONlpuy6GCwi4fznClsRfR4pPvry5kUAOskkmo0K
         jxPFuc1h0bOnK5locxjGh4qc5YQQxwpcIVc10edsXIm3jV+9wohQxpa8Id/x3e7i0Cqt
         QdplhuFyvPQM/Sp8li3H+1nCsvWt4cv0bbAvoSGAVjMPpA1w6PUdPNQx96u6nfy+uU7/
         jhW19gHBX2PLS86+WnYLU4/svMBt914HAGx/haMQZMbGfWEBKwiRCMFQESSeuUnbfpfI
         7dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k16MUxzAr7So06ek3jaPuSWRMbCu5blX7yixTU1VOIo=;
        b=hpeEEy/qj6D6kFuDOVf+cjUbShSXuIFGxdu8KagL0bdjkwVGYbCwK7BexZZG1pYMZO
         dA8LrAelN7iGd4TmXtP7Jl+FgCg/4OlRdbfo5wkZMtlNYfoOpazApGayTlqQKBGlOc0i
         HjYacRWylRNO+cI8UrU4PQjkdCFqjy6eJDNKb5On0V6lAuyTKEWSvAcSNB5Bmimn4QNE
         rVxGqtNlMXfc7oA7eQUHDFJ/rjP+YsewMnOrMoSz9X5CVqqaa6eUDhqBOJRI/7Xvlmj1
         AsrmXzP2y0UcNUO+gvMWMdkh2Yux+/eKos1VxMzYUYhVAKVdkhcQQjYzj6NC33DaWn63
         RZTQ==
X-Gm-Message-State: AO0yUKWIBhVqxKSVbOTohQhkvJi2N9cuMNum111EYIGAkOZvad9llgH5
        6x+l7pjqgayJmOSnDhnE2/MxVQ==
X-Google-Smtp-Source: AK7set8rHwqmHn+7sNRobBB28oMLRWp7yGgCfY/k3lB8f0Hw3GPmtlFfnPKnKWQkObtFPzP1JQGv4Q==
X-Received: by 2002:ac2:5097:0:b0:4b5:2ef3:fd2a with SMTP id f23-20020ac25097000000b004b52ef3fd2amr7744823lfm.47.1679308926377;
        Mon, 20 Mar 2023 03:42:06 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id r8-20020a19ac48000000b004e8b90e14a8sm1659531lfc.25.2023.03.20.03.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:42:06 -0700 (PDT)
Message-ID: <0a8fcd57-94dc-61e6-0ba0-b1591e05e6f2@linaro.org>
Date:   Mon, 20 Mar 2023 11:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] dmaengine: qcom: bam_dma: Add support for BAM engine
 v1.7.4
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com, vkoul@kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org
References: <20230320071211.3005769-1-bhupesh.sharma@linaro.org>
 <20230320071211.3005769-2-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320071211.3005769-2-bhupesh.sharma@linaro.org>
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



On 20.03.2023 08:12, Bhupesh Sharma wrote:
> Qualcomm SoCs SM6115 and  QRB2290 support BAM engine version
> v1.7.4.
> 
> Add the support for the same in driver. Since the reg info of
> this version is similar to version v1.7.0, so reuse the same.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 1e47d27e1f81..153d189de7d2 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1228,6 +1228,7 @@ static const struct of_device_id bam_of_match[] = {
>  	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_reg_info },
>  	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_reg_info },
>  	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_reg_info },
> +	{ .compatible = "qcom,bam-v1.7.4", .data = &bam_v1_7_reg_info },
The compatible is meaningless as of today (it uses the exact same driver
data as v1.7.0), so I'd say going with:

compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";

is what we want.

Konrad
>  	{}
>  };
>  
