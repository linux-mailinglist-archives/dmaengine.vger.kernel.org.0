Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A651D6C6F
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2020 21:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgEQTiX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 May 2020 15:38:23 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:42970 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTiX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 17 May 2020 15:38:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1DB718030808;
        Sun, 17 May 2020 19:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fJXvaHVVcPHl; Sun, 17 May 2020 22:38:19 +0300 (MSK)
Date:   Sun, 17 May 2020 22:38:18 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH v2 5/6] dmaengine: dw: Introduce max burst length hw
 config
Message-ID: <20200517193818.jaiwgzgz7tutj4mk@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-6-Sergey.Semin@baikalelectronics.ru>
 <20200508114153.GK185537@smile.fi.intel.com>
 <20200512140820.ssjv6pl7busqqi3t@mobilestation>
 <20200512191208.GG185537@smile.fi.intel.com>
 <20200515063950.GI333670@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515063950.GI333670@vkoul-mobl>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 15, 2020 at 12:09:50PM +0530, Vinod Koul wrote:
> On 12-05-20, 22:12, Andy Shevchenko wrote:
> > On Tue, May 12, 2020 at 05:08:20PM +0300, Serge Semin wrote:
> > > On Fri, May 08, 2020 at 02:41:53PM +0300, Andy Shevchenko wrote:
> > > > On Fri, May 08, 2020 at 01:53:03PM +0300, Serge Semin wrote:
> > > > > IP core of the DW DMA controller may be synthesized with different
> > > > > max burst length of the transfers per each channel. According to Synopsis
> > > > > having the fixed maximum burst transactions length may provide some
> > > > > performance gain. At the same time setting up the source and destination
> > > > > multi size exceeding the max burst length limitation may cause a serious
> > > > > problems. In our case the system just hangs up. In order to fix this
> > > > > lets introduce the max burst length platform config of the DW DMA
> > > > > controller device and don't let the DMA channels configuration code
> > > > > exceed the burst length hardware limitation. Depending on the IP core
> > > > > configuration the maximum value can vary from channel to channel.
> > > > > It can be detected either in runtime from the DWC parameter registers
> > > > > or from the dedicated dts property.
> > > > 
> > > > I'm wondering what can be the scenario when your peripheral will ask something
> > > > which is not supported by DMA controller?
> > > 
> > > I may misunderstood your statement, because seeing your activity around my
> > > patchsets including the SPI patchset and sometimes very helpful comments,
> > > this question answer seems too obvious to see you asking it.
> > > 
> > > No need to go far for an example. See the DW APB SSI driver. Its DMA module
> > > specifies the burst length to be 16, while not all of ours channels supports it.
> > > Yes, originally it has been developed for the Intel Midfield SPI, but since I
> > > converted the driver into a generic code we can't use a fixed value. For instance
> > > in our hardware only two DMA channels of total 16 are capable of bursting up to
> > > 16 bytes (data items) at a time, the rest of them are limited with up to 4 bytes
> > > burst length. While there are two SPI interfaces, each of which need to have two
> > > DMA channels for communications. So I need four channels in total to allocate to
> > > provide the DMA capability for all interfaces. In order to set the SPI controller
> > > up with valid optimized parameters the max-burst-length is required. Otherwise we
> > > can end up with buffers overrun/underrun.
> > 
> > Right, and we come to the question which channel better to be used by SPI and
> > the rest devices. Without specific filter function you can easily get into a
> > case of inverted optimizations, when SPI got channels with burst = 4, while
> > it's needed 16, and other hardware otherwise. Performance wise it's worse
> > scenario which we may avoid in the first place, right?
> 
> If one has channels which are different and described as such in DT,
> then I think it does make sense to specify in your board-dt about the
> specific channels you would require...

Well, we do have such hardware. Our DW DMA controller has got different max
burst lengths assigned to first two and the rest of the channels. But creating
a functionality of the individual channels assignment is a matter of different
patchset. Sorry. It's not one of my task at the moment.

My primary task is to integrate the Baikal-T1 SoC support into the kernel. I've
refactored a lot of code found in the Baikal-T1 SDK and currently under a pressure
of a lot of review. Alas there is no time to create new functionality as you
suggest. In future I may provide such, but not in the framework of this patchset.

> > 
> > > > Peripheral needs to supply a lot of configuration parameters specific to the
> > > > DMA controller in use (that's why we have struct dw_dma_slave).
> > > > So, seems to me the feasible approach is supply correct data in the first place.
> > > 
> > > How to supply a valid data if clients don't know the DMA controller limitations
> > > in general?
> > 
> > This is a good question. DMA controllers are quite different and having unified
> > capabilities structure for all is almost impossible task to fulfil. That's why
> > custom filter function(s) can help here. Based on compatible string you can
> > implement whatever customized quirks like two functions, for example, to try 16
> > burst size first and fallback to 4 if none was previously found.
> > 
> > > > If you have specific channels to acquire then you probably need to provide a
> > > > custom xlate / filter functions. Because above seems a bit hackish workaround
> > > > of dynamic channel allocation mechanism.
> > > 
> > > No, I don't have a specific channel to acquire and in general you may use any
> > > returned from the DMA subsystem (though some platforms may need a dedicated
> > > channels to use, in this case xlate / filter is required). In our SoC any DW DMAC
> > > channel can be used for any DMA-capable peripherals like SPI, I2C, UART. But the
> > > their DMA settings must properly and optimally configured. It can be only done
> > > if you know the DMA controller parameters like max burst length, max block-size,
> > > etc.
> > > 
> > > So no. The change proposed by this patch isn't workaround, but a useful feature,
> > > moreover expected to be supported by the generic DMA subsystem.
> > 
> > See above.
> > 
> > > > But let's see what we can do better. Since maximum is defined on the slave side
> > > > device, it probably needs to define minimum as well, otherwise it's possible
> > > > that some hardware can't cope underrun bursts.
> > > 
> > > There is no need to define minimum if such limit doesn't exists except a
> > > natural 1. Moreover it doesn't exist for all DMA controllers seeing noone has
> > > added such capability into the generic DMA subsystem so far.
> > 
> > There is a contract between provider and consumer about DMA resource. That's
> > why both sides should participate in fulfilling it. Theoretically it may be a
> > hardware that doesn't support minimum burst available in DMA by a reason. For
> > such we would need minimum to be provided as well.
> 
> Agreed and if required caps should be extended to tell consumer the
> minimum values supported.

Sorry, it's not required by our hardware. Is there any, which actually has such
limitation? (minimum burst length)

-Sergey

> 
> -- 
> ~Vinod
