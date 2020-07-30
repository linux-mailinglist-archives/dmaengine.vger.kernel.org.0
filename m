Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4FA23376B
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jul 2020 19:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgG3RMA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jul 2020 13:12:00 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57750 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3RL7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jul 2020 13:11:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5282C803202F;
        Thu, 30 Jul 2020 17:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AIqB7a2FtJ5j; Thu, 30 Jul 2020 20:11:56 +0300 (MSK)
Date:   Thu, 30 Jul 2020 20:11:55 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] dmaengine: dw: Add DMA-channels mask cell support
Message-ID: <20200730171155.rywxoibglse2pc3h@mobilestation>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
 <20200730154545.3965-6-Sergey.Semin@baikalelectronics.ru>
 <20200730164146.GX3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200730164146.GX3703480@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 30, 2020 at 07:41:46PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 30, 2020 at 06:45:45PM +0300, Serge Semin wrote:
> > DW DMA IP-core provides a way to synthesize the DMA controller with
> > channels having different parameters like maximum burst-length,
> > multi-block support, maximum data width, etc. Those parameters both
> > explicitly and implicitly affect the channels performance. Since DMA slave
> > devices might be very demanding to the DMA performance, let's provide a
> > functionality for the slaves to be assigned with DW DMA channels, which
> > performance according to the platform engineer fulfill their requirements.
> > After this patch is applied it can be done by passing the mask of suitable
> > DMA-channels either directly in the dw_dma_slave structure instance or as
> > a fifth cell of the DMA DT-property. If mask is zero or not provided, then
> > there is no limitation on the channels allocation.
> > 
> > For instance Baikal-T1 SoC is equipped with a DW DMAC engine, which first
> > two channels are synthesized with max burst length of 16, while the rest
> > of the channels have been created with max-burst-len=4. It would seem that
> > the first two channels must be faster than the others and should be more
> > preferable for the time-critical DMA slave devices. In practice it turned
> > out that the situation is quite the opposite. The channels with
> > max-burst-len=4 demonstrated a better performance than the channels with
> > max-burst-len=16 even when they both had been initialized with the same
> > settings. The performance drop of the first two DMA-channels made them
> > unsuitable for the DW APB SSI slave device. No matter what settings they
> > are configured with, full-duplex SPI transfers occasionally experience the
> > Rx FIFO overflow. It means that the DMA-engine doesn't keep up with
> > incoming data pace even though the SPI-bus is enabled with speed of 25MHz
> > while the DW DMA controller is clocked with 50MHz signal. There is no such
> > problem has been noticed for the channels synthesized with
> > max-burst-len=4.
> 
> ...
> 

> > +	if (dws->channels && !(dws->channels & dwc->mask))
> 
> You can drop the first check if...

See below.

> 
> > +		return false;
> 
> ...
> 
> > +	if (dma_spec->args_count >= 4)
> > +		slave.channels = dma_spec->args[3];
> 
> ...you apply sane default here or somewhere else.

Alas I can't because dw_dma_slave structure is defined all over the kernel
drivers/spi/spi-dw-dma.c
drivers/spi/spi-pxa2xx-pci.c
drivers/tty/serial/8250/8250_lpss.c

These devices aren't always placed on the OF-based platforms. In that case the
corresponding DMA-channels won't be requested by means of the dw_dma_of_xlate()
method. So we have to preserve a default behavior if dws->channels is zero.

> 
> ...
> 
> > +		    fls(slave.channels) > dw->pdata->nr_channels))
> 

> Does it really make sense?

It does to prevent the clients to specify an invalid channels mask, which can't
have bits set higher than the number of channels the engine supports.

> 
> I think it can also be simplified to faster op, i.e.
> 	BIT(nr_channels) < slave.channels
> (but check for off-by-one errors)

Makes sense. Thanks. I'll replace it with the next statement:
slave.channels >= BIT(dw->pdata->nr_channels)

> 
> ...
> 

> > + * @channels:	mask of the channels permitted for allocation (zero
> > + *		value means any)
> 
> Perhaps on one line?

I don't really care. If you insist on that, I'll make it a single line, but it
will be over 80 columns. 85 to be exact.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
