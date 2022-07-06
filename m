Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921F0567DDF
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 07:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiGFFgC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 01:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiGFFgB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 01:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E71E21830
        for <dmaengine@vger.kernel.org>; Tue,  5 Jul 2022 22:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09F6C61D02
        for <dmaengine@vger.kernel.org>; Wed,  6 Jul 2022 05:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0E6C3411C;
        Wed,  6 Jul 2022 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657085759;
        bh=S+9t9q5pVQZbqiqen6tdRHzFoItuJpupAK4la5hhoCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqVeorU6vJUdHY+z8Y3bQ6TaioQy27QvSCnX+UQ/9ZvPeUrCjrJVhXvb9B59IrkmA
         KneJNGkxeB4/fQZO4sMgmBpB7GT2lCcNishJGWZWVkdygf5zeH8lVSAYu0ggEhvv42
         bJ55AygCGYPaZHTOnDFI5XMqzDt+RUXDE96UoUOUsvrHvfPXkTh54iSbShxGytEpHb
         gTCnalq8B8K5UAjpt5nMVkQ34lUfuLPC7TqrzL4ivVI2ZMSXItuK0rV7fZJUTZ5Zrl
         abG/+NBKBngPluEs93ylRmZ8tkbz0Gg8yBeJU/gZHQtvJJd5Jl5AWz6a3Tpz0CG3dT
         fAFRgUF4nAjKQ==
Date:   Wed, 6 Jul 2022 11:05:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     nathan@kernel.org, dmaengine@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dmaengine: imx-dma: Silence a clang warning
Message-ID: <YsUfOweQimrROAPd@matsya>
References: <20220526005422.1162090-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526005422.1162090-1-festevam@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-05-22, 21:54, Fabio Estevam wrote:
> Change the of_device_get_match_data() cast to (uintptr_t)
> to silence the following clang warning:

Patch title should describe the change and not the effect of the change.
Pls revise

> 
> drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer type 'enum imx_dma_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 0ab785c894e6 ("dmaengine: imx-dma: Remove unused .id_table")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/dma/imx-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index 3bffe3ecbd1b..65c6094ce063 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -1047,7 +1047,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	imxdma->dev = &pdev->dev;
> -	imxdma->devtype = (enum imx_dma_type)of_device_get_match_data(&pdev->dev);
> +	imxdma->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imxdma->base = devm_ioremap_resource(&pdev->dev, res);
> -- 
> 2.25.1

-- 
~Vinod
