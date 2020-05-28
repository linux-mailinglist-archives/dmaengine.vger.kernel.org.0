Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3DC1E63A6
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391051AbgE1OVK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 May 2020 10:21:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:20668 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390924AbgE1OVJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 May 2020 10:21:09 -0400
IronPort-SDR: lwKWPPpfCUBJU3dam2bE/0jMqpJA8LN84Ga4uMfHoqm0O2LDKfYlrBSstawzBPwbmKvY0ICh2+
 ltQp7l6BTv2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 07:21:05 -0700
IronPort-SDR: RbBOw7sCwjdGD+r6XWfXsZOuFjUtGlLTVQc41w4UEzOUe0AuN9UGJnNDQcyvlokBiRqVwZyWKo
 iFk1h8NQGUXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="302827105"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 28 May 2020 07:21:01 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jeJP6-009RKe-LU; Thu, 28 May 2020 17:21:04 +0300
Date:   Thu, 28 May 2020 17:21:04 +0300
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
Subject: Re: [PATCH v3 03/10] dmaengine: Introduce min burst length capability
Message-ID: <20200528142104.GQ1634618@smile.fi.intel.com>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526225022.20405-4-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 27, 2020 at 01:50:14AM +0300, Serge Semin wrote:
> Some hardware aside from default 0/1 may have greater minimum burst
> transactions length constraints. Here we introduce the DMA device
> and slave capability, which if required can be initialized by the DMA
> engine driver with the device-specific value.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
> - This is a new patch created as a result of the discussion with Vinud and
>   Andy in the framework of DW DMA burst and LLP capabilities.
> ---
>  drivers/dma/dmaengine.c   | 1 +
>  include/linux/dmaengine.h | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index d31076d9ef25..b332ffe52780 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -590,6 +590,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	caps->src_addr_widths = device->src_addr_widths;
>  	caps->dst_addr_widths = device->dst_addr_widths;
>  	caps->directions = device->directions;
> +	caps->min_burst = device->min_burst;
>  	caps->max_burst = device->max_burst;
>  	caps->residue_granularity = device->residue_granularity;
>  	caps->descriptor_reuse = device->descriptor_reuse;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index e1c03339918f..0c7403b27133 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -465,6 +465,7 @@ enum dma_residue_granularity {
>   *	Since the enum dma_transfer_direction is not defined as bit flag for
>   *	each type, the dma controller should set BIT(<TYPE>) and same
>   *	should be checked by controller as well
> + * @min_burst: min burst capability per-transfer
>   * @max_burst: max burst capability per-transfer
>   * @cmd_pause: true, if pause is supported (i.e. for reading residue or
>   *	       for resume later)
> @@ -478,6 +479,7 @@ struct dma_slave_caps {
>  	u32 src_addr_widths;
>  	u32 dst_addr_widths;
>  	u32 directions;
> +	u32 min_burst;
>  	u32 max_burst;
>  	bool cmd_pause;
>  	bool cmd_resume;
> @@ -769,6 +771,7 @@ struct dma_filter {
>   *	Since the enum dma_transfer_direction is not defined as bit flag for
>   *	each type, the dma controller should set BIT(<TYPE>) and same
>   *	should be checked by controller as well
> + * @min_burst: min burst capability per-transfer
>   * @max_burst: max burst capability per-transfer
>   * @residue_granularity: granularity of the transfer residue reported
>   *	by tx_status
> @@ -839,6 +842,7 @@ struct dma_device {
>  	u32 src_addr_widths;
>  	u32 dst_addr_widths;
>  	u32 directions;
> +	u32 min_burst;
>  	u32 max_burst;
>  	bool descriptor_reuse;
>  	enum dma_residue_granularity residue_granularity;
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


