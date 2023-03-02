Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230656A7883
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 01:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCBA4T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 19:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBA4S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 19:56:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E756794;
        Wed,  1 Mar 2023 16:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677718577; x=1709254577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B7l47jDXL6XYjzlb7DoYwki6AJEFxkHN4ykXqiXARNk=;
  b=gtUh2+V86VMQiWDbkaPK0IgmTj6qDNJ07YER0mapCTM+edNOzO1rzdkX
   Jz2Ot5M1E0PWzmOF1gNhPMceoFaWdNARSx0Mhv1CAJG5qc29RrkpZeWG0
   /y/dkvNDL/m5oaNAB3uxBu/cPDXCbadCq0HRe+QCVkI5TOQNlpxFHFrrF
   RRD5sEdi4qtGQMeae6YFw7mU3AwaFuO6EFuIUFkwQWOCQej/Fd7BKA+kU
   UkNNhaR8QD27YWzb5tcLU/FA8im4Vq86D24V8mmfMB+hvCb+inEIgxhQZ
   P/yVpB66uUng0k6zgQRnawfRDSHyhbrBRRRi+bVC/Gh2nXtaAFW2jclAe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397141467"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="397141467"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 16:56:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="624708987"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="624708987"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2023 16:56:11 -0800
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
Subject: [PATCH 0/4] Re-enable IDXD kernel workqueue under DMA API
Date:   Wed,  1 Mar 2023 16:59:55 -0800
Message-Id: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Jacob

Jacob Pan (4):
  iommu/vt-d: Implement set device pasid op for default domain
  iommu/vt-d: Use non-privileged mode for all PASIDs
  iommu/sva: Support reservation of global PASIDs
  dmaengine/idxd: Re-enable kernel workqueue under DMA API

 drivers/dma/idxd/device.c   | 30 ++++-------------------
 drivers/dma/idxd/init.c     | 47 +++++++++++++++++++++++++++++++++----
 drivers/dma/idxd/sysfs.c    |  7 ------
 drivers/iommu/intel/iommu.c | 34 +++++++++++++++++++++++++--
 drivers/iommu/iommu-sva.c   | 25 ++++++++++++++++++++
 include/linux/iommu.h       | 14 +++++++++++
 6 files changed, 119 insertions(+), 38 deletions(-)

-- 
2.25.1

