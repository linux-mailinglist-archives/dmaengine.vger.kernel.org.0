Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51BCF1789E1
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2020 06:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgCDFNH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Mar 2020 00:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgCDFNH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Mar 2020 00:13:07 -0500
Received: from localhost (unknown [122.181.220.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 327CD2146E;
        Wed,  4 Mar 2020 05:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583298787;
        bh=mzU4L/XMjGaJAPbq1tZpVtldMsMyR7PfRrzM/0eFIBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9xU5cXzyeMCdypU9hHcQ5y+99ny9n09Hyk+7oqUj57yZ4WqQi+YDU3u5zaDNzClc
         d6Nnz8unt9lrgLMxmySceLHwgAnYw0wc2nk98cRBkm4Sud31CihWo/4M0CwSuzYDye
         Ozj65JKeKTPkobp/XG3MFMSCaYibL1oQ5mdL+/TU=
Date:   Wed, 4 Mar 2020 10:43:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200304051301.GS4148@vkoul-mobl>
References: <20200213165249.GH29760@pendragon.ideasonboard.com>
 <20200214042349.GS2618@vkoul-mobl>
 <20200214162236.GK4831@pendragon.ideasonboard.com>
 <becf8212-7fe6-9fb6-eb2c-7a03a9b286b1@ti.com>
 <20200219092514.GG2618@vkoul-mobl>
 <20200226163011.GE4770@pendragon.ideasonboard.com>
 <20200302034735.GD4148@vkoul-mobl>
 <20200302073728.GB9177@pendragon.ideasonboard.com>
 <20200303043254.GN4148@vkoul-mobl>
 <20200303192255.GN11333@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303192255.GN11333@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-03-20, 21:22, Laurent Pinchart wrote:
> Hi Vinod,
> 
> On Tue, Mar 03, 2020 at 10:02:54AM +0530, Vinod Koul wrote:
> > On 02-03-20, 09:37, Laurent Pinchart wrote:
> > 
> > > > I would be more comfortable in calling an API to do so :)
> > > > The flow I am thinking is:
> > > > 
> > > > - prep cyclic1 txn
> > > > - submit cyclic1 txn
> > > > - call issue_pending() (cyclic one starts)
> > > > 
> > > > - prep cyclic2 txn
> > > > - submit cyclic2 txn
> > > > - signal_cyclic1_txn aka terminate_cookie()
> > > > - cyclic1 completes, switch to cyclic2 (dmaengine driver)
> > > > - get callback for cyclic1 (optional)
> > > > 
> > > > To check if hw supports terminate_cookie() or not we can check if the
> > > > callback support is implemented
> > > 
> > > Two questions though:
> > > 
> > > - Where is .issue_pending() called for cyclic2 in your above sequence ?
> > >   Surely it should be called somewhere, as the DMA engine API requires
> > >   .issue_pending() to be called for a transfer to be executed, otherwise
> > >   it stays in the submitted but not pending queue.
> > 
> > Sorry missed that one, I would do that after submit cyclic2 txn step and
> > then signal signal_cyclic1_txn termination
> 
> OK, that matches my understanding, good :-)
> 
> > > - With the introduction of a new .terminate_cookie() operation, we need
> > >   to specify that operation for all transfer types. What's its
> > 
> > Correct
> > 
> > >   envisioned semantics for non-cyclic transfers ? And how do DMA engine
> > >   drivers report that they support .terminate_cookie() for cyclic
> > >   transfers but not for other transfer types (the counterpart of
> > >   reporting, in my proposition, that .issue_pending() isn't supported
> > >   replace the current cyclic transfer) ?
> > 
> > Typically for dmaengine controller cyclic is *not* a special mode, only
> > change is that a list provided to controller is circular.
> 
> I don't agree with this. For cyclic transfers to be replaceable in a
> clean way, the feature must be specifically implemented at the hardware
> level. A DMA engine that supports chaining transfers with an explicit
> way to override that chaining, and without the logic to report if the
> inherent race was lost or not, really can't support this API.

Well chaining is a typical feature in dmaengine and making last chain
point to first makes it circular. I have seen couple of engines and this
was the implementation in the hardware.

There can exist special hardware for this purposes as well, but the
point is that the cyclic can be treated as circular list.

> Furthemore, for non-cyclic transfers, what would .terminate_cookie() do
> ? I need it to be defined as terminating the current transfer when it
> ends for the cyclic case, not terminating it immediately. All non-cyclic
> transfers terminate by themselves when they end, so what would this new
> operation do ?

I would use it for two purposes, cancelling txn but at the end of
current txn. I have couple of usages where this would
be helpful. Second in error handling where some engines do not support
aborting (unless we reset the whole controller)

But yes the .terminate_cookie() semantics should indicate if the
termination should be immediate or end of current txn. I see people
using it for both.

And with this I think it would make sense to also add this to
capabilities :)

> > So, the .terminate_cookie() should be a feature for all type of txn's.
> > If for some reason (dont discount what hw designers can do) a controller
> > supports this for some specific type(s), then they should return
> > -ENOTSUPP for cookies that do not support and let the caller know.
> 
> But then the caller can't know ahead of time, it will only find out when
> it's too late, and can't decide not to use the DMA engine if it doesn't
> support the feature. I don't think that's a very good option.

Agreed so lets go with adding these in caps.

-- 
~Vinod
