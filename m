Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C10B5EEF25
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 09:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiI2Hfh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 03:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiI2Hfd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 03:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B5B24AA;
        Thu, 29 Sep 2022 00:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B8AD62061;
        Thu, 29 Sep 2022 07:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E42C433C1;
        Thu, 29 Sep 2022 07:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664436931;
        bh=w8sJ2aK2xXxhf+av8iYHPcJJb02anv8Gm2kYalcXmG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPbJBbT6nFJF6TlfilrR/VeMWyzuU7XF5DB7MXMJjZPE1raOmnEZyWd86dsXdqzRH
         6319F3k3MTvZ+C17cm23MYjS4KnEtdZ9fwconk+gtSaRa6jr9IsXvzefr27k+fTNjP
         uiNYQ81UuaBnfE73pmE2ajNQBuAKMq9nUEyEijRBiAUavFSQGNTeIv2Mtwnj3bAMTb
         dy7lTPFjuGExyRhqagTJRQhxXnkLifpuMy51dzyxL1vnfD+es2OTLfRPWVtmC2Xsox
         Y5LcAyAUNXzFMZs6WctogBJ7G9loegDG07yOX5LRg/rCyVNsM+ZAY0ddPhc6aWcdHV
         Pv60cEcj4zkMw==
Date:   Thu, 29 Sep 2022 13:05:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: Re: [PATCH v2 2/3] dma/ti: convert k3-udma to module
Message-ID: <YzVKv8zJDU0Sm0Iu@matsya>
References: <20220927230804.4085579-1-khilman@baylibre.com>
 <20220927230804.4085579-3-khilman@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927230804.4085579-3-khilman@baylibre.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-09-22, 16:08, Kevin Hilman wrote:
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

drop extra shoul

Please change subsystem tag to dmaengine: ti: xxxx for this and next
patch

> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>                                                                                                                            

this has trailing whitespaces, maybe copy paste error


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
> +MODULE_LICENSE("GPL v2");
>  
>  /* Private interfaces to UDMA */
>  #include "k3-udma-private.c"
> -- 
> 2.34.0

-- 
~Vinod
