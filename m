Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FF61E7FB1
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 16:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2OHn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 10:07:43 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48652 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2OHn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 May 2020 10:07:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1A7798030777;
        Fri, 29 May 2020 14:07:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 19c8mHoJIBUB; Fri, 29 May 2020 17:07:39 +0300 (MSK)
Date:   Fri, 29 May 2020 17:07:38 +0300
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
Subject: Re: [PATCH v4 05/11] dmaengine: Introduce DMA-device device_caps
 callback
Message-ID: <20200529140738.l57z24xylcnxk6m2@mobilestation>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
 <20200528222401.26941-6-Sergey.Semin@baikalelectronics.ru>
 <20200529121203.GK1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200529121203.GK1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 29, 2020 at 03:12:03PM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 01:23:55AM +0300, Serge Semin wrote:
> > There are DMA devices (like ours version of Synopsys DW DMAC) which have
> > DMA capabilities non-uniformly redistributed amongst the device channels.
> > In order to provide a way of exposing the channel-specific parameters to
> > the DMA engine consumers, we introduce a new DMA-device callback. In case
> > if provided it gets called from the dma_get_slave_caps() method and is
> > able to override the generic DMA-device capabilities.
> 
> I thought there is a pattern to return something, but it seems none.
> So, I have nothing against it to return void.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> But consider one comment below.
> 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-mips@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > 
> > ---
> > 
> > Changelog v3:
> > - This is a new patch created as a result of the discussion with Vinod and
> >   Andy in the framework of DW DMA burst and LLP capabilities.
> > ---
> >  drivers/dma/dmaengine.c   | 3 +++
> >  include/linux/dmaengine.h | 2 ++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index ad56ad58932c..edbb11d56cde 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -599,6 +599,9 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> >  	caps->cmd_resume = !!device->device_resume;
> >  	caps->cmd_terminate = !!device->device_terminate_all;
> >  
> 

> Perhaps a comment to explain that this is channel specific correction /
> override / you name it on top of device level capabilities?
> 
> > +	if (device->device_caps)
> > +		device->device_caps(chan, caps);
> > +

Agreed. I also forgot to add a doc-comment above the struct dma_device
definition.

-Sergey 

> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(dma_get_slave_caps);
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index a7e4d8dfdd19..b303e59929e5 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -899,6 +899,8 @@ struct dma_device {
> >  		struct dma_chan *chan, dma_addr_t dst, u64 data,
> >  		unsigned long flags);
> >  
> > +	void (*device_caps)(struct dma_chan *chan,
> > +			    struct dma_slave_caps *caps);
> >  	int (*device_config)(struct dma_chan *chan,
> >  			     struct dma_slave_config *config);
> >  	int (*device_pause)(struct dma_chan *chan);
> > -- 
> > 2.26.2
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
