Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7855E63692
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jul 2019 15:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfGINOF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Jul 2019 09:14:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:46968 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfGINOF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Jul 2019 09:14:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 06:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="340748003"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga005.jf.intel.com with ESMTP; 09 Jul 2019 06:14:03 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hkpwX-0003bi-Sy; Tue, 09 Jul 2019 16:14:01 +0300
Date:   Tue, 9 Jul 2019 16:14:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Ross Zwisler <zwisler@google.com>,
        Fletcher Woodruff <fletcherw@google.com>,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        Pierre-louis Bossart <pierre-louis.bossart@intel.com>,
        Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: DW-DMA: Probe failures on broadwell
Message-ID: <20190709131401.GA9224@smile.fi.intel.com>
References: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

(I think this is okay to go on public here)
+Cc: Pierre, Liam, DMA Engine ML, ASoC ML

On Mon, Jul 08, 2019 at 01:50:07PM -0700, Curtis Malainey wrote:
> Hello Andy,
> 
> I am reaching out to you as you are the main author for
> drivers/dma/dw/core.c and we are seeing a failure in there on some of
> our samus devices. On certain device we are seeing the following
> failure (debugging enabled in this log.)
> 
> [    3.587515] sst-acpi INT3438:00: DW_PARAMS: 0x00000000

AFAIK, when Synopsys DesignWare DMA IP is in use in Intel, we almost always
(yes, I know couple of exceptions), enable auto configuration block. Thus, the
*private* DMA controllers used in Broadwell are actually Intel iDMA 32-bit.
Nowadays the differences can be seen in drivers/dma/dw/idma32.c.

Note, DMA in the driver is used solely for firmware load, simplest workaround
is to disable DMA. Though, personally, for sake of test coverage, I would like
to see how it works in DMA case.

> [    3.587519] haswell-pcm-audio haswell-pcm-audio: error: DMA device
> register failed
> [    3.587524] haswell-pcm-audio haswell-pcm-audio: sst_dma_new failed -22
> [    3.598010] bdw-rt5677 bdw-rt5677: ASoC: failed to init link System PCM
> 
> I don't have the datasheets for this component but I am wondering if
> you could help us troubleshoot this bug it would be greatly
> appreciated if possible. I am not sure if we are seeing a hardware
> boot failure or a boot race. I was hoping you could shed some light on
> this and if it is a boot race help us recover from it. I know Intel
> relies on no defers typically but it would be nice to see if we can
> fix this. Below is where I have traced the error source to in core.c.

So, the correct fix is to provide a platform data, like it's done in
drivers/dma/dw/pci.c::idma32_pdata, in the sst-firmware.c::dw_probe(), and call
idma32_dma_probe() with idma32_dma_remove() respectively on removal stage.

(It will require latest patches to be applied, which are material for v5.x)

>                  dw_params = dma_readl(dw, DW_PARAMS);
>                  dev_dbg(chip->dev, "DW_PARAMS: 0x%08x\n", dw_params);
> 
>                  autocfg = dw_params >> DW_PARAMS_EN & 1;
>                  if (!autocfg) {
>                          err = -EINVAL;
>                          goto err_pdata;
>                  }
> Let me know if you have any ideas on how to mitigate this, thanks.

-- 
With Best Regards,
Andy Shevchenko


