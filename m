Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC4E1D7B4B
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2020 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgEROcV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 May 2020 10:32:21 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36368 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgEROcU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 May 2020 10:32:20 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 63475258;
        Mon, 18 May 2020 16:32:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1589812337;
        bh=58B79mQVbrAoLTAOJsYGx4PUL8lmc3pe60bTCt0AP/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3uOEheUcbo1ZGH7x5P5rrY70LtaLqOnWbTlrshgf8twlNjV9ESv6bkFzHOOiPoLu
         5VUoXFoHMQ92NJyQl8wPJHh2CNuzQlRQZvgQMXAra4dEg+5WJqDcdriLxtjBfzMV9j
         qB3Q44fKsQitqZPC+Wwk/j9jo1hLSaAbXXcNbSBM=
Date:   Mon, 18 May 2020 17:32:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v4 3/6] dmaengine: Add support for repeating transactions
Message-ID: <20200518143208.GD5851@pendragon.ideasonboard.com>
References: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
 <20200513165943.25120-4-laurent.pinchart@ideasonboard.com>
 <20200514182344.GI14092@vkoul-mobl>
 <20200514200709.GL5955@pendragon.ideasonboard.com>
 <20200515083817.GP333670@vkoul-mobl>
 <20200515141101.GA7186@pendragon.ideasonboard.com>
 <d270d4ca-1928-a11a-3186-bc118c4b8756@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d270d4ca-1928-a11a-3186-bc118c4b8756@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Mon, May 18, 2020 at 04:57:07PM +0300, Peter Ujfalusi wrote:
> On 15/05/2020 17.11, Laurent Pinchart wrote:
> > On Fri, May 15, 2020 at 02:08:17PM +0530, Vinod Koul wrote:
> >> On 14-05-20, 23:07, Laurent Pinchart wrote:
> >>> On Thu, May 14, 2020 at 11:53:44PM +0530, Vinod Koul wrote:
> >>>> On 13-05-20, 19:59, Laurent Pinchart wrote:
> >>>>> DMA engines used with displays perform 2D interleaved transfers to read
> >>>>> framebuffers from memory and feed the data to the display engine. As the
> >>>>> same framebuffer can be displayed for multiple frames, the DMA
> >>>>> transactions need to be repeated until a new framebuffer replaces the
> >>>>> current one. This feature is implemented natively by some DMA engines
> >>>>> that have the ability to repeat transactions and switch to a new
> >>>>> transaction at the end of a transfer without any race condition or frame
> >>>>> loss.
> >>>>>
> >>>>> This patch implements support for this feature in the DMA engine API. A
> >>>>> new DMA_PREP_REPEAT transaction flag allows DMA clients to instruct the
> >>>>> DMA channel to repeat the transaction automatically until one or more
> >>>>> new transactions are issued on the channel (or until all active DMA
> >>>>> transfers are explicitly terminated with the dmaengine_terminate_*()
> >>>>> functions). A new DMA_REPEAT transaction type is also added for DMA
> >>>>> engine drivers to report their support of the DMA_PREP_REPEAT flag.
> >>>>>
> >>>>> The DMA_PREP_REPEAT flag is currently supported for interleaved
> >>>>> transactions only. Its usage can easily be extended to cover more
> >>>>> transaction types simply by adding an appropriate check in the
> >>>>> corresponding dmaengine_prep_*() function.
> >>>>>
> >>>>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>> ---
> >>>>> If this approach is accepted I can send a new version that updates
> >>>>> documentation in Documentation/driver-api/dmaengine/, and extend support
> >>>>> of DMA_PREP_REPEAT to the other transaction types, if desired already.
> >>>>>
> >>>>>  include/linux/dmaengine.h | 10 ++++++++++
> >>>>>  1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> >>>>> index 64461fc64e1b..9fa00bdbf583 100644
> >>>>> --- a/include/linux/dmaengine.h
> >>>>> +++ b/include/linux/dmaengine.h
> >>>>> @@ -61,6 +61,7 @@ enum dma_transaction_type {
> >>>>>  	DMA_SLAVE,
> >>>>>  	DMA_CYCLIC,
> >>>>>  	DMA_INTERLEAVE,
> >>>>> +	DMA_REPEAT,
> >>>>>  /* last transaction type for creation of the capabilities mask */
> >>>>>  	DMA_TX_TYPE_END,
> >>>>>  };
> >>>>> @@ -176,6 +177,11 @@ struct dma_interleaved_template {
> >>>>>   * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is command
> >>>>>   *  data and the descriptor should be in different format from normal
> >>>>>   *  data descriptors.
> >>>>> + * @DMA_PREP_REPEAT: tell the driver that the transaction shall be automatically
> >>>>> + *  repeated when it ends if no other transaction has been issued on the same
> >>>>> + *  channel. If other transactions have been issued, this transaction completes
> >>>>> + *  normally. This flag is only applicable to interleaved transactions and is
> >>>>> + *  ignored for all other transaction types.
> 
> It should not be restricted to interleaved, slave_sg/memcpy/etc can be
> repeated if the DMA driver implements it (a user on a given platform
> needs it).

As mentioned in the commit message, I plan to extend that, I just didn't
want to add the checks to all the prepare operation wrappers until an
agreement on the approach would be reached. I also thought it would be
good to not allow this API for other transaction types until use cases
arise, in order to force upstream discussions instead of silently
abusing the API :-) I can extend the flag to all other transaction types
(except for the cyclic transaction, as it doesn't make sense there).

> >>>>>   */
> >>>>>  enum dma_ctrl_flags {
> >>>>>  	DMA_PREP_INTERRUPT = (1 << 0),
> >>>>> @@ -186,6 +192,7 @@ enum dma_ctrl_flags {
> >>>>>  	DMA_PREP_FENCE = (1 << 5),
> >>>>>  	DMA_CTRL_REUSE = (1 << 6),
> >>>>>  	DMA_PREP_CMD = (1 << 7),
> >>>>> +	DMA_PREP_REPEAT = (1 << 8),
> >>>>
> >>>> Thanks for sending this. I think this is a good proposal which Peter
> >>>> made for solving this issue and it has great merits, but this is
> >>>> incomplete.
> >>>>
> >>>> DMA_PREP_REPEAT|RELOAD should only imply repeating of transactions,
> >>>> nothing else. I would like to see APIs having explicit behaviour, so let
> >>>> us also add another flag DMA_PREP_LOAD_NEXT|NEW to indicate that the
> >>>> next transactions will replace the current one when submitted after calling
> >>>> .issue_pending().
> >>>>
> >>>> Also it makes sense to explicitly specify when the transaction should be
> >>>> reloaded. Rather than make a guesswork based on hardware support, we
> >>>> should specify the EOB/EOT in these flags as well.
> >>>>
> >>>> Next is callback notification mechanism and when it should be invoked.
> >>>> EOT is today indicated by DMA_PREP_INTERRUPT, EOB needs to be added.
> >>>>
> >>>> So to summarize your driver needs to invoke
> >>>> DMA_PREP_REPEAT|DMA_PREP_LOAD_NEXT|DMA_LOAD_EOT|DMA_PREP_INTERRUPT
> >>>> specifying that the transactions are repeated untill next one pops up
> >>>> and replaced at EOT with callbacks being invoked at EOT boundaries.
> > 
> > Peter, what do you think ?
> 
> Well, I'm in between ;)
> 
> You have a dedicated DMA which can do one thing - to service display.
> DMAengine provides generic API for DMA use users.
> 
> The DMA_PREP_REPEAT is a new flag for a descriptor, imho it can be
> introduced without breaking anything which exists today.
> 
> DMA_PREP_REPEAT - the descriptor should be repeated until the channel is
> terminated with terminate_all.

No concern about DMA_PREP_REPEAT, I like the idea.

> DMA_PREP_LOAD_EOT - the descriptor should be loaded at the next EOT of
> the currently running transfer, if any, otherwise start.

Why is this needed ? Why can't this be the default behaviour ? What the
use case for queuing a descriptor with DMA_PREP_REPEAT and *not* setting
DMA_PREP_LOAD_EOT on the next one ? If a client queues the next
descriptor without DMA_PREP_LOAD_EOT, the DMA engine will keep repeating
the previous one, the client will hang forever waiting for the switch to
the new descriptor that will never happen, and no error message or other
diagnostic information will be provided. This creates an API that as no
purpose (or at least no specified purpose, if there's an actual use case
for not specifying that flag, I'm willing to discuss it) and makes it
easy to shoot oneself in the foot. A good API should be impossible to
misuse (this can of course not always be achieved in practice, but it's
still a good goal to aim for).

And this doesn't even mention DMA_PREP_LOAD_NEXT, that seems equally
design as a way to maximize chances that drivers will get something
wrong :-)

> DMA_PREP_INTERRUPT - as it is today. Callback at EOT (for
> slave_sg/interleaved/memcpy/etc, cyclic interprets this differently -
> callback at period elapse time).
> 
> So you would set DMA_PREP_REPEAT | DMA_PREP_LOAD_EOT (|
> DMA_PREP_INTERRUPT if you need callbacks at EOT).
> 
> The capabilities of the device/channel should tell the user if it is
> capable of REPEAT and LOAD_EOT.
> It is possible that a DMA can do repeat, but lacks the ability to do any
> type of LOAD_*

This is the kind of information I was looking for, thanks. I agree that
some DMA engines may not be able to replace a repeated transfer (I'm
using the word repeated here instead of cyclic, to avoid confusion with
the existing cyclic transfer type) at EOT. I however assume they would
all have the ability to replace it immediately, as DMA engines are
required to implement terminate_all(), and replacing a transfer
immediately can then just be a combination of terminate_all() + starting
the next transfer. Whether we want DMA engines to implement this
internally instead of having the logical on the client side (as done
today) is another question, and I'm not pushing in one direction or
another here (although I think we could explore the option of
implementing this in the DMA engine core).

Having a capability flag to report if a DMA engine supports replacing a
repeated transfer at EOT makes sense (no idea if we will have DMA
engines supporting DMA_REPEAT but not DMA_LOAD_EOT, but that's another
story, at least in theory it could happen). I hwoever don't see what a
DMA_PREP_LOAD_EOT flag is needed, if this feature isn't supported,
shouldn't tx_submit() and/or issue_pending() fail when a repeated
transfer is queued ? Succeeding in tx_submit() and issue_pending() and
doing nothing with the newly queued transfers is, as I explained above,
a very good way to increase the chance of bugs. I don't see a reason why
accepting a call that we know will not perform what the caller expects
it to perform whould be a good idea.

> I think this would give a nice starting point to extend on later.
> 
> >>> Are you *serious* ? I feel trapped in a cross-over of Groundhog Day and
> >>> Brazil.
> >>
> >> Sorry, I don't understand that reference!
> >>
> >> Nevertheless, you want a behaviour which is somehow defined by your use
> >> and magically implies certain conditions. I do not want it that way.
> >> I would rather see all the flag required.
> >>
> >>>> @Peter, did I miss anything else in this..? Please send the patch for
> >>>> this (to start with just the headers so that Laurent can start
> >>>> using them) and detailed patch with documentation as follow up, I trust
> >>>> you two can coordinate :)
> >>>
> >>> I won't call that coordination, no. If you want to design something
> >>> absurd that's your call, not mine, I don't want to get involved.
> >>
> >> Your wish!

-- 
Regards,

Laurent Pinchart
