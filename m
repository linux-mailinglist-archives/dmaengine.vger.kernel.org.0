Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29511E64AC
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403809AbgE1Owi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 10:52:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:28867 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403790AbgE1Owh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 May 2020 10:52:37 -0400
IronPort-SDR: XDyuhNDsdZyK8R38J+MU/TdGAXRYiDZdZ8EeiwDHssxe74w2jX4TJwdsCBXor4Lzqpyvm3Ntt2
 aCocO/X3WxMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 07:52:24 -0700
IronPort-SDR: EK3BBD6Ggz6zJo7E4j4JMagsNStfqspwS0XyjaL7vTKp2pfCYtq2YyTk0T4bFU8OmZQfE8C1RU
 HDOXV+pbBKiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="376393864"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2020 07:52:21 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jeJtQ-009Ram-6Q; Thu, 28 May 2020 17:52:24 +0300
Date:   Thu, 28 May 2020 17:52:24 +0300
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
Subject: Re: [PATCH v3 09/10] dmaengine: dw: Introduce max burst length hw
 config
Message-ID: <20200528145224.GT1634618@smile.fi.intel.com>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526225022.20405-10-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 27, 2020 at 01:50:20AM +0300, Serge Semin wrote:
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

...

>  static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  {
> +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
>  

Perhaps,

	/* DesignWare DMA supports burst value from 0 */
	caps->min_burst = 0;

> +	caps->max_burst = dwc->max_burst;
>  }

...

> +	*maxburst = clamp(*maxburst, 0U, dwc->max_burst);

Shouldn't we do the same for iDMA 32-bit? Thus, perhaps do it in the core.c?

>  	*maxburst = *maxburst > 1 ? fls(*maxburst) - 2 : 0;

> +	if (!of_property_read_u32_array(np, "snps,max-burst-len", mb,
> +					nr_channels)) {
> +		for (tmp = 0; tmp < nr_channels; tmp++)
> +			pdata->max_burst[tmp] = mb[tmp];

I think we may read directly to the array. This ugly loops were introduced due
to type mismatch. (See below)

> +	} else {
> +		for (tmp = 0; tmp < nr_channels; tmp++)
> +			pdata->max_burst[tmp] = DW_DMA_MAX_BURST;
> +	}

And this will be effectively memset32().

>  	unsigned char	nr_masters;
>  	unsigned char	data_width[DW_DMA_MAX_NR_MASTERS];
>  	unsigned char	multi_block[DW_DMA_MAX_NR_CHANNELS];
> +	unsigned int	max_burst[DW_DMA_MAX_NR_CHANNELS];

I think we have to stop with this kind of types and use directly what is in the
properties, i.e.

	u32 max_burst[...];

-- 
With Best Regards,
Andy Shevchenko


