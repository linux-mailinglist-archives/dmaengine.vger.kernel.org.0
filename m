Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF61D5018
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEOOLL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 10:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOLL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 May 2020 10:11:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB9CC061A0C
        for <dmaengine@vger.kernel.org>; Fri, 15 May 2020 07:11:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0461026A;
        Fri, 15 May 2020 16:11:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1589551869;
        bh=I8TI8hRDa2IBhXZefnO3YqDAGDYQS/6NvXOMeR0pdzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9w1eDEz1cnBcZHR7lcTSZV9/jmandrv7zjeajgJ8aQlTx1//RzWUa1jk/KVuuEjS
         wHnlv1U8AJHW4HPOWxLDbhvjCEKrcmv9omTWJGcAnGSnjHFgQMSB+ewsISePSYUGWL
         fkISvivmSQqrEOXNd+uF6NBeIchpKC6wzVqtu+H4=
Date:   Fri, 15 May 2020 17:11:01 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v4 3/6] dmaengine: Add support for repeating transactions
Message-ID: <20200515141101.GA7186@pendragon.ideasonboard.com>
References: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
 <20200513165943.25120-4-laurent.pinchart@ideasonboard.com>
 <20200514182344.GI14092@vkoul-mobl>
 <20200514200709.GL5955@pendragon.ideasonboard.com>
 <20200515083817.GP333670@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515083817.GP333670@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 15, 2020 at 02:08:17PM +0530, Vinod Koul wrote:
> Hi Laurent,
> 
> On 14-05-20, 23:07, Laurent Pinchart wrote:
> > On Thu, May 14, 2020 at 11:53:44PM +0530, Vinod Koul wrote:
> > > On 13-05-20, 19:59, Laurent Pinchart wrote:
> > > > DMA engines used with displays perform 2D interleaved transfers to read
> > > > framebuffers from memory and feed the data to the display engine. As the
> > > > same framebuffer can be displayed for multiple frames, the DMA
> > > > transactions need to be repeated until a new framebuffer replaces the
> > > > current one. This feature is implemented natively by some DMA engines
> > > > that have the ability to repeat transactions and switch to a new
> > > > transaction at the end of a transfer without any race condition or frame
> > > > loss.
> > > > 
> > > > This patch implements support for this feature in the DMA engine API. A
> > > > new DMA_PREP_REPEAT transaction flag allows DMA clients to instruct the
> > > > DMA channel to repeat the transaction automatically until one or more
> > > > new transactions are issued on the channel (or until all active DMA
> > > > transfers are explicitly terminated with the dmaengine_terminate_*()
> > > > functions). A new DMA_REPEAT transaction type is also added for DMA
> > > > engine drivers to report their support of the DMA_PREP_REPEAT flag.
> > > > 
> > > > The DMA_PREP_REPEAT flag is currently supported for interleaved
> > > > transactions only. Its usage can easily be extended to cover more
> > > > transaction types simply by adding an appropriate check in the
> > > > corresponding dmaengine_prep_*() function.
> > > > 
> > > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > ---
> > > > If this approach is accepted I can send a new version that updates
> > > > documentation in Documentation/driver-api/dmaengine/, and extend support
> > > > of DMA_PREP_REPEAT to the other transaction types, if desired already.
> > > > 
> > > >  include/linux/dmaengine.h | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > > index 64461fc64e1b..9fa00bdbf583 100644
> > > > --- a/include/linux/dmaengine.h
> > > > +++ b/include/linux/dmaengine.h
> > > > @@ -61,6 +61,7 @@ enum dma_transaction_type {
> > > >  	DMA_SLAVE,
> > > >  	DMA_CYCLIC,
> > > >  	DMA_INTERLEAVE,
> > > > +	DMA_REPEAT,
> > > >  /* last transaction type for creation of the capabilities mask */
> > > >  	DMA_TX_TYPE_END,
> > > >  };
> > > > @@ -176,6 +177,11 @@ struct dma_interleaved_template {
> > > >   * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is command
> > > >   *  data and the descriptor should be in different format from normal
> > > >   *  data descriptors.
> > > > + * @DMA_PREP_REPEAT: tell the driver that the transaction shall be automatically
> > > > + *  repeated when it ends if no other transaction has been issued on the same
> > > > + *  channel. If other transactions have been issued, this transaction completes
> > > > + *  normally. This flag is only applicable to interleaved transactions and is
> > > > + *  ignored for all other transaction types.
> > > >   */
> > > >  enum dma_ctrl_flags {
> > > >  	DMA_PREP_INTERRUPT = (1 << 0),
> > > > @@ -186,6 +192,7 @@ enum dma_ctrl_flags {
> > > >  	DMA_PREP_FENCE = (1 << 5),
> > > >  	DMA_CTRL_REUSE = (1 << 6),
> > > >  	DMA_PREP_CMD = (1 << 7),
> > > > +	DMA_PREP_REPEAT = (1 << 8),
> > > 
> > > Thanks for sending this. I think this is a good proposal which Peter
> > > made for solving this issue and it has great merits, but this is
> > > incomplete.
> > > 
> > > DMA_PREP_REPEAT|RELOAD should only imply repeating of transactions,
> > > nothing else. I would like to see APIs having explicit behaviour, so let
> > > us also add another flag DMA_PREP_LOAD_NEXT|NEW to indicate that the
> > > next transactions will replace the current one when submitted after calling
> > > .issue_pending().
> > > 
> > > Also it makes sense to explicitly specify when the transaction should be
> > > reloaded. Rather than make a guesswork based on hardware support, we
> > > should specify the EOB/EOT in these flags as well.
> > > 
> > > Next is callback notification mechanism and when it should be invoked.
> > > EOT is today indicated by DMA_PREP_INTERRUPT, EOB needs to be added.
> > > 
> > > So to summarize your driver needs to invoke
> > > DMA_PREP_REPEAT|DMA_PREP_LOAD_NEXT|DMA_LOAD_EOT|DMA_PREP_INTERRUPT
> > > specifying that the transactions are repeated untill next one pops up
> > > and replaced at EOT with callbacks being invoked at EOT boundaries.

Peter, what do you think ?

> > Are you *serious* ? I feel trapped in a cross-over of Groundhog Day and
> > Brazil.
> 
> Sorry, I don't understand that reference!
> 
> Nevertheless, you want a behaviour which is somehow defined by your use
> and magically implies certain conditions. I do not want it that way.
> I would rather see all the flag required.
> 
> > > @Peter, did I miss anything else in this..? Please send the patch for
> > > this (to start with just the headers so that Laurent can start
> > > using them) and detailed patch with documentation as follow up, I trust
> > > you two can coordinate :)
> > 
> > I won't call that coordination, no. If you want to design something
> > absurd that's your call, not mine, I don't want to get involved.
> 
> Your wish!

-- 
Regards,

Laurent Pinchart
