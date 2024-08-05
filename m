Return-Path: <dmaengine+bounces-2798-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A423948054
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5191F284BE0
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10453E479;
	Mon,  5 Aug 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="komo7i2o"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976C17C64;
	Mon,  5 Aug 2024 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879098; cv=none; b=ah0fKlnxz7bBKDPsOLUC9iPqbgH7p/pl6LstctHdkzUklaEP3GZg14hLxHOo5GCrYkB9DZPSQtF1EfsSax/eTCA7nlhyjHDUkQqm19b2Ohl+UEVuSti7SpgqAI5aTN83+GQy6yZfhSM5Totu0a8QVGXMxloE7S4XF3HTd+TMCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879098; c=relaxed/simple;
	bh=jK/A/zJS1iUqWDS3vi10emhlxiXkHJJXac7va2y2nuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s555ScFb/70cHXLKwnFzgNg8/GiR1HRYqVKWZJ8qiQcX31fojXv/r6PxfSwedbc/prGmcZF/JpYQqGyx2LhD83dTDzlarQFPgdN5+qROKoeXzMSy8CDgxUYx84B0aLJRioFOG44BOUczJqAInlcl+FOXAw7VSKG1/Se62FyEHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=komo7i2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CF0C32782;
	Mon,  5 Aug 2024 17:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722879098;
	bh=jK/A/zJS1iUqWDS3vi10emhlxiXkHJJXac7va2y2nuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=komo7i2o9mK3uIGzWKBTv1UXqXDv9E6CBtz2OiN9e2wYppJos4PpeCTsNyIWpb6nJ
	 4a4MubQHLWqlm64yLWlFfl5UnyH+MZPk/P5dmbVJipJ3xapeloRoGCIrJSRIrVgaCe
	 zRiX3t9WlmSNeKXTk23+Kr/Q58NpuUnbzOLp+CxsKNTzHxmtdQ8kIsuBfmVQCu2clE
	 fKsaCrLTz10kVbdGOQKfn0rLbk/rg/u/Mgn2hB8baMGymVK+NZAcYsqoCOdwyZ1SrH
	 r5A7HpoqmrLoexSY12C08p3fCpAAHjIy1+liNX8Ug/t9MVtcIxo9wDIs/PyOwYrCWU
	 9t+LMSFSWXkrw==
Date: Mon, 5 Aug 2024 23:01:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Pavel Machek <pavel@denx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	dmaengine@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Add support for SCIF DMA
Message-ID: <ZrEMdmqAMX2sctvv@matsya>
References: <20240628151728.84470-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628151728.84470-1-biju.das.jz@bp.renesas.com>

On 28-06-24, 16:17, Biju Das wrote:
> The sh_sci driver supports dma with pio mode as fallback. When the DMA Rx
> time out happens, it switches to pio mode and the timer function has the
> below dma callbacks
> 
> rx_timer_fn() of the sh-sci.c:
> 	dmaengine_pause();		/* [1] */
> 	...
> 	dmaengine_tx_status();		/* [2] */
> 	...
> 	dmaengine_terminate_all();	/* [3] */
> 
> Update [1] to re-enable the interrupt by clearing the DMARS. RZ/G2L SoC
> use the same signal for both interrupt and DMA transfer requests. The
> signal works as a DMA transfer request signal by setting DMARS, and
> subsequent interrupt requests to the interrupt controller are
> masked.
> 
> Update [2] to calculate residue, so that sh_sci driver can work on
> leftover data from DMA operation during pio mode.
> 
> Update [3] to invalidate hw descriptors for reuse.

Can you split to each patch, we are doing too many things here

> 
> Based on similar work done for rcar_dmac for supporting scif dma.
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 193 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 192 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 65a27c5a7bce..3ef4dda51c8e 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -109,10 +109,12 @@ struct rz_dmac {
>   * Registers
>   */
>  
> +#define CRTB				0x0020
>  #define CHSTAT				0x0024
>  #define CHCTRL				0x0028
>  #define CHCFG				0x002c
>  #define NXLA				0x0038
> +#define CRLA				0x003c
>  
>  #define DCTRL				0x0000
>  
> @@ -533,11 +535,15 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  static int rz_dmac_terminate_all(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
>  	unsigned long flags;
>  	LIST_HEAD(head);
>  
>  	rz_dmac_disable_hw(channel);
>  	spin_lock_irqsave(&channel->vc.lock, flags);
> +	for (; lmdesc < channel->lmdesc.base + DMAC_NR_LMDESC; lmdesc++)
> +		lmdesc->header = 0;

Why reset header (each patch would tell us that)

> +
>  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
>  	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
>  	vchan_get_all_descriptors(&channel->vc, &head);
> @@ -647,6 +653,190 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
>  	rz_dmac_set_dmars_register(dmac, channel->index, 0);
>  }
>  
> +static struct rz_lmdesc *
> +rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
> +{
> +	struct rz_lmdesc *next = lmdesc++;
> +
> +	if (next >= base + DMAC_NR_LMDESC)
> +		next = base;
> +
> +	return next;
> +}
> +
> +static unsigned int
> +rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel)
> +{
> +	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
> +	struct dma_chan *chan = &channel->vc.chan;
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	unsigned int residue = 0, i = 0;
> +	unsigned int crla;
> +
> +	crla = rz_dmac_ch_readl(channel, CRLA, 1);
> +	while (!(lmdesc->nxla == crla)) {
> +		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		if (i++ > DMAC_NR_LMDESC)
> +			return 0;
> +	}
> +
> +	/* Get current processing lmdesc in hardware */
> +	lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +	/* Calculate residue from next lmdesc to end of virtual desc*/
> +	while (lmdesc->chcfg & CHCFG_DEM) {
> +		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		residue += lmdesc->tb;
> +	}
> +
> +	dev_dbg(dmac->dev, "%s: Getting residue is %d\n", __func__, residue);
> +
> +	return residue;
> +}
> +
> +static unsigned int rz_dmac_calculate_total_bytes_in_vd(struct rz_dmac_desc *desc)
> +{
> +	unsigned int i, size = 0;
> +	struct scatterlist *sg;
> +
> +	for_each_sg(desc->sg, sg, desc->sgcount, i)
> +		size += sg_dma_len(sg);
> +
> +	return size;
> +}
> +
> +static unsigned int rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
> +					     dma_cookie_t cookie)
> +{
> +	struct rz_dmac_desc *current_desc, *desc;
> +	enum dma_status status;
> +	unsigned int residue;
> +	unsigned int crla;
> +	unsigned int crtb;
> +	unsigned int i;
> +
> +	/* Get current processing virtual descriptor */
> +	current_desc = list_first_entry(&channel->ld_active,
> +					struct rz_dmac_desc, node);
> +	if (!current_desc)
> +		return 0;
> +
> +	/*
> +	 * If the cookie corresponds to a descriptor that has been completed
> +	 * there is no residue. The same check has already been performed by the
> +	 * caller but without holding the channel lock, so the descriptor could
> +	 * now be complete.
> +	 */
> +	status = dma_cookie_status(&channel->vc.chan, cookie, NULL);
> +	if (status == DMA_COMPLETE)
> +		return 0;
> +
> +	/*
> +	 * If the cookie doesn't correspond to the currently processing virtual
> +	 * descriptor then the descriptor hasn't been processed yet, and the
> +	 * residue is equal to the full descriptor size.
> +	 * Also, a client driver is possible to call this function before
> +	 * rz_dmac_irq_handler_thread() runs. In this case, the running
> +	 * descriptor will be the next descriptor, and the done list will
> +	 * appear. So, if the argument cookie matches the done list's cookie,
> +	 * we can assume the residue is zero.
> +	 */
> +	if (cookie != current_desc->vd.tx.cookie) {
> +		list_for_each_entry(desc, &channel->ld_free, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return 0;
> +		}

hmmm, why would check free list?

> +
> +		list_for_each_entry(desc, &channel->ld_queue, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return rz_dmac_calculate_total_bytes_in_vd(desc);
> +		}

Or pending?

> +
> +		list_for_each_entry(desc, &channel->ld_active, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return rz_dmac_calculate_total_bytes_in_vd(desc);
> +		}

This would be only case to makes sense

> +
> +		/*
> +		 * No descriptor found for the cookie, there's thus no residue.
> +		 * This shouldn't happen if the calling driver passes a correct
> +		 * cookie value.
> +		 */
> +		WARN_ONCE(1, "No descriptor for cookie!");
> +		return 0;
> +	}
> +
> +	/*
> +	 * We need to read two registers.
> +	 * Make sure the hardware does not move to next lmdesc while reading
> +	 * the current lmdesc.
> +	 * Trying it 3 times should be enough: Initial read, retry, retry
> +	 * for the paranoid.
> +	 */
> +	for (i = 0; i < 3; i++) {
> +		crla = rz_dmac_ch_readl(channel, CRLA, 1);
> +		crtb = rz_dmac_ch_readl(channel, CRTB, 1);
> +		/* Still the same? */
> +		if (crla == rz_dmac_ch_readl(channel, CRLA, 1))
> +			break;
> +	}
> +
> +	WARN_ONCE(i >= 3, "residue might be not continuous!");
> +
> +	/*
> +	 * Calculate number of byte transferred in processing virtual descriptor
> +	 * One virtual descriptor can have many lmdesc
> +	 */
> +	residue = crtb;
> +	residue += rz_dmac_calculate_residue_bytes_in_vd(channel);
> +
> +	return residue;
> +}
> +
> +static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	enum dma_status status;
> +	unsigned int residue;
> +	unsigned long flags;
> +
> +	status = dma_cookie_status(chan, cookie, txstate);
> +	if (status == DMA_COMPLETE || !txstate)
> +		return status;
> +
> +	spin_lock_irqsave(&channel->vc.lock, flags);
> +	residue = rz_dmac_chan_get_residue(channel, cookie);
> +	spin_unlock_irqrestore(&channel->vc.lock, flags);
> +
> +	/* if there's no residue, the cookie is complete */
> +	if (!residue)
> +		return DMA_COMPLETE;
> +
> +	dma_set_residue(txstate, residue);
> +
> +	return status;
> +}
> +
> +static int rz_dmac_device_pause(struct dma_chan *chan)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	unsigned int i;
> +	u32 chstat;
> +
> +	for (i = 0; i < 1024; i++) {
> +		chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
> +		if (!(chstat & CHSTAT_EN))
> +			break;
> +		udelay(1);
> +	}
> +
> +	rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +
> +	return 0;
> +}
> +
>  /*
>   * -----------------------------------------------------------------------------
>   * IRQ handling
> @@ -929,13 +1119,14 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  
>  	engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
>  	engine->device_free_chan_resources = rz_dmac_free_chan_resources;
> -	engine->device_tx_status = dma_cookie_status;
> +	engine->device_tx_status = rz_dmac_tx_status;
>  	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
>  	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
>  	engine->device_config = rz_dmac_config;
>  	engine->device_terminate_all = rz_dmac_terminate_all;
>  	engine->device_issue_pending = rz_dmac_issue_pending;
>  	engine->device_synchronize = rz_dmac_device_synchronize;
> +	engine->device_pause = rz_dmac_device_pause;
>  
>  	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
>  	dma_set_max_seg_size(engine->dev, U32_MAX);
> -- 
> 2.43.0

-- 
~Vinod

