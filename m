Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE19B1479D1
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 09:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgAXI5O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jan 2020 03:57:14 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:60734 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAXI5O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Jan 2020 03:57:14 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6B97E97D;
        Fri, 24 Jan 2020 09:57:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1579856231;
        bh=nR5jS4ggYyNFcdVcCJJseRWpKNbhNnPpgQE+OfW5uNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZAI0XXGvNB4TPaKlyL3yp8dyyCU2Vhcf2TJFYauqKzKnEXeu/pjf5TxhuTeQo3w7
         RdkjJAxriY3lfalcTesMbR/8dpIQgLutiQCKtmKl5B40XGWPbEqIoJ8Wk+FF2qW2mD
         iZel+cTIrAIetTYSF12lDCZ4j3MOH/7U840N7WF8=
Date:   Fri, 24 Jan 2020 10:56:54 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200124085654.GB4842@pendragon.ideasonboard.com>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
 <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
 <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
 <20200123084352.GU2841@vkoul-mobl>
 <88aa9920-cdaf-97f0-c36f-66a998860ed2@ti.com>
 <20200123122304.GB13922@pendragon.ideasonboard.com>
 <ded9c051-11f3-e61a-e0de-1cd54a8c85d5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ded9c051-11f3-e61a-e0de-1cd54a8c85d5@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On Fri, Jan 24, 2020 at 09:20:15AM +0200, Peter Ujfalusi wrote:
> On 23/01/2020 14.23, Laurent Pinchart wrote:
> >>>> I think capture (camera) is another potential beneficiary of this.
> > 
> > Possibly, although in the camera case I'd rather have the hardware stop
> > if there's no more buffer. Requiring a buffer to always be present is
> > annoying from a userspace point of view. For display it's different, if
> > userspace doesn't submit a new frame, the same frame should keep being
> > displayed on the screen.
> > 
> >>>> So you don't need to terminate the running interleaved_cyclic and start
> >>>> a new one, but prepare and issue a new one, which would
> >>>> terminate/replace the currently running cyclic interleaved DMA?
> > 
> > Correct.
> > 
> >>> Why not explicitly terminate the transfer and start when a new one is
> >>> issued. That can be common usage for audio and display..
> >>
> >> Yes, this is what I'm asking. The cyclic transfer is running and in
> >> order to start the new transfer, the previous should stop. But in cyclic
> >> case it is not going to happen unless it is terminated.
> >>
> >> When one would want to have different interleaved transfer the display
> >> (or capture )IP needs to be reconfigured as well. The the would need to
> >> be terminated anyways to avoid interpreting data in a wrong way.
> > 
> > The use case here is not to switch to a new configuration, but to switch
> > to a new buffer. If the transfer had to be terminated manually first,
> > the DMA engine would potentially miss a frame, which is not acceptable.
> > We need an atomic way to switch to the next transfer.
> 
> You have a special hardware in hand, most DMAs can not just replace a
> cyclic transfer in-flight and it also kind of violates the DMAengine
> principles.

That's why cyclic support is optional :-)

> If cyclic transfer is started then it is expected to run forever until
> it is terminated. Preparing and issuing a new transfer will not get
> executed when there is already a cyclic transfer in flight as your only
> option is to terminate_all, which will kill the running cyclic _and_
> will discard the issued and pending transfers.

For the existing cyclic API, I could agree with that, although there's
very little documentation in the dmaengine subsystem to be used as an
authoritative source of information :-(

> So the use case is page flip when you have multiple framebuffers and you
> switch them to show the updated one, right?

Correct.

> There are things missing in DMAengine in API level for sure to do this,
> imho.
> The issue is that cyclic transfers will never complete, they run until
> terminated, but you want to replace the currently executing one with a
> another cyclic transfer without actually terminating the other.

Correct.

> It is like pause the 1st cyclic and continue with the 2nd one. Then at
> some point you pause the 2nd one and restart the 1st one.

No, after the 2nd one comes the 3rd one. It's not a double-buffering
case, it's really about replacing the buffer with another one,
regardless of where it comes from. Userspace may double-buffer, or
triple, or more.

> It is also crucial that the pause /switch happens when the executing one
> finished the interleaved round and not in the middle somewhere, right?

Yes. But that's not specific to this use case, with all non-cyclic
transfers submitting a new transfer request doesn't stop the ongoing
transfer (if any) immediately, it just queues the new transfer for
processing.

> If you:
> desc_1 = dmaengine_prep_interleaved_cyclic(chan, );
> cookie_1 = dmaengine_submit(desc_1);
> desc_2 = dmaengine_prep_interleaved_cyclic(chan, );
> cookie_2 = dmaengine_submit(desc_1);
> 
> /* cookie_1/desc_1 is started */
> dma_async_issue_pending(chan);
> 
> /* When need to switch to cookie_2 */
> dmaengine_cyclic_set_active_cookie(chan, cookie_2);
> /*
>  * cookie_1 execution is suspended after it finished the running
>  * dma_interleaved_template or buffer in normal cyclic and cookie_2
>  * is replacing it.
>  */
> 
> /* Switch back to cookie_1 */
> dmaengine_cyclic_set_active_cookie(chan, cookie_1);
> /*
>  * cookie_2 execution is suspended after it finished the running
>  * dma_interleaved_template or buffer in normal cyclic and cookie_1
>  * is replacing it.
>  */

As explained above, I don't want to switch back to a previous transfer,
I always want a new one. I don't see why we would need this kind of API
when we can just define that any queued interleaved transfer, whether
cyclic or not, is just queued and replaces the ongoing transfer at the
next frame boundary. Drivers don't have to implement the new API if the
hardware doesn't possess this capability.

> There should be a (yet another) capabilities flag got
> cyclic_set_active_cookie and the documentation should be strict on what
> is the expected behavior.
> 
> You can kill everything with terminate_all.
> There is another thing which is missing imho from DMAengine: to
> terminate a specific cookie, not the entire channel, which might be a
> good addition as you might spawn framebuffers and then delete them and
> you might want to release the corresponding cookie/descriptor as well.
> 
> What do you think?

I think it's overcomplicated for this use case :-)

-- 
Regards,

Laurent Pinchart
