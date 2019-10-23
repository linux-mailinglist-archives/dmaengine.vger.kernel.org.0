Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EB6E2339
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 21:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390153AbfJWTTG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 15:19:06 -0400
Received: from muru.com ([72.249.23.125]:39548 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732232AbfJWTTF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Oct 2019 15:19:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7F9BE80CF;
        Wed, 23 Oct 2019 19:19:37 +0000 (UTC)
Date:   Wed, 23 Oct 2019 12:18:59 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, giulio.benetti@benettiengineering.com,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when
 idle
Message-ID: <20191023191859.GQ5610@atomide.com>
References: <20191023153138.23442-1-tony@atomide.com>
 <245e1e8f-7933-bae1-b779-239f33d4d449@ti.com>
 <20191023171628.GO5610@atomide.com>
 <5deab8a9-5796-5367-213e-90c5961b8498@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5deab8a9-5796-5367-213e-90c5961b8498@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [191023 19:02]:
> On 10/23/19 8:16 PM, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [191023 17:04]:
> >> On 10/23/19 6:31 PM, Tony Lindgren wrote:
> >>> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
> >>> --- a/drivers/dma/ti/cppi41.c
> >>> +++ b/drivers/dma/ti/cppi41.c
> >>> @@ -586,9 +586,22 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
> >>>  	enum dma_transfer_direction dir, unsigned long tx_flags, void *context)
> >>>  {
> >>>  	struct cppi41_channel *c = to_cpp41_chan(chan);
> >>> +	struct dma_async_tx_descriptor *txd = NULL;
> >>> +	struct cppi41_dd *cdd = c->cdd;
> >>>  	struct cppi41_desc *d;
> >>>  	struct scatterlist *sg;
> >>>  	unsigned int i;
> >>> +	int error;
> >>> +
> >>> +	error = pm_runtime_get(cdd->ddev.dev);
> >>
> >> If pm_runtime_get()
> >> pm_runtime_mark_last_busy()+pm_runtime_put_autosuspend() around a code
> >> which updates a descriptor in _memory_ helps then this best described as
> >> works by luck ;)
> > 
> > It also checks the cpp41 state for cdd->is_suspended
> > though.
> 
> Which is cleared/set in the suspend/resume callbacks and they are called
> from a work (the driver uses async runtime_get).

Right, only the cppi41 driver itself knows when it's idled
or not, we cannot rely on pm_runtime functions for that.

> >> I have a feeling that if you put enough delay between prepare_sg and
> >> issue_pending in the usb driver then it will keep failing, no?
> > 
> > Nope, it will just queue it and run the queue when awake.
> 
> the autosuspend_delay is set 100 ms, so if you put a udelay(101) between
> prep_sg and issue_pending in the usb driver this trickery will be for
> nothing, right?
> If the usb driver is preempted for longer than 100ms between the two
> calls, same issue.
> Not sure, but if for some reason the transfer would take longer than
> 100ms than pm_runtime will bring down the dma, no?

No, the dma will happen just fine no matter what the delay is.

Part of the problem here is the musb driver. It friggin
continues before checking the completion of a dma transfer!
Fixing that currently is not trivial.

> > But yeah, some dmaengine API that can sleep to tell
> > a request is about to come would simplify things.
> 
> any of the prep callbacks kind of indicates that a client is preparing a
> transfer so in a perfect world it is going to want to execute it..
> 
> > I don't think we have anything like that available
> > right now?
> 
> Well, it would have the same issues. If the time between
> dmaengine_be_warned_i_m_going_to_call_issue_pending_soon and
> issue_pending is more than the autosuspend_delay then it is not going to
> help.

We'd have to allow dma consumer driver call pm_runtime_get_sync()
on the dma device. Something similar maybe to what we have
for phy_pm_runtime_get_sync(). Or just get the device handle for
dma so the consumer can call pm_runtime_get_sync() on it.

> On the other hand: if the usb driver assumes that the dma transfer is
> already finished when issue_pending returned and carry on with
> subsequent request, that is also a problematic assumption. One can only
> consider a transfer to be done if the completion callback is called or
> you have polled for the completion and it tells you the same.
> This is problematic if you are in atomic context as the DMA completion
> interrupt might not come while you are there.

Yeah the musb driver has a history of 14 years of issues.
I guess the logic there has been, it's usb, it can disconnect
at any time..

> imho, this fix is working by lucky constellation of the stars ;)
> Or we can assume that there will never be more than 100ms delay between
> prepare_sg and issue_pending...

Not true. The cpp41 dma is doing the right thing and is not
affected by the PM runtime autosuspend delay. Otherwise USB
hard drives would not work, they can take seconds to spin up :)

The missing part here seems to be the fact that musb continues
before the dma completion is done.

Regards,

Tony
