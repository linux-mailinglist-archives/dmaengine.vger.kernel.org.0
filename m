Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0351CCF5C
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 04:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgEKCKb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 10 May 2020 22:10:31 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47822 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgEKCKb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 10 May 2020 22:10:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3F8068030809;
        Mon, 11 May 2020 02:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DIUJtZOGJa0j; Mon, 11 May 2020 05:10:19 +0300 (MSK)
Date:   Mon, 11 May 2020 05:10:16 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
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
Message-ID: <20200511021016.wptcgnc3iq3kadgz@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508115334.GE4820@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Mark

On Fri, May 08, 2020 at 12:53:34PM +0100, Mark Brown wrote:
> On Fri, May 08, 2020 at 02:26:04PM +0300, Andy Shevchenko wrote:
> > On Fri, May 08, 2020 at 01:53:02PM +0300, Serge Semin wrote:
> 
> > > Multi-block support provides a way to map the kernel-specific SG-table so
> > > the DW DMA device would handle it as a whole instead of handling the
> > > SG-list items or so called LLP block items one by one. So if true LLP
> > > list isn't supported by the DW DMA engine, then soft-LLP mode will be
> > > utilized to load and execute each LLP-block one by one. A problem may
> > > happen for multi-block DMA slave transfers, when the slave device buffers
> > > (for example Tx and Rx FIFOs) depend on each other and have size smaller
> > > than the block size. In this case writing data to the DMA slave Tx buffer
> > > may cause the Rx buffer overflow if Rx DMA channel is paused to
> > > reinitialize the DW DMA controller with a next Rx LLP item. In particular
> > > We've discovered this problem in the framework of the DW APB SPI device
> 
> > Mark, do we have any adjustment knobs in SPI core to cope with this?
> 
> Frankly I'm not sure I follow what the issue is - is an LLP block item
> different from a SG list entry?  As far as I can tell the problem is
> that the DMA controller does not support chaining transactions together
> and possibly also has a limit on the transfer size?  Or possibly some
> issue with the DMA controller locking the CPU out of the I/O bus for
> noticable periods?  I can't really think what we could do about that if
> the issue is transfer sizes, that just seems like hardware which is
> never going to work reliably.  If the issue is not being able to chain
> transfers then possibly an option to linearize messages into a single
> transfer as suggested to cope with PIO devices with ill considered
> automated chip select handling, though at some point you have to worry
> about the cost of the memcpy() vs the cost of just doing PIO.

The problem is that our version of DW DMA controller can't automatically walk
over the chained SG list (in the DW DMA driver the SG list is mapped into a
chain of LLP items, which length is limited to the max transfer length supported
by the controller). In order to cope with such devices the DW DMA driver
manually (in IRQ handler) reloads the next SG/LLP item in the chain when a
previous one is finished. This causes a problem in the generic DW SSI driver
because normally the Tx DMA channel finishes working before the Rx DMA channel.
So the DW DMA driver will reload the next Tx SG/LLP item and will start the Tx
transaction while the Rx DMA finish IRQ is still pending. This most of the time
causes the Rx FIFO overrun and obviously data loss.

Alas linearizing the SPI messages won't help in this case because the DW DMA
driver will split it into the max transaction chunks anyway.

> 
> > > working in conjunction with DW DMA. Since there is no comprehensive way to
> > > fix it right now lets at least print a warning for the first found
> > > multi-blockless DW DMAC channel. This shall point a developer to the
> > > possible cause of the problem if one would experience a sudden data loss.
> 
> I thought from the description of the SPI driver I just reviewed that
> this hardware didn't have DMA?  Or are there separate blocks in the
> hardware that have a more standard instantiation of the DesignWare SPI
> controller with DMA attached?

You are right. Baikal-T1's got three SPI interfaces. Two of them are normal
DW APB SSI interfaces with 64 bytes FIFO, DMA, IRQ, their registers are
mapped in a dedicated memory space with no stuff like SPI flash direct mapping,
and the third one is the embedded into the System Boot Controller DW APB SSI
with all the peculiarities and complications I've described in the
corresponding patchset. Here in this patch I am talking about the former
ones.

-Sergey
