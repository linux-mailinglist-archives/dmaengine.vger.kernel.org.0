Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33B4148D4
	for <lists+dmaengine@lfdr.de>; Mon,  6 May 2019 13:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFLUQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 May 2019 07:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfEFLUQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 May 2019 07:20:16 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DE020830;
        Mon,  6 May 2019 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557141615;
        bh=RWzWLNRmkhsx4X7UpZcftA+Wiv1oQRs9O0WY0WPKXWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hk4dwhjLQEPPRdQ0zwXdrTWUl1vfNqBiUN8qayLMMWwiHk1oKjGjoJVQfu08f9pB7
         Yy7pioHSPaFNZVaErU08zdmhEgdSOt3z6lvjU5eo0aNpYHDBZPT5+dlqgySyjp5DQq
         4nlKbWB55nozAsvihO8wK1GzCNKBdrzb/kFhja7A=
Date:   Mon, 6 May 2019 16:50:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [RFC v6 1/6] dmaengine: Add Synopsys eDMA IP core driver
Message-ID: <20190506112001.GE3845@vkoul-mobl.Dlink>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
 <0e877ac0115d37e466ac234f47c51cb1cae7f292.1556043127.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e877ac0115d37e466ac234f47c51cb1cae7f292.1556043127.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-04-19, 20:30, Gustavo Pimentel wrote:
> Add Synopsys PCIe Endpoint eDMA IP core driver to kernel.

Still an RFC ?

> +static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
> +{
> +	struct dw_edma_chan *chan = desc->chan;
> +	struct dw_edma *dw = chan->chip->dw;
> +	struct dw_edma_chunk *chunk;
> +
> +	chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);

Looking at the code this should be called from one of the
device_prep_xxx calls so this should not sleep, so GFP_NOWAIT please

(pls audit rest of the mem allocations in the code)

> +	if (unlikely(!chunk))
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&chunk->list);
> +	chunk->chan = chan;
> +	chunk->cb = !(desc->chunks_alloc % 2);
? why %2?

> +static enum dma_status
> +dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
> +			 struct dma_tx_state *txstate)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	struct dw_edma_desc *desc;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +	enum dma_status ret;
> +	u32 residue = 0;
> +
> +	ret = dma_cookie_status(dchan, cookie, txstate);
> +	if (ret == DMA_COMPLETE)
> +		return ret;
> +
> +	if (ret == DMA_IN_PROGRESS && chan->status == EDMA_ST_PAUSE)
> +		ret = DMA_PAUSED;

Don't you want to set residue on paused channel, how else will user know
the position of pause?

> +static struct dma_async_tx_descriptor *
> +dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
> +	enum dma_transfer_direction direction = xfer->direction;
> +	phys_addr_t src_addr, dst_addr;
> +	struct scatterlist *sg = NULL;
> +	struct dw_edma_chunk *chunk;
> +	struct dw_edma_burst *burst;
> +	struct dw_edma_desc *desc;
> +	u32 cnt;
> +	int i;
> +
> +	if ((direction == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE) ||
> +	    (direction == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ))
> +		return NULL;
> +
> +	if (xfer->cyclic) {
> +		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
> +			return NULL;
> +	} else {
> +		if (xfer->xfer.sg.len < 1)
> +			return NULL;
> +	}
> +
> +	if (!chan->configured)
> +		return NULL;
> +
> +	desc = dw_edma_alloc_desc(chan);
> +	if (unlikely(!desc))
> +		goto err_alloc;
> +
> +	chunk = dw_edma_alloc_chunk(desc);
> +	if (unlikely(!chunk))
> +		goto err_alloc;
> +
> +	src_addr = chan->config.src_addr;
> +	dst_addr = chan->config.dst_addr;
> +
> +	if (xfer->cyclic) {
> +		cnt = xfer->xfer.cyclic.cnt;
> +	} else {
> +		cnt = xfer->xfer.sg.len;
> +		sg = xfer->xfer.sg.sgl;
> +	}
> +
> +	for (i = 0; i < cnt; i++) {
> +		if (!xfer->cyclic && !sg)
> +			break;
> +
> +		if (chunk->bursts_alloc == chan->ll_max) {
> +			chunk = dw_edma_alloc_chunk(desc);
> +			if (unlikely(!chunk))
> +				goto err_alloc;
> +		}
> +
> +		burst = dw_edma_alloc_burst(chunk);
> +		if (unlikely(!burst))
> +			goto err_alloc;
> +
> +		if (xfer->cyclic)
> +			burst->sz = xfer->xfer.cyclic.len;
> +		else
> +			burst->sz = sg_dma_len(sg);
> +
> +		chunk->ll_region.sz += burst->sz;
> +		desc->alloc_sz += burst->sz;
> +
> +		if (direction == DMA_DEV_TO_MEM) {
> +			burst->sar = src_addr;

We are device to mem, so src is peripheral.. okay

> +			if (xfer->cyclic) {
> +				burst->dar = xfer->xfer.cyclic.paddr;
> +			} else {
> +				burst->dar = sg_dma_address(sg);
> +				src_addr += sg_dma_len(sg);

and we increment the src, doesn't make sense to me!

> +			}
> +		} else {
> +			burst->dar = dst_addr;
> +			if (xfer->cyclic) {
> +				burst->sar = xfer->xfer.cyclic.paddr;
> +			} else {
> +				burst->sar = sg_dma_address(sg);
> +				dst_addr += sg_dma_len(sg);

same here as well

> +static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
> +{
> +	struct dw_edma_desc *desc;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +
> +	dw_edma_v0_core_clear_done_int(chan);
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +	vd = vchan_next_desc(&chan->vc);
> +	if (vd) {
> +		switch (chan->request) {
> +		case EDMA_REQ_NONE:
> +			desc = vd2dw_edma_desc(vd);
> +			if (desc->chunks_alloc) {
> +				chan->status = EDMA_ST_BUSY;
> +				dw_edma_start_transfer(chan);
> +			} else {
> +				list_del(&vd->node);
> +				vchan_cookie_complete(vd);
> +				chan->status = EDMA_ST_IDLE;
> +			}
> +			break;

Empty line after each break please

> +		case EDMA_REQ_STOP:
> +			list_del(&vd->node);
> +			vchan_cookie_complete(vd);
> +			chan->request = EDMA_REQ_NONE;
> +			chan->status = EDMA_ST_IDLE;

Why do we need to track request as well as status?

> +static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +
> +	if (chan->status != EDMA_ST_IDLE)
> +		return -EBUSY;
> +
> +	dma_cookie_init(dchan);

not using vchan_init() you need to do this and init the lists..?

> +struct dw_edma_transfer {
> +	struct dma_chan			*dchan;
> +	union Xfer {

no camel case please

It would help to run checkpatch with --strict option to find any style
issues and fix them as well
-- 
~Vinod
