Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02631E7CFF
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 14:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgE2MSY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 08:18:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:4728 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgE2MSX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 May 2020 08:18:23 -0400
IronPort-SDR: g/eol5Kn3FH9Zo0r+x5mrU+uTQeFz5kVCGcWY5ZDeOojLidn0JmZnHSP0XbEM3X8VgpxnBXwnA
 qARnsh9NG7Ug==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 05:18:23 -0700
IronPort-SDR: hX2vL5BHGCPgXcr2CNZzqZ8CRI5ywY6AXsMJKzA2olNvZBRNC69AsxEgyBomqb8+9mgQXdGivx
 IjhlNq7pSxgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="285516296"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 29 May 2020 05:18:20 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jedxu-009c1I-TY; Fri, 29 May 2020 15:18:22 +0300
Date:   Fri, 29 May 2020 15:18:22 +0300
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
Subject: Re: [PATCH v4 07/11] dmaengine: dw: Set DMA device max segment size
 parameter
Message-ID: <20200529121822.GL1634618@smile.fi.intel.com>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
 <20200528222401.26941-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528222401.26941-8-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 29, 2020 at 01:23:57AM +0300, Serge Semin wrote:
> Maximum block size DW DMAC configuration corresponds to the max segment
> size DMA parameter in the DMA core subsystem notation. Lets set it with a
> value specific to the probed DW DMA controller. It shall help the DMA
> clients to create size-optimized SG-list items for the controller. This in
> turn will cause less dw_desc allocations, less LLP reinitializations,
> better DMA device performance.

Yes, something like that for time being, thanks!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
> Changelog v2:
> - This is a new patch created in place of the dropped one:
>   "dmaengine: dw: Add LLP and block size config accessors".
> 
> Changelog v3:
> - Use the block_size found for the very first channel instead of looking for
>   the maximum of maximum block sizes.
> - Don't define device-specific device_dma_parameters object, since it has
>   already been defined by the platform device core.
> ---
>  drivers/dma/dw/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 33e99d95b3d3..fb95920c429e 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -1229,6 +1229,13 @@ int do_dma_probe(struct dw_dma_chip *chip)
>  			     BIT(DMA_MEM_TO_MEM);
>  	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>  
> +	/*
> +	 * For now there is no hardware with non uniform maximum block size
> +	 * across all of the device channels, so we set the maximum segment
> +	 * size as the block size found for the very first channel.
> +	 */
> +	dma_set_max_seg_size(dw->dma.dev, dw->chan[0].block_size);
> +
>  	err = dma_async_device_register(&dw->dma);
>  	if (err)
>  		goto err_dma_register;
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


