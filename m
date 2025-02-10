Return-Path: <dmaengine+bounces-4390-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FB6A2EF86
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 15:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337DA7A1D95
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC5236A90;
	Mon, 10 Feb 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVLTyNQA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B3236A7F
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197100; cv=none; b=StFhf/I7u1z1WpeqJYBWOMKuYD2YITmQRoM/LJ+aZiKwS9R83X8PKD4cY5675FyMBNxCkCLuUs4bteIVKqBjtZ9bqKUVD4ekMJfKBVNS2Vm1ICmCanviHFA0f7v/S3n9hfVGLUjHK0qnChfrZfFY/HwKaa3S0EnhBPWE6Zn+oCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197100; c=relaxed/simple;
	bh=EvjMa8+c7HHvD3yvTaB4h2HHEx5AdgEMLVMypR7W87Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTC/MTQfKGw+SsgLNYaYMQ1qVmPWWNNzxUtylxTcrh9DO24nUxF6WynyKZ+q7IqPbaMx7EedpTg/qzzjiErhmi1+Rwl40DUGVpsxN0kQ1qVIbEJTKsanQUN2QNnt0+ZC4nYka3TZNBb4ubLMlqwTxx4Nfm+7d9FjZ2g9/CgFT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVLTyNQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04499C4CED1;
	Mon, 10 Feb 2025 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739197100;
	bh=EvjMa8+c7HHvD3yvTaB4h2HHEx5AdgEMLVMypR7W87Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PVLTyNQAQROmPVDG3bLrDWyzWoRhoVfgEg5b2E94fXGBVnZTo4u1LrBIP7C5xSrs2
	 4HVGE/MR/9KiN9VKhzGgdA/OlROdSashOr0gxHFtANMCtpMGrE7R563gqjH5JOh94Q
	 3Z2gRyFwMYLqDsh3FGsBS9+8w9QjLtiXYlTG31gsgr7aJf6V+xr0YofhxR0D1zCUEL
	 KLFFo4Js0IqZlDCnaaqj69Vi2QYDvCi0IpEudD1CxP6oZdLpxY+j+qVh/HKoB9xmv8
	 eV+pBjG/qtw/o6b8g5MSV/u4U5KZ/RWK5i4/J29prYh3pxtWh/uCevfbnpBipHgZ3h
	 w4zuLmkpYjfqQ==
Date: Mon, 10 Feb 2025 19:48:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org
Subject: Re: [PATCH 3/3] dmaengine: ptdma: Utilize the AE4DMA engine's
 multi-queue functionality
Message-ID: <Z6oKqKncVc9AL2Tb@vaman>
References: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
 <20250203162511.911946-4-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250203162511.911946-4-Basavaraj.Natikar@amd.com>

On 03-02-25, 21:55, Basavaraj Natikar wrote:
> As AE4DMA offers multi-channel functionality compared to PTDMA’s single
> queue, utilize multi-queue, which supports higher speeds than PTDMA, to
> achieve higher performance using the AE4DMA workqueue based mechanism.
> 
> Fixes: 69a47b16a51b ("dmaengine: ptdma: Extend ptdma to support multi-channel and version")

Why is this a fix, again!

> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  drivers/dma/amd/ae4dma/ae4dma.h         |  2 +
>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 90 ++++++++++++++++++++++++-
>  2 files changed, 89 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
> index 265c5d436008..57f6048726bb 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma.h
> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
> @@ -37,6 +37,8 @@
>  #define AE4_DMA_VERSION			4
>  #define CMD_AE4_DESC_DW0_VAL		2
>  
> +#define AE4_TIME_OUT			5000
> +
>  struct ae4_msix {
>  	int msix_count;
>  	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index 35c84ec9608b..715ac3ae067b 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -198,8 +198,10 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>  {
>  	struct dma_async_tx_descriptor *tx_desc;
>  	struct virt_dma_desc *vd;
> +	struct pt_device *pt;
>  	unsigned long flags;
>  
> +	pt = chan->pt;
>  	/* Loop over descriptors until one is found with commands */
>  	do {
>  		if (desc) {
> @@ -217,7 +219,7 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>  
>  		spin_lock_irqsave(&chan->vc.lock, flags);
>  
> -		if (desc) {
> +		if (pt->ver != AE4_DMA_VERSION && desc) {
>  			if (desc->status != DMA_COMPLETE) {
>  				if (desc->status != DMA_ERROR)
>  					desc->status = DMA_COMPLETE;
> @@ -235,7 +237,7 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>  
>  		spin_unlock_irqrestore(&chan->vc.lock, flags);
>  
> -		if (tx_desc) {
> +		if (pt->ver != AE4_DMA_VERSION && tx_desc) {

Why should this handling be different for DMA_VERSION?

>  			dmaengine_desc_get_callback_invoke(tx_desc, NULL);
>  			dma_run_dependencies(tx_desc);
>  			vchan_vdesc_fini(vd);
> @@ -245,11 +247,25 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
>  	return NULL;
>  }
>  
> +static inline bool ae4_core_queue_full(struct pt_cmd_queue *cmd_q)
> +{
> +	u32 front_wi = readl(cmd_q->reg_control + AE4_WR_IDX_OFF);
> +	u32 rear_ri = readl(cmd_q->reg_control + AE4_RD_IDX_OFF);
> +
> +	if (((MAX_CMD_QLEN + front_wi - rear_ri) % MAX_CMD_QLEN)  >= (MAX_CMD_QLEN - 1))
> +		return true;
> +
> +	return false;
> +}
> +
>  static void pt_cmd_callback(void *data, int err)
>  {
>  	struct pt_dma_desc *desc = data;
> +	struct ae4_cmd_queue *ae4cmd_q;
>  	struct dma_chan *dma_chan;
>  	struct pt_dma_chan *chan;
> +	struct ae4_device *ae4;
> +	struct pt_device *pt;
>  	int ret;
>  
>  	if (err == -EINPROGRESS)
> @@ -257,11 +273,32 @@ static void pt_cmd_callback(void *data, int err)
>  
>  	dma_chan = desc->vd.tx.chan;
>  	chan = to_pt_chan(dma_chan);
> +	pt = chan->pt;
>  
>  	if (err)
>  		desc->status = DMA_ERROR;
>  
>  	while (true) {
> +		if (pt->ver == AE4_DMA_VERSION) {
> +			ae4 = container_of(pt, struct ae4_device, pt);
> +			ae4cmd_q = &ae4->ae4cmd_q[chan->id];
> +
> +			if (ae4cmd_q->q_cmd_count >= (CMD_Q_LEN - 1) ||
> +			    ae4_core_queue_full(&ae4cmd_q->cmd_q)) {
> +				wake_up(&ae4cmd_q->q_w);
> +
> +				if (wait_for_completion_timeout(&ae4cmd_q->cmp,
> +								msecs_to_jiffies(AE4_TIME_OUT))
> +								== 0) {
> +					dev_err(pt->dev, "TIMEOUT %d:\n", ae4cmd_q->id);
> +					break;
> +				}
> +
> +				reinit_completion(&ae4cmd_q->cmp);
> +				continue;
> +			}
> +		}
> +
>  		/* Check for DMA descriptor completion */
>  		desc = pt_handle_active_desc(chan, desc);
>  
> @@ -296,6 +333,49 @@ static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
>  	return desc;
>  } 
>  
> +static void pt_cmd_callback_work(void *data, int err)
> +{
> +	struct dma_async_tx_descriptor *tx_desc;
> +	struct pt_dma_desc *desc = data;
> +	struct dma_chan *dma_chan;
> +	struct virt_dma_desc *vd;
> +	struct pt_dma_chan *chan;
> +	unsigned long flags;
> +
> +	dma_chan = desc->vd.tx.chan;
> +	chan = to_pt_chan(dma_chan);
> +
> +	if (err == -EINPROGRESS)
> +		return;
> +
> +	tx_desc = &desc->vd.tx;
> +	vd = &desc->vd;
> +
> +	if (err)
> +		desc->status = DMA_ERROR;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +	if (desc) {
> +		if (desc->status != DMA_COMPLETE) {
> +			if (desc->status != DMA_ERROR)
> +				desc->status = DMA_COMPLETE;
> +
> +			dma_cookie_complete(tx_desc);
> +			dma_descriptor_unmap(tx_desc);
> +		} else {
> +			tx_desc = NULL;
> +		}
> +	}
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	if (tx_desc) {
> +		dmaengine_desc_get_callback_invoke(tx_desc, NULL);
> +		dma_run_dependencies(tx_desc);
> +		list_del(&desc->vd.node);
> +		vchan_vdesc_fini(vd);
> +	}
> +}

Why do we have callback in driver...?

> +
>  static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>  					  dma_addr_t dst,
>  					  dma_addr_t src,
> @@ -327,6 +407,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>  	desc->len = len;
>  
>  	if (pt->ver == AE4_DMA_VERSION) {
> +		pt_cmd->pt_cmd_callback = pt_cmd_callback_work;
>  		ae4 = container_of(pt, struct ae4_device, pt);
>  		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
>  		mutex_lock(&ae4cmd_q->cmd_lock);
> @@ -367,13 +448,16 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>  {
>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>  	struct pt_dma_desc *desc;
> +	struct pt_device *pt;
>  	unsigned long flags;
>  	bool engine_is_idle = true;
>  
> +	pt = chan->pt;
> +
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  
>  	desc = pt_next_dma_desc(chan);
> -	if (desc)
> +	if (desc && pt->ver != AE4_DMA_VERSION)
>  		engine_is_idle = false;
>  
>  	vchan_issue_pending(&chan->vc);
> -- 
> 2.25.1

-- 
~Vinod

