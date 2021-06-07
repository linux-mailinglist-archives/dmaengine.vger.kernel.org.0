Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0639DAA6
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 13:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFGLJC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 07:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhFGLJC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Jun 2021 07:09:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99C4E60FF2;
        Mon,  7 Jun 2021 11:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623064031;
        bh=XXIzcNn0RfGrbstV7HqbdbJu6dyRY4Wigc4ycJ5cQAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCHcXrAYH6lYO04Q1YOP/5j+Y/z78DgbM9QO3dK7sackBRR7JTleFkFPkZVP/OAjB
         OIHE0TxF2gXIqBwvb2sGo8LFn5fbNSnintYjs9yughUH4XwSvHVdhKknqg/0eUb9ZA
         5ARqT8d4oN0uYHXJYFtGtZHEsiNAt7A5lnAycRgshjZHrNqcmMMhj8h/w/8OATBFq4
         B2yVZJcHZVnpRfIDRYeiBV4bmKXRyelr/gnAT+Al4YGybZuPaXT5pk/RLXkrX5hbYD
         afYCA0ux1AUGutkUnhXQXsHv1gElNu+kV9r2B6S/002ySyWOnKKfdUsbC0sZtQcLmi
         BAiM6MCqkhD6w==
Date:   Mon, 7 Jun 2021 16:37:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 RESEND] dmaengine: Loongson1: Add Loongson1 dmaengine
 driver
Message-ID: <YL392y4a6iRf1UyQ@vkoul-mobl>
References: <20210520230225.11911-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520230225.11911-1-keguang.zhang@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-05-21, 07:02, Keguang Zhang wrote:

> +config LOONGSON1_DMA
> +	tristate "Loongson1 DMA support"
> +	depends on MACH_LOONGSON32

Why does it have to do that? The dma driver is generic..

> +static int ls1x_dma_alloc_chan_resources(struct dma_chan *dchan)
> +{
> +	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
> +
> +	chan->desc_pool = dma_pool_create(dma_chan_name(dchan),
> +					  dchan->device->dev,
> +					  sizeof(struct ls1x_dma_lli),
> +					  __alignof__(struct ls1x_dma_lli), 0);
> +	if (!chan->desc_pool) {
> +		dev_err(chan2dev(dchan),
> +			"failed to alloc DMA descriptor pool!\n");

This can be dropped, allocators will warn you for the allocation
failures

> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ls1x_dma_free_desc(struct virt_dma_desc *vdesc)
> +{
> +	struct ls1x_dma_desc *desc = to_ls1x_dma_desc(vdesc);
> +
> +	if (desc->nr_descs) {
> +		unsigned int i = desc->nr_descs;
> +		struct ls1x_dma_hwdesc *hwdesc;
> +
> +		do {
> +			hwdesc = &desc->hwdesc[--i];
> +			dma_pool_free(desc->chan->desc_pool, hwdesc->lli,
> +				      hwdesc->phys);
> +		} while (i);
> +	}
> +
> +	kfree(desc);
> +}
> +
> +static struct ls1x_dma_desc *ls1x_dma_alloc_desc(struct ls1x_dma_chan *chan,
> +						 int sg_len)

single line now :)

> +{
> +	struct ls1x_dma_desc *desc;
> +	struct dma_chan *dchan = &chan->vchan.chan;
> +
> +	desc = kzalloc(struct_size(desc, hwdesc, sg_len), GFP_NOWAIT);
> +	if (!desc)
> +		dev_err(chan2dev(dchan), "failed to alloc DMA descriptor!\n");

this can be dropped too..

> +static struct dma_async_tx_descriptor *
> +ls1x_dma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
> +		       unsigned int sg_len,
> +		       enum dma_transfer_direction direction,
> +		       unsigned long flags, void *context)
> +{
> +	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
> +	struct dma_slave_config *cfg = &chan->cfg;
> +	struct ls1x_dma_desc *desc;
> +	struct scatterlist *sg;
> +	unsigned int dev_addr, bus_width, cmd, i;
> +
> +	if (!is_slave_direction(direction)) {
> +		dev_err(chan2dev(dchan), "invalid DMA direction!\n");
> +		return NULL;
> +	}
> +
> +	dev_dbg(chan2dev(dchan), "sg_len=%d, dir=%s, flags=0x%lx\n", sg_len,
> +		direction == DMA_MEM_TO_DEV ? "to device" : "from device",
> +		flags);
> +
> +	switch (direction) {
> +	case DMA_MEM_TO_DEV:
> +		dev_addr = cfg->dst_addr;
> +		bus_width = cfg->dst_addr_width;
> +		cmd = LS1X_DMA_RAM2DEV | LS1X_DMA_INT;
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		dev_addr = cfg->src_addr;
> +		bus_width = cfg->src_addr_width;
> +		cmd = LS1X_DMA_INT;
> +		break;
> +	default:
> +		dev_err(chan2dev(dchan),
> +			"unsupported DMA transfer mode! %d\n", direction);
> +		return NULL;

will this be ever executed?

> +static int ls1x_dma_slave_config(struct dma_chan *dchan,
> +				 struct dma_slave_config *config)
> +{
> +	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
> +
> +	if (!dchan)
> +		return -EINVAL;

should this not be checked before you dereference this to get chan

> +static void ls1x_dma_trigger(struct ls1x_dma_chan *chan)
> +{
> +	struct dma_chan *dchan = &chan->vchan.chan;
> +	struct ls1x_dma_desc *desc;
> +	struct virt_dma_desc *vdesc;
> +	unsigned int val;
> +
> +	vdesc = vchan_next_desc(&chan->vchan);
> +	if (!vdesc) {
> +		dev_warn(chan2dev(dchan), "No pending descriptor\n");

Hmm, I would not log that... this is called from
ls1x_dma_issue_pending() and which can be called from client driver but
previous completion would push and this can find empty queue so it can
happen quite frequently

> +static irqreturn_t ls1x_dma_irq_handler(int irq, void *data)
> +{
> +	struct ls1x_dma_chan *chan = data;
> +	struct dma_chan *dchan = &chan->vchan.chan;
> +
> +	dev_dbg(chan2dev(dchan), "DMA IRQ %d on channel %d\n", irq, chan->id);
> +	if (!chan->desc) {
> +		dev_warn(chan2dev(dchan),
> +			 "DMA IRQ with no active descriptor on channel %d\n",
> +			 chan->id);

single line pls

> +		return IRQ_NONE;
> +	}
> +
> +	spin_lock(&chan->vchan.lock);
> +
> +	if (chan->desc->type == DMA_CYCLIC) {
> +		vchan_cyclic_callback(&chan->desc->vdesc);
> +	} else {
> +		list_del(&chan->desc->vdesc.node);
> +		vchan_cookie_complete(&chan->desc->vdesc);
> +		chan->desc = NULL;
> +	}

not submitting next txn, defeats the purpose of dma if we dont push txns
as fast as possible..

> +static struct platform_driver ls1x_dma_driver = {
> +	.probe	= ls1x_dma_probe,
> +	.remove	= ls1x_dma_remove,
> +	.driver	= {
> +		.name	= "ls1x-dma",
> +	},

No device tree?

-- 
~Vinod
