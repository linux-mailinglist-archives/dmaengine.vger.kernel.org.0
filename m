Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1262D6D1FD9
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjCaMRG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjCaMRF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:17:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1ED1DF90;
        Fri, 31 Mar 2023 05:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44056B82E25;
        Fri, 31 Mar 2023 12:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB24C433D2;
        Fri, 31 Mar 2023 12:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680265020;
        bh=9Admhwyx0Gd6z/BIY82sHKwSBKVyNW3s7E6o0Jl6iok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSd3mar5ihSZi0vhk9h35f78m+tbzvVoTZgD/lHxsmpX0rOAEYhLw4NGAx2UfD1iT
         1GOqkMBYZAMEDy1PH+gTdqWwcmndLqQqaDos1M5RRyQmYX7d6kEgVEx+DuEdAg+F6U
         BRhXYm/0XnWqSHNv6VLDnCcJP/rjg2LM8/hymO0HgDZbNJWprTj15dHR9hdpbGdOjr
         UOd0YTXzKGIskrvcshA7+mrGAYNEmD6BDz9DhhwqF7Q9w2wokg2Ui337RUlDAwmkWL
         88MGXX2FAg5j7YxiIWepqvSjQdq7pif5wKL3OX4AOybwiGbkzS8V/p1uvqbkYOBF1i
         08SVfyZB90JMg==
Date:   Fri, 31 Mar 2023 17:46:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/3] dmaengine: sh: rz-dmac: Add device_tx_status()
 callback
Message-ID: <ZCbPOODVqQQmv/TT@matsya>
References: <20230324094957.115071-1-biju.das.jz@bp.renesas.com>
 <20230324094957.115071-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324094957.115071-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-03-23, 09:49, Biju Das wrote:
> The device_tx_status() callback is needed for serial DMA (RZ/G2L
> SCIFA). Add support for device_tx_status() callback.
> 
> Based on a patch in the BSP by Long Luu similar to rcar-dmac
> <long.luu.ur@renesas.com>
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/dma/sh/rz-dmac.c | 169 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 168 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index a04a37ce03fd..3625925d9f9f 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -110,10 +110,12 @@ struct rz_dmac {
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
> @@ -655,6 +657,171 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
>  	rz_dmac_set_dmars_register(dmac, channel->index, 0);
>  }
>  
> +static unsigned int calculate_total_bytes_in_vd(struct rz_dmac_desc *desc)
> +{
> +	struct scatterlist *sg, *sgl = desc->sg;
> +	unsigned int i, size, sg_len = desc->sgcount;
> +
> +	for (i = 0, size = 0, sg = sgl; i < sg_len; i++, sg = sg_next(sg))
> +		size += sg_dma_len(sg);

for_each_sg() ?

> +
> +	return size;
> +}
> +
> +static unsigned int calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel)
> +{
> +	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
> +	struct dma_chan *chan = &channel->vc.chan;
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	unsigned int residue = 0, i = 0;
> +	unsigned int crla;
> +
> +	/* get current lmdesc */
> +	crla = rz_dmac_ch_readl(channel, CRLA, 1);
> +	while (!(lmdesc->nxla == crla)) {
> +		lmdesc++;
> +		if (lmdesc >= (channel->lmdesc.base + DMAC_NR_LMDESC))
> +			lmdesc = channel->lmdesc.base;
> +		i++;
> +		/* Not found current lmdesc */
> +		if (i > DMAC_NR_LMDESC)
> +			return 0;
> +	}
> +
> +	/* Point to current processing lmdesc in hardware */
> +	lmdesc++;
> +	if (lmdesc >= (channel->lmdesc.base + DMAC_NR_LMDESC))
> +		lmdesc = channel->lmdesc.base;
> +
> +	/* Calculate residue from next lmdesc to end of virtual desc*/
> +	while (lmdesc->chcfg & CHCFG_DEM) {
> +		lmdesc++;
> +		if (lmdesc >= (channel->lmdesc.base + DMAC_NR_LMDESC))
> +			lmdesc = channel->lmdesc.base;
> +		residue += lmdesc->tb;
> +	}
> +
> +	dev_dbg(dmac->dev, "%s: Getting residue is %d\n", __func__, residue);
> +
> +	return residue;
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
> +
> +		list_for_each_entry(desc, &channel->ld_queue, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return calculate_total_bytes_in_vd(desc);
> +		}
> +
> +		list_for_each_entry(desc, &channel->ld_active, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return calculate_total_bytes_in_vd(desc);
> +		}
> +
> +		/*
> +		 * No descriptor found for the cookie, there's thus no residue.
> +		 * This shouldn't happen if the calling driver passes a correct
> +		 * cookie value.
> +		 */
> +		WARN(1, "No descriptor for cookie!");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Correspond to the currently processing virtual descriptor
> +	 *
> +	 * Make sure the hardware does not move to next lmdesc
> +	 * while reading the counter.
> +	 * Trying it 3 times should be enough: Initial read, retry, retry
> +	 * for the paranoid.
> +	 * The current lmdesc running in hardware is channel.lmdesc.head
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
> +	residue += calculate_residue_bytes_in_vd(channel);
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
>  /*
>   * -----------------------------------------------------------------------------
>   * IRQ handling
> @@ -937,7 +1104,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  
>  	engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
>  	engine->device_free_chan_resources = rz_dmac_free_chan_resources;
> -	engine->device_tx_status = dma_cookie_status;
> +	engine->device_tx_status = rz_dmac_tx_status;
>  	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
>  	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
>  	engine->device_config = rz_dmac_config;
> -- 
> 2.25.1

-- 
~Vinod
