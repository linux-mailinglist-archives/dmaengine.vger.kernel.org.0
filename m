Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5708A63714
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jul 2019 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGINiv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jul 2019 09:38:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:63518 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfGINiv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jul 2019 09:38:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 06:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="167986828"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga003.jf.intel.com with ESMTP; 09 Jul 2019 06:38:48 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hkqKV-0003sq-Fd; Tue, 09 Jul 2019 16:38:47 +0300
Date:   Tue, 9 Jul 2019 16:38:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Ross Zwisler <zwisler@google.com>,
        Fletcher Woodruff <fletcherw@google.com>,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        Pierre-louis Bossart <pierre-louis.bossart@intel.com>,
        Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: DW-DMA: Probe failures on broadwell
Message-ID: <20190709133847.GD9224@smile.fi.intel.com>
References: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
 <20190709131401.GA9224@smile.fi.intel.com>
 <20190709132943.GB9224@smile.fi.intel.com>
 <20190709133448.GC9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709133448.GC9224@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 09, 2019 at 04:34:48PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 09, 2019 at 04:29:43PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 09, 2019 at 04:14:01PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 08, 2019 at 01:50:07PM -0700, Curtis Malainey wrote:
> > 
> > > So, the correct fix is to provide a platform data, like it's done in
> > > drivers/dma/dw/pci.c::idma32_pdata, in the sst-firmware.c::dw_probe(), and call
> > > idma32_dma_probe() with idma32_dma_remove() respectively on removal stage.
> > > 
> > > (It will require latest patches to be applied, which are material for v5.x)
> > 
> > Below completely untested patch to try
> 
> Also, it might require to set proper request lines (currently it uses 0 AFAICS).
> Something like it's done in drivers/spi/spi-pxa2xx-pci.c for Intel Merrifield.

And SST_DSP_DMA_MAX_BURST seems encoded while it's should be simple number,
like 8 (bytes). Also SPI PXA is an example to look into.

I doubt it has been validated with upstream driver (I know about some internal
drivers, hacked version of dw one, you may find sources somewhere in public).

-- 
With Best Regards,
Andy Shevchenko


