Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169501045A1
	for <lists+dmaengine@lfdr.de>; Wed, 20 Nov 2019 22:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKTVYJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Nov 2019 16:24:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:53826 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKTVYJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Nov 2019 16:24:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 13:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="290080868"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2019 13:24:07 -0800
Subject: [PATCH RFC 04/14] mm: create common code from request allocation
 based from blk-mq code
From:   Dave Jiang <dave.jiang@intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Cc:     dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Date:   Wed, 20 Nov 2019 14:24:07 -0700
Message-ID: <157428504761.36836.18308178739856771908.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the allocation of requests from compound pages to a common function
to allow usages by other callers. Since the routine has more to do with
memory allocation and management, it is moved to be exported by the
mempool.h and be part of mm subsystem.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 block/blk-mq.c          |   94 +++++++++++++----------------------------------
 include/linux/mempool.h |    6 +++
 mm/Makefile             |    2 -
 mm/request_alloc.c      |   95 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 69 deletions(-)
 create mode 100644 mm/request_alloc.c

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec791156e9cc..399dfe7b1d2e 100644
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
 
@@ -2054,8 +2054,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
-	struct page *page;
-
 	if (tags->rqs && set->ops->exit_request) {
 		int i;
 
@@ -2069,16 +2067,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
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
+	request_from_pages_free(&tags->page_list);
 }
 
 void blk_mq_free_rq_map(struct blk_mq_tags *tags)
@@ -2128,11 +2117,6 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
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
@@ -2148,12 +2132,20 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	return 0;
 }
 
+static void blk_mq_assign_request(void *ctx, void *ptr, int idx)
+{
+	struct blk_mq_tags *tags = (struct blk_mq_tags *)ctx;
+	struct request *rq = ptr;
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
@@ -2167,62 +2159,28 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
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
+	rc = request_from_pages_alloc((void *)tags, depth, rq_size,
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
index 0c964ac107c2..5b1f6214c881 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -108,4 +108,10 @@ static inline mempool_t *mempool_create_page_pool(int min_nr, int order)
 			      (void *)(long)order);
 }
 
+int request_from_pages_alloc(void *ctx, unsigned int depth, size_t rq_size,
+			     struct list_head *page_list, int max_order,
+			     int node,
+			     void (*assign)(void *ctx, void *req, int idx));
+void request_from_pages_free(struct list_head *page_list);
+
 #endif /* _LINUX_MEMPOOL_H */
diff --git a/mm/Makefile b/mm/Makefile
index d996846697ef..b122e7ddd1e5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -42,7 +42,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o mmu_context.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o $(mmu-y)
+			   debug.o gup.o request_alloc.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/request_alloc.c b/mm/request_alloc.c
new file mode 100644
index 000000000000..01ebea8ccdfc
--- /dev/null
+++ b/mm/request_alloc.c
@@ -0,0 +1,95 @@
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
+void request_from_pages_free(struct list_head *page_list)
+{
+	struct page *page, *n;
+
+	list_for_each_entry_safe(page, n, page_list, lru) {
+		list_del_init(&page->lru);
+		/*
+		 * Remove kmemleak object previously allocated in
+		 * blk_mq_alloc_rqs().
+		 */
+		kmemleak_free(page_address(page));
+		__free_pages(page, page->private);
+	}
+}
+EXPORT_SYMBOL_GPL(request_from_pages_free);
+
+static size_t order_to_size(unsigned int order)
+{
+	return (size_t)PAGE_SIZE << order;
+}
+
+int request_from_pages_alloc(void *ctx, unsigned int depth, size_t rq_size,
+			     struct list_head *page_list, int max_order,
+			     int node,
+			     void (*assign)(void *ctx, void *req, int idx))
+{
+	size_t left;
+	unsigned int i, j, entries_per_page;
+
+	left = rq_size * depth;
+
+	for (i = 0; i < depth; ) {
+		int this_order = max_order;
+		struct page *page;
+		int to_do;
+		void *p;
+
+		while (this_order && left < order_to_size(this_order - 1))
+			this_order--;
+
+		do {
+			page = alloc_pages_node(node,
+						GFP_NOIO | __GFP_NOWARN |
+						__GFP_NORETRY | __GFP_ZERO,
+						this_order);
+			if (page)
+				break;
+			if (!this_order--)
+				break;
+			if (order_to_size(this_order) < rq_size)
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
+		/*
+		 * Allow kmemleak to scan these pages as they contain pointers
+		 * to additional allocations like via ops->init_request().
+		 */
+		kmemleak_alloc(p, order_to_size(this_order), 1, GFP_NOIO);
+		entries_per_page = order_to_size(this_order) / rq_size;
+		to_do = min(entries_per_page, depth - i);
+		left -= to_do * rq_size;
+		for (j = 0; j < to_do; j++) {
+			assign((void *)ctx, p, i);
+			p += rq_size;
+			i++;
+		}
+	}
+
+	return i;
+
+fail:
+	request_from_pages_free(page_list);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(request_from_pages_alloc);

