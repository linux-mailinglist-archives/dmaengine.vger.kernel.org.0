Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0001CA974
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHLVy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 07:21:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:64781 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHLVy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 8 May 2020 07:21:54 -0400
IronPort-SDR: eZ8BD4v1hrMhJzG2YO3dTlTNvmoDzwvQB8tlU6Nw6bfc+dL+bYvhBY55u1oje5rFu4gZ1zQ09U
 +ZFh0ZxzWFmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 04:21:53 -0700
IronPort-SDR: AWn4JlKcN8+Kxi8TzKAw9JjRTfavnoOzEW0AiPwbQHRL5c+GX//59m/RxVdjoQmAf6vZ6Z3I1w
 haHJ31QpjNnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="462202399"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 08 May 2020 04:21:49 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jX14i-005PEb-LK; Fri, 08 May 2020 14:21:52 +0300
Date:   Fri, 8 May 2020 14:21:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vineet Gupta <vgupta@synopsys.com>
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
Subject: Re: [PATCH v2 3/6] dmaengine: dw: Set DMA device max segment size
 parameter
Message-ID: <20200508112152.GI185537@smile.fi.intel.com>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508105304.14065-4-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

+Cc (Vineet, for information you probably know)

On Fri, May 08, 2020 at 01:53:01PM +0300, Serge Semin wrote:
> Maximum block size DW DMAC configuration corresponds to the max segment
> size DMA parameter in the DMA core subsystem notation. Lets set it with a
> value specific to the probed DW DMA controller. It shall help the DMA
> clients to create size-optimized SG-list items for the controller. This in
> turn will cause less dw_desc allocations, less LLP reinitializations,
> better DMA device performance.

Thank you for the patch.
My comments below.

...

> +		/*
> +		 * Find maximum block size to be set as the DMA device maximum
> +		 * segment size. By doing so we'll have size optimized SG-list
> +		 * items for the channels with biggest block size. This won't
> +		 * be a problem for the rest of the channels, since they will
> +		 * still be able to split the requests up by allocating
> +		 * multiple DW DMA LLP descriptors, which they would have done
> +		 * anyway.
> +		 */
> +		if (dwc->block_size > block_size)
> +			block_size = dwc->block_size;
>  	}
>  
>  	/* Clear all interrupts on all channels. */
> @@ -1220,6 +1233,10 @@ int do_dma_probe(struct dw_dma_chip *chip)
>  			     BIT(DMA_MEM_TO_MEM);
>  	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>  
> +	/* Block size corresponds to the maximum sg size */
> +	dw->dma.dev->dma_parms = &dw->dma_parms;
> +	dma_set_max_seg_size(dw->dma.dev, block_size);
> +
>  	err = dma_async_device_register(&dw->dma);
>  	if (err)
>  		goto err_dma_register;

Yeah, I have locally something like this and I didn't dare to upstream because
there is an issue. We have this information per DMA controller, while we
actually need this on per DMA channel basis.

Above will work only for synthesized DMA with all channels having same block
size. That's why above conditional is not needed anyway.

OTOH, I never saw the DesignWare DMA to be synthesized differently (I remember
that Intel Medfield has interesting settings, but I don't remember if DMA
channels are different inside the same controller).

Vineet, do you have any information that Synopsys customers synthesized DMA
controllers with different channel characteristics inside one DMA IP?

...

>  #include <linux/bitops.h>

> +#include <linux/device.h>

Isn't enough to supply

struct device;

?

>  #include <linux/interrupt.h>
>  #include <linux/dmaengine.h>

Also this change needs a separate patch I suppose.

...

> -	struct dma_device	dma;
> -	char			name[20];
> -	void __iomem		*regs;
> -	struct dma_pool		*desc_pool;
> -	struct tasklet_struct	tasklet;
> +	struct dma_device		dma;
> +	struct device_dma_parameters	dma_parms;
> +	char				name[20];
> +	void __iomem			*regs;
> +	struct dma_pool			*desc_pool;
> +	struct tasklet_struct		tasklet;
>  
>  	/* channels */
> -	struct dw_dma_chan	*chan;
> -	u8			all_chan_mask;
> -	u8			in_use;
> +	struct dw_dma_chan		*chan;
> +	u8				all_chan_mask;
> +	u8				in_use;

Please split formatting fixes into a separate patch.


-- 
With Best Regards,
Andy Shevchenko


