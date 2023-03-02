Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB76A840D
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 15:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCBOUa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 09:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjCBOU3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 09:20:29 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C9C19F1F;
        Thu,  2 Mar 2023 06:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677766828; x=1709302828;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3676zTBvU6TZnvPW7IT27dMb+Hxhu8evGp71QQAk5BI=;
  b=hFy/LeqKbvY+wnkS1L07Qdxu3VFeCUAgJdFagw/3CZFLgfy9wc9mpwGq
   iVMU8cgDfa9HzNJofa0ryhE2zsVURybhwvzVcZwtnsY51FYWqc5iMTB0j
   spY/9rrhw6VbRwnfzN7Hv0zFZjw+Z29Rfjxwc+YjmQrc87Kqu2cQXkIqE
   5Vi14Ri1jZvn52EiyRpXiL3jK5DhY7bK1pG3ibTzyXaVkHwuBy9c2x2x7
   2/taGh+PxFkLJl/o3rqumTWgkeIMBmNsC6L1JZiVsU8peL0JB6OJB52DW
   bok+94+nP78FUhi1JFOPN0QtS5JxIIyigh3O4eBZ+OZf1Zl0iiGD62MGR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="397299707"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="397299707"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 06:11:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="739086119"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="739086119"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.218]) ([10.254.214.218])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 06:11:39 -0800
Message-ID: <0afa8e6e-1676-d6a5-d679-173351fe439c@linux.intel.com>
Date:   Thu, 2 Mar 2023 22:11:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH 2/4] iommu/vt-d: Use non-privileged mode for all PASIDs
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
 <20230302005959.2695267-3-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230302005959.2695267-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/3/2 8:59, Jacob Pan wrote:
> For in-kernel DMA, use non-privileged access for all PASIDs to be
> consistent with RID_PASID.
> There's no need to differentiate user and kernel for in-kernel DMA. >
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a0cb3bc851ac..9e3c056e392d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2334,8 +2334,6 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>   	if (level != 4 && level != 5)
>   		return -EINVAL;
>   
> -	if (pasid != PASID_RID2PASID)
> -		flags |= PASID_FLAG_SUPERVISOR_MODE;

With above removed, PASID_FLAG_SUPERVISOR_MODE is not used anywhere?
Perhaps you can cleanup it to avoid dead code?

>   	if (level == 5)
>   		flags |= PASID_FLAG_FL5LP;
>   

Best regards,
baolu
