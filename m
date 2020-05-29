Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458D01E7A88
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 12:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgE2K1i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 06:27:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:1688 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgE2K1f (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 May 2020 06:27:35 -0400
IronPort-SDR: vS2PphNfrj3CwqxB9l/m2oI7kbZws3n22Vg2zv5Fo5WdRfIGI90eVjLah1DNU4v6iTHHEvtzsC
 QYSMwu0FYGHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 03:27:32 -0700
IronPort-SDR: cy9Ijp0WPLtd+2LLZCHoODlXDKNs6NH3JrrJ5svsXL3e15kxF/oJWfOIB1ZreFLCGbLsz+SPqM
 sZ5jMvng6tYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="469462746"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 29 May 2020 03:27:29 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jecEe-009ara-Ca; Fri, 29 May 2020 13:27:32 +0300
Date:   Fri, 29 May 2020 13:27:32 +0300
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
Subject: Re: [PATCH v4 10/11] dmaengine: dw: Introduce max burst length hw
 config
Message-ID: <20200529102732.GE1634618@smile.fi.intel.com>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
 <20200528222401.26941-11-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528222401.26941-11-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 29, 2020 at 01:24:00AM +0300, Serge Semin wrote:
> IP core of the DW DMA controller may be synthesized with different
> max burst length of the transfers per each channel. According to Synopsis
> having the fixed maximum burst transactions length may provide some
> performance gain. At the same time setting up the source and destination
> multi size exceeding the max burst length limitation may cause a serious
> problems. In our case the DMA transaction just hangs up. In order to fix
> this lets introduce the max burst length platform config of the DW DMA
> controller device and don't let the DMA channels configuration code
> exceed the burst length hardware limitation.
> 
> Note the maximum burst length parameter can be detected either in runtime
> from the DWC parameter registers or from the dedicated DT property.
> Depending on the IP core configuration the maximum value can vary from
> channel to channel so by overriding the channel slave max_burst capability
> we make sure a DMA consumer will get the channel-specific max burst
> length.

LGTM, but consider comment to previous patch (in that case perhaps definition
of min and max should be moved there).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
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
> - Rearrange SoBs.
> - Discard dwc_get_maxburst() accessor. It's enough to have a clamping
>   guard against exceeding the hardware max burst limitation.
> 
> Changelog v3:
> - Override the slave channel max_burst capability instead of calculating
>   the minimum value of max burst lengths and setting the DMA-device
>   generic capability.
> 
> Changelog v4:
> - Clamp the dst and src burst lengths in the generic dwc_config() method
>   instead of doing that in the encode_maxburst() callback.
> - Define max_burst with u32 type in struct dw_dma_platform_data.
> - Perform of_property_read_u32_array() directly into the platform data
>   max_burst member.
> ---
>  drivers/dma/dw/core.c                | 10 ++++++++++
>  drivers/dma/dw/of.c                  |  5 +++++
>  drivers/dma/dw/regs.h                |  2 ++
>  include/linux/platform_data/dma-dw.h |  4 ++++
>  4 files changed, 21 insertions(+)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index a8cebb1dbb68..60ef779fc5e0 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -791,6 +791,11 @@ static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
>  
>  	memcpy(&dwc->dma_sconfig, sconfig, sizeof(*sconfig));
>  
> +	dwc->dma_sconfig.src_maxburst =
> +		clamp(dwc->dma_sconfig.src_maxburst, 0U, dwc->max_burst);
> +	dwc->dma_sconfig.dst_maxburst =
> +		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
> +
>  	dw->encode_maxburst(dwc, &dwc->dma_sconfig.src_maxburst);
>  	dw->encode_maxburst(dwc, &dwc->dma_sconfig.dst_maxburst);
>  
> @@ -1051,7 +1056,9 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  
>  static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  {
> +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
>  
> +	caps->max_burst = dwc->max_burst;
>  }
>  
>  int do_dma_probe(struct dw_dma_chip *chip)
> @@ -1194,9 +1201,12 @@ int do_dma_probe(struct dw_dma_chip *chip)
>  			dwc->nollp =
>  				(dwc_params >> DWC_PARAMS_MBLK_EN & 0x1) == 0 ||
>  				(dwc_params >> DWC_PARAMS_HC_LLP & 0x1) == 1;
> +			dwc->max_burst =
> +				(0x4 << (dwc_params >> DWC_PARAMS_MSIZE & 0x7));
>  		} else {
>  			dwc->block_size = pdata->block_size;
>  			dwc->nollp = !pdata->multi_block[i];
> +			dwc->max_burst = pdata->max_burst[i] ?: DW_DMA_MAX_BURST;
>  		}
>  	}
>  
> diff --git a/drivers/dma/dw/of.c b/drivers/dma/dw/of.c
> index 9e27831dee32..1474b3817ef4 100644
> --- a/drivers/dma/dw/of.c
> +++ b/drivers/dma/dw/of.c
> @@ -98,6 +98,11 @@ struct dw_dma_platform_data *dw_dma_parse_dt(struct platform_device *pdev)
>  			pdata->multi_block[tmp] = 1;
>  	}
>  
> +	if (of_property_read_u32_array(np, "snps,max-burst-len", pdata->max_burst,
> +				       nr_channels)) {
> +		memset32(pdata->max_burst, DW_DMA_MAX_BURST, nr_channels);
> +	}
> +
>  	if (!of_property_read_u32(np, "snps,dma-protection-control", &tmp)) {
>  		if (tmp > CHAN_PROTCTL_MASK)
>  			return NULL;
> diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
> index 1ab840b06e79..76654bd13c1a 100644
> --- a/drivers/dma/dw/regs.h
> +++ b/drivers/dma/dw/regs.h
> @@ -126,6 +126,7 @@ struct dw_dma_regs {
>  /* Bitfields in DWC_PARAMS */
>  #define DWC_PARAMS_MBLK_EN	11		/* multi block transfer */
>  #define DWC_PARAMS_HC_LLP	13		/* set LLP register to zero */
> +#define DWC_PARAMS_MSIZE	16		/* max group transaction size */
>  
>  /* bursts size */
>  enum dw_dma_msize {
> @@ -284,6 +285,7 @@ struct dw_dma_chan {
>  	/* hardware configuration */
>  	unsigned int		block_size;
>  	bool			nollp;
> +	u32			max_burst;
>  
>  	/* custom slave configuration */
>  	struct dw_dma_slave	dws;
> diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
> index f3eaf9ec00a1..29c484da2979 100644
> --- a/include/linux/platform_data/dma-dw.h
> +++ b/include/linux/platform_data/dma-dw.h
> @@ -12,6 +12,7 @@
>  
>  #define DW_DMA_MAX_NR_MASTERS	4
>  #define DW_DMA_MAX_NR_CHANNELS	8
> +#define DW_DMA_MAX_BURST	256
>  
>  /**
>   * struct dw_dma_slave - Controller-specific information about a slave
> @@ -42,6 +43,8 @@ struct dw_dma_slave {
>   * @data_width: Maximum data width supported by hardware per AHB master
>   *		(in bytes, power of 2)
>   * @multi_block: Multi block transfers supported by hardware per channel.
> + * @max_burst: Maximum value of burst transaction size supported by hardware
> + *	       per channel (in units of CTL.SRC_TR_WIDTH/CTL.DST_TR_WIDTH).
>   * @protctl: Protection control signals setting per channel.
>   */
>  struct dw_dma_platform_data {
> @@ -56,6 +59,7 @@ struct dw_dma_platform_data {
>  	unsigned char	nr_masters;
>  	unsigned char	data_width[DW_DMA_MAX_NR_MASTERS];
>  	unsigned char	multi_block[DW_DMA_MAX_NR_CHANNELS];
> +	u32		max_burst[DW_DMA_MAX_NR_CHANNELS];
>  #define CHAN_PROTCTL_PRIVILEGED		BIT(0)
>  #define CHAN_PROTCTL_BUFFERABLE		BIT(1)
>  #define CHAN_PROTCTL_CACHEABLE		BIT(2)
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


