Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0463615E52E
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2020 17:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393281AbgBNQW4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 14 Feb 2020 11:22:56 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:40992 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393271AbgBNQWz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 14 Feb 2020 11:22:55 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 40CC0504;
        Fri, 14 Feb 2020 17:22:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1581697373;
        bh=gYWx588wpOM3nv6X+YSdlRtsf2wJCnbRu+ZGbpwvKrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXAUF552BCkxzMvQUl8tHPxP7r6Ksa8nvYAGfqG7l3MHDzLakRSgkVPTMgYDoEUhK
         7bkMtWou2VmRO76FB9U4zMCsgsqGOlwbtqMa5P63196xH54IhFEn6abbs6j98657HU
         pa1Uf9erjzg0ivSP1igWUXcnMxfvrkIfFJdYw4qE=
Date:   Fri, 14 Feb 2020 18:22:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200214162236.GK4831@pendragon.ideasonboard.com>
References: <20200123122304.GB13922@pendragon.ideasonboard.com>
 <20200124061047.GE2841@vkoul-mobl>
 <20200124085051.GA4842@pendragon.ideasonboard.com>
 <20200210140618.GA4727@pendragon.ideasonboard.com>
 <20200213132938.GF2618@vkoul-mobl>
 <20200213134843.GG4833@pendragon.ideasonboard.com>
 <20200213140709.GH2618@vkoul-mobl>
 <736038ef-e8b2-5542-5cda-d8923e3a4826@ti.com>
 <20200213165249.GH29760@pendragon.ideasonboard.com>
 <20200214042349.GS2618@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214042349.GS2618@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Fri, Feb 14, 2020 at 09:53:49AM +0530, Vinod Koul wrote:
> On 13-02-20, 18:52, Laurent Pinchart wrote:
> > On Thu, Feb 13, 2020 at 04:15:38PM +0200, Peter Ujfalusi wrote:
> > > On 13/02/2020 16.07, Vinod Koul wrote:
> > > > On 13-02-20, 15:48, Laurent Pinchart wrote:
> > > >> On Thu, Feb 13, 2020 at 06:59:38PM +0530, Vinod Koul wrote:
> > > >>> On 10-02-20, 16:06, Laurent Pinchart wrote:
> > > >>>
> > > >>>>>>> The use case here is not to switch to a new configuration, but to switch
> > > >>>>>>> to a new buffer. If the transfer had to be terminated manually first,
> > > >>>>>>> the DMA engine would potentially miss a frame, which is not acceptable.
> > > >>>>>>> We need an atomic way to switch to the next transfer.
> > > >>>>>>
> > > >>>>>> So in this case you have, let's say a cyclic descriptor with N buffers
> > > >>>>>> and they are cyclically capturing data and providing to client/user..
> > > >>>>>
> > > >>>>> For the display case it's cyclic over a single buffer that is repeatedly
> > > >>>>> displayed over and over again until a new one replaces it, when
> > > >>>>> userspace wants to change the content on the screen. Userspace only has
> > > >>>>> to provide a new buffer when content changes, otherwise the display has
> > > >>>>> to keep displaying the same one.
> > > >>>>
> > > >>>> Is the use case clear enough, or do you need more information ? Are you
> > > >>>> fine with the API for this kind of use case ?
> > > >>>
> > > >>> So we *know* when a new buffer is being used?
> > > >>
> > > >> The user of the DMA engine (the DRM DPSUB driver in this case) knows
> > > >> when a new buffer needs to be used, as it receives it from userspace. In
> > > >> response, it prepares a new interleaved cyclic transaction and queues
> > > >> it. At the next IRQ, the DMA engine driver switches to the new
> > > >> transaction (the implementation is slightly more complex to handle race
> > > >> conditions, but that's the idea).
> > > >>
> > > >>> IOW would it be possible for display (rather a dmaengine facing
> > > >>> display wrapper) to detect that we are reusing an old buffer and keep
> > > >>> the cyclic and once detected prepare a new descriptor, submit a new
> > > >>> one and then terminate old one which should trigger next transaction
> > > >>> to be submitted
> > > >>
> > > >> I'm not sure to follow you. Do you mean that the display driver should
> > > >> submit a non-cyclic transaction for every frame, reusing the same buffer
> > > >> for every transaction, until a new buffer is available ? The issue with
> > > >> this is that if the CPU load gets high, we may miss a frame, and the
> > > >> display will break. The DPDMA hardware implements cyclic support for
> > > >> this reason, and we want to use that feature to comply with the real
> > > >> time requirements.
> > > > 
> > > > Sorry to cause confusion :) I mean cyclic
> > > > 
> > > > So, DRM DPSUB get first buffer
> > > > A.1 Prepare cyclic interleave txn
> > > > A.2 Submit the txn (it doesn't start here)
> > > > A.3 Invoke issue_pending (that starts the txn)
> > 
> > I assume that, at this point, the transfer is started, and repeated
> > forever until step B below, right ?
> 
> Right, since the transaction is cyclic in nature, the transaction will continue
> until stopped or switched :)
> 
> > > > DRM DPSUB gets next buffer:
> > > > B.1 Prepare cyclic interleave txn
> > > > B.2 Submit the txn
> > > > B.3 Call terminate for current cyclic txn (we need an updated terminate
> > > > which terminates the current txn, right now we have terminate_all which
> > > > is a sledge hammer approach)
> > > > B.4 Next txn would start once current one is started
> > 
> > Do you mean "once current one is completed" ?
> 
> Yup, sorry for the typo!

No worries, I just wanted to make sure it wasn't a misunderstanding on
my side.

> > > > Does this help and make sense in your case
> > 
> > It does, but I really wonder why we need a new terminate operation that
> > would terminate a single transfer. If we call issue_pending at step B.3,
> > when the new txn submitted, we can terminate the current transfer at the
> > point. It changes the semantics of issue_pending, but only for cyclic
> > transfers (this whole discussions it only about cyclic transfers). As a
> > cyclic transfer will be repeated forever until terminated, there's no
> > use case for issuing a new transfer without terminating the one in
> > progress. I thus don't think we need a new terminate operation: the only
> > thing that makes sense to do when submitting a new cyclic transfer is to
> > terminate the current one and switch to the new one, and we already have
> > all the APIs we need to enable this behaviour.
> 
> The issue_pending() is a NOP when engine is already running.

That's not totally right. issue_pending() still moves submitted but not
issued transactions from the submitted queue to the issued queue. The
DMA engine only considers the issued queue, so issue_pending()
essentially tells the DMA engine to consider the submitted transaction
for processing after the already issued transactions complete (in the
non-cyclic case).

> The design of APIs is that we submit a txn to pending_list and then the
> pending_list is started when issue_pending() is called.
> Or if the engine is already running, it will take next txn from
> pending_list() when current txn completes.
> 
> The only consideration here in this case is that the cyclic txn never
> completes. Do we really treat a new txn submission as an 'indication' of
> completeness? That is indeed a point to ponder upon.

The reason why I think we should is two-fold:

1. I believe it's semantically aligned with the existing behaviour of
issue_pending(). As explained above, the operation tells the DMA engine
to consider submitted transactions for processing when the current (and
other issued) transactions complete. If we extend the definition of
complete to cover cyclic transactions, I think it's a good match.

2. There's really nothing else we could do with cyclic transactions.
They never complete today and have to be terminated manually with
terminate_all(). Using issue_pending() to move to a next cyclic
transaction doesn't change the existing behaviour by replacing a useful
(and used) feature, as issue_pending() is currently a no-op for cyclic
transactions. The newly issued transaction is never considered, and
calling terminate_all() will cancel the issued transactions. By
extending the behaviour of issue_pending(), we're making a new use case
possible, without restricting any other feature, and without "stealing"
issue_pending() and preventing it from implementing another useful
behaviour.

In a nutshell, an important reason why I like using issue_pending() for
this purpose is because it makes cyclic and non-cyclic transactions
behave more similarly, which I think is good from an API consistency
point of view.

> Also, we need to keep in mind that the dmaengine wont stop a cyclic
> txn. It would be running and start next transfer (in this case do
> from start) while it also gives you an interrupt. Here we would be
> required to stop it and then start a new one...

We wouldn't be required to stop it in the middle, the expected behaviour
is for the DMA engine to complete the cyclic transaction until the end
of the cycle and then replace it by the new one. That's exactly what
happens for non-cyclic transactions when you call issue_pending(), which
makes me like this solution.

> Or perhaps remove the cyclic setting from the txn when a new one
> arrives and that behaviour IMO is controller dependent, not sure if
> all controllers support it..

At the very least I would assume controllers to be able to stop a cyclic
transaction forcefully, otherwise terminate_all() could never be
implemented. This may not lead to a gracefully switch from one cyclic
transaction to another one if the hardware doesn't allow doing so. In
that case I think tx_submit() could return an error, or we could turn
issue_pending() into an int operation to signal the error. Note that
there's no need to mass-patch drivers here, if a DMA engine client
issues a second cyclic transaction while one is in progress, the second
transaction won't be considered today. Signalling an error is in my
opinion a useful feature, but not doing so in DMA engine drivers can't
be a regression. We could also add a flag to tell whether this mode of
operation is supported.

> > > That would be a clean way to handle it. We were missing this API for a
> > > long time to be able to cancel the ongoing transfer (whether it is
> > > cyclic or slave_sg, or memcpy) and move to the next one if there is one
> > > pending.
> > 
> > Note that this new terminate API wouldn't terminate the ongoing transfer
> > immediately, it would complete first, until the end of the cycle for
> > cyclic transfers, and until the end of the whole transfer otherwise.
> > This new operation would thus essentially be a no-op for non-cyclic
> > transfers. I don't see how it would help :-) Do you have any particular
> > use case in mind ?
> 
> Yeah that is something more to think about. Do we really abort here or
> wait for the txn to complete. I think Peter needs the former and your
> falls in the latter category

I definitely need the latter, otherwise the display will flicker (or
completely misoperate) every time a new frame is displayed, which isn't
a good idea :-) I'm not sure about Peter's use cases, but it seems to me
that aborting a transaction immediately is racy in most cases, unless
the DMA engine supports byte-level residue reporting. One non-intrusive
option would be to add a flag to signal that a newly issued transaction
should interrupt the current transaction immediately.

-- 
Regards,

Laurent Pinchart
