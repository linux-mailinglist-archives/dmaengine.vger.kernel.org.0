Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA474AAAD
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jul 2023 07:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGGFl1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Jul 2023 01:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjGGFl0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Jul 2023 01:41:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C981FC6;
        Thu,  6 Jul 2023 22:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E716172F;
        Fri,  7 Jul 2023 05:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD31C433C7;
        Fri,  7 Jul 2023 05:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688708484;
        bh=Xv11ogHIC9tpNiVOCkdq4KJKlOsPx5tdAth0FE01FVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdoELbJt3DWtec4gcjtVnyCEgA4H/Neqz9uDAgtpmr4CihEhPbNb5T7+Y0VKNwYIg
         fTz75+BglySlDpY82AMujWx0HxRjG7WaeOZRmlBcKo57MdON6rQ/X0N357+04QMIdd
         QmnVFTvPmsSsbcYHG6LZ7xjLHwgFpPHzeQQ9DQx9NVR05loncvLV8Jgl2eQfoflkju
         ltWz7HMQdfII/EyqurR0HEJgSwI+hlknvhz/NKDKeeMMWBn9VV7O3B8sGQO6adstmX
         nJT1Na9PnirOniCZpkVptlDCyTOzgffO+I+R6KuZbcdG9gONV5eBrb/NmDj5r9QxdP
         Yi7oKg7+LBxmQ==
Date:   Fri, 7 Jul 2023 11:11:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, joy.zou@nxp.com,
        shenwei.wang@nxp.com, imx@lists.linux.dev
Subject: Re: [PATCH v9 03/13] dmaengine: fsl-edma: clean up
 fsl_edma_irq_exit()
Message-ID: <ZKelf9T7QTPjZTHT@matsya>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
 <20230620201221.2580428-4-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620201221.2580428-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-23, 16:12, Frank Li wrote:
> In the probe function, devm_request_irq is now being used to automatically
> manage IRQ. It eliminates the need for manual IRQ freeing during removal.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/dma/fsl-edma-main.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index e40769666e39..16305bb9a2ef 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -216,17 +216,6 @@ fsl_edma2_irq_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> -static void fsl_edma_irq_exit(
> -		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
> -{
> -	if (fsl_edma->txirq == fsl_edma->errirq) {
> -		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> -	} else {
> -		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
> -		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
> -	}
> -}
> -
>  static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
>  {
>  	int i;
> @@ -427,7 +416,6 @@ static int fsl_edma_remove(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
>  
> -	fsl_edma_irq_exit(pdev, fsl_edma);

I would not agree, this code is a failsafe to ensure that irq is quiesced
and cant fire again while we are unrolling which also triggers a tasklet

We are better of with this change

>  	fsl_edma_cleanup_vchan(&fsl_edma->dma_dev);
>  	of_dma_controller_free(np);
>  	dma_async_device_unregister(&fsl_edma->dma_dev);
> -- 
> 2.34.1

-- 
~Vinod
