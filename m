Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51A6BC74D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Mar 2023 08:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCPHfI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 03:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjCPHer (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 03:34:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6050595BCC;
        Thu, 16 Mar 2023 00:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678952052; x=1710488052;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/RZV+NKoVH+A+UzBt07KdobJa/g/QegZ+SlgrfhPIfk=;
  b=Xmylb12X6N9lZIkfbDlTIQrhYP/b85O8NGOh8Wq/b1GevykvmYr4e/tV
   YpU6LVbyyzbVL0Ub5Sp7oMorK2u40Cjw7W43Ya8TWtv8zPcj9JsqwgsaM
   YMftK5totAdNLpmYgHXuRfgBUcQtRAAMkIVt4BH8AjC0Npt1DQX933H39
   owAo3+fzf/N5YZvjcrE9loGSe3olVJ1bPopDPAh7Ga8uom7X9RD7MXnLz
   X8TTg9Vx+oCP0MaE5nn1uKvx9L6WA4jxobWSYFFWT61U7zG4i9CelIjRJ
   Hc16eBZeka49tnYxco6KtaDhlLDEIIbT8pqb9Vf5bRTnYoT+j2WYzVb18
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321755345"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="321755345"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="657087475"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="657087475"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.173.173]) ([10.249.173.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 00:31:21 -0700
Message-ID: <9cd8f9b8-2362-2145-6f5d-edf47087aca3@linux.intel.com>
Date:   Thu, 16 Mar 2023 15:31:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] iommu/vt-d: Allow SVA with device-specific IOPF
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <20230309025639.26109-1-baolu.lu@linux.intel.com>
 <20230309025639.26109-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F50D86F8DA507CC18AF18CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F50D86F8DA507CC18AF18CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/3/16 15:09, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, March 9, 2023 10:57 AM
>>
>> @@ -4650,7 +4650,18 @@ static int intel_iommu_enable_sva(struct device
>> *dev)
>>   	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
>>   		return -ENODEV;
>>
>> -	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
>> +	if (!info->pasid_enabled)
>> +		return -EINVAL;
>> +
> 
> I think you still want to check ats_enabled even for device specific IOPF.

Yeah! Updated.

Best regards,
baolu
