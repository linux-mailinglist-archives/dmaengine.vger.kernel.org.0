Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FAF1FCEE3
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2020 15:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFQNze (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jun 2020 09:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFQNzd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jun 2020 09:55:33 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 091AF206DB;
        Wed, 17 Jun 2020 13:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592402133;
        bh=RCK1pOU/OyjR6dg9CUaoQ7WIU2luc36I/GhVjk13Scs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfrmmZJg9EQoWhDmAxaUIgOFkVMXFi2LIa6DDQbu6WvLyOw/s/Ons8uWZXEo4kir6
         oTc0+InPEM8rrnRRYLGFPrKAmKW3a1BTkSrtJgUe5ftjIZ44oZRv2bx+4xxntAVVfr
         t2eTQOtw3IMYJrELBg+doObuF/dNubBjz+wKxPgE=
Date:   Wed, 17 Jun 2020 19:25:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        tomi.valkeinen@ti.com
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix delayed_work usage for tx
 drain workaround
Message-ID: <20200617135528.GT2324254@vkoul-mobl>
References: <20200520112233.26807-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520112233.26807-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-05-20, 14:22, Peter Ujfalusi wrote:
> INIT_DELAYED_WORK_ONSTACK() must be used with on-stack delayed work, which
> is not the case here.
> Use normal delayed_work for the channels instead.
> 
> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")

Is this a fix or an optimization?

> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

No sob!

> ---
>  drivers/dma/ti/k3-udma.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index c91e2dc1bb72..87554e093a3b 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -1906,8 +1906,6 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
>  
>  	udma_reset_rings(uc);
>  
> -	INIT_DELAYED_WORK_ONSTACK(&uc->tx_drain.work,
> -				  udma_check_tx_completion);
>  	return 0;
>  
>  err_irq_free:
> @@ -3019,7 +3017,6 @@ static void udma_free_chan_resources(struct dma_chan *chan)
>  	}
>  
>  	cancel_delayed_work_sync(&uc->tx_drain.work);
> -	destroy_delayed_work_on_stack(&uc->tx_drain.work);
>  
>  	if (uc->irq_num_ring > 0) {
>  		free_irq(uc->irq_num_ring, uc);
> @@ -3711,6 +3708,7 @@ static int udma_probe(struct platform_device *pdev)
>  		tasklet_init(&uc->vc.task, udma_vchan_complete,
>  			     (unsigned long)&uc->vc);
>  		init_completion(&uc->teardown_completed);
> +		INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_completion);
>  	}
>  
>  	ret = dma_async_device_register(&ud->ddev);
> -- 
> Peter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
