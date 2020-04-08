Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64E61A27A5
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2020 19:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDHRBA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Apr 2020 13:01:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33362 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgDHRBA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Apr 2020 13:01:00 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AF6BC522;
        Wed,  8 Apr 2020 19:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586365258;
        bh=MsZV3yDvG9XIt9P/905CeDawxUGjF7ho9/k9yar+Pzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhngO2KFgoZuVlYi43WakcjfRWmHSxtRENRtdFpIWt0mUJbn+EZWlQqtY4fBti5w7
         GYvFFhOpRdgdxshGXUZEg5XY614YH3SDJDCl/BiuCjjUj/tnb37LcnrX1g/ZGHQjGZ
         JRQ1hvmPnqdF8TNz4omSVJ+HnZpIcGCOVtlm6JvQ=
Date:   Wed, 8 Apr 2020 20:00:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200408170047.GA21714@pendragon.ideasonboard.com>
References: <20200302073728.GB9177@pendragon.ideasonboard.com>
 <20200303043254.GN4148@vkoul-mobl>
 <20200303192255.GN11333@pendragon.ideasonboard.com>
 <20200304051301.GS4148@vkoul-mobl>
 <20200304080128.GA4712@pendragon.ideasonboard.com>
 <20200304153718.GU4148@vkoul-mobl>
 <20200304160016.GB4712@pendragon.ideasonboard.com>
 <20200304162426.GV4148@vkoul-mobl>
 <20200311155248.GA4772@pendragon.ideasonboard.com>
 <20200326070234.GX72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326070234.GX72691@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Thu, Mar 26, 2020 at 12:32:34PM +0530, Vinod Koul wrote:
> On 11-03-20, 17:52, Laurent Pinchart wrote:
> > On Wed, Mar 04, 2020 at 09:54:26PM +0530, Vinod Koul wrote:
> >>>>>> Second in error handling where some engines do not support
> >>>>>> aborting (unless we reset the whole controller)
> >>>>> 
> >>>>> Could you explain that one ? I'm not sure to understand it.
> >>>> 
> >>>> So I have dma to a slow peripheral and it is stuck for some reason. I
> >>>> want to abort the cookie and let subsequent ones runs (btw this is for
> >>>> non cyclic case), so I would use that here. Today we terminate_all and
> >>>> then resubmit...
> >>> 
> >>> That's also for immediate abort, right ?
> >> 
> >> Right
> >> 
> >>> For this to work properly we need very accurate residue reporting, as
> >>> the client will usually need to know exactly what has been transferred.
> >>> The device would need to support DMA_RESIDUE_GRANULARITY_BURST when
> >>> aborting an ongoing transfer. What hardware supports this ?
> >> 
> >>  git grep DMA_RESIDUE_GRANULARITY_BURST drivers/dma/ |wc -l
> >> 27
> >> 
> >> So it seems many do support the burst reporting.
> > 
> > Yes, but not all of those may support aborting a transfer *and*
> > reporting the exact residue of cancelled transfers. We need both to
> > implement your proposal.
> 
> Reporting residue is already implemented, please see  struct
> dmaengine_result. This can be passed by a callback
> dma_async_tx_callback_result() in struct dma_async_tx_descriptor.

I mean that I don't know if the driver that support
DMA_RESIDUE_GRANULARITY_BURST only support reporting the residue when
the transfer is active, or also support reporting it when cancelling a
transfer. Maybe all of them do, maybe a subset of them do, so I can't
tell if this would be a feature that could be widely supported.

> >>>>>> But yes the .terminate_cookie() semantics should indicate if the
> >>>>>> termination should be immediate or end of current txn. I see people
> >>>>>> using it for both.
> >>>>> 
> >>>>> Immediate termination is *not* something I'll implement as I have no
> >>>>> good way to test that semantics. I assume you would be fine with leaving
> >>>>> that for later, when someone will need it ?
> >>>> 
> >>>> Sure, if you have hw to support please test. If not, you will not
> >>>> implement that.
> >>>> 
> >>>> The point is that API should support it and people can add support in
> >>>> the controllers and test :)
> >>> 
> >>> I still think this is a different API. We'll have
> >>> 
> >>> 1. Existing .issue_pending(), queueing the next transfer for non-cyclic
> >>>    cases, and being a no-op for cyclic cases.
> >>> 2. New .terminate_cookie(AT_END_OF_TRANSFER), being a no-op for
> >>>    non-cyclic cases, and moving to the next transfer for cyclic cases.
> >>> 3. New .terminate_cookie(ABORT_IMMEDIATELY), applicable to both cyclic
> >>>    and non-cyclic cases.
> >>> 
> >>> 3. is an API I don't need, and can't easily test. I agree that it can
> >>> have use cases (provided the DMA device can abort an ongoing transfer
> >>> *and* still support DMA_RESIDUE_GRANULARITY_BURST in that case).
> >>> 
> >>> I'm troubled by my inability to convince you that 1. and 2. are really
> >>> the same, with 1. addressing the non-cyclic case and 2. addressing the
> >>> cyclic case :-) This is why I think they should both be implemeted using
> >>> .issue_pending() (no other option for 1., that's what it uses today).
> >>> This wouldn't prevent implementing 3. with a new .terminate_cookie()
> >>> operation, that wouldn't need to take a flag as it would always operate
> >>> in ABORT_IMMEDIATELY mode. There would also be no need to report a new
> >>> capability for 3., as the presence of the .terminate_cookie() handler
> >>> would be enough to tell clients that the API is supported. Only a new
> >>> capability for 2. would be needed.
> >> 
> >> Well I agree 1 & 2 seem similar but I would like to define the behaviour
> >> not dependent on the txn being cyclic or not. That is my concern and
> >> hence the idea that:
> >> 
> >> 1. .issue_pending() will push txn to pending_queue, you may have a case
> >> where that is done only once (due to nature of txn), but no other
> >> implication
> >> 
> >> 2. .terminate_cookie(EOT) will abort the transfer at the end. Maybe not
> >> used for cyclic but irrespective of that, the behaviour would be abort
> >> at end of cyclic
> > 
> > Did you mean "maybe not used for non-cyclic" ?
> 
> Yes I think so..
> 
> >> 3. .terminate_cookie(IMMEDIATE) will abort immediately. If there is
> >> anything in pending_queue that will get pushed to hardware.
> >> 
> >> 4. Cyclic by nature never completes
> >>    - as a consequence needs to be stopped by terminate_all/terminate_cookie
> >> 
> >> Does these rules make sense :)
> > 
> > It's a set of rules that I think can handle my use case, but I still
> > believe my proposal based on just .issue_pending() would be simpler, in
> > line with the existing API concepts, and wouldn't preclude the addition
> > of .terminate_cookie(IMMEDIATE) at a later point. It's your call though,
> > especially if you provide the implementation :-) When do you think you
> > will be able to do so ?
> 
> I will try to take a stab at it once merge window opens.. will let you
> and Peter for sneak preview once I start on it :)

I started giving it a try as this has been blocked for two months and a
half now.

I very quickly ran into issues as the interface is ill-defined as it
stands.

- What should happen when .terminate_cookie(EOT) is called with no other
  transfer issued, and a new transfer is issued before the current
  transfer terminates ?

- I expect .terminate_cookie() to be asynchronous, as .terminate_all().
  This means that actual termination of cyclic transfers will actually
  be handled at end of transfer, in the interrupt handler. This creates
  race conditions with other operations. It would also make it much more
  difficult to support this feature for devices that require sleeping
  when stopping the DMA engine at the end of a cyclic transfer.

If we have to go forward with this new API, I need a detailed
explanation of how all this should be handled. I still truly believe
this is a case of yak shaving that introduces additional complexity for
absolutely no valid reason, when a solution that is aligned with the
existing API and its concepts exists already. It's your decision as the
subsystem maintainer, but if you want something more complex, please
provide it soon. I don't want to wait another three months to see
progress on this issue.

> >>>>>> And with this I think it would make sense to also add this to
> >>>>>> capabilities :)
> >>>>> 
> >>>>> I'll repeat the comment I made to Peter: you want me to implement a
> >>>>> feature that you think would be useful, but is completely unrelated to
> >>>>> my use case, while there's a more natural way to handle my issue with
> >>>>> the current API, without precluding in any way the addition of your new
> >>>>> feature in the future. Not fair.
> >>>> 
> >>>> So from API design pov, I would like this to support both the features.
> >>>> This helps us to not rework the API again for the immediate abort.
> >>>> 
> >>>> I am not expecting this to be implemented by you if your hw doesn't
> >>>> support it. The core changes are pretty minimal and callback in the
> >>>> driver is the one which does the job and yours wont do this
> >>> 
> >>> Xilinx DMA drivers don't support DMA_RESIDUE_GRANULARITY_BURST so I
> >>> can't test this indeed.
> >> 
> >> Sure I understand that! Am sure folks will respond to CFT and I guess
> >> Peter will also be interested in testing.
> > 
> > s/testing/implementing it/ :-)
> 
> Even better :)

-- 
Regards,

Laurent Pinchart
