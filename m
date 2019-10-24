Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F157E34E5
	for <lists+dmaengine@lfdr.de>; Thu, 24 Oct 2019 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfJXOAv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Oct 2019 10:00:51 -0400
Received: from muru.com ([72.249.23.125]:39740 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbfJXOAv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Oct 2019 10:00:51 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 71C7680C5;
        Thu, 24 Oct 2019 14:01:23 +0000 (UTC)
Date:   Thu, 24 Oct 2019 07:00:45 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Bin Liu <b-liu@ti.com>, Daniel Mack <zonque@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johan Hovold <johan@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        giulio.benetti@benettiengineering.com,
        Sebastian Reichel <sre@kernel.org>,
        Skvortsov <andrej.skvortzov@gmail.com>,
        Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] dmaengine: cppi41: Fix cppi41_dma_prep_slave_sg() when
 idle
Message-ID: <20191024140045.GX5610@atomide.com>
References: <20191023153138.23442-1-tony@atomide.com>
 <245e1e8f-7933-bae1-b779-239f33d4d449@ti.com>
 <20191023171628.GO5610@atomide.com>
 <5deab8a9-5796-5367-213e-90c5961b8498@ti.com>
 <20191023191859.GQ5610@atomide.com>
 <7d578fe1-2d60-4a6e-48b0-73d66c39f783@ti.com>
 <20191023201829.GR5610@atomide.com>
 <4bcd75d8-b7c5-5006-d80f-c5bda0cdf011@ti.com>
 <CAHp75VfOHjzO=ar+G7ieJo49=Nt8kFwUnA__B7vX8+Gh4JZqzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfOHjzO=ar+G7ieJo49=Nt8kFwUnA__B7vX8+Gh4JZqzg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

* Andy Shevchenko <andy.shevchenko@gmail.com> [191024 11:23]:
> On Thu, Oct 24, 2019 at 11:51 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > On 23/10/2019 23.18, Tony Lindgren wrote:
> 
> > And the USB cable connect/disconnect is handled in interrupt -> you need
> > to call pm_runtime_get_sync(dmadev) from interrupt context and need to
> > mark the dmadev to pm_runtime_irq_safe()
> 
> Side note: and please don't spread the pm_runtime_irq_safe() hack more...
> I think Tony is quite aware of this.

I agree, let's not add any more pm_runtime_irq_safe() at all. And let's get
rid of all the existing users of it.

Using pm_runtime_irq_safe() causes a problem for implementing genpd because
of the permanent use count on the parent device. And then there is the
serial driver issue with console use.

In the musb case, we should be able to enable/disable cppi41 dma from
musb_pm_runtime_check_session() without a need for pm_runtime_irq_safe().

We probably still want to keep the $subject patch for the state check and
return NULL if cppi41 is not active. But should be able to remove the
PM runtime calls in the $subject patch.

Regards,

Tony
