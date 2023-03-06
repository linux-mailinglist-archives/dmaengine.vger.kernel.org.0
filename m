Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344036AC887
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 17:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCFQqB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 11:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCFQoW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 11:44:22 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BB834F43;
        Mon,  6 Mar 2023 08:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121038; x=1709657038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ktIv+Rh9KBAfkRLGGpvik7AxgJzeQXcUN3sTRinZTIs=;
  b=i5/XJRA/tL30phmJ4RnJgJoZanPN9SmehbxBYJju/jfwMFe4NZJQ2M4T
   V/zype3hX/hl2RDaoq8Rq01icD5kOdrNiSbh3daqYBYfMfLslTmtfqSHm
   5I97d5fH6c16Dk24gjKxj5BqG7b/Xs1FB2BrMzC5iOpPQq34H7M1CYDjM
   jEz9sFHlR1d23ys0l77QJdG+CuqTWqp9NqP/9l4jC0cmKjXtIVg/dJKLh
   VHhq6FM7o84gJhoxMo8ORitvZVXZu7FPCehFWe00X6hwvfS2zVPgTGp3T
   HVHaRis7MdQ/FdDVH0dmQNNTFnGn4mYt0GDqNVzm45Cu79LshGGqcBCCL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181162"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181162"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504527"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504527"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:57 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, iommu@lists.linux.dev
Subject: [PATCH v2 08/16] iommu: define and export iommu_access_remote_vm()
Date:   Mon,  6 Mar 2023 08:31:30 -0800
Message-Id: <20230306163138.587484-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230306163138.587484-1-fenghua.yu@intel.com>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Define and export iommu_access_remote_vm() to allow IOMMU related
drivers to access user address space by PASID.

The IDXD driver would like to use it to write the user's completion
record that the hardware device is not able to write to due to user
page fault.

Without the API, it's complex for IDXD driver to copy completion record
to a process' fault address for two reasons:
1. access_remote_vm() is not exported and shouldn't be exported for
   drivers because drivers may easily cause mm reference issue.
2. user frees fault address pages to trigger fault by IDXD device.

The driver has to call iommu_sva_find(), kthread_use_mm(), re-implement
majority of access_remote_vm() etc to access remote vm.

This IOMMU specific API hides these details and provides a clean interface
for idxd driver and potentially other IOMMU related drivers.

Suggested-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux.dev
---
v2:
- Define and export iommu_access_remote_vm() for IDXD driver to write
  completion record to user address space. This change removes
  patch 8 and 9 in v1 (Alistair Popple)

 drivers/iommu/iommu-sva.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/iommu.h     |  9 +++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..1d7a0aee58f7 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -71,6 +71,41 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
 
+/**
+ * iommu_access_remote_vm - access another process' address space by PASID
+ * @pasid:	Process Address Space ID assigned to the mm
+ * @addr:	start address to access
+ * @buf:	source or destination buffer
+ * @len:	number of bytes to transfer
+ * @gup_flags:	flags modifying lookup behaviour
+ *
+ * Another process' address space is found by PASID. A reference on @mm
+ * is taken and released inside the function.
+ *
+ * Return: number of bytes copied from source to destination.
+ */
+int iommu_access_remote_vm(ioasid_t pasid, unsigned long addr, void *buf,
+			   int len, unsigned int gup_flags)
+{
+	struct mm_struct *mm;
+	int copied;
+
+	mm = iommu_sva_find(pasid);
+	if (IS_ERR_OR_NULL(mm))
+		return 0;
+
+	/*
+	 * A reference on @mm has been held by mmget_not_zero()
+	 * during iommu_sva_find().
+	 */
+	copied = access_remote_vm(mm, addr, buf, len, gup_flags);
+	/* The reference is released. */
+	mmput(mm);
+
+	return copied;
+}
+EXPORT_SYMBOL_GPL(iommu_access_remote_vm);
+
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6595454d4f48..414a46a53799 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1177,6 +1177,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+int iommu_access_remote_vm(ioasid_t pasid, unsigned long addr, void *buf,
+			   int len, unsigned int gup_flags);
 #else
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
@@ -1192,6 +1194,13 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
+
+static inline int iommu_access_remote_vm(ioasid_t pasid, unsigned long addr,
+					 void *buf, int len,
+					 unsigned int gup_flags)
+{
+	return 0;
+}
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.37.1

