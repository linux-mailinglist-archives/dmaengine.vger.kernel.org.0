Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB81E826E
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgE2Ps2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 11:48:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:9070 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgE2Ps2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 May 2020 11:48:28 -0400
IronPort-SDR: sOnZYYRLdCtMp3MPBKDg/eThkYEZopM5VtRKbFg6g0ZBuc86wgUF3s6WWrBlwg/Xm+BxIESxJN
 03yU10PkQCLA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 08:48:27 -0700
IronPort-SDR: 8rg70f1m/iIwW8+EDUPTct8YHZ43T8EY1iyW9lBF7nyta2UH/zf11NB6nAF3S6iy4FrDiciOm3
 SK5FxgETFldQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="311277341"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 29 May 2020 08:48:24 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jehFD-009dqd-LX; Fri, 29 May 2020 18:48:27 +0300
Date:   Fri, 29 May 2020 18:48:27 +0300
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
Subject: Re: [PATCH v5 09/11] dmaengine: dw: Initialize min and max burst DMA
 device capability
Message-ID: <20200529154827.GT1634618@smile.fi.intel.com>
References: <20200529144054.4251-1-Sergey.Semin@baikalelectronics.ru>
 <20200529144054.4251-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529144054.4251-10-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 29, 2020 at 05:40:52PM +0300, Serge Semin wrote:
> According to the DW APB DMAC data book the minimum burst transaction
> length is 1 and it's true for any version of the controller since
> isn't parametrised in the coreAssembler so can't be changed at the
> IP-core synthesis stage. The maximum burst transaction can vary from
> channel to channel and from controller to controller depending on a
> IP-core parameter the system engineer activated during the IP-core
> synthesis. Let's initialise both min_burst and max_burst members of the
> DMA controller descriptor with extreme values so the DMA clients could
> use them to properly optimize the DMA requests. The channels and
> controller-specific max_burst length initialization will be introduced
> by the follow-up patches.

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
> Changelog v4:
> - This is a new patch suggested by Andy.
> 
> Changelog v5:
> - Introduce macro with extreme min and max burst length supported by the
>   DW DMA controller.
> - Initialize max_burst length capability with extreme burst length supported
>   by the DW DMAC IP-core.
> ---
>  drivers/dma/dw/core.c                | 2 ++
>  include/linux/platform_data/dma-dw.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index ceded21537e2..4887aa2fc73c 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -1229,6 +1229,8 @@ int do_dma_probe(struct dw_dma_chip *chip)
>  	dw->dma.device_issue_pending = dwc_issue_pending;
>  
>  	/* DMA capabilities */
> +	dw->dma.min_burst = DW_DMA_MIN_BURST;
> +	dw->dma.max_burst = DW_DMA_MAX_BURST;
>  	dw->dma.src_addr_widths = DW_DMA_BUSWIDTHS;
>  	dw->dma.dst_addr_widths = DW_DMA_BUSWIDTHS;
>  	dw->dma.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
> diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
> index f3eaf9ec00a1..369e41e9dcc9 100644
> --- a/include/linux/platform_data/dma-dw.h
> +++ b/include/linux/platform_data/dma-dw.h
> @@ -12,6 +12,8 @@
>  
>  #define DW_DMA_MAX_NR_MASTERS	4
>  #define DW_DMA_MAX_NR_CHANNELS	8
> +#define DW_DMA_MIN_BURST	1
> +#define DW_DMA_MAX_BURST	256
>  
>  /**
>   * struct dw_dma_slave - Controller-specific information about a slave
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


