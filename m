Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7261E7AC7
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 12:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgE2KlX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 06:41:23 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47250 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2KlX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 May 2020 06:41:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7217780307C7;
        Fri, 29 May 2020 10:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W6eRTeMemRWI; Fri, 29 May 2020 13:41:19 +0300 (MSK)
Date:   Fri, 29 May 2020 13:41:19 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/11] dmaengine: dw: Initialize min_burst capability
Message-ID: <20200529104119.qrqoptp5iz5hs56r@mobilestation>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
 <20200528222401.26941-10-Sergey.Semin@baikalelectronics.ru>
 <20200529102515.GD1634618@smile.fi.intel.com>
 <20200529102902.GG1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200529102902.GG1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 29, 2020 at 01:29:02PM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 01:25:15PM +0300, Andy Shevchenko wrote:
> > On Fri, May 29, 2020 at 01:23:59AM +0300, Serge Semin wrote:
> > > According to the DW APB DMAC data book the minimum burst transaction
> > > length is 1 and it's true for any version of the controller since
> > > isn't parametrised in the coreAssembler so can't be changed at the
> > > IP-core synthesis stage. Let's initialise the min_burst member of the
> > > DMA controller descriptor so the DMA clients could use it to properly
> > > optimize the DMA requests.
> 
> ...
> 
> > >  	/* DMA capabilities */
> > 
> > > +	dw->dma.min_burst = 1;
> > 
> > Perhaps then relaxed maximum, like
> > 
> > 	dw->dma.max_burst = 256;
> > 
> > (channels will update this)
> > 
> > ?
> 

> And forgot to mention that perhaps we need a definitions for both.

By "definitions for both" do you mean a macro with corresponding parameter
definition like it's done for the max burst length in the next patch?
Something like this:
--- include/linux/platform_data/dma-dw.h
+++ include/linux/platform_data/dma-dw.h
+#define DW_DMA_MIN_BURST	1
+#define DW_DMA_MAX_BURST	256

?

-Sergey

> 
> > >  	dw->dma.src_addr_widths = DW_DMA_BUSWIDTHS;
> > >  	dw->dma.dst_addr_widths = DW_DMA_BUSWIDTHS;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
