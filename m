Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E121E5ED6D1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiI1Hvd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiI1HvG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 03:51:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE9211918E
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 00:49:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x29so13469586ljq.2
        for <dmaengine@vger.kernel.org>; Wed, 28 Sep 2022 00:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Tz8FnON40hM72t8l0w9zzHepsEG1dR1dE8lAypF/8gQ=;
        b=xqjKOEM60b3kO5FXONlqeS+u0bfBp7+2es6bDeu2a+RrQHudBK97LmKepBt01O9JZx
         SdyDC3tgMc0Crc9/eYvvhXzxw4StPOVsLDgWZWrlRHFFMwo740zcTp5mR9AsbU+0HwsE
         zzAVP8APIKOA3HdkoYOHy7+rwQy+gsIr5PMsdW7LkJyVkFRG0UQrmpzyJPwmZK6ufnVd
         eA1gsfQ1LzSClp7Gew+OIwT5zbVKRMFLFJTVFEDJP3ZqgIypeoalhBj+xYzRylTXPDVA
         +5Gv98mFdrD7gDa/Wt91W8FL0fxGXJyI6MxxTiEBd5/Pu7oeD1pzghWHA9dNvupqmN5L
         k8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Tz8FnON40hM72t8l0w9zzHepsEG1dR1dE8lAypF/8gQ=;
        b=ug/E7IxkjM5FUHoKfJpqag9nKm0fEGjhJ/1LXdHVuKa8slR2B4Bclu2bta3IACpgaS
         jLpvogVbDC9IoRUlyGDiPi/3/toCOd2lhzofUaf9w9CzNaYcZWo1ivHFDA2giA2R04Eb
         gU5GCDUDitL/ICqitfx69kMvyJxADIgpiwegPt0JZrhkvXWOG1PI7XeuoWxEL0/KvD5L
         VReMMoAK0IiHUVvf/ZtWeBMhvkzirE5pHilwq7NGH2Lf1MgIi+sN0F9WO+/qvWOpYBRw
         +b9WWNJS9AwvTnEbP67RH13PDjboOPdIZaSyQlCHiz+STQQrJIgq04huO7s3n7D/z3gJ
         sTkA==
X-Gm-Message-State: ACrzQf0E9kOtqyTKmj8lPnZJy9CrQ/eW0Cya1mjIyPDTltsawSMx/vGt
        j3RFuPXRXeJ01jDVOUIfAjDXSQ==
X-Google-Smtp-Source: AMsMyM6XEyT9Y+vKgFQGHVFAkmCRPGlrudBlXOq6fAezTaw3b6tDxijEtcG5CNa1XooTvy6H/3fYRw==
X-Received: by 2002:a2e:7808:0:b0:26d:295f:dfef with SMTP id t8-20020a2e7808000000b0026d295fdfefmr7220913ljc.266.1664351389228;
        Wed, 28 Sep 2022 00:49:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id cf31-20020a056512281f00b004a044928923sm395342lfb.293.2022.09.28.00.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:49:48 -0700 (PDT)
Message-ID: <9c88a0ba-36c4-ae04-cf04-51174613893a@linaro.org>
Date:   Wed, 28 Sep 2022 09:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 4/4] dmaengine: qcom: gpi: drop redundant of_device_id
 entries
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
References: <20220927014846.32892-1-mailingradian@gmail.com>
 <20220927014846.32892-5-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927014846.32892-5-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27/09/2022 03:48, Richard Acayan wrote:
> The drivers are transitioning from matching against lists of specific
> compatible strings to matching against smaller lists of more generic
> compatible strings. Continue the transition in the GPI DMA driver.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/dma/qcom/gpi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 89839864b4ec..e5f37d61f30a 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -2289,8 +2289,6 @@ static const struct of_device_id gpi_of_match[] = {
>  	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
>  	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
>  	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
> -	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
> -	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },

You cannot remove them that fast - it would be an ABI break. Just add a
comment that these are deprecated and devices should match with a
fallback compatible.

Best regards,
Krzysztof

