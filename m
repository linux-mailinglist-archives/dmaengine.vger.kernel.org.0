Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2CB6CB22A
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 01:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjC0XRj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 19:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0XRi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 19:17:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121872108;
        Mon, 27 Mar 2023 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679959058; x=1711495058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KkXAum0ih9g0sRekV8u6QaT0HhDiaD3XBnOPlV66GzA=;
  b=fMQULEukIMV9/68K0Ug26SXu/EOImIe/G0SkNX6dlN/S1nzXEXbN+x/r
   682DJN8jmWuG9llT1a7ET4vvR5K3KGNr/RNwsaH3llBu8pUBSR3/o7lSO
   d7Y0mLrqPIXoVyrjlJS7y5h3CVbjGsPZcvJGWi3Jijs3qFdBhdBHUSJDX
   4eQRA952aW/mWGqG+odCopIt+ldEPqFmPW9rnoIsMhOIz3/LuxClwcs9P
   SNjNwaEPF4xGNTVzRUHYu5d9js6QHmTcMD6gI+bCVx36JfX3pSYullOfF
   CprYrlknWfMKHVLq4nT4t7VRTVEu9uZomej9z7Qi3srYhmL+c9r4/BoXP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320817287"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320817287"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 16:17:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686144706"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686144706"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2023 16:17:36 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 0/8] Re-enable IDXD kernel workqueue under DMA API
Date:   Mon, 27 Mar 2023 16:21:30 -0700
Message-Id: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=AC_FROM_MANY_DOTS,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi all,

IDXD kernel work queues were disabled due to the flawed use of kernel VA
and SVA API.
Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/

The solution is to enable it under DMA API where IDXD shared workqueue users
can use ENQCMDS to submit work on buffers mapped by DMA API.

This patchset adds support for attaching PASID to the device's default
domain and the ability to reserve global PASIDs from SVA APIs. We can then
re-enable the kernel work queues and use them under DMA API.

This depends on the IOASID removal series.
https://lore.kernel.org/linux-iommu/20230301235646.2692846-1-jacob.jun.pan@linux.intel.com/T/#t

Thanks,

---
Changelog:
v2:
	- refactored device PASID attach domain ops based on Baolu's early patch
	- addressed TLB flush gap
	- explicitly reserve RID_PASID from SVA PASID number space
	- get dma domain directly, avoid checking domain types

Jacob

Jacob Pan (8):
  iommu/vt-d: Use non-privileged mode for all PASIDs
  iommu/vt-d: Remove PASID supervisor request support
  iommu/sva: Support reservation of global SVA PASIDs
  iommu/vt-d: Reserve RID_PASID from global SVA PASID space
  iommu/vt-d: Make device pasid attachment explicit
  iommu/vt-d: Implement set_dev_pasid domain op
  iommu: Export iommu_get_dma_domain
  dmaengine/idxd: Re-enable kernel workqueue under DMA API

 drivers/dma/idxd/device.c   |  30 +-----
 drivers/dma/idxd/init.c     |  51 +++++++++-
 drivers/dma/idxd/sysfs.c    |   7 --
 drivers/iommu/intel/iommu.c | 188 ++++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h |   8 ++
 drivers/iommu/intel/pasid.c |  43 ---------
 drivers/iommu/intel/pasid.h |   7 --
 drivers/iommu/iommu-sva.c   |  33 +++++++
 drivers/iommu/iommu.c       |   1 +
 include/linux/iommu.h       |  19 ++++
 10 files changed, 261 insertions(+), 126 deletions(-)

-- 
2.25.1

