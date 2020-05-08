Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B265E1CB7E7
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 21:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHTGY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 15:06:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:1210 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbgEHTGY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 8 May 2020 15:06:24 -0400
IronPort-SDR: v2gjK4RKVJ1v/sdovzL2O+wNylxbADOvG7CwVQ2mYCdz9xLJxz/HixotXkwpwCZ+kmPH0d16Cx
 1FbYJHrKB4gw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:06:23 -0700
IronPort-SDR: nTJv2Ub7B7vBvOk28P4x1cVdUZbPUuOksDDQNy7s9MtBirBS8RvT9K4KcLsZoqahFtSTTuVdmk
 9Xl7ImcTOcnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,368,1583222400"; 
   d="scan'208";a="462687274"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2020 12:06:19 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX8KE-005Sw7-9j; Fri, 08 May 2020 22:06:22 +0300
Date:   Fri, 8 May 2020 22:06:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is
 unsupported
Message-ID: <20200508190622.GQ185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508115334.GE4820@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 08, 2020 at 12:53:34PM +0100, Mark Brown wrote:
> On Fri, May 08, 2020 at 02:26:04PM +0300, Andy Shevchenko wrote:
> > On Fri, May 08, 2020 at 01:53:02PM +0300, Serge Semin wrote:
> 
> > > Multi-block support provides a way to map the kernel-specific SG-table so
> > > the DW DMA device would handle it as a whole instead of handling the
> > > SG-list items or so called LLP block items one by one. So if true LLP
> > > list isn't supported by the DW DMA engine, then soft-LLP mode will be
> > > utilized to load and execute each LLP-block one by one. A problem may
> > > happen for multi-block DMA slave transfers, when the slave device buffers
> > > (for example Tx and Rx FIFOs) depend on each other and have size smaller
> > > than the block size. In this case writing data to the DMA slave Tx buffer
> > > may cause the Rx buffer overflow if Rx DMA channel is paused to
> > > reinitialize the DW DMA controller with a next Rx LLP item. In particular
> > > We've discovered this problem in the framework of the DW APB SPI device
> 
> > Mark, do we have any adjustment knobs in SPI core to cope with this?
> 
> Frankly I'm not sure I follow what the issue is - is an LLP block item
> different from a SG list entry?  As far as I can tell the problem is
> that the DMA controller does not support chaining transactions together
> and possibly also has a limit on the transfer size?  Or possibly some
> issue with the DMA controller locking the CPU out of the I/O bus for
> noticable periods?  I can't really think what we could do about that if
> the issue is transfer sizes, that just seems like hardware which is
> never going to work reliably.  If the issue is not being able to chain
> transfers then possibly an option to linearize messages into a single
> transfer as suggested to cope with PIO devices with ill considered
> automated chip select handling, though at some point you have to worry
> about the cost of the memcpy() vs the cost of just doing PIO.

My understanding that the programmed transfers (as separate items in SG list)
can be desynchronized due to LLP emulation in DMA driver. And suggestion
probably is to use only single entry (block) SG lists will do the trick (I
guess that we can configure SPI core do or do not change CS between them).

> > > working in conjunction with DW DMA. Since there is no comprehensive way to
> > > fix it right now lets at least print a warning for the first found
> > > multi-blockless DW DMAC channel. This shall point a developer to the
> > > possible cause of the problem if one would experience a sudden data loss.
> 
> I thought from the description of the SPI driver I just reviewed that
> this hardware didn't have DMA?  Or are there separate blocks in the
> hardware that have a more standard instantiation of the DesignWare SPI
> controller with DMA attached?

I speculate that the right words there should be 'we don't enable DMA right now
due to some issues' (see above).

-- 
With Best Regards,
Andy Shevchenko


