Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451E76CB67E
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 08:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjC1GED (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Mar 2023 02:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjC1GEC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Mar 2023 02:04:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A02DC;
        Mon, 27 Mar 2023 23:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679983442; x=1711519442;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vnpTrkgWOEL/GwwdpC+uOT5gFwIGgE12DtT51MDVw6A=;
  b=FqAOZ5DLZ7lltQVTjEtMqlwWLDA2pRJrpozoHfiHo4ZQhaXx9yppQKaE
   VSAuk8WJzX7ht3B2VDwRrgdLv5QW7aCkx3A0niMbct/hTh/dZxMM8RSZD
   1eovkLxKBv9BYbnMGmqYK6aDa5R1L31KkOQD6ckpnKDF1Bv8jeZnAbWbQ
   TID8pQzPYEiyFlPxWxpAGEtn4lvZK4K3kHhXpeYSXHKnHD9rcAqdEyB9L
   3ls7pa3SaJCipjIkcs6G2w+HU/coDZYzOuw2SZnZQPBBPgEoDAIbwXiE2
   gjSwyjHL22JikEg1oq35anE7rPzFn8jatbJLVGjRV/W7E8upIOmTqaUc+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="426743807"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="426743807"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 23:04:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="683758172"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="683758172"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 27 Mar 2023 23:03:56 -0700
Message-ID: <e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
Date:   Tue, 28 Mar 2023 14:04:15 +0800
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
Subject: Re: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
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
> Devices that use ENQCMDS to submit work needs to retrieve its DMA
> domain. It can then attach PASID to the DMA domain for shared mapping
> (with RID) established by DMA API.
> 
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/iommu.c | 1 +
>   include/linux/iommu.h | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 10db680acaed..c51d343a75d2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2118,6 +2118,7 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
>   {
>   	return dev->iommu_group->default_domain;
>   }
> +EXPORT_SYMBOL_GPL(iommu_get_dma_domain);

Directly exporting this function for external use seems unsafe. If the
caller is the kernel driver for this device, it's fine because default
domain remains unchanged during the life cycle of the driver. Otherwise,
using this function may cause UAF. Keep in mind that group's default
domain could be changed through sysfs.

However, iommu_get_domain_for_dev() has already done so and has been
exported. Maybe I'm worried too much. :-)

Best regards,
baolu
