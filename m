Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C052B36D
	for <lists+dmaengine@lfdr.de>; Wed, 18 May 2022 09:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiERHPP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 May 2022 03:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiERHPN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 May 2022 03:15:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FFE111B9A
        for <dmaengine@vger.kernel.org>; Wed, 18 May 2022 00:15:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l19so1426774ljb.7
        for <dmaengine@vger.kernel.org>; Wed, 18 May 2022 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=gxNp7wo0EZOb9E1oU3VMuWuT9HM6AfJUFpl0839G+5s=;
        b=tKXG6V85D2IceWP9CGx1Vc1gGzqurlyZq7Oah63v/H7nSicVwXlhdnL588nU1vOKcB
         xzu9ZZllIl8ae9KUaRi0UpDLfZCZWB0bbqLDdOMlzeusYmZkHfOuxDC0qJAvvxRrHIyG
         uqrc/xMkLN942zfAiH4pYrzsaJgq/AbAaMjvLiqLeAjR3nCJ/YpSndJec3HJ/fUbobra
         kNMrylw8k4PYqTt4eq70W8h2IB/hUNAEuW9Ey3e8hmGKVRagJE9dGPpeAFocatr9fm20
         F6MDGl37XtMVV3P20vp3flUxfUTzOad2mIjAKMb+a7gMHFZ9PBvJ2iY37+bOPnSmTnFx
         +gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gxNp7wo0EZOb9E1oU3VMuWuT9HM6AfJUFpl0839G+5s=;
        b=w6het9uAU/LRb8QrFEiPhiPW4nl5Ob84eJxAWqHj6rHGFIk61wPfY7sUc7cmcY/v4f
         zhZOyyr0wPASAowEUimiUaWPhrI7xfbJ+Ra9w8Us+FYTy6kfc1DHPYTWpOlus8QzcRbf
         EE0jvQOTS4kznAxhsLBmUBSy2lDfMXn3L2ZIYcjGvZrLNI6N2fJAzxrDn9LwUiNrctXL
         wNhNvT2uUW5In/mIPNbvxLQrz4yxJXifa/Qc5YNnpCT0XsQc0vVcoOyI57b11YH3TMZC
         ujO876ogHbbl7q7yPPGFk/1QOimZpjH3MKXuXD1EjuBz7TNAT1StlK9oa+toMP26HMF+
         zpwg==
X-Gm-Message-State: AOAM530sxegYpy8gxWjvANd4q7JMZsZ9EANl74u1cr56kuxrQOYDLZIH
        aDzFSkNfgU02QbLImnWg9fOmAQ==
X-Google-Smtp-Source: ABdhPJwURjJVQZqzoLW8bTWlGprlMgYzVTATCzQl9kCMuCP3oIFU+YXs2kBOcrsE0DtsAebLjZHIxw==
X-Received: by 2002:a2e:96d3:0:b0:24f:11ea:2118 with SMTP id d19-20020a2e96d3000000b0024f11ea2118mr16352095ljj.316.1652858110428;
        Wed, 18 May 2022 00:15:10 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v9-20020a197409000000b0047255d21101sm123190lfe.48.2022.05.18.00.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:15:09 -0700 (PDT)
Message-ID: <02e9ba1a-852b-b2b9-209e-4c819f86dc34@linaro.org>
Date:   Wed, 18 May 2022 09:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/4] dmaengine: ste_dma40: Remove unneeded ERROR and NULL
 check in ste_dma40
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220516084139.8864-1-wanjiabing@vivo.com>
 <20220516084139.8864-4-wanjiabing@vivo.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220516084139.8864-4-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16/05/2022 10:41, Wan Jiabing wrote:
> clk_put() already checks ERROR by using IS_ERR.
> clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
> Remove unneeded NULL check for clk_ret and ERROR check for clk.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/dma/ste_dma40.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index e1827393143f..7d1bf4ae4495 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -3119,7 +3119,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
>  	clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(clk)) {
>  		d40_err(&pdev->dev, "No matching clock found\n");
> -		goto check_prepare_enabled;
> +		goto disable_unprepare;

This should be rather return PTR_ERR. No need to jump to labels which
are not relevant (even if harmless) for this case. It's a confusing code.

>  	}
>  
>  	clk_ret = clk_prepare_enable(clk);
> @@ -3305,12 +3305,10 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
>  	iounmap(virtbase);
>   release_region:
>  	release_mem_region(res->start, resource_size(res));
> - check_prepare_enabled:
> -	if (!clk_ret)
>   disable_unprepare:
> -		clk_disable_unprepare(clk);
> -	if (!IS_ERR(clk))
> -		clk_put(clk);
> +	clk_disable_unprepare(clk);
> +	clk_put(clk);
> +
>  	return NULL;
>  }
>  


Best regards,
Krzysztof
