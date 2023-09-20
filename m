Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4A87A8B51
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 20:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjITSNR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjITSNP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 14:13:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F9AC6
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 11:13:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso3527466b.2
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695233588; x=1695838388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eebm0bZ8oIw7YLEe3SWSGOgHuxHYKcqJneb0xHoiFbw=;
        b=OuzBHtkk6CArUWPd8+xXlagGjWfgIAYGJ/P3nC89+/g4nJFrZtwR2OQoRyvyfwyRsh
         oPwNgRj6WlB4/zmFXCobolQycLBvlUt6+QXLPmWRX8duv1XoyKNE3d8+LJs5pjklJI9M
         waFc8e2wkZRuItvMb1k6zl7CufJNKSFcxZV92tN0eNCozP6yy+JmXtlmdr0F2rIjGpov
         T/Sif159i07sXb8kahY9+Zn20aBGCas9Z0J+xBh8LI9taj408ODOKfUT2Bg3M1QO+9Xf
         I6P2fM8Rab1ryPc2Cvwhat6lZ4or3hiJqRAitJUiUSXSVqEk2JbP8i+r+7UB+5adn/7v
         1++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233588; x=1695838388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eebm0bZ8oIw7YLEe3SWSGOgHuxHYKcqJneb0xHoiFbw=;
        b=jwXpoCqBxExrZF/OCrmLdUpgmgUGUTAbdE2xTKklutq99uRsBfVUggAn/lmG0qxn2B
         wXCysdNBBxiHk0VneRwKVsoXCvUdlIYxaHIoYr0ed+DMe91ZvVeIZp+5fP6ldGW/b2XQ
         tzUtG4P1m4pM2UKxUCsB/nR/E5qhXV2f+ZIBXg+efUVTUBSQlusdITNw/iACwy4o+ljr
         OWhYe5sgjBiIWDKR7C0dF59EkOWf/Qo/T0kaBeaVF4UWFmCCXbteH9FR1zGC7MtB4ORZ
         rOzJoLDFPV3jZ6YTH/1nhwYnlDSPkOFB0hurppuyWKvxtXD6dMin9ATFnPCNTaKdU2YD
         mI9w==
X-Gm-Message-State: AOJu0Yx2WlhFeZoiiSb2FBJEQTYsOt4st0vP61R7Z9WEm7FDbsI26UOO
        ZZ1nIfJk4U1PJRcxJJCmv5U=
X-Google-Smtp-Source: AGHT+IFmUoTGoZLbonvpotWJoCY+mvgELA7UGLMrgARAQyS1PPaVkHtctkkqhpmmGKcfFMo3UHKogg==
X-Received: by 2002:a17:907:272a:b0:9a1:c502:b7d2 with SMTP id d10-20020a170907272a00b009a1c502b7d2mr2510961ejl.67.1695233587988;
        Wed, 20 Sep 2023 11:13:07 -0700 (PDT)
Received: from freebase (190-2-133-229.hosted-by-worldstream.net. [190.2.133.229])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906240f00b0099bd1ce18fesm9848205eja.10.2023.09.20.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 11:13:07 -0700 (PDT)
Date:   Wed, 20 Sep 2023 20:13:05 +0200
From:   Olivier Dautricourt <olivierdautricourt@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 01/59] dma: altera-msgdma: Convert to platform remove
 callback returning void
Message-ID: <ZQs2MQPhgGU3qrRw@freebase>
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919133207.1400430-2-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 19, 2023 at 03:31:09PM +0200, Uwe Kleine-König wrote:
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

Acked-by: Olivier Dautricourt <olivierdautricourt@gmail.com>

Thanks

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/dma/altera-msgdma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 4153c2edb049..a8e3615235b8 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -923,7 +923,7 @@ static int msgdma_probe(struct platform_device *pdev)
>   *
>   * Return: Always '0'
>   */
> -static int msgdma_remove(struct platform_device *pdev)
> +static void msgdma_remove(struct platform_device *pdev)
>  {
>  	struct msgdma_device *mdev = platform_get_drvdata(pdev);
>  
> @@ -933,8 +933,6 @@ static int msgdma_remove(struct platform_device *pdev)
>  	msgdma_dev_remove(mdev);
>  
>  	dev_notice(&pdev->dev, "Altera mSGDMA driver removed\n");
> -
> -	return 0;
>  }
>  
>  #ifdef CONFIG_OF
> @@ -952,7 +950,7 @@ static struct platform_driver msgdma_driver = {
>  		.of_match_table = of_match_ptr(msgdma_match),
>  	},
>  	.probe = msgdma_probe,
> -	.remove = msgdma_remove,
> +	.remove_new = msgdma_remove,
>  };
>  
>  module_platform_driver(msgdma_driver);
> -- 
> 2.40.1
> 
