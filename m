Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB021CE741
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 23:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgEKVQ1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 17:16:27 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:50200 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgEKVQ1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 17:16:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4D1C7803080A;
        Mon, 11 May 2020 21:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JINjVi3KOE_z; Tue, 12 May 2020 00:16:23 +0300 (MSK)
Date:   Tue, 12 May 2020 00:16:22 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] dmaengine: dw: Set DMA device max segment size
 parameter
Message-ID: <20200511211622.yuh3ls2ay76yaxrf@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-4-Sergey.Semin@baikalelectronics.ru>
 <20200508112152.GI185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200508112152.GI185537@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 08, 2020 at 02:21:52PM +0300, Andy Shevchenko wrote:
> +Cc (Vineet, for information you probably know)
> 
> On Fri, May 08, 2020 at 01:53:01PM +0300, Serge Semin wrote:
> > Maximum block size DW DMAC configuration corresponds to the max segment
> > size DMA parameter in the DMA core subsystem notation. Lets set it with a
> > value specific to the probed DW DMA controller. It shall help the DMA
> > clients to create size-optimized SG-list items for the controller. This in
> > turn will cause less dw_desc allocations, less LLP reinitializations,
> > better DMA device performance.
> 
> Thank you for the patch.
> My comments below.
> 
> ...
> 
> > +		/*
> > +		 * Find maximum block size to be set as the DMA device maximum
> > +		 * segment size. By doing so we'll have size optimized SG-list
> > +		 * items for the channels with biggest block size. This won't
> > +		 * be a problem for the rest of the channels, since they will
> > +		 * still be able to split the requests up by allocating
> > +		 * multiple DW DMA LLP descriptors, which they would have done
> > +		 * anyway.
> > +		 */
> > +		if (dwc->block_size > block_size)
> > +			block_size = dwc->block_size;
> >  	}
> >  
> >  	/* Clear all interrupts on all channels. */
> > @@ -1220,6 +1233,10 @@ int do_dma_probe(struct dw_dma_chip *chip)
> >  			     BIT(DMA_MEM_TO_MEM);
> >  	dw->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> >  
> > +	/* Block size corresponds to the maximum sg size */
> > +	dw->dma.dev->dma_parms = &dw->dma_parms;
> > +	dma_set_max_seg_size(dw->dma.dev, block_size);
> > +
> >  	err = dma_async_device_register(&dw->dma);
> >  	if (err)
> >  		goto err_dma_register;
> 
> Yeah, I have locally something like this and I didn't dare to upstream because
> there is an issue. We have this information per DMA controller, while we
> actually need this on per DMA channel basis.
> 
> Above will work only for synthesized DMA with all channels having same block
> size. That's why above conditional is not needed anyway.

Hm, I don't really see why the conditional isn't needed and this won't work. As
you can see in the loop above Initially I find a maximum of all channels maximum
block sizes and use it then as a max segment size parameter for the whole device.
If the DW DMA controller has the same max block size of all channels, then it
will be found. If the channels've been synthesized with different block sizes,
then the optimization will work for the one with greatest block size. The SG
list entries of the channels with lesser max block size will be split up
by the DW DMAC driver, which would have been done anyway without
max_segment_size being set. Here we at least provide the optimization for the
channels with greatest max block size.

I do understand that it would be good to have this parameter setup on per generic
DMA channel descriptor basis. But DMA core and device descriptor doesn't provide
such facility, so setting at least some justified value is a good idea.

> 
> OTOH, I never saw the DesignWare DMA to be synthesized differently (I remember
> that Intel Medfield has interesting settings, but I don't remember if DMA
> channels are different inside the same controller).
> 
> Vineet, do you have any information that Synopsys customers synthesized DMA
> controllers with different channel characteristics inside one DMA IP?

AFAICS the DW DMAC channels can be synthesized with different max block size.
The IP core supports such configuration. So we can't assume that such DMAC
release can't be found in a real hardware just because we've never seen one.
No matter what Vineet will have to say in response to your question.

> 
> ...
> 
> >  #include <linux/bitops.h>
> 
> > +#include <linux/device.h>
> 
> Isn't enough to supply
> 
> struct device;
> 
> ?

It's "struct device_dma_parameters" and I'd prefer to include the header file.

> 
> >  #include <linux/interrupt.h>
> >  #include <linux/dmaengine.h>
> 
> Also this change needs a separate patch I suppose.

Ah, just discovered there is no need in adding the dma_parms here because since
commit 7c8978c0837d ("driver core: platform: Initialize dma_parms for platform
devices") the dma_params pointer is already initialized. The same thing is done
for the PCI device too.

-Sergey

> 
> ...
> 
> > -	struct dma_device	dma;
> > -	char			name[20];
> > -	void __iomem		*regs;
> > -	struct dma_pool		*desc_pool;
> > -	struct tasklet_struct	tasklet;
> > +	struct dma_device		dma;
> > +	struct device_dma_parameters	dma_parms;
> > +	char				name[20];
> > +	void __iomem			*regs;
> > +	struct dma_pool			*desc_pool;
> > +	struct tasklet_struct		tasklet;
> >  
> >  	/* channels */
> > -	struct dw_dma_chan	*chan;
> > -	u8			all_chan_mask;
> > -	u8			in_use;
> > +	struct dw_dma_chan		*chan;
> > +	u8				all_chan_mask;
> > +	u8				in_use;
> 
> Please split formatting fixes into a separate patch.
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
