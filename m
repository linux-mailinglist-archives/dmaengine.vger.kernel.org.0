Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A09508757
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 13:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376324AbiDTLvL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359409AbiDTLvL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 07:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3557419B7
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 04:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E0B661944
        for <dmaengine@vger.kernel.org>; Wed, 20 Apr 2022 11:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1499AC385A1;
        Wed, 20 Apr 2022 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650455304;
        bh=djYSPAWl2IhmkSXXEAOrBilSrWifuUdDvaqU5tV14ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBYEBg93WIAp8EnVbt2i0CzC0lVsV77Am7/PU1lTWhnK2y4CqQZJ7NhA23tJgI5Oo
         TLcunYcDXXnJZHazZJCnRCKvyoCvE9jY2aHHOIGMOI2oJS6aA5zC/BPcNcWaS/VkJy
         euw8ofllLIOXcyHuBZb2rBDP3/DzyPfQkCL8Ai55koweqIQYVXRbRiPM1awVuHUdJg
         apsBpB+Vgr6Xw2a/rHfh1w/w1Vp+Vs8/8X/HntjSudgTEFZDLFMEbEP8xwmxReYWyg
         jvFwouuCk/ghpqzkOx5x6LPOTNn2fctJ3/nOzHM9V1QTESsHKlS6XPY0Ei+NmrKqKX
         FoX/TujwIjgxw==
Date:   Wed, 20 Apr 2022 17:18:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Ben Walker <benjamin.walker@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: set DMA_INTERRUPT cap bit
Message-ID: <Yl/zBG+XxFP9mgHg@matsya>
References: <164971497859.2201379.17925303210723708961.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164971497859.2201379.17925303210723708961.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-04-22, 15:09, Dave Jiang wrote:
> Even though idxd driver has always supported interrupt, it never actually
> set the DMA_INTERRUPT cap bit. Rectify this mistake so the interrupt
> capability is advertised.

Applied, thanks

> 
> Reported-by: Ben Walker <benjamin.walker@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/dma.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index bfff59617d04..13e061944db9 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -193,6 +193,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
>  	INIT_LIST_HEAD(&dma->channels);
>  	dma->dev = dev;
>  
> +	dma_cap_set(DMA_INTERRUPT, dma->cap_mask);
>  	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>  	dma_cap_set(DMA_COMPLETION_NO_ORDER, dma->cap_mask);
>  	dma->device_release = idxd_dma_release;
> 

-- 
~Vinod
