Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AA07A8AEC
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjITRzS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjITRzR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 13:55:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B38AD7
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 10:55:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-503f39d3236so268393e87.0
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695232509; x=1695837309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BwLNGi1b5LgRRhdnNgQMVamNH66BILKFFpEBt14Cs0=;
        b=E1pKztDqfU5PyLwSYjovAYBUcxWSDR+wBzZdbwZoHcnYNLD+2EuImohFBclZI+FOBO
         u4UpV4mIGJbKaGCZxWmHx8xgO9COc7K+b2xEm6WbQ7NqPDGtaY5aJVGoDEXS1efBaSrD
         lgN5C1m9qyYLhg6MQIvMkDFiQyzJFZdCgzaEGkVHrn5lhVofpct361E1IZ9dG3t+t6Zs
         23xU3EYON2jF87VyjcfOX7qSJkA7SC99LYxDyVBMXd+Nx5VMohfRcNB04knTQp45HukK
         0KKtyxD1UTp3BAiq4fjKfO2JLmF4Q9mMGqBKIkEbUEc7JofeV4/PWwZN+6fG03zdRH1W
         MtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695232509; x=1695837309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BwLNGi1b5LgRRhdnNgQMVamNH66BILKFFpEBt14Cs0=;
        b=GDdX5ciFDiU0K/+JhUAVtrysj0q1UvyA21AEqlviGn++yLT0mxH3tk/g3pg9M1PlRW
         KYHrG+P5Sed88k1qryXqYtvWiCmWYfro0IrSv5NlXTXwGj77JfIfrEUWhEIsgEbw6FqN
         FeeSDmgapvhM1FAkEIcjXCOpCv4tvRFRq+IeZZQTxAsCAI9yZpwjFd1+3MhDeNfb7b6I
         2eofel0gWDE2jJ9xbXFoKDoAw7v7JKqZo+QQ1xAgGQuAbRw59QPypWba4gTmsGCaR1X+
         PYA0sJrzj9oL6yPL5+yqg2IW822j7L2fXibz0GSDRgmFewmXXtMwfknBP3PCg+6T5pLS
         oJPQ==
X-Gm-Message-State: AOJu0YzkiRC7AuUbnFrJpBoW7PJ/PobGPKyLcifJRa0GhO66La30OWFG
        +YJzovhPeQiAfPf8NmpCa/8=
X-Google-Smtp-Source: AGHT+IGTIiAnimfngaqjhaaJ0Uoeoa26zUF6G6uqsC4ZyOV1n0+IW6KUT5sHy4I4FMI2vp9ZbqOidg==
X-Received: by 2002:a05:6512:3586:b0:503:3278:3225 with SMTP id m6-20020a056512358600b0050332783225mr2722747lfr.63.1695232509143;
        Wed, 20 Sep 2023 10:55:09 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id o10-20020ac2494a000000b0050234d02e64sm1315334lfi.15.2023.09.20.10.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:55:08 -0700 (PDT)
Message-ID: <48459e11-9aff-49fe-bb7e-879d75dcccbe@gmail.com>
Date:   Wed, 20 Sep 2023 20:55:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 50/59] dma: ti: cppi41: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-51-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230919133207.1400430-51-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/19/23 16:31, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/dma/ti/cppi41.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
> index c3555cfb0681..7e0b06b5dff0 100644
> --- a/drivers/dma/ti/cppi41.c
> +++ b/drivers/dma/ti/cppi41.c
> @@ -1156,7 +1156,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int cppi41_dma_remove(struct platform_device *pdev)
> +static void cppi41_dma_remove(struct platform_device *pdev)
>  {
>  	struct cppi41_dd *cdd = platform_get_drvdata(pdev);
>  	int error;
> @@ -1173,7 +1173,6 @@ static int cppi41_dma_remove(struct platform_device *pdev)
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> -	return 0;
>  }
>  
>  static int __maybe_unused cppi41_suspend(struct device *dev)
> @@ -1244,7 +1243,7 @@ static const struct dev_pm_ops cppi41_pm_ops = {
>  
>  static struct platform_driver cpp41_dma_driver = {
>  	.probe  = cppi41_dma_probe,
> -	.remove = cppi41_dma_remove,
> +	.remove_new = cppi41_dma_remove,
>  	.driver = {
>  		.name = "cppi41-dma-engine",
>  		.pm = &cppi41_pm_ops,

-- 
Péter
