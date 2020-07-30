Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6662336AC
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jul 2020 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgG3QYd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jul 2020 12:24:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:58165 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3QYd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Jul 2020 12:24:33 -0400
IronPort-SDR: U319jWku/ps5PMCHhdL6istjmYt1dnTVMYxoZkzF+xxEb3I5RURyYinDP7iIw+IerrwIvHFjLl
 AhR1en2rjhOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="213167902"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="213167902"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 09:24:31 -0700
IronPort-SDR: MrwQ0eg/Hshj310EMy889lLnLgtpyUUa2R79J391oiiwE3bgZXHDiDPqzaaEgcpaHpDHCO9OIY
 Akujdv4qhWSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="272968805"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2020 09:24:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k1BM4-004zEe-GV; Thu, 30 Jul 2020 19:24:28 +0300
Date:   Thu, 30 Jul 2020 19:24:28 +0300
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
Subject: Re: [PATCH 2/5] dmaengine: dw: Activate FIFO-mode for memory
 peripherals only
Message-ID: <20200730162428.GU3703480@smile.fi.intel.com>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
 <20200730154545.3965-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730154545.3965-3-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 30, 2020 at 06:45:42PM +0300, Serge Semin wrote:
> CFGx.FIFO_MODE field controls a DMA-controller "FIFO readiness" criterion.
> In other words it determines when to start pushing data out of a DW
> DMAC channel FIFO to a destination peripheral or from a source
> peripheral to the DW DMAC channel FIFO. Currently FIFO-mode is set to one
> for all DW DMAC channels. It means they are tuned to flush data out of
> FIFO (to a memory peripheral or by accepting the burst transaction
> requests) when FIFO is at least half-full (except at the end of the block
> transfer, when FIFO-flush mode is activated) and are configured to get
> data to the FIFO when it's at least half-empty.
> 
> Such configuration is a good choice when there is no slave device involved
> in the DMA transfers. In that case the number of bursts per block is less
> than when CFGx.FIFO_MODE = 0 and, hence, the bus utilization will improve.
> But the latency of DMA transfers may increase when CFGx.FIFO_MODE = 1,
> since DW DMAC will wait for the channel FIFO contents to be either
> half-full or half-empty depending on having the destination or the source
> transfers. Such latencies might be dangerous in case if the DMA transfers
> are expected to be performed from/to a slave device. Since normally
> peripheral devices keep data in internal FIFOs, any latency at some
> critical moment may cause one being overflown and consequently losing
> data. This especially concerns a case when either a peripheral device is
> relatively fast or the DW DMAC engine is relatively slow with respect to
> the incoming data pace.
> 
> In order to solve problems, which might be caused by the latencies
> described above, let's enable the FIFO half-full/half-empty "FIFO
> readiness" criterion only for DMA transfers with no slave device involved.

> Thanks to the commit ???????????? ("dmaengine: dw: Initialize channel

See below.

> before each transfer") we can freely do that in the generic
> dw_dma_initialize_chan() method.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks!

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Note the DMA-engine repository git.infradead.org/users/vkoul/slave-dma.git
> isn't accessible. So I couldn't find out the Andy' commit hash to use it in
> the log.

It's dmaengine.git on git.kernel.org.

> ---
>  drivers/dma/dw/dw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw/dw.c b/drivers/dma/dw/dw.c
> index 7a085b3c1854..d9810980920a 100644
> --- a/drivers/dma/dw/dw.c
> +++ b/drivers/dma/dw/dw.c
> @@ -14,7 +14,7 @@
>  static void dw_dma_initialize_chan(struct dw_dma_chan *dwc)
>  {
>  	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
> -	u32 cfghi = DWC_CFGH_FIFO_MODE;
> +	u32 cfghi = is_slave_direction(dwc->direction) ? 0 : DWC_CFGH_FIFO_MODE;
>  	u32 cfglo = DWC_CFGL_CH_PRIOR(dwc->priority);
>  	bool hs_polarity = dwc->dws.hs_polarity;
>  
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko


