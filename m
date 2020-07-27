Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F5022FAB9
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 22:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgG0Uzc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 16:55:32 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45668 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgG0Uzb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jul 2020 16:55:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 64C6B8030868;
        Mon, 27 Jul 2020 20:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3kM3i7w2TsUD; Mon, 27 Jul 2020 23:55:21 +0300 (MSK)
Date:   Mon, 27 Jul 2020 23:55:20 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 00/10] dmaengine: dw: Take Baikal-T1 SoC DW DMAC
 peculiarities into account
Message-ID: <20200727205520.kteltxy6gbho226q@mobilestation>
References: <20200723005848.31907-1-Sergey.Semin@baikalelectronics.ru>
 <20200727090114.GM12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200727090114.GM12965@vkoul-mobl>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jul 27, 2020 at 02:31:14PM +0530, Vinod Koul wrote:
> On 23-07-20, 03:58, Serge Semin wrote:
> > In the previous patchset I've written the next message:
> > 
> > > Folks, note I've removed the next patches from the series:
> > > [PATCH v7 04/11] dmaengine: Introduce max SG list entries capability
> > > [PATCH v7 11/11] dmaengine: dw: Initialize max_sg_nents capability
> > > It turns out the problem with the asynchronous handling of Tx- and Rx-
> > > SPI transfers interrupts is more complex than I expected. So in order to
> > > solve the problem it isn't enough to split the SG list entries submission
> > > up based on the max_sg_nents capability setting (though the synchronous
> > > one-by-one SG list entries handling does fix a part of the problem). So
> > > if and when I get to find a comprehensive solution for it I'll submit a
> > > new series with fixups. Until then please consider to merge the patchset
> > > in without those patches.
> > 
> > Those patches are returned back to the series. I've found a solution, which
> > fixes the problem for our hardware. A new patchset with several fixes for the
> > DW DMAC driver will be sent shortly after this one is merged in. Note the same
> > concerns the DW APB SPI driver. So please review and merge in as soon as
> > possible.
> > 
> > Regarding the patchset. Baikal-T1 SoC has an DW DMAC on-board to provide a
> > Mem-to-Mem, low-speed peripherals Dev-to-Mem and Mem-to-Dev functionality.
> > Mostly it's compatible with currently implemented in the kernel DW DMAC
> > driver, but there are some peculiarities which must be taken into account
> > in order to have the device fully supported.
> > 
> > First of all traditionally we replaced the legacy plain text-based dt-binding
> > file with yaml-based one. Secondly Baikal-T1 DW DMA Controller provides eight
> > channels, which alas have different max burst length configuration.
> > In particular first two channels may burst up to 128 bits (16 bytes) at a time
> > while the rest of them just up to 32 bits. We must make sure that the DMA
> > subsystem doesn't set values exceeding these limitations otherwise the
> > controller will hang up. In third currently we discovered the problem in using
> > the DW APB SPI driver together with DW DMAC. The problem happens if there is no
> > natively implemented multi-block LLP transfers support and the SPI-transfer
> > length exceeds the max lock size. In this case due to asynchronous handling of
> > Tx- and Rx- SPI transfers interrupt we might end up with DW APB SSI Rx FIFO
> > overflow. So if DW APB SSI (or any other DMAC service consumer) intends to use
> > the DMAC to asynchronously execute the transfers we'd have to at least warn
> > the user of the possible errors. In forth it's worth to set the DMA device max
> > segment size with max block size config specific to the DW DMA controller. It
> > shall help the DMA clients to create size-optimized SG-list items for the
> > controller. This in turn will cause less dw_desc allocations, less LLP
> > reinitializations, better DMA device performance.
> > 
> > Finally there is a bug in the algorithm of the nollp flag detection.
> > In particular even if DW DMAC parameters state the multi-block transfers
> > support there is still HC_LLP (hardcode LLP) flag, which if set makes expected
> > by the driver true multi-block LLP functionality unusable. This happens cause'
> > if HC_LLP flag is set the LLP registers will be hardcoded to zero so the
> > contiguous multi-block transfers will be only supported. We must take the
> > flag into account when detecting the LLP support otherwise the driver just
> > won't work correctly.
> 
> Applied all, thanks

Great! Thank you very much. Now I can send out another set of patches for
review.

-Sergey

> -- 
> ~Vinod
