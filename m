Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 175E3114339
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2019 16:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfLEPER (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Dec 2019 10:04:17 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:33548 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfLEPER (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Dec 2019 10:04:17 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F17E22E5;
        Thu,  5 Dec 2019 16:04:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1575558255;
        bh=Q74C2syM6RwpkWHke5/SyhGMRaFJ4I5uoTWTcUj4jyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tP0QpleyRuoud0miSBumqT4Wax0MTq7/P/Ltc4dWHopWDoZW3YNdlrCPn5aQYWOQ9
         CLCNaUXIgNKCK9nR7THaNDSVIhKnI+dk5a3t6S8bZKr0vY2QkJ1/JRIPwmsnMVbbPS
         pG0G+PBV7sDVbqOEq2VBiPIhgiiAbL0pyiqhNNbA=
Date:   Thu, 5 Dec 2019 17:04:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v2 2/4] dma: xilinx: dpdma: Add the Xilinx DisplayPort
 DMA engine driver
Message-ID: <20191205150407.GL4734@pendragon.ideasonboard.com>
References: <20191107021400.16474-1-laurent.pinchart@ideasonboard.com>
 <20191107021400.16474-3-laurent.pinchart@ideasonboard.com>
 <20191109175908.GI952516@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191109175908.GI952516@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Sat, Nov 09, 2019 at 11:29:08PM +0530, Vinod Koul wrote:
> Hi Laurent,
> 
> it is dmaengine: xxx not dma: xxx :-)

My bad, will fix it.

> On 07-11-19, 04:13, Laurent Pinchart wrote:
> 
> > +/*
> > + * DPDMA descriptor placement
> > + * --------------------------
> > + * DPDMA descritpor life time is described with following placements:
> > + *
> > + * allocated_desc -> submitted_desc -> pending_desc -> active_desc -> done_list
> > + *
> > + * Transition is triggered as following:
> > + *
> > + * -> allocated_desc : a descriptor allocation
> > + * allocated_desc -> submitted_desc: a descriptor submission
> > + * submitted_desc -> pending_desc: request to issue pending a descriptor
> > + * pending_desc -> active_desc: VSYNC intr when a desc is scheduled to DPDMA
> > + * active_desc -> done_list: VSYNC intr when DPDMA switches to a new desc
> 
> Well this tells me driver is not using vchan infrastructure, the
> drivers/dma/virt-dma.c is common infra which does pretty decent list
> management and drivers do not need to open code this.
> 
> Please convert the driver to use virt-dma

As noted in the cover letter,

"There is one review comment that is still pending: switching to
virt-dma. I started investigating this, and it quickly appeared that
this would result in an almost complete rewrite of the driver's logic.
While the end result may be better, I wonder if this is worth it, given
that the DPDMA is tied to the DisplayPort subsystem and can't be used
with other DMA slaves. The DPDMA is thus used with very specific usage
patterns, which don't need the genericity of descriptor handling
provided by virt-dma. Vinod, what's your opinion on this ? Is virt-dma
usage a blocker to merge this driver, could we switch to it later, or is
it just overkill in this case ?"

I'd like to ask an additional question : is the dmaengine API the best
solution for this ? The DPDMA is a separate IP core, but it is tied with
the DP subsystem. I'm tempted to just fold it in the display driver. The
only reason why I'm hesitant on this is that the DPDMA also handles
audio channels, that are also part of the DP subsystem, but that could
be handled by a separate ALSA driver. Still, handling display, audio and
DMA in drivers that we pretend are independent and generic would be a
bit of a lie.

> > +static struct dma_async_tx_descriptor *
> > +xilinx_dpdma_chan_prep_slave_sg(struct xilinx_dpdma_chan *chan,
> > +				struct scatterlist *sgl)
> > +{
> > +	struct xilinx_dpdma_tx_desc *tx_desc;
> > +	struct xilinx_dpdma_sw_desc *sw_desc, *last = NULL;
> > +
> > +	if (chan->allocated_desc)
> > +		return &chan->allocated_desc->async_tx;
> 
> This seems wrong, you are supposed to prepare a new descriptor based on
> sg list provided, returning allocated without preparing seems wrong to
> me!
> 
> > +static dma_cookie_t xilinx_dpdma_tx_submit(struct dma_async_tx_descriptor *tx)
> > +{
> > +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(tx->chan);
> > +	struct xilinx_dpdma_tx_desc *tx_desc = to_dpdma_tx_desc(tx);
> > +	struct xilinx_dpdma_sw_desc *sw_desc;
> > +	dma_cookie_t cookie;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&chan->lock, flags);
> > +
> > +	if (chan->submitted_desc) {
> > +		cookie = chan->submitted_desc->async_tx.cookie;
> 
> submit should give a new cookie not for already submitted descriptor!
> 
> > +		goto out_unlock;
> > +	}
> > +
> > +	cookie = dma_cookie_assign(&tx_desc->async_tx);
> 
> yes this is correct :-)
> 
> > +
> > +	/*
> > +	 * Assign the cookie to descriptors in this transaction. Only 16 bit
> > +	 * will be used, but it should be enough.
> > +	 */
> > +	list_for_each_entry(sw_desc, &tx_desc->descriptors, node)
> > +		sw_desc->hw.desc_id = cookie;
> > +
> > +	if (tx_desc != chan->allocated_desc)
> > +		dev_err(chan->xdev->dev, "desc != allocated_desc\n");
> > +	else
> > +		chan->allocated_desc = NULL;
> > +	chan->submitted_desc = tx_desc;
> 
> submitted should be a list, we can submit multiple...
> 
> > +static void xilinx_dpdma_issue_pending(struct dma_chan *dchan)
> > +{
> > +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> > +
> > +	xilinx_dpdma_chan_start(chan);
> 
> what if channel is already started?

-- 
Regards,

Laurent Pinchart
