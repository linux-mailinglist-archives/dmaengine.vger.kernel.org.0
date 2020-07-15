Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E742A22057B
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 08:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGOGyJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 02:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgGOGyI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 02:54:08 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF652067D;
        Wed, 15 Jul 2020 06:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594796048;
        bh=6G9ixkAKc0GhL+3IVqJVPv4ISAogPqNf55glRSXE8Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ik/iJkyf4+GWhutWzRWocu7hTzQ5V0cQFOYyQu/le1r6t3tEGxyoCLKivvzjdxgws
         9CkSxU9I82qDEtfYBrARmU8wlB09/8O6K7z3vLYy1pDwFZbu33lM9ADrXZTiPikK9n
         F6tN7AOs4JuOozQ9iBKL8gp/ds2TB5a2WCBwc/1c=
Date:   Wed, 15 Jul 2020 12:24:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v6 4/6] dmaengine: xilinx: dpdma: Add the Xilinx
 DisplayPort DMA engine driver
Message-ID: <20200715065403.GC34333@vkoul-mobl>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
 <20200708201906.4546-5-laurent.pinchart@ideasonboard.com>
 <64817596-1ba2-97d7-1dde-600eead16b05@ti.com>
 <20200711221644.GD5954@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711221644.GD5954@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-07-20, 01:16, Laurent Pinchart wrote:
> Hi Peter,
> 
> On Thu, Jul 09, 2020 at 04:21:38PM +0300, Peter Ujfalusi wrote:
> > On 08/07/2020 23.19, Laurent Pinchart wrote:
> > > From: Hyun Kwon <hyun.kwon@xilinx.com>
> > > 
> > > The ZynqMP DisplayPort subsystem includes a DMA engine called DPDMA with
> > > 6 DMa channels (4 for display and 2 for audio). This driver exposes the
> > > DPDMA through the dmaengine API, to be used by audio (ALSA) and display
> > > (DRM) drivers for the DisplayPort subsystem.
> > > 
> > > Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> > > Signed-off-by: Tejas Upadhyay <tejasu@xilinx.com>
> > > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > ...
> > 
> > > +static void xilinx_dpdma_chan_queue_transfer(struct xilinx_dpdma_chan *chan)
> > > +{
> > > +	struct xilinx_dpdma_device *xdev = chan->xdev;
> > > +	struct xilinx_dpdma_sw_desc *sw_desc;
> > > +	struct xilinx_dpdma_tx_desc *desc;
> > > +	struct virt_dma_desc *vdesc;
> > > +	u32 reg, channels;
> > > +
> > > +	lockdep_assert_held(&chan->lock);
> > > +
> > > +	if (chan->desc.pending)
> > > +		return;
> > > +
> > > +	if (!chan->running) {
> > > +		xilinx_dpdma_chan_unpause(chan);
> > > +		xilinx_dpdma_chan_enable(chan);
> > > +		chan->first_frame = true;
> > > +		chan->running = true;
> > > +	}
> > > +
> > > +	if (chan->video_group)
> > > +		channels = xilinx_dpdma_chan_video_group_ready(chan);
> > > +	else
> > > +		channels = BIT(chan->id);
> > > +
> > > +	if (!channels)
> > > +		return;
> > > +
> > > +	vdesc = vchan_next_desc(&chan->vchan);
> > > +	if (!vdesc)
> > > +		return;
> > > +
> > > +	if (!chan->first_frame && !(vdesc->tx.flags & DMA_PREP_LOAD_EOT)) {
> > > +		/*
> > > +		 * The client forgot to set the DMA_PREP_LOAD_EOT flag. The DMA
> > > +		 * engine API requires the channel to silently ignore the
> > > +		 * descriptor, leaving the client waiting forever for the new
> > > +		 * descriptor to be processed.
> > > +		 */
> > 
> > This hardly going to happen. But if it does, a gentle dev_dbg() might
> > save some time for the user on debugging?

Correct!

Also this is not quite right place for this driver to check this. In
prep_ call this driver should check if the channel is idle and if not
DMA_PREP_LOAD_EOT would be mandatory to be set and return error.

> I think you know my opinion on this already :-) I believe we should have
> designed this API in a way that makes this error impossible, by dropping
> the DMA_PREP_LOAD_EOT flag and considering that the default case. That
> was rejected. Do we now need to work around the problem in drivers ?

Driver can do that easily, API can allow this as some hardware can have
allow this.

Thanks
-- 
~Vinod
