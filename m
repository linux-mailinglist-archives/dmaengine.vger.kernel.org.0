Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C4717BF63
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2020 14:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFNnR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Mar 2020 08:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgCFNnR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Mar 2020 08:43:17 -0500
Received: from localhost (unknown [122.178.250.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F742072D;
        Fri,  6 Mar 2020 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583502196;
        bh=/FRMCH/2Aozcr11mGr2dYvfp97yiKC9ojfj5aDNFTnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLWyJmosr/DjDVlSdDo65STseH2BUvxWVhqdL7ieiMMtJeV6Pyi/eJYnw4rL53/i5
         qFTqPgN75HOPJks/FX1ubsDa9yypYdkP1sH5K4WkPJkUIXMWZ+MJkWLdPIw5LjOYZB
         rkIVOSPF6B40CIqtKncdAi2tqAyBhJlNg5vcoRfA=
Date:   Fri, 6 Mar 2020 19:13:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey.Semin@baikalelectronics.ru,
        Serge Semin <fancer.lancer@gmail.com>,
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
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] dmaengine: dw: Take Baikal-T1 SoC DW DMAC
 peculiarities into account
Message-ID: <20200306134312.GK4148@vkoul-mobl>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200306132912.GA1748204@smile.fi.intel.com>
 <20200306133035.GB1748204@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306133035.GB1748204@smile.fi.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-03-20, 15:30, Andy Shevchenko wrote:
> On Fri, Mar 06, 2020 at 03:29:12PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 06, 2020 at 04:10:29PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > From: Serge Semin <fancer.lancer@gmail.com>
> > > 
> > > Baikal-T1 SoC has an DW DMAC on-board to provide a Mem-to-Mem, low-speed
> > > peripherals Dev-to-Mem and Mem-to-Dev functionality. Mostly it's compatible
> > > with currently implemented in the kernel DW DMAC driver, but there are some
> > > peculiarities which must be taken into account in order to have the device
> > > fully supported.
> > > 
> > > First of all traditionally we replaced the legacy plain text-based dt-binding
> > > file with yaml-based one. Secondly Baikal-T1 DW DMA Controller provides eight
> > > channels, which alas have different max burst length configuration.
> > > In particular first two channels may burst up to 128 bits (16 bytes) at a time
> > > while the rest of them just up to 32 bits. We must make sure that the DMA
> > > subsystem doesn't set values exceeding these limitations otherwise the
> > > controller will hang up. In third currently we discovered the problem in using
> > > the DW APB SPI driver together with DW DMAC. The problem happens if there is no
> > > natively implemented multi-block LLP transfers support and the SPI-transfer
> > > length exceeds the max lock size. In this case due to asynchronous handling of
> > > Tx- and Rx- SPI transfers interrupt we might end up with Dw APB SSI Rx FIFO
> > > overflow. So if DW APB SSI (or any other DMAC service consumer) intends to use
> > > the DMAC to asynchronously execute the transfers we'd have to at least warn
> > > the user of the possible errors.
> > > 
> > > Finally there is a bug in the algorithm of the nollp flag detection.
> > > In particular even if DW DMAC parameters state the multi-block transfers
> > > support there is still HC_LLP (hardcode LLP) flag, which if set makes expected
> > > by the driver true multi-block LLP functionality unusable. This happens cause'
> > > if HC_LLP flag is set the LLP registers will be hardcoded to zero so the
> > > contiguous multi-block transfers will be only supported. We must take the
> > > flag into account when detecting the LLP support otherwise the driver just
> > > won't work correctly.
> > > 
> > > This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> > > commit 98d54f81e36b ("Linux 5.6-rc4").
> > 
> > Thank you for your series!
> > 
> > I'll definitely review it, but it will take time. So, I think due to late
> > submission this is material at least for v5.8.
> 
> One thing that I can tell immediately is the broken email thread in this series.
> Whenever you do a series, use `git format-patch --cover-letter --thread ...`,
> so, it will link the mail properly.

And all the dmaengine specific patches should be sent to dmaengine list,
I see only few of them on the list.. that confuses tools like
patchwork..

Pls fix these and resubmit

Thanks
-- 
~Vinod
