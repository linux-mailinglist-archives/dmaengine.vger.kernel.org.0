Return-Path: <dmaengine+bounces-5224-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D00EABE755
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 00:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C791B6386F
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53C525F976;
	Tue, 20 May 2025 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHPSaCLr"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2912213E76;
	Tue, 20 May 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780763; cv=none; b=M1ZnzvDZpY+1RccfnZyAKWgPm43Q9xJAmggvgh+9znYGcy2uIqEC+3xlM/fo8dEjSUfvyjhmys1XcWCSt6XibXVjvDf3vDGVDeGWKFI/6L3gKUjDbr+F/ea5eUcJMRe9AgQ7JbsPIghFZyW4JwKODefFP+SgoFdyqrl8H8TXr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780763; c=relaxed/simple;
	bh=A3wjISd92WFp/YkWVPFHYHp2eTndHO86n7K5t7uLNI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmQn1NRqNCZBigUPfgiDzOtgyFZxMJXVRxbCs6jR9tZEOsvgm+yBkGLfhiAdpqpwSruthKwluyF+gN6pgy9taaRBUQdqUHkFhxHCE4xjdNsX0k3ghmr3r9oOgs5xiUNpqMpvVyrugCoDCXtWuecHaVMxJxXDnnOumFdcWuhh6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BHPSaCLr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=J3ZWGV109L3nCMO23/qgIhl4o2k9T7+Mtj6I3yZ/ZEM=; b=BHPSaCLrRs2kntVzErAWTjpe1Z
	WFpxr0q0dXsZdNNPwHEL+c+U9nCLdTAcqn2eziS7XPqJJKVlqjw/M5PdohIiVkyNeFrcjcYeMtypr
	NNqK/T9SNgHd6SmIjt7HlmoaBXetxlJ2J4O/WgHqm/d6VM3bR1NeCqNADR/GDN2I9yd/lJXoPHLBQ
	tWgpSARrGjMhTv6bcfagRuZMSnxSD8rOngpGy66ZjQz3/AtDOLoP9JMYE3vUZSV7TawiI/J1ptJ4J
	wivFhi680FHvKLGX9Rd/hOuqadvvTYeg286TCRKlV8HCMwBHhGrfmF/2Qz+sx5LuLuIzhz5348jdB
	hTa3jxPA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVcA-0000000EIMG-19Q4;
	Tue, 20 May 2025 22:39:14 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: vkoul@kernel.org,
	chenxiang66@hisilicon.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	leon@kernel.org,
	jgg@nvidia.com,
	alex.williamson@redhat.com,
	joel.granados@kernel.org
Cc: iommu@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 4/6] dmatest: add IOVA tests
Date: Tue, 20 May 2025 15:39:11 -0700
Message-ID: <20250520223913.3407136-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520223913.3407136-1-mcgrof@kernel.org>
References: <20250520223913.3407136-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The IOVA DMA API was added for very efficient mapping when using an
IOMMU, but we lack easy quick tests for it. Just leverage the existing
dmatest driver. We skip IOVA tests if use_dma_iommu() is false, as
dma_iova_try_alloc() would otherwise fail as an IOMMU is needed.

This also lets you compare and contrast performance on both APIs.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/dma/dmatest.c | 285 +++++++++++++++++++++++++++++++++---------
 1 file changed, 229 insertions(+), 56 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index b4c129e688e3..deec99d43742 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -20,6 +20,7 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
+#include <linux/iommu-dma.h>
 
 static bool nobounce;
 module_param(nobounce, bool, 0644);
@@ -247,6 +248,19 @@ struct dmatest_thread {
 	unsigned int streaming_failures;
 	unsigned long long streaming_total_len;
 	ktime_t streaming_runtime;
+
+	bool iova_support;
+	/* IOVA DMA statistics */
+	unsigned int iova_tests;
+	unsigned int iova_failures;
+	unsigned long long iova_total_len;
+	ktime_t iova_runtime;
+
+	/* IOVA-specific timings */
+	ktime_t iova_alloc_time;
+	ktime_t iova_link_time;
+	ktime_t iova_sync_time;
+	ktime_t iova_destroy_time;
 };
 
 struct dmatest_chan {
@@ -667,7 +681,8 @@ static int dmatest_do_dma_test(struct dmatest_thread *thread,
 			       unsigned int *failed_tests,
 			       unsigned long long *total_len,
 			       ktime_t *filltime,
-			       ktime_t *comparetime)
+			       ktime_t *comparetime,
+			       bool use_iova)
 {
 	struct dmatest_info *info = thread->info;
 	struct dmatest_params *params = &info->params;
@@ -677,10 +692,12 @@ static int dmatest_do_dma_test(struct dmatest_thread *thread,
 	struct dmatest_data *src = &thread->src;
 	struct dmatest_data *dst = &thread->dst;
 	struct dmatest_done *done = &thread->test_done;
+	struct dma_iova_state iova_state = {};
+	bool iova_used = false;
 	dma_addr_t *srcs;
 	dma_addr_t *dma_pq;
 	struct dma_async_tx_descriptor *tx = NULL;
-	struct dmaengine_unmap_data *um;
+	struct dmaengine_unmap_data *um = NULL;
 	dma_addr_t *dsts;
 	unsigned int len;
 	unsigned int error_count;
@@ -689,6 +706,7 @@ static int dmatest_do_dma_test(struct dmatest_thread *thread,
 	enum dma_status status;
 	ktime_t start, diff;
 	int ret;
+	enum dma_data_direction dir = DMA_BIDIRECTIONAL;
 
 	(*total_tests)++;
 
@@ -734,51 +752,123 @@ static int dmatest_do_dma_test(struct dmatest_thread *thread,
 		*filltime = ktime_add(*filltime, diff);
 	}
 
-	/* Map buffers */
-	um = dmaengine_get_unmap_data(dma_dev, src->cnt + dst->cnt, GFP_KERNEL);
-	if (!um) {
-		(*failed_tests)++;
-		result("unmap data NULL", *total_tests, src->off, dst->off, len, ret);
-		return -ENOMEM;
-	}
+	/* Try IOVA path if requested */
+	if (use_iova) {
+		phys_addr_t src_phys = virt_to_phys(src->aligned[0] + src->off);
+		ktime_t iova_start;
 
-	um->len = buf_size;
-	srcs = kcalloc(src->cnt, sizeof(dma_addr_t), GFP_KERNEL);
-	if (!srcs) {
-		dmaengine_unmap_put(um);
-		return -ENOMEM;
-	}
+		/* Track IOVA allocation time */
+		iova_start = ktime_get();
+		if (dma_iova_try_alloc(dma_dev, &iova_state, src_phys, len)) {
+			thread->iova_alloc_time = ktime_add(thread->iova_alloc_time,
+							   ktime_sub(ktime_get(), iova_start));
 
-	/* Map source buffers */
-	for (int i = 0; i < src->cnt; i++) {
-		void *buf = src->aligned[i];
-		struct page *pg = virt_to_page(buf);
-		unsigned long pg_off = offset_in_page(buf);
-
-		um->addr[i] = dma_map_page(dma_dev, pg, pg_off, um->len, DMA_TO_DEVICE);
-		srcs[i] = um->addr[i] + src->off;
-		ret = dma_mapping_error(dma_dev, um->addr[i]);
-		if (ret) {
-			result("src mapping error", *total_tests, src->off, dst->off, len, ret);
-			goto error_unmap;
+			/* Track IOVA link time */
+			iova_start = ktime_get();
+			ret = dma_iova_link(dma_dev, &iova_state, src_phys, 0, len, dir, 0);
+			thread->iova_link_time = ktime_add(thread->iova_link_time,
+							  ktime_sub(ktime_get(), iova_start));
+
+			if (ret) {
+				verbose_result("IOVA link failed",
+					      *total_tests, src->off, dst->off, len, ret);
+				dma_iova_free(dma_dev, &iova_state);
+				return ret;
+			}
+
+			/* Track IOVA sync time */
+			iova_start = ktime_get();
+			ret = dma_iova_sync(dma_dev, &iova_state, 0, len);
+			thread->iova_sync_time = ktime_add(thread->iova_sync_time,
+							  ktime_sub(ktime_get(), iova_start));
+
+			if (ret) {
+				verbose_result("IOVA sync failed",
+					      *total_tests, src->off, dst->off, len, ret);
+				dma_iova_unlink(dma_dev, &iova_state, 0, len, dir, 0);
+				dma_iova_free(dma_dev, &iova_state);
+				return ret;
+			}
+
+			iova_used = true;
+			verbose_result("IOVA path used", *total_tests, src->off, dst->off, len,
+				      (unsigned long)iova_state.addr);
+		} else {
+			thread->iova_alloc_time = ktime_add(thread->iova_alloc_time,
+							   ktime_sub(ktime_get(), iova_start));
+			verbose_result("IOVA allocation failed",
+				      *total_tests, src->off, dst->off, len, 0);
+			return -EINVAL;
 		}
-		um->to_cnt++;
 	}
 
-	/* Map destination buffers */
-	dsts = &um->addr[src->cnt];
-	for (int i = 0; i < dst->cnt; i++) {
-		void *buf = dst->aligned[i];
-		struct page *pg = virt_to_page(buf);
-		unsigned long pg_off = offset_in_page(buf);
-
-		dsts[i] = dma_map_page(dma_dev, pg, pg_off, um->len, DMA_BIDIRECTIONAL);
-		ret = dma_mapping_error(dma_dev, dsts[i]);
-		if (ret) {
-			result("dst mapping error", *total_tests, src->off, dst->off, len, ret);
-			goto error_unmap;
+	if (!iova_used) {
+		/* Regular DMA mapping path */
+		um = dmaengine_get_unmap_data(dma_dev, src->cnt + dst->cnt, GFP_KERNEL);
+		if (!um) {
+			(*failed_tests)++;
+			result("unmap data NULL", *total_tests, src->off, dst->off, len, ret);
+			return -ENOMEM;
 		}
-		um->bidi_cnt++;
+
+		um->len = buf_size;
+		srcs = kcalloc(src->cnt, sizeof(dma_addr_t), GFP_KERNEL);
+		if (!srcs) {
+			dmaengine_unmap_put(um);
+			return -ENOMEM;
+		}
+
+		/* Map source buffers */
+		for (int i = 0; i < src->cnt; i++) {
+			void *buf = src->aligned[i];
+			struct page *pg = virt_to_page(buf);
+			unsigned long pg_off = offset_in_page(buf);
+
+			um->addr[i] = dma_map_page(dma_dev, pg, pg_off, um->len, DMA_TO_DEVICE);
+			srcs[i] = um->addr[i] + src->off;
+			ret = dma_mapping_error(dma_dev, um->addr[i]);
+			if (ret) {
+				result("src mapping error", *total_tests, src->off, dst->off, len, ret);
+				goto error_unmap;
+			}
+			um->to_cnt++;
+		}
+
+		/* Map destination buffers */
+		dsts = &um->addr[src->cnt];
+		for (int i = 0; i < dst->cnt; i++) {
+			void *buf = dst->aligned[i];
+			struct page *pg = virt_to_page(buf);
+			unsigned long pg_off = offset_in_page(buf);
+
+			dsts[i] = dma_map_page(dma_dev, pg, pg_off, um->len, DMA_BIDIRECTIONAL);
+			ret = dma_mapping_error(dma_dev, dsts[i]);
+			if (ret) {
+				result("dst mapping error", *total_tests, src->off, dst->off, len, ret);
+				goto error_unmap;
+			}
+			um->bidi_cnt++;
+		}
+	} else {
+		/* For IOVA path, create simple arrays pointing to the IOVA */
+		srcs = kcalloc(src->cnt, sizeof(dma_addr_t), GFP_KERNEL);
+		if (!srcs) {
+			ret = -ENOMEM;
+			goto error_iova_cleanup;
+		}
+
+		dsts = kcalloc(dst->cnt, sizeof(dma_addr_t), GFP_KERNEL);
+		if (!dsts) {
+			ret = -ENOMEM;
+			kfree(srcs);
+			goto error_iova_cleanup;
+		}
+
+		/* For simplicity, use the same IOVA for src and dst in test */
+		for (int i = 0; i < src->cnt; i++)
+			srcs[i] = iova_state.addr;
+		for (int i = 0; i < dst->cnt; i++)
+			dsts[i] = iova_state.addr;
 	}
 
 	/* Prepare DMA transaction */
@@ -858,8 +948,18 @@ static int dmatest_do_dma_test(struct dmatest_thread *thread,
 		goto error_unmap;
 	}
 
-	dmaengine_unmap_put(um);
-	kfree(srcs);
+	/* Cleanup mappings */
+	if (iova_used) {
+		ktime_t destroy_start = ktime_get();
+		dma_iova_destroy(dma_dev, &iova_state, len, dir, 0);
+		thread->iova_destroy_time = ktime_add(thread->iova_destroy_time,
+						     ktime_sub(ktime_get(), destroy_start));
+		kfree(srcs);
+		kfree(dsts);
+	} else {
+		dmaengine_unmap_put(um);
+		kfree(srcs);
+	}
 
 	/* Verify results */
 	if (!params->noverify) {
@@ -883,49 +983,88 @@ static int dmatest_do_dma_test(struct dmatest_thread *thread,
 		*comparetime = ktime_add(*comparetime, diff);
 
 		if (error_count) {
-			result("data error", *total_tests, src->off,
-			       dst->off, len, error_count);
+			result(iova_used ? "IOVA data error" : "data error", *total_tests,
+			       src->off, dst->off, len, error_count);
 			(*failed_tests)++;
 			ret = -EIO;
 		} else {
-			verbose_result("test passed", *total_tests, src->off,
-				       dst->off, len, 0);
+			verbose_result(iova_used ? "IOVA test passed" : "test passed",
+				      *total_tests, src->off, dst->off, len, 0);
 			ret = 0;
 		}
 	} else {
-		verbose_result("test passed", *total_tests, src->off, dst->off, len, 0);
+		verbose_result(iova_used ? "IOVA test passed" : "test passed",
+			      *total_tests, src->off, dst->off, len, 0);
 		ret = 0;
 	}
 
 	return ret;
 
 error_unmap:
-	dmaengine_unmap_put(um);
-	kfree(srcs);
+	if (iova_used) {
+		kfree(srcs);
+		kfree(dsts);
+		goto error_iova_cleanup;
+	} else {
+		dmaengine_unmap_put(um);
+		kfree(srcs);
+	}
+	(*failed_tests)++;
+	return ret;
+
+error_iova_cleanup:
+	dma_iova_destroy(dma_dev, &iova_state, len, dir, 0);
 	(*failed_tests)++;
 	return ret;
 }
 
 static void dmatest_print_detailed_stats(struct dmatest_thread *thread)
 {
-	unsigned long long streaming_iops, streaming_kbs;
-	s64 streaming_runtime_us;
+	unsigned long long streaming_iops, streaming_kbs, iova_iops, iova_kbs;
+	s64 streaming_runtime_us, iova_runtime_us;
 
 	mutex_lock(&stats_mutex);
 
 	streaming_runtime_us = ktime_to_us(thread->streaming_runtime);
+	iova_runtime_us = ktime_to_us(thread->iova_runtime);
+
 	streaming_iops = dmatest_persec(streaming_runtime_us, thread->streaming_tests);
+	iova_iops = dmatest_persec(iova_runtime_us, thread->iova_tests);
+
 	streaming_kbs = dmatest_KBs(streaming_runtime_us, thread->streaming_total_len);
+	iova_kbs = dmatest_KBs(iova_runtime_us, thread->iova_total_len);
 
 	pr_info("=== %s: DMA Test Results ===\n", current->comm);
 
-	/* Streaming DMA statistics */
 	pr_info("%s: STREAMINMG DMA: %u tests, %u failures\n",
 		current->comm, thread->streaming_tests, thread->streaming_failures);
 	pr_info("%s: STREAMING DMA: %llu.%02llu iops, %llu KB/s, %lld us total\n",
 		current->comm, FIXPT_TO_INT(streaming_iops), FIXPT_GET_FRAC(streaming_iops),
 		streaming_kbs, streaming_runtime_us);
 
+	if (!thread->iova_support)
+		goto out;
+
+	pr_info("%s: IOVA DMA: %u tests, %u failures\n",
+		current->comm, thread->iova_tests, thread->iova_failures);
+	pr_info("%s: IOVA DMA: %llu.%02llu iops, %llu KB/s, %lld us total\n",
+		current->comm, FIXPT_TO_INT(iova_iops), FIXPT_GET_FRAC(iova_iops),
+		iova_kbs, iova_runtime_us);
+
+	pr_info("%s: IOVA timings: alloc %lld us, link %lld us, sync %lld us, destroy %lld us\n",
+		current->comm,
+		ktime_to_us(thread->iova_alloc_time),
+		ktime_to_us(thread->iova_link_time),
+		ktime_to_us(thread->iova_sync_time),
+		ktime_to_us(thread->iova_destroy_time));
+
+	if (streaming_runtime_us > 0 && iova_runtime_us > 0) {
+		long long speedup_pct = ((long long)streaming_runtime_us - iova_runtime_us) * 100 / streaming_runtime_us;
+		pr_info("%s: PERFORMANCE: IOVA is %lld%% %s than STREAMING DMA\n",
+			current->comm, abs(speedup_pct),
+			speedup_pct > 0 ? "faster" : "slower");
+	}
+out:
 	pr_info("=== %s: End Results ===\n", current->comm);
 	mutex_unlock(&stats_mutex);
 }
@@ -937,6 +1076,8 @@ static void dmatest_print_detailed_stats(struct dmatest_thread *thread)
  * in parallel for a single channel, and there may be multiple channels
  * being tested in parallel.
  *
+ * We test both Regular DMA and IOVA paths.
+ *
  * Before each test, the source and destination buffer is initialized
  * with a known pattern. This pattern is different depending on
  * whether it's in an area which is supposed to be copied or
@@ -950,11 +1091,12 @@ static int dmatest_func(void *data)
 	struct dmatest_info *info = thread->info;
 	struct dmatest_params *params = &info->params;
 	struct dma_chan *chan = thread->chan;
+	struct device *dev = dmaengine_get_dma_device(chan);
 	unsigned int buf_size;
 	u8 align;
 	bool is_memset;
 	unsigned int total_iterations = 0;
-	ktime_t start_time, streaming_start;
+	ktime_t start_time, streaming_start, iova_start;
 	ktime_t filltime = 0;
 	ktime_t comparetime = 0;
 	int ret;
@@ -968,6 +1110,15 @@ static int dmatest_func(void *data)
 	thread->streaming_failures = 0;
 	thread->streaming_total_len = 0;
 	thread->streaming_runtime = 0;
+	thread->iova_support = use_dma_iommu(dev);
+	thread->iova_tests = 0;
+	thread->iova_failures = 0;
+	thread->iova_total_len = 0;
+	thread->iova_runtime = 0;
+	thread->iova_alloc_time = 0;
+	thread->iova_link_time = 0;
+	thread->iova_sync_time = 0;
+	thread->iova_destroy_time = 0;
 
 	/* Setup test parameters and allocate buffers */
 	ret = dmatest_setup_test(thread, &buf_size, &align, &is_memset);
@@ -985,12 +1136,28 @@ static int dmatest_func(void *data)
 		ret = dmatest_do_dma_test(thread, buf_size, align, is_memset,
 					  &thread->streaming_tests, &thread->streaming_failures,
 					  &thread->streaming_total_len,
-					  &filltime, &comparetime);
+					  &filltime, &comparetime, false);
 		thread->streaming_runtime = ktime_add(thread->streaming_runtime,
 						    ktime_sub(ktime_get(), streaming_start));
 		if (ret < 0)
 			break;
 
+		/* Test IOVA path */
+		if (thread->iova_support) {
+			iova_start = ktime_get();
+			ret = dmatest_do_dma_test(thread, buf_size,
+						  align, is_memset,
+						  &thread->iova_tests,
+						  &thread->iova_failures,
+						  &thread->iova_total_len,
+						  &filltime, &comparetime, true);
+			thread->iova_runtime = ktime_add(thread->iova_runtime,
+							ktime_sub(ktime_get(),
+							iova_start));
+			if (ret < 0)
+				break;
+		}
+
 		total_iterations++;
 	}
 
@@ -999,6 +1166,12 @@ static int dmatest_func(void *data)
 					   ktime_divns(filltime, 2));
 	thread->streaming_runtime = ktime_sub(thread->streaming_runtime,
 					   ktime_divns(comparetime, 2));
+	if (thread->iova_support) {
+		thread->iova_runtime = ktime_sub(thread->iova_runtime,
+						ktime_divns(filltime, 2));
+		thread->iova_runtime = ktime_sub(thread->iova_runtime,
+						ktime_divns(comparetime, 2));
+	}
 
 	ret = 0;
 	dmatest_cleanup_test(thread);
@@ -1008,7 +1181,7 @@ static int dmatest_func(void *data)
 	dmatest_print_detailed_stats(thread);
 
 	/* terminate all transfers on specified channels */
-	if (ret || (thread->streaming_failures))
+	if (ret || (thread->streaming_failures + thread->iova_failures))
 		dmaengine_terminate_sync(chan);
 
 	thread->done = true;
-- 
2.47.2


