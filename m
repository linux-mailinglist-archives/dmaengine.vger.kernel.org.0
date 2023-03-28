Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0C6CB5DD
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 07:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjC1FUH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 01:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC1FUG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 01:20:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC7619B4;
        Mon, 27 Mar 2023 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679980805; x=1711516805;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2WDW1HbB8GiBw48W4/RWUGSXww0Cy5qMfC0++e9jU44=;
  b=GLnAKJu88VH2dHAeeeD+Nrwg0OmQX4qRxy6KZbVOZwtqFYIgdtBtk4gM
   dOfcbPfy5WjJuDx28SPjmh2+jgT16VxvEe59rI6KYUbEhCsyJ3zV+Lr8K
   +kwCLZYFtcHGKQ8WsqKw8XxlESMz9lr0c/TVyrC0iwFlw0hdqLCAf+c09
   pscQccPt79654w5ip8k/1ASpXWWH6EMTA+iaQhbmm0cwssNWH5KMx8kiR
   ivkc6RwV74iywg7kqRdJtQcDbj89yGabxqOcPB6D0GLvUIst39qe+SbGt
   zQRyFRMQLC30hWn2wE1/wisG2QAtJDW93ZvJdhhkD05Rp+x6ORzTR0210
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="403082808"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="403082808"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="633887906"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="633887906"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2023 22:20:00 -0700
Message-ID: <41d31adf-577e-431c-c400-2708885400c1@linux.intel.com>
Date:   Tue, 28 Mar 2023 13:20:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v2 4/8] iommu/vt-d: Reserve RID_PASID from global SVA
 PASID space
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 3/28/23 7:21 AM, Jacob Pan wrote:
> On VT-d platforms, RID_PASID is used for DMA request without PASID. We
> should not treat RID_PASID special instead let it be allocated from the
> global SVA PASID number space.

It's same to AMD and ARM SMMUv3, right? They also need an explicit
reservation of PASID 0.

> 
> Consequently, for devices also do DMA with PASID, drivers will not worry
> about conflicts when it comes to allocating PASIDs for in-kernel DMA.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9f737ef55463..61c06f7ad8f7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
>   
>   	intel_iommu_enabled = 1;
>   
> +#ifdef CONFIG_INTEL_IOMMU_SVM

Do we really need this #ifdef? IOMMU_SVA is selected by INTEL_IOMMU_SVM,
right? So if CONFIG_INTEL_IOMMU_SVM is not set,
iommu_sva_reserve_pasid() is just a dumb.

> +	/* Reserved RID_PASID from the global namespace for legacy DMA */
> +	iommu_sva_reserve_pasid(PASID_RID2PASID, PASID_RID2PASID);
> +#endif
>   	return 0;
>   
>   out_free_dmar:

Best regards,
baolu
