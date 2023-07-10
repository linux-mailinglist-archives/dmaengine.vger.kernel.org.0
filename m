Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EF274DC08
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jul 2023 19:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGJRNT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jul 2023 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjGJRNR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jul 2023 13:13:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C39C12B;
        Mon, 10 Jul 2023 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689009196; x=1720545196;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mM9exNdxqVDYS/BxudcSWkCg4TByqBcCVt/yPpweeFA=;
  b=YZ628KiLKqb0HkR/NgCSAJ4JpW2rRHVnNojmjuDPlhSiByOYVQeLVLAc
   GRKUOFEGGcvaeuGLfeLDKrq0DUObXrtdss/bPD5WHITzUarr8owNXwK2A
   QxF/84NFrQxC0u8vOxoCoae++aRJAWvBHY+IWY4dbIRhfeYcPQv8hlgJm
   Z3ykssqfv5gtREdf/Nc5ldis2BkU21Zp4qs7kRZ+KRxXbo6p0taGL9W8u
   OosJE/6z5mkP/sSSkVKIn8/tW0tqWL24YqbyfpxfrFyLgVk+C32BA+XgC
   C2fNoVX5qsuM6J5YzJCdlmQ3DYCUn0RmveQlPxSeMY7HjvvDXX8bLldvF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="344726605"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="344726605"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 10:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="1051434143"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="1051434143"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 10:13:14 -0700
Date:   Mon, 10 Jul 2023 10:18:10 -0700
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
        "Zanussi, Tom" <tom.zanussi@intel.com>, rex.zhang@intel.com,
        xiaochen.shen@intel.com, narayan.ranganathan@intel.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v9 0/7] Re-enable IDXD kernel workqueue under DMA API
Message-ID: <20230710101810.40098ce3@jacob-builder>
In-Reply-To: <20230621205947.1327094-1-jacob.jun.pan@linux.intel.com>
References: <20230621205947.1327094-1-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Baolu, Joerg, and all,

Just wondering if there are more comments?

Thanks,

Jacob

On Wed, 21 Jun 2023 13:59:40 -0700, Jacob Pan
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
> v9:
> 	- Fix an IDXD driver issue where user interrupt enable bit got
> cleared during device enable/disable cycle. Reported and tested by
> 	  Tony Zhu <tony.zhu@intel.com>
> 	- Rebased to v6.4-rc7
> v8:
> 	- further vt-d driver refactoring (3-6) around set/remove device
> PASID (Baolu)
> 	- make consistent use of NO_PASID in SMMU code (Jean)
> 	- fix off-by-one error in max PASID check (Kevin)
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
> Jacob Pan (3):
>   iommu: Generalize PASID 0 for normal DMA w/o PASID
>   iommu: Move global PASID allocation from SVA to core
>   dmaengine/idxd: Re-enable kernel workqueue under DMA API
> 
> Lu Baolu (4):
>   iommu/vt-d: Add domain_flush_pasid_iotlb()
>   iommu/vt-d: Remove pasid_mutex
>   iommu/vt-d: Make prq draining code generic
>   iommu/vt-d: Add set_dev_pasid callback for dma domain
> 
>  drivers/dma/idxd/device.c                     |  39 ++---
>  drivers/dma/idxd/dma.c                        |   5 +-
>  drivers/dma/idxd/idxd.h                       |   9 +
>  drivers/dma/idxd/init.c                       |  54 +++++-
>  drivers/dma/idxd/sysfs.c                      |   7 -
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  16 +-
>  drivers/iommu/intel/iommu.c                   | 161 +++++++++++++++---
>  drivers/iommu/intel/iommu.h                   |   9 +
>  drivers/iommu/intel/pasid.c                   |   2 +-
>  drivers/iommu/intel/pasid.h                   |   2 -
>  drivers/iommu/intel/svm.c                     |  53 +-----
>  drivers/iommu/iommu-sva.c                     |  28 ++-
>  drivers/iommu/iommu.c                         |  28 +++
>  include/linux/iommu.h                         |  11 ++
>  15 files changed, 291 insertions(+), 135 deletions(-)
> 


Thanks,

Jacob
