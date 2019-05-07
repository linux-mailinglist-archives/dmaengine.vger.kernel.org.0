Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D115158B3
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 07:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEGFDS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 01:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEGFDS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 01:03:18 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B728820675;
        Tue,  7 May 2019 05:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557205396;
        bh=6i2X82xQFmvRD3usoC/EKuCIFawVFJpiwINinhluvg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzTE29+1BCsA2mE00yRVfprC3hO+yRSyRhKJ8gafU15sBZFoovTZIMglIHQTkpE52
         QnRBr5l8+boe8+xtBsyrvwD+4tFCLyToEK1rrLiMo3dP0/mVcphMKHEwp3qoCQnYRw
         ogZ0L4OH0qI9SHi40M1SQkFflmXa4MsqV2FgMHu4=
Date:   Tue, 7 May 2019 10:33:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [RFC v6 1/6] dmaengine: Add Synopsys eDMA IP core driver
Message-ID: <20190507050310.GA16052@vkoul-mobl>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
 <0e877ac0115d37e466ac234f47c51cb1cae7f292.1556043127.git.gustavo.pimentel@synopsys.com>
 <20190506112001.GE3845@vkoul-mobl.Dlink>
 <305100E33629484CBB767107E4246BBB0A238675@de02wembxa.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305100E33629484CBB767107E4246BBB0A238675@de02wembxa.internal.synopsys.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-19, 16:42, Gustavo Pimentel wrote:

> > > +	if (unlikely(!chunk))
> > > +		return NULL;
> > > +
> > > +	INIT_LIST_HEAD(&chunk->list);
> > > +	chunk->chan = chan;
> > > +	chunk->cb = !(desc->chunks_alloc % 2);
> > ? why %2?
> 
> I think it's explained on the patch description. CB also is known as 
> Change Bit that must be toggled in order to the HW assume a new linked 
> list is available to be consumed.
> Since desc->chunks_alloc variable is an incremental counter the remainder 
> after division by 2 will be zero (if chunks_alloc is even) or one (if 
> chunks_alloc is odd).

Okay it would be great to add a comment here to explain as well

> > > +static enum dma_status
> > > +dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
> > > +			 struct dma_tx_state *txstate)
> > > +{
> > > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +	struct dw_edma_desc *desc;
> > > +	struct virt_dma_desc *vd;
> > > +	unsigned long flags;
> > > +	enum dma_status ret;
> > > +	u32 residue = 0;
> > > +
> > > +	ret = dma_cookie_status(dchan, cookie, txstate);
> > > +	if (ret == DMA_COMPLETE)
> > > +		return ret;
> > > +
> > > +	if (ret == DMA_IN_PROGRESS && chan->status == EDMA_ST_PAUSE)
> > > +		ret = DMA_PAUSED;
> > 
> > Don't you want to set residue on paused channel, how else will user know
> > the position of pause?
> 
> I didn't catch you on this. I'm only setting the dma status here. After 
> this function, the residue is calculated and set, isn't it?

Hmm I thought you returned for paused case, if not then it is okay

> > > +static struct dma_async_tx_descriptor *
> > > +dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > > +{
> > > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
> > > +	enum dma_transfer_direction direction = xfer->direction;
> > > +	phys_addr_t src_addr, dst_addr;
> > > +	struct scatterlist *sg = NULL;
> > > +	struct dw_edma_chunk *chunk;
> > > +	struct dw_edma_burst *burst;
> > > +	struct dw_edma_desc *desc;
> > > +	u32 cnt;
> > > +	int i;
> > > +
> > > +	if ((direction == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE) ||
> > > +	    (direction == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ))
> > > +		return NULL;
> > > +
> > > +	if (xfer->cyclic) {
> > > +		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
> > > +			return NULL;
> > > +	} else {
> > > +		if (xfer->xfer.sg.len < 1)
> > > +			return NULL;
> > > +	}
> > > +
> > > +	if (!chan->configured)
> > > +		return NULL;
> > > +
> > > +	desc = dw_edma_alloc_desc(chan);
> > > +	if (unlikely(!desc))
> > > +		goto err_alloc;
> > > +
> > > +	chunk = dw_edma_alloc_chunk(desc);
> > > +	if (unlikely(!chunk))
> > > +		goto err_alloc;
> > > +
> > > +	src_addr = chan->config.src_addr;
> > > +	dst_addr = chan->config.dst_addr;
> > > +
> > > +	if (xfer->cyclic) {
> > > +		cnt = xfer->xfer.cyclic.cnt;
> > > +	} else {
> > > +		cnt = xfer->xfer.sg.len;
> > > +		sg = xfer->xfer.sg.sgl;
> > > +	}
> > > +
> > > +	for (i = 0; i < cnt; i++) {
> > > +		if (!xfer->cyclic && !sg)
> > > +			break;
> > > +
> > > +		if (chunk->bursts_alloc == chan->ll_max) {
> > > +			chunk = dw_edma_alloc_chunk(desc);
> > > +			if (unlikely(!chunk))
> > > +				goto err_alloc;
> > > +		}
> > > +
> > > +		burst = dw_edma_alloc_burst(chunk);
> > > +		if (unlikely(!burst))
> > > +			goto err_alloc;
> > > +
> > > +		if (xfer->cyclic)
> > > +			burst->sz = xfer->xfer.cyclic.len;
> > > +		else
> > > +			burst->sz = sg_dma_len(sg);
> > > +
> > > +		chunk->ll_region.sz += burst->sz;
> > > +		desc->alloc_sz += burst->sz;
> > > +
> > > +		if (direction == DMA_DEV_TO_MEM) {
> > > +			burst->sar = src_addr;
> > 
> > We are device to mem, so src is peripheral.. okay
> > 
> > > +			if (xfer->cyclic) {
> > > +				burst->dar = xfer->xfer.cyclic.paddr;
> > > +			} else {
> > > +				burst->dar = sg_dma_address(sg);
> > > +				src_addr += sg_dma_len(sg);
> > 
> > and we increment the src, doesn't make sense to me!
> > 
> > > +			}
> > > +		} else {
> > > +			burst->dar = dst_addr;
> > > +			if (xfer->cyclic) {
> > > +				burst->sar = xfer->xfer.cyclic.paddr;
> > > +			} else {
> > > +				burst->sar = sg_dma_address(sg);
> > > +				dst_addr += sg_dma_len(sg);
> > 
> > same here as well
> 
> This is hard to explain in words...
> Well, in my perspective I want to transfer a piece of memory from the 
> peripheral into local RAM

Right and most of the case RAM address (sg) needs to increment whereas
peripheral is a constant one

> Through the DMA client API I'll break this piece of memory in several 
> small parts and add all into a list (scatter-gather), right?
> Each element of the scatter-gather has the sg_dma_address (in the 
> DMA_DEV_TO_MEM case will be the destination address) and the 
> corresponding size.

Correct

> However, I still need the other address (in the DMA_DEV_TO_MEM case will 
> be the source address) for that small part of memory.
> Since I get that address from the config, I still need to increment the 
> source address in the same proportion of the destination address, in 
> other words, the increment will be the part size.

I don't think so. Typically the device address is a FIFO, which does not
increment and you keep pushing data at same address. It is not a memory

> If there is some way to set and get the address for the source (in this 
> case) into each scatter-gather element, that would be much nicer, is that 
> possible?

> > > +		case EDMA_REQ_STOP:
> > > +			list_del(&vd->node);
> > > +			vchan_cookie_complete(vd);
> > > +			chan->request = EDMA_REQ_NONE;
> > > +			chan->status = EDMA_ST_IDLE;
> > 
> > Why do we need to track request as well as status?
> 
> Since I don't actually have the PAUSE state feature available on HW, I'm 
> emulating it through software. As far as HW is concerned, it thinks that 
> it has transferred everything (no more bursts valid available), but in 
> terms of software, we still have a lot of chunks (each one containing 
> several bursts) to process.

Why do you need to emulate, if HW doesnt support so be it?
The applications should handle a device which doesnt support pause and
not a low level driver

> > > +struct dw_edma_transfer {
> > > +	struct dma_chan			*dchan;
> > > +	union Xfer {
> > 
> > no camel case please
> 
> Ok.
> 
> > 
> > It would help to run checkpatch with --strict option to find any style
> > issues and fix them as well
> 
> I usually run with that option, but for now, that option is giving some 
> warnings about macro variable names that are pure noise.

yeah that is a *guide* and to be used as guidance. If code looks worse
off then it shouldn't be used. But many of the test are helpful. Some
macros checks actually make sense, but again use your judgement :)

-- 
~Vinod
