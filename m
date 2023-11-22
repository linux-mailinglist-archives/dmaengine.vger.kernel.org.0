Return-Path: <dmaengine+bounces-183-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFFE7F4F77
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 19:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455B62812D2
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903C5D4A5;
	Wed, 22 Nov 2023 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nd7nsZ/O"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EB41BF;
	Wed, 22 Nov 2023 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700677530; x=1732213530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9T/lmkOzA8qH1gsqzBaEUXEcJ2xCyHprr1GsLX67Go=;
  b=Nd7nsZ/O0PDv0mbGUgxrFrxmMdNl0nqIbmleG0wl6LU5Q9jYMucavz6h
   pVHyKsgdVnhSpFbMHMG1IgB0gU46GmwZX8z8eQSHmeCoJ+csGGjWf7aRa
   6FYbRfws4y4/yYfT23s4OOoewIVrxeC9T5T5uj7OyExkQFmbjf/ySj8D7
   3XteRxuEIYr9H7Z/EOLQB/5+JV5EP+AXQZ1McJ6Mb4QxreS64cqHHLyRU
   L3Vytp8w3MGQGb/iSbTwbRQkcXWH8fSdG+y0LHYZXGgUCR0A14SMiPF2w
   x2sOY8XeHPcg8/RyGKasU3YgNJKGZwYNyzBWruzHUCDJw825DFWmSjfld
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456442927"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="456442927"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 10:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="890499124"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="890499124"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:13:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1r5m3a-0000000G5El-1eRf;
	Wed, 22 Nov 2023 14:10:14 +0200
Date: Wed, 22 Nov 2023 14:10:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/39] dma: cirrus: add DT support for Cirrus EP93xx
Message-ID: <ZV3vpu8uQFq-9ZuF@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-9-d59a76d5df29@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-9-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 22, 2023 at 11:59:47AM +0300, Nikita Shubin wrote:
> - drop subsys_initcall code
> - drop platform probe
> - add OF ID match table with data
> - add of_probe for device tree
> - add xlate for m2m/m2p
> - drop platform structs usage

It's not the best commit message (e.g., unaligned with verb "add"
in the Subject).

...

> +		edmac->clk = of_clk_get(np, i);

Why devm_clk_get() can't be used?

>  		if (IS_ERR(edmac->clk)) {
> +			dev_warn(&pdev->dev, "failed to get clock\n");
>  			continue;
>  		}

...

> +	if (direction != DMA_MEM_TO_DEV && direction != DMA_DEV_TO_MEM)
> +		return NULL;

is_slave_direction() ?

...

> +	dev_info(edma->dma_dev.dev, "%s: port=%d", __func__, port);

info level?! Wouldn't be noisy a bit?

...

> +	if (direction != DMA_MEM_TO_DEV && direction != DMA_DEV_TO_MEM)
> +		return NULL;

As per above.

...

> +	dev_info(dma_dev->dev, "EP93xx M2%s DMA ready\n",
> +			       edma->m2m ? "M" : "P");

One line?

...

> +		if (!IS_ERR_OR_NULL(edmac->clk))
> +			clk_put(edmac->clk);

CLK framework is at least NULL aware. Perhaps you can make sure it's never
IS_ERR() and drop this conditional altogether.

...

> -
> +module_platform_driver(ep93xx_dma_driver);

+ blank line.

>  MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
>  MODULE_DESCRIPTION("EP93xx DMA driver");

...

> --- a/include/linux/platform_data/dma-ep93xx.h
> +++ b/include/linux/platform_data/dma-ep93xx.h
> @@ -5,6 +5,7 @@
>  #include <linux/types.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/property.h>

Can this be a bit more ordered, like put before types.h (at least from the
context I see here)?

Also you missing device.h and string.h according to the new function
implementation.

-- 
With Best Regards,
Andy Shevchenko



