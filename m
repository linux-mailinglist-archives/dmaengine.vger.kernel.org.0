Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558A821C69B
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jul 2020 00:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgGKWQy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Jul 2020 18:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgGKWQy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Jul 2020 18:16:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94D3C08C5DD
        for <dmaengine@vger.kernel.org>; Sat, 11 Jul 2020 15:16:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2A67C293;
        Sun, 12 Jul 2020 00:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594505811;
        bh=OfhxhwiU2xZFrKTni/w9gJs+bueV8qP6qd4yRpGCtaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rihh8OTAhMxCdDRCkgZNE+dGmvPr5TWldEEQ3KqWR2TAS+hiYElK2CejpVrSwZz7k
         RL/MxJW5l9tsfJJOn2+Rp8Fug+qhq95c88HraIfNCPGq7wllv5L5gEa5tqt0f4DYiw
         00YFILgsLxltPWMSmmvkXJiZYoEtK/FfPkgxYh0U=
Date:   Sun, 12 Jul 2020 01:16:44 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v6 4/6] dmaengine: xilinx: dpdma: Add the Xilinx
 DisplayPort DMA engine driver
Message-ID: <20200711221644.GD5954@pendragon.ideasonboard.com>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
 <20200708201906.4546-5-laurent.pinchart@ideasonboard.com>
 <64817596-1ba2-97d7-1dde-600eead16b05@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64817596-1ba2-97d7-1dde-600eead16b05@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Thu, Jul 09, 2020 at 04:21:38PM +0300, Peter Ujfalusi wrote:
> On 08/07/2020 23.19, Laurent Pinchart wrote:
> > From: Hyun Kwon <hyun.kwon@xilinx.com>
> > 
> > The ZynqMP DisplayPort subsystem includes a DMA engine called DPDMA with
> > 6 DMa channels (4 for display and 2 for audio). This driver exposes the
> > DPDMA through the dmaengine API, to be used by audio (ALSA) and display
> > (DRM) drivers for the DisplayPort subsystem.
> > 
> > Signed-off-by: Hyun Kwon <hyun.kwon@xilinx.com>
> > Signed-off-by: Tejas Upadhyay <tejasu@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ...
> 
> > +static void xilinx_dpdma_chan_queue_transfer(struct xilinx_dpdma_chan *chan)
> > +{
> > +	struct xilinx_dpdma_device *xdev = chan->xdev;
> > +	struct xilinx_dpdma_sw_desc *sw_desc;
> > +	struct xilinx_dpdma_tx_desc *desc;
> > +	struct virt_dma_desc *vdesc;
> > +	u32 reg, channels;
> > +
> > +	lockdep_assert_held(&chan->lock);
> > +
> > +	if (chan->desc.pending)
> > +		return;
> > +
> > +	if (!chan->running) {
> > +		xilinx_dpdma_chan_unpause(chan);
> > +		xilinx_dpdma_chan_enable(chan);
> > +		chan->first_frame = true;
> > +		chan->running = true;
> > +	}
> > +
> > +	if (chan->video_group)
> > +		channels = xilinx_dpdma_chan_video_group_ready(chan);
> > +	else
> > +		channels = BIT(chan->id);
> > +
> > +	if (!channels)
> > +		return;
> > +
> > +	vdesc = vchan_next_desc(&chan->vchan);
> > +	if (!vdesc)
> > +		return;
> > +
> > +	if (!chan->first_frame && !(vdesc->tx.flags & DMA_PREP_LOAD_EOT)) {
> > +		/*
> > +		 * The client forgot to set the DMA_PREP_LOAD_EOT flag. The DMA
> > +		 * engine API requires the channel to silently ignore the
> > +		 * descriptor, leaving the client waiting forever for the new
> > +		 * descriptor to be processed.
> > +		 */
> 
> This hardly going to happen. But if it does, a gentle dev_dbg() might
> save some time for the user on debugging?

I think you know my opinion on this already :-) I believe we should have
designed this API in a way that makes this error impossible, by dropping
the DMA_PREP_LOAD_EOT flag and considering that the default case. That
was rejected. Do we now need to work around the problem in drivers ?

> > +		return;
> > +	}
> > +
> > +	desc = to_dpdma_tx_desc(vdesc);
> > +	chan->desc.pending = desc;
> > +	list_del(&desc->vdesc.node);
> > +
> > +	/*
> > +	 * Assign the cookie to descriptors in this transaction. Only 16 bit
> > +	 * will be used, but it should be enough.
> > +	 */
> > +	list_for_each_entry(sw_desc, &desc->descriptors, node)
> > +		sw_desc->hw.desc_id = desc->vdesc.tx.cookie;
> > +
> > +	sw_desc = list_first_entry(&desc->descriptors,
> > +				   struct xilinx_dpdma_sw_desc, node);
> > +	dpdma_write(chan->reg, XILINX_DPDMA_CH_DESC_START_ADDR,
> > +		    lower_32_bits(sw_desc->dma_addr));
> > +	if (xdev->ext_addr)
> > +		dpdma_write(chan->reg, XILINX_DPDMA_CH_DESC_START_ADDRE,
> > +			    FIELD_PREP(XILINX_DPDMA_CH_DESC_START_ADDRE_MASK,
> > +				       upper_32_bits(sw_desc->dma_addr)));
> > +
> > +	if (chan->first_frame)
> > +		reg = XILINX_DPDMA_GBL_TRIG_MASK(channels);
> > +	else
> > +		reg = XILINX_DPDMA_GBL_RETRIG_MASK(channels);
> > +
> > +	chan->first_frame = false;
> > +
> > +	dpdma_write(xdev->reg, XILINX_DPDMA_GBL, reg);
> > +}

-- 
Regards,

Laurent Pinchart
