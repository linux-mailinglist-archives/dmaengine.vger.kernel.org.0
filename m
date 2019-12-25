Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D269012A595
	for <lists+dmaengine@lfdr.de>; Wed, 25 Dec 2019 03:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLYC0e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Dec 2019 21:26:34 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60136 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfLYC0d (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Dec 2019 21:26:33 -0500
Received: from s0106602ad0811846.cg.shawcable.net ([68.147.191.165] helo=[192.168.0.12])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ijwNc-00031F-0E; Tue, 24 Dec 2019 19:26:32 -0700
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <20191224050326.3481588-1-vkoul@kernel.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d9991788-feb7-1a3e-1ae3-1131ff3af5a2@deltatee.com>
Date:   Tue, 24 Dec 2019 19:26:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191224050326.3481588-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.191.165
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, vkoul@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE autolearn=no autolearn_force=no version=3.4.2
Subject: Re: [PATCH 1/2] dmaengine: move module_/dma_device_put() after route
 free
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2019-12-23 10:03 p.m., Vinod Koul wrote:
> We call dma_device_put() and module_put() after invoking
> .device_free_chan_resources callback, but we should also take care of
> router devices and invoke this after .route_free callback. So move it
> after .route_free
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Makes sense.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/dma/dmaengine.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index e316abe3672d..0505ea5b002f 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -427,15 +427,15 @@ static void dma_chan_put(struct dma_chan *chan)
>  		chan->device->device_free_chan_resources(chan);
>  	}
>  
> -	dma_device_put(chan->device);
> -	module_put(dma_chan_to_owner(chan));
> -
>  	/* If the channel is used via a DMA request router, free the mapping */
>  	if (chan->router && chan->router->route_free) {
>  		chan->router->route_free(chan->router->dev, chan->route_data);
>  		chan->router = NULL;
>  		chan->route_data = NULL;
>  	}
> +
> +	dma_device_put(chan->device);
> +	module_put(dma_chan_to_owner(chan));
>  }
>  
>  enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
> 
