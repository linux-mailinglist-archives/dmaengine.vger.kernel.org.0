Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2E604DBE
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJSQtM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 12:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJSQtK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 12:49:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E71A1C73C1;
        Wed, 19 Oct 2022 09:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0060EB824C7;
        Wed, 19 Oct 2022 16:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7471C433C1;
        Wed, 19 Oct 2022 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666198146;
        bh=1zhD6GeKgSstHb00mJlu4MbO8vG9BfJlQz73YmXarik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkD7RuvnEHkDnggb2aOBdyTek0f5t9C2/0BuWk1RFdCPVSC+dgYRQQAoGiTF1neCz
         hVwbdbkfjWZ6FvyHdXZAKqqE1bcTDt12S/d9lZpKlgZuN8XPrxKTPk6GVViqCNqJBW
         fMvcU5uFvJBKBckLMu31qvjD03HIqkMIqfP32iJ8KPEqjceWnh8+MUwk8HEsON3RcU
         lq1BDj8icWJTDSOgInBNkdORrTEYnMl2FMj93xb/H0rTc12U7zEhUOVzwMkqNZXLtq
         52tdLgCGZmfXSCMvKFUUoJ2+Ba6pWOrL0hpmcWW6a+NI4lOQunHcpW22mmTs4efnsB
         U2Yv5kJBXgARw==
Date:   Wed, 19 Oct 2022 22:19:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     peda@axentia.se, du@axentia.se, regressions@leemhuis.info,
        ludovic.desroches@microchip.com, maciej.sosnowski@intel.com,
        dan.j.williams@intel.com, nicolas.ferre@microchip.com,
        mripard@kernel.org, torfl6749@gmail.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 28/33] dmaengine: at_hdmac: Use devm_request_irq()
Message-ID: <Y1Aqfk9iusj51YzJ@matsya>
References: <20220820125717.588722-1-tudor.ambarus@microchip.com>
 <20220820125717.588722-29-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820125717.588722-29-tudor.ambarus@microchip.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-08-22, 15:57, Tudor Ambarus wrote:
> IRQs requested with this function will be automatically freed on driver
> detach. Use devm_request_irq() and make the code cleaner.

That is not really good idea!

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/dma/at_hdmac.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 9c414f167b62..96b885f83374 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -2241,6 +2241,10 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> +	err = devm_request_irq(&pdev->dev, irq, at_dma_interrupt, 0,
> +			       dev_name(&pdev->dev), atdma);
> +	if (err)
> +		return err;
>  
>  	/* discover transaction capabilities */
>  	atdma->dma_device.cap_mask = plat_dat->cap_mask;
> @@ -2257,10 +2261,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  	/* force dma off, just in case */
>  	at_dma_off(atdma);
>  
> -	err = request_irq(irq, at_dma_interrupt, 0, "at_hdmac", atdma);
> -	if (err)
> -		goto err_irq;

here you are ready to receive the irq, but now you moved it early on..
it may cause issues..

> -
>  	platform_set_drvdata(pdev, atdma);
>  
>  	/* create a pool of consistent memory blocks for hardware descriptors */
> @@ -2377,8 +2377,6 @@ static int __init at_dma_probe(struct platform_device *pdev)
>  err_memset_pool_create:
>  	dma_pool_destroy(atdma->dma_desc_pool);
>  err_desc_pool_create:
> -	free_irq(platform_get_irq(pdev, 0), atdma);
> -err_irq:
>  	clk_disable_unprepare(atdma->clk);
>  err_clk_prepare:
>  	clk_put(atdma->clk);
> @@ -2397,7 +2395,6 @@ static int at_dma_remove(struct platform_device *pdev)
>  
>  	dma_pool_destroy(atdma->memset_pool);
>  	dma_pool_destroy(atdma->dma_desc_pool);
> -	free_irq(platform_get_irq(pdev, 0), atdma);

Now we have an active irq while we are unrolling device, which can be
fired and cause tasklet to also get scheduled...

You need to make sure now irq cant fire here and tasklet is killed..

>  
>  	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
>  			device_node) {
> -- 
> 2.25.1

-- 
~Vinod
