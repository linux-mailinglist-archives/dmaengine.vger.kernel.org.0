Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A761E6CA5
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 22:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407294AbgE1Uee (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 16:34:34 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44194 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407190AbgE1Uee (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 16:34:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id C741C80307C1;
        Thu, 28 May 2020 20:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jdv7qOIYXcJH; Thu, 28 May 2020 23:34:30 +0300 (MSK)
Date:   Thu, 28 May 2020 23:34:29 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] dmaengine: dw: Add dummy device_caps callback
Message-ID: <20200528203429.n23gi65zndfo4zti@mobilestation>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-9-Sergey.Semin@baikalelectronics.ru>
 <20200528145303.GU1634618@smile.fi.intel.com>
 <20200528152740.ggld7wkmaqiq4g6o@mobilestation>
 <CAHp75VdrOJF6R9YDpeV7x+9=DZJULM0hsfdr0o_Jmgf69CRKvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VdrOJF6R9YDpeV7x+9=DZJULM0hsfdr0o_Jmgf69CRKvQ@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 28, 2020 at 11:29:16PM +0300, Andy Shevchenko wrote:
> On Thu, May 28, 2020 at 6:30 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > On Thu, May 28, 2020 at 05:53:03PM +0300, Andy Shevchenko wrote:
> > > On Wed, May 27, 2020 at 01:50:19AM +0300, Serge Semin wrote:
> > > > Since some DW DMA controllers (like one installed on Baikal-T1 SoC) may
> > > > have non-uniform DMA capabilities per device channels, let's add
> > > > the DW DMA specific device_caps callback to expose that specifics up to
> > > > the DMA consumer. It's a dummy function for now. We'll fill it in with
> > > > capabilities overrides in the next commits.
> > >
> > > I think per se it is not worth to have it separated. Squash into the next one.
> >
> > bikeshadding?
> 
> Actually no.
> 
> > There is no any difference whether I add a dummy callback, then
> > fill it in in a following up patch, or have the callback added together
> > with some content. Let's see what Vinod thinks of it. Until then I'll stick with
> > the current solution.
> 
> The rule of thumb that we don't add dead code or code which is useless
> per se. Go ahead and provide it with some usefulness.

Actually yes. I've seen examples, which preparation patches first added
prototypes with empty functionality, that in follow-up patches have been
filled with a required code. I've seen Greg accepted such approach. So it's
absolutely normal and acceptable.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
