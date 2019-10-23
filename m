Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F570E246C
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 22:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407463AbfJWUSf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 16:18:35 -0400
Received: from muru.com ([72.249.23.125]:39584 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407427AbfJWUSe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Oct 2019 16:18:34 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F0A6480CF;
        Wed, 23 Oct 2019 20:19:06 +0000 (UTC)
Date:   Wed, 23 Oct 2019 13:18:29 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
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
Message-ID: <20191023201829.GR5610@atomide.com>
References: <20191023153138.23442-1-tony@atomide.com>
 <245e1e8f-7933-bae1-b779-239f33d4d449@ti.com>
 <20191023171628.GO5610@atomide.com>
 <5deab8a9-5796-5367-213e-90c5961b8498@ti.com>
 <20191023191859.GQ5610@atomide.com>
 <7d578fe1-2d60-4a6e-48b0-73d66c39f783@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d578fe1-2d60-4a6e-48b0-73d66c39f783@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [191023 19:55]:
> On 10/23/19 10:18 PM, Tony Lindgren wrote:
> > We'd have to allow dma consumer driver call pm_runtime_get_sync()
> > on the dma device. Something similar maybe to what we have
> > for phy_pm_runtime_get_sync(). Or just get the device handle for
> > dma so the consumer can call pm_runtime_get_sync() on it.
> 
> How much a pm_runtime_get_sync(dmadev) is different when it is issued by
> the client driver compared to when the dma driver issues it for it's own
> device?

Well the consumer device could call pm_runtime_get_sync(dmadev)
when the USB cable is connected for example, and then call
pm_runtime_pu(dmadev) when let's say the USB cable is disconnected.

Without using pm_runtime_irq_safe() we currently don't have a
clear path for doing this where the pm_runtime_get_sync(dmadev)
may sleep.

> But I still fail to see the difference between the events before this
> patch and with the case when there is a 100ms delay between prep_sg and
> issue_pending.
> 
> Before this patch:
> 
> prep_sg()
> issue_pending() <- runtime_get() /  put_autosuspend()
> 		   _not_ starting transfer
> runtime_resume() <- starts the transfer
> 
> With this patch and than 100ms delay between prep_sg and issue_pending:
> 
> prep_sg() <- runtime_get() /  put_autosuspend()
> runtime_resume() <- not starting transfer
> issue_pending() <- runtime_get() /  put_autosuspend()
> 		   starts the transfer
> 
> With this patch, but more than 100ms delay in between:
> 
> prep_sg() <- runtime_get() /  put_autosuspend()
> runtime_resume() <- not starting transfer
> > 100ms delay
> runtime_suspend()
> issue_pending() <- runtime_get() /  put_autosuspend()
> 		   _not_ starting transfer
> runtime_resume() <- starts the transfer
> 
> pm_runtime_get_sync() in issue_pending would be the solution to avoid
> delayed execution, but the usb driver should not assume that DMA is
> completed as soon as issue_pending returned.

Oh I see. Yes the consumer driver would need to check for
the completed dma transfer in all cases. The delay issues
should not currently happen in the musb_ep_program() problem
case as it gets called from IRQ context.

And no, adding pm_runtime_get_sync() to issue_pending is not
a solution. There may be clocks and regulators that need to
be powered up, and we don't want to use pm_runtime_irq_safe()
because of the permanent use count on the parent.

Regards,

Tony
