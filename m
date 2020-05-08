Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609B71CA9D4
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 13:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEHLnb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 07:43:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:17037 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgEHLnb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 8 May 2020 07:43:31 -0400
IronPort-SDR: 18nEa2Sn5Bd/naPm8YKevnHR/rG+XuZQlaqTmnjxSqOqXfRK56/Ws3p18Uf3QwiyGoAfAbzhhy
 l9g74k2mrGyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 04:43:30 -0700
IronPort-SDR: N520jTIwBLbQ3eYPYfqgXoYmzna7PwGI5hq/piziWOApkWt7/SY2gIpRH6PMVQ/+XaA1GoMTon
 3aKmR+5XPkTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="462212826"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 08 May 2020 04:43:27 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX1Pe-005PPL-CS; Fri, 08 May 2020 14:43:30 +0300
Date:   Fri, 8 May 2020 14:43:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] dmaengine: dw: Take HC_LLP flag into account for
 noLLP auto-config
Message-ID: <20200508114330.GL185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508105304.14065-7-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 08, 2020 at 01:53:04PM +0300, Serge Semin wrote:
> Full multi-block transfers functionality is enabled in DW DMA
> controller only if CHx_MULTI_BLK_EN is set. But LLP-based transfers
> can be executed only if hardcode channel x LLP register feature isn't
> enabled, which can be switched on at the IP core synthesis for
> optimization. If it's enabled then the LLP register is hardcoded to
> zero, so the blocks chaining based on the LLPs is unsupported.
> 

This one is good.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Feel free to reassemble the series, so, Vinod can apply it independently.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> ---
> 
> Changelog v2:
> - Rearrange SoBs.
> - Add comment about why hardware accelerated LLP list support depends
>   on both MBLK_EN and HC_LLP configs setting.
> - Use explicit bits state comparison operator.
> ---
>  drivers/dma/dw/core.c | 11 ++++++++++-
>  drivers/dma/dw/regs.h |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 5b76ccc857fd..3179d45df662 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -1180,8 +1180,17 @@ int do_dma_probe(struct dw_dma_chip *chip)
>  			 */
>  			dwc->block_size =
>  				(4 << ((pdata->block_size >> 4 * i) & 0xf)) - 1;
> +
> +			/*
> +			 * According to the DW DMA databook the true scatter-
> +			 * gether LLPs aren't available if either multi-block
> +			 * config is disabled (CHx_MULTI_BLK_EN == 0) or the
> +			 * LLP register is hard-coded to zeros
> +			 * (CHx_HC_LLP == 1).
> +			 */
>  			dwc->nollp =
> -				(dwc_params >> DWC_PARAMS_MBLK_EN & 0x1) == 0;
> +				(dwc_params >> DWC_PARAMS_MBLK_EN & 0x1) == 0 ||
> +				(dwc_params >> DWC_PARAMS_HC_LLP & 0x1) == 1;
>  			dwc->max_burst =
>  				(0x4 << (dwc_params >> DWC_PARAMS_MSIZE & 0x7));
>  		} else {
> diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
> index f581d4809b71..a8af19d0eabd 100644
> --- a/drivers/dma/dw/regs.h
> +++ b/drivers/dma/dw/regs.h
> @@ -126,6 +126,7 @@ struct dw_dma_regs {
>  
>  /* Bitfields in DWC_PARAMS */
>  #define DWC_PARAMS_MSIZE	16		/* max group transaction size */
> +#define DWC_PARAMS_HC_LLP	13		/* set LLP register to zero */
>  #define DWC_PARAMS_MBLK_EN	11		/* multi block transfer */
>  
>  /* bursts size */
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


