Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7D2C0327
	for <lists+dmaengine@lfdr.de>; Mon, 23 Nov 2020 11:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgKWKV5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Nov 2020 05:21:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:13889 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgKWKV5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Nov 2020 05:21:57 -0500
IronPort-SDR: aPE8N6gKOTojOmbxUxZrWrTVCOdt0EIESBgrA0I30BRHfp4JdxRnRtsjBZwup/GMhZt6HAL5BX
 chnnyBTF5U9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="235879373"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="235879373"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 02:21:56 -0800
IronPort-SDR: bDYcC0KazFEg8m1ptN73iHBFmsa13wxflaQanQLsw0kHHkwlR1mXimKGt/uNf9/QIGiAh2fjlu
 dlnEAr6WbTPw==
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="536051793"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 02:21:54 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kh8zo-0097fC-RX; Mon, 23 Nov 2020 12:22:56 +0200
Date:   Mon, 23 Nov 2020 12:22:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 16/16] dmaengine: dw-axi-dmac: Virtually split the
 linked-list
Message-ID: <20201123102256.GV4077@smile.fi.intel.com>
References: <20201123023452.7894-1-jee.heng.sia@intel.com>
 <20201123023452.7894-17-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123023452.7894-17-jee.heng.sia@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 23, 2020 at 10:34:52AM +0800, Sia Jee Heng wrote:
> AxiDMA driver exposed the dma_set_max_seg_size() to the DMAENGINE.
> It shall helps the DMA clients to create size-optimized linked-list
> for the controller.
> 
> However, there are certain situations where DMA client might not be
> abled to benefit from the dma_get_max_seg_size() if the segment size
> can't meet the nature of the DMA client's operation.
> 
> In the case of ALSA operation, ALSA application and driver expecting
> to run in a period of larger than 10ms regardless of the bit depth.
> With this large period, there is a strong request to split the linked-list
> in the AxiDMA driver.

I'm wondering why ASoC generic code can't use DMA channel and device
capabilities and prepare SG list with all limitations taken into account.


-- 
With Best Regards,
Andy Shevchenko


