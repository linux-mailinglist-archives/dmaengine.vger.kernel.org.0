Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158697A8AE8
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 19:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjITRyn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 13:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjITRyl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 13:54:41 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73BB9
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 10:54:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50309daf971so226935e87.3
        for <dmaengine@vger.kernel.org>; Wed, 20 Sep 2023 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695232473; x=1695837273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Eya/p6rhXz7EqlvBpc7WNwGyylNzMHi0+yXv4rTPdc=;
        b=dOXKxE0lyHrFTro9gc3+T9yfAu1myboM7IyPdZTpP4n4oUi4nK1+S7aKpxM0Y+eO0a
         OmdevEPZ7NGkfN1VCZRcw1N/IhgAJ4gCdfWMQubVpNsGEFEK4vzFAs08qJvlePobFs9P
         EkoEMBHPldQqM2aVn0GQXJGy0nYHKZ9sU6Gli/tmYKfnnxqODG2T6NTveI2vNgR+hMzS
         oHAkX/kzYPDPrUJsjheJ/DJNwybWFBtyWtaOCiilcPMbg5MKyJOkvWDLRGOGDuqwTRpc
         6Q43xbnkzBIDlszF14z22HHY00D8l9Ko04F5sxjkSdl5qM29W6meU6Xx3rMFNnt9QXOC
         I2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695232473; x=1695837273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Eya/p6rhXz7EqlvBpc7WNwGyylNzMHi0+yXv4rTPdc=;
        b=jvdL7+hP7kQ0K1nnHDSzMQSaX/vuEQG9QMIaVH8mU+xtWSYibpL6fZfBsNE30v+NxF
         pcHvvBBwQrSneHlfaJh6LONvILayo+8AI91T6lOrzVgGcmN3x2jGXlzdJsdOFUlEYDhX
         GkH8xpQ2KiED1VNNcIIiMAlchgDcSNeYDw8RNWZxqtaGjEJlSKRXVtA6omgSa0UpDe73
         RXlpHmLuOY6HqnT10bJSGmfB5zjBqbt13bpIqzMfxxPSqrK5hqTOyBz9YoaBkfBrNjXa
         Y3lTBrJFzv9Sk+vE6bVT1+y3tr958RtuMWjBnC4b0vvRsxn3WpXeMIazuy2AmggUUwDw
         Oo9w==
X-Gm-Message-State: AOJu0Yx+5BOD23L75wLFRGQJWKyyEvqLqNUM46g854AdZSx869mu2mMm
        DsL7eYhCRm8wYHt1ljQRw7QWtzClOOmlIcRS
X-Google-Smtp-Source: AGHT+IHeTIUREUl7OPcm0kG9exVdG1imcK6VlAn8zJjklAGMaVN5xYJ9Yr4bRyTF+dBYXYS0O/+G5Q==
X-Received: by 2002:a05:6512:3987:b0:4fb:820a:f87f with SMTP id j7-20020a056512398700b004fb820af87fmr3922766lfu.10.1695232473262;
        Wed, 20 Sep 2023 10:54:33 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id o10-20020ac2494a000000b0050234d02e64sm1315334lfi.15.2023.09.20.10.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:54:32 -0700 (PDT)
Message-ID: <024831a9-34a4-4c61-ab4a-33384f51836d@gmail.com>
Date:   Wed, 20 Sep 2023 20:54:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 52/59] dma: ti: omap-dma: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, kernel@pengutronix.de
References: <20230919133207.1400430-1-u.kleine-koenig@pengutronix.de>
 <20230919133207.1400430-53-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230919133207.1400430-53-u.kleine-koenig@pengutronix.de>
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



On 9/19/23 16:32, Uwe Kleine-König wrote:
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
>  drivers/dma/ti/omap-dma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index cf96cf915c0c..76db0fc19524 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1844,7 +1844,7 @@ static int omap_dma_probe(struct platform_device *pdev)
>  	return rc;
>  }
>  
> -static int omap_dma_remove(struct platform_device *pdev)
> +static void omap_dma_remove(struct platform_device *pdev)
>  {
>  	struct omap_dmadev *od = platform_get_drvdata(pdev);
>  	int irq;
> @@ -1869,8 +1869,6 @@ static int omap_dma_remove(struct platform_device *pdev)
>  		dma_pool_destroy(od->desc_pool);
>  
>  	omap_dma_free(od);
> -
> -	return 0;
>  }
>  
>  static const struct omap_dma_config omap2420_data = {
> @@ -1918,7 +1916,7 @@ MODULE_DEVICE_TABLE(of, omap_dma_match);
>  
>  static struct platform_driver omap_dma_driver = {
>  	.probe	= omap_dma_probe,
> -	.remove	= omap_dma_remove,
> +	.remove_new = omap_dma_remove,
>  	.driver = {
>  		.name = "omap-dma-engine",
>  		.of_match_table = omap_dma_match,

-- 
Péter
