Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E190E113E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 06:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfJWExl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 00:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731061AbfJWExl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Oct 2019 00:53:41 -0400
Received: from localhost (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D3122173B;
        Wed, 23 Oct 2019 04:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571806420;
        bh=KmXEO9N15emCT7iHfRUVAzsxcCk2lj537nwdJsgIXJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvK6csaJTyaVFUf/KOKnftCZA6SnTccubTAMBReC0Rscti6sxfYml5eUnEtFiyncy
         HYscRAxdFIqhU6GiTRllBuZz2tTxJXZdWU7k91OQgvJKmUY7k2E6NQWr61toWXC0ew
         tycYBGN2SuBzTrMA6OkeqKJi/AM99Nt/VCVHkyTs=
Date:   Wed, 23 Oct 2019 10:23:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        George Cherian <george.cherian@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, giulio.benetti@benettiengineering.com,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] dmaengine: cppi41: Fix issue with musb and ftdi uart
Message-ID: <20191023045333.GO2654@vkoul-mobl>
References: <20191022145545.6449-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022145545.6449-1-tony@atomide.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Tony,

On 22-10-19, 07:55, Tony Lindgren wrote:

Patch subject should reflect the patch changes not the fix. The patch
title here is not telling me anything about the change below. Pls
consider updating the title.

> The first dma call done by musb_ep_program() must wait if cppi41 is PM
> runtime suspended. Otherwise musb_ep_program() continues with other
> non-dma packets before the DMA transfer is started causing at least ftdi
> uarts to fail to receive data.
> 
> Let's fix the issue by waking up cppi41 with PM runtime calls added to
> cppi41_dma_prep_slave_sg() and return NULL if still idled. This way we
> have musb_ep_program() continue with PIO until cppi41 is awake.
> 
> Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")

Cc stable?

> Cc: Bin Liu <b-liu@ti.com>
> Cc: giulio.benetti@benettiengineering.com
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Skvortsov <andrej.skvortzov@gmail.com>
> Reported-by: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/dma/ti/cppi41.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
> --- a/drivers/dma/ti/cppi41.c
> +++ b/drivers/dma/ti/cppi41.c
> @@ -586,9 +586,22 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
>  	enum dma_transfer_direction dir, unsigned long tx_flags, void *context)
>  {
>  	struct cppi41_channel *c = to_cpp41_chan(chan);
> +	struct dma_async_tx_descriptor *txd = NULL;
> +	struct cppi41_dd *cdd = c->cdd;
>  	struct cppi41_desc *d;
>  	struct scatterlist *sg;
>  	unsigned int i;
> +	int error;
> +
> +	error = pm_runtime_get(cdd->ddev.dev);
> +	if (error < 0) {
> +		pm_runtime_put_noidle(cdd->ddev.dev);
> +
> +		return NULL;
> +	}
> +
> +	if (cdd->is_suspended)
> +		goto err_out_not_ready;
>  
>  	d = c->desc;
>  	for_each_sg(sgl, sg, sg_len, i) {
> @@ -611,7 +624,13 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
>  		d++;
>  	}
>  
> -	return &c->txd;
> +	txd = &c->txd;
> +
> +err_out_not_ready:
> +	pm_runtime_mark_last_busy(cdd->ddev.dev);
> +	pm_runtime_put_autosuspend(cdd->ddev.dev);
> +
> +	return txd;
>  }
>  
>  static void cppi41_compute_td_desc(struct cppi41_desc *d)
> -- 
> 2.23.0

-- 
~Vinod
