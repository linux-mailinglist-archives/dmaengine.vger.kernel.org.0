Return-Path: <dmaengine+bounces-4056-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D29FBB2B
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF48F1639C6
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342361B2180;
	Tue, 24 Dec 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2ayArVq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DB1AB6D4;
	Tue, 24 Dec 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032589; cv=none; b=rD3AgcsNldC/5RhMkgDhINGLW1ZUKhsF0hwMBTQGVOR0uE7hrTMWc1KQ/rjUEzq8RYFIJjzAIIRQApSEXKPZTHS6Qh36beyn2NIwItomMvbz+Kv9Um5AaFX0jTH130iuUjJFVacBE9hC0jFmPlDlx7+IidQMMnycLQjzmwzjA1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032589; c=relaxed/simple;
	bh=0TyDd0Y54nWgRQnAS8toDD/VfrC5aVrsdrD1BneoFOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVIWHixVc9z0tGztau+XcS97X4NxSIqwD02J40D79xbc2Z/YO9fOTBPuWS4WddeOouA676898dk10KbLWz99b25fCDZvEDINwAp+WTjGpw39d/YTw16JxCQ5eZZah4liYKhAGFAD5fBSe9D/U2j9Ik3MdJ0NZWRKqSqwp6SGpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2ayArVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5A2C4CED7;
	Tue, 24 Dec 2024 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735032588;
	bh=0TyDd0Y54nWgRQnAS8toDD/VfrC5aVrsdrD1BneoFOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2ayArVqEJtFLD8oei6o40vhxJWSG9mPG3UFXJT6e9FNZaqpxRHpiq+ib6oysyLjZ
	 55n89+1Y5zF8yW5kS9A0ObyjCgbNF207FFCkGD2+phjDZnaY0lwNwn6EAEUHJi4231
	 QbmVYSBiMtqgLvyYQyejV69oYVli0TO2jitaWbEqcEIlCEy0sp8F7vlOC083+dbANK
	 4/tYve1Hasa8QvcTYL9isLLk0ZPfGfoM+Mw8JMLbdwu/k5QbNC5nN9ee5mvSR5xZK9
	 iBdTp90B4WPtGD1DD7ZHDWapy2MmgiWiAT6a6CmHDEevQ5UGrP/qc0qkgFBiiK8Dk0
	 Y3tF1fzq0jIDQ==
Date: Tue, 24 Dec 2024 14:59:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: frank.li@nxp.com, shengjiu.wang@nxp.com, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: fsl-edma: add runtime suspend/resume
 support
Message-ID: <Z2p/CLHFqdamp4Bq@vaman>
References: <20241220021109.2102294-1-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220021109.2102294-1-joy.zou@nxp.com>

On 20-12-24, 10:11, Joy Zou wrote:
> Introduce runtime suspend and resume support for FSL eDMA. Enable
> per-channel power domain management to facilitate runtime suspend and
> resume operations.
> 
> Implement runtime suspend and resume functions for the eDMA engine and
> individual channels.
> 
> Link per-channel power domain device to eDMA per-channel device instead of
> eDMA engine device. So Power Manage framework manage power state of linked
> domain device when per-channel device request runtime resume/suspend.
> 
> Trigger the eDMA engine's runtime suspend when all channels are suspended,
> disabling all common clocks through the runtime PM framework.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/fsl-edma-common.c |  15 ++---
>  drivers/dma/fsl-edma-main.c   | 115 ++++++++++++++++++++++++++++++----
>  2 files changed, 110 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index b7f15ab96855..fcdb53b21f38 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -243,9 +243,6 @@ int fsl_edma_terminate_all(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>  	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
>  
> -	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_PD)
> -		pm_runtime_allow(fsl_chan->pd_dev);
> -
>  	return 0;
>  }
>  
> @@ -805,8 +802,12 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
>  	int ret;
>  
> -	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
> -		clk_prepare_enable(fsl_chan->clk);
> +	ret = pm_runtime_get_sync(&fsl_chan->vchan.chan.dev->device);
> +	if (ret < 0) {
> +		dev_err(&fsl_chan->vchan.chan.dev->device, "pm_runtime_get_sync() failed\n");
> +		pm_runtime_disable(&fsl_chan->vchan.chan.dev->device);
> +		return ret;
> +	}
>  
>  	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
>  				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
> @@ -819,6 +820,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
>  
>  		if (ret) {
>  			dma_pool_destroy(fsl_chan->tcd_pool);
> +			pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
>  			return ret;
>  		}
>  	}
> @@ -851,8 +853,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
>  	fsl_chan->is_sw = false;
>  	fsl_chan->srcid = 0;
>  	fsl_chan->is_remote = false;
> -	if (fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_HAS_CHCLK)
> -		clk_disable_unprepare(fsl_chan->clk);
> +	pm_runtime_put_sync_suspend(&fsl_chan->vchan.chan.dev->device);
>  }
>  
>  void fsl_edma_cleanup_vchan(struct dma_device *dmadev)
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 60de1003193a..75d6c8984c8e 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -420,7 +420,6 @@ MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
>  static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
>  {
>  	struct fsl_edma_chan *fsl_chan;
> -	struct device_link *link;
>  	struct device *pd_chan;
>  	struct device *dev;
>  	int i;
> @@ -439,24 +438,39 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
>  			return -EINVAL;
>  		}
>  
> -		link = device_link_add(dev, pd_chan, DL_FLAG_STATELESS |
> -					     DL_FLAG_PM_RUNTIME |
> -					     DL_FLAG_RPM_ACTIVE);
> -		if (!link) {
> -			dev_err(dev, "Failed to add device_link to %d\n", i);
> -			return -EINVAL;
> -		}
> -
>  		fsl_chan->pd_dev = pd_chan;
> -
> -		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
> -		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
> -		pm_runtime_set_active(fsl_chan->pd_dev);
>  	}
>  
>  	return 0;
>  }
>  
> +/* Per channel dma power domain */
> +static int fsl_edma_chan_runtime_suspend(struct device *dev)
> +{
> +	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	clk_disable_unprepare(fsl_chan->clk);
> +
> +	return ret;

Unused ret! drop it

> +}
> +
> +static int fsl_edma_chan_runtime_resume(struct device *dev)
> +{
> +	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(fsl_chan->clk);
> +
> +	return ret;

how about return clk_prepare_enable()

-- 
~Vinod

