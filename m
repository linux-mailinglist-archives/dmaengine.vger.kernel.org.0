Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E456D1E7CDC
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgE2MMF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 08:12:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:23968 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgE2MMF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 May 2020 08:12:05 -0400
IronPort-SDR: Qermc0EercT7INXGeQpk9ML0X7Kd/+5tDaOkSVh15emUr3UCwHAhKDNP7s69q4oUx+RkSQUwN6
 YJkfPb9dRgng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 05:12:04 -0700
IronPort-SDR: W6hm4qdNwW/VxxI2WNuDIea29zHc9Q3inbKrr6Gw8DXT4H+CcHEyRsDj0KmbYERrLD7dnT9bBu
 AZRryEb+GqgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="346247214"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2020 05:12:01 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jedrn-009bxC-TD; Fri, 29 May 2020 15:12:03 +0300
Date:   Fri, 29 May 2020 15:12:03 +0300
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
Subject: Re: [PATCH v4 05/11] dmaengine: Introduce DMA-device device_caps
 callback
Message-ID: <20200529121203.GK1634618@smile.fi.intel.com>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
 <20200528222401.26941-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528222401.26941-6-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 29, 2020 at 01:23:55AM +0300, Serge Semin wrote:
> There are DMA devices (like ours version of Synopsys DW DMAC) which have
> DMA capabilities non-uniformly redistributed amongst the device channels.
> In order to provide a way of exposing the channel-specific parameters to
> the DMA engine consumers, we introduce a new DMA-device callback. In case
> if provided it gets called from the dma_get_slave_caps() method and is
> able to override the generic DMA-device capabilities.

I thought there is a pattern to return something, but it seems none.
So, I have nothing against it to return void.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But consider one comment below.

> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> ---
> 
> Changelog v3:
> - This is a new patch created as a result of the discussion with Vinod and
>   Andy in the framework of DW DMA burst and LLP capabilities.
> ---
>  drivers/dma/dmaengine.c   | 3 +++
>  include/linux/dmaengine.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index ad56ad58932c..edbb11d56cde 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -599,6 +599,9 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	caps->cmd_resume = !!device->device_resume;
>  	caps->cmd_terminate = !!device->device_terminate_all;
>  

Perhaps a comment to explain that this is channel specific correction /
override / you name it on top of device level capabilities?

> +	if (device->device_caps)
> +		device->device_caps(chan, caps);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dma_get_slave_caps);
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index a7e4d8dfdd19..b303e59929e5 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -899,6 +899,8 @@ struct dma_device {
>  		struct dma_chan *chan, dma_addr_t dst, u64 data,
>  		unsigned long flags);
>  
> +	void (*device_caps)(struct dma_chan *chan,
> +			    struct dma_slave_caps *caps);
>  	int (*device_config)(struct dma_chan *chan,
>  			     struct dma_slave_config *config);
>  	int (*device_pause)(struct dma_chan *chan);
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


