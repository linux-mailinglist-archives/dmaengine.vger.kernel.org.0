Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1EC39DC65
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jun 2021 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFGMcL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Jun 2021 08:32:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:61308 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhFGMcI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Jun 2021 08:32:08 -0400
IronPort-SDR: nETW6aXoj+Xlp6NVBHKPIowttY0GiQypLnFwCPsjaRKpWEeGjLrrPfaotg6Nk0QglvYjXNSdTE
 7wSbzm621iBA==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="184293537"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="184293537"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 05:30:17 -0700
IronPort-SDR: btYoB+df5b1KaX044ICw0fUZK6+EP0PXPNnumH6QCEThOdCowIoM2z/GBHeYseBoZiGkUpY1rk
 DO2fL9a0gdcQ==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="551868470"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 05:30:15 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqEOS-000FhU-ND; Mon, 07 Jun 2021 15:30:12 +0300
Date:   Mon, 7 Jun 2021 15:30:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v1 1/1] dmaengine: dw: Program xBAR hardware for Elkhart
 Lake
Message-ID: <YL4RVEIJrSMy+Slf@smile.fi.intel.com>
References: <20210602085604.21933-1-andriy.shevchenko@linux.intel.com>
 <YL4EYb35GOVYxdQO@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL4EYb35GOVYxdQO@vkoul-mobl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 07, 2021 at 05:04:57PM +0530, Vinod Koul wrote:
> On 02-06-21, 11:56, Andy Shevchenko wrote:
> > Intel Elkhart Lake PSE DMA implementation is integrated with crossbar IP
> > in order to serve more hardware than there are DMA request lines available.
> > 
> > Due to this, program xBAR hardware to make flexible support of PSE peripheral.

...

> > -// Copyright (C) 2013,2018 Intel Corporation
> > +// Copyright (C) 2013,2018,2020 Intel Corporation
> 
> 2021..?

Actually 2020.
But I can add 2021.

...

> > +static unsigned int idma32_get_slave_devid(struct dw_dma_chan *dwc)
> > +{
> > +	struct device *slave = dwc->chan.slave;
> > +
> > +	if (!slave || !dev_is_pci(slave))
> > +		return 0;
> > +
> > +	return to_pci_dev(slave)->devfn;
> 
> so this return devfn.. maybe rename function to get_slave_devfn() ?

Will do in v2.

> > +}

...

> > +	switch (dwc->direction) {
> > +	case DMA_MEM_TO_MEM:
> > +		value |= CTL_CH_TRANSFER_MODE_D2D;
> > +		break;
> > +	case DMA_MEM_TO_DEV:
> > +		value |= CTL_CH_TRANSFER_MODE_D2S;
> > +		value |= CTL_CH_WR_NON_SNOOP_BIT;
> > +		break;
> > +	case DMA_DEV_TO_MEM:
> > +		value |= CTL_CH_TRANSFER_MODE_S2D;
> > +		value |= CTL_CH_RD_NON_SNOOP_BIT;
> > +		break;
> > +	case DMA_DEV_TO_DEV:
> > +	default:
> > +		value |= CTL_CH_WR_NON_SNOOP_BIT | CTL_CH_RD_NON_SNOOP_BIT;
> > +		value |= CTL_CH_TRANSFER_MODE_S2S;
> > +		break;
> 
> aha, how did you test this...

Not sure what the question is about. You are talking about last two cases
or the entire switch? Last two weren't tested, just filed for the sake of
being documented. First two were tested with SPI host controllers.

-- 
With Best Regards,
Andy Shevchenko


