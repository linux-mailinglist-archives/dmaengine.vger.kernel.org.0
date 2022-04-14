Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC912500709
	for <lists+dmaengine@lfdr.de>; Thu, 14 Apr 2022 09:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbiDNHjI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 14 Apr 2022 03:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbiDNHjE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 14 Apr 2022 03:39:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12AC56C15
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 00:36:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v15so5220106edb.12
        for <dmaengine@vger.kernel.org>; Thu, 14 Apr 2022 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gy7AkBu7bAXBU0y3wAkFQ5PlduSnOoydEHQ9dHG0xqU=;
        b=zBKde8JUkVKVlpgHIy6ft1h9KyiEPQ8x3AXpkjobSHYAeGM6icbkw3E6IJ1RH6dqmM
         3KH6n20js6DSceg0j8p74wH7vBnBBOOPIZ29lWuNsWblzEdgYYFgW8WWqEJ7eISN9/z/
         ZNN1dLcvHHLV/cUhush3kMfQD/DqN/h1GsdB6f0mFFDPVNVh+yHYdl+Gifg2owlbDZ/l
         FiMC88SMJ8AyjGlVrPi77bCa8VKocDQ6I/n9+FbXZM/TepmI2WEIG1Tl+OZsdD8d/cTQ
         9YuFRB4IdpJ0gYAoXG6G8zGJ24xVlIrm/w2Od6J8laEpvkVhBYghr3EA7yRwIXftchCS
         U5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gy7AkBu7bAXBU0y3wAkFQ5PlduSnOoydEHQ9dHG0xqU=;
        b=xcqzfuA/MfTwVwl36NpZkTdETkVvLbr30TVRAlGSQsvVVc6y59QlX6t7stMKYRJkb8
         4ufctfp1lqucpdhBzMAICGBnmWC9RC2PetUCcoDiRozq+h3o+JOvsBrNdISDdoKifiAc
         3zzQ+8gDWFwQi750LCGrwGbURYvLnX7pLNt+JKt9TptWltXR+5zX5lKM/twFc+KzWldt
         kayB0c1J8grjcuHeHzQqlkJ+Hs8Aly2A/gIpMR7iV3+8H47BTFkJfBH41oVTEwllc7BB
         BXOH0fRdqTo1MG6Uzplv19UDkt0DB+/a8kuwE9/Uc3B/fuqa0Q2zqWYQcCueruk6ymLG
         RoGQ==
X-Gm-Message-State: AOAM532Vaxo/4xgPcIt1VKOrFeCa3ztOWDyDiUhb6wCpeR3tY4qFPoxI
        UOSzKdAi2WRSwvNttTjnWSA79g==
X-Google-Smtp-Source: ABdhPJxVkieNFrCUgPtdH8sa6eUkB8QCY/095ocDDMYsh57rFUNDZ8O3DDoHtABO6gVaXsAwHX4/fA==
X-Received: by 2002:a50:cc82:0:b0:41d:5fca:10c3 with SMTP id q2-20020a50cc82000000b0041d5fca10c3mr1563726edi.373.1649921798496;
        Thu, 14 Apr 2022 00:36:38 -0700 (PDT)
Received: from [192.168.0.209] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k22-20020a508ad6000000b00420bd71e06bsm653456edk.79.2022.04.14.00.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:36:38 -0700 (PDT)
Message-ID: <34a14968-e939-3e22-9385-e31be1a96bbd@linaro.org>
Date:   Thu, 14 Apr 2022 09:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: dmaengine: qcom: gpi: add compatible for
 sc7280
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414064216.1182177-1-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220414064216.1182177-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14/04/2022 08:42, Vinod Koul wrote:
> Document the compatible for GPI DMA controller on SC7280 SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
