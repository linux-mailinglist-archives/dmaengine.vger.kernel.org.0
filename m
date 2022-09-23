Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799395E77B5
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiIWJyr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 05:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiIWJyo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 05:54:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9A1E72B
        for <dmaengine@vger.kernel.org>; Fri, 23 Sep 2022 02:54:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a8so18908386lff.13
        for <dmaengine@vger.kernel.org>; Fri, 23 Sep 2022 02:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tI86aWc3x9gHUUkwiKWXsgqLgR2fUyl+zwNSRN0rak0=;
        b=Xmrb0xNDPdo/slXsikUgoRsYmGoF6cV6TbKHDcNgZDSkLERlrUivnIyUQpG2S1AMbQ
         1ZSJHo37HkMdS1xKmGe/49U8DOWYaV1saKoFjmdo6n+/XG34LNnyGmg5QkZyowOV4yMj
         f1T23a4RbhghBGRGBflPgTLDjD8IKALuBawKz96KzmRUYjgtbwDuCOH/x9F724hT8PcK
         Ef2PyFj8gqpdaVruu6Cw6fw4vNpiyY9z+82HZv49cNOZ3XjkYkIb0CrZVfyy347UYgPT
         5fkofahFK2oiBJo9tAGPTfsd3S+0NGzpILlG3ecYM3EE3FIAARHepcT3eXUWaqHbtfI2
         8sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tI86aWc3x9gHUUkwiKWXsgqLgR2fUyl+zwNSRN0rak0=;
        b=gG50IbujlYNs6VgbFstcXdJGJ7sHaOLRKHS5uSFleSbfwagbohtcz4GGzsGWBIT8vw
         xgX/7iszgPAQ4w4H0/mD7zNa6W0HtFZDPaNZUnECtGr0v55Iekxg2g16R8ZWvZMc6W4+
         lOXNAdsSMWTYwAAglbKwaTBaQEt094w8OMzQ2lV+8x7FBbgWfmRzaAfjZc0ll9ep7akn
         dO+ZMDsdAOt0ysAVy8dCTXFe699M80Vdj2JssyTBjaFbO6PyhGpddw+Y13CjhJaxpI7i
         6uKbuz1GT9exiFZsTDvAaP9qbomlflKaNyt/i6YTD2zpuUMUj0gzIm6rncFmRCxBlQEi
         IJ1A==
X-Gm-Message-State: ACrzQf1+rfNunklkQOqbvCpBDQAfJv77d8l/FjzEj6keCH+n76uRYjOv
        actpqNh4qUGErfvAM0RZKEuaEg==
X-Google-Smtp-Source: AMsMyM5osgYnk0JY32MOnt1PTXSY4AAdMLMRZyN20A9Fexjs3um0SuzDWBHwsefW+hYfQ4HjPMHmZQ==
X-Received: by 2002:a05:6512:1088:b0:49f:c019:a3ae with SMTP id j8-20020a056512108800b0049fc019a3aemr2797491lfg.332.1663926879982;
        Fri, 23 Sep 2022 02:54:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x27-20020a2ea99b000000b0026c46788fa3sm1243885ljq.104.2022.09.23.02.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:54:39 -0700 (PDT)
Message-ID: <11442883-2ccd-b787-5143-b2dfeb54da3e@linaro.org>
Date:   Fri, 23 Sep 2022 11:54:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] dmaengine: qcom: gpi: add sdm670 support
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
References: <20220923015426.38119-1-mailingradian@gmail.com>
 <20220923015426.38119-3-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923015426.38119-3-mailingradian@gmail.com>
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

On 23/09/2022 03:54, Richard Acayan wrote:
> The Snapdragon 670 uses GPI DMA for its GENI interface. Add support for
> it.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/dma/qcom/gpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 89839864b4ec..9634be23e46b 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -2287,6 +2287,7 @@ static int gpi_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id gpi_of_match[] = {
>  	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
> +	{ .compatible = "qcom,sdm670-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
>  	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },

I vote for just one entry with 0x0 offset...

Best regards,
Krzysztof

