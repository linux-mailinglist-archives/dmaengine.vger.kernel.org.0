Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EBA2F8A4F
	for <lists+dmaengine@lfdr.de>; Sat, 16 Jan 2021 02:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbhAPBWR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jan 2021 20:22:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:55631 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbhAPBWR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 Jan 2021 20:22:17 -0500
IronPort-SDR: h43Gi4tTtPS8Qt9K0xdP2ne5XhRI31Vg0ejPlIr6vNion1y8TLLObYRoZj7Ri81+ogRPJ8TQLv
 TOMESzq7hIag==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="178778399"
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="178778399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 17:20:28 -0800
IronPort-SDR: DznnGYuwJ/UxxQrmQGJd5b9g6Om3RrfpkvoMPBs122KxptEO3Brz/fbs5840Umw7sUzZLqkujt
 GGgy0p/jLtsg==
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="382861945"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.175.94]) ([10.249.175.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 17:20:18 -0800
Cc:     baolu.lu@linux.intel.com, tglx@linutronix.de, ashok.raj@intel.com,
        kevin.tian@intel.com, dave.jiang@intel.com, megha.dey@intel.com,
        dwmw2@infradead.org, alex.williamson@redhat.com,
        bhelgaas@google.com, dan.j.williams@intel.com, will@kernel.org,
        joro@8bytes.org, dmaengine@vger.kernel.org, eric.auger@redhat.com,
        jacob.jun.pan@intel.com, jgg@mellanox.com, kvm@vger.kernel.org,
        kwankhede@nvidia.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        maz@kernel.org, mona.hossain@intel.com, netanelg@mellanox.com,
        parav@mellanox.com, pbonzini@redhat.com, rafael@kernel.org,
        samuel.ortiz@intel.com, sanjay.k.kumar@intel.com,
        shahafs@mellanox.com, tony.luck@intel.com, vkoul@kernel.org,
        yan.y.zhao@linux.intel.com, yi.l.liu@intel.com
Subject: Re: [RFC PATCH v3 1/2] iommu: Add capability IOMMU_CAP_VIOMMU
To:     Leon Romanovsky <leon@kernel.org>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
 <20210114013003.297050-2-baolu.lu@linux.intel.com>
 <20210114132627.GA944463@unreal>
 <b0c8b260-8e23-a5bd-d2da-ca1d67cdfa8a@linux.intel.com>
 <20210115063108.GI944463@unreal>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c58adc13-306a-8df8-19e1-27f834b3a7c9@linux.intel.com>
Date:   Sat, 16 Jan 2021 09:20:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210115063108.GI944463@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 2021/1/15 14:31, Leon Romanovsky wrote:
> On Fri, Jan 15, 2021 at 07:49:47AM +0800, Lu Baolu wrote:
>> Hi Leon,
>>
>> On 1/14/21 9:26 PM, Leon Romanovsky wrote:
>>> On Thu, Jan 14, 2021 at 09:30:02AM +0800, Lu Baolu wrote:
>>>> Some vendor IOMMU drivers are able to declare that it is running in a VM
>>>> context. This is very valuable for the features that only want to be
>>>> supported on bare metal. Add a capability bit so that it could be used.
>>>
>>> And how is it used? Who and how will set it?
>>
>> Use the existing iommu_capable(). I should add more descriptions about
>> who and how to use it.
> 
> I want to see the code that sets this capability.

Currently we have Intel VT-d and the virt-iommu setting this capability.

  static bool intel_iommu_capable(enum iommu_cap cap)
  {
  	if (cap == IOMMU_CAP_CACHE_COHERENCY)
  		return domain_update_iommu_snooping(NULL) == 1;
  	if (cap == IOMMU_CAP_INTR_REMAP)
  		return irq_remapping_enabled == 1;
+	if (cap == IOMMU_CAP_VIOMMU)
+		return caching_mode_enabled();

  	return false;
  }

And,

+static bool viommu_capable(enum iommu_cap cap)
+{
+	if (cap == IOMMU_CAP_VIOMMU)
+		return true;
+
+	return false;
+}

Best regards,
baolu
