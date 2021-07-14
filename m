Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DE63C7E6C
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 08:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbhGNGSI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 02:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237958AbhGNGSH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 02:18:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E46FE6127C;
        Wed, 14 Jul 2021 06:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626243316;
        bh=KUK1LwW20wP3EqcQiPE5rpv4X3DjPYHIE3Ahfa2rIKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0RtBQ0mFpIz2J0df4y5K1QZ1k182MYXSVBsATd0Oo2x2rqVZSBrgzyQkv7ODRa4D
         yxm2z4io/KAxDlYSO3EHTTnN+JRo3oDNfTEK4s1rKOy2neAGyfg+bePaY8+l9xC5ZX
         KZYCHdXF/BFs4UrQmq1wrW4G90Qt1HTn9i/MdThDm/ZJNIQFUDa0EmiQo2yv7c8HW1
         4JD4+ZDNoc/JnOK0K//vj9ng8aKX8dzikRogVkbgdA+Nwgq7KBwWUmFvSlgnnVBa8z
         aoiH3jVLp+8Np971wMHELoJS8V1jf56iQAU9wIBiMyEezeSxSwZQMxQMjJZE8lc8+E
         ZkDqXP+fa5f1Q==
Date:   Wed, 14 Jul 2021 11:45:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Message-ID: <YO6A8KXRSvqUN6pL@matsya>
References: <20210702100527.28251-1-biju.das.jz@bp.renesas.com>
 <20210702100527.28251-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702100527.28251-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-07-21, 11:05, Biju Das wrote:

> +static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr,
> +				       u32 dmars)
> +{
> +	u32 dmars_offset = (nr / 2) * 4;
> +	u32 dmars32;
> +
> +	dmars32 = rz_dmac_ext_readl(dmac, dmars_offset);
> +	if (nr % 2) {
> +		dmars32 &= 0x0000ffff;
> +		dmars32 |= dmars << 16;
> +	} else {
> +		dmars32 &= 0xffff0000;
> +		dmars32 |= dmars;
> +	}

how about using upper_16_bits() and lower_16_bits() for extracting
above?

> +static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
> +{
> +	struct dma_chan *chan = &channel->vc.chan;
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
> +	struct rz_dmac_desc *d = channel->desc;
> +	u32 chcfg = CHCFG_MEM_COPY;
> +	u32 dmars = 0;
> +
> +	lmdesc = channel->lmdesc.tail;
> +
> +	/* prepare descriptor */
> +	lmdesc->sa = d->src;
> +	lmdesc->da = d->dest;
> +	lmdesc->tb = d->len;
> +	lmdesc->chcfg = chcfg;
> +	lmdesc->chitvl = 0;
> +	lmdesc->chext = 0;
> +	lmdesc->header = HEADER_LV;
> +
> +	rz_dmac_set_dmars_register(dmac, channel->index, dmars);

why not pass 0 as last arg and remove dmars?

> +static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	return dma_cookie_status(chan, cookie, txstate);
> +}

why not assign status as dma_cookie_status and remove
rz_dmac_tx_status()

> +static int rz_dmac_config(struct dma_chan *chan,
> +			  struct dma_slave_config *config)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	u32 *ch_cfg;
> +	u32 val;
> +
> +	if (config->direction == DMA_DEV_TO_MEM) {

config->direction is deprecated, pls save the dma_slave_config here and
then use based on txn direction...

> +static bool rz_dmac_chan_filter(struct dma_chan *chan, void *arg)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	struct of_phandle_args *dma_spec = arg;
> +
> +	if (chan->device->device_config != rz_dmac_config)
> +		return false;

which cases would this be false?

> +
> +	channel->mid_rid = dma_spec->args[0];
> +
> +	return !test_and_set_bit(dma_spec->args[0], dmac->modules);
> +}
> +
> +static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	dma_cap_mask_t mask;
> +
> +	if (dma_spec->args_count != 1)
> +		return NULL;
> +
> +	/* Only slave DMA channels can be allocated via DT */
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	return dma_request_channel(mask, rz_dmac_chan_filter, dma_spec);
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * Probe and remove
> + */

we use
/*
 * this style
 * multi-line comments
 */
-- 
~Vinod
