Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1D52DC29
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiESR6i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiESR6h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:58:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CDDD02BD;
        Thu, 19 May 2022 10:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30815619CF;
        Thu, 19 May 2022 17:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2DFC385AA;
        Thu, 19 May 2022 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652983115;
        bh=qPSL3nOy4ors8i7I3XUDymDpFTxUdxPWn9rsFvTq4IU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0B6c12RB7rnU3d3fbpR59AQwMBiYIHh01cWkCVFWoFxG4S/5WQslaQxF6a2ndlaT
         SS9SbflaP4pIgkWayhUQVBIGeGX24a5SGPnYCvyhxaqImBQq7zRl2lPettkBow1Y9u
         BFOpWBdSpUXBEsA9RZp5inbVjsq2ATV62zYtK8E2arym0VFrfChrfTH9vzdu9wDgW9
         FNiUNiJf/5StVBcsWkvpyOsRYIzO5YoPX47FtapAKwFRlJjnMVsfDT0XtOl7hNa/hq
         3bF55LsX9RF+l7PNlMiCks5Kxp6YukONvO7HhczXJ1szKkvlRkCRa9Gz0fsv2ugsqN
         XD3AjDZ/T+/4w==
Date:   Thu, 19 May 2022 23:28:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "sean.nyekjaer@prevas.dk" <sean.nyekjaer@prevas.dk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v1 03/15] Revert "dmaengine: imx-sdma: refine to load
 context only once"
Message-ID: <YoaFR/Nd9fv0xbKA@matsya>
References: <1556027045-5269-1-git-send-email-yibin.gong@nxp.com>
 <1556027045-5269-4-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556027045-5269-4-git-send-email-yibin.gong@nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-04-19, 13:50, Robin Gong wrote:
> This reverts commit ad0d92d7ba6aecbe2705907c38ff8d8be4da1e9c, because

Please fix this as well

> in spi-imx case, burst length may be changed dynamically.

So what is the solution to handle different burst lengths, pls
explain...

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 99d9f43..407a56e 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -377,7 +377,6 @@ struct sdma_channel {
>  	unsigned long			watermark_level;
>  	u32				shp_addr, per_addr;
>  	enum dma_status			status;
> -	bool				context_loaded;
>  	struct imx_dma_data		data;
>  	struct work_struct		terminate_worker;
>  };
> @@ -988,9 +987,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>  	int ret;
>  	unsigned long flags;
>  
> -	if (sdmac->context_loaded)
> -		return 0;
> -
>  	if (sdmac->direction == DMA_DEV_TO_MEM)
>  		load_address = sdmac->pc_from_device;
>  	else if (sdmac->direction == DMA_DEV_TO_DEV)
> @@ -1033,8 +1029,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
>  
>  	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
>  
> -	sdmac->context_loaded = true;
> -
>  	return ret;
>  }
>  
> @@ -1074,7 +1068,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
>  	sdmac->desc = NULL;
>  	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
>  	vchan_dma_desc_free_list(&sdmac->vc, &head);
> -	sdmac->context_loaded = false;
>  }
>  
>  static int sdma_disable_channel_async(struct dma_chan *chan)
> -- 
> 2.7.4
> 

-- 
~Vinod
