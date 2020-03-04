Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C63179509
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2020 17:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbgCDQYd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Mar 2020 11:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729554AbgCDQYc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Mar 2020 11:24:32 -0500
Received: from localhost (unknown [122.181.220.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B691821D56;
        Wed,  4 Mar 2020 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583339071;
        bh=Pg2hDboSI+lYW+TpMY8oQbXikiMpcUYh26TXaA1llLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbB9uRL3sMtULBV0ZyTpMada27H2kzqOhzd/rgJNARez64SUCXBJsZMcL6E5WKFTG
         nu1eRmkEaohxzxh0St51AGJaVL5Ai3vFRf7bPNEuLkU2zQKMO+i8QkJSsevocbwElv
         1UWAej4jy8ieGqazVLIT/i2kIhJ3j6k4N7b/z08w=
Date:   Wed, 4 Mar 2020 21:54:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200304162426.GV4148@vkoul-mobl>
References: <20200219092514.GG2618@vkoul-mobl>
 <20200226163011.GE4770@pendragon.ideasonboard.com>
 <20200302034735.GD4148@vkoul-mobl>
 <20200302073728.GB9177@pendragon.ideasonboard.com>
 <20200303043254.GN4148@vkoul-mobl>
 <20200303192255.GN11333@pendragon.ideasonboard.com>
 <20200304051301.GS4148@vkoul-mobl>
 <20200304080128.GA4712@pendragon.ideasonboard.com>
 <20200304153718.GU4148@vkoul-mobl>
 <20200304160016.GB4712@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304160016.GB4712@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 04-03-20, 18:00, Laurent Pinchart wrote:
> On Wed, Mar 04, 2020 at 09:07:18PM +0530, Vinod Koul wrote:
> > On 04-03-20, 10:01, Laurent Pinchart wrote:
> > > On Wed, Mar 04, 2020 at 10:43:01AM +0530, Vinod Koul wrote:
> > >> On 03-03-20, 21:22, Laurent Pinchart wrote:
> > >>> On Tue, Mar 03, 2020 at 10:02:54AM +0530, Vinod Koul wrote:
> > >>>> On 02-03-20, 09:37, Laurent Pinchart wrote:
> > >>>>>> I would be more comfortable in calling an API to do so :)
> > >>>>>> The flow I am thinking is:
> > >>>>>> 
> > >>>>>> - prep cyclic1 txn
> > >>>>>> - submit cyclic1 txn
> > >>>>>> - call issue_pending() (cyclic one starts)
> > >>>>>> 
> > >>>>>> - prep cyclic2 txn
> > >>>>>> - submit cyclic2 txn
> > >>>>>> - signal_cyclic1_txn aka terminate_cookie()
> > >>>>>> - cyclic1 completes, switch to cyclic2 (dmaengine driver)
> > >>>>>> - get callback for cyclic1 (optional)
> > >>>>>> 
> > >>>>>> To check if hw supports terminate_cookie() or not we can check if the
> > >>>>>> callback support is implemented
> > >>>>> 
> > >>>>> Two questions though:
> > >>>>> 
> > >>>>> - Where is .issue_pending() called for cyclic2 in your above sequence ?
> > >>>>>   Surely it should be called somewhere, as the DMA engine API requires
> > >>>>>   .issue_pending() to be called for a transfer to be executed, otherwise
> > >>>>>   it stays in the submitted but not pending queue.
> > >>>> 
> > >>>> Sorry missed that one, I would do that after submit cyclic2 txn step and
> > >>>> then signal signal_cyclic1_txn termination
> > >>> 
> > >>> OK, that matches my understanding, good :-)
> > >>> 
> > >>>>> - With the introduction of a new .terminate_cookie() operation, we need
> > >>>>>   to specify that operation for all transfer types. What's its
> > >>>> 
> > >>>> Correct
> > >>>> 
> > >>>>>   envisioned semantics for non-cyclic transfers ? And how do DMA engine
> > >>>>>   drivers report that they support .terminate_cookie() for cyclic
> > >>>>>   transfers but not for other transfer types (the counterpart of
> > >>>>>   reporting, in my proposition, that .issue_pending() isn't supported
> > >>>>>   replace the current cyclic transfer) ?
> > >>>> 
> > >>>> Typically for dmaengine controller cyclic is *not* a special mode, only
> > >>>> change is that a list provided to controller is circular.
> > >>> 
> > >>> I don't agree with this. For cyclic transfers to be replaceable in a
> > >>> clean way, the feature must be specifically implemented at the hardware
> > >>> level. A DMA engine that supports chaining transfers with an explicit
> > >>> way to override that chaining, and without the logic to report if the
> > >>> inherent race was lost or not, really can't support this API.
> > >> 
> > >> Well chaining is a typical feature in dmaengine and making last chain
> > >> point to first makes it circular. I have seen couple of engines and this
> > >> was the implementation in the hardware.
> > >> 
> > >> There can exist special hardware for this purposes as well, but the
> > >> point is that the cyclic can be treated as circular list.
> > >> 
> > >>> Furthemore, for non-cyclic transfers, what would .terminate_cookie() do
> > >>> ? I need it to be defined as terminating the current transfer when it
> > >>> ends for the cyclic case, not terminating it immediately. All non-cyclic
> > >>> transfers terminate by themselves when they end, so what would this new
> > >>> operation do ?
> > >> 
> > >> I would use it for two purposes, cancelling txn but at the end of
> > >> current txn. I have couple of usages where this would be helpful.
> > > 
> > > I fail to see how that would help. Non-cyclic transfers always stop at
> > > the end of the transfer. "Cancelling txn but at the end of current txn"
> > > is what DMA engine drivers already do if you call .terminate_cookie() on
> > > the ongoing transfer. It would thus be a no-op.
> > 
> > Well that actually depends on the hardware, some of them support abort
> > so people cancel it (terminate_all approach atm)
> 
> In that case it's not terminating at the end of the current transfer,
> but terminating immediately (a.k.a. aborting), right ? Cancelling at the
> end of the current transfer still seems to be a no-op to me for
> non-cyclic transfers, as that's what they do on their own already.

Correct, it is abort for current txn.

> > >> Second in error handling where some engines do not support
> > >> aborting (unless we reset the whole controller)
> > > 
> > > Could you explain that one ? I'm not sure to understand it.
> > 
> > So I have dma to a slow peripheral and it is stuck for some reason. I
> > want to abort the cookie and let subsequent ones runs (btw this is for
> > non cyclic case), so I would use that here. Today we terminate_all and
> > then resubmit...
> 
> That's also for immediate abort, right ?

Right

> For this to work properly we need very accurate residue reporting, as
> the client will usually need to know exactly what has been transferred.
> The device would need to support DMA_RESIDUE_GRANULARITY_BURST when
> aborting an ongoing transfer. What hardware supports this ?

 git grep DMA_RESIDUE_GRANULARITY_BURST drivers/dma/ |wc -l
27

So it seems many do support the burst reporting.

> > >> But yes the .terminate_cookie() semantics should indicate if the
> > >> termination should be immediate or end of current txn. I see people
> > >> using it for both.
> > > 
> > > Immediate termination is *not* something I'll implement as I have no
> > > good way to test that semantics. I assume you would be fine with leaving
> > > that for later, when someone will need it ?
> > 
> > Sure, if you have hw to support please test. If not, you will not
> > implement that.
> > 
> > The point is that API should support it and people can add support in
> > the controllers and test :)
> 
> I still think this is a different API. We'll have
> 
> 1. Existing .issue_pending(), queueing the next transfer for non-cyclic
>    cases, and being a no-op for cyclic cases.
> 2. New .terminate_cookie(AT_END_OF_TRANSFER), being a no-op for
>    non-cyclic cases, and moving to the next transfer for cyclic cases.
> 3. New .terminate_cookie(ABORT_IMMEDIATELY), applicable to both cyclic
>    and non-cyclic cases.
> 
> 3. is an API I don't need, and can't easily test. I agree that it can
> have use cases (provided the DMA device can abort an ongoing transfer
> *and* still support DMA_RESIDUE_GRANULARITY_BURST in that case).
> 
> I'm troubled by my inability to convince you that 1. and 2. are really
> the same, with 1. addressing the non-cyclic case and 2. addressing the
> cyclic case :-) This is why I think they should both be implemeted using
> .issue_pending() (no other option for 1., that's what it uses today).
> This wouldn't prevent implementing 3. with a new .terminate_cookie()
> operation, that wouldn't need to take a flag as it would always operate
> in ABORT_IMMEDIATELY mode. There would also be no need to report a new
> capability for 3., as the presence of the .terminate_cookie() handler
> would be enough to tell clients that the API is supported. Only a new
> capability for 2. would be needed.

Well I agree 1 & 2 seem similar but I would like to define the behaviour
not dependent on the txn being cyclic or not. That is my concern and
hence the idea that:

1. .issue_pending() will push txn to pending_queue, you may have a case
where that is done only once (due to nature of txn), but no other
implication

2. .terminate_cookie(EOT) will abort the transfer at the end. Maybe not
used for cyclic but irrespective of that, the behaviour would be abort
at end of cyclic

3. .terminate_cookie(IMMEDIATE) will abort immediately. If there is
anything in pending_queue that will get pushed to hardware.

4. Cyclic by nature never completes
   - as a consequence needs to be stopped by terminate_all/terminate_cookie

Does these rules make sense :)

> > >> And with this I think it would make sense to also add this to
> > >> capabilities :)
> > > 
> > > I'll repeat the comment I made to Peter: you want me to implement a
> > > feature that you think would be useful, but is completely unrelated to
> > > my use case, while there's a more natural way to handle my issue with
> > > the current API, without precluding in any way the addition of your new
> > > feature in the future. Not fair.
> > 
> > So from API design pov, I would like this to support both the features.
> > This helps us to not rework the API again for the immediate abort.
> > 
> > I am not expecting this to be implemented by you if your hw doesn't
> > support it. The core changes are pretty minimal and callback in the
> > driver is the one which does the job and yours wont do this
> 
> Xilinx DMA drivers don't support DMA_RESIDUE_GRANULARITY_BURST so I
> can't test this indeed.

Sure I understand that! Am sure folks will respond to CFT and I guess
Peter will also be interested in testing.

> > >>>> So, the .terminate_cookie() should be a feature for all type of txn's.
> > >>>> If for some reason (dont discount what hw designers can do) a controller
> > >>>> supports this for some specific type(s), then they should return
> > >>>> -ENOTSUPP for cookies that do not support and let the caller know.
> > >>> 
> > >>> But then the caller can't know ahead of time, it will only find out when
> > >>> it's too late, and can't decide not to use the DMA engine if it doesn't
> > >>> support the feature. I don't think that's a very good option.
> > >> 
> > >> Agreed so lets go with adding these in caps.
> > > 
> > > So if there's a need for caps anyway, why not a cap that marks
> > > .issue_pending() as moving from the current cyclic transfer to the next
> > > one ? 
> > 
> > Is the overhead really too much on that :) If you like I can send the
> > core patches and you would need to implement the driver side?
> 
> We can try that as a compromise. One of main concerns with developing
> the core patches myself is that the .terminate_cookie() API still seems
> ill-defined to me, so it would be much more efficient if you translate

yeah lets take a stab at defining this and see if we come up with
something meaningful

> the idea you have in your idea into code than trying to communicate it
> to me in all details (one of the grey areas is what should
> .terminate_cookie() do if the cookie passed to the function corresponds
> to an already terminated or, more tricky from a completion callback
> point of view, an issued but not-yet-started transfer, or also a
> submitted but not issued transfer). If you implement the core part, then
> that problem will go away.
> 
> How about the implementation in virt-dma.[ch] by the way ?

It needs to be comprehended and tested as well.. since these are simple
callbacks to driver, we should not need huge changes here (i need to
double check though)

-- 
~Vinod
