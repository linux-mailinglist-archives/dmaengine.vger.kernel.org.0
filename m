Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D41E66BF
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404520AbgE1PuX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 11:50:23 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43234 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404503AbgE1PuW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 11:50:22 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 226DD803083A;
        Thu, 28 May 2020 15:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id scf8l9YyCqMo; Thu, 28 May 2020 18:50:18 +0300 (MSK)
Date:   Thu, 28 May 2020 18:50:17 +0300
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
Subject: Re: [PATCH v3 10/10] dmaengine: dw: Initialize max_sg_nents with
 nollp flag
Message-ID: <20200528155017.ayetroojyvxl74kb@mobilestation>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-11-Sergey.Semin@baikalelectronics.ru>
 <20200528145630.GV1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200528145630.GV1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 28, 2020 at 05:56:30PM +0300, Andy Shevchenko wrote:
> On Wed, May 27, 2020 at 01:50:21AM +0300, Serge Semin wrote:
> > Multi-block support provides a way to map the kernel-specific SG-table so
> > the DW DMA device would handle it as a whole instead of handling the
> > SG-list items or so called LLP block items one by one. So if true LLP
> > list isn't supported by the DW DMA engine, then soft-LLP mode will be
> > utilized to load and execute each LLP-block one by one. The soft-LLP mode
> > of the DMA transactions execution might not work well for some DMA
> > consumers like SPI due to its Tx and Rx buffers inter-dependency. Let's
> > expose the nollp flag indicating the soft-LLP mode by means of the
> > max_sg_nents capability, so the DMA consumer would be ready to somehow
> > workaround errors caused by such mode being utilized.
> > 
> 
> In principal I agree, one nit below.
> If you are okay with it, feel free to add my Rb tag.
> 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-mips@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch created as a result of the discussion with Vinud and
> >   Andy in the framework of DW DMA burst and LLP capabilities.
> > ---
> >  drivers/dma/dw/core.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> > index 29c4ef08311d..b850eb7fd084 100644
> > --- a/drivers/dma/dw/core.c
> > +++ b/drivers/dma/dw/core.c
> > @@ -1054,6 +1054,15 @@ static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> >  	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> >  
> >  	caps->max_burst = dwc->max_burst;
> > +
> > +	/*
> > +	 * It might be crucial for some devices to have the hardware
> > +	 * accelerated multi-block transfers supported, aka LLPs in DW DMAC
> > +	 * notation. So if LLPs are supported then max_sg_nents is set to
> > +	 * zero which means unlimited number of SG entries can be handled in a
> > +	 * single DMA transaction, otherwise it's just one SG entry.
> > +	 */
> 
> > +	caps->max_sg_nents = dwc->nollp;
> 

> To be on the safer side I would explicitly do it like
> 
> 	if (dwc->nollp)
> 	 /* your nice comment */
> 	 = 1;
> 	else
> 	 /* Unlimited */
> 	 = 0;
> 
> type or content of nollp theoretically can be changed and this will affect maximum segments.

Agree. Though I don't like formatting you suggested. If I add my nice comment
between if-statement and assignment the the former will be look detached from
the if-statement, which seems a bit ugly. So I'd leave the comment above the
whole if-else statement, especially seeing I've already mentioned there about
the unlimited number of SG entries there.

	/*
	 * It might be crucial for some devices to have the hardware
	 * accelerated multi-block transfers supported, aka LLPs in DW DMAC
	 * notation. So if LLPs are supported then max_sg_nents is set to
	 * zero which means unlimited number of SG entries can be handled in a
	 * single DMA transaction, otherwise it's just one SG entry.
	 */
 	if (dwc->nollp)
 		caps->max_sg_nents = 1;
 	else
 		caps->max_sg_nents = 0;

-Sergey

> 
> >  }
> >  
> >  int do_dma_probe(struct dw_dma_chip *chip)
> > -- 
> > 2.26.2
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
