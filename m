Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACEFE2195
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 19:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfJWRQf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 13:16:35 -0400
Received: from muru.com ([72.249.23.125]:39462 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfJWRQe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Oct 2019 13:16:34 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C4EFC80CF;
        Wed, 23 Oct 2019 17:17:06 +0000 (UTC)
Date:   Wed, 23 Oct 2019 10:16:28 -0700
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
Message-ID: <20191023171628.GO5610@atomide.com>
References: <20191023153138.23442-1-tony@atomide.com>
 <245e1e8f-7933-bae1-b779-239f33d4d449@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <245e1e8f-7933-bae1-b779-239f33d4d449@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [191023 17:04]:
> On 10/23/19 6:31 PM, Tony Lindgren wrote:
> > diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
> > --- a/drivers/dma/ti/cppi41.c
> > +++ b/drivers/dma/ti/cppi41.c
> > @@ -586,9 +586,22 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
> >  	enum dma_transfer_direction dir, unsigned long tx_flags, void *context)
> >  {
> >  	struct cppi41_channel *c = to_cpp41_chan(chan);
> > +	struct dma_async_tx_descriptor *txd = NULL;
> > +	struct cppi41_dd *cdd = c->cdd;
> >  	struct cppi41_desc *d;
> >  	struct scatterlist *sg;
> >  	unsigned int i;
> > +	int error;
> > +
> > +	error = pm_runtime_get(cdd->ddev.dev);
> 
> If pm_runtime_get()
> pm_runtime_mark_last_busy()+pm_runtime_put_autosuspend() around a code
> which updates a descriptor in _memory_ helps then this best described as
> works by luck ;)

It also checks the cpp41 state for cdd->is_suspended
though. AFAIK we do not currently have any other place
to tell the driver a DMA request is about to start at
some point soon.

> I have a feeling that if you put enough delay between prepare_sg and
> issue_pending in the usb driver then it will keep failing, no?

Nope, it will just queue it and run the queue when awake.

> fwiw, in the cppi41_dma_issue_pending() the driver does:
> 
> 	error = pm_runtime_get(cdd->ddev.dev);
> ...
> 	if (!cdd->is_suspended)
> 		cppi41_run_queue(cdd);
> ...
> 	pm_runtime_mark_last_busy(cdd->ddev.dev);
> 	pm_runtime_put_autosuspend(cdd->ddev.dev);
> 
> Without waiting for the transfer to complete?

The queue gets run when cpp41 is awake, runtime PM
reference is not released until completed.

> If issue_pending is not starting the transfer right away then the whole
> pm handling is broken in there. imho.

AFAIK there is no other way to do this without tagging
devices with pm_runtime_irq_safe(), which is nasty as
it takes a permanent use count on the parent device.

But yeah, some dmaengine API that can sleep to tell
a request is about to come would simplify things.

I don't think we have anything like that available
right now?

Regards,

Tony
