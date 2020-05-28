Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601371E6BC2
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 21:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406762AbgE1Txn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 15:53:43 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44018 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406687AbgE1Txm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 May 2020 15:53:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6A6A38030839;
        Thu, 28 May 2020 19:53:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NGsEWW3ofFNe; Thu, 28 May 2020 22:53:38 +0300 (MSK)
Date:   Thu, 28 May 2020 22:53:38 +0300
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
Subject: Re: [PATCH v3 09/10] dmaengine: dw: Introduce max burst length hw
 config
Message-ID: <20200528195338.yzl35nhogmyikv43@mobilestation>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-10-Sergey.Semin@baikalelectronics.ru>
 <20200528145224.GT1634618@smile.fi.intel.com>
 <20200528154022.3reghhjcd4dnsr3g@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200528154022.3reghhjcd4dnsr3g@mobilestation>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, May 28, 2020 at 06:40:22PM +0300, Serge Semin wrote:
> On Thu, May 28, 2020 at 05:52:24PM +0300, Andy Shevchenko wrote:
> > On Wed, May 27, 2020 at 01:50:20AM +0300, Serge Semin wrote:
> > > IP core of the DW DMA controller may be synthesized with different
> > > max burst length of the transfers per each channel. According to Synopsis
> > > having the fixed maximum burst transactions length may provide some
> > > performance gain. At the same time setting up the source and destination
> > > multi size exceeding the max burst length limitation may cause a serious
> > > problems. In our case the DMA transaction just hangs up. In order to fix
> > > this lets introduce the max burst length platform config of the DW DMA
> > > controller device and don't let the DMA channels configuration code
> > > exceed the burst length hardware limitation.
> > > 
> > > Note the maximum burst length parameter can be detected either in runtime
> > > from the DWC parameter registers or from the dedicated DT property.
> > > Depending on the IP core configuration the maximum value can vary from
> > > channel to channel so by overriding the channel slave max_burst capability
> > > we make sure a DMA consumer will get the channel-specific max burst
> > > length.
> > 
> > ...
> > 
> > >  static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> > >  {
> > > +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> > >  
> > 
> 
> > Perhaps,
> > 
> > 	/* DesignWare DMA supports burst value from 0 */
> > 	caps->min_burst = 0;
> 
> Regarding min_burst being zero. I don't fully understand what it means.
> It means no burst or burst with minimum length or what?
> In fact DW DMA burst length starts from 1. Remember the burst-length run-time
> parameter we were arguing about? Anyway the driver makes sure that both
> 0 and 1 requested burst length are setup as burst length of 1 in the
> CTLx.SRC_MSIZE, CTLx.DST_MSIZE fields.
> 
> I agree with the rest of your comments below.
> 
> -Sergey
> 
> > 

It would be also better to initialize the dw->dma.min_burst field instead
of setting caps->min_burst in the dwc_caps callback, since the min burst length
can't vary from channel to channel and it will be copied to the caps->min_burst
field anyway in the dma_get_slave_caps() method.

-Sergey
