Return-Path: <dmaengine+bounces-5857-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9730CB0F4AA
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 15:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DD91C82CB6
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250D32EF673;
	Wed, 23 Jul 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD72/VPN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78A2EF2A6;
	Wed, 23 Jul 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279003; cv=none; b=Dj6SDcvMUHDFCE6nAeTLrXzXhORgRXgTq5qv0YEM/zbM5p8XIIh1Ww01nosX0RZLsrg/8RFeL6uvOnwz3dAE6aICnOEuVCP6L8OeqGDWYb5cGP26prPlc4yDRXwsNaNhB6QBDn05ceF2KemujgA5anVk8vmWaQdJW7CPFtEtv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279003; c=relaxed/simple;
	bh=5HDITE1NDcFmygkehiv2HaR3n8bW2VfPiUT74Rn+2PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf9pwOci5nZg9Mp2cHhkBhi8+feWsTF1b5fcdHgrNYSRLDN3PsVqdKIAFbnqYFCczvL5NKfMwcW0SIKs7lJn7chw/oZDpT78dKcO+JOJ77lNOnW2jIVwhAw1Ca0tXcQ1ynpAldVMQ5YW/sK4Eqh5DLnFXM6obJltVuvOq54enAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD72/VPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91848C4CEEF;
	Wed, 23 Jul 2025 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753279001;
	bh=5HDITE1NDcFmygkehiv2HaR3n8bW2VfPiUT74Rn+2PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TD72/VPN7qYwaYt+9ZFyaHlXfvT2gVVHk+Vvp2AY/fzPpw8R4/AV2VDzdVIy/4vbg
	 WXwH3HtxZsf6Dji7AQlu4szV74zi4srEwgMgHWDTQtEo+adcqQPqnI51aEdO+7USUd
	 WmFrr8QuBPcgUvcg4kzF9CyTpbhOY4h/MEQKonr1CpZcQUV+Who7haC/sThMGm0J7h
	 xEn7/gt0m/zNt0vVcJ+0vsZ4yUPxuD5s5arYf1QdRR+CNRqhRrqnAkzT1HCk9+vJie
	 fmYgFY8fPdDMkXCfnfWJ7JPO0T22r6IFgVbiXO5bzav4wxn8ER461vOA3SJzSSje02
	 hnEAe64qPx7ug==
Date: Wed, 23 Jul 2025 19:26:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Devendra K Verma <devverma@amd.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vkoul@kernel.org
Subject: Re: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
Message-ID: <d6rtkyelnfhqya6txe7wr6rup7y6riifwzw6tbajopqa5wty6j@3o32khdidnas>
References: <20250623061733.1864392-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623061733.1864392-1-devverma@amd.com>

On Mon, Jun 23, 2025 at 11:47:33AM GMT, Devendra K Verma wrote:
> The HDMA IP supports the simple mode (non-linked list).
> In this mode the channel registers are configured to initiate
> a single DMA data transfer. The channel can be configured in
> simple mode via peripheral param of dma_slave_config param.
> 
> Signed-off-by: Devendra K Verma <devverma@amd.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 10 +++++
>  drivers/dma/dw-edma/dw-edma-core.h    |  2 +
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 53 ++++++++++++++++++++++++++-
>  include/linux/dma/edma.h              |  8 ++++
>  4 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2b88cc99e5d..4dafd6554277 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -235,9 +235,19 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	struct dw_edma_peripheral_config *pconfig = config->peripheral_config;
> +	unsigned long flags;
> +
> +	if (WARN_ON(config->peripheral_config &&
> +		    config->peripheral_size != sizeof(*pconfig)))
> +		return -EINVAL;
>  
> +	spin_lock_irqsave(&chan->vc.lock, flags);
>  	memcpy(&chan->config, config, sizeof(*config));
> +
> +	chan->non_ll_en = pconfig ? pconfig->non_ll_en : false;

Who is allocating 'dw_edma_peripheral_config' and setting 'non_ll_en' flag? We
cannot introduce a flag without anyone using it in upstream.

- Mani

>  	chan->configured = true;
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  
>  	return 0;
>  }
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 71894b9e0b15..c0266976aa22 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -86,6 +86,8 @@ struct dw_edma_chan {
>  	u8				configured;
>  
>  	struct dma_slave_config		config;
> +
> +	bool				non_ll_en;
>  };
>  
>  struct dw_edma_irq {
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index e3f8db4fe909..3237c807a18e 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
>  		readl(chunk->ll_region.vaddr.io);
>  }
>  
> -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +static void dw_hdma_v0_ll_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> @@ -263,6 +263,57 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
>  }
>  
> +static void dw_hdma_v0_non_ll_start(struct dw_edma_chunk *chunk)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +	struct dw_edma *dw = chan->dw;
> +	struct dw_edma_burst *child;
> +	u32 val;
> +
> +	list_for_each_entry(child, &chunk->burst->list, list) {
> +		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> +
> +		/* Source address */
> +		SET_CH_32(dw, chan->dir, chan->id, sar.lsb, lower_32_bits(child->sar));
> +		SET_CH_32(dw, chan->dir, chan->id, sar.msb, upper_32_bits(child->sar));
> +
> +		/* Destination address */
> +		SET_CH_32(dw, chan->dir, chan->id, dar.lsb, lower_32_bits(child->dar));
> +		SET_CH_32(dw, chan->dir, chan->id, dar.msb, upper_32_bits(child->dar));
> +
> +		/* Transfer size */
> +		SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
> +
> +		/* Interrupt setup */
> +		val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> +				HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
> +				HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> +
> +		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +			val |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
> +
> +		SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> +
> +		/* Channel control setup */
> +		val = GET_CH_32(dw, chan->dir, chan->id, control1);
> +		val &= ~HDMA_V0_LINKLIST_EN;
> +		SET_CH_32(dw, chan->dir, chan->id, control1, val);
> +
> +		/* Ring the doorbell */
> +		SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
> +	}
> +}
> +
> +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +
> +	if (!chan->non_ll_en)
> +		dw_hdma_v0_ll_start(chunk, first);
> +	else
> +		dw_hdma_v0_non_ll_start(chunk);
> +}
> +
>  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3080747689f6..82d808013a66 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -101,6 +101,14 @@ struct dw_edma_chip {
>  	struct dw_edma		*dw;
>  };
>  
> +/**
> + * struct dw_edma_peripheral_config - peripheral spicific configurations
> + * @non_ll_en:		 enable non-linked list mode of operations
> + */
> +struct dw_edma_peripheral_config {
> +	bool			non_ll_en;
> +};
> +
>  /* Export to the platform drivers */
>  #if IS_REACHABLE(CONFIG_DW_EDMA)
>  int dw_edma_probe(struct dw_edma_chip *chip);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

