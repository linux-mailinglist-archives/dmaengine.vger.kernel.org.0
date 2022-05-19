Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7A52CC33
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 08:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiESGuv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 02:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiESGuv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 02:50:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F44513F6F;
        Wed, 18 May 2022 23:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652943049; x=1684479049;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rjhxdtU/rJ1XS+TF9ytej5Qm9UaG/+F24zp9IID0CGw=;
  b=U+AnlNPdVTu8qCjCxFNbbF+J5G/dCuomWwD3cPrDiD1jQNdbIgFEe21b
   kVGfTjc2ENeGf6TxpSzRsRx4klnTBMPkBS0TbtUD77Ls/NYBGQsbP16dh
   dXXS4zHwuHi6z1HeOsdoL6lYxUIqhryedyZtP4UZlRlDq2DioP9+Lv6hB
   3JVgpSUcP61xnYVBiEkLFrkuuu/Jur7tBr6qGyNHBopEuDFMUHvgYAHUI
   Yj9eLVVlpx4UoESZc97zjUpeMipd96NyfxMP9HoWScm5pl9Pte0/+jHc4
   Oj1pTFkF8DVtvBHJKsP9rmV/jdI3XTZGY5lx/nBmTKhBz5tA4SZIq/s+H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="251949877"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="251949877"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 23:50:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="742755243"
Received: from zhongz9x-mobl.ccr.corp.intel.com (HELO [10.255.28.182]) ([10.255.28.182])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 23:50:44 -0700
Message-ID: <6e5079d1-1bdb-1b36-3884-0112f2557271@linux.intel.com>
Date:   Thu, 19 May 2022 14:50:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 1/6] iommu: Add a per domain PASID for DMA API
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org
References: <20220518182120.1136715-1-jacob.jun.pan@linux.intel.com>
 <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220518182120.1136715-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2022/5/19 02:21, Jacob Pan wrote:
> DMA requests tagged with PASID can target individual IOMMU domains.
> Introduce a domain-wide PASID for DMA API, it will be used on the same
> mapping as legacy DMA without PASID. Let it be IOVA or PA in case of
> identity domain.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   include/linux/iommu.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 9405034e3013..36ad007084cc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -106,6 +106,8 @@ struct iommu_domain {
>   	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
>   						      void *data);
>   	void *fault_data;
> +	ioasid_t dma_pasid;		/* Used for DMA requests with PASID */

This looks more suitable for iommu_dma_cookie?

> +	atomic_t dma_pasid_users;
>   };
>   
>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)

Best regards,
baolu
