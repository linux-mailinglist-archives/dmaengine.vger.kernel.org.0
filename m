Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3406F0B3E
	for <lists+dmaengine@lfdr.de>; Thu, 27 Apr 2023 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbjD0Rpl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Apr 2023 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbjD0Rpj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Apr 2023 13:45:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACFE35A5;
        Thu, 27 Apr 2023 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682617521; x=1714153521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sL1Oogrx9xSZdLUnJG5ws6JoMbQTO9hqS3tsfFCI38U=;
  b=UwEImCoa0/Gi6LOCz6SeD1pb5ujIdyhBVu6NHPJrwUOpTGkXwsaDA+9I
   fI6q+cDwJYno3oPoSn8UsWZ48cFTmheXSk4ZZJnsaVz8pXoIBEEAaAmgM
   LrA9v5CzMdKOhlVzUIcXxcUJwNMVv6GpwUB3tit384cuJZRvhTQxSFrGg
   Vt5fptj2S+OFoUuCDaa00lGi6mX8Fe7uTLCljRbn902kYMo1UnLUKdHhc
   kQDlvpqyAmG2oUvxXY4Nk8ArMZWoG9rt17Iijxv7dcy9noJ7+XDg7HmGC
   T6G4iBRfplX4OvmvCVxB1lgC3G2plme+T9uatjcHSg7tWAyGAZPAXBUNM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="350398689"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="350398689"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 10:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024219686"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="1024219686"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 27 Apr 2023 10:45:19 -0700
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
        narayan.ranganathan@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 0/7] Re-enable IDXD kernel workqueue under DMA API
Date:   Thu, 27 Apr 2023 10:49:30 -0700
Message-Id: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
domain and the ability to allocate global PASIDs from IOMMU APIs. We can then
re-enable the kernel work queues and use them under DMA API.

This depends on the IOASID removal series. (merged)
https://lore.kernel.org/all/ZCaUBJvUMsJyD7EW@8bytes.org/


Thanks,

Jacob

---
Changelog:
v5:
	- exclude two patches related to supervisor mode, taken by VT-d
	maintainer Baolu.
	- move PASID range check into allocation API so that device drivers
	  only need to pass in struct device*. (Kevin)
	- factor out helper functions in device-domain attach (Baolu)
	- make explicit use of RID_PASID across architectures
v4:
	- move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
	- dropped domain type check while disabling idxd system PASID (Baolu)

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


Jacob Pan (6):
  iommu: Generalize default PCIe requester ID PASID
  iommu/sva: Explicitly exclude RID_PASID from SVA
  iommu: Move global PASID allocation from SVA to core
  iommu/vt-d: Prepare PASID attachment beyond RID_PASID
  iommu/vt-d: Implement set_dev_pasid domain op
  dmaengine/idxd: Re-enable kernel workqueue under DMA API

Lu Baolu (1):
  iommu/vt-d: Factoring out PASID set up helper function

 drivers/dma/idxd/device.c   |  30 +----
 drivers/dma/idxd/init.c     |  60 ++++++++-
 drivers/dma/idxd/sysfs.c    |   7 --
 drivers/iommu/intel/iommu.c | 240 +++++++++++++++++++++++++++++-------
 drivers/iommu/intel/iommu.h |   8 ++
 drivers/iommu/intel/pasid.c |   2 +-
 drivers/iommu/intel/pasid.h |   1 -
 drivers/iommu/iommu-sva.c   |  25 +---
 drivers/iommu/iommu.c       |  24 ++++
 include/linux/iommu.h       |  10 ++
 10 files changed, 305 insertions(+), 102 deletions(-)

-- 
2.25.1

