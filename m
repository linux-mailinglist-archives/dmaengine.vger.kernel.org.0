Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF7E1E63C8
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 16:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391054AbgE1OXa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 10:23:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:16004 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391124AbgE1OXU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 May 2020 10:23:20 -0400
IronPort-SDR: lxxeuY1xtGBc8ReuYBabQ3YbmTCLgKOBZVaZBGat8znseOXQbEf8t8xzcrkTXY/ihdAGvjqkkk
 LmyFF2JpMlsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 07:22:21 -0700
IronPort-SDR: gNo5fESEi88ICadxnRas20uQR259e56xhdit7Lv5R8UYFfHWazi64BmuzHavftCD2mQZeNAS9d
 d118Lf7jKUyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="267231578"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2020 07:22:18 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jeJQL-009RLS-03; Thu, 28 May 2020 17:22:21 +0300
Date:   Thu, 28 May 2020 17:22:20 +0300
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
Subject: Re: [PATCH v3 04/10] dmaengine: Introduce max SG list entries
 capability
Message-ID: <20200528142220.GR1634618@smile.fi.intel.com>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526225022.20405-5-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 27, 2020 at 01:50:15AM +0300, Serge Semin wrote:
> Some devices may lack the support of the hardware accelerated SG list
> entries automatic walking through and execution. In this case a burden of
> the SG list traversal and DMA engine re-initialization lies on the
> DMA engine driver (normally implemented by using a DMA transfer completion
> IRQ to recharge the DMA device with a next SG list entry). But such
> solution may not be suitable for some DMA consumers. In particular SPI
> devices need both Tx and Rx DMA channels work synchronously in order
> to avoid the Rx FIFO overflow. In case if Rx DMA channel is paused for
> some time while the Tx DMA channel works implicitly pulling data into the
> Rx FIFO, the later will be eventually overflown, which will cause the data
> loss. So if SG list entries aren't automatically fetched by the DMA
> engine, but are one-by-one manually selected for execution in the
> ISRs/deferred work/etc., such problem will eventually happen due to the
> non-deterministic latencies of the service execution.
> 
> In order to let the DMA consumer know about the DMA device capabilities
> regarding the hardware accelerated SG list traversal we introduce the
> max_sg_list capability. It is supposed to be initialized by the DMA engine
> driver with 0 if there is no limitation for the number of SG entries
> atomically executed and with non-zero value if there is such constraints,
> so the upper limit is determined by the number set to the property.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But see below.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
>  drivers/dma/dmaengine.c   | 1 +
>  include/linux/dmaengine.h | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index b332ffe52780..ad56ad58932c 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -592,6 +592,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	caps->directions = device->directions;
>  	caps->min_burst = device->min_burst;
>  	caps->max_burst = device->max_burst;
> +	caps->max_sg_nents = device->max_sg_nents;
>  	caps->residue_granularity = device->residue_granularity;
>  	caps->descriptor_reuse = device->descriptor_reuse;
>  	caps->cmd_pause = !!device->device_pause;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 0c7403b27133..6801200c76b6 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -467,6 +467,9 @@ enum dma_residue_granularity {
>   *	should be checked by controller as well
>   * @min_burst: min burst capability per-transfer
>   * @max_burst: max burst capability per-transfer
> + * @max_sg_nents: max number of SG list entries executed in a single atomic
> + *	DMA tansaction with no intermediate IRQ for reinitialization. Zero
> + *	value means unlimited number if entries.

if -> of ?

>   * @cmd_pause: true, if pause is supported (i.e. for reading residue or
>   *	       for resume later)
>   * @cmd_resume: true, if resume is supported
> @@ -481,6 +484,7 @@ struct dma_slave_caps {
>  	u32 directions;
>  	u32 min_burst;
>  	u32 max_burst;
> +	u32 max_sg_nents;
>  	bool cmd_pause;
>  	bool cmd_resume;
>  	bool cmd_terminate;
> @@ -773,6 +777,9 @@ struct dma_filter {
>   *	should be checked by controller as well
>   * @min_burst: min burst capability per-transfer
>   * @max_burst: max burst capability per-transfer
> + * @max_sg_nents: max number of SG list entries executed in a single atomic
> + *	DMA tansaction with no intermediate IRQ for reinitialization. Zero
> + *	value means unlimited number if entries.

Ditto.

>   * @residue_granularity: granularity of the transfer residue reported
>   *	by tx_status
>   * @device_alloc_chan_resources: allocate resources and return the
> @@ -844,6 +851,7 @@ struct dma_device {
>  	u32 directions;
>  	u32 min_burst;
>  	u32 max_burst;
> +	u32 max_sg_nents;
>  	bool descriptor_reuse;
>  	enum dma_residue_granularity residue_granularity;
>  
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


