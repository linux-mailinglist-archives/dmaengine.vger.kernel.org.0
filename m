Return-Path: <dmaengine+bounces-9388-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP4rG6JksWnsugIAu9opvQ
	(envelope-from <dmaengine+bounces-9388-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 13:48:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1287B263D78
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E87A3314A16C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94623ABA9;
	Wed, 11 Mar 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIvv5lep"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773801DE2D3;
	Wed, 11 Mar 2026 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233156; cv=none; b=cnuDNddMjF4q5utHRahiq2kDAJSLtzoGH9dt723lGGAAcDT0FZcdSiRR+vGvMaWyLh7mXRNaV+o2mxD4/8Y+3i63071xnjgCSPRfY8N/fSeugLKq1pqZ8F1VfA1ccz7CggagfuoS1oV6S/2sgrVr/QrH7n5wBoNKloy4sNA84bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233156; c=relaxed/simple;
	bh=p5s6LmiZUsNIQywTKWkHbQraxneuuNSzrESbFlm5lxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8soBHg+pItdLrUXl2f3LtJq26sOuiI4JHTZErVr4vZ0w9HnOH8QFiGugppOFam4xQX1U7uwfQTqCfUfkeWnCnY/tXQeEsgxl6o4upb3Ts49phMGeS9SJmzBuJaJ+613eBSHME5Op5DCVED3j54+zguIgO4/TyAvNTpN2QYxPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIvv5lep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6760C4CEF7;
	Wed, 11 Mar 2026 12:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773233156;
	bh=p5s6LmiZUsNIQywTKWkHbQraxneuuNSzrESbFlm5lxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIvv5lepipQPW10zdemikIqrwuUfcRR2QVowZqwFW/ZMs8Vk8zbtQOHn+AEYgh++Z
	 LenwsZII7WsgyInyJ0Fx3KydhVgM2Piwy/FAhRLI5Ha+CpuKojEhkrzgKy+9RsoeG1
	 aK57CJaJsW/ALaXAvG4Fki6KUN9EAQmPimqZra/gUOXkT3CkfKsKCejdp98VUGfsAN
	 SAkQ0ZX9PP2GBVNlM8c90pgKjgyOxjyv36dyQjnAY0oDjoPoqOUjjdcJlVWrJgqKq7
	 nEIfwuUerD9oTl5p7gL5uLuAWZ7qJPf1IHvD/oW8IoZQyMvRKy/hXEoGJn5kCeIqDD
	 Dh0CYmLG/rnNw==
Date: Wed, 11 Mar 2026 18:15:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, brgl@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v12 02/12] dmaengine: qcom: bam_dma: convert tasklet to a
 BH workqueue
Message-ID: <iimeqofy4fzr4pqtda7sayt5hbbmdldopmcyxagve44dbapnla@ruzqqx6lntkz>
References: <20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com>
 <20260310-qcom-qce-cmd-descr-v12-2-398f37f26ef0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310-qcom-qce-cmd-descr-v12-2-398f37f26ef0@oss.qualcomm.com>
X-Rspamd-Queue-Id: 1287B263D78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9388-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,vger.kernel.org,lists.infradead.org,linaro.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 04:44:16PM +0100, Bartosz Golaszewski wrote:
> BH workqueues are a modern mechanism, aiming to replace legacy tasklets.
> Let's convert the BAM DMA driver to using the high-priority variant of
> the BH workqueue.
> 
> [Vinod: suggested using the BG workqueue instead of the regular one
> running in process context]
> 
> Suggested-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/dma/qcom/bam_dma.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 19116295f8325767a0d97a7848077885b118241c..c8601bac555edf1bb4384fd39cb3449ec6e86334 100644
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
> @@ -863,7 +864,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
>  			/*
>  			 * if complete, process cookie. Otherwise
>  			 * push back to front of desc_issued so that
> -			 * it gets restarted by the tasklet
> +			 * it gets restarted by the work queue.
>  			 */
>  			if (!async_desc->num_desc) {
>  				vchan_cookie_complete(&async_desc->vd);
> @@ -893,9 +894,9 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
>  
>  	srcs |= process_channel_irqs(bdev);
>  
> -	/* kick off tasklet to start next dma transfer */
> +	/* kick off the work queue to start next dma transfer */
>  	if (srcs & P_IRQ)
> -		tasklet_schedule(&bdev->task);
> +		queue_work(system_bh_highpri_wq, &bdev->work);
>  
>  	ret = pm_runtime_get_sync(bdev->dev);
>  	if (ret < 0)
> @@ -1091,14 +1092,14 @@ static void bam_start_dma(struct bam_chan *bchan)
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
> @@ -1111,14 +1112,13 @@ static void dma_tasklet(struct tasklet_struct *t)
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
> @@ -1286,14 +1286,14 @@ static int bam_dma_probe(struct platform_device *pdev)
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
> @@ -1358,8 +1358,8 @@ static int bam_dma_probe(struct platform_device *pdev)
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
> @@ -1393,7 +1393,7 @@ static void bam_dma_remove(struct platform_device *pdev)
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
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்

