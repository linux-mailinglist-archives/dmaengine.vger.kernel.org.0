Return-Path: <dmaengine+bounces-7141-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2D4C5361E
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 653ED3572CA
	for <lists+dmaengine@lfdr.de>; Wed, 12 Nov 2025 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5492F60CF;
	Wed, 12 Nov 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj9LpvMV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906102D0C70;
	Wed, 12 Nov 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964129; cv=none; b=aG1Q0zdy/U1sCnZVO2RlKNKPK2Wb/R6m9D52dMXvKN59r9e5GYSDtXA6Gem4bOdyS4n1xodBB2LvqJzZDBnGVlaHWgrO2+3WbW4D8uH8gFJmBsuPn7RY/6dBUngENoHakogoIvx0oaxGz2O3eeBSuqkddGczJ4tSQkZwKTS3dUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964129; c=relaxed/simple;
	bh=jr2jj0NNeOlSkjn/MTgOK8TwOXuV3wzWI3+dwpzsasI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWI0gkO0Icwsb8cNhZLg8emvgtoW73qVSIl2Fe5MN84+T9na0qnqItW9rfp0brwsxp1ATnznyGBHaJlgAP5X1f0IFmauUCTmOanXxoVOGJ3CBm3EzfCXoYI1EpdLR5voDioTsWM9U3lqfhiM/CQRiJA0UUFOsYQLqMuwIVvzdXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj9LpvMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC66C19421;
	Wed, 12 Nov 2025 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964129;
	bh=jr2jj0NNeOlSkjn/MTgOK8TwOXuV3wzWI3+dwpzsasI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mj9LpvMVqFq1XK8hFK01+6fDPWy0GZ4hFzSQRnsscaqExHcki2FWF6EcGc7m/47Qo
	 DYhRguS1QQa86Z5dNX6yE2YqvoQhRitm3fngt2DrdXllEoxw8NEVk7elFgmjYw0aw2
	 ibScTaCQLyxqPNP8qCV9UaYwAHaOq889OecEJqN2WZXp8mliHYkIpo76pGFOh9QrhK
	 jYIAGr6CAh2ow2WAqgzdweMqHVOIdC4P7DLjCgPeF55tRNEzTB7LW5Sh5ke0I63Nwe
	 AywdXC3cXmh1djRf223iA7ZJqPJU87toDrtD/Ko4v5neIwZjCbq67FVMAfVQPxBT0Q
	 fr/9/J2Cyr+rw==
Date: Wed, 12 Nov 2025 10:19:46 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/3] dmaengine: qcom: bam_dma: convert tasklet to a
 workqueue
Message-ID: <rrw7q7cmkaykng5mnyqk5oxsjednptx3yvjilh3tf5uub4nxzh@p5a4sbgbaha2>
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
 <20251106-qcom-bam-dma-refactor-v1-3-0e2baaf3d81a@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-qcom-bam-dma-refactor-v1-3-0e2baaf3d81a@linaro.org>

On Thu, Nov 06, 2025 at 04:44:52PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There is nothing in the interrupt handling that requires us to run in
> atomic context so convert the tasklet to a workqueue.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

I like the patch, getting off the tasklet is nice. But reading the
patch/driver spawned some additional questions (not (necessarily)
feedback to this patch).

> ---
>  drivers/dma/qcom/bam_dma.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index bcd8de9a9a12621a36b49c31bff96f474468be06..40ad4179177fb7a074776db05b834da012f6a35f 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -42,6 +42,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
> +#include <linux/workqueue.h>
>  
>  #include "../dmaengine.h"
>  #include "../virt-dma.h"
> @@ -397,8 +398,8 @@ struct bam_device {
>  	struct clk *bamclk;
>  	int irq;
>  
> -	/* dma start transaction tasklet */
> -	struct tasklet_struct task;
> +	/* dma start transaction workqueue */
> +	struct work_struct work;
>  };
>  
>  /**
> @@ -869,7 +870,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
>  			/*
>  			 * if complete, process cookie. Otherwise
>  			 * push back to front of desc_issued so that
> -			 * it gets restarted by the tasklet
> +			 * it gets restarted by the work queue.
>  			 */
>  			if (!async_desc->num_desc) {
>  				vchan_cookie_complete(&async_desc->vd);
> @@ -899,9 +900,9 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
>  
>  	srcs |= process_channel_irqs(bdev);
>  
> -	/* kick off tasklet to start next dma transfer */
> +	/* kick off the work queue to start next dma transfer */
>  	if (srcs & P_IRQ)
> -		tasklet_schedule(&bdev->task);
> +		schedule_work(&bdev->work);

I'm not entirely familiar with the BAM driver, but wouldn't it be
preferable to make the interrupt handler threaded and just kick off the
next set of transactions directly from here? To reduce the downtime
between transactions when more are ready queued.

It seems this might be of concern when we have queued more transfers
than can fit in the hardware, but I don't have any data indicating how
often this happens.

>  
>  	ret = pm_runtime_get_sync(bdev->dev);

The "bus" clock is tied to the PM runtime state, so I presume this is
here in order to ensure the block is clocked for the following register
accesses(?)

But process_channel_irqs() was just all over the same register space.


Also noteworthy is that none of the pm_runtime_get_sync() in this driver
calls have adequate error handling.

Regards,
Bjorn

>  	if (ret < 0)
> @@ -1097,14 +1098,14 @@ static void bam_start_dma(struct bam_chan *bchan)
>  }
>  
>  /**
> - * dma_tasklet - DMA IRQ tasklet
> - * @t: tasklet argument (bam controller structure)
> + * bam_dma_work() - DMA interrupt work queue callback
> + * @work: work queue struct embedded in the BAM controller device struct
>   *
>   * Sets up next DMA operation and then processes all completed transactions
>   */
> -static void dma_tasklet(struct tasklet_struct *t)
> +static void bam_dma_work(struct work_struct *work)
>  {
> -	struct bam_device *bdev = from_tasklet(bdev, t, task);
> +	struct bam_device *bdev = from_work(bdev, work, work);
>  	struct bam_chan *bchan;
>  	unsigned int i;
>  
> @@ -1117,14 +1118,13 @@ static void dma_tasklet(struct tasklet_struct *t)
>  		if (!list_empty(&bchan->vc.desc_issued) && !IS_BUSY(bchan))
>  			bam_start_dma(bchan);
>  	}
> -
>  }
>  
>  /**
>   * bam_issue_pending - starts pending transactions
>   * @chan: dma channel
>   *
> - * Calls tasklet directly which in turn starts any pending transactions
> + * Calls work queue directly which in turn starts any pending transactions
>   */
>  static void bam_issue_pending(struct dma_chan *chan)
>  {
> @@ -1292,14 +1292,14 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_disable_clk;
>  
> -	tasklet_setup(&bdev->task, dma_tasklet);
> +	INIT_WORK(&bdev->work, bam_dma_work);
>  
>  	bdev->channels = devm_kcalloc(bdev->dev, bdev->num_channels,
>  				sizeof(*bdev->channels), GFP_KERNEL);
>  
>  	if (!bdev->channels) {
>  		ret = -ENOMEM;
> -		goto err_tasklet_kill;
> +		goto err_workqueue_cancel;
>  	}
>  
>  	/* allocate and initialize channels */
> @@ -1364,8 +1364,8 @@ static int bam_dma_probe(struct platform_device *pdev)
>  err_bam_channel_exit:
>  	for (i = 0; i < bdev->num_channels; i++)
>  		tasklet_kill(&bdev->channels[i].vc.task);
> -err_tasklet_kill:
> -	tasklet_kill(&bdev->task);
> +err_workqueue_cancel:
> +	cancel_work_sync(&bdev->work);
>  err_disable_clk:
>  	clk_disable_unprepare(bdev->bamclk);
>  
> @@ -1399,7 +1399,7 @@ static void bam_dma_remove(struct platform_device *pdev)
>  			    bdev->channels[i].fifo_phys);
>  	}
>  
> -	tasklet_kill(&bdev->task);
> +	cancel_work_sync(&bdev->work);
>  
>  	clk_disable_unprepare(bdev->bamclk);
>  }
> 
> -- 
> 2.51.0
> 
> 

