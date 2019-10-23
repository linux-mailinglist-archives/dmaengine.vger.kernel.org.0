Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BBAE25C2
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 23:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405702AbfJWVtO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 17:49:14 -0400
Received: from muru.com ([72.249.23.125]:39646 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390165AbfJWVtO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Oct 2019 17:49:14 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 09F8280CF;
        Wed, 23 Oct 2019 21:49:45 +0000 (UTC)
Date:   Wed, 23 Oct 2019 14:49:08 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
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
Message-ID: <20191023214908.GU5610@atomide.com>
References: <20191023153138.23442-1-tony@atomide.com>
 <245e1e8f-7933-bae1-b779-239f33d4d449@ti.com>
 <20191023171628.GO5610@atomide.com>
 <5deab8a9-5796-5367-213e-90c5961b8498@ti.com>
 <20191023191859.GQ5610@atomide.com>
 <7d578fe1-2d60-4a6e-48b0-73d66c39f783@ti.com>
 <20191023201829.GR5610@atomide.com>
 <c3f0ae57-bc74-bab9-c8f9-b4ca751d657e@ti.com>
 <20191023212734.GT5610@atomide.com>
 <78bf336e-8078-df79-2e3e-42c6cf8a3ae8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bf336e-8078-df79-2e3e-42c6cf8a3ae8@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [191023 21:43]:
> 
> 
> On 24/10/2019 00:27, Tony Lindgren wrote:
> > * Grygorii Strashko <grygorii.strashko@ti.com> [191023 20:56]:
> > > On 23/10/2019 23:18, Tony Lindgren wrote:
> > > > And no, adding pm_runtime_get_sync() to issue_pending is not
> > > > a solution. There may be clocks and regulators that need to
> > > > be powered up, and we don't want to use pm_runtime_irq_safe()
> > > > because of the permanent use count on the parent.
> > > 
> > > 5 cents.
> > > 
> > > I think the right thing might be to get rid of pm_runtime_xxx()
> > > in cppi41_dma_issue_pending(). So overall approach will be:
> > > 
> > > - new job -> cppi41_dma_prep_slave_sg() -> pm_runtime_get()
> > > - issue_pending: fill backlog if suspended or run_queue if active (pm_runtime_active())
> > > - job done: dmaengine_desc_get_callback_invoke() ->
> > > 
> > > 	dmaengine_desc_get_callback_invoke();
> > > 	pm_runtime_mark_last_busy(cdd->ddev.dev);
> > > 	pm_runtime_put_autosuspend(cdd->ddev.dev);
> > >    in all places.
> > > 
> > > It even might allow to get rid of cdd->lock.
> > 
> > Well I don't think cppi41_dma_prep_slave_sg() is necessarily
> > paired with anything currently.
> 
> It should - dma cmpletion callbacks have to be called somewhere.

Well what I meant is there's no guarantee that we have
cppi41_dma_issue_pending() followed by cppi41_dma_prep_slave_sg()
currently :)

>  This can potentially leading
> > to pm_runtime_get() called multiple times?
> 
> That's the idea - increase pm_counter as many times as jobs submitted.

Right, but that needs to be done in a paired manner so the
API is clear to everyone and does not lead into unpaired
PM runtime calls.

Regards,

Tony
