Return-Path: <dmaengine+bounces-2985-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04A2962ED9
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 19:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98510281BB7
	for <lists+dmaengine@lfdr.de>; Wed, 28 Aug 2024 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5124719D8A4;
	Wed, 28 Aug 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3b8etMW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3351494AC
	for <dmaengine@vger.kernel.org>; Wed, 28 Aug 2024 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867222; cv=none; b=BGFZDa9gNln/ErRKgY3zmBhn8xeayNWmj2VaVp4l0wUBV2NTUiPHdFPoBxVWsozXm93yXQ6NP/9e4zMUfU8lu8+iMddlV0h9TmESrQPspanfJVFCEhWmR2e7fWQguHiSgiV9h9mItgacv1UkUw3ZIBfuUKMDvZeLVURH1VWXHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867222; c=relaxed/simple;
	bh=M8HBlxCLeAGa8cDNP5iVT0Q8RykV/AtZdGI4RIE0C9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcCNaV3nzsu6TQAmB4jvFWPpgnCdEy3o09pvU4EyQ0hK8ZBuNGgF8+OQkp8tjdtWL2lUhZBzyfjiTjfhYJSvGen6BiMpSLKASZh+ORe8Rp60zl7W9UUEFn2Pp8tBaYKKLNo5mmvmTy9qBYHboP55Hzvvsps+nRfh9n8zwO2ML3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3b8etMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3126EC4CEC0;
	Wed, 28 Aug 2024 17:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724867221;
	bh=M8HBlxCLeAGa8cDNP5iVT0Q8RykV/AtZdGI4RIE0C9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3b8etMWhsxy+n7XZudpPz5ho/VHcrGv1Gm6ikMDMU9ZcX8Y/bPZTV6pwmMV1H46s
	 b5WlvwiDCUnW+EiM/DVuqgIDN3mBmD5Vnm172JCRtdjG+FKopthDefkMGPXIAt41El
	 WHBrrtFuS3q+cq9Yy5LE+0UBZeiI+VolrNVPKtFZnFHW36fz5QvDeuAcH7s7SWnp9V
	 CHvsCS6O/cs2vUWBkpe2XizTqMJRB7MXYHSDPPpBS1N9Ajt2RxsxmJLhxz4DtEDKAV
	 RrD4Nf6zR7reBIqv6RIG2tD0qD05M8QmE6HvYRfQ8bLRO9zDub6z276w+1mgJueA6K
	 dh8wuLBeWNS7Q==
Date: Wed, 28 Aug 2024 23:16:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, Raju.Rangoju@amd.com, Frank.li@nxp.com,
	helgaas@kernel.org, pstanner@redhat.com
Subject: Re: [PATCH v5 4/7] dmaengine: ptdma: Extend ptdma to support
 multi-channel and version
Message-ID: <Zs9ikhDFPn1LNb5I@vaman>
References: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
 <20240708144500.1523651-5-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708144500.1523651-5-Basavaraj.Natikar@amd.com>

On 08-07-24, 20:14, Basavaraj Natikar wrote:
> To support multi-channel functionality with AE4DMA engine, extend the
> PTDMA code with reusable components.
> 
> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  drivers/dma/amd/ae4dma/ae4dma.h         |   2 +
>  drivers/dma/amd/common/amd_dma.h        |   1 +
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 105 +++++++++++++++++++-----
>  drivers/dma/amd/ptdma/ptdma.h           |   2 +
>  4 files changed, 90 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
> index a63525792080..5f9dab5f05f4 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma.h
> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
> @@ -24,6 +24,8 @@
>  #define AE4_Q_BASE_H_OFF		0x1C
>  #define AE4_Q_SZ			0x20
>  
> +#define AE4_DMA_VERSION			4

Can it be driver data for the device?
I am not seeing who sets this here?

> +
>  struct ae4_msix {
>  	int msix_count;
>  	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
> diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
> index f9f396cd4371..396667e81e1a 100644
> --- a/drivers/dma/amd/common/amd_dma.h
> +++ b/drivers/dma/amd/common/amd_dma.h
> @@ -21,6 +21,7 @@
>  #include <linux/wait.h>
>  
>  #include "../ptdma/ptdma.h"
> +#include "../ae4dma/ae4dma.h"
>  #include "../../virt-dma.h"
>  
>  #endif
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 66ea10499643..90ca02fd5f8f 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -43,7 +43,24 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
>  	kmem_cache_free(pt->dma_desc_cache, desc);
>  }
>  
> -static int pt_dma_start_desc(struct pt_dma_desc *desc)
> +static struct pt_cmd_queue *pt_get_cmd_queue(struct pt_device *pt, struct pt_dma_chan *chan)
> +{
> +	struct ae4_cmd_queue *ae4cmd_q;
> +	struct pt_cmd_queue *cmd_q;
> +	struct ae4_device *ae4;
> +
> +	if (pt->ver == AE4_DMA_VERSION) {
> +		ae4 = container_of(pt, struct ae4_device, pt);
> +		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
> +		cmd_q = &ae4cmd_q->cmd_q;
> +	} else {
> +		cmd_q = &pt->cmd_q;
> +	}
> +
> +	return cmd_q;
> +}
> +
> +static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
>  {
>  	struct pt_passthru_engine *pt_engine;
>  	struct pt_device *pt;
> @@ -54,7 +71,9 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc)
>  
>  	pt_cmd = &desc->pt_cmd;
>  	pt = pt_cmd->pt;
> -	cmd_q = &pt->cmd_q;
> +
> +	cmd_q = pt_get_cmd_queue(pt, chan);
> +
>  	pt_engine = &pt_cmd->passthru;
>  
>  	pt->tdata.cmd = pt_cmd;
> @@ -149,7 +168,7 @@ static void pt_cmd_callback(void *data, int err)
>  		if (!desc)
>  			break;
>  
> -		ret = pt_dma_start_desc(desc);
> +		ret = pt_dma_start_desc(desc, chan);
>  		if (!ret)
>  			break;
>  
> @@ -184,7 +203,10 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>  {
>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>  	struct pt_passthru_engine *pt_engine;
> +	struct pt_device *pt = chan->pt;
> +	struct ae4_cmd_queue *ae4cmd_q;
>  	struct pt_dma_desc *desc;
> +	struct ae4_device *ae4;
>  	struct pt_cmd *pt_cmd;
>  
>  	desc = pt_alloc_dma_desc(chan, flags);
> @@ -192,7 +214,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>  		return NULL;
>  
>  	pt_cmd = &desc->pt_cmd;
> -	pt_cmd->pt = chan->pt;
> +	pt_cmd->pt = pt;
>  	pt_engine = &pt_cmd->passthru;
>  	pt_cmd->engine = PT_ENGINE_PASSTHRU;
>  	pt_engine->src_dma = src;
> @@ -203,6 +225,14 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>  
>  	desc->len = len;
>  
> +	if (pt->ver == AE4_DMA_VERSION) {
> +		ae4 = container_of(pt, struct ae4_device, pt);
> +		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
> +		mutex_lock(&ae4cmd_q->cmd_lock);
> +		list_add_tail(&pt_cmd->entry, &ae4cmd_q->cmd);
> +		mutex_unlock(&ae4cmd_q->cmd_lock);
> +	}
> +
>  	return desc;
>  }
>  
> @@ -260,8 +290,11 @@ static enum dma_status
>  pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
>  		struct dma_tx_state *txstate)
>  {
> -	struct pt_device *pt = to_pt_chan(c)->pt;
> -	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
> +	struct pt_dma_chan *chan = to_pt_chan(c);
> +	struct pt_device *pt = chan->pt;
> +	struct pt_cmd_queue *cmd_q;
> +
> +	cmd_q = pt_get_cmd_queue(pt, chan);
>  
>  	pt_check_status_trans(pt, cmd_q);
>  	return dma_cookie_status(c, cookie, txstate);
> @@ -270,10 +303,13 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
>  static int pt_pause(struct dma_chan *dma_chan)
>  {
>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
> +	struct pt_device *pt = chan->pt;
> +	struct pt_cmd_queue *cmd_q;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&chan->vc.lock, flags);
> -	pt_stop_queue(&chan->pt->cmd_q);
> +	cmd_q = pt_get_cmd_queue(pt, chan);
> +	pt_stop_queue(cmd_q);
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  
>  	return 0;
> @@ -283,10 +319,13 @@ static int pt_resume(struct dma_chan *dma_chan)
>  {
>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>  	struct pt_dma_desc *desc = NULL;
> +	struct pt_device *pt = chan->pt;
> +	struct pt_cmd_queue *cmd_q;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&chan->vc.lock, flags);
> -	pt_start_queue(&chan->pt->cmd_q);
> +	cmd_q = pt_get_cmd_queue(pt, chan);
> +	pt_start_queue(cmd_q);
>  	desc = pt_next_dma_desc(chan);
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  
> @@ -300,11 +339,17 @@ static int pt_resume(struct dma_chan *dma_chan)
>  static int pt_terminate_all(struct dma_chan *dma_chan)
>  {
>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
> +	struct pt_device *pt = chan->pt;
> +	struct pt_cmd_queue *cmd_q;
>  	unsigned long flags;
> -	struct pt_cmd_queue *cmd_q = &chan->pt->cmd_q;
>  	LIST_HEAD(head);
>  
> -	iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_control + 0x0010);
> +	cmd_q = pt_get_cmd_queue(pt, chan);
> +	if (pt->ver == AE4_DMA_VERSION)
> +		pt_stop_queue(cmd_q);
> +	else
> +		iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_control + 0x0010);
> +
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  	vchan_get_all_descriptors(&chan->vc, &head);
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
> @@ -317,14 +362,24 @@ static int pt_terminate_all(struct dma_chan *dma_chan)
>  
>  int pt_dmaengine_register(struct pt_device *pt)
>  {
> -	struct pt_dma_chan *chan;
>  	struct dma_device *dma_dev = &pt->dma_dev;
> -	char *cmd_cache_name;
> +	struct ae4_cmd_queue *ae4cmd_q = NULL;
> +	struct ae4_device *ae4 = NULL;
> +	struct pt_dma_chan *chan;
>  	char *desc_cache_name;
> -	int ret;
> +	char *cmd_cache_name;
> +	int ret, i;
> +
> +	if (pt->ver == AE4_DMA_VERSION)
> +		ae4 = container_of(pt, struct ae4_device, pt);
> +
> +	if (ae4)

in which case would ae4 be null but you are on version 4?

> +		pt->pt_dma_chan = devm_kcalloc(pt->dev, ae4->cmd_q_count,
> +					       sizeof(*pt->pt_dma_chan), GFP_KERNEL);
> +	else
> +		pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
> +					       GFP_KERNEL);
>  
> -	pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
> -				       GFP_KERNEL);
>  	if (!pt->pt_dma_chan)
>  		return -ENOMEM;
>  
> @@ -366,9 +421,6 @@ int pt_dmaengine_register(struct pt_device *pt)
>  
>  	INIT_LIST_HEAD(&dma_dev->channels);
>  
> -	chan = pt->pt_dma_chan;
> -	chan->pt = pt;
> -
>  	/* Set base and prep routines */
>  	dma_dev->device_free_chan_resources = pt_free_chan_resources;
>  	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
> @@ -380,8 +432,21 @@ int pt_dmaengine_register(struct pt_device *pt)
>  	dma_dev->device_terminate_all = pt_terminate_all;
>  	dma_dev->device_synchronize = pt_synchronize;
>  
> -	chan->vc.desc_free = pt_do_cleanup;
> -	vchan_init(&chan->vc, dma_dev);
> +	if (ae4) {
> +		for (i = 0; i < ae4->cmd_q_count; i++) {
> +			chan = pt->pt_dma_chan + i;
> +			ae4cmd_q = &ae4->ae4cmd_q[i];
> +			chan->id = ae4cmd_q->id;
> +			chan->pt = pt;
> +			chan->vc.desc_free = pt_do_cleanup;
> +			vchan_init(&chan->vc, dma_dev);
> +		}
> +	} else {
> +		chan = pt->pt_dma_chan;
> +		chan->pt = pt;
> +		chan->vc.desc_free = pt_do_cleanup;
> +		vchan_init(&chan->vc, dma_dev);
> +	}
>  
>  	ret = dma_async_device_register(dma_dev);
>  	if (ret)
> diff --git a/drivers/dma/amd/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
> index 2690a32fc7cb..a6990021fe2b 100644
> --- a/drivers/dma/amd/ptdma/ptdma.h
> +++ b/drivers/dma/amd/ptdma/ptdma.h
> @@ -184,6 +184,7 @@ struct pt_dma_desc {
>  struct pt_dma_chan {
>  	struct virt_dma_chan vc;
>  	struct pt_device *pt;
> +	u32 id;
>  };
>  
>  struct pt_cmd_queue {
> @@ -262,6 +263,7 @@ struct pt_device {
>  	unsigned long total_interrupts;
>  
>  	struct pt_tasklet_data tdata;
> +	int ver;
>  };
>  
>  /*
> -- 
> 2.25.1

-- 
~Vinod

