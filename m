Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9057191DD
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 06:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjFAE3M (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 00:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjFAE3K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 00:29:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD413A3;
        Wed, 31 May 2023 21:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685593748; x=1717129748;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qG0Umcj9VDUl7x+PwQ4etmpLHYQ/oy15Ct2LJzLgUxw=;
  b=nmMO07Kbb02PC1HGfRNI8QTZzb5c/q51jKDcq2COxEz2WFCWzLfbz2iK
   OyLc+y/Vh2fTpzpe8KhEmD32r0FWJHm9+kY2zlocSHK6AINv9mH9M+x2R
   awSvpDH8kAbC9JUkV4zjoB/8K0I7Oo0W7nRPIGM+V3+4tmMMhhj3lZWI/
   rhoMoGkCgSiqSJM/ldVtrc6onfCXUQ44Mbk21RaXsm+OSpplQxNrhtyU+
   mZiT0vtZ12KZ/iFieCI5fA07osDxvKtqCoS5EvFlL592Sq0wTQ/Cvm1Oo
   0flA6T3wJqywCuS2MrLXq7Pxy4kavAxcM3ni5KDg9JLaT0csDOodXoKTi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="421225083"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="421225083"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 21:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="657605968"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="657605968"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 21:29:06 -0700
Date:   Wed, 31 May 2023 21:33:42 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        narayan.ranganathan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 0/4] Re-enable IDXD kernel workqueue under DMA API
Message-ID: <20230531213342.1a3f1508@jacob-builder>
In-Reply-To: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jason,

Do you have any comments on this set? this is a follow-up of the IOASID
removal series.

Thanks a lot for your time.

Jacob

On Tue, 23 May 2023 10:34:47 -0700, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> Hi Joerg and all,
> 
> IDXD kernel work queues were disabled due to the flawed use of kernel VA
> and SVA API.
> Link:
> https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
> 
> The solution is to enable it under DMA API where IDXD shared workqueue
> users can use ENQCMDS to submit work on buffers mapped by DMA API.
> 
> This patchset adds support for attaching PASID to the device's default
> domain and the ability to allocate global PASIDs from IOMMU APIs. IDXD
> driver can then re-enable the kernel work queues and use them under DMA
> API.
> 
> This depends on the IOASID removal series. (merged)
> https://lore.kernel.org/all/ZCaUBJvUMsJyD7EW@8bytes.org/
> 
> 
> Thanks,
> 
> Jacob
> 
> ---
> Changelog:
> v7:
> 	- renamed IOMMU_DEF_RID_PASID to be IOMMU_NO_PASID to be more
> generic (Jean)
> 	- simplify range checking for sva PASID (Baolu) 
> v6:
> 	- use a simplified version of vt-d driver change for
> set_device_pasid from Baolu.
> 	- check and rename global PASID allocation base
> v5:
> 	- exclude two patches related to supervisor mode, taken by VT-d
> 	maintainer Baolu.
> 	- move PASID range check into allocation API so that device
> drivers only need to pass in struct device*. (Kevin)
> 	- factor out helper functions in device-domain attach (Baolu)
> 	- make explicit use of RID_PASID across architectures
> v4:
> 	- move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
> 	- dropped domain type check while disabling idxd system PASID
> (Baolu)
> 
> v3:
> 	- moved global PASID allocation API from SVA to IOMMU (Kevin)
> 	- remove #ifdef around global PASID reservation during boot
> (Baolu)
> 	- remove restriction on PASID 0 allocation (Baolu)
> 	- fix a bug in sysfs domain change when attaching devices
> 	- clear idxd user interrupt enable bit after disabling device(
> Fenghua) v2:
> 	- refactored device PASID attach domain ops based on Baolu's
> early patch
> 	- addressed TLB flush gap
> 	- explicitly reserve RID_PASID from SVA PASID number space
> 	- get dma domain directly, avoid checking domain types
> 
> 
> 
> Jacob Pan (3):
>   iommu: Generalize PASID 0 for normal DMA w/o PASID
>   iommu: Move global PASID allocation from SVA to core
>   dmaengine/idxd: Re-enable kernel workqueue under DMA API
> 
> Lu Baolu (1):
>   iommu/vt-d: Add set_dev_pasid callback for dma domain
> 
>  drivers/dma/idxd/device.c                     |  30 +---
>  drivers/dma/idxd/dma.c                        |   5 +-
>  drivers/dma/idxd/init.c                       |  60 ++++++-
>  drivers/dma/idxd/sysfs.c                      |   7 -
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  10 +-
>  drivers/iommu/intel/iommu.c                   | 159 +++++++++++++++---
>  drivers/iommu/intel/iommu.h                   |   7 +
>  drivers/iommu/intel/pasid.c                   |   2 +-
>  drivers/iommu/intel/pasid.h                   |   1 -
>  drivers/iommu/iommu-sva.c                     |  28 ++-
>  drivers/iommu/iommu.c                         |  24 +++
>  include/linux/iommu.h                         |  11 ++
>  13 files changed, 261 insertions(+), 85 deletions(-)
> 


Thanks,

Jacob
