Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACD11CDB9D
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 15:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgEKNpH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 09:45:07 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:49194 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbgEKNpG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 09:45:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id EC8F08030807;
        Mon, 11 May 2020 13:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b5TYIIyRMs46; Mon, 11 May 2020 16:45:03 +0300 (MSK)
Date:   Mon, 11 May 2020 16:45:02 +0300
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
Message-ID: <20200511134502.hjbu5evkiuh75chr@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
 <20200511021016.wptcgnc3iq3kadgz@mobilestation>
 <20200511115813.GG8216@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200511115813.GG8216@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 11, 2020 at 12:58:13PM +0100, Mark Brown wrote:
> On Mon, May 11, 2020 at 05:10:16AM +0300, Serge Semin wrote:
> 
> > Alas linearizing the SPI messages won't help in this case because the DW DMA
> > driver will split it into the max transaction chunks anyway.
> 
> That sounds like you need to also impose a limit on the maximum message
> size as well then, with that you should be able to handle messages up
> to whatever that limit is.  There's code for that bit already, so long
> as the limit is not too low it should be fine for most devices and
> client drivers can see the limit so they can be updated to work with it
> if needed.

Hmm, this might work. The problem will be with imposing such limitation through
the DW APB SSI driver. In order to do this I need to know:
1) Whether multi-block LLP is supported by the DW DMA controller.
2) Maximum DW DMA transfer block size.
Then I'll be able to use this information in the can_dma() callback to enable
the DMA xfers only for the safe transfers. Did you mean something like this when
you said "There's code for that bit already" ? If you meant the max_dma_len
parameter, then setting it won't work, because it just limits the SG items size
not the total length of a single transfer.

So the question is of how to export the multi-block LLP flag from DW DMAc
driver. Andy?

-Sergey

