Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F351CE28E
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 20:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgEKSZl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 14:25:41 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:49720 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbgEKSZl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 14:25:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4B329803080A;
        Mon, 11 May 2020 18:25:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vze97ONxmtmJ; Mon, 11 May 2020 21:25:36 +0300 (MSK)
Date:   Mon, 11 May 2020 21:25:35 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Message-ID: <20200511182535.uvijbdjreqw2zsfc@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
 <20200511021016.wptcgnc3iq3kadgz@mobilestation>
 <20200511115813.GG8216@sirena.org.uk>
 <20200511134502.hjbu5evkiuh75chr@mobilestation>
 <CAHp75VdOi1rwaKjzowhj0KA-eNNL4NxpiCeqfELFgO_RcnZ-xw@mail.gmail.com>
 <20200511174800.GM8216@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200511174800.GM8216@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 11, 2020 at 06:48:00PM +0100, Mark Brown wrote:
> On Mon, May 11, 2020 at 04:58:53PM +0300, Andy Shevchenko wrote:
> > On Mon, May 11, 2020 at 4:48 PM Serge Semin
> 
> > > So the question is of how to export the multi-block LLP flag from DW DMAc
> > > driver. Andy?
> 
> > I'm not sure I understand why do you need this being exported. Just
> > always supply SG list out of single entry and define the length
> > according to the maximum segment size (it's done IIRC in SPI core).
> 
> If there's a limit from the dmaengine it'd be a bit cleaner to export
> the limit from the DMA engine (and it'd help with code reuse for clients
> that might work with other DMA controllers without needing to add custom
> compatibles for those instantiations).

Right. I've already posted a patch which exports the max segment size from the
DW DMA controller driver. The SPI core will get the limit in the spi_map_buf()
method by calling the dma_get_max_seg_size() function. The problem I
described concerns of how to determine whether to apply the solution Andy
suggested, since normally if DW DMA controller has true multi-block LLP
supported the workaround isn't required. So in order to solve the problem in a
generic way the easiest way would be to somehow get the noLLP flag from the DW
DMAC private data and select a one-by-one SG entries submission algorithm
instead of the normal one... On the other hand we could just implement a
flag-based quirks in the DW APB SSI driver and determine whether the LLP
problem exists for the platform-specific DW APB SSI controller.

-Sergey

