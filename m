Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A341E64E6
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403861AbgE1O4c (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 10:56:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:22928 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403856AbgE1O4b (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 May 2020 10:56:31 -0400
IronPort-SDR: Z+MLV+sAeMSBjmKCUUIEDqzmEl09hTjz+Z0QZtnqu+YHylte+gzYfQiM+xnTirh7RkZ236gJ7l
 GRSgux8OQoMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 07:56:30 -0700
IronPort-SDR: 9GMNO2dpZ8QHEws0zoKx0e5A/SnV4klKacWqjY2NfFml2EkkB8oynn2CAv6xDVVdBX+drSM/66
 3qbgPnlal6tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="267241338"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 07:56:27 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jeJxO-009Rcl-2C; Thu, 28 May 2020 17:56:30 +0300
Date:   Thu, 28 May 2020 17:56:30 +0300
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
Subject: Re: [PATCH v3 10/10] dmaengine: dw: Initialize max_sg_nents with
 nollp flag
Message-ID: <20200528145630.GV1634618@smile.fi.intel.com>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526225022.20405-11-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 27, 2020 at 01:50:21AM +0300, Serge Semin wrote:
> Multi-block support provides a way to map the kernel-specific SG-table so
> the DW DMA device would handle it as a whole instead of handling the
> SG-list items or so called LLP block items one by one. So if true LLP
> list isn't supported by the DW DMA engine, then soft-LLP mode will be
> utilized to load and execute each LLP-block one by one. The soft-LLP mode
> of the DMA transactions execution might not work well for some DMA
> consumers like SPI due to its Tx and Rx buffers inter-dependency. Let's
> expose the nollp flag indicating the soft-LLP mode by means of the
> max_sg_nents capability, so the DMA consumer would be ready to somehow
> workaround errors caused by such mode being utilized.
> 

In principal I agree, one nit below.
If you are okay with it, feel free to add my Rb tag.

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
>  drivers/dma/dw/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 29c4ef08311d..b850eb7fd084 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -1054,6 +1054,15 @@ static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
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

> +	caps->max_sg_nents = dwc->nollp;

To be on the safer side I would explicitly do it like

	if (dwc->nollp)
	 /* your nice comment */
	 = 1;
	else
	 /* Unlimited */
	 = 0;

type or content of nollp theoretically can be changed and this will affect maximum segments.

>  }
>  
>  int do_dma_probe(struct dw_dma_chip *chip)
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


