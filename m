Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311C66D2B92
	for <lists+dmaengine@lfdr.de>; Sat,  1 Apr 2023 01:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCaXHe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 19:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCaXHd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 19:07:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EDB5BB4;
        Fri, 31 Mar 2023 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680304053; x=1711840053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DnaRmj+QiMWJCcTf2AJsdp5uoJ6bEGi3YKrWISZOyzI=;
  b=Og74AqYffJVqGW4ToNfwET3v1Jbz7TizZ8CW4sf1JtE1rX5eFKNCuwkN
   QTg85dGgfFuFviAyYXBp3NdZLIy1Fpv5m2CTD8LuI9vwmv8cjwOXQyxnV
   ct9A/N7HRkd5ObmvIyt3dABHwb0IdkzUhW5bf1LFOnDmn3EJZH5zZ+ej/
   e49bW5OwLrZRoCumv1kCWPtZJvnqTMyUi7pSqwZQSOQVJYnqiW2ayP2yt
   YQhE6PeIKOTL7tUxu1RofbZ1VNVtZK8ricKPSt4b15rooSV5yMAfI7yFA
   C0VSdq7bDztoTMLtf0dHPT1nRVBdjI4SNywEr7KanMXyaN2L+kYggCmDM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343245119"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343245119"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="717888334"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="717888334"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2023 16:07:32 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org
Cc:     "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 0/7] Re-enable IDXD kernel workqueue under DMA API
Date:   Fri, 31 Mar 2023 16:11:30 -0700
Message-Id: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=AC_FROM_MANY_DOTS,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
https://lore.kernel.org/all/ZCaUBJvUMsJyD7EW@8bytes.org/


Thanks,

Jacob

---
Changelog:
v3:
	- moved global PASID allocation API from SVA to IOMMU (Kevin)
	- remove #ifdef around global PASID reservation during boot (Baolu)
	- remove restriction on PASID 0 allocation (Baolu)
	- fix a bug in sysfs domain change when attaching devices
	- clear idxd user interrupt enable bit after disabling device( Fenghua)
v2:
	- refactored device PASID attach domain ops based on Baolu's early patch
	- addressed TLB flush gap
	- explicitly reserve RID_PASID from SVA PASID number space
	- get dma domain directly, avoid checking domain types



Jacob Pan (7):
  iommu/vt-d: Use non-privileged mode for all PASIDs
  iommu/vt-d: Remove PASID supervisor request support
  iommu/sva: Support allocation of global PASIDs outside SVA
  iommu/vt-d: Reserve RID_PASID from global PASID space
  iommu/vt-d: Make device pasid attachment explicit
  iommu/vt-d: Implement set_dev_pasid domain op
  dmaengine/idxd: Re-enable kernel workqueue under DMA API

 drivers/dma/idxd/device.c   |  30 +-----
 drivers/dma/idxd/init.c     |  56 ++++++++++-
 drivers/dma/idxd/sysfs.c    |   7 --
 drivers/iommu/intel/iommu.c | 180 +++++++++++++++++++++++++++++-------
 drivers/iommu/intel/iommu.h |   8 ++
 drivers/iommu/intel/pasid.c |  43 ---------
 drivers/iommu/intel/pasid.h |   7 --
 drivers/iommu/iommu-sva.c   |  10 +-
 drivers/iommu/iommu.c       |  33 +++++++
 include/linux/iommu.h       |  10 ++
 10 files changed, 257 insertions(+), 127 deletions(-)

-- 
2.25.1

