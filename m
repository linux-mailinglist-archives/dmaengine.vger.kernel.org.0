Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74884219ED8
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2020 13:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGILJR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jul 2020 07:09:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:39568 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgGILJQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 9 Jul 2020 07:09:16 -0400
IronPort-SDR: 45nC6U7Bv7mJjVYTZWqGyWG55S2sfdSXKEcrPpoWLWF++DAuAmuc7F3bo9BMjq72Tw1aXQIta9
 /YoDptNR1RFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="212891107"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="212891107"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 04:09:16 -0700
IronPort-SDR: OWaLNeZBmurGE0tfls9Q2CUa/rhJAuCmUH8nFuOlGcWQl+Rl23mb1bdok7/IQ+rBvSwIphLnW6
 cN3S2miYfZjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="323211719"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2020 04:09:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jtUQU-000qRR-HO; Thu, 09 Jul 2020 14:09:14 +0300
Date:   Thu, 9 Jul 2020 14:09:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        malliamireddy009@gmail.com
Subject: Re: [PATCH v4 2/2] Add Intel LGM soc DMA support.
Message-ID: <20200709110914.GW3703480@smile.fi.intel.com>
References: <cover.1594273437.git.mallikarjunax.reddy@linux.intel.com>
 <6be9b9cfbf6708fe371f280cb94cbdc9c04bdccb.1594273437.git.mallikarjunax.reddy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be9b9cfbf6708fe371f280cb94cbdc9c04bdccb.1594273437.git.mallikarjunax.reddy@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 09, 2020 at 02:01:06PM +0800, Amireddy Mallikarjuna reddy wrote:
> Add DMA controller driver for Lightning Mountain(LGM) family of SoCs.
> 
> The main function of the DMA controller is the transfer of data from/to any
> DPlus compliant peripheral to/from the memory. A memory to memory copy
> capability can also be configured.
> 
> This ldma driver is used for configure the device and channnels for data
> and control paths.

> +#include "../virt-dma.h"

I didn't find any evidence this driver utilizes virt-dma API in full.
For example, there is a virt_dma_desc structure and descriptor management around it.
Why don't you use it?

-- 
With Best Regards,
Andy Shevchenko


