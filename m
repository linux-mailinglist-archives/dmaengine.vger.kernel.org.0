Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694EB55FDBC
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jun 2022 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiF2Ks1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jun 2022 06:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF2Ks0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jun 2022 06:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5807411C2E;
        Wed, 29 Jun 2022 03:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA68461004;
        Wed, 29 Jun 2022 10:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC68C34114;
        Wed, 29 Jun 2022 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656499703;
        bh=yx8rlMTgm5/Zj4pMhvf/7HabeFYe9kWyjZ07Yhj3p64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqSNG//XkKuk4FTBsgBeZYiCSrTrWtRb9cHv+gDG+hztwLqAWrBb1E2BR5X8tRBp1
         zDSMP0PpiXmi0rNFDcIFXbfxnGASfGVpanUK9gvj2yrhOQC42LCECI96w2qQtvfdvU
         SRwbu+9297NxzyF/SRTsgJHDpwyyKKB6tPPNetLRCwor84ENnna3wHMSIdP6NJE3Kz
         uoKEuF5st/LDkNSl6MWtKq0Go6BmYh+MMMFWAZvdYUUDXa6EDXvg66Nk3Hnj/MWSW4
         PWWVuWaSuHXKIYIm2daMopRqJT7Inb3njRJiMVKhvUkUdfHB6vrivYgT+OOzXXSSWf
         8UChzvdQhT4+w==
Date:   Wed, 29 Jun 2022 16:18:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vivek Gautam <vivek.gautam@arm.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com
Subject: Re: [PATCH] dmaengine: pl330: Set DMA_INTERRUPT capability and add
 related callback
Message-ID: <Yrwt8QzEFM6W0xrc@matsya>
References: <20220629093003.19440-1-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629093003.19440-1-vivek.gautam@arm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-06-22, 15:00, Vivek Gautam wrote:
> With the verification for DMA_INTERRUPT capability added to the dmatest
> module, the dmatest fails to start for various channels of pl330 dma
> controller. So, set the DMA_INTERRUPT capability and add the required
> callback method to set the transaction descriptor flags.

Are you sire you want that? See 646728dff254 in linux-next

Thanks

> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  drivers/dma/pl330.c | 24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 858400e42ec0..b80e48f0970b 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2757,6 +2757,28 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
>  	return &desc->txd;
>  }
>  
> +static struct dma_async_tx_descriptor *
> +pl330_dma_prep_interrupt(struct dma_chan *chan, unsigned long flags)
> +{
> +	struct dma_pl330_chan *pch = to_pchan(chan);
> +	struct dma_pl330_desc *desc;
> +
> +	if (unlikely(!pch))
> +		return NULL;
> +
> +	desc = pl330_get_desc(pch);
> +	if (!desc) {
> +		dev_err(pch->dmac->ddma.dev, "%s:%d Unable to fetch desc\n",
> +			__func__, __LINE__);
> +		return NULL;
> +	}
> +
> +	/* Set the flags that are passed downstream */
> +	desc->txd.flags = flags;
> +
> +	return &desc->txd;
> +}
> +
>  static struct dma_async_tx_descriptor *
>  pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
>  		dma_addr_t src, size_t len, unsigned long flags)
> @@ -3111,6 +3133,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>  	}
>  
>  	dma_cap_set(DMA_MEMCPY, pd->cap_mask);
> +	dma_cap_set(DMA_INTERRUPT, pd->cap_mask);
>  	if (pcfg->num_peri) {
>  		dma_cap_set(DMA_SLAVE, pd->cap_mask);
>  		dma_cap_set(DMA_CYCLIC, pd->cap_mask);
> @@ -3121,6 +3144,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>  	pd->device_free_chan_resources = pl330_free_chan_resources;
>  	pd->device_prep_dma_memcpy = pl330_prep_dma_memcpy;
>  	pd->device_prep_dma_cyclic = pl330_prep_dma_cyclic;
> +	pd->device_prep_dma_interrupt = pl330_dma_prep_interrupt;
>  	pd->device_tx_status = pl330_tx_status;
>  	pd->device_prep_slave_sg = pl330_prep_slave_sg;
>  	pd->device_config = pl330_config;
> -- 
> 2.17.1

-- 
~Vinod
