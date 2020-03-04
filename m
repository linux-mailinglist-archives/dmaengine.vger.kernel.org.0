Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BAE178C14
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2020 09:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725271AbgCDIBc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Mar 2020 03:01:32 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44846 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgCDIBc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Mar 2020 03:01:32 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AFBEC33E;
        Wed,  4 Mar 2020 09:01:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1583308889;
        bh=7/+ODIhyFRTCkveQIvsMuBPakeM/g2Rsb0Qr569VlSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuzrRl5txBed05xOizIw7ytLZ41xEfGb5ik/IoaJfKTXWj+rUdGg3UU0vxTeAa4CY
         GatuAye0SJIVH8B6A+y7YVd9cJ9Mdj8+9a0NTwBEDto+r2T4sTxws+jdSUECmxbNTY
         9GBv8Ltjk8ZnTJPVNf7CMqpP9HFBfWAkk1n2MX7I=
Date:   Wed, 4 Mar 2020 10:01:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200304080128.GA4712@pendragon.ideasonboard.com>
References: <20200214042349.GS2618@vkoul-mobl>
 <20200214162236.GK4831@pendragon.ideasonboard.com>
 <becf8212-7fe6-9fb6-eb2c-7a03a9b286b1@ti.com>
 <20200219092514.GG2618@vkoul-mobl>
 <20200226163011.GE4770@pendragon.ideasonboard.com>
 <20200302034735.GD4148@vkoul-mobl>
 <20200302073728.GB9177@pendragon.ideasonboard.com>
 <20200303043254.GN4148@vkoul-mobl>
 <20200303192255.GN11333@pendragon.ideasonboard.com>
 <20200304051301.GS4148@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304051301.GS4148@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Wed, Mar 04, 2020 at 10:43:01AM +0530, Vinod Koul wrote:
> On 03-03-20, 21:22, Laurent Pinchart wrote:
> > On Tue, Mar 03, 2020 at 10:02:54AM +0530, Vinod Koul wrote:
> > > On 02-03-20, 09:37, Laurent Pinchart wrote:
> > > > > I would be more comfortable in calling an API to do so :)
> > > > > The flow I am thinking is:
> > > > > 
> > > > > - prep cyclic1 txn
> > > > > - submit cyclic1 txn
> > > > > - call issue_pending() (cyclic one starts)
> > > > > 
> > > > > - prep cyclic2 txn
> > > > > - submit cyclic2 txn
> > > > > - signal_cyclic1_txn aka terminate_cookie()
> > > > > - cyclic1 completes, switch to cyclic2 (dmaengine driver)
> > > > > - get callback for cyclic1 (optional)
> > > > > 
> > > > > To check if hw supports terminate_cookie() or not we can check if the
> > > > > callback support is implemented
> > > > 
> > > > Two questions though:
> > > > 
> > > > - Where is .issue_pending() called for cyclic2 in your above sequence ?
> > > >   Surely it should be called somewhere, as the DMA engine API requires
> > > >   .issue_pending() to be called for a transfer to be executed, otherwise
> > > >   it stays in the submitted but not pending queue.
> > > 
> > > Sorry missed that one, I would do that after submit cyclic2 txn step and
> > > then signal signal_cyclic1_txn termination
> > 
> > OK, that matches my understanding, good :-)
> > 
> > > > - With the introduction of a new .terminate_cookie() operation, we need
> > > >   to specify that operation for all transfer types. What's its
> > > 
> > > Correct
> > > 
> > > >   envisioned semantics for non-cyclic transfers ? And how do DMA engine
> > > >   drivers report that they support .terminate_cookie() for cyclic
> > > >   transfers but not for other transfer types (the counterpart of
> > > >   reporting, in my proposition, that .issue_pending() isn't supported
> > > >   replace the current cyclic transfer) ?
> > > 
> > > Typically for dmaengine controller cyclic is *not* a special mode, only
> > > change is that a list provided to controller is circular.
> > 
> > I don't agree with this. For cyclic transfers to be replaceable in a
> > clean way, the feature must be specifically implemented at the hardware
> > level. A DMA engine that supports chaining transfers with an explicit
> > way to override that chaining, and without the logic to report if the
> > inherent race was lost or not, really can't support this API.
> 
> Well chaining is a typical feature in dmaengine and making last chain
> point to first makes it circular. I have seen couple of engines and this
> was the implementation in the hardware.
> 
> There can exist special hardware for this purposes as well, but the
> point is that the cyclic can be treated as circular list.
> 
> > Furthemore, for non-cyclic transfers, what would .terminate_cookie() do
> > ? I need it to be defined as terminating the current transfer when it
> > ends for the cyclic case, not terminating it immediately. All non-cyclic
> > transfers terminate by themselves when they end, so what would this new
> > operation do ?
> 
> I would use it for two purposes, cancelling txn but at the end of
> current txn. I have couple of usages where this would be helpful.

I fail to see how that would help. Non-cyclic transfers always stop at
the end of the transfer. "Cancelling txn but at the end of current txn"
is what DMA engine drivers already do if you call .terminate_cookie() on
the ongoing transfer. It would thus be a no-op.

> Second in error handling where some engines do not support
> aborting (unless we reset the whole controller)

Could you explain that one ? I'm not sure to understand it.

> But yes the .terminate_cookie() semantics should indicate if the
> termination should be immediate or end of current txn. I see people
> using it for both.

Immediate termination is *not* something I'll implement as I have no
good way to test that semantics. I assume you would be fine with leaving
that for later, when someone will need it ?

> And with this I think it would make sense to also add this to
> capabilities :)

I'll repeat the comment I made to Peter: you want me to implement a
feature that you think would be useful, but is completely unrelated to
my use case, while there's a more natural way to handle my issue with
the current API, without precluding in any way the addition of your new
feature in the future. Not fair.

> > > So, the .terminate_cookie() should be a feature for all type of txn's.
> > > If for some reason (dont discount what hw designers can do) a controller
> > > supports this for some specific type(s), then they should return
> > > -ENOTSUPP for cookies that do not support and let the caller know.
> > 
> > But then the caller can't know ahead of time, it will only find out when
> > it's too late, and can't decide not to use the DMA engine if it doesn't
> > support the feature. I don't think that's a very good option.
> 
> Agreed so lets go with adding these in caps.

So if there's a need for caps anyway, why not a cap that marks
.issue_pending() as moving from the current cyclic transfer to the next
one ? 

-- 
Regards,

Laurent Pinchart
