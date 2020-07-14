Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077A21F59F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 17:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgGNPCg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 11:02:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:40152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNPCg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Jul 2020 11:02:36 -0400
IronPort-SDR: MuQtLfp5wUQR8AQ+Xzhkgxy18QVAH6s/W6u4B+UEFAcNkJLAiD7Lh+kmr2MscKWDChvmjigKqU
 aqA55BMtpkfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="150342742"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="150342742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 07:58:10 -0700
IronPort-SDR: vSELINP7Oka841b1XQ5v0T1yejLWoHKcTeuMZInm+KpwF7plU6OAN89HR0vw7g7DJV83rweBeN
 1ZmvFmAmP9oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="307898089"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.140.223]) ([10.209.140.223])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2020 07:58:09 -0700
Subject: Re: [PATCH -next] dmaengine: idxd: fix PCI_MSI build errors
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <9dee3f46-70d9-ea75-10cb-5527ab297d1d@infradead.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <46ae481e-3213-f1e0-604b-177bc876bb93@intel.com>
Date:   Tue, 14 Jul 2020 07:58:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9dee3f46-70d9-ea75-10cb-5527ab297d1d@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/13/2020 11:35 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors when CONFIG_PCI_MSI is not enabled by making the
> driver depend on PCI_MSI:
> 
> ld: drivers/dma/idxd/device.o: in function `idxd_mask_msix_vector':
> device.c:(.text+0x26f): undefined reference to `pci_msi_mask_irq'
> ld: drivers/dma/idxd/device.o: in function `idxd_unmask_msix_vector':
> device.c:(.text+0x2af): undefined reference to `pci_msi_unmask_irq'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: dmaengine@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>

Vinod, I submitted this fix patch last week:
https://patchwork.kernel.org/patch/11649231/

But I think maybe Randy's patch may be more preferable? You can apply this one 
and ignore my submission.

> ---
>   drivers/dma/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- mmotm-2020-0713-1949.orig/drivers/dma/Kconfig
> +++ mmotm-2020-0713-1949/drivers/dma/Kconfig
> @@ -285,6 +285,7 @@ config INTEL_IDMA64
>   config INTEL_IDXD
>   	tristate "Intel Data Accelerators support"
>   	depends on PCI && X86_64
> +	depends on PCI_MSI
>   	depends on SBITMAP
>   	select DMA_ENGINE
>   	help
> 
> 
