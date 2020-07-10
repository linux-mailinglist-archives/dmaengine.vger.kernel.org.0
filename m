Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2613121B1AE
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2020 10:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGJIvc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jul 2020 04:51:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:47336 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbgGJIv0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 10 Jul 2020 04:51:26 -0400
IronPort-SDR: e4uxyLUHGTEZnMEV/m8M8lKo7ocxaM+f+jHqiRpR025GltuEx22FJM58hLMzb37XWU/JtLqk7T
 lO+b8Dr/AuHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="146240806"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="146240806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 01:51:25 -0700
IronPort-SDR: LfnhsBzxBWY8tqtpOAFIpp4omzBPhlDDYPvGoaq55B3GhQW54uSzRM82CGAHOdwQ2stvXjmjP5
 rAJiHPvmo/RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="389432771"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2020 01:51:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtokd-0011Rj-Fp; Fri, 10 Jul 2020 11:51:23 +0300
Date:   Fri, 10 Jul 2020 11:51:23 +0300
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
Subject: Re: [PATCH v7 08/11] dmaengine: dw: Add dummy device_caps callback
Message-ID: <20200710085123.GF3703480@smile.fi.intel.com>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-9-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709224550.15539-9-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 10, 2020 at 01:45:47AM +0300, Serge Semin wrote:
> Since some DW DMA controllers (like one installed on Baikal-T1 SoC) may
> have non-uniform DMA capabilities per device channels, let's add
> the DW DMA specific device_caps callback to expose that specifics up to
> the DMA consumer. It's a dummy function for now. We'll fill it in with
> capabilities overrides in the next commits.

Just a reminder (mainly to Vinod) of my view to this.
Unneeded churn, should be folded to patch 9.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> ---
> 
> Changelog v3:
> - This is a new patch created as a result of the discussion with Vinud and
>   Andy in the framework of DW DMA burst and LLP capabilities.
> ---
>  drivers/dma/dw/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index fb95920c429e..ceded21537e2 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -1049,6 +1049,11 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
>  }
>  
> +static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> +{
> +
> +}
> +
>  int do_dma_probe(struct dw_dma_chip *chip)
>  {
>  	struct dw_dma *dw = chip->dw;
> @@ -1214,6 +1219,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
>  	dw->dma.device_prep_dma_memcpy = dwc_prep_dma_memcpy;
>  	dw->dma.device_prep_slave_sg = dwc_prep_slave_sg;
>  
> +	dw->dma.device_caps = dwc_caps;
>  	dw->dma.device_config = dwc_config;
>  	dw->dma.device_pause = dwc_pause;
>  	dw->dma.device_resume = dwc_resume;
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


