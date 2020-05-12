Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58A91CF499
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2020 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgELMmP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 08:42:15 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53368 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELMmP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 May 2020 08:42:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B0FAC803080B;
        Tue, 12 May 2020 12:42:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PTikmzJM42z6; Tue, 12 May 2020 15:42:07 +0300 (MSK)
Date:   Tue, 12 May 2020 15:42:06 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
        devicetree <devicetree@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is
 unsupported
Message-ID: <20200512124206.l3uv5hg2zimi24dq@mobilestation>
References: <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
 <20200511021016.wptcgnc3iq3kadgz@mobilestation>
 <20200511115813.GG8216@sirena.org.uk>
 <20200511134502.hjbu5evkiuh75chr@mobilestation>
 <CAHp75VdOi1rwaKjzowhj0KA-eNNL4NxpiCeqfELFgO_RcnZ-xw@mail.gmail.com>
 <20200511193255.t6orpcdz5ukmwmqo@mobilestation>
 <20200511210714.GO185537@smile.fi.intel.com>
 <20200511210800.GP185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200511210800.GP185537@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Vinod,

Could you join the discussion for a little bit?

In order to properly fix the problem discussed in this topic, we need to
introduce an additional capability exported by DMA channel handlers on per-channel
basis. It must be a number, which would indicate an upper limitation of the SG list
entries amount.
Something like this would do it:
struct dma_slave_caps {
...
	unsigned int max_sg_nents;
...
};
As Andy suggested it's value should be interpreted as:
0          - unlimited number of entries,
1:MAX_UINT - actual limit to the number of entries.

In addition to that seeing the dma_get_slave_caps() method provide the caps only
by getting them from the DMA device descriptor, while we need to have an info on
per-channel basis, it would be good to introduce a new DMA-device callback like:
struct dma_device {
...
	int (*device_caps)(struct dma_chan *chan,
			   struct dma_slave_caps *caps);
...
};
So the DMA driver could override the generic DMA device capabilities with the
values specific to the DMA channels. Such functionality will be also helpful for
the max-burst-len parameter introduced by this patchset, since depending on the
IP-core synthesis parameters it may be channel-specific.

Alternatively we could just introduce a new fields to the dma_chan structure and
retrieve the new caps values from them in the dma_get_slave_caps() method.
Though the solution with callback I like better.

What is your opinion about this? What solution you'd prefer?

On Tue, May 12, 2020 at 12:08:00AM +0300, Andy Shevchenko wrote:
> On Tue, May 12, 2020 at 12:07:14AM +0300, Andy Shevchenko wrote:
> > On Mon, May 11, 2020 at 10:32:55PM +0300, Serge Semin wrote:
> > > On Mon, May 11, 2020 at 04:58:53PM +0300, Andy Shevchenko wrote:
> > > > On Mon, May 11, 2020 at 4:48 PM Serge Semin
> > > > <Sergey.Semin@baikalelectronics.ru> wrote:
> > > > >
> > > > > On Mon, May 11, 2020 at 12:58:13PM +0100, Mark Brown wrote:
> > > > > > On Mon, May 11, 2020 at 05:10:16AM +0300, Serge Semin wrote:
> > > > > >
> > > > > > > Alas linearizing the SPI messages won't help in this case because the DW DMA
> > > > > > > driver will split it into the max transaction chunks anyway.
> > > > > >
> > > > > > That sounds like you need to also impose a limit on the maximum message
> > > > > > size as well then, with that you should be able to handle messages up
> > > > > > to whatever that limit is.  There's code for that bit already, so long
> > > > > > as the limit is not too low it should be fine for most devices and
> > > > > > client drivers can see the limit so they can be updated to work with it
> > > > > > if needed.
> > > > >
> > > > > Hmm, this might work. The problem will be with imposing such limitation through
> > > > > the DW APB SSI driver. In order to do this I need to know:
> > > > > 1) Whether multi-block LLP is supported by the DW DMA controller.
> > > > > 2) Maximum DW DMA transfer block size.
> > > > > Then I'll be able to use this information in the can_dma() callback to enable
> > > > > the DMA xfers only for the safe transfers. Did you mean something like this when
> > > > > you said "There's code for that bit already" ? If you meant the max_dma_len
> > > > > parameter, then setting it won't work, because it just limits the SG items size
> > > > > not the total length of a single transfer.
> > > > >
> > > > > So the question is of how to export the multi-block LLP flag from DW DMAc
> > > > > driver. Andy?
> > > > 
> > > > I'm not sure I understand why do you need this being exported. Just
> > > > always supply SG list out of single entry and define the length
> > > > according to the maximum segment size (it's done IIRC in SPI core).
> > > 
> > > Finally I see your point. So you suggest to feed the DMA engine with SG list
> > > entries one-by-one instead of sending all of them at once in a single
> > > dmaengine_prep_slave_sg() -> dmaengine_submit() -> dma_async_issue_pending()
> > > session. Hm, this solution will work, but there is an issue. There is no
> > > guarantee, that Tx and Rx SG lists are symmetric, consisting of the same
> > > number of items with the same sizes. It depends on the Tx/Rx buffers physical
> > > address alignment and their offsets within the memory pages. Though this
> > > problem can be solved by making the Tx and Rx SG lists symmetric. I'll have
> > > to implement a clever DMA IO loop, which would extract the DMA
> > > addresses/lengths from the SG entries and perform the single-buffer DMA 
> > > transactions with the DMA buffers of the same length.
> > > 
> > > Regarding noLLP being exported. Obviously I intended to solve the problem in a
> > > generic way since the problem is common for noLLP DW APB SSI/DW DMAC combination.
> > > In order to do this we need to know whether the multi-block LLP feature is
> > > unsupported by the DW DMA controller. We either make such info somehow exported
> > > from the DW DMA driver, so the DMA clients (like Dw APB SSI controller driver)
> > > could be ready to work around the problem; or just implement a flag-based quirk
> > > in the DMA client driver, which would be enabled in the platform-specific basis
> > > depending on the platform device actually detected (for instance, a specific
> > > version of the DW APB SSI IP). AFAICS You'd prefer the later option. 
> > 
> > So, we may extend the struct of DMA parameters to tell the consumer amount of entries (each of which is no longer than maximum segment size) it can afford:
> > - 0: Auto (DMA driver handles any cases itself)
> > - 1: Only single entry
> > - 2: Up to two...
> 
> It will left implementation details (or i.o.w. obstacles or limitation) why DMA
> can't do otherwise.

Sounds good. Thanks for assistance.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
