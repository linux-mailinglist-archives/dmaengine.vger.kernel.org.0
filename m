Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B0F50B027
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 08:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444249AbiDVGHe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 02:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444219AbiDVGH2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 02:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A203850063;
        Thu, 21 Apr 2022 23:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E12461DC5;
        Fri, 22 Apr 2022 06:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C216DC385A4;
        Fri, 22 Apr 2022 06:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650607475;
        bh=QVgdPhLPhkloXklN2o5gxk7tqYHTsj68+O0sLTDu7XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSizFBlFR69OnS+wshQn86Kwi7lObQGqB6M5j1bJRVTJssXo29VaMCsMIef1Kgryo
         zxpmZNTxbHBbqmhR6q0xOBFFpurXCdFs7xMCjq+kgVjfJADrqMrv4/jPuZuzeF6Eug
         7X+YLFUmIiWUMAZpIkFbO8oLsNt8Q9Zplg1qWl56aifrL/JKhluSVlanij1F+LRI6e
         tBF21OInNey2jcaDu5dDFgXHfMSU9M+oLbmG1F9gUr6b3xIKVbhuXikwd5/bjFlrvo
         aNSDZ0IoT0wZ0nQEEOhTJMT74SWG2JN8L6+F6S2xU9PrCfZXyK2yPvLeOgiuJ58hLQ
         IVH+5TT61itNQ==
Date:   Fri, 22 Apr 2022 11:34:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] dma: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <YmJFbxi2T9wvP1Ox@matsya>
References: <20220421084509.2615252-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421084509.2615252-1-lv.ruyi@zte.com.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-04-22, 08:45, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 

It is dmaengine: not dma:

Also add driver tag to subject line. git log would help you choosing
right tags

> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

Where is the report?

> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/dma/imx-sdma.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 6196a7b3956b..cf4667d10f6a 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2073,7 +2073,6 @@ static int sdma_probe(struct platform_device *pdev)
>  	const char *fw_name;
>  	int ret;
>  	int irq;
> -	struct resource *iores;
>  	struct resource spba_res;
>  	int i;
>  	struct sdma_engine *sdma;
> @@ -2096,8 +2095,7 @@ static int sdma_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	sdma->regs = devm_ioremap_resource(&pdev->dev, iores);
> +	sdma->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(sdma->regs))
>  		return PTR_ERR(sdma->regs);
>  
> -- 
> 2.25.1

-- 
~Vinod
