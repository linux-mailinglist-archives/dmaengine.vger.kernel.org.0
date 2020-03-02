Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA5175263
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2020 04:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCBDrl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 1 Mar 2020 22:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgCBDrl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 1 Mar 2020 22:47:41 -0500
Received: from localhost (unknown [171.76.77.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A1124695;
        Mon,  2 Mar 2020 03:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583120860;
        bh=4nmax239qb5WGC/6RBH8Ei/2+mWdtxBmEDVTYzOB7WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYHONj8D8J/aoVuY6S65RBnP6HRznGZQw0T/bNbfYNgkwurI4V2xViROkkAQwIQxn
         MEng8y29Vyor5YngMBe/+eKds3xj39Bz0tFobd1jVNcB36O1PyfmrBN14C+axJgTUQ
         GKkGH2rOn3QQBKCPsXnOGIcSLCn26WDfB//Z/GQw=
Date:   Mon, 2 Mar 2020 09:17:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200302034735.GD4148@vkoul-mobl>
References: <20200213132938.GF2618@vkoul-mobl>
 <20200213134843.GG4833@pendragon.ideasonboard.com>
 <20200213140709.GH2618@vkoul-mobl>
 <736038ef-e8b2-5542-5cda-d8923e3a4826@ti.com>
 <20200213165249.GH29760@pendragon.ideasonboard.com>
 <20200214042349.GS2618@vkoul-mobl>
 <20200214162236.GK4831@pendragon.ideasonboard.com>
 <becf8212-7fe6-9fb6-eb2c-7a03a9b286b1@ti.com>
 <20200219092514.GG2618@vkoul-mobl>
 <20200226163011.GE4770@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226163011.GE4770@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 26-02-20, 18:30, Laurent Pinchart wrote:
> On Wed, Feb 19, 2020 at 02:55:14PM +0530, Vinod Koul wrote:
> > On 17-02-20, 12:00, Peter Ujfalusi wrote:
> > > On 14/02/2020 18.22, Laurent Pinchart wrote:
> > >>>> It does, but I really wonder why we need a new terminate operation that
> > >>>> would terminate a single transfer. If we call issue_pending at step B.3,
> > >>>> when the new txn submitted, we can terminate the current transfer at the
> > >>>> point. It changes the semantics of issue_pending, but only for cyclic
> > >>>> transfers (this whole discussions it only about cyclic transfers). As a
> > >>>> cyclic transfer will be repeated forever until terminated, there's no
> > >>>> use case for issuing a new transfer without terminating the one in
> > >>>> progress. I thus don't think we need a new terminate operation: the only
> > >>>> thing that makes sense to do when submitting a new cyclic transfer is to
> > >>>> terminate the current one and switch to the new one, and we already have
> > >>>> all the APIs we need to enable this behaviour.
> > >>>
> > >>> The issue_pending() is a NOP when engine is already running.
> > >> 
> > >> That's not totally right. issue_pending() still moves submitted but not
> > >> issued transactions from the submitted queue to the issued queue. The
> > >> DMA engine only considers the issued queue, so issue_pending()
> > >> essentially tells the DMA engine to consider the submitted transaction
> > >> for processing after the already issued transactions complete (in the
> > >> non-cyclic case).
> > > 
> > > Vinod's point is for the cyclic case at the current state. It is NOP
> > > essentially as we don't have way to not kill the whole channel.
> > 
> > Or IOW there is no descriptor movement to hardware..
> > 
> > > Just a sidenote: it is not even that clean cut for slave transfers
> > > either as the slave_config must _not_ change between the issued
> > > transfers. Iow, you can not switch between 16bit and 32bit word lengths
> > > with some DMA. EDMA, sDMA can do that, but UDMA can not for example...
> > > 
> > >>> The design of APIs is that we submit a txn to pending_list and then the
> > >>> pending_list is started when issue_pending() is called.
> > >>> Or if the engine is already running, it will take next txn from
> > >>> pending_list() when current txn completes.
> > >>>
> > >>> The only consideration here in this case is that the cyclic txn never
> > >>> completes. Do we really treat a new txn submission as an 'indication' of
> > >>> completeness? That is indeed a point to ponder upon.
> > >> 
> > >> The reason why I think we should is two-fold:
> > >> 
> > >> 1. I believe it's semantically aligned with the existing behaviour of
> > >> issue_pending(). As explained above, the operation tells the DMA engine
> > >> to consider submitted transactions for processing when the current (and
> > >> other issued) transactions complete. If we extend the definition of
> > >> complete to cover cyclic transactions, I think it's a good match.
> > > 
> > > We will end up with different behavior between cyclic and non cyclic
> > > transfers and the new behavior should be somehow supported by existing
> > > drivers.
> > > Yes, issue_pending is moving the submitted tx to the issued queue to be
> > > executed on HW when the current transfer finished.
> > > We only needed this for non cyclic uses so far. Some DMA hw can replace
> > > the current transfer with a new one (re-trigger to fetch the new
> > > configuration, like your's), but some can not (none of the system DMAs
> > > on TI platforms can).
> > > If we say that this is the behavior the DMA drivers must follow then we
> > > will have non compliant DMA drivers. You can not move simply to other
> > > DMA or can not create generic DMA code shared by drivers.
> > 
> > That is very important point for API. We want no implicit behaviour, so
> > if we want an behaviour let us do that explicitly.
> 
> As I've just explained in my reply to Peter, there's nothing implicit in
> my proposal :-) It's however missing a flag to report if the DMA engine
> driver supports this feature, put apart from that, it makes the API
> *more* consistent by making issue_pending() cover *all* transfer types
> with the *same* semantics.

I would be more comfortable in calling an API to do so :)
The flow I am thinking is:

- prep cyclic1 txn
- submit cyclic1 txn
- call issue_pending() (cyclic one starts)

- prep cyclic2 txn
- submit cyclic2 txn
- signal_cyclic1_txn aka terminate_cookie()
- cyclic1 completes, switch to cyclic2 (dmaengine driver)
- get callback for cyclic1 (optional)

To check if hw supports terminate_cookie() or not we can check if the
callback support is implemented

> 
> > >> 2. There's really nothing else we could do with cyclic transactions.
> > >> They never complete today and have to be terminated manually with
> > >> terminate_all(). Using issue_pending() to move to a next cyclic
> > >> transaction doesn't change the existing behaviour by replacing a useful
> > >> (and used) feature, as issue_pending() is currently a no-op for cyclic
> > >> transactions. The newly issued transaction is never considered, and
> > >> calling terminate_all() will cancel the issued transactions. By
> > >> extending the behaviour of issue_pending(), we're making a new use case
> > >> possible, without restricting any other feature, and without "stealing"
> > >> issue_pending() and preventing it from implementing another useful
> > >> behaviour.
> > > 
> > > But at the same time we make existing drivers non compliant...
> > > 
> > > Imo a new callback to 'kill' / 'terminate' / 'replace' / 'abort' an
> > > issued cookie would be cleaner.
> > > 
> > > cookie1 = dmaengine_issue_pending();
> > > // will start the transfer
> > > cookie2 = dmaengine_issue_pending();
> > > // cookie1 still runs, cookie2 is waiting to be executed
> > > dmaengine_abort_tx(chan);
> > > // will kill cookie1 and executes cookie2
> > 
> > Right and we need a kill mode which kills the cookie1 at the end of
> > transfer (conditional to hw supporting that)
> > 
> > I think it should be generic API and usable in both the cyclic and
> > non-cyclic case
> 
> I have no issue with an API that can abort ongoing transfers without
> killing the whole queue of pending transfers, but that's not what I'm
> after, it's not my use case. Again, as explained in my reply to Peter,
> I'm not looking for a way to abort a transfer immediately, but to move
> to the next transfer at the end of the current one. It's very different,
> and the DMA engine API already supports this for all transfers but
> cyclic transfers. I'd go as far as saying that my proposal is fixing a
> bug in the current implementation :-)
> 
> > > dmaengine_abort_tx() could take a cookie as parameter if we wish, so you
> > > can say selectively which issued tx you want to remove, if it is the
> > > running one, then stop it and move to the next one.
> > > In place of the cookie parameter a 0 could imply that I don't know the
> > > cookie, but kill the running one.
> > > 
> > > We would preserve what issue_pending does atm and would give us a
> > > generic flow of how other drivers should handle such cases.
> > > 
> > > Note that this is not only useful for cyclic cases. Any driver which
> > > currently uses brute-force termination can be upgraded.
> > > Prime example is UART RX. We issue an RX buffer to receive data, but it
> > > is not guarantied that the remote will send data which would fill the
> > > buffer and we hit a timeout waiting. We could issue the next buffer and
> > > kill the stale transfer to reclaim the received data.
> > > 
> > > I think this can be even implemented for DMAs which can not do the same
> > > thing as your DMA can.
> > > 
> > >> In a nutshell, an important reason why I like using issue_pending() for
> > >> this purpose is because it makes cyclic and non-cyclic transactions
> > >> behave more similarly, which I think is good from an API consistency
> > >> point of view.
> > >> 
> > >>> Also, we need to keep in mind that the dmaengine wont stop a cyclic
> > >>> txn. It would be running and start next transfer (in this case do
> > >>> from start) while it also gives you an interrupt. Here we would be
> > >>> required to stop it and then start a new one...
> > >> 
> > >> We wouldn't be required to stop it in the middle, the expected behaviour
> > >> is for the DMA engine to complete the cyclic transaction until the end
> > >> of the cycle and then replace it by the new one. That's exactly what
> > >> happens for non-cyclic transactions when you call issue_pending(), which
> > >> makes me like this solution.
> > > 
> > > Right, so we have two different use cases. Replace the current transfers
> > > with the next issued one and abort the current transfer now and arm the
> > > next issued one.
> > > dmaengine_abort_tx(chan, cookie, forced) ?
> > > forced == false: replace it at cyclic boundary
> > > forced == true: right away (as HW allows), do not wait for cyclic round
> > > 
> > >>> Or perhaps remove the cyclic setting from the txn when a new one
> > >>> arrives and that behaviour IMO is controller dependent, not sure if
> > >>> all controllers support it..
> > >> 
> > >> At the very least I would assume controllers to be able to stop a cyclic
> > >> transaction forcefully, otherwise terminate_all() could never be
> > >> implemented. This may not lead to a gracefully switch from one cyclic
> > >> transaction to another one if the hardware doesn't allow doing so. In
> > >> that case I think tx_submit() could return an error, or we could turn
> > >> issue_pending() into an int operation to signal the error. Note that
> > >> there's no need to mass-patch drivers here, if a DMA engine client
> > >> issues a second cyclic transaction while one is in progress, the second
> > >> transaction won't be considered today. Signalling an error is in my
> > >> opinion a useful feature, but not doing so in DMA engine drivers can't
> > >> be a regression. We could also add a flag to tell whether this mode of
> > >> operation is supported.
> > > 
> > > My problems is that it is changing the behavior of issue_pending() for
> > > cyclic. If we document this than all existing DMA drivers are broken
> > > (not complaint with the API documentation) as they don't do this.
> > > 
> > > 
> > >>>>> That would be a clean way to handle it. We were missing this API for a
> > >>>>> long time to be able to cancel the ongoing transfer (whether it is
> > >>>>> cyclic or slave_sg, or memcpy) and move to the next one if there is one
> > >>>>> pending.
> > >>>>
> > >>>> Note that this new terminate API wouldn't terminate the ongoing transfer
> > >>>> immediately, it would complete first, until the end of the cycle for
> > >>>> cyclic transfers, and until the end of the whole transfer otherwise.
> > >>>> This new operation would thus essentially be a no-op for non-cyclic
> > >>>> transfers. I don't see how it would help :-) Do you have any particular
> > >>>> use case in mind ?
> > >>>
> > >>> Yeah that is something more to think about. Do we really abort here or
> > >>> wait for the txn to complete. I think Peter needs the former and your
> > >>> falls in the latter category
> > >> 
> > >> I definitely need the latter, otherwise the display will flicker (or
> > >> completely misoperate) every time a new frame is displayed, which isn't
> > >> a good idea :-)
> > > 
> > > Sure, and it is a great feature.
> > > 
> > >> I'm not sure about Peter's use cases, but it seems to me
> > >> that aborting a transaction immediately is racy in most cases, unless
> > >> the DMA engine supports byte-level residue reporting.
> > > 
> > > Sort of yes. With EDMA, sDMA I can just kill the channel and set up a
> > > new one right away.
> > > UDMA on the other hand is not that forgiving... I would need to kill the
> > > channel, wait for the termination to complete, reconfigure the channel
> > > and execute the new transfer.
> > > 
> > > But with a separate callback API at least there will be an entry point
> > > when this can be initiated and handled.
> > > Fwiw, I think it should be simple to add this functionality to them, the
> > > code is kind of handling it in other parts, but implementing it in the
> > > issue_pending() is not really a clean solution.
> > > 
> > > In a channel you can run slave_sg transfers followed by cyclic if you
> > > wish. A slave channel is what it is, slave channel which can be capable
> > > to execute slave_sg and/or cyclic (and/or interleaved).
> > > If issue_pending() is to take care then we need to check if the current
> > > transfer is cyclic or not and decide based on that.
> > > 
> > > With a separate callback we in the DMA driver just need to do what the
> > > client is asking for and no need to think.
> > > 
> > >> One non-intrusive
> > >> option would be to add a flag to signal that a newly issued transaction
> > >> should interrupt the current transaction immediately.
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
~Vinod
