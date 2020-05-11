Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED11CE485
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbgEKTdC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 15:33:02 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:49834 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgEKTdB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 15:33:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 45FF1803080A;
        Mon, 11 May 2020 19:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q65asuHJMWNf; Mon, 11 May 2020 22:32:57 +0300 (MSK)
Date:   Mon, 11 May 2020 22:32:55 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
        devicetree <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is
 unsupported
Message-ID: <20200511193255.t6orpcdz5ukmwmqo@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
 <20200511021016.wptcgnc3iq3kadgz@mobilestation>
 <20200511115813.GG8216@sirena.org.uk>
 <20200511134502.hjbu5evkiuh75chr@mobilestation>
 <CAHp75VdOi1rwaKjzowhj0KA-eNNL4NxpiCeqfELFgO_RcnZ-xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VdOi1rwaKjzowhj0KA-eNNL4NxpiCeqfELFgO_RcnZ-xw@mail.gmail.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 11, 2020 at 04:58:53PM +0300, Andy Shevchenko wrote:
> On Mon, May 11, 2020 at 4:48 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > On Mon, May 11, 2020 at 12:58:13PM +0100, Mark Brown wrote:
> > > On Mon, May 11, 2020 at 05:10:16AM +0300, Serge Semin wrote:
> > >
> > > > Alas linearizing the SPI messages won't help in this case because the DW DMA
> > > > driver will split it into the max transaction chunks anyway.
> > >
> > > That sounds like you need to also impose a limit on the maximum message
> > > size as well then, with that you should be able to handle messages up
> > > to whatever that limit is.  There's code for that bit already, so long
> > > as the limit is not too low it should be fine for most devices and
> > > client drivers can see the limit so they can be updated to work with it
> > > if needed.
> >
> > Hmm, this might work. The problem will be with imposing such limitation through
> > the DW APB SSI driver. In order to do this I need to know:
> > 1) Whether multi-block LLP is supported by the DW DMA controller.
> > 2) Maximum DW DMA transfer block size.
> > Then I'll be able to use this information in the can_dma() callback to enable
> > the DMA xfers only for the safe transfers. Did you mean something like this when
> > you said "There's code for that bit already" ? If you meant the max_dma_len
> > parameter, then setting it won't work, because it just limits the SG items size
> > not the total length of a single transfer.
> >
> > So the question is of how to export the multi-block LLP flag from DW DMAc
> > driver. Andy?
> 
> I'm not sure I understand why do you need this being exported. Just
> always supply SG list out of single entry and define the length
> according to the maximum segment size (it's done IIRC in SPI core).

Finally I see your point. So you suggest to feed the DMA engine with SG list
entries one-by-one instead of sending all of them at once in a single
dmaengine_prep_slave_sg() -> dmaengine_submit() -> dma_async_issue_pending()
session. Hm, this solution will work, but there is an issue. There is no
guarantee, that Tx and Rx SG lists are symmetric, consisting of the same
number of items with the same sizes. It depends on the Tx/Rx buffers physical
address alignment and their offsets within the memory pages. Though this
problem can be solved by making the Tx and Rx SG lists symmetric. I'll have
to implement a clever DMA IO loop, which would extract the DMA
addresses/lengths from the SG entries and perform the single-buffer DMA 
transactions with the DMA buffers of the same length.

Regarding noLLP being exported. Obviously I intended to solve the problem in a
generic way since the problem is common for noLLP DW APB SSI/DW DMAC combination.
In order to do this we need to know whether the multi-block LLP feature is
unsupported by the DW DMA controller. We either make such info somehow exported
from the DW DMA driver, so the DMA clients (like Dw APB SSI controller driver)
could be ready to work around the problem; or just implement a flag-based quirk
in the DMA client driver, which would be enabled in the platform-specific basis
depending on the platform device actually detected (for instance, a specific
version of the DW APB SSI IP). AFAICS You'd prefer the later option. 

Regarding SPI core toggling CS. It is irrelevant to this problem, since DMA
transactions are implemented within a single SPI transfer so the CS won't be
touched by the SPI core while we are working wht the xfer descriptor. Though
the problem with DW APB SSI native CS automatic toggling will persist anyway
no matter whether the multi-block LLPs are supported on not.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
