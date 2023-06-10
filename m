Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D115672AB5E
	for <lists+dmaengine@lfdr.de>; Sat, 10 Jun 2023 14:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjFJMOO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Jun 2023 08:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjFJMON (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Jun 2023 08:14:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A62D4A;
        Sat, 10 Jun 2023 05:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686399252; x=1717935252;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8elPVM81BdGcGGAZYBdokG8hYC/1QRR+oygJ7EhpjR0=;
  b=R6pTbErsvHXjNx/8KTvQ8+xilrinyIFAhWozcbTmVeJqiOM8UffKVuNe
   FEtbyQ2Qk/fuhM5jEfhnfeUy+pD4LYr4BZvSUUIQNzpTEEs6SM5oIxSfV
   c/44UQN3zeqdmmAUzS4vqdywKvpdax1fP3jJworlu9D9Rb1a209EwOEvz
   aLvpS9l8i9QNMPZ1Dw75GHytse0mfnwew2PGOPE0EqBsIMjS4un6FLlIv
   3wHR7z9R2uY9H/EvftVSOjX4EMGTmZNOf4UZw7Pv/KuKSSwUvOgYU+NLO
   M2fvS8Tk4+hRN4GEH6uB0DWa7beDl7+EMBS/WAth+HfQjPTLlNq/ii/r5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338119665"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="338119665"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 05:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="884879484"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="884879484"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 10 Jun 2023 05:14:07 -0700
Message-ID: <08830c11-5528-0c42-0bc3-89c3796611fe@linux.intel.com>
Date:   Sat, 10 Jun 2023 20:13:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>, rex.zhang@intel.com,
        xiaochen.shen@intel.com, narayan.ranganathan@intel.com
Subject: Re: [PATCH v8 2/7] iommu: Move global PASID allocation from SVA to
 core
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
 <20230602182212.150825-3-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230602182212.150825-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 6/3/23 2:22 AM, Jacob Pan wrote:
> +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> +{
> +	int ret;
> +	ioasid_t max;
> +
> +	max = dev->iommu->max_pasids;
> +	/*
> +	 * max_pasids is set up by vendor driver based on number of PASID bits
> +	 * supported but the IDA allocation is inclusive.
> +	 */
> +	ret = ida_alloc_range(&iommu_global_pasid_ida, IOMMU_FIRST_GLOBAL_PASID, max - 1, GFP_KERNEL);
> +	if (ret < 0)
> +		return IOMMU_PASID_INVALID;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);

"dev->iommu->max_pasids == 0" indicates no pasid support on the device.
The code should return IOMMU_PASID_INVALID explicitly. Perhaps we can
make this function like this:

ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
{
         int ret;

         if (!dev->iommu->max_pasids)
                 return IOMMU_PASID_INVALID;

         /*
          * max_pasids is set up by vendor driver based on number of 
PASID bits
          * supported but the IDA allocation is inclusive.
          */
         ret = ida_alloc_range(&iommu_global_pasid_ida, 
IOMMU_FIRST_GLOBAL_PASID,
                               dev->iommu->max_pasids - 1, GFP_KERNEL);

         return ret < 0 ? IOMMU_PASID_INVALID : ret;
}
EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);

Other change in this series looks good to me.

I hope I can queue this series including above change as part of my VT-d
update for v6.5 to Joerg if no objection.

Let's try to re-enable this key feature of Intel idxd driver in v6.5.

Best regards,
baolu
