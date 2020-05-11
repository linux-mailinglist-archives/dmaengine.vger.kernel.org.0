Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D901CD03E
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 05:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEKDOL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 May 2020 23:14:11 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47868 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgEKDOL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 May 2020 23:14:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7EFF88030807;
        Mon, 11 May 2020 03:13:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 39Gwz_y8nH4Q; Mon, 11 May 2020 06:13:45 +0300 (MSK)
Date:   Mon, 11 May 2020 06:13:44 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is
 unsupported
Message-ID: <20200511031344.lnq3wesjuy5cwbfj@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
 <20200508190622.GQ185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508190622.GQ185537@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 08, 2020 at 10:06:22PM +0300, Andy Shevchenko wrote:
> On Fri, May 08, 2020 at 12:53:34PM +0100, Mark Brown wrote:
> > On Fri, May 08, 2020 at 02:26:04PM +0300, Andy Shevchenko wrote:
> > > On Fri, May 08, 2020 at 01:53:02PM +0300, Serge Semin wrote:
> > 
> > > > Multi-block support provides a way to map the kernel-specific SG-table so
> > > > the DW DMA device would handle it as a whole instead of handling the
> > > > SG-list items or so called LLP block items one by one. So if true LLP
> > > > list isn't supported by the DW DMA engine, then soft-LLP mode will be
> > > > utilized to load and execute each LLP-block one by one. A problem may
> > > > happen for multi-block DMA slave transfers, when the slave device buffers
> > > > (for example Tx and Rx FIFOs) depend on each other and have size smaller
> > > > than the block size. In this case writing data to the DMA slave Tx buffer
> > > > may cause the Rx buffer overflow if Rx DMA channel is paused to
> > > > reinitialize the DW DMA controller with a next Rx LLP item. In particular
> > > > We've discovered this problem in the framework of the DW APB SPI device
> > 
> > > Mark, do we have any adjustment knobs in SPI core to cope with this?
> > 
> > Frankly I'm not sure I follow what the issue is - is an LLP block item
> > different from a SG list entry?  As far as I can tell the problem is
> > that the DMA controller does not support chaining transactions together
> > and possibly also has a limit on the transfer size?  Or possibly some
> > issue with the DMA controller locking the CPU out of the I/O bus for
> > noticable periods?  I can't really think what we could do about that if
> > the issue is transfer sizes, that just seems like hardware which is
> > never going to work reliably.  If the issue is not being able to chain
> > transfers then possibly an option to linearize messages into a single
> > transfer as suggested to cope with PIO devices with ill considered
> > automated chip select handling, though at some point you have to worry
> > about the cost of the memcpy() vs the cost of just doing PIO.
> 
> My understanding that the programmed transfers (as separate items in SG list)
> can be desynchronized due to LLP emulation in DMA driver. And suggestion
> probably is to use only single entry (block) SG lists will do the trick (I
> guess that we can configure SPI core do or do not change CS between them).

CS has nothing to do with this. The problem is pure in the LLP emulation and Tx
channel being enabled before the Rx channel initialization during the next LLP
reload. Yes, if we have Tx and Rx SG/LLP list consisting of a single item, then
there is no problem. Though it would be good to fix the issue in general instead
of setting such fatal restrictions. If we had some fence of blocking one channel
before another is reinitialized, the problem could theoretically be solved.

It could be an interdependent DMA channels functionality. If two channels are
interdependent than the Rx channel could pause the Tx channel while it's in the
IRQ handling procedure (or at some other point... call a callback?). This !might!
fix the problem, but with no 100% guarantee of success. It will work only if IRQ
handler is executed with small latency, so the Tx channel is paused before the Rx
FIFO has been filled and overrun.

Another solution could be to reinitialize the interdependent channels
synchronously. Tx channel stops and waits until the Rx channel is finished its
business of data retrieval from SPI Rx FIFO. Though this solution implies
the Tx and Rx buffers of SG/LLP items being of the same size.

Although non of these solutions I really like to spend some time for its
development.

> 
> > > > working in conjunction with DW DMA. Since there is no comprehensive way to
> > > > fix it right now lets at least print a warning for the first found
> > > > multi-blockless DW DMAC channel. This shall point a developer to the
> > > > possible cause of the problem if one would experience a sudden data loss.
> > 
> > I thought from the description of the SPI driver I just reviewed that
> > this hardware didn't have DMA?  Or are there separate blocks in the
> > hardware that have a more standard instantiation of the DesignWare SPI
> > controller with DMA attached?
> 
> I speculate that the right words there should be 'we don't enable DMA right now
> due to some issues' (see above).

It's your speculation and it's kind of offensive implicitly implying I was
lying. If our System SPI controller had DMA I would have said that and would
have made it supported in the driver and probably wouldn't bother with a
dedicated driver development. Again the Baikal-T1 System Boot SPI controller
doesn't have DMA, doesn't have IRQ, is equipped with only 8 bytes FIFO, is
embedded into the Boot Controller, provides a dirmap interface to an SPI flash
and so on. Baikal-T1 has also got two more normal DW APB SSI interfaces with 64
bytes FIFO, IRQ and DMA.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
