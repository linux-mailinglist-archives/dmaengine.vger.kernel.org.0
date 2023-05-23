Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108A870E348
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbjEWRaY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbjEWRaX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 13:30:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E3797;
        Tue, 23 May 2023 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684863022; x=1716399022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cEJSLPDvzjlLklZPDg24lbhzBd1u5HoZaAKoC5OD1wQ=;
  b=BesdEZaGjucrCSUpAlpU3H0acaqMhKVrl7izBTXtIWCBvc05YFefcCZX
   mmYrM2fKooThef2KBju2V591uumsXASbo9oMx9DuE9yMeAo7VA+qE2Uhf
   ySWpruiyHdM2Zmw8Lr3mm0y7bs6yKU+ANTsa/Elsg/RDKz6NAmk0fc69x
   aKsfPErMS1xxvdr2CoZW6U0nk1NbLRh0upm4w//aFTDyPrKYBz3TXARhl
   lu1jHR3p8ri3LTrbXBDZkTVdmZlhxbPhoGRySZI5VwUME2cKUkG3W2d3P
   37s6zGpH3lvdxhUIad3hmRzhsImVrvBoaVovl458Kb8gYWNH5nZ+pi4K4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="337892789"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="337892789"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 10:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="1034170002"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="1034170002"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by fmsmga005.fm.intel.com with ESMTP; 23 May 2023 10:30:20 -0700
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
        narayan.ranganathan@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v7 0/4] Re-enable IDXD kernel workqueue under DMA API
Date:   Tue, 23 May 2023 10:34:47 -0700
Message-Id: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Joerg and all,

IDXD kernel work queues were disabled due to the flawed use of kernel VA
and SVA API.
Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/

The solution is to enable it under DMA API where IDXD shared workqueue users
can use ENQCMDS to submit work on buffers mapped by DMA API.

This patchset adds support for attaching PASID to the device's default
domain and the ability to allocate global PASIDs from IOMMU APIs. IDXD driver
can then re-enable the kernel work queues and use them under DMA API.

This depends on the IOASID removal series. (merged)
https://lore.kernel.org/all/ZCaUBJvUMsJyD7EW@8bytes.org/


Thanks,

Jacob

---
Changelog:
v7:
	- renamed IOMMU_DEF_RID_PASID to be IOMMU_NO_PASID to be more generic
	  (Jean)
	- simplify range checking for sva PASID (Baolu) 
v6:
	- use a simplified version of vt-d driver change for set_device_pasid
	  from Baolu.
	- check and rename global PASID allocation base
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



Jacob Pan (3):
  iommu: Generalize PASID 0 for normal DMA w/o PASID
  iommu: Move global PASID allocation from SVA to core
  dmaengine/idxd: Re-enable kernel workqueue under DMA API

Lu Baolu (1):
  iommu/vt-d: Add set_dev_pasid callback for dma domain

 drivers/dma/idxd/device.c                     |  30 +---
 drivers/dma/idxd/dma.c                        |   5 +-
 drivers/dma/idxd/init.c                       |  60 ++++++-
 drivers/dma/idxd/sysfs.c                      |   7 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  10 +-
 drivers/iommu/intel/iommu.c                   | 159 +++++++++++++++---
 drivers/iommu/intel/iommu.h                   |   7 +
 drivers/iommu/intel/pasid.c                   |   2 +-
 drivers/iommu/intel/pasid.h                   |   1 -
 drivers/iommu/iommu-sva.c                     |  28 ++-
 drivers/iommu/iommu.c                         |  24 +++
 include/linux/iommu.h                         |  11 ++
 13 files changed, 261 insertions(+), 85 deletions(-)

-- 
2.25.1

