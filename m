Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121056D8DB0
	for <lists+dmaengine@lfdr.de>; Thu,  6 Apr 2023 04:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjDFCut (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Apr 2023 22:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjDFCuY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Apr 2023 22:50:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D27F9009;
        Wed,  5 Apr 2023 19:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680749385; x=1712285385;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wNLHlYy6uV4G115SGXQXDrIz1CoHj/OQl8UlKp5dXLs=;
  b=lEkqMSbTxooxglfJ8+0E9V84q+3C0Ip3/mHcIleCPVEq1kGlwX6ZYV70
   joo9cZ//RiAtYOd1jI4kJmB6Cl+exBGaIpL+OGBqg77ou4gYWb0B4p65+
   XN0ba6s+4n4bdzG2p3aVKwRfzYHB5xoPugzkqIeOSEb9pZ4ODAukqPqDV
   SjPPVk9byVNhICDkMEeP1QOqqYUouIwy5bbzPheL92tGSpqjAaqOJFglq
   +9gOIZnRrEyL9zffeXbDnvtsSj4M0YP0jM9kVxOvBD2Xxn0hitmBHltdI
   MqovND55rnh3paZvVzNX8jZ1VeqjI4TDMkC3ckLknTeY8R+bpjflIMe3f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="370457043"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="370457043"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 19:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="1016701974"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="1016701974"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 05 Apr 2023 19:49:40 -0700
Message-ID: <7312331a-71a1-deea-6d17-bd6d968e87d4@linux.intel.com>
Date:   Thu, 6 Apr 2023 10:49:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 7/7] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-8-jacob.jun.pan@linux.intel.com>
 <ZC1mUKH/03QhkcR9@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZC1mUKH/03QhkcR9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 4/5/23 8:15 PM, Jason Gunthorpe wrote:
> On Fri, Mar 31, 2023 at 04:11:37PM -0700, Jacob Pan wrote:
>>   static void idxd_disable_system_pasid(struct idxd_device *idxd)
>>   {
>> +	struct pci_dev *pdev = idxd->pdev;
>> +	struct device *dev = &pdev->dev;
>> +	struct iommu_domain *domain;
>> +	union gencfg_reg gencfg;
>> +
>> +	domain = iommu_get_domain_for_dev(dev);
>> +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
>> +		return;
>> +
>> +	iommu_detach_device_pasid(domain, dev, idxd->pasid);
> This sequence is kinda weird, we shouldn't pass in domain to
> detach_device_pasid, IMHO. We already know the domain because we store
> it in an xarray, it just creates weirdness if the user passes in the
> wrong domain.

The initial idea was that the driver has a domain and it wants to attach
the domain to a pasid of the device. During attaching, iommu core will
save the domain in its xarray.

After use, driver want to detach the domain from the pasid by calling
iommu_detach_device_pasid(). The iommu core will compare the input
domain and the one it saved. A warning will be triggered if they are
different.

	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);

Logically speaking, @domain for detach_device_pasid is unnecessary,
because the pasid array is essentially per-device (as we discussed
before. the pci_enable_pasid() ensures this), although it is currently
placed in the group structure. In that case, the driver can and should
own everything about the pasid and domain. The roles of the iommu core
and the individual driver are only to handle requests of installing or
withdrawing a domain on/from a device's pasid.

Best regards,
baolu
