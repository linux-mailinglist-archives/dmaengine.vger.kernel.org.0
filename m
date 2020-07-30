Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D611B2336C0
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jul 2020 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgG3Q2i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jul 2020 12:28:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:47605 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3Q2h (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Jul 2020 12:28:37 -0400
IronPort-SDR: MgAtMaF2kcvmTecnKTRPZHO/nNOGfQ6RInaJeANBKVfQhoF8e3bHs2CZKP6v/892aLTEwG3eqp
 qD1vZPDWWXPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="131200238"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="131200238"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 09:28:37 -0700
IronPort-SDR: 3EFjlDhVMfjudTwik6M7iGEp3/iA8cQxPmUMk9Cxeo+rosuhM35RLz6oH/Ht0gUGxL6XGeJ/un
 8fEPrK1DPTQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="490714354"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jul 2020 09:28:34 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k1BQ1-004zHp-QU; Thu, 30 Jul 2020 19:28:33 +0300
Date:   Thu, 30 Jul 2020 19:28:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Vinod Koul <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dmaengine: dw: Discard dlen from the dev-to-mem xfer
 width calculation
Message-ID: <20200730162833.GV3703480@smile.fi.intel.com>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
 <20200730154545.3965-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730154545.3965-4-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 30, 2020 at 06:45:43PM +0300, Serge Semin wrote:
> Indeed in case of the DMA_DEV_TO_MEM DMA transfers it's enough to take the
> destination memory address and the destination master data width into
> account to calculate the CTLx.DST_TR_WIDTH setting of the memory

> peripheral. According to the DW DMAC IP-core Databook (page 66, Example 5)

Always put a version of the Databook document. I have several and they may differ.

> at the and of a DMA transfer when the DMA-channel internal FIFO is left
> with data less than for a single destination burst transaction, the
> destination peripheral will enter the Single Transaction Region where the
> DW DMA controller can complete a block transfer to the destination using
> single transactions (non-burst transaction of CTLx.DST_TR_WIDTH bytes). If
> there is no enough data in the DMA-channel internal FIFO for even a single
> non-burst transaction of CTLx.DST_TR_WIDTH bytes, then the channel enters
> "FIFO flush mode". That mode is activated to empty the FIFO and flush the
> leftovers out to the memory peripheral. The flushing procedure is simple.
> The data is sent to the memory by means of a set of single transaction of
> CTLx.SRC_TR_WIDTH bytes. To sum up it's redundant to use the LLPs length
> to find out the CTLx.DST_TR_WIDTH parameter value, since each DMA transfer
> will be completed with the CTLx.SRC_TR_WIDTH bytes transaction if it is
> required.

> In this commit we remove the LLP entry length from the statement which

"In this commit" should be removed, see Submitting Patches ("This patch").

> calculates the memory peripheral DMA transaction width since it's
> redundant due to the feature described above. By doing so we'll improve
> the memory bus utilization and speed up the DMA-channel performance for
> DMA_DEV_TO_MEM DMA-transfers.

Okay, I have no objections.
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/dma/dw/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 4700f2e87a62..3da0aea9fe25 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -723,7 +723,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  			lli_write(desc, sar, reg);
>  			lli_write(desc, dar, mem);
>  			lli_write(desc, ctlhi, ctlhi);
> -			mem_width = __ffs(data_width | mem | dlen);
> +			mem_width = __ffs(data_width | mem);
>  			lli_write(desc, ctllo, ctllo | DWC_CTLL_DST_WIDTH(mem_width));
>  			desc->len = dlen;
>  
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko


