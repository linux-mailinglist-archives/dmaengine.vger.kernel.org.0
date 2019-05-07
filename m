Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B021618F
	for <lists+dmaengine@lfdr.de>; Tue,  7 May 2019 11:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfEGJ5C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 May 2019 05:57:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfEGJ5C (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 May 2019 05:57:02 -0400
Received: from localhost (unknown [106.200.210.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1E42053B;
        Tue,  7 May 2019 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557223020;
        bh=qZCkGMVfQi6XdZaHQrcvVPt8ch7IBWjlhqotMuwf81s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SePrwzWCiyuzYrqHfbOjeHP3FeY928pydbXrc05iyqRb0HvQZzEvyJ6CErb/F2MlT
         VsmySCaS74w3z2qMSJvE2FDRElfpfOjvOTJF5P4wS6rPLX0ugX7VT0TGzsTpYe4miF
         vdu6Pl8HocKcKdx/C5jezcDjh1fYk1DRIVBo3Qfk=
Date:   Tue, 7 May 2019 15:26:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [RFC v6 1/6] dmaengine: Add Synopsys eDMA IP core driver
Message-ID: <20190507095654.GH16052@vkoul-mobl>
References: <cover.1556043127.git.gustavo.pimentel@synopsys.com>
 <0e877ac0115d37e466ac234f47c51cb1cae7f292.1556043127.git.gustavo.pimentel@synopsys.com>
 <20190506112001.GE3845@vkoul-mobl.Dlink>
 <305100E33629484CBB767107E4246BBB0A238675@de02wembxa.internal.synopsys.com>
 <20190507050310.GA16052@vkoul-mobl>
 <305100E33629484CBB767107E4246BBB0A238D2C@de02wembxa.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305100E33629484CBB767107E4246BBB0A238D2C@de02wembxa.internal.synopsys.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-05-19, 09:08, Gustavo Pimentel wrote:
> On Tue, May 7, 2019 at 6:3:10, Vinod Koul <vkoul@kernel.org> wrote:
> > On 06-05-19, 16:42, Gustavo Pimentel wrote:

> > > > > +static struct dma_async_tx_descriptor *
> > > > > +dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > > > > +{
> > > > > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
> > > > > +	enum dma_transfer_direction direction = xfer->direction;
> > > > > +	phys_addr_t src_addr, dst_addr;
> > > > > +	struct scatterlist *sg = NULL;
> > > > > +	struct dw_edma_chunk *chunk;
> > > > > +	struct dw_edma_burst *burst;
> > > > > +	struct dw_edma_desc *desc;
> > > > > +	u32 cnt;
> > > > > +	int i;
> > > > > +
> > > > > +	if ((direction == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE) ||
> > > > > +	    (direction == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ))
> > > > > +		return NULL;
> > > > > +
> > > > > +	if (xfer->cyclic) {
> > > > > +		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
> > > > > +			return NULL;
> > > > > +	} else {
> > > > > +		if (xfer->xfer.sg.len < 1)
> > > > > +			return NULL;
> > > > > +	}
> > > > > +
> > > > > +	if (!chan->configured)
> > > > > +		return NULL;
> > > > > +
> > > > > +	desc = dw_edma_alloc_desc(chan);
> > > > > +	if (unlikely(!desc))
> > > > > +		goto err_alloc;
> > > > > +
> > > > > +	chunk = dw_edma_alloc_chunk(desc);
> > > > > +	if (unlikely(!chunk))
> > > > > +		goto err_alloc;
> > > > > +
> > > > > +	src_addr = chan->config.src_addr;
> > > > > +	dst_addr = chan->config.dst_addr;
> > > > > +
> > > > > +	if (xfer->cyclic) {
> > > > > +		cnt = xfer->xfer.cyclic.cnt;
> > > > > +	} else {
> > > > > +		cnt = xfer->xfer.sg.len;
> > > > > +		sg = xfer->xfer.sg.sgl;
> > > > > +	}
> > > > > +
> > > > > +	for (i = 0; i < cnt; i++) {
> > > > > +		if (!xfer->cyclic && !sg)
> > > > > +			break;
> > > > > +
> > > > > +		if (chunk->bursts_alloc == chan->ll_max) {
> > > > > +			chunk = dw_edma_alloc_chunk(desc);
> > > > > +			if (unlikely(!chunk))
> > > > > +				goto err_alloc;
> > > > > +		}
> > > > > +
> > > > > +		burst = dw_edma_alloc_burst(chunk);
> > > > > +		if (unlikely(!burst))
> > > > > +			goto err_alloc;
> > > > > +
> > > > > +		if (xfer->cyclic)
> > > > > +			burst->sz = xfer->xfer.cyclic.len;
> > > > > +		else
> > > > > +			burst->sz = sg_dma_len(sg);
> > > > > +
> > > > > +		chunk->ll_region.sz += burst->sz;
> > > > > +		desc->alloc_sz += burst->sz;
> > > > > +
> > > > > +		if (direction == DMA_DEV_TO_MEM) {
> > > > > +			burst->sar = src_addr;
> > > > 
> > > > We are device to mem, so src is peripheral.. okay
> > > > 
> > > > > +			if (xfer->cyclic) {
> > > > > +				burst->dar = xfer->xfer.cyclic.paddr;
> > > > > +			} else {
> > > > > +				burst->dar = sg_dma_address(sg);
> > > > > +				src_addr += sg_dma_len(sg);
> > > > 
> > > > and we increment the src, doesn't make sense to me!
> > > > 
> > > > > +			}
> > > > > +		} else {
> > > > > +			burst->dar = dst_addr;
> > > > > +			if (xfer->cyclic) {
> > > > > +				burst->sar = xfer->xfer.cyclic.paddr;
> > > > > +			} else {
> > > > > +				burst->sar = sg_dma_address(sg);
> > > > > +				dst_addr += sg_dma_len(sg);
> > > > 
> > > > same here as well
> > > 
> > > This is hard to explain in words...
> > > Well, in my perspective I want to transfer a piece of memory from the 
> > > peripheral into local RAM
> > 
> > Right and most of the case RAM address (sg) needs to increment whereas
> > peripheral is a constant one
> > 
> > > Through the DMA client API I'll break this piece of memory in several 
> > > small parts and add all into a list (scatter-gather), right?
> > > Each element of the scatter-gather has the sg_dma_address (in the 
> > > DMA_DEV_TO_MEM case will be the destination address) and the 
> > > corresponding size.
> > 
> > Correct
> > 
> > > However, I still need the other address (in the DMA_DEV_TO_MEM case will 
> > > be the source address) for that small part of memory.
> > > Since I get that address from the config, I still need to increment the 
> > > source address in the same proportion of the destination address, in 
> > > other words, the increment will be the part size.
> > 
> > I don't think so. Typically the device address is a FIFO, which does not
> > increment and you keep pushing data at same address. It is not a memory
> 
> In my use case, it's a memory, perhaps that is what is causing this 
> confusing.
> I'm copying "plain and flat" data from point A to B, with the 
> particularity that the peripheral memory is always continuous and the CPU 
> memory can be constituted by scatter-gather chunks of contiguous memory

Then why should it be slave transfer, it should be treated as memcpy
with src and dst sg lists..
-- 
~Vinod
