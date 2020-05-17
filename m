Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1351D1D6BB1
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2020 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgEQSWP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 May 2020 14:22:15 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42716 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgEQSWP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 17 May 2020 14:22:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 03DFB8030802;
        Sun, 17 May 2020 18:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xlnnS2shJqbh; Sun, 17 May 2020 21:22:11 +0300 (MSK)
Date:   Sun, 17 May 2020 21:22:10 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
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
Subject: Re: [PATCH v2 3/6] dmaengine: dw: Set DMA device max segment size
 parameter
Message-ID: <20200517182210.jxtsqbtf3pjogxpc@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-4-Sergey.Semin@baikalelectronics.ru>
 <20200508112152.GI185537@smile.fi.intel.com>
 <20200511211622.yuh3ls2ay76yaxrf@mobilestation>
 <20200512123551.GX185537@smile.fi.intel.com>
 <20200515061601.GG333670@vkoul-mobl>
 <20200515105313.GL185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515105313.GL185537@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 15, 2020 at 01:53:13PM +0300, Andy Shevchenko wrote:
> On Fri, May 15, 2020 at 11:46:01AM +0530, Vinod Koul wrote:
> > On 12-05-20, 15:35, Andy Shevchenko wrote:
> > > On Tue, May 12, 2020 at 12:16:22AM +0300, Serge Semin wrote:
> > > > On Fri, May 08, 2020 at 02:21:52PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, May 08, 2020 at 01:53:01PM +0300, Serge Semin wrote:
> 
> ...
> 
> > > My point here that we probably can avoid complications till we have real
> > > hardware where it's different. As I said I don't remember a such, except
> > > *maybe* Intel Medfield, which is quite outdated and not supported for wider
> > > audience anyway.
> > 
> > IIRC Intel Medfield has couple of dma controller instances each one with
> > different parameters *but* each instance has same channel configuration.
> 
> That's my memory too.
> 
> > I do not recall seeing that we have synthesis parameters per channel
> > basis... But I maybe wrong, it's been a while.
> 
> Exactly, that's why I think we better simplify things till we will have real
> issue with it. I.o.w. no need to solve the problem which doesn't exist.

Ok then. My hardware is also synthesized with uniform max block size
parameter. I'll remove that maximum of maximum search pattern and use the block
size found for the very first channel to set the maximum segment size parameter.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
