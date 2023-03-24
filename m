Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAC96C7DA9
	for <lists+dmaengine@lfdr.de>; Fri, 24 Mar 2023 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjCXMDI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Mar 2023 08:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjCXMCv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Mar 2023 08:02:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A205265B8;
        Fri, 24 Mar 2023 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679659361; x=1711195361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M/Jk/NyOL6YOkh9WpMFp/FMLnkzRYwNbBzLyoNFzzAU=;
  b=Tp5a5DlI92vpGpnCNmXRTLEMyGYXWHELMjRzcubt+IXqopxokZmzqfSW
   KVSN/K4KyaboIXyMOiehaL3XB5f6R1ZWMjduEBj56Sv/oZXVUYU2goAvK
   5VbV+QrGuVMk4L6DHat3uMMRt2WcZF2ZUdb0TLcB4k+AxCRd8QucJSKys
   89HQLLUybgG+nAwV4980m3FlgoSsJcBkHx0+kbrPL2hWtRBdAYUFeKtkf
   kQzvBdqY6XWAu2splMDWXmziMo4J5r/lzKq+O0+b3GvVF5j4tqjQkSkLO
   9dgZMZzQ+W1F1XjNd3hPwzDnhrb28DP2wakcng75YVM0MXbDF7p1Fwe8o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323634194"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="323634194"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 05:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682674914"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682674914"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2023 05:02:38 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev, dmaengine@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 6/6] iommu/vt-d: Remove unnecessary checks in iopf disabling path
Date:   Fri, 24 Mar 2023 20:02:34 +0800
Message-Id: <20230324120234.313643-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324120234.313643-1-baolu.lu@linux.intel.com>
References: <20230324120234.313643-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

iommu_unregister_device_fault_handler() and iopf_queue_remove_device()
are called after device has stopped issuing new page falut requests and
all outstanding page requests have been drained. They should never fail.
Trigger a warning if it happens unfortunately.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cd3a3c4b5e64..c771233d6f2a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4707,7 +4707,6 @@ static int intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
-	int ret;
 
 	if (!info->pri_enabled)
 		return -EINVAL;
@@ -4723,15 +4722,15 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	pci_disable_pri(to_pci_dev(dev));
 	info->pri_enabled = 0;
 
-	ret = iommu_unregister_device_fault_handler(dev);
-	if (ret)
-		return ret;
-
-	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
-	if (ret)
-		iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	/*
+	 * With PRI disabled and outstanding PRQs drained, unregistering
+	 * fault handler and removing device from iopf queue should never
+	 * fail.
+	 */
+	WARN_ON(iommu_unregister_device_fault_handler(dev));
+	WARN_ON(iopf_queue_remove_device(iommu->iopf_queue, dev));
 
-	return ret;
+	return 0;
 }
 
 static int
-- 
2.34.1

