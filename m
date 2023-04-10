Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422EF6DC279
	for <lists+dmaengine@lfdr.de>; Mon, 10 Apr 2023 03:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjDJB7o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Apr 2023 21:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDJB7n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Apr 2023 21:59:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790D3AA1;
        Sun,  9 Apr 2023 18:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681091982; x=1712627982;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/IJTEHav6M6hQw5IBxvXX3JshX32DmEiQxkwLFfjo7k=;
  b=VAe7BtcK9RytSLwBDHTJRbSxxV8rjSMNwyT/M+C2Z6GpeH5mOPAAY3C1
   7shHEJOFRHd8yUdM8EBe9eslZWnhXrnN7Km+6zRFIDqTwH0ydLlufOT/g
   zBvs6Oc26PTAczD9ZILhGM3NNuHrBTpWYu9SiUatnbHYlexWdUiaP0qh7
   rb00uLYshiskK8Al3PvbaQT6ey4Nzr5axijwCNl/13FJIQ8eHzuQ+EswE
   0jIliJINMQweij9q4mJr47mqu+Sg8I34wnSCiq2El2RcrYuIRFnnh7w4N
   V/E0Vvu9GQJIJZIPQFUCi1otJL107qq1EEcS3XZQZ3hFjUSf+nW4ROlHm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="322901950"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="322901950"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 18:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="681593333"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="681593333"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 09 Apr 2023 18:59:38 -0700
Message-ID: <c8373d68-9f15-e9a5-d19f-c050f23ac85d@linux.intel.com>
Date:   Mon, 10 Apr 2023 09:59:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Reserve RID_PASID from global PASID
 space
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
 <20230407180554.2784285-5-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230407180554.2784285-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/8/23 2:05 AM, Jacob Pan wrote:
> On VT-d platforms, RID_PASID is used for DMA request without PASID. We
> should not treat RID_PASID special instead let it be allocated from the
> global PASID number space. Non-zero value can be used in RID_PASID on
> Intel VT-d.
> 
> For ARM, AMD and others that_always_  use 0 as RID_PASID, there is no
> impact in that SVA PASID allocation base is 1.
> 
> With this change, devices do both DMA with PASID and SVA will not worry
> about conflicts when it comes to allocating PASIDs for in-kernel DMA.
> 
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9f737ef55463..cbb2670f88ca 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
>   
>   	intel_iommu_enabled = 1;
>   
> +	/* Reserved RID_PASID from the global namespace for legacy DMA */
> +	WARN_ON(iommu_alloc_global_pasid(PASID_RID2PASID, PASID_RID2PASID) !=
> +		PASID_RID2PASID);

How about moving above line up a bit? For example, at least before
iommu_device_register(). This is the starting point where device drivers
may want global PASIDs.

Best regards,
baolu
