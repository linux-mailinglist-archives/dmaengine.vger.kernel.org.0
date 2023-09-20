Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F987A8AE6
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 19:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjITRyU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 13:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjITRyT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 13:54:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A097583
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 10:54:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50336768615so257788e87.0
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695232452; x=1695837252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vog84xO4UDYfL4nqjzzOo8g+D9NDoUUJCHsjoh/YY0s=;
        b=GsEPcrDShCKhMmzBUH2yOPkA+NorKtM882iziPoXSYTKnN925+LTe10QFqjh5TeERy
         7dLO85ofIc4WWNoO+x22SgC5TJiwRNjcZFvRKykjYwrmgVtKJSOA5/i4yLaKF7bula/A
         x8PtXqT7iMu287YP9uTpjBXoapJIUKQwBOvpzuU/DABVZbhHbdpXvpJ6YvP603BpqOit
         r5sPZpNR+dgcWvYFNCB6A6KzfwlbS+jCh+QTTpLxHU5qaB0Ro3sfyr4cWDAoHKWY1g1C
         1/dipAQEjvPZhzvYruRPOKdOHjky1XDD0GEvIwBobzeAOEwBNkGhM4qP2PJvj37fvXLn
         NFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695232452; x=1695837252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vog84xO4UDYfL4nqjzzOo8g+D9NDoUUJCHsjoh/YY0s=;
        b=E0TEQrn54QdHwaclmo6+4Vh6tZXS76TtCb/RSbT1GyhZgsENp0ANktGeWgr9zesfIk
         hz5wex6lOJPNXJndfCONM0GdNP6JDHQiYOBkg1LwnQgom7a1NjY6ZRcmOS+LZIPPz4M2
         qwXIV/xYhukZ7VZ3TRasu+boE4kW6tMCinfxjhEPmVzXwQglQ8hlughEcuFiOq5rDzku
         TF07Tyhb9W+Kpia2LLa7nMWFjrpALGoih7OzKn9rohw/9AJn7RcEwgYupAAcfnuouAYb
         izHsIIp8x7Cok1EjJB+M4HKVirJAoaEuiA6QM6ZjvrqgXef3kYMtW6v+HEizq8+/M+Cp
         btjA==
X-Gm-Message-State: AOJu0YzW524h4SAlMhIa2Wo3+vsb49zy7E1LIm8UQaQqrdvkxbmvniGN
        XDHrUoIW83I4PjS8vsyLIiA=
X-Google-Smtp-Source: AGHT+IGF7NjIaKFUsZYwxigDIk89SYJ02kHua+If1SN6HQVFV0oYQA5w15qxGDqapI79BACC3l67Ww==
X-Received: by 2002:a05:6512:401e:b0:503:175e:f005 with SMTP id br30-20020a056512401e00b00503175ef005mr3961697lfb.38.1695232451618;
        Wed, 20 Sep 2023 10:54:11 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id o10-20020ac2494a000000b0050234d02e64sm1315334lfi.15.2023.09.20.10.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:54:11 -0700 (PDT)
Message-ID: <40f59ea8-3c56-4110-abcd-20cd6540b6e9@gmail.com>
Date:   Wed, 20 Sep 2023 20:54:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 51/59] dma: ti: edma: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-52-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230919133207.1400430-52-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/dma/ti/edma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index aa8e2e8ac260..3ed022918ec0 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2550,7 +2550,7 @@ static void edma_cleanupp_vchan(struct dma_device *dmadev)
>  	}
>  }
>  
> -static int edma_remove(struct platform_device *pdev)
> +static void edma_remove(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct edma_cc *ecc = dev_get_drvdata(dev);
> @@ -2568,8 +2568,6 @@ static int edma_remove(struct platform_device *pdev)
>  	edma_free_slot(ecc, ecc->dummy_slot);
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
> -
> -	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -2628,7 +2626,7 @@ static const struct dev_pm_ops edma_pm_ops = {
>  
>  static struct platform_driver edma_driver = {
>  	.probe		= edma_probe,
> -	.remove		= edma_remove,
> +	.remove_new	= edma_remove,
>  	.driver = {
>  		.name	= "edma",
>  		.pm	= &edma_pm_ops,

-- 
Péter
