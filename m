Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E4A123AD6
	for <lists+dmaengine@lfdr.de>; Wed, 18 Dec 2019 00:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfLQXd0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 18:33:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:5721 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfLQXdZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Dec 2019 18:33:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 15:33:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="209883295"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008.jf.intel.com with ESMTP; 17 Dec 2019 15:33:23 -0800
Subject: [PATCH RFC v3 04/14] mm: create common code from request allocation
 based from blk-mq code
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Tue, 17 Dec 2019 16:33:23 -0700
Message-ID: <157662560369.51652.2032980716536155791.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157662541786.51652.7666763291600764054.stgit@djiang5-desk3.ch.intel.com>
References: <157662541786.51652.7666763291600764054.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the allocation of requests from compound pages to a common function
to allow usages by blk-mq and dmaengine. Since the routine has more to do with
memory allocation and management, it is moved to be exported by the
mempool.h and be part of mm subsystem.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 block/Kconfig           |    1 
 block/blk-mq.c          |   94 +++++++++-----------------------
 include/linux/mempool.h |   10 +++
 mm/Kconfig              |    6 ++
 mm/Makefile             |    1 
 mm/context_alloc.c      |  137 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 181 insertions(+), 68 deletions(-)
 create mode 100644 mm/context_alloc.c

diff --git a/block/Kconfig b/block/Kconfig
index c23094a14a2b..d2b3aba69f5e 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -7,6 +7,7 @@ menuconfig BLOCK
        default y
        select SBITMAP
        select SRCU
+       select CONTEXT_ALLOC
        help
 	 Provide block layer support for the kernel.
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 323c9cb28066..4bcdf50712a7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -10,7 +10,6 @@
 #include <linux/backing-dev.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
-#include <linux/kmemleak.h>
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -26,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
+#include <linux/mempool.h>
 
 #include <trace/events/block.h>
 
@@ -2015,8 +2015,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
-	struct page *page;
-
 	if (tags->rqs && set->ops->exit_request) {
 		int i;
 
@@ -2030,16 +2028,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		}
 	}
 
-	while (!list_empty(&tags->page_list)) {
-		page = list_first_entry(&tags->page_list, struct page, lru);
-		list_del_init(&page->lru);
-		/*
-		 * Remove kmemleak object previously allocated in
-		 * blk_mq_alloc_rqs().
-		 */
-		kmemleak_free(page_address(page));
-		__free_pages(page, page->private);
-	}
+	context_free_from_pages(&tags->page_list);
 }
 
 void blk_mq_free_rq_map(struct blk_mq_tags *tags)
@@ -2089,11 +2078,6 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 	return tags;
 }
 
-static size_t order_to_size(unsigned int order)
-{
-	return (size_t)PAGE_SIZE << order;
-}
-
 static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 			       unsigned int hctx_idx, int node)
 {
@@ -2109,12 +2093,20 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	return 0;
 }
 
+static void blk_mq_assign_request(void *data, void *ctx, int idx)
+{
+	struct blk_mq_tags *tags = (struct blk_mq_tags *)data;
+	struct request *rq = ctx;
+
+	tags->static_rqs[idx] = rq;
+}
+
 int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx, unsigned int depth)
 {
-	unsigned int i, j, entries_per_page, max_order = 4;
-	size_t rq_size, left;
-	int node;
+	unsigned int i;
+	size_t rq_size;
+	int node, rc;
 
 	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
 	if (node == NUMA_NO_NODE)
@@ -2128,62 +2120,28 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	 */
 	rq_size = round_up(sizeof(struct request) + set->cmd_size,
 				cache_line_size());
-	left = rq_size * depth;
-
-	for (i = 0; i < depth; ) {
-		int this_order = max_order;
-		struct page *page;
-		int to_do;
-		void *p;
-
-		while (this_order && left < order_to_size(this_order - 1))
-			this_order--;
-
-		do {
-			page = alloc_pages_node(node,
-				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO,
-				this_order);
-			if (page)
-				break;
-			if (!this_order--)
-				break;
-			if (order_to_size(this_order) < rq_size)
-				break;
-		} while (1);
 
-		if (!page)
-			goto fail;
+	rc = context_alloc_from_pages((void *)tags, depth, rq_size,
+				      &tags->page_list, 4, node,
+				      blk_mq_assign_request);
+	if (rc < 0)
+		goto fail;
 
-		page->private = this_order;
-		list_add_tail(&page->lru, &tags->page_list);
+	for (i = 0; i < rc; i++) {
+		struct request *rq = tags->static_rqs[i];
 
-		p = page_address(page);
-		/*
-		 * Allow kmemleak to scan these pages as they contain pointers
-		 * to additional allocations like via ops->init_request().
-		 */
-		kmemleak_alloc(p, order_to_size(this_order), 1, GFP_NOIO);
-		entries_per_page = order_to_size(this_order) / rq_size;
-		to_do = min(entries_per_page, depth - i);
-		left -= to_do * rq_size;
-		for (j = 0; j < to_do; j++) {
-			struct request *rq = p;
-
-			tags->static_rqs[i] = rq;
-			if (blk_mq_init_request(set, rq, hctx_idx, node)) {
-				tags->static_rqs[i] = NULL;
-				goto fail;
-			}
-
-			p += rq_size;
-			i++;
+		if (blk_mq_init_request(set, rq, hctx_idx, node)) {
+			tags->static_rqs[i] = NULL;
+			rc = -ENOMEM;
+			goto fail;
 		}
 	}
+
 	return 0;
 
 fail:
 	blk_mq_free_rqs(set, tags, hctx_idx);
-	return -ENOMEM;
+	return rc;
 }
 
 /*
diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 0c964ac107c2..f96c5d6b39fd 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -108,4 +108,14 @@ static inline mempool_t *mempool_create_page_pool(int min_nr, int order)
 			      (void *)(long)order);
 }
 
+/*
+ * Management functions to allocate or free a fixed size context memory from
+ * compound pages.
+ */
+int context_alloc_from_pages(void *data, unsigned int ctx_num, size_t ctx_size,
+			     struct list_head *page_list, int max_order,
+			     int node,
+			     void (*init_ctx)(void *data, void *ctx, int idx));
+void context_free_from_pages(struct list_head *page_list);
+
 #endif /* _LINUX_MEMPOOL_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933be65f..680d0a437832 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -739,4 +739,10 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+#
+# Provide context allocation from compound pages
+#
+config CONTEXT_ALLOC
+	bool
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 1937cc251883..c2110d161c7c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
+obj-$(CONFIG_CONTEXT_ALLOC) += context_alloc.o
diff --git a/mm/context_alloc.c b/mm/context_alloc.c
new file mode 100644
index 000000000000..e7f3b6454156
--- /dev/null
+++ b/mm/context_alloc.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common function for struct allocation. Moved from blk-mq code
+ *
+ * Copyright (C) 2013-2014 Jens Axboe
+ */
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/mm_types.h>
+#include <linux/list.h>
+#include <linux/kmemleak.h>
+#include <linux/mm.h>
+
+/**
+ * context_free_from_pages() - free allocated pages
+ * @page_list - list of pages to be freed
+ *
+ * Function to release all the pages in the @page_list back to the kernel.
+ */
+void context_free_from_pages(struct list_head *page_list)
+{
+	struct page *page, *n;
+
+	list_for_each_entry_safe(page, n, page_list, lru) {
+		list_del_init(&page->lru);
+		/*
+		 * Remove kmemleak object previously allocated to track the
+		 * pages.
+		 */
+		kmemleak_free(page_address(page));
+		__free_pages(page, page->private);
+	}
+}
+EXPORT_SYMBOL_GPL(context_free_from_pages);
+
+static size_t order_to_size(unsigned int order)
+{
+	return (size_t)PAGE_SIZE << order;
+}
+
+/**
+ * context_alloc_from_pages() - allocate @ctx_num blocks of @ctx_size from a
+ *				compound pages starting with highest order
+ *				@max_order for page allocation.
+ * @data - data ptr from caller to be passed to init_data
+ * @ctx_num - total number of context blocks needed
+ * @ctx_size - size of the context block
+ * @page_list - list to keep track of the pages allocated
+ * @max_order - max allocation order to try for pages allocation
+ * @node - NUMA node for the pages to be allocated from
+ * @init_ctx - caller provided init function for context init
+ *
+ * This function initially came from blk-mq request allocation code. It allows
+ * the caller to pre-allocate a large number of fix sized memory blocks for
+ * fast I/O processing without having to go through allocation path during I/O.
+ * The function will start with allocating pages with @max_order. With failure
+ * it will continue to attempt allocation with order size decreasing.
+ *
+ * Return values: N number of data blocks allocated or -ENOMEM on failure
+ */
+int context_alloc_from_pages(void *data, unsigned int ctx_num,
+			     size_t ctx_size, struct list_head *page_list,
+			     int max_order, int node,
+			     void (*init_ctx)(void *data, void *ctx, int idx))
+{
+	size_t left;
+	unsigned int i, j, entries_per_page;
+
+	left = ctx_size * ctx_num;
+
+	for (i = 0; i < ctx_num; ) {
+		int this_order = max_order;
+		struct page *page;
+		int to_do;
+		void *p;
+
+		/* Find a memory order size that would fit the need.  */
+		while (this_order && left < order_to_size(this_order - 1))
+			this_order--;
+
+		/*
+		 * Continue to try to allocate a compound page starting
+		 * with this_order at this_order. Keep trying while
+		 * decremeting the order while failure until order is 0
+		 * or order size is less than the context size.
+		 */
+		do {
+			page = alloc_pages_node(node,
+						GFP_NOIO | __GFP_NOWARN |
+						__GFP_NORETRY | __GFP_ZERO,
+						this_order);
+			if (page)
+				break;
+			if (!this_order--)
+				break;
+			if (order_to_size(this_order) < ctx_size)
+				break;
+		} while (1);
+
+		if (!page)
+			goto fail;
+
+		page->private = this_order;
+		list_add_tail(&page->lru, page_list);
+
+		p = page_address(page);
+
+		/* Allow kmemleak to track the allocation. */
+		kmemleak_alloc(p, order_to_size(this_order), 1, GFP_NOIO);
+
+		/*
+		 * Calculate the total context block for this allocation and
+		 * initialize them using function provided by caller.
+		 */
+		entries_per_page = order_to_size(this_order) / ctx_size;
+		to_do = min(entries_per_page, ctx_num - i);
+		left -= to_do * ctx_size;
+
+		if (!init_ctx) {
+			i += to_do;
+			continue;
+		}
+
+		for (j = 0; j < to_do; j++) {
+			init_ctx(data, p, i);
+			p += ctx_size;
+			i++;
+		}
+	}
+
+	return i;
+
+fail:
+	context_free_from_pages(page_list);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(context_alloc_from_pages);

