Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02ED70A093
	for <lists+dmaengine@lfdr.de>; Fri, 19 May 2023 22:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjESU15 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 May 2023 16:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjESU15 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 May 2023 16:27:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2755FE0;
        Fri, 19 May 2023 13:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684528076; x=1716064076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lPknCd0JASs7OSTHQDTzAn2JYPT+94NvxjU0w6CeP78=;
  b=Pp4KjFTBqXEUkd9qbZXDZp63SZlNKtGft+3FOgbF84E+EeU5x576H7Dw
   ieivGzCZqMWURuyUTqJlDzyyUBfqZ92hPejuBUcjgmX5iQ7Vt6v228CdH
   1dvImFkrCYL+rquWV+T1/80GQ2yuNrwYsGfCsNE5oMUq4RMadzOHdNaBU
   Bg7GtmLwanf1m1/SPZ/gkr8gJNq1/XZd3MwHJ8q07eDIsgx0qPl8wQn4o
   CSlg6hh8zLK0pBMcKW5Y551XrZAiShtWmXu78CJnwO5RuazxAgVyqcVAf
   e7N8N0vSbZoD2jIhOxJntdSuP7liDPM6YlIWp/P9p5lVIYtWHvTWfLYlu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="418175353"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="418175353"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 13:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="876967791"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="876967791"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2023 13:27:55 -0700
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
        narayan.ranganathan@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 0/4] Re-enable IDXD kernel workqueue under DMA API
Date:   Fri, 19 May 2023 13:32:19 -0700
Message-Id: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
  iommu: Generalize default PCIe requester ID PASID
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
 drivers/iommu/iommu-sva.c                     |  33 ++--
 drivers/iommu/iommu.c                         |  24 +++
 include/linux/iommu.h                         |  11 ++
 13 files changed, 265 insertions(+), 86 deletions(-)

-- 
2.25.1

