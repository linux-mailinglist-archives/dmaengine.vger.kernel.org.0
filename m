Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED03F1E53AE
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 04:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgE1CKX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 May 2020 22:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1CKW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 May 2020 22:10:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9DDC05BD1E
        for <dmaengine@vger.kernel.org>; Wed, 27 May 2020 19:10:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D7B932A3;
        Thu, 28 May 2020 04:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1590631821;
        bh=cbNdkJPjvsN1SEbG2Prk3NpuF2RkyMuhBgjocskL8ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtMv6YAhXcT/da7iL5lT+nNv7RmSwWxBxr9vzwcLtpdInrzG0pV31lwMshQixgVjh
         qty4PLXPff0FIWQNtPhzDPO15dkmvhYUpVRSLMnSW5W419OlSwrDhHeicxVTOuirJY
         qxV8aW+vhV247xVqnQvCtFew5NifUf9A4NrGPPlk=
Date:   Thu, 28 May 2020 05:10:06 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v4 3/6] dmaengine: Add support for repeating transactions
Message-ID: <20200528021006.GG4670@pendragon.ideasonboard.com>
References: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
 <20200513165943.25120-4-laurent.pinchart@ideasonboard.com>
 <20200514182344.GI14092@vkoul-mobl>
 <20200514200709.GL5955@pendragon.ideasonboard.com>
 <20200515083817.GP333670@vkoul-mobl>
 <20200515141101.GA7186@pendragon.ideasonboard.com>
 <d270d4ca-1928-a11a-3186-bc118c4b8756@ti.com>
 <20200518143208.GD5851@pendragon.ideasonboard.com>
 <872d2f33-cdea-34c3-38b4-601d6dae7c94@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <872d2f33-cdea-34c3-38b4-601d6dae7c94@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Tue, May 19, 2020 at 03:41:17PM +0300, Peter Ujfalusi wrote:
> On 18/05/2020 17.32, Laurent Pinchart wrote:
> >>>>>>> @@ -176,6 +177,11 @@ struct dma_interleaved_template {
> >>>>>>>   * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is command
> >>>>>>>   *  data and the descriptor should be in different format from normal
> >>>>>>>   *  data descriptors.
> >>>>>>> + * @DMA_PREP_REPEAT: tell the driver that the transaction shall be automatically
> >>>>>>> + *  repeated when it ends if no other transaction has been issued on the same
> >>>>>>> + *  channel. If other transactions have been issued, this transaction completes
> >>>>>>> + *  normally. This flag is only applicable to interleaved transactions and is
> >>>>>>> + *  ignored for all other transaction types.
> >>
> >> It should not be restricted to interleaved, slave_sg/memcpy/etc can be
> >> repeated if the DMA driver implements it (a user on a given platform
> >> needs it).
> > 
> > As mentioned in the commit message, I plan to extend that, I just didn't
> > want to add the checks to all the prepare operation wrappers until an
> > agreement on the approach would be reached. I also thought it would be
> > good to not allow this API for other transaction types until use cases
> > arise, in order to force upstream discussions instead of silently
> > abusing the API :-)
> 
> I would not object if slave_sg and memcpy got the same treatment. If the
> DMA driver did not set the DMA_REPEAT then clients can not use this
> feature anyways.

Would you not object, or would you prefer if it was done in v5 ? :-)
Overall I think that enabling APIs that have no user isn't necessarily
the best idea, as it's prone to design issues, but I don't mind doing so
if you think it needs to be done now.

> > I can extend the flag to all other transaction types
> > (except for the cyclic transaction, as it doesn't make sense there).
> 
> Yep, cyclic is a different type of transfer, it is for circular buffers.
> It could be seen as a special case of slave_sg. Some drivers actually
> create temporary sg_list in case of cyclic and use the same setup
> function to set up the transfer for slave_sg/cyclic...

Cyclic is different for historical reasons, but if I had to redesign it
today, I'd make it slave_sg + DMA_PREP_REPEAT. We obviously can't, and I
have no issue with that.

> >>>>>>>   */
> >>>>>>>  enum dma_ctrl_flags {
> >>>>>>>  	DMA_PREP_INTERRUPT = (1 << 0),
> >>>>>>> @@ -186,6 +192,7 @@ enum dma_ctrl_flags {
> >>>>>>>  	DMA_PREP_FENCE = (1 << 5),
> >>>>>>>  	DMA_CTRL_REUSE = (1 << 6),
> >>>>>>>  	DMA_PREP_CMD = (1 << 7),
> >>>>>>> +	DMA_PREP_REPEAT = (1 << 8),
> >>>>>>
> >>>>>> Thanks for sending this. I think this is a good proposal which Peter
> >>>>>> made for solving this issue and it has great merits, but this is
> >>>>>> incomplete.
> >>>>>>
> >>>>>> DMA_PREP_REPEAT|RELOAD should only imply repeating of transactions,
> >>>>>> nothing else. I would like to see APIs having explicit behaviour, so let
> >>>>>> us also add another flag DMA_PREP_LOAD_NEXT|NEW to indicate that the
> >>>>>> next transactions will replace the current one when submitted after calling
> >>>>>> .issue_pending().
> >>>>>>
> >>>>>> Also it makes sense to explicitly specify when the transaction should be
> >>>>>> reloaded. Rather than make a guesswork based on hardware support, we
> >>>>>> should specify the EOB/EOT in these flags as well.
> >>>>>>
> >>>>>> Next is callback notification mechanism and when it should be invoked.
> >>>>>> EOT is today indicated by DMA_PREP_INTERRUPT, EOB needs to be added.
> >>>>>>
> >>>>>> So to summarize your driver needs to invoke
> >>>>>> DMA_PREP_REPEAT|DMA_PREP_LOAD_NEXT|DMA_LOAD_EOT|DMA_PREP_INTERRUPT
> >>>>>> specifying that the transactions are repeated untill next one pops up
> >>>>>> and replaced at EOT with callbacks being invoked at EOT boundaries.
> >>>
> >>> Peter, what do you think ?
> >>
> >> Well, I'm in between ;)
> >>
> >> You have a dedicated DMA which can do one thing - to service display.
> >> DMAengine provides generic API for DMA use users.
> >>
> >> The DMA_PREP_REPEAT is a new flag for a descriptor, imho it can be
> >> introduced without breaking anything which exists today.
> >>
> >> DMA_PREP_REPEAT - the descriptor should be repeated until the channel is
> >> terminated with terminate_all.
> > 
> > No concern about DMA_PREP_REPEAT, I like the idea.
> > 
> >> DMA_PREP_LOAD_EOT - the descriptor should be loaded at the next EOT of
> >> the currently running transfer, if any, otherwise start.
> > 
> > Why is this needed ? Why can't this be the default behaviour ? What the
> > use case for queuing a descriptor with DMA_PREP_REPEAT and *not* setting
> > DMA_PREP_LOAD_EOT on the next one ? If a client queues the next
> > descriptor without DMA_PREP_LOAD_EOT, the DMA engine will keep repeating
> > the previous one, the client will hang forever waiting for the switch to
> > the new descriptor that will never happen, and no error message or other
> > diagnostic information will be provided. This creates an API that as no
> > purpose (or at least no specified purpose, if there's an actual use case
> > for not specifying that flag, I'm willing to discuss it) and makes it
> > easy to shoot oneself in the foot. A good API should be impossible to
> > misuse (this can of course not always be achieved in practice, but it's
> > still a good goal to aim for).
> 
> If no DMA_PRP_LOAD_EOT is set then yes, the running transfer will not
> move towards, like how the cyclic is working.
> and...
> 
> > And this doesn't even mention DMA_PREP_LOAD_NEXT, that seems equally
> > design as a way to maximize chances that drivers will get something
> > wrong :-)
> > 
> >> DMA_PREP_INTERRUPT - as it is today. Callback at EOT (for
> >> slave_sg/interleaved/memcpy/etc, cyclic interprets this differently -
> >> callback at period elapse time).
> >>
> >> So you would set DMA_PREP_REPEAT | DMA_PREP_LOAD_EOT (|
> >> DMA_PREP_INTERRUPT if you need callbacks at EOT).
> >>
> >> The capabilities of the device/channel should tell the user if it is
> >> capable of REPEAT and LOAD_EOT.
> >> It is possible that a DMA can do repeat, but lacks the ability to do any
> >> type of LOAD_*
> > 
> > This is the kind of information I was looking for, thanks. I agree that
> > some DMA engines may not be able to replace a repeated transfer (I'm
> > using the word repeated here instead of cyclic, to avoid confusion with
> > the existing cyclic transfer type) at EOT. I however assume they would
> > all have the ability to replace it immediately, as DMA engines are
> > required to implement terminate_all(), and replacing a transfer
> > immediately can then just be a combination of terminate_all() + starting
> > the next transfer. Whether we want DMA engines to implement this
> > internally instead of having the logical on the client side (as done
> > today) is another question, and I'm not pushing in one direction or
> > another here (although I think we could explore the option of
> > implementing this in the DMA engine core).
> > 
> > Having a capability flag to report if a DMA engine supports replacing a
> > repeated transfer at EOT makes sense (no idea if we will have DMA
> > engines supporting DMA_REPEAT but not DMA_LOAD_EOT, but that's another
> > story, at least in theory it could happen). I hwoever don't see what a
> > DMA_PREP_LOAD_EOT flag is needed, if this feature isn't supported,
> > shouldn't tx_submit() and/or issue_pending() fail when a repeated
> > transfer is queued ? Succeeding in tx_submit() and issue_pending() and
> > doing nothing with the newly queued transfers is, as I explained above,
> > a very good way to increase the chance of bugs. I don't see a reason why
> > accepting a call that we know will not perform what the caller expects
> > it to perform whould be a good idea.
> 
> I would argue that the DMA_PREP_RELOAD_NOW (ASAP?) is a bit more than
> terminate_all+issue_pending.
> 
> But, DMA drivers might support neither of them, either of them or both.
> It is up to the client to pick the preferred method for it's use.
> It is not far fetched that the next DMA the client is going to be
> serviced will have different capabilities and the client needs to handle
> EOT or NOW or it might even need to have fallback to case when neither
> is supported.
> 
> I don't like excessive flags either, but based on my experience
> under-flagging can bite back sooner than later.
> 
> I'm aware that at the moment it feels like it is too explicit, but never
> underestimate the creativity of the design - and in some cases the
> constraint the design must fulfill.

I'm still very puzzled by why you think adding DMA_PREP_LOAD_EOT now is
a good idea, given that there's no existing and no foreseen use case for
not setting it. Creating an API element that is completely disconnected
from any known use case doesn't seem like good API design to me,
especially for an in-kernel API.

> >> I think this would give a nice starting point to extend on later.
> >>
> >>>>> Are you *serious* ? I feel trapped in a cross-over of Groundhog Day and
> >>>>> Brazil.
> >>>>
> >>>> Sorry, I don't understand that reference!
> >>>>
> >>>> Nevertheless, you want a behaviour which is somehow defined by your use
> >>>> and magically implies certain conditions. I do not want it that way.
> >>>> I would rather see all the flag required.
> >>>>
> >>>>>> @Peter, did I miss anything else in this..? Please send the patch for
> >>>>>> this (to start with just the headers so that Laurent can start
> >>>>>> using them) and detailed patch with documentation as follow up, I trust
> >>>>>> you two can coordinate :)
> >>>>>
> >>>>> I won't call that coordination, no. If you want to design something
> >>>>> absurd that's your call, not mine, I don't want to get involved.
> >>>>
> >>>> Your wish!

-- 
Regards,

Laurent Pinchart
