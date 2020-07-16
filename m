Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80E1222438
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jul 2020 15:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGPNqg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jul 2020 09:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPNqg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jul 2020 09:46:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E3CC061755
        for <dmaengine@vger.kernel.org>; Thu, 16 Jul 2020 06:46:35 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 423952B7;
        Thu, 16 Jul 2020 15:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594907193;
        bh=wgz216XVwr5bv5j/+EEVdVEg44gowkfJ3KbFAoXfSVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdXnJy45GMi/DXvFQxAFKN0nIYD6kZVwLwsyJ8I0ofGpnXpNK33/I4ken2OrnGppR
         3AbeLfix6ABhiKyKZ9xjhQaGsKiDSGymKNKqbJkzU5tzPXYzNj7dfcxQJKOlKdb/+s
         xBPA6n+gjuULnH9l6OkY66m47id7p7IqmyQSC5s4=
Date:   Thu, 16 Jul 2020 16:46:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v6 4/6] dmaengine: xilinx: dpdma: Add the Xilinx
 DisplayPort DMA engine driver
Message-ID: <20200716134625.GC5960@pendragon.ideasonboard.com>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
 <20200708201906.4546-5-laurent.pinchart@ideasonboard.com>
 <20200715105906.GI34333@vkoul-mobl>
 <20200716004140.GN6144@pendragon.ideasonboard.com>
 <20200716052107.GC55478@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716052107.GC55478@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Thu, Jul 16, 2020 at 10:51:07AM +0530, Vinod Koul wrote:
> On 16-07-20, 03:41, Laurent Pinchart wrote:
> > On Wed, Jul 15, 2020 at 04:29:06PM +0530, Vinod Koul wrote:
> > > On 08-07-20, 23:19, Laurent Pinchart wrote:
> > > 
> > > > +static struct dma_async_tx_descriptor *
> > > > +xilinx_dpdma_prep_interleaved_dma(struct dma_chan *dchan,
> > > > +				  struct dma_interleaved_template *xt,
> > > > +				  unsigned long flags)
> > > > +{
> > > > +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> > > > +	struct xilinx_dpdma_tx_desc *desc;
> > > > +
> > > > +	if (xt->dir != DMA_MEM_TO_DEV)
> > > > +		return NULL;
> > > > +
> > > > +	if (!xt->numf || !xt->sgl[0].size)
> > > > +		return NULL;
> > > > +
> > > > +	if (!(flags & DMA_PREP_REPEAT))
> > > > +		return NULL;
> > > 
> > > is the hw be not capable of supporting single interleave txn?
> > 
> > I haven't checked if that would be possible to implement, as there's
> > zero use case for that. This DMA engine is tied to one particular
> > display engine, and there's no use for non-repeated transfers for
> > display. Even if I were to implement this (assuming the hardware would
> > support it), I would have no way to test it.
> 
> Okay
> 
> > > Also as replied the comment to Peter, we should check chan->running here
> > > and see that DMA_PREP_LOAD_EOT is set. There can still be a case where
> > > descriptor is submitted but not issued causing you to miss, but i guess
> > > that might be overkill for your scenarios
> > 
> > I can instead check for DMA_PREP_LOAD_EOT unconditionally, as that's all
> > that is supported. Doing anything more complex would be overkill. Please
> > confirm this is fine with you.
> 
> Agreed
> 
> > > > +static int xilinx_dpdma_config(struct dma_chan *dchan,
> > > > +			       struct dma_slave_config *config)
> > > > +{
> > > > +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> > > > +	unsigned long flags;
> > > > +
> > > > +	/*
> > > > +	 * The destination address doesn't need to be specified as the DPDMA is
> > > > +	 * hardwired to the destination (the DP controller). The transfer
> > > > +	 * width, burst size and port window size are thus meaningless, they're
> > > > +	 * fixed both on the DPDMA side and on the DP controller side.
> > > > +	 */
> > > 
> > > But we are not doing peripheral transfers, this is memory to memory
> > > (interleave) here right?
> > 
> > No, it's memory to peripheral.
> 
> Ok, the DMA_SLAVE makes sense
> 
> > > > +
> > > > +	spin_lock_irqsave(&chan->lock, flags);
> > > > +
> > > > +	/*
> > > > +	 * Abuse the slave_id to indicate that the channel is part of a video
> > > > +	 * group.
> > > > +	 */
> > > > +	if (chan->id >= ZYNQMP_DPDMA_VIDEO0 && chan->id <= ZYNQMP_DPDMA_VIDEO2)
> > > > +		chan->video_group = config->slave_id != 0;
> > > 
> > > Okay looking closely here, the video_group is used to tie different
> > > channels together to ensure sync operation is that right?
> > 
> > Correct.
> 
> So can you help me understand what is the usage here? I am trying to see
> if we can come with a better way to handle this.

When transfering a video frame stored in NV12, two DMA channels are
needed, one for the Y plane and one for the C plane. The two planes are
stored in two separate memory locations. The two channels need to
operate in sync, so the driver starts them at the hardware level when
they're all started at the software level. The video_group is used to
tell the DMA engine driver if the channels are used in that mode.

> > > And this seems to be only reason for DMA_SLAVE capabilities, i don't
> > > think I saw slave ops
> > 
> > Which ops are you talking about ? device_prep_slave_sg ? That's not
> > applicable for this device as the hardware doesn't support scatterlists.
> > Could you please explain any issue you see here in more details ?
> 
> I was assuming that interleave is memcpy operation and dma_slave_config
> is used for video_group only so DMA_SLAVE might not have been correct.
> 
> But looks like it is a peripheral. We typically pass dma configuration
> which seems unused here, which seems fine as things are tied to
> peripheral and not configurable.

Yes, everything is hardcoded at the hardware level on both the DMA
engine and the display controller side, so there's nothing to configure.

> > > > +static int xilinx_dpdma_terminate_all(struct dma_chan *dchan)
> > > > +{
> > > > +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> > > > +	struct xilinx_dpdma_device *xdev = chan->xdev;
> > > > +	LIST_HEAD(descriptors);
> > > > +	unsigned long flags;
> > > > +	unsigned int i;
> > > > +
> > > > +	/* Pause the channel (including the whole video group if applicable). */
> > > > +	if (chan->video_group) {
> > > > +		for (i = ZYNQMP_DPDMA_VIDEO0; i <= ZYNQMP_DPDMA_VIDEO2; i++) {
> > > > +			if (xdev->chan[i]->video_group &&
> > > > +			    xdev->chan[i]->running) {
> > > > +				xilinx_dpdma_chan_pause(xdev->chan[i]);
> > > 
> > > so there is no terminate here, only pause?
> > 
> > Pausing the channel is the first step of termination, the second and
> > third steps (waiting for oustanding transfers to complete and disabling
> > the hardware) are synchronous and handled in xilinx_dpdma_chan_stop(),
> > called from the .device_synchronize() handler
> > (xilinx_dpdma_synchronize()).
> > 
> > Could you please confirm that the only change required in this patch is
> > to check DMA_PREP_LOAD_EOT in xilinx_dpdma_prep_interleaved_dma() and
> > that there's no other issue ? I've sent too many versions of this series
> > already and I'd like to minimize the number of new cycles.
> 
> Yes that is only thing atm. Also I think we should rethink how we are
> tying the channels and can we do a better way to handle that

Thanks. I'll make the necessary changes and submit a new version. If you
think a new API is needed to tie channels together, can it be developed
on top ?

-- 
Regards,

Laurent Pinchart
