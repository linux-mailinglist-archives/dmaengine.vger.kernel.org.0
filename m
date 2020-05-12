Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730CA1CF47F
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2020 14:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgELMfx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 May 2020 08:35:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:2792 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELMfx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 May 2020 08:35:53 -0400
IronPort-SDR: ZW9YklmNTR0YgwAp6NFA+PvUJVaiXkolqsMYXFZBVzYRyhHWLlBWg8UygSQoAHCY99oXsG8lqz
 Utwl3/DlxHCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 05:35:52 -0700
IronPort-SDR: LhFEIQ/w6qJjoAx9cR1EgbDS61a0cyLOb9Dv0WHWw9jPq/uobO/v5xW/xvgrKEOdoi800UDk0q
 hkj+aStjuSfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="251451800"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2020 05:35:49 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jYU8V-006Cdk-Rh; Tue, 12 May 2020 15:35:51 +0300
Date:   Tue, 12 May 2020 15:35:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dmaengine: dw: Set DMA device max segment size
 parameter
Message-ID: <20200512123551.GX185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-4-Sergey.Semin@baikalelectronics.ru>
 <20200508112152.GI185537@smile.fi.intel.com>
 <20200511211622.yuh3ls2ay76yaxrf@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511211622.yuh3ls2ay76yaxrf@mobilestation>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 12, 2020 at 12:16:22AM +0300, Serge Semin wrote:
> On Fri, May 08, 2020 at 02:21:52PM +0300, Andy Shevchenko wrote:
> > On Fri, May 08, 2020 at 01:53:01PM +0300, Serge Semin wrote:
> > > Maximum block size DW DMAC configuration corresponds to the max segment
> > > size DMA parameter in the DMA core subsystem notation. Lets set it with a
> > > value specific to the probed DW DMA controller. It shall help the DMA
> > > clients to create size-optimized SG-list items for the controller. This in
> > > turn will cause less dw_desc allocations, less LLP reinitializations,
> > > better DMA device performance.

> > Yeah, I have locally something like this and I didn't dare to upstream because
> > there is an issue. We have this information per DMA controller, while we
> > actually need this on per DMA channel basis.
> > 
> > Above will work only for synthesized DMA with all channels having same block
> > size. That's why above conditional is not needed anyway.
> 
> Hm, I don't really see why the conditional isn't needed and this won't work. As
> you can see in the loop above Initially I find a maximum of all channels maximum
> block sizes and use it then as a max segment size parameter for the whole device.
> If the DW DMA controller has the same max block size of all channels, then it
> will be found. If the channels've been synthesized with different block sizes,
> then the optimization will work for the one with greatest block size. The SG
> list entries of the channels with lesser max block size will be split up
> by the DW DMAC driver, which would have been done anyway without
> max_segment_size being set. Here we at least provide the optimization for the
> channels with greatest max block size.
> 
> I do understand that it would be good to have this parameter setup on per generic
> DMA channel descriptor basis. But DMA core and device descriptor doesn't provide
> such facility, so setting at least some justified value is a good idea.
> 
> > 
> > OTOH, I never saw the DesignWare DMA to be synthesized differently (I remember
> > that Intel Medfield has interesting settings, but I don't remember if DMA
> > channels are different inside the same controller).
> > 
> > Vineet, do you have any information that Synopsys customers synthesized DMA
> > controllers with different channel characteristics inside one DMA IP?
> 
> AFAICS the DW DMAC channels can be synthesized with different max block size.
> The IP core supports such configuration. So we can't assume that such DMAC
> release can't be found in a real hardware just because we've never seen one.
> No matter what Vineet will have to say in response to your question.

My point here that we probably can avoid complications till we have real
hardware where it's different. As I said I don't remember a such, except
*maybe* Intel Medfield, which is quite outdated and not supported for wider
audience anyway.

-- 
With Best Regards,
Andy Shevchenko


