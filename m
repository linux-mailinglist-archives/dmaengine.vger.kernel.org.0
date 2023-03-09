Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8C6B305C
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 23:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCIWSW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Mar 2023 17:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCIWSR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Mar 2023 17:18:17 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C93B3FD;
        Thu,  9 Mar 2023 14:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678400294; x=1709936294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dxYel3ZlkSHs8JMhm6G5rUzIqRmXv6Tk+mhe99eZrVA=;
  b=QfaOECQfHKPUTzBbgiDh5xlpprX1NV6tItxb5oF+tmimib26tebyIIqf
   eg/sp9459T+ofTge0QjqfzJsSUVY5feogrPhIli194SEYyAMJmC7CWf/x
   +6WY2DLHZV5VlIx6JDPw+MR9v4exT8iyBUoGMVgU9c7wFrTFCc1+mcRWl
   RDpcPq+citzxptF7Kya7sRXH68oxngqp+aDaXrzf0Rl+z2C6SA8fpWXAP
   OE90klPQeMd9jqSfUyTo/MNIn9+qBZeGWnxSQuoa98sC1w+uPx9nlCzUn
   E9h/p2XQx6XtjsXNjjuncgieP7otSvfM3yff0YFlEox40paEQfDQhizzs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="364235277"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="364235277"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 14:18:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="707788868"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="707788868"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2023 14:18:10 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86 Kernel <x86@kernel.org>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 7/7] iommu: Remove ioasid infrastructure
Date:   Thu,  9 Mar 2023 14:21:59 -0800
Message-Id: <20230309222159.487826-9-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This has no use anymore, delete it all.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v3:	- put rename under a different patch
	- delete makefile and Kconfig
v2:
	- fix compile issue w/o CONFIG_IOMMU_SVA
	- consolidate INVALID_IOASID w/ IOMMU_PASID_INVALID
---
 drivers/dma/idxd/idxd.h     |   1 -
 drivers/iommu/Kconfig       |   5 -
 drivers/iommu/Makefile      |   1 -
 drivers/iommu/intel/iommu.h |   1 -
 drivers/iommu/intel/svm.c   |   1 -
 drivers/iommu/ioasid.c      | 422 ------------------------------------
 drivers/iommu/iommu-sva.h   |   1 -
 include/linux/ioasid.h      |  80 -------
 include/linux/iommu.h       |   1 -
 9 files changed, 513 deletions(-)
 delete mode 100644 drivers/iommu/ioasid.c
 delete mode 100644 include/linux/ioasid.h

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 417e602a46b6..dd2a6ed8949b 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -10,7 +10,6 @@
 #include <linux/cdev.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
-#include <linux/ioasid.h>
 #include <linux/bitmap.h>
 #include <linux/perf_event.h>
 #include <linux/iommu.h>
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 889c7efd050b..a799221f8844 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -3,10 +3,6 @@
 config IOMMU_IOVA
 	tristate
 
-# The IOASID library may also be used by non-IOMMU_API users
-config IOASID
-	tristate
-
 # IOMMU_API always gets selected by whoever wants it.
 config IOMMU_API
 	bool
@@ -160,7 +156,6 @@ config IOMMU_DMA
 # Shared Virtual Addressing
 config IOMMU_SVA
 	bool
-	select IOASID
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index f461d0651385..769e43d780ce 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
-obj-$(CONFIG_IOASID) += ioasid.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a2010fb120e2..65b15be72878 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -19,7 +19,6 @@
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
-#include <linux/ioasid.h>
 #include <linux/bitfield.h>
 #include <linux/xarray.h>
 #include <linux/perf_event.h>
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 3848a1b0800c..e95b339e9cdc 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/mm_types.h>
 #include <linux/xarray.h>
-#include <linux/ioasid.h>
 #include <asm/page.h>
 #include <asm/fpu/api.h>
 
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
deleted file mode 100644
index a786c034907c..000000000000
--- a/drivers/iommu/ioasid.c
+++ /dev/null
@@ -1,422 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * I/O Address Space ID allocator. There is one global IOASID space, split into
- * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
- * free IOASIDs with ioasid_alloc() and ioasid_free().
- */
-#include <linux/ioasid.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
-#include <linux/xarray.h>
-
-struct ioasid_data {
-	ioasid_t id;
-	struct ioasid_set *set;
-	void *private;
-	struct rcu_head rcu;
-};
-
-/*
- * struct ioasid_allocator_data - Internal data structure to hold information
- * about an allocator. There are two types of allocators:
- *
- * - Default allocator always has its own XArray to track the IOASIDs allocated.
- * - Custom allocators may share allocation helpers with different private data.
- *   Custom allocators that share the same helper functions also share the same
- *   XArray.
- * Rules:
- * 1. Default allocator is always available, not dynamically registered. This is
- *    to prevent race conditions with early boot code that want to register
- *    custom allocators or allocate IOASIDs.
- * 2. Custom allocators take precedence over the default allocator.
- * 3. When all custom allocators sharing the same helper functions are
- *    unregistered (e.g. due to hotplug), all outstanding IOASIDs must be
- *    freed. Otherwise, outstanding IOASIDs will be lost and orphaned.
- * 4. When switching between custom allocators sharing the same helper
- *    functions, outstanding IOASIDs are preserved.
- * 5. When switching between custom allocator and default allocator, all IOASIDs
- *    must be freed to ensure unadulterated space for the new allocator.
- *
- * @ops:	allocator helper functions and its data
- * @list:	registered custom allocators
- * @slist:	allocators share the same ops but different data
- * @flags:	attributes of the allocator
- * @xa:		xarray holds the IOASID space
- * @rcu:	used for kfree_rcu when unregistering allocator
- */
-struct ioasid_allocator_data {
-	struct ioasid_allocator_ops *ops;
-	struct list_head list;
-	struct list_head slist;
-#define IOASID_ALLOCATOR_CUSTOM BIT(0) /* Needs framework to track results */
-	unsigned long flags;
-	struct xarray xa;
-	struct rcu_head rcu;
-};
-
-static DEFINE_SPINLOCK(ioasid_allocator_lock);
-static LIST_HEAD(allocators_list);
-
-static ioasid_t default_alloc(ioasid_t min, ioasid_t max, void *opaque);
-static void default_free(ioasid_t ioasid, void *opaque);
-
-static struct ioasid_allocator_ops default_ops = {
-	.alloc = default_alloc,
-	.free = default_free,
-};
-
-static struct ioasid_allocator_data default_allocator = {
-	.ops = &default_ops,
-	.flags = 0,
-	.xa = XARRAY_INIT(ioasid_xa, XA_FLAGS_ALLOC),
-};
-
-static struct ioasid_allocator_data *active_allocator = &default_allocator;
-
-static ioasid_t default_alloc(ioasid_t min, ioasid_t max, void *opaque)
-{
-	ioasid_t id;
-
-	if (xa_alloc(&default_allocator.xa, &id, opaque, XA_LIMIT(min, max), GFP_ATOMIC)) {
-		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
-		return INVALID_IOASID;
-	}
-
-	return id;
-}
-
-static void default_free(ioasid_t ioasid, void *opaque)
-{
-	struct ioasid_data *ioasid_data;
-
-	ioasid_data = xa_erase(&default_allocator.xa, ioasid);
-	kfree_rcu(ioasid_data, rcu);
-}
-
-/* Allocate and initialize a new custom allocator with its helper functions */
-static struct ioasid_allocator_data *ioasid_alloc_allocator(struct ioasid_allocator_ops *ops)
-{
-	struct ioasid_allocator_data *ia_data;
-
-	ia_data = kzalloc(sizeof(*ia_data), GFP_ATOMIC);
-	if (!ia_data)
-		return NULL;
-
-	xa_init_flags(&ia_data->xa, XA_FLAGS_ALLOC);
-	INIT_LIST_HEAD(&ia_data->slist);
-	ia_data->flags |= IOASID_ALLOCATOR_CUSTOM;
-	ia_data->ops = ops;
-
-	/* For tracking custom allocators that share the same ops */
-	list_add_tail(&ops->list, &ia_data->slist);
-
-	return ia_data;
-}
-
-static bool use_same_ops(struct ioasid_allocator_ops *a, struct ioasid_allocator_ops *b)
-{
-	return (a->free == b->free) && (a->alloc == b->alloc);
-}
-
-/**
- * ioasid_register_allocator - register a custom allocator
- * @ops: the custom allocator ops to be registered
- *
- * Custom allocators take precedence over the default xarray based allocator.
- * Private data associated with the IOASID allocated by the custom allocators
- * are managed by IOASID framework similar to data stored in xa by default
- * allocator.
- *
- * There can be multiple allocators registered but only one is active. In case
- * of runtime removal of a custom allocator, the next one is activated based
- * on the registration ordering.
- *
- * Multiple allocators can share the same alloc() function, in this case the
- * IOASID space is shared.
- */
-int ioasid_register_allocator(struct ioasid_allocator_ops *ops)
-{
-	struct ioasid_allocator_data *ia_data;
-	struct ioasid_allocator_data *pallocator;
-	int ret = 0;
-
-	spin_lock(&ioasid_allocator_lock);
-
-	ia_data = ioasid_alloc_allocator(ops);
-	if (!ia_data) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
-
-	/*
-	 * No particular preference, we activate the first one and keep
-	 * the later registered allocators in a list in case the first one gets
-	 * removed due to hotplug.
-	 */
-	if (list_empty(&allocators_list)) {
-		WARN_ON(active_allocator != &default_allocator);
-		/* Use this new allocator if default is not active */
-		if (xa_empty(&active_allocator->xa)) {
-			rcu_assign_pointer(active_allocator, ia_data);
-			list_add_tail(&ia_data->list, &allocators_list);
-			goto out_unlock;
-		}
-		pr_warn("Default allocator active with outstanding IOASID\n");
-		ret = -EAGAIN;
-		goto out_free;
-	}
-
-	/* Check if the allocator is already registered */
-	list_for_each_entry(pallocator, &allocators_list, list) {
-		if (pallocator->ops == ops) {
-			pr_err("IOASID allocator already registered\n");
-			ret = -EEXIST;
-			goto out_free;
-		} else if (use_same_ops(pallocator->ops, ops)) {
-			/*
-			 * If the new allocator shares the same ops,
-			 * then they will share the same IOASID space.
-			 * We should put them under the same xarray.
-			 */
-			list_add_tail(&ops->list, &pallocator->slist);
-			goto out_free;
-		}
-	}
-	list_add_tail(&ia_data->list, &allocators_list);
-
-	spin_unlock(&ioasid_allocator_lock);
-	return 0;
-out_free:
-	kfree(ia_data);
-out_unlock:
-	spin_unlock(&ioasid_allocator_lock);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ioasid_register_allocator);
-
-/**
- * ioasid_unregister_allocator - Remove a custom IOASID allocator ops
- * @ops: the custom allocator to be removed
- *
- * Remove an allocator from the list, activate the next allocator in
- * the order it was registered. Or revert to default allocator if all
- * custom allocators are unregistered without outstanding IOASIDs.
- */
-void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
-{
-	struct ioasid_allocator_data *pallocator;
-	struct ioasid_allocator_ops *sops;
-
-	spin_lock(&ioasid_allocator_lock);
-	if (list_empty(&allocators_list)) {
-		pr_warn("No custom IOASID allocators active!\n");
-		goto exit_unlock;
-	}
-
-	list_for_each_entry(pallocator, &allocators_list, list) {
-		if (!use_same_ops(pallocator->ops, ops))
-			continue;
-
-		if (list_is_singular(&pallocator->slist)) {
-			/* No shared helper functions */
-			list_del(&pallocator->list);
-			/*
-			 * All IOASIDs should have been freed before
-			 * the last allocator that shares the same ops
-			 * is unregistered.
-			 */
-			WARN_ON(!xa_empty(&pallocator->xa));
-			if (list_empty(&allocators_list)) {
-				pr_info("No custom IOASID allocators, switch to default.\n");
-				rcu_assign_pointer(active_allocator, &default_allocator);
-			} else if (pallocator == active_allocator) {
-				rcu_assign_pointer(active_allocator,
-						list_first_entry(&allocators_list,
-								struct ioasid_allocator_data, list));
-				pr_info("IOASID allocator changed");
-			}
-			kfree_rcu(pallocator, rcu);
-			break;
-		}
-		/*
-		 * Find the matching shared ops to delete,
-		 * but keep outstanding IOASIDs
-		 */
-		list_for_each_entry(sops, &pallocator->slist, list) {
-			if (sops == ops) {
-				list_del(&ops->list);
-				break;
-			}
-		}
-		break;
-	}
-
-exit_unlock:
-	spin_unlock(&ioasid_allocator_lock);
-}
-EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
-
-/**
- * ioasid_set_data - Set private data for an allocated ioasid
- * @ioasid: the ID to set data
- * @data:   the private data
- *
- * For IOASID that is already allocated, private data can be set
- * via this API. Future lookup can be done via ioasid_find.
- */
-int ioasid_set_data(ioasid_t ioasid, void *data)
-{
-	struct ioasid_data *ioasid_data;
-	int ret = 0;
-
-	spin_lock(&ioasid_allocator_lock);
-	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (ioasid_data)
-		rcu_assign_pointer(ioasid_data->private, data);
-	else
-		ret = -ENOENT;
-	spin_unlock(&ioasid_allocator_lock);
-
-	/*
-	 * Wait for readers to stop accessing the old private data, so the
-	 * caller can free it.
-	 */
-	if (!ret)
-		synchronize_rcu();
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ioasid_set_data);
-
-/**
- * ioasid_alloc - Allocate an IOASID
- * @set: the IOASID set
- * @min: the minimum ID (inclusive)
- * @max: the maximum ID (inclusive)
- * @private: data private to the caller
- *
- * Allocate an ID between @min and @max. The @private pointer is stored
- * internally and can be retrieved with ioasid_find().
- *
- * Return: the allocated ID on success, or %INVALID_IOASID on failure.
- */
-ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
-		      void *private)
-{
-	struct ioasid_data *data;
-	void *adata;
-	ioasid_t id;
-
-	data = kzalloc(sizeof(*data), GFP_ATOMIC);
-	if (!data)
-		return INVALID_IOASID;
-
-	data->set = set;
-	data->private = private;
-
-	/*
-	 * Custom allocator needs allocator data to perform platform specific
-	 * operations.
-	 */
-	spin_lock(&ioasid_allocator_lock);
-	adata = active_allocator->flags & IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data;
-	id = active_allocator->ops->alloc(min, max, adata);
-	if (id == INVALID_IOASID) {
-		pr_err("Failed ASID allocation %lu\n", active_allocator->flags);
-		goto exit_free;
-	}
-
-	if ((active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) &&
-	     xa_alloc(&active_allocator->xa, &id, data, XA_LIMIT(id, id), GFP_ATOMIC)) {
-		/* Custom allocator needs framework to store and track allocation results */
-		pr_err("Failed to alloc ioasid from %d\n", id);
-		active_allocator->ops->free(id, active_allocator->ops->pdata);
-		goto exit_free;
-	}
-	data->id = id;
-
-	spin_unlock(&ioasid_allocator_lock);
-	return id;
-exit_free:
-	spin_unlock(&ioasid_allocator_lock);
-	kfree(data);
-	return INVALID_IOASID;
-}
-EXPORT_SYMBOL_GPL(ioasid_alloc);
-
-/**
- * ioasid_free - Free an ioasid
- * @ioasid: the ID to remove
- */
-void ioasid_free(ioasid_t ioasid)
-{
-	struct ioasid_data *ioasid_data;
-
-	spin_lock(&ioasid_allocator_lock);
-	ioasid_data = xa_load(&active_allocator->xa, ioasid);
-	if (!ioasid_data) {
-		pr_err("Trying to free unknown IOASID %u\n", ioasid);
-		goto exit_unlock;
-	}
-
-	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
-	/* Custom allocator needs additional steps to free the xa element */
-	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
-		ioasid_data = xa_erase(&active_allocator->xa, ioasid);
-		kfree_rcu(ioasid_data, rcu);
-	}
-
-exit_unlock:
-	spin_unlock(&ioasid_allocator_lock);
-}
-EXPORT_SYMBOL_GPL(ioasid_free);
-
-/**
- * ioasid_find - Find IOASID data
- * @set: the IOASID set
- * @ioasid: the IOASID to find
- * @getter: function to call on the found object
- *
- * The optional getter function allows to take a reference to the found object
- * under the rcu lock. The function can also check if the object is still valid:
- * if @getter returns false, then the object is invalid and NULL is returned.
- *
- * If the IOASID exists, return the private pointer passed to ioasid_alloc.
- * Private data can be NULL if not set. Return an error if the IOASID is not
- * found, or if @set is not NULL and the IOASID does not belong to the set.
- */
-void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
-		  bool (*getter)(void *))
-{
-	void *priv;
-	struct ioasid_data *ioasid_data;
-	struct ioasid_allocator_data *idata;
-
-	rcu_read_lock();
-	idata = rcu_dereference(active_allocator);
-	ioasid_data = xa_load(&idata->xa, ioasid);
-	if (!ioasid_data) {
-		priv = ERR_PTR(-ENOENT);
-		goto unlock;
-	}
-	if (set && ioasid_data->set != set) {
-		/* data found but does not belong to the set */
-		priv = ERR_PTR(-EACCES);
-		goto unlock;
-	}
-	/* Now IOASID and its set is verified, we can return the private data */
-	priv = rcu_dereference(ioasid_data->private);
-	if (getter && !getter(priv))
-		priv = NULL;
-unlock:
-	rcu_read_unlock();
-
-	return priv;
-}
-EXPORT_SYMBOL_GPL(ioasid_find);
-
-MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
-MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
-MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
-MODULE_LICENSE("GPL");
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index c22d0174ad61..54946b5a7caf 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -5,7 +5,6 @@
 #ifndef _IOMMU_SVA_H
 #define _IOMMU_SVA_H
 
-#include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
 /* I/O Page fault */
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
deleted file mode 100644
index 665a3773a409..000000000000
--- a/include/linux/ioasid.h
+++ /dev/null
@@ -1,80 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_IOASID_H
-#define __LINUX_IOASID_H
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/iommu-helper.h>
-
-typedef unsigned int ioasid_t;
-#define INVALID_IOASID ((ioasid_t)-1)
-typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
-typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
-
-struct ioasid_set {
-	int dummy;
-};
-
-/**
- * struct ioasid_allocator_ops - IOASID allocator helper functions and data
- *
- * @alloc:	helper function to allocate IOASID
- * @free:	helper function to free IOASID
- * @list:	for tracking ops that share helper functions but not data
- * @pdata:	data belong to the allocator, provided when calling alloc()
- */
-struct ioasid_allocator_ops {
-	ioasid_alloc_fn_t alloc;
-	ioasid_free_fn_t free;
-	struct list_head list;
-	void *pdata;
-};
-
-#define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
-
-#if IS_ENABLED(CONFIG_IOASID)
-ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
-		      void *private);
-void ioasid_free(ioasid_t ioasid);
-void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
-		  bool (*getter)(void *));
-int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
-void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
-int ioasid_set_data(ioasid_t ioasid, void *data);
-
-#else /* !CONFIG_IOASID */
-static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
-				    ioasid_t max, void *private)
-{
-	return INVALID_IOASID;
-}
-
-static inline void ioasid_free(ioasid_t ioasid) { }
-
-static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
-				bool (*getter)(void *))
-{
-	return NULL;
-}
-
-static inline int ioasid_register_allocator(struct ioasid_allocator_ops *allocator)
-{
-	return -ENOTSUPP;
-}
-
-static inline void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator)
-{
-}
-
-static inline int ioasid_set_data(ioasid_t ioasid, void *data)
-{
-	return -ENOTSUPP;
-}
-
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return false;
-}
-
-#endif /* CONFIG_IOASID */
-#endif /* __LINUX_IOASID_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 945a2f09b442..94f4e53c50e7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -13,7 +13,6 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/ioasid.h>
 #include <uapi/linux/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
-- 
2.25.1

