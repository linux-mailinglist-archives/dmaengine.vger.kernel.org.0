Return-Path: <dmaengine+bounces-1871-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65A68A8A1A
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BA0285310
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 17:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23208171673;
	Wed, 17 Apr 2024 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpNWKtuV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A916FF52;
	Wed, 17 Apr 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374474; cv=none; b=VTnwNKxS0n0vUXbcGkB7W/9pWnMSsixT5svDwKWN1kstLUb1XnQ2KQNLBcEbEuAYP4z9uPwfVwCLXl7/j54c7M16WWEpj58zKvJIeiSEPBrKh8k1UnB1WmJObpnaUKBiPmkgrmtzJyAHa9EQz/AtlacD84S/vLEnyVCyz0zZngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374474; c=relaxed/simple;
	bh=EgzLCuU8JOpiayA2khQEnnc6hPtWqr4k8f9F4Un16Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8Uaxg7BTCHooEwG6fglFC8bV0Ktqev/gsjWMXQGs5AylEygjD1gVZjb9jIIyjcnNoAeGPFTXsYq1IpOpodvmqJl+95LlfkwU0Os9VeG6k2bvt3jqZ708tVbs1bFRYMHKM7U/PMHRZX8V/mXhtrlBpuMz5csNa0OoGSbDTsqjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpNWKtuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5596C072AA;
	Wed, 17 Apr 2024 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374473;
	bh=EgzLCuU8JOpiayA2khQEnnc6hPtWqr4k8f9F4Un16Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpNWKtuVdwHF8XFhFOhpHUv2ToXW1LSlqoX9UXyvKHG/A+BwVmOB/qd6wAfs7kVrG
	 6j/aj2NqcnWAryWaGWOwVrQGNvFrAOEX6QALjanyWxUphqMGHVjzsTeNS6yliPMqf1
	 WGoR68eM5bcZ+lEjvoAd/FIi33lYDvVArh8yivzlwZA43FJ0pJxN4VTji0+MEW1CRr
	 Pp6YhrEFvkTe9fKyYSQKAbF5qkBulnkaz1oH1aH1Pg+2Oft7tZHkUErmmI6qBI/gXl
	 vPguQ+DlZd8cFLVGrR7iQ8z0WZuxKkKbhGh9A6RyLaFekBeoL7Gdu1ufuoNp95M3V2
	 visNhMIQAAYbw==
Date: Wed, 17 Apr 2024 22:51:09 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: zynqmp_dma: rework tasklet to threaded
 interrupt handler
Message-ID: <ZiAFBaZLbQ8yj-dn@matsya>
References: <20240226-zynqmp-dma-tasklet-irqthread-v1-1-2d154d6238fd@pengutronix.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-zynqmp-dma-tasklet-irqthread-v1-1-2d154d6238fd@pengutronix.de>

On 26-02-24, 23:17, Michael Grzeschik wrote:
> Since the tasklets are being scheduled with low priority the actual work
> will be delayed for unseen time. Also this is a driver that probably
> other drivers depend on its work to be done early. So we move the
> actual work from an tasklet to an threaded interrupt handler and
> therefor increase the priority for the scheduler.

The tasklet have higer priority than threaded handler! So this should
worsen the performance.

Btw there is work to move away from tasklet by Allen, so this is no
longer valid now

> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/dma/xilinx/zynqmp_dma.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index f31631bef961a..09173ef6d24bc 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -204,7 +204,6 @@ struct zynqmp_dma_desc_sw {
>   * @dev: The dma device
>   * @irq: Channel IRQ
>   * @is_dmacoherent: Tells whether dma operations are coherent or not
> - * @tasklet: Cleanup work after irq
>   * @idle : Channel status;
>   * @desc_size: Size of the low level descriptor
>   * @err: Channel has errors
> @@ -228,7 +227,6 @@ struct zynqmp_dma_chan {
>  	struct device *dev;
>  	int irq;
>  	bool is_dmacoherent;
> -	struct tasklet_struct tasklet;
>  	bool idle;
>  	size_t desc_size;
>  	bool err;
> @@ -724,8 +722,7 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
>  
>  	writel(isr, chan->regs + ZYNQMP_DMA_ISR);
>  	if (status & ZYNQMP_DMA_INT_DONE) {
> -		tasklet_schedule(&chan->tasklet);
> -		ret = IRQ_HANDLED;
> +		ret = IRQ_WAKE_THREAD;
>  	}
>  
>  	if (status & ZYNQMP_DMA_DONE)
> @@ -733,9 +730,8 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
>  
>  	if (status & ZYNQMP_DMA_INT_ERR) {
>  		chan->err = true;
> -		tasklet_schedule(&chan->tasklet);
>  		dev_err(chan->dev, "Channel %p has errors\n", chan);
> -		ret = IRQ_HANDLED;
> +		ret = IRQ_WAKE_THREAD;
>  	}
>  
>  	if (status & ZYNQMP_DMA_INT_OVRFL) {
> @@ -748,19 +744,20 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
>  }
>  
>  /**
> - * zynqmp_dma_do_tasklet - Schedule completion tasklet
> + * zynqmp_dma_irq_thread - Interrupt thread function
>   * @t: Pointer to the ZynqMP DMA channel structure
>   */
> -static void zynqmp_dma_do_tasklet(struct tasklet_struct *t)
> +static irqreturn_t zynqmp_dma_irq_thread(int irq, void *data)
>  {
> -	struct zynqmp_dma_chan *chan = from_tasklet(chan, t, tasklet);
> +	struct zynqmp_dma_chan *chan = (struct zynqmp_dma_chan *)data;
>  	u32 count;
>  	unsigned long irqflags;
>  
>  	if (chan->err) {
>  		zynqmp_dma_reset(chan);
>  		chan->err = false;
> -		return;
> +
> +		return IRQ_HANDLED;
>  	}
>  
>  	spin_lock_irqsave(&chan->lock, irqflags);
> @@ -778,6 +775,8 @@ static void zynqmp_dma_do_tasklet(struct tasklet_struct *t)
>  		zynqmp_dma_start_transfer(chan);
>  		spin_unlock_irqrestore(&chan->lock, irqflags);
>  	}
> +
> +	return IRQ_HANDLED;
>  }
>  
>  /**
> @@ -796,17 +795,6 @@ static int zynqmp_dma_device_terminate_all(struct dma_chan *dchan)
>  	return 0;
>  }
>  
> -/**
> - * zynqmp_dma_synchronize - Synchronizes the termination of a transfers to the current context.
> - * @dchan: DMA channel pointer
> - */
> -static void zynqmp_dma_synchronize(struct dma_chan *dchan)
> -{
> -	struct zynqmp_dma_chan *chan = to_chan(dchan);
> -
> -	tasklet_kill(&chan->tasklet);
> -}
> -
>  /**
>   * zynqmp_dma_prep_memcpy - prepare descriptors for memcpy transaction
>   * @dchan: DMA channel
> @@ -876,7 +864,6 @@ static void zynqmp_dma_chan_remove(struct zynqmp_dma_chan *chan)
>  
>  	if (chan->irq)
>  		devm_free_irq(chan->zdev->dev, chan->irq, chan);
> -	tasklet_kill(&chan->tasklet);
>  	list_del(&chan->common.device_node);
>  }
>  
> @@ -921,7 +908,6 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
>  
>  	chan->is_dmacoherent =  of_property_read_bool(node, "dma-coherent");
>  	zdev->chan = chan;
> -	tasklet_setup(&chan->tasklet, zynqmp_dma_do_tasklet);
>  	spin_lock_init(&chan->lock);
>  	INIT_LIST_HEAD(&chan->active_list);
>  	INIT_LIST_HEAD(&chan->pending_list);
> @@ -936,7 +922,8 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
>  	chan->irq = platform_get_irq(pdev, 0);
>  	if (chan->irq < 0)
>  		return -ENXIO;
> -	err = devm_request_irq(&pdev->dev, chan->irq, zynqmp_dma_irq_handler, 0,
> +	err = devm_request_threaded_irq(&pdev->dev, chan->irq,
> +			       zynqmp_dma_irq_handler, zynqmp_dma_irq_thread, 0,
>  			       "zynqmp-dma", chan);
>  	if (err)
>  		return err;
> @@ -1071,7 +1058,6 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>  	p = &zdev->common;
>  	p->device_prep_dma_memcpy = zynqmp_dma_prep_memcpy;
>  	p->device_terminate_all = zynqmp_dma_device_terminate_all;
> -	p->device_synchronize = zynqmp_dma_synchronize;
>  	p->device_issue_pending = zynqmp_dma_issue_pending;
>  	p->device_alloc_chan_resources = zynqmp_dma_alloc_chan_resources;
>  	p->device_free_chan_resources = zynqmp_dma_free_chan_resources;
> 
> ---
> base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
> change-id: 20240226-zynqmp-dma-tasklet-irqthread-1540cfe2a1c2
> 
> Best regards,
> -- 
> Michael Grzeschik <m.grzeschik@pengutronix.de>

-- 
~Vinod

