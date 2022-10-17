Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B266601C1B
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 00:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJQWMf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 18:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJQWMd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 18:12:33 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBCB6D87B
        for <dmaengine@vger.kernel.org>; Mon, 17 Oct 2022 15:12:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id j21so7590140qkk.9
        for <dmaengine@vger.kernel.org>; Mon, 17 Oct 2022 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OJf4F+JKFppB/W0S0nhFbRnIAx64pBVeYTRLpixwyE=;
        b=vX8e52AS+9MDUc9S8uNK4Q0XQGHn9O4xlkEdlvHntcs+g2y4f70q49YdgSGtiFoFM3
         lJC6cZI3uOD/EtcwCjVl2b9OoCpxTGNR5RfDUxxA1vRMw9dtMaxyxF0jX3PuHXaoP6Jv
         zu3SxnPesLcdlfBy55n+vZUhizHwOiDGBagH3yMBFxbS7hvVoMZRmR5EyGBxVDN/K95Z
         lshiQdabI3kle6iu6uMJlhvVv5f8Y3SwIaY5gmocf0oUeS9054pkpkgaed64hT/gP4jO
         /kj0NfTQ6Gu1elluEP6rsVIIAv176mh8jIF8DeHJcmba+TSpCu/I8C9kPrzdjUghCx3a
         Oeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OJf4F+JKFppB/W0S0nhFbRnIAx64pBVeYTRLpixwyE=;
        b=hwVGU/lwpo32RNLsALw89TZa5885o9u9It38oRyfMIyLsyFE9KVZHhK/f3Uk2j5byj
         hOv1nOo8ZvaCli0lJoYT7sItcIQninoux/7RA5SIk1e1AeQVwMxQAVydOXCmezYgkS61
         5LG6XSjGxHV4TUWvB6mqpfMf3WKXqgmHj//2hbQXJ3NuaR64c39BCNR4n6tUTZVB6KPv
         KGqOY62d281AD5v7Smv7ogdccrA6VF1FINPkUHM5WO/kPHavnoay7xnliIPZMKdkvlPp
         p08Si9AOcj8b1N+T+9zx3cAbmN/+Wek4lTC74JvCs5oKtYsYss0sPkp1N5/+rVmE/IDL
         PLsA==
X-Gm-Message-State: ACrzQf27UFiMaizh7Qh+o2h1hVyRnTb/kLK+O+063nVPfmswUOl6IlHv
        nDZoHLfs3RoeE058yf412S8Clw==
X-Google-Smtp-Source: AMsMyM4GKqAMJAAvwwgEdE6t9HOW5Z4eFfI2/AeOZaIj9u0+aquUf93vI+CcZOvQas4C2sEkS22rCQ==
X-Received: by 2002:a05:620a:1293:b0:6ee:dfb8:d448 with SMTP id w19-20020a05620a129300b006eedfb8d448mr6588764qki.510.1666044750690;
        Mon, 17 Oct 2022 15:12:30 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87951000000b0039cb9ef50b5sm672321qtt.26.2022.10.17.15.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 15:12:29 -0700 (PDT)
Message-ID: <6d9df544-b99e-4d62-53d1-1f3290d31a19@linaro.org>
Date:   Mon, 17 Oct 2022 18:12:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/5] dmaengine: qcom: gpi: document preferred SM6350
 binding
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Melody Olvera <quic_molvera@quicinc.org>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
 <20221015140447.55221-3-krzysztof.kozlowski@linaro.org>
 <20221017212320.4960-1-mailingradian@gmail.com>
 <801c902d-4e1a-6ddc-e050-afdc2514e687@linaro.org>
 <20221017220004.6234-1-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017220004.6234-1-mailingradian@gmail.com>
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

On 17/10/2022 18:00, Richard Acayan wrote:
>> On 17/10/2022 17:23, Richard Acayan wrote:
>>>> Devices with ee offset of 0x10000 should rather bind with SM6350
>>>> compatible, so the list will not unnecessarily grow for compatible
>>>> devices.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>  drivers/dma/qcom/gpi.c | 7 ++++---
>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>>>> index f8e19e6e6117..061add832295 100644
>>>> --- a/drivers/dma/qcom/gpi.c
>>>> +++ b/drivers/dma/qcom/gpi.c
>>>> @@ -2286,13 +2286,14 @@ static int gpi_probe(struct platform_device *pdev)
>>>>  }
>>>>  
>>>>  static const struct of_device_id gpi_of_match[] = {
>>>> -	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
>>>>  	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
>>>>  	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
>>>>  	/*
>>>> -	 * Deprecated, devices with ee_offset = 0 should use sdm845-gpi-dma as
>>>> -	 * fallback and not need their own entries here.
>>>
>>> This comment is from the dependency series [1]. Why would we need to add it just
>>> to remove it here? I was not notified that the dependency was applied anywhere
>>> (except as a base for other series) so it's not set in stone. Let's just drop
>>> the original patch that this comment originates from to prevent needlessly
>>> adding and removing the same lines at once.
>>
>> I don't remove the comment, I re-phrase it to be better suited for final
>> code.
> 
> Yes, I didn't word that exactly right. I still think the patch that adds this is
> now useless if it's just going to be replaced. Do you think I should keep the
> patch that this comment originates from, even though we already know exactly how
> its substantial contents will be replaced?
> 
> We can't modify history and drop commits on kernel trees, but I can still send
> a v6 series that drops the original comment.

Sure. You can make it then:

	 * Do not grow the list for compatible devices. Instead use
	 * qcom,sdm845-gpi-dma (for ee_offset = 0x0).

And my patch will just change one line.

We can also keep it like:

	 * Do not grow the list for compatible devices. Instead use
	 * proper fallback compatibles.

Best regards,
Krzysztof

