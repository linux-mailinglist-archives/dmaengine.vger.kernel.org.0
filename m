Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80EABB8DB9
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2019 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408329AbfITJ1B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Sep 2019 05:27:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42187 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405604AbfITJ1B (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Sep 2019 05:27:01 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iBFBk-0004Qu-4T; Fri, 20 Sep 2019 11:26:52 +0200
Message-ID: <363fe4763ab3445f29f775b9694334acbe8638f1.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/3] dmaengine: imx-sdma: fix dma freezes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     fugang.duan@nxp.com, festevam@gmail.com, s.hauer@pengutronix.de,
        vkoul@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
        dan.j.williams@intel.com, yibin.gong@nxp.com, shawnguo@kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 20 Sep 2019 11:26:51 +0200
In-Reply-To: <9305e5ff-f555-3c6e-9e99-36d88edcae0a@emlix.com>
References: <20190919142942.12469-1-philipp.puschmann@emlix.com>
         <20190919142942.12469-3-philipp.puschmann@emlix.com>
         <ad87f175496358adb825240f1de609318ed8204c.camel@pengutronix.de>
         <9305e5ff-f555-3c6e-9e99-36d88edcae0a@emlix.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fr, 2019-09-20 at 10:53 +0200, Philipp Puschmann wrote:
> Hi Jan,
> 
> Am 19.09.19 um 17:19 schrieb Jan Lübbe:
> > Hi Philipp,
> > 
> > see below...
> > 
> > On Thu, 2019-09-19 at 16:29 +0200, Philipp Puschmann wrote:
> > > For some years and since many kernel versions there are reports that the
> > > RX UART SDMA channel stops working at some point. The workaround was to
> > > disable DMA for RX. This commit tries to fix the problem itself.
> > > 
> > > Due to its license i wasn't able to debug the sdma script itself but it
> > > somehow leads to blocking the scheduling of the channel script when a
> > > running sdma script does not find any free descriptor in the ring to put
> > > its data into.
> > > 
> > > If we detect such a potential case we manually restart the channel.
> > > 
> > > As sdmac->desc is constant we can move desc out of the loop.
> > > 
> > > Fixes: 1ec1e82f2510 ("dmaengine: Add Freescale i.MX SDMA support")
> > > Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > > 
> > > Changelog v4:
> > >  - fixed the fixes tag
> > >  
> > > Changelog v3:
> > >  - use correct dma_wmb() instead of dma_wb()
> > >  - add fixes tag
> > >  
> > > Changelog v2:
> > >  - clarify comment and commit description
> > > 
> > >  drivers/dma/imx-sdma.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > > index e029a2443cfc..a32b5962630e 100644
> > > --- a/drivers/dma/imx-sdma.c
> > > +++ b/drivers/dma/imx-sdma.c
> > > @@ -775,21 +775,23 @@ static void sdma_start_desc(struct sdma_channel *sdmac)
> > >  static void sdma_update_channel_loop(struct sdma_channel *sdmac)
> > >  {
> > >  	struct sdma_buffer_descriptor *bd;
> > > -	int error = 0;
> > > -	enum dma_status	old_status = sdmac->status;
> > > +	struct sdma_desc *desc = sdmac->desc;
> > > +	int error = 0, cnt = 0;
> > > +	enum dma_status old_status = sdmac->status;
> > >  
> > >  	/*
> > >  	 * loop mode. Iterate over descriptors, re-setup them and
> > >  	 * call callback function.
> > >  	 */
> > > -	while (sdmac->desc) {
> > > -		struct sdma_desc *desc = sdmac->desc;
> > > +	while (desc) {
> > >  
> > >  		bd = &desc->bd[desc->buf_tail];
> > >  
> > >  		if (bd->mode.status & BD_DONE)
> > >  			break;
> > >  
> > > +		cnt++;
> > > +
> > >  		if (bd->mode.status & BD_RROR) {
> > >  			bd->mode.status &= ~BD_RROR;
> > >  			sdmac->status = DMA_ERROR;
> > > @@ -822,6 +824,17 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
> > >  		if (error)
> > >  			sdmac->status = old_status;
> > >  	}
> > > +
> > > +	/* In some situations it may happen that the sdma does not found any
> >                                                           ^ hasn't
> > > +	 * usable descriptor in the ring to put data into. The channel is
> > > +	 * stopped then. While there is no specific error condition we can
> > > +	 * check for, a necessary condition is that all available buffers for
> > > +	 * the current channel have been written to by the sdma script. In
> > > +	 * this case and after we have made the buffers available again,
> > > +	 * we restart the channel.
> > > +	 */
> > 
> > Are you sure we can't miss cases where we only had to make some buffers
> > available again, but the SDMA already ran out of buffers before?
> Think so, yes.
> > A while ago, I was debugging a similar issue triggered by receiving
> > data with a wrong baud rate, which leads to all descriptors being
> > marked with the error flag very quickly (and the SDMA stalling).
> > I noticed that you can check if the channel is still running by
> > checking the SDMA_H_STATSTOP register & BIT(sdmac->channel).
> 
> I think checking for this register is the better approach. Then i could drop the
> cnt variable. And by droppting cnt i would propose to move the check and reenabling
> to the end of the while loop to reenable the channel after freeing first buffer.

You certainly don't want to have a MMIO read at each iteration of the
loop, as that would be quite a bit of overhead. I'm not sure it's worth
it to try to minimize the channel re-enable latency. You are only
getting into this situation because of bad system latencies before this
part of the code run, so the little bit of latency added by cleaning
the descriptors before trying to re-enable the channel will probably
not add much further harm and you don't risk running in the out-of-
descriptors error immediately again. Remember, in a preemptible kernel
the task cleaning the descriptors could be put to sleep immediately
after you you cleaned a single descriptor and kicked the channel back
to life.

> > I also added a flag for the sdmac->flags field to allow stopping the
> > channel from the callback (otherwise it would enable the channel
> > again).
> 
> Could memory and compiler ordering a problem here?
> I'm not that into these kind of problems, but is this
> 	sdmac->flags &= ~IMX_DMA_ACTIVE;
>   	writel_relaxed(BIT(channel), sdma->regs + SDMA_H_STATSTOP);
> guaranteed to be free of race conditions?

In fact the writel_relaxed needs to be replaced by the non-relaxed
version to imply a proper memory barrier before the register write.

Regards,
Lucas

