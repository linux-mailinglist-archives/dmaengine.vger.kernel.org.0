Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC78B5EB06D
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 20:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiIZSpL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 14:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiIZSop (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 14:44:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A989FDD;
        Mon, 26 Sep 2022 11:43:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j16so12316703lfg.1;
        Mon, 26 Sep 2022 11:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rRJ44Z2TX288yMrnSrkrRyEiDyacpZBDYBKuFx6X4sU=;
        b=naPg2JaAG1fG4AtFV5gayR79vs77brYXjsKVbtw3+Dt4nNjA2oS+zhLlIv4POoS9ak
         X3NFeNAechadRmuggYjqLkpFcB87U/QKe+GNSYULh+oeg7Bp1DGf7bOzJzKNiSqlItPR
         +Tjw8TJdG3SoSvIm+sAdr7W+czxys3PDBiP0/BvXRFQAyHHIxERmPCLBQgb9Eg6C87tm
         z4gIW8t4v8yYnkgWJN7u8TV2aJiR24Eiw3uHxMPyLgZEW150ejd8jOhbBsSA+uNWTj2V
         6v4pM/JGApy2ZzcOXNn6Ts7zTbmBFu2nH4W7DaGUuvLGdkSQSGaEeHKz5j9hp/RFlVbF
         VAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rRJ44Z2TX288yMrnSrkrRyEiDyacpZBDYBKuFx6X4sU=;
        b=S0VsAknNlETbt8jP9COyMonrC48FxLFkEwZCy9gCqo44Gf5dS/iK1zpQd6MKTB1lRT
         jgt1EyJG1RsUKDelLYx6ieh9ivi2Wt0Wa6kmRZSA6n5Cg/IiWGVROgyu8JiLzgPwn7ff
         EbtanduxDHf2859ws2/doYPELjvIfooJeRiPwYhriS4wx7Yh0BFmCf1hAycOU7qD3NgE
         wXcQG1o4PkRAgDKWVWgQ6h5qiQQCyKSYy97TvFY43uDiZdkV6QM0uPNdJ//axLEDHw1k
         yC6/vhf9PZBhrIb+QOrH95r0k3ftYv6wXd4vJXx7mubC/pCxff1NeQQgBQtvHvlXSZgo
         DLWQ==
X-Gm-Message-State: ACrzQf108y4jo/YoMdduoM2eXuJN9lhy7wpU0Z71/EjAsNQax9bPPppU
        zDFnY2kdD1SBwGBVTqSVH+Q=
X-Google-Smtp-Source: AMsMyM4DNdayqjG4b6vFSIA8TyVdb/tkPuOYISyGSR+6fFnG1xWgENsMRD5DuBCMf9RQWYdoACINJg==
X-Received: by 2002:a05:6512:32c7:b0:49f:53f2:a51a with SMTP id f7-20020a05651232c700b0049f53f2a51amr10431749lfg.236.1664217836681;
        Mon, 26 Sep 2022 11:43:56 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id t26-20020a2e9d1a000000b0026c297a9e11sm2424244lji.133.2022.09.26.11.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 11:43:56 -0700 (PDT)
Message-ID: <11cf284c-d0d6-0687-b70b-2245ff8d6fcd@gmail.com>
Date:   Mon, 26 Sep 2022 21:52:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/3] dma/ti: convert k3-udma to module
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>, dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
 <20220926181848.2917639-3-khilman@baylibre.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220926181848.2917639-3-khilman@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/26/22 21:18, Kevin Hilman wrote:
> Currently k3-udma driver is built as separate platform drivers with a
> shared probe and identical code path, just differnet platform data.
> 
> To enable to build as module, convert the separate platform driver
> into a single module_platform_driver with the data selection done via
> compatible string and of_match.  The separate of_match tables are also
> combined into a single table to avoid the multiple calls to
> of_match_node()
> 
> Since all modern TI platforms using this are DT enabled, the removal
> of separate platform_drivers shoul should nave no functional change.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  drivers/dma/ti/Kconfig        |  4 ++--
>  drivers/dma/ti/k3-udma-glue.c |  5 ++++-
>  drivers/dma/ti/k3-udma.c      | 40 +++++------------------------------
>  3 files changed, 11 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
> index 79618fac119a..f196be3b222f 100644
> --- a/drivers/dma/ti/Kconfig
> +++ b/drivers/dma/ti/Kconfig
> @@ -35,7 +35,7 @@ config DMA_OMAP
>  	  DMA engine is found on OMAP and DRA7xx parts.
>  
>  config TI_K3_UDMA
> -	bool "Texas Instruments UDMA support"
> +	tristate "Texas Instruments UDMA support"
>  	depends on ARCH_K3
>  	depends on TI_SCI_PROTOCOL
>  	depends on TI_SCI_INTA_IRQCHIP
> @@ -48,7 +48,7 @@ config TI_K3_UDMA
>  	  DMA engine is used in AM65x and j721e.
>  
>  config TI_K3_UDMA_GLUE_LAYER
> -	bool "Texas Instruments UDMA Glue layer for non DMAengine users"
> +	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
>  	depends on ARCH_K3
>  	depends on TI_K3_UDMA
>  	help
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index 4fdd9f06b723..c29de4695ae7 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -6,6 +6,7 @@
>   *
>   */
>  
> +#include <linux/module.h>
>  #include <linux/atomic.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> @@ -1433,4 +1434,6 @@ static int __init k3_udma_glue_class_init(void)
>  {
>  	return class_register(&k3_udma_glue_devclass);
>  }
> -arch_initcall(k3_udma_glue_class_init);
> +
> +module_init(k3_udma_glue_class_init);
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 2f0d2c68c93c..7239ff31c8c5 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> @@ -4318,18 +4319,10 @@ static const struct of_device_id udma_of_match[] = {
>  		.compatible = "ti,j721e-navss-mcu-udmap",
>  		.data = &j721e_mcu_data,
>  	},
> -	{ /* Sentinel */ },
> -};
> -
> -static const struct of_device_id bcdma_of_match[] = {
>  	{
>  		.compatible = "ti,am64-dmss-bcdma",
>  		.data = &am64_bcdma_data,
>  	},
> -	{ /* Sentinel */ },
> -};
> -
> -static const struct of_device_id pktdma_of_match[] = {
>  	{
>  		.compatible = "ti,am64-dmss-pktdma",
>  		.data = &am64_pktdma_data,
> @@ -5254,14 +5247,9 @@ static int udma_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	match = of_match_node(udma_of_match, dev->of_node);
> -	if (!match)
> -		match = of_match_node(bcdma_of_match, dev->of_node);
>  	if (!match) {
> -		match = of_match_node(pktdma_of_match, dev->of_node);
> -		if (!match) {
> -			dev_err(dev, "No compatible match found\n");
> -			return -ENODEV;
> -		}
> +		dev_err(dev, "No compatible match found\n");
> +		return -ENODEV;
>  	}
>  	ud->match_data = match->data;
>  
> @@ -5494,27 +5482,9 @@ static struct platform_driver udma_driver = {
>  	},
>  	.probe		= udma_probe,
>  };
> -builtin_platform_driver(udma_driver);
>  
> -static struct platform_driver bcdma_driver = {
> -	.driver = {
> -		.name	= "ti-bcdma",
> -		.of_match_table = bcdma_of_match,
> -		.suppress_bind_attrs = true,
> -	},
> -	.probe		= udma_probe,
> -};
> -builtin_platform_driver(bcdma_driver);
> -
> -static struct platform_driver pktdma_driver = {
> -	.driver = {
> -		.name	= "ti-pktdma",
> -		.of_match_table = pktdma_of_match,
> -		.suppress_bind_attrs = true,
> -	},
> -	.probe		= udma_probe,
> -};
> -builtin_platform_driver(pktdma_driver);
> +module_platform_driver(udma_driver);

I did liked the 'hack' that the dev_* prints contained the actual type
of the DMA (udma/bcdma/pktdma), but it is not working via modules,
unless the driver init parts are split out and the bulk is kept as a
library.
I had this half way implemented in my wip, but never got the chance to
finalize it.

But, one can get the info via the address, so...

> +MODULE_LICENSE("GPL v2");
>  
>  /* Private interfaces to UDMA */
>  #include "k3-udma-private.c"

-- 
Péter
