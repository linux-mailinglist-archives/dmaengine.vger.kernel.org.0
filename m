Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6381E7A7E
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2020 12:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE2KZQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 May 2020 06:25:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:15613 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE2KZQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 29 May 2020 06:25:16 -0400
IronPort-SDR: RmO72A9yApsv6LNwZSSqdJjIMMD8YH7wq3vkndRboE6OfyEKUiRZ6+n6KguhV4AZaOAzP8pxPo
 GH3NUt17BlmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 03:25:15 -0700
IronPort-SDR: 7PsuXqCp1c8RMiOZioLmiKTedIZ+CE48YYzzrFoG6NWhu7y3RoJYSDBJM6yyOw3zBgyQcrql4Q
 ZCfhEioQwTMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="311207800"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 29 May 2020 03:25:12 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jecCR-009aqc-QJ; Fri, 29 May 2020 13:25:15 +0300
Date:   Fri, 29 May 2020 13:25:15 +0300
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
Subject: Re: [PATCH v4 09/11] dmaengine: dw: Initialize min_burst capability
Message-ID: <20200529102515.GD1634618@smile.fi.intel.com>
References: <20200528222401.26941-1-Sergey.Semin@baikalelectronics.ru>
 <20200528222401.26941-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528222401.26941-10-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 29, 2020 at 01:23:59AM +0300, Serge Semin wrote:
> According to the DW APB DMAC data book the minimum burst transaction
> length is 1 and it's true for any version of the controller since
> isn't parametrised in the coreAssembler so can't be changed at the
> IP-core synthesis stage. Let's initialise the min_burst member of the
> DMA controller descriptor so the DMA clients could use it to properly
> optimize the DMA requests.

> @@ -1229,6 +1229,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
>  	dw->dma.device_issue_pending = dwc_issue_pending;
>  
>  	/* DMA capabilities */

> +	dw->dma.min_burst = 1;

Perhaps then relaxed maximum, like

	dw->dma.max_burst = 256;

(channels will update this)

?

>  	dw->dma.src_addr_widths = DW_DMA_BUSWIDTHS;
>  	dw->dma.dst_addr_widths = DW_DMA_BUSWIDTHS;
>  	dw->dma.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


