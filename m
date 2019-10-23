Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32DE1F4E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 17:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390944AbfJWP2A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Oct 2019 11:28:00 -0400
Received: from muru.com ([72.249.23.125]:39348 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732725AbfJWP2A (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Oct 2019 11:28:00 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 360F980CF;
        Wed, 23 Oct 2019 15:28:33 +0000 (UTC)
Date:   Wed, 23 Oct 2019 08:27:55 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        George Cherian <george.cherian@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        dmaengine@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, giulio.benetti@benettiengineering.com,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] dmaengine: cppi41: Fix issue with musb and ftdi uart
Message-ID: <20191023152755.GK5610@atomide.com>
References: <20191022145545.6449-1-tony@atomide.com>
 <20191023045333.GO2654@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023045333.GO2654@vkoul-mobl>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Vinod Koul <vkoul@kernel.org> [191023 04:54]:
> Hi Tony,
> 
> On 22-10-19, 07:55, Tony Lindgren wrote:
> 
> Patch subject should reflect the patch changes not the fix. The patch
> title here is not telling me anything about the change below. Pls
> consider updating the title.

Sure, I'll resend with updated description using:

dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when idle

> > The first dma call done by musb_ep_program() must wait if cppi41 is PM
> > runtime suspended. Otherwise musb_ep_program() continues with other
> > non-dma packets before the DMA transfer is started causing at least ftdi
> > uarts to fail to receive data.
> > 
> > Let's fix the issue by waking up cppi41 with PM runtime calls added to
> > cppi41_dma_prep_slave_sg() and return NULL if still idled. This way we
> > have musb_ep_program() continue with PIO until cppi41 is awake.
> > 
> > Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> 
> Cc stable?

Yes please.

Regards,

Tony
