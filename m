Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C81E7A8F
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 12:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgE2K2A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 06:28:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:15738 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgE2K17 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 May 2020 06:27:59 -0400
IronPort-SDR: Th5axlvECwaus3KrcUvre21AaF+RuirgxClLXOJr9ujYDRmFNUK+JIKehilj54ZNuWs+y9R7cP
 IO2UAbYW2D4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 03:27:58 -0700
IronPort-SDR: yZWHEw6N3fJYIYszgq50Qzdz+p+4/7Wkrc+snophAHAc6hs9QifNQ+SJ6whwaHMfnngErhuYUu
 vrdcVzxbUVrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="469462825"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 29 May 2020 03:27:55 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jecF4-009ars-OL; Fri, 29 May 2020 13:27:58 +0300
Date:   Fri, 29 May 2020 13:27:58 +0300
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
Subject: Re: [PATCH v4 11/11] dmaengine: dw: Initialize max_sg_nents
 capability
Message-ID: <20200529102758.GF1634618@smile.fi.intel.com>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
 <20200528222401.26941-12-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528222401.26941-12-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 29, 2020 at 01:24:01AM +0300, Serge Semin wrote:
> Multi-block support provides a way to map the kernel-specific SG-table so
> the DW DMA device would handle it as a whole instead of handling the
> SG-list items or so called LLP block items one by one. So if true LLP
> list isn't supported by the DW DMA engine, then soft-LLP mode will be
> utilized to load and execute each LLP-block one by one. The soft-LLP mode
> of the DMA transactions execution might not work well for some DMA
> consumers like SPI due to its Tx and Rx buffers inter-dependency. Let's
> initialize the max_sg_nents DMA channels capability based on the nollp
> flag state. If it's true, no hardware accelerated LLP is available and
> max_sg_nents should be set with 1, which means that the DMA engine
> can handle only a single SG list entry at a time. If noLLP is set to
> false, then hardware accelerated LLP is supported and the DMA engine
> can handle infinite number of SG entries in a single DMA transaction.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
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
> 
> Changelog v4:
> - Use explicit if-else statement when assigning the max_sg_nents field.
> ---
>  drivers/dma/dw/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 60ef779fc5e0..b76eee75fde8 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -1059,6 +1059,18 @@ static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
>  
>  	caps->max_burst = dwc->max_burst;
> +
> +	/*
> +	 * It might be crucial for some devices to have the hardware
> +	 * accelerated multi-block transfers supported, aka LLPs in DW DMAC
> +	 * notation. So if LLPs are supported then max_sg_nents is set to
> +	 * zero which means unlimited number of SG entries can be handled in a
> +	 * single DMA transaction, otherwise it's just one SG entry.
> +	 */
> +	if (dwc->nollp)
> +		caps->max_sg_nents = 1;
> +	else
> +		caps->max_sg_nents = 0;
>  }
>  
>  int do_dma_probe(struct dw_dma_chip *chip)
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


