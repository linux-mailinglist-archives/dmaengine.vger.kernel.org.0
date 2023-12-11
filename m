Return-Path: <dmaengine+bounces-437-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E3B80C75A
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 11:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A4E1C20C74
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD24B347B6;
	Mon, 11 Dec 2023 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdXAbsnT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3F3454A
	for <dmaengine@vger.kernel.org>; Mon, 11 Dec 2023 10:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6F6C433C8;
	Mon, 11 Dec 2023 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702292084;
	bh=BsHdeJO+VdYNGqLVNFanltGKbE5xp7hh0b7y/NioNh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KdXAbsnTPeBzkUV49rrm+8BHCXL1GrauQEjZ1xD1cTxcDbPT7iRs/dX1nYv/WztM5
	 rYJjRE8VzwyjBaPhoBhI/bQ0pyNcpprQMjHFuuIjwwaSt+IPyDd7ZayTaKcu4NP55m
	 9gtu2S+xvpSrCqTHaKRGughnRlc2AypkgptqRqNBey5ZEuaeeMG8ddgOPTGRC4I+oM
	 OvvxLS1uDPHAZf0/jL2Rn/1yVf1VThaIPiGGijho0AeBrnKyawhnyoPn+7wcVQqvcO
	 EUi5slbpVwiQUkRYH3r1V1yGKe9iH68ga5/vKB3PqTDjPHnc3ZnXPKEPvOepLqbVJT
	 E8dxPIrzf2l8g==
Date: Mon, 11 Dec 2023 16:24:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jan Kuliga <jankul@alatek.krakow.pl>
Cc: lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
	michal.simek@amd.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [FIXED PATCH v4 6/8] dmaengine: xilinx: xdma: Add transfer error
 reporting
Message-ID: <ZXbqcGSL6oVD8YDS@matsya>
References: <9d683987-53db-a53e-9215-3a29f0167183@amd.com>
 <20231208220802.56458-1-jankul@alatek.krakow.pl>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208220802.56458-1-jankul@alatek.krakow.pl>

On 08-12-23, 23:08, Jan Kuliga wrote:
> Extend the capability of transfer status reporting. Introduce error flag,
> which allows to report error in case of a interrupt-reported error
> condition.

Pls post the updated series, noting changes from last rev

> 
> Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
> ---
>  drivers/dma/xilinx/xdma.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index d1bc36133a45..a7cd378b7e9a 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -85,6 +85,7 @@ struct xdma_chan {
>   * @cyclic: Cyclic transfer vs. scatter-gather
>   * @periods: Number of periods in the cyclic transfer
>   * @period_size: Size of a period in bytes in cyclic transfers
> + * @error: tx error flag
>   */
>  struct xdma_desc {
>  	struct virt_dma_desc		vdesc;
> @@ -97,6 +98,7 @@ struct xdma_desc {
>  	bool				cyclic;
>  	u32				periods;
>  	u32				period_size;
> +	bool				error;
>  };
> 
>  #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
> @@ -274,6 +276,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
>  	sw_desc->chan = chan;
>  	sw_desc->desc_num = desc_num;
>  	sw_desc->cyclic = cyclic;
> +	sw_desc->error = false;
>  	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
>  	sw_desc->desc_blocks = kcalloc(dblk_num, sizeof(*sw_desc->desc_blocks),
>  				       GFP_NOWAIT);
> @@ -770,20 +773,20 @@ static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cookie_t cookie
>  	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> 
>  	vd = vchan_find_desc(&xdma_chan->vchan, cookie);
> -	if (vd)
> -		desc = to_xdma_desc(vd);
> -	if (!desc || !desc->cyclic) {
> -		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> -		return ret;
> -	}
> -
> -	period_idx = desc->completed_desc_num % desc->periods;
> -	residue = (desc->periods - period_idx) * desc->period_size;
> +	if (!vd)
> +		goto out;
> 
> +	desc = to_xdma_desc(vd);
> +	if (desc->error) {
> +		ret = DMA_ERROR;
> +	} else if (desc->cyclic) {
> +		period_idx = desc->completed_desc_num % desc->periods;
> +		residue = (desc->periods - period_idx) * desc->period_size;
> +		dma_set_residue(state, residue);
> +	}
> +out:
>  	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
> 
> -	dma_set_residue(state, residue);
> -
>  	return ret;
>  }
> 
> @@ -820,6 +823,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
>  	st &= XDMA_CHAN_STATUS_MASK;
>  	if ((st & XDMA_CHAN_ERROR_MASK) ||
>  		!(st & (CHAN_CTRL_IE_DESC_COMPLETED | CHAN_CTRL_IE_DESC_STOPPED))) {
> +		desc->error = true;
>  		xdma_err(xdev, "channel error, status register value: 0x%x", st);
>  		goto out;
>  	}
> --
> 2.34.1

-- 
~Vinod

