Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B66117EB79
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2020 22:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgCIVql (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Mar 2020 17:46:41 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43830 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVql (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Mar 2020 17:46:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8150B803087C;
        Mon,  9 Mar 2020 21:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EgbOXeQlax4M; Tue, 10 Mar 2020 00:46:35 +0300 (MSK)
Date:   Tue, 10 Mar 2020 00:45:38 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] dmaengine: dw: Take Baikal-T1 SoC DW DMAC
 peculiarities into account
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200306132912.GA1748204@smile.fi.intel.com>
 <20200306133035.GB1748204@smile.fi.intel.com>
 <20200306135050.40094803087C@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200306135050.40094803087C@mail.baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200309214636.8150B803087C@mail.baikalelectronics.ru>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 06, 2020 at 07:13:12PM +0530, Vinod Koul wrote:
> On 06-03-20, 15:30, Andy Shevchenko wrote:
> > On Fri, Mar 06, 2020 at 03:29:12PM +0200, Andy Shevchenko wrote:
> > > On Fri, Mar 06, 2020 at 04:10:29PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > > From: Serge Semin <fancer.lancer@gmail.com>
> > > > 
> > > > Baikal-T1 SoC has an DW DMAC on-board to provide a Mem-to-Mem, low-speed
> > > > peripherals Dev-to-Mem and Mem-to-Dev functionality. Mostly it's compatible
> > > > with currently implemented in the kernel DW DMAC driver, but there are some
> > > > peculiarities which must be taken into account in order to have the device
> > > > fully supported.
> > > > 
> > > > First of all traditionally we replaced the legacy plain text-based dt-binding
> > > > file with yaml-based one. Secondly Baikal-T1 DW DMA Controller provides eight
> > > > channels, which alas have different max burst length configuration.
> > > > In particular first two channels may burst up to 128 bits (16 bytes) at a time
> > > > while the rest of them just up to 32 bits. We must make sure that the DMA
> > > > subsystem doesn't set values exceeding these limitations otherwise the
> > > > controller will hang up. In third currently we discovered the problem in using
> > > > the DW APB SPI driver together with DW DMAC. The problem happens if there is no
> > > > natively implemented multi-block LLP transfers support and the SPI-transfer
> > > > length exceeds the max lock size. In this case due to asynchronous handling of
> > > > Tx- and Rx- SPI transfers interrupt we might end up with Dw APB SSI Rx FIFO
> > > > overflow. So if DW APB SSI (or any other DMAC service consumer) intends to use
> > > > the DMAC to asynchronously execute the transfers we'd have to at least warn
> > > > the user of the possible errors.
> > > > 
> > > > Finally there is a bug in the algorithm of the nollp flag detection.
> > > > In particular even if DW DMAC parameters state the multi-block transfers
> > > > support there is still HC_LLP (hardcode LLP) flag, which if set makes expected
> > > > by the driver true multi-block LLP functionality unusable. This happens cause'
> > > > if HC_LLP flag is set the LLP registers will be hardcoded to zero so the
> > > > contiguous multi-block transfers will be only supported. We must take the
> > > > flag into account when detecting the LLP support otherwise the driver just
> > > > won't work correctly.
> > > > 
> > > > This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> > > > commit 98d54f81e36b ("Linux 5.6-rc4").
> > > 
> > > Thank you for your series!
> > > 
> > > I'll definitely review it, but it will take time. So, I think due to late
> > > submission this is material at least for v5.8.
> > 
> > One thing that I can tell immediately is the broken email thread in this series.
> > Whenever you do a series, use `git format-patch --cover-letter --thread ...`,
> > so, it will link the mail properly.
> 
> And all the dmaengine specific patches should be sent to dmaengine list,
> I see only few of them on the list.. that confuses tools like
> patchwork..
> 
> Pls fix these and resubmit
> 

Folks. I've found out what was wrong with the emails threading. As I
said my gitconfig had the next settings set: chainreplyto = false,
thread = true. So the emails should have been formatted as expected by
the requirements. And they were on my emails client side, so I didn't see
the problem you've got.

It wasn't a first time I was submitting patches to the kernel, but it was
a first time of me using the corporate exchange server for it. It turned out
the damn server changed the Message-Id field of the emails header on the
way of transmitting the messages. If you take a look at the non-cover-letter
emails you've got from me you'll see that they actually have the In-Reply-To
and References fields with Id's referring to the original Message-Id. After
our system administrator fixes that problem and we come up with solutions
for the issues you've found in the patches I'll definitely resend the
patchset. This time I'll also make sure the emailing lists are also included
in Cc. Sorry for the inconvenience.

Regards,
-Sergey

> Thanks
> -- 
> ~Vinod
