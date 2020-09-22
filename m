Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17722749FA
	for <lists+dmaengine@lfdr.de>; Tue, 22 Sep 2020 22:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVUSR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Sep 2020 16:18:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:36376 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVUSQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Sep 2020 16:18:16 -0400
IronPort-SDR: p16aI1w2wrbJDPLr6jmNAtwKUX/zL7W7zeMeUlXA6xKnkDmnLbCFJ8/ejrChun7L2BmsSVyjJZ
 GThEmrQRH3gA==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="148367164"
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="148367164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 13:18:15 -0700
IronPort-SDR: XTAigLGP4M5j62RLH4ili/V8WI/V1kXS/M+4Bf/wA1PLcB7ndh1UV0/siwC6127ujDxTpMgxaA
 HT2lNvPfoZ/w==
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="454626468"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.69.50]) ([10.212.69.50])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 13:18:15 -0700
Subject: Re: [PATCH] dmaengine: ioat: Allocate correct size for descriptor
 chunk
To:     Logan Gunthorpe <logang@deltatee.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200922200844.2982-1-logang@deltatee.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <a8dacb00-ae27-f5d1-c8f7-5c06853e8b69@intel.com>
Date:   Tue, 22 Sep 2020 13:18:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922200844.2982-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 9/22/2020 1:08 PM, Logan Gunthorpe wrote:
> dma_alloc_coherent() is called with a fixed SZ_2M size, but frees happen
> with IOAT_CHUNK_SIZE. Recently, IOAT_CHUNK_SIZE was reduced to 512M but
> the allocation did not change. To fix, change to using the
> IOAT_CHUNK_SIZE define.
> 
> This was caught with the upcoming patchset for converting Intel platforms to the
> dma-iommu implementation. It has a warning when the unmapped size differs from
> the mapped size.
> 
> Fixes: a02254f8a676 ("dmaengine: ioat: Decreasing allocation chunk size 2M->512K")
> Link: https://lore.kernel.org/intel-gfx/776771a2-247a-d1be-d882-bee02d919ae0@deltatee.com/
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

Thanks Logan.

> ---
>   drivers/dma/ioat/dma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index a814b200299b..07296171e2bb 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -389,7 +389,7 @@ ioat_alloc_ring(struct dma_chan *c, int order, gfp_t flags)
>   		struct ioat_descs *descs = &ioat_chan->descs[i];
>   
>   		descs->virt = dma_alloc_coherent(to_dev(ioat_chan),
> -						 SZ_2M, &descs->hw, flags);
> +					IOAT_CHUNK_SIZE, &descs->hw, flags);
>   		if (!descs->virt) {
>   			int idx;
>   
> 
> base-commit: ba4f184e126b751d1bffad5897f263108befc780
> 
