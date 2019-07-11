Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9C657BC
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jul 2019 15:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfGKNMg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jul 2019 09:12:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:12567 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfGKNMf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 11 Jul 2019 09:12:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 06:12:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,478,1557212400"; 
   d="scan'208";a="186375427"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2019 06:12:33 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hlYsC-0006Wg-5J; Thu, 11 Jul 2019 16:12:32 +0300
Date:   Thu, 11 Jul 2019 16:12:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Ross Zwisler <zwisler@google.com>,
        Fletcher Woodruff <fletcherw@google.com>,
        dmaengine@vger.kernel.org,
        ALSA development <alsa-devel@alsa-project.org>,
        Pierre-louis Bossart <pierre-louis.bossart@intel.com>,
        Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: DW-DMA: Probe failures on broadwell
Message-ID: <20190711131232.GS9224@smile.fi.intel.com>
References: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
 <20190709131401.GA9224@smile.fi.intel.com>
 <20190709132943.GB9224@smile.fi.intel.com>
 <20190709133448.GC9224@smile.fi.intel.com>
 <20190709133847.GD9224@smile.fi.intel.com>
 <CAOReqxgnbDJsEcv7vdX3w44rzB=B69sHj95E8yBZ8DnZq0=63Q@mail.gmail.com>
 <20190710164346.GP9224@smile.fi.intel.com>
 <CAOReqxgnUp2tTp__YCjF_QH4166FAA1CE8Yq_VdE9jLW6Q4s3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOReqxgnUp2tTp__YCjF_QH4166FAA1CE8Yq_VdE9jLW6Q4s3A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jul 10, 2019 at 02:24:48PM -0700, Curtis Malainey wrote:
> On Wed, Jul 10, 2019 at 9:43 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Jul 09, 2019 at 12:27:49PM -0700, Curtis Malainey wrote:

> > > Thanks for the information, we are running a 4.14 kernel so we don't
> > > have the idma32 driver, I will see if I can backport it and report
> > > back if the fix works.
> >
> > Driver is supporting iDMA 32-bit in v4.14 AFAICS.
> > The missed stuff is a split and some fixes here and there.
> > Here is the list of patches I have in a range v4.14..v5.2
> > (I deliberately dropped the insignificant ones)
> >
> > 934891b0a16c dmaengine: dw: Don't pollute CTL_LO on iDMA 32-bit
> > 91f0ff883e9a dmaengine: dw: Reset DRAIN bit when resume the channel
> > 69da8be90d5e dmaengine: dw: Split DW and iDMA 32-bit operations
> > 87fe9ae84d7b dmaengine: dw: Add missed multi-block support for iDMA 32-bit
> > ffe843b18211 dmaengine: dw: Fix FIFO size for Intel Merrifield
> > 7b0c03ecc42f dmaengine: dw-dmac: implement dma protection control setting
> >
> > For me sounds like fairly easy to backport.
> >
> I got the code integrated, and ran some tests. The test device
> regularly hits a BUG_ON in the dw/core.c, debug is turned on in dw
> core

I see. We need ASoC guys to shed a light here. I don't know that part at all.

Only last suggestion I have is to try remove multi-block setting from the
platform data (it will be emulated in software if needed). But I don't believe
the DMA for audio has no such feature enabled.

> We have only been able to consistently reproduce the DMA boot issue on
> our original code consistently on 1 device and sporadically on another
> handful of devices.
> When the device did finally booted after 2-3 device crashes the device
> failed to load the DSP.

Yeah, it has something to do with this firmware loader code...

> [    3.709573] sst-acpi INT3438:00: DesignWare DMA Controller, 8 channels
> [    3.959027] haswell-pcm-audio haswell-pcm-audio: error: audio DSP
> boot timeout IPCD 0x0 IPCX 0x0
> [    3.970336] bdw-rt5677 bdw-rt5677: ASoC: failed to init link System PCM

-- 
With Best Regards,
Andy Shevchenko


