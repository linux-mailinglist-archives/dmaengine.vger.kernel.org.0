Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0EA8BB2B
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2019 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfHMOHd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Aug 2019 10:07:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:17780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbfHMOHd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Aug 2019 10:07:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 07:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,381,1559545200"; 
   d="scan'208";a="376304590"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2019 07:07:31 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hxXST-00078N-LH; Tue, 13 Aug 2019 17:07:29 +0300
Date:   Tue, 13 Aug 2019 17:07:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmaengine: dw: Update Intel Elkhart Lake Service Engine
 acronym
Message-ID: <20190813140729.GC30120@smile.fi.intel.com>
References: <20190813080602.15376-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813080602.15376-1-jarkko.nikula@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Aug 13, 2019 at 11:06:02AM +0300, Jarkko Nikula wrote:
> Intel Elkhart Lake Offload Service Engine (OSE) will be called as
> Intel(R) Programmable Services Engine (Intel(R) PSE) in documentation.
> 
> Update the comment here accordingly.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Seems similar we need for UART.

> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/dma/dw/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw/pci.c b/drivers/dma/dw/pci.c
> index 8de87b15a988..ad6db1cc287e 100644
> --- a/drivers/dma/dw/pci.c
> +++ b/drivers/dma/dw/pci.c
> @@ -143,7 +143,7 @@ static const struct pci_device_id dw_pci_id_table[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2286), (kernel_ulong_t)&dw_pci_data },
>  	{ PCI_VDEVICE(INTEL, 0x22c0), (kernel_ulong_t)&dw_pci_data },
>  
> -	/* Elkhart Lake iDMA 32-bit (OSE DMA) */
> +	/* Elkhart Lake iDMA 32-bit (PSE DMA) */
>  	{ PCI_VDEVICE(INTEL, 0x4bb4), (kernel_ulong_t)&idma32_pci_data },
>  	{ PCI_VDEVICE(INTEL, 0x4bb5), (kernel_ulong_t)&idma32_pci_data },
>  	{ PCI_VDEVICE(INTEL, 0x4bb6), (kernel_ulong_t)&idma32_pci_data },
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


