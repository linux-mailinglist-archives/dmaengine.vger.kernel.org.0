Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CF47B142D
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 09:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjI1HKb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 03:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjI1HKM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 03:10:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974C5448D
        for <dmaengine@vger.kernel.org>; Thu, 28 Sep 2023 00:09:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690d2441b95so9650463b3a.1
        for <dmaengine@vger.kernel.org>; Thu, 28 Sep 2023 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695884948; x=1696489748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bP9Yd/TSRhU9ZRBkQP4uyYzEOg348TN4GSZsv2VRnS4=;
        b=Gbx+VzU6by5QJwcfmZKFLDnnhHeLr9LviDIlhiLRO0a7K++zBxbsbfXzX3GFZXGMnv
         fozosmft2pZq+RLwLVfDtzVdA6s7fr9XZtIimpRNy0gjdInBZXesSKvX4lU7uBByAD93
         whb9PK7yPLCP16R5K/dtShiV2JGt0bmb3K752sc+AAM/HlljIhXRiEmsWsRbd7IQN1Ro
         dE7yEmYKjNVBAxO4LdyzcltHE+cRxAqjHlS3ARibtOLaJQ8OEo/wtsLfrtD88sqNhPie
         3sxrmkqOQC4QK63KgmvQAOudWy85u3KO07c48qHrcVqaSm9SzkVIVwPAl3btB4NsWWje
         vD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695884948; x=1696489748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bP9Yd/TSRhU9ZRBkQP4uyYzEOg348TN4GSZsv2VRnS4=;
        b=iO54NU9UiIwMVqJ3MqzAWK3zy5r4+yIbKHnV2D33w/7LFpq5E/4Np4CO5UHKUIJI2B
         pt8bzydzRG5X4A1RqSsTsdCr/QbjgWkmhmfEPnTP+qsg1pFvCMTJB5ZZOy4K8AYLD9G0
         SHmPqr8eiTDVCMGtts6LCJ1oRkkPDmW1B1KpC7FLbeGZB7zX9klH5mQlEBiDbM4rfXfR
         Eh/4SITfduMN8RTlieXQHburwr+26foacmi72SMLBIqpx4YWCjYqjgAG6yW3M0WbJpJV
         wcQcqAfDjzQqIOXCNKjJoIMpM5uPLMF50Iq+P+mXpWZqozRY90vlHQfCQriWwwOTt26s
         q7MQ==
X-Gm-Message-State: AOJu0YzpjymdUsdyIHSBVHpxTi8ov1cD9xzA2hVfDqxLlD5jz4+y9/ls
        AMDEy3K3fSQk9vHzTb9bY0IYc081XesBSpmJkkE=
X-Google-Smtp-Source: AGHT+IE2+dQMExD0VfgQtYafARd83rDcIBJbzJABj2M93lcE63IX8nq+vXwjT3wD9UWqwk1iBJeaNw==
X-Received: by 2002:a05:6a20:5529:b0:15e:b253:269f with SMTP id ko41-20020a056a20552900b0015eb253269fmr420436pzb.28.1695884948083;
        Thu, 28 Sep 2023 00:09:08 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id 9-20020aa79249000000b00690c9fda0fesm12649747pfp.169.2023.09.28.00.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 00:09:07 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:39:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 11/59] dma: dw: platform: Convert to platform remove
 callback returning void
Message-ID: <20230928070905.7ejspn55rx36rg6i@vireshk-i7>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-12-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919133207.1400430-12-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-09-23, 15:31, Uwe Kleine-König wrote:
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
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/dma/dw/platform.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw/platform.c b/drivers/dma/dw/platform.c
> index 47f2292dba98..7d9d4c951724 100644
> --- a/drivers/dma/dw/platform.c
> +++ b/drivers/dma/dw/platform.c
> @@ -93,7 +93,7 @@ static int dw_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static int dw_remove(struct platform_device *pdev)
> +static void dw_remove(struct platform_device *pdev)
>  {
>  	struct dw_dma_chip_pdata *data = platform_get_drvdata(pdev);
>  	struct dw_dma_chip *chip = data->chip;
> @@ -109,8 +109,6 @@ static int dw_remove(struct platform_device *pdev)
>  
>  	pm_runtime_disable(&pdev->dev);
>  	clk_disable_unprepare(chip->clk);
> -
> -	return 0;
>  }
>  
>  static void dw_shutdown(struct platform_device *pdev)
> @@ -193,7 +191,7 @@ static const struct dev_pm_ops dw_dev_pm_ops = {
>  
>  static struct platform_driver dw_driver = {
>  	.probe		= dw_probe,
> -	.remove		= dw_remove,
> +	.remove_new	= dw_remove,
>  	.shutdown       = dw_shutdown,
>  	.driver = {
>  		.name	= DRV_NAME,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
