Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2891522605
	for <lists+dmaengine@lfdr.de>; Tue, 10 May 2022 23:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiEJVDX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 May 2022 17:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiEJVDW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 May 2022 17:03:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7568291CF7;
        Tue, 10 May 2022 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652216601; x=1683752601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yaL5eTR2TDGWQSRHXqCNVN+WN1qFxw5PS9ZayzMjEpA=;
  b=erKWnLfrixI+VXL62Ppm5x6KFDd81bJLwf4fsiUE5wSW5vk0kqA195xU
   +jzmHen4Pq9XYcq52v9fixoEG9jLL1wuoBaLXX3wlpKpmWbC1YavPtS1k
   xMrLdRpzoKIEugcT8/kbm/tkxx61yl42fq9WA0gzIqeFCYX7GeKfsWTyH
   H6ZScb74fpC2N9yxig6CRjnvSlwVZQl/aOx+IzUETL5hwR8uaC+1dNa1z
   I6nmv1CzfHwz0u6JzSK4giykqzcDB6O48/+jXbtvR8aKWNdGV51GYpTnV
   o++WF7FP/U9HcCn77zpoaZ+PeVDgAFqpCzahgicBOgJkUsXxDpYBcnV4E
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="332538554"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="332538554"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 14:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="553017115"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by orsmga002.jf.intel.com with ESMTP; 10 May 2022 14:03:21 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, vkoul@kernel.org,
        robin.murphy@arm.com, will@kernel.org
Cc:     Yi Liu <yi.l.liu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 2/4] iommu: Add PASID support for DMA mapping API users
Date:   Tue, 10 May 2022 14:07:02 -0700
Message-Id: <20220510210704.3539577-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
References: <20220510210704.3539577-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DMA mapping API is the de facto standard for in-kernel DMA. It operates
on a per device/RID basis which is not PASID-aware.

Some modern devices such as Intel Data Streaming Accelerator, PASID is
required for certain work submissions. To allow such devices use DMA
mapping API, we need the following functionalities:
1. Provide device a way to retrieve a PASID for work submission within
the kernel
2. Enable the kernel PASID on the IOMMU for the device
3. Attach the kernel PASID to the device's default DMA domain, let it
be IOVA or physical address in case of pass-through.

This patch introduces a driver facing API that enables DMA API
PASID usage. Once enabled, device drivers can continue to use DMA APIs as
is. There is no difference in dma_handle between without PASID and with
PASID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 107 ++++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |   3 ++
 include/linux/iommu.h     |   2 +
 3 files changed, 112 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1ca85d37eeab..5984f3129fa2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -34,6 +34,8 @@ struct iommu_dma_msi_page {
 	phys_addr_t		phys;
 };
 
+static DECLARE_IOASID_SET(iommu_dma_pasid);
+
 enum iommu_dma_cookie_type {
 	IOMMU_DMA_IOVA_COOKIE,
 	IOMMU_DMA_MSI_COOKIE,
@@ -370,6 +372,111 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	domain->iova_cookie = NULL;
 }
 
+/**
+ * iommu_attach_dma_pasid --Attach a PASID for in-kernel DMA. Use the device's
+ * DMA domain.
+ * @dev: Device to be enabled
+ * @pasid: The returned kernel PASID to be used for DMA
+ *
+ * DMA request with PASID will be mapped the same way as the legacy DMA.
+ * If the device is in pass-through, PASID will also pass-through. If the
+ * device is in IOVA, the PASID will point to the same IOVA page table.
+ *
+ * @return err code or 0 on success
+ */
+int iommu_attach_dma_pasid(struct device *dev, ioasid_t *pasid)
+{
+	struct iommu_domain *dom;
+	ioasid_t id, max;
+	int ret = 0;
+
+	dom = iommu_get_domain_for_dev(dev);
+	if (!dom || !dom->ops || !dom->ops->attach_dev_pasid)
+		return -ENODEV;
+
+	/* Only support domain types that DMA API can be used */
+	if (dom->type == IOMMU_DOMAIN_UNMANAGED ||
+	    dom->type == IOMMU_DOMAIN_BLOCKED) {
+		dev_warn(dev, "Invalid domain type %d", dom->type);
+		return -EPERM;
+	}
+
+	id = dom->pasid;
+	if (!id) {
+		/*
+		 * First device to use PASID in its DMA domain, allocate
+		 * a single PASID per DMA domain is all we need, it is also
+		 * good for performance when it comes down to IOTLB flush.
+		 */
+		max = 1U << dev->iommu->pasid_bits;
+		if (!max)
+			return -EINVAL;
+
+		id = ioasid_alloc(&iommu_dma_pasid, 1, max, dev);
+		if (id == INVALID_IOASID)
+			return -ENOMEM;
+
+		dom->pasid = id;
+		atomic_set(&dom->pasid_users, 1);
+	}
+
+	ret = dom->ops->attach_dev_pasid(dom, dev, id);
+	if (!ret) {
+		*pasid = id;
+		atomic_inc(&dom->pasid_users);
+		return 0;
+	}
+
+	if (atomic_dec_and_test(&dom->pasid_users)) {
+		ioasid_free(id);
+		dom->pasid = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(iommu_attach_dma_pasid);
+
+/**
+ * iommu_detach_dma_pasid --Disable in-kernel DMA request with PASID
+ * @dev:	Device's PASID DMA to be disabled
+ *
+ * It is the device driver's responsibility to ensure no more incoming DMA
+ * requests with the kernel PASID before calling this function. IOMMU driver
+ * ensures PASID cache, IOTLBs related to the kernel PASID are cleared and
+ * drained.
+ *
+ */
+void iommu_detach_dma_pasid(struct device *dev)
+{
+	struct iommu_domain *dom;
+	ioasid_t pasid;
+
+	dom = iommu_get_domain_for_dev(dev);
+	if (!dom || !dom->ops || !dom->ops->detach_dev_pasid) {
+		dev_warn(dev, "No ops for detaching PASID %u", pasid);
+		return;
+	}
+	/* Only support DMA API managed domain type */
+	if (dom->type == IOMMU_DOMAIN_UNMANAGED ||
+	    dom->type == IOMMU_DOMAIN_BLOCKED) {
+		dev_err(dev, "Invalid domain type %d to detach DMA PASID %u\n",
+			 dom->type, pasid);
+		return;
+	}
+
+	pasid = dom->pasid;
+	if (!pasid) {
+		dev_err(dev, "No DMA PASID attached\n");
+		return;
+	}
+	dom->ops->detach_dev_pasid(dom, dev, pasid);
+	if (atomic_dec_and_test(&dom->pasid_users)) {
+		ioasid_free(pasid);
+		dom->pasid = 0;
+	}
+}
+EXPORT_SYMBOL(iommu_detach_dma_pasid);
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 24607dc3c2ac..538650b9cb75 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -18,6 +18,9 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
+int iommu_attach_dma_pasid(struct device *dev, ioasid_t *pasid);
+void iommu_detach_dma_pasid(struct device *dev);
+
 /* Setup call for arch DMA mapping code */
 void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
 int iommu_dma_init_fq(struct iommu_domain *domain);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1164524814cb..281a87fdce77 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -105,6 +105,8 @@ struct iommu_domain {
 	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
 						      void *data);
 	void *fault_data;
+	ioasid_t pasid;		/* Used for DMA requests with PASID */
+	atomic_t pasid_users;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
-- 
2.25.1

