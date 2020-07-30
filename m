Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF22336FB
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jul 2020 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG3Qlv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jul 2020 12:41:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:59905 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3Qlv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Jul 2020 12:41:51 -0400
IronPort-SDR: 0pEC6jvAMKlKAYAO+lucBBuZ7X/ylk/AjE7JuYT2r6HCBdxURftEMmS5MnMCwK5EOc8LN5Xto5
 H8x3xeFD4YAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="139186675"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="139186675"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 09:41:49 -0700
IronPort-SDR: 1Vv1W5DwYf/VI4pbSgIYJesCCX+9ZPGAQ7pCoV0ZKY/YvIpgtvLERdqqi5FNxK4/nY0rFjMm8E
 owPZWPu3zp+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="365248333"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 30 Jul 2020 09:41:46 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k1Bco-004zPI-G8; Thu, 30 Jul 2020 19:41:46 +0300
Date:   Thu, 30 Jul 2020 19:41:46 +0300
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
Subject: Re: [PATCH 5/5] dmaengine: dw: Add DMA-channels mask cell support
Message-ID: <20200730164146.GX3703480@smile.fi.intel.com>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
 <20200730154545.3965-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730154545.3965-6-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 30, 2020 at 06:45:45PM +0300, Serge Semin wrote:
> DW DMA IP-core provides a way to synthesize the DMA controller with
> channels having different parameters like maximum burst-length,
> multi-block support, maximum data width, etc. Those parameters both
> explicitly and implicitly affect the channels performance. Since DMA slave
> devices might be very demanding to the DMA performance, let's provide a
> functionality for the slaves to be assigned with DW DMA channels, which
> performance according to the platform engineer fulfill their requirements.
> After this patch is applied it can be done by passing the mask of suitable
> DMA-channels either directly in the dw_dma_slave structure instance or as
> a fifth cell of the DMA DT-property. If mask is zero or not provided, then
> there is no limitation on the channels allocation.
> 
> For instance Baikal-T1 SoC is equipped with a DW DMAC engine, which first
> two channels are synthesized with max burst length of 16, while the rest
> of the channels have been created with max-burst-len=4. It would seem that
> the first two channels must be faster than the others and should be more
> preferable for the time-critical DMA slave devices. In practice it turned
> out that the situation is quite the opposite. The channels with
> max-burst-len=4 demonstrated a better performance than the channels with
> max-burst-len=16 even when they both had been initialized with the same
> settings. The performance drop of the first two DMA-channels made them
> unsuitable for the DW APB SSI slave device. No matter what settings they
> are configured with, full-duplex SPI transfers occasionally experience the
> Rx FIFO overflow. It means that the DMA-engine doesn't keep up with
> incoming data pace even though the SPI-bus is enabled with speed of 25MHz
> while the DW DMA controller is clocked with 50MHz signal. There is no such
> problem has been noticed for the channels synthesized with
> max-burst-len=4.

...

> +	if (dws->channels && !(dws->channels & dwc->mask))

You can drop the first check if...

> +		return false;

...

> +	if (dma_spec->args_count >= 4)
> +		slave.channels = dma_spec->args[3];

...you apply sane default here or somewhere else.

...

> +		    fls(slave.channels) > dw->pdata->nr_channels))

Does it really make sense?

I think it can also be simplified to faster op, i.e.
	BIT(nr_channels) < slave.channels
(but check for off-by-one errors)

...

> + * @channels:	mask of the channels permitted for allocation (zero
> + *		value means any)

Perhaps on one line?

-- 
With Best Regards,
Andy Shevchenko


