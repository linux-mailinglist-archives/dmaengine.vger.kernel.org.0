Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA69D1E7A95
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 12:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE2K3E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 06:29:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:16807 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2K3E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 May 2020 06:29:04 -0400
IronPort-SDR: EFzH7o0wuges6QVtt5x8A7BKLPh8X8WXtPk/23Z3pJRPCH5k/rfen6d848j8a18Tw+phSAfyub
 XaHAyhkO3IsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 03:29:03 -0700
IronPort-SDR: QoDuHZIcRNcEeyPBM2Imhg3vvdp8Kjl7xFXEs43IFFDtjFw5g0/eq4A+qycEMoeCQ387eyXBE2
 chOYW/7X4Shw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="303088339"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 29 May 2020 03:28:59 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jecG6-009asP-Q4; Fri, 29 May 2020 13:29:02 +0300
Date:   Fri, 29 May 2020 13:29:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] dmaengine: dw: Initialize min_burst capability
Message-ID: <20200529102902.GG1634618@smile.fi.intel.com>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
 <20200528222401.26941-10-Sergey.Semin@baikalelectronics.ru>
 <20200529102515.GD1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529102515.GD1634618@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 29, 2020 at 01:25:15PM +0300, Andy Shevchenko wrote:
> On Fri, May 29, 2020 at 01:23:59AM +0300, Serge Semin wrote:
> > According to the DW APB DMAC data book the minimum burst transaction
> > length is 1 and it's true for any version of the controller since
> > isn't parametrised in the coreAssembler so can't be changed at the
> > IP-core synthesis stage. Let's initialise the min_burst member of the
> > DMA controller descriptor so the DMA clients could use it to properly
> > optimize the DMA requests.

...

> >  	/* DMA capabilities */
> 
> > +	dw->dma.min_burst = 1;
> 
> Perhaps then relaxed maximum, like
> 
> 	dw->dma.max_burst = 256;
> 
> (channels will update this)
> 
> ?

And forgot to mention that perhaps we need a definitions for both.

> >  	dw->dma.src_addr_widths = DW_DMA_BUSWIDTHS;
> >  	dw->dma.dst_addr_widths = DW_DMA_BUSWIDTHS;

-- 
With Best Regards,
Andy Shevchenko


