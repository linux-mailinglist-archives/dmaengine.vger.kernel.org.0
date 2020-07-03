Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769EB213EED
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2020 19:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgGCRoH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 13:44:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33718 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbgGCRoF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 13:44:05 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AF34429E;
        Fri,  3 Jul 2020 19:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593798242;
        bh=YOcYqYxzQcpzrRbGgtZRd0HDRBeWYP+7YXZELRA1T30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPEk2tqL8Esa5zrVWnu4hPxigX40er7HEn/3rASEgNmUPE7U0qe6XzVKBLh+TC9YW
         FX6DRQ9d8NO0LAZfWK+3FrkZgduPAS719V3Vnv9J3Xz+9dSvLPlQd4tZXiFuCkPpCB
         yHoiKx7ad/aXiMq8WtbEgqosEgVXVpyICbveVDZg=
Date:   Fri, 3 Jul 2020 20:43:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 4/6] dmaengine: xilinx: dpdma: Add the Xilinx
 DisplayPort DMA engine driver
Message-ID: <20200703174358.GD14282@pendragon.ideasonboard.com>
References: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
 <20200528025228.31638-5-laurent.pinchart@ideasonboard.com>
 <20200703173239.GP273932@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200703173239.GP273932@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Fri, Jul 03, 2020 at 11:02:39PM +0530, Vinod Koul wrote:
> On 28-05-20, 05:52, Laurent Pinchart wrote:
> 
> > +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> > @@ -0,0 +1,1554 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx ZynqMP DPDMA Engine driver
> > + *
> > + * Copyright (C) 2015 - 2019 Xilinx, Inc.
> 
> 2020 please

I was accurate when the first version was submitted ;-) I'll update
this.

> > +static struct xilinx_dpdma_tx_desc *
> > +xilinx_dpdma_chan_alloc_tx_desc(struct xilinx_dpdma_chan *chan)
> > +{
> > +	struct xilinx_dpdma_tx_desc *tx_desc;
> > +
> > +	tx_desc = kzalloc(sizeof(*tx_desc), GFP_KERNEL);
> 
> GFP_NOWAIT please, this is called from a prep call so needs to be atomic
> context

That's an easy change, but it's an annoying one. No user of this driver
will ever prepare descriptors in atomic context. This would thus put
unnecessary burden on the system memory, possibly depriving a real user
of GFP_NOWAIT from precious memory.

> > +static int xilinx_dpdma_config(struct dma_chan *dchan,
> > +			       struct dma_slave_config *config)
> > +{
> > +	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	if (config->direction != DMA_MEM_TO_DEV)
> > +		return -EINVAL;
> 
> sorry but direction is deprecated and supposed to be remove, can you
> please remove this

Sure.

Removing the direction field through the whole subsystem would be nice
to avoid this mistake in new drivers.

> > +
> > +	/*
> > +	 * The destination address doesn't need to be specified as the DPDMA is
> > +	 * hardwired to the destination (the DP controller). The transfer
> > +	 * width, burst size and port window size are thus meaningless, they're
> > +	 * fixed both on the DPDMA side and on the DP controller side.
> > +	 */
> > +
> > +	spin_lock_irqsave(&chan->lock, flags);
> > +
> > +	/* Can't reconfigure a running channel. */
> > +	if (chan->running) {
> > +		ret = -EBUSY;
> > +		goto unlock;
> > +	}
> 
> why does this part matter? The configuration is passed here and should
> be applied to next descriptor submitted, channel can be busy.

I'll drop it.

> > +
> > +	/*
> > +	 * Abuse the slave_id to indicate that the channel is part of a video
> > +	 * group.
> > +	 */
> 
> Of course, what does video grp mean here? 

When the frame to be displayed is made of multiple planes, multiple DMA
channels have to be used, one per plane. The channels have to be
synchronized and operated together by the driver. The video_group field
is a boolean indicating that the channel is part of such a group.

> > +	if (chan->id >= ZYNQMP_DPDMA_VIDEO0 && chan->id <= ZYNQMP_DPDMA_VIDEO2)
> > +		chan->video_group = config->slave_id != 0;
> 
> so only thing we care here is slave_id? What about dma burst parameters?

The hardware hardware doesn't have any burst parameter that can be
configured. It's a DMA engine dedicated to the display device, most
parameters are thus hardcoded at the hardware level, as explained by the
comment above.

-- 
Regards,

Laurent Pinchart
