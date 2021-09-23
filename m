Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1124160D1
	for <lists+dmaengine@lfdr.de>; Thu, 23 Sep 2021 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbhIWONm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Sep 2021 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbhIWONl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Sep 2021 10:13:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39EC061574
        for <dmaengine@vger.kernel.org>; Thu, 23 Sep 2021 07:12:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mTPSD-0006kc-MA; Thu, 23 Sep 2021 16:12:01 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mTPSA-0000L2-3T; Thu, 23 Sep 2021 16:11:58 +0200
Date:   Thu, 23 Sep 2021 16:11:58 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     vkoul@kernel.org, romain.perier@gmail.com, allen.lkml@gmail.com,
        yukuai3@huawei.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@xilinx.com,
        radhey.shyam.pandey@xilinx.com, shravya.kumbham@xilinx.com
Subject: Re: [PATCH 1/4] dmaengine: zynqmp_dma: Typecast the variable to
 handle overflow
Message-ID: <20210923141158.GA30905@pengutronix.de>
References: <20210914082817.22311-1-harini.katakam@xilinx.com>
 <20210914082817.22311-2-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914082817.22311-2-harini.katakam@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:08:04 up 217 days, 16:31, 115 users,  load average: 0.30, 0.52,
 0.45
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Harini,

On Tue, 14 Sep 2021 13:58:14 +0530, Harini Katakam wrote:
> From: Shravya Kumbham <shravya.kumbham@xilinx.com>
> 
> In zynqmp_dma_alloc/free_chan_resources functions there is a
> potential overflow in the below expressions.
> 
> dma_alloc_coherent(chan->dev, (2 * chan->desc_size *
> 		   ZYNQMP_DMA_NUM_DESCS),
> 		   &chan->desc_pool_p, GFP_KERNEL);
> 
> dma_free_coherent(chan->dev,(2 * ZYNQMP_DMA_DESC_SIZE(chan) *
>                  ZYNQMP_DMA_NUM_DESCS),
>                 chan->desc_pool_v, chan->desc_pool_p);
> 
> The arguments desc_size and ZYNQMP_DMA_NUM_DESCS are 32 bit. Though
> this overflow condition is not observed but it is a potential problem
> in the case of 32-bit multiplication. Hence fix it by using typecast.
> 
> Addresses-Coverity: Event overflow_before_widen.
> Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Thanks for the patch.

Your SoB is missing in this and the other patches of this series.

> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 5fecf5aa6e85..2d0eba25739d 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -490,7 +490,8 @@ static int zynqmp_dma_alloc_chan_resources(struct dma_chan *dchan)
>  	}
>  
>  	chan->desc_pool_v = dma_alloc_coherent(chan->dev,
> -					       (2 * chan->desc_size * ZYNQMP_DMA_NUM_DESCS),
> +					       ((size_t)(2 * chan->desc_size) *
> +						ZYNQMP_DMA_NUM_DESCS),

Wouldn't it be easier to change the type of chan->desc_size to size_t? Maybe
we could also just calculate the size of the descriptor pool during probe() to
make the code more readable?

I also noticed that there is the ZYNQMP_DMA_DESC_SIZE() macro, which is
inconsistently used in the driver. Maybe you could cleanup this as well as you
are at it?

>  					       &chan->desc_pool_p, GFP_KERNEL);
>  	if (!chan->desc_pool_v)
>  		return -ENOMEM;
> @@ -677,7 +678,8 @@ static void zynqmp_dma_free_chan_resources(struct dma_chan *dchan)
>  	zynqmp_dma_free_descriptors(chan);
>  	spin_unlock_irqrestore(&chan->lock, irqflags);
>  	dma_free_coherent(chan->dev,
> -		(2 * ZYNQMP_DMA_DESC_SIZE(chan) * ZYNQMP_DMA_NUM_DESCS),
> +		((size_t)(2 * ZYNQMP_DMA_DESC_SIZE(chan)) *
> +		 ZYNQMP_DMA_NUM_DESCS),

With a pre-calculated descriptor pool size, recalculating the size here
wouldn't be necessary anymore.

Michael

>  		chan->desc_pool_v, chan->desc_pool_p);
>  	kfree(chan->sw_desc_pool);
>  	pm_runtime_mark_last_busy(chan->dev);
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
