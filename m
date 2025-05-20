Return-Path: <dmaengine+bounces-5228-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB5ABE75D
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 00:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DBA3A487C
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 22:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21348262803;
	Tue, 20 May 2025 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mUzhbSyY"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1C25F7A5;
	Tue, 20 May 2025 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780765; cv=none; b=g1qZWqY8VPwkBlZe15UEZfpqf38mfFhfLRygAPvb6MtCQHjEV+OLGrNcX0Sk1jCXKmxQ4jiEkcrP0G/ZLaRXlprzDiYxnaaDGdnGdzmoduzQjToms+wrcoVe3ieJa6Knc8bYWxiwWk7yN4cxzhaxeNHmNz4NQtllx5481NOLbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780765; c=relaxed/simple;
	bh=9P6JkaQzTiNb0JWSd2wAZNgysr/BAAzM2VevHPD5n3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNIX9dHi7k706O6n1DqbpbOQCW7ofqoKx30WQ9urWnADTTDZ5oEm7PKSsFH+ZFXPlAO9JTaIkPaDLCf+2Q2OPI0SasSdI7QBsknp0qGfd5ba/TSMttCSU3XsQj9Kfxu6D5oAXZmEkFedIHk3nRJ9/zk99K7NdxDh+7E6Zk0NjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mUzhbSyY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=+7in2ohAhLEsNpO8Gfw2xROmEnRm0I2n1Qm569qhae0=; b=mUzhbSyYTepdLaZHRvbcGy0HY7
	ELbcDKwxWqzZTmMGjBW8UATj/i2QVivNJ6zHLp2BvRNRJsuBJFl1D6VK1cPY4xd/S4bBoDcSCzS8I
	/+8NecruA630XXoJl//FlFX+8m3GbQwOQoKdpBBCBR+W5ijbo9TfLgsoT/Ox57l2GrYzMCcFb7QnP
	CvonidLYIqjAqHr8iiRre2gTnQn2bRjL/6CccmainLHaxIe6VKMVAYS40Pu8GhrVu6A1tqfzZ+5FG
	zRjM0AyByIH0gmcWSHw866JN3sqcb+EqfdvO+Z3C29za2SE4h31Abrfyq3CT21grkb4KC7KJ5E5s9
	ljR2anug==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHVcA-0000000EIML-1TuR;
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
Subject: [PATCH 6/6] dma-mapping: benchmark: add IOVA support
Date: Tue, 20 May 2025 15:39:13 -0700
Message-ID: <20250520223913.3407136-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520223913.3407136-1-mcgrof@kernel.org>
References: <20250520223913.3407136-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Add support to use the IOVA DMA API, and allow comparing and contrasting
to the streaming DMA API. Since the IOVA is intended to be an enhancement
when using an IOMMU which supports DMA over it only allow the IOVA to be
used proactively for devices which have this support, that is when
use_dma_iommu() is true. We don't try a fallback as the goal is clear,
only to use the IOVA when intended.

Example output, using intel-iommu on qemu against a random number
generator device, this output is completely artificial as its a VM
and its using more threads than the guest even has cores, the goal was
to at least visualize some numerical output on both paths:

./tools/testing/selftests/dma/dma_map_benchmark -t 24 -i 2
=== DMA Mapping Benchmark Results ===
Configuration: threads:24 seconds:20 node:-1 dir:BIDIRECTIONAL granule:1 iova:2
Buffer size: 1 pages (4 KB)

STREAMING DMA RESULTS:
  Map   latency:    12.3 μs (σ=257.9 μs)
  Unmap latency:     3.7 μs (σ=142.5 μs)
  Total latency:    16.0 μs

IOVA DMA RESULTS:
  Alloc   latency:     0.1 μs (σ= 31.1 μs)
  Link    latency:     2.5 μs (σ=116.9 μs)
  Sync    latency:     9.6 μs (σ=227.8 μs)
  Destroy latency:     3.6 μs (σ=141.2 μs)
  Total latency:    15.8 μs

PERFORMANCE COMPARISON:
  Streaming DMA total:    16.0 μs
  IOVA DMA total:         15.8 μs
  Performance ratio:      0.99x (IOVA is 1.3% faster)
  Streaming throughput:    62500 ops/sec
  IOVA throughput:         63291 ops/sec
  Streaming bandwidth:     244.1 MB/s
  IOVA bandwidth:          247.2 MB/s

IOVA OPERATION BREAKDOWN:
  Alloc:     0.6% (   0.1 μs)
  Link:     15.8% (   2.5 μs)
  Sync:     60.8% (   9.6 μs)
  Destroy:  22.8% (   3.6 μs)

RECOMMENDATIONS:
  ~ IOVA and Streaming APIs show similar performance
=== End of Benchmark ===

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/map_benchmark.h                 |  11 +
 kernel/dma/Kconfig                            |   4 +-
 kernel/dma/map_benchmark.c                    | 417 +++++++++++++++++-
 .../testing/selftests/dma/dma_map_benchmark.c | 145 +++++-
 4 files changed, 562 insertions(+), 15 deletions(-)

diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
index 62674c83bde4..da7c9e3ddf21 100644
--- a/include/linux/map_benchmark.h
+++ b/include/linux/map_benchmark.h
@@ -7,6 +7,7 @@
 #define _KERNEL_DMA_BENCHMARK_H
 
 #define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
+#define DMA_MAP_BENCHMARK_IOVA	_IOWR('d', 2, struct map_benchmark)
 #define DMA_MAP_MAX_THREADS     1024
 #define DMA_MAP_MAX_SECONDS     300
 #define DMA_MAP_MAX_TRANS_DELAY (10 * NSEC_PER_MSEC)
@@ -27,5 +28,15 @@ struct map_benchmark {
 	__u32 dma_dir; /* DMA data direction */
 	__u32 dma_trans_ns; /* time for DMA transmission in ns */
 	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
+	__u32 has_iommu_dma;
+	__u64 avg_iova_alloc_100ns;
+	__u64 avg_iova_link_100ns;
+	__u64 avg_iova_sync_100ns;
+	__u64 avg_iova_destroy_100ns;
+	__u64 iova_alloc_stddev;
+	__u64 iova_link_stddev;
+	__u64 iova_sync_stddev;
+	__u64 iova_destroy_stddev;
+	__u32 use_iova; /* 0=regular, 1=IOVA, 2=both */
 };
 #endif /* _KERNEL_DMA_BENCHMARK_H */
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 31cfdb6b4bc3..e2d5784f46eb 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -261,10 +261,10 @@ config DMA_API_DEBUG
 	  If unsure, say N.
 
 config DMA_MAP_BENCHMARK
-	bool "Enable benchmarking of streaming DMA mapping"
+	bool "Enable benchmarking of streaming and IOVA DMA mapping"
 	depends on DEBUG_FS
 	help
 	  Provides /sys/kernel/debug/dma_map_benchmark that helps with testing
-	  performance of dma_(un)map_page.
+	  performance of the streaming DMA dma_(un)map_page and IOVA API.
 
 	  See tools/testing/selftests/dma/dma_map_benchmark.c
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index b54345a757cb..3ae34433420b 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/timekeeping.h>
+#include <linux/iommu-dma.h>
 
 struct map_benchmark_data {
 	struct map_benchmark bparam;
@@ -29,9 +30,127 @@ struct map_benchmark_data {
 	atomic64_t sum_sq_map;
 	atomic64_t sum_sq_unmap;
 	atomic64_t loops;
+
+	/* IOVA-specific counters */
+	atomic64_t sum_iova_alloc_100ns;
+	atomic64_t sum_iova_link_100ns;
+	atomic64_t sum_iova_sync_100ns;
+	atomic64_t sum_iova_destroy_100ns;
+	atomic64_t sum_sq_iova_alloc;
+	atomic64_t sum_sq_iova_link;
+	atomic64_t sum_sq_iova_sync;
+	atomic64_t sum_sq_iova_destroy;
+	atomic64_t iova_loops;
 };
 
-static int map_benchmark_thread(void *data)
+static int benchmark_thread_iova(void *data)
+{
+	void *buf;
+	struct map_benchmark_data *map = data;
+	int npages = map->bparam.granule;
+	u64 size = npages * PAGE_SIZE;
+	int ret = 0;
+	enum dma_data_direction dir = map->dir;
+
+	buf = alloc_pages_exact(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	while (!kthread_should_stop()) {
+		struct dma_iova_state iova_state;
+		phys_addr_t phys;
+		ktime_t alloc_stime, alloc_etime, link_stime, link_etime;
+		ktime_t sync_stime, sync_etime, destroy_stime, destroy_etime;
+		ktime_t alloc_delta, link_delta, sync_delta, destroy_delta;
+		u64 alloc_100ns, link_100ns, sync_100ns, destroy_100ns;
+		u64 alloc_sq, link_sq, sync_sq, destroy_sq;
+
+		/* Stain cache if needed */
+		if (map->dir != DMA_FROM_DEVICE)
+			memset(buf, 0x66, size);
+
+		phys = virt_to_phys(buf);
+
+		/* IOVA allocation */
+		alloc_stime = ktime_get();
+		if (!dma_iova_try_alloc(map->dev, &iova_state, phys, size)) {
+			pr_warn_once("IOVA allocation not supported on device %s\n",
+				     dev_name(map->dev));
+			/* IOVA not supported, skip this iteration */
+			cond_resched();
+			continue;
+		}
+		alloc_etime = ktime_get();
+		alloc_delta = ktime_sub(alloc_etime, alloc_stime);
+
+		/* IOVA linking */
+		link_stime = ktime_get();
+		ret = dma_iova_link(map->dev, &iova_state, phys, 0, size, dir, 0);
+		link_etime = ktime_get();
+		link_delta = ktime_sub(link_etime, link_stime);
+
+		if (ret) {
+			pr_err("dma_iova_link failed on %s\n", dev_name(map->dev));
+			dma_iova_free(map->dev, &iova_state);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/* IOVA sync */
+		sync_stime = ktime_get();
+		ret = dma_iova_sync(map->dev, &iova_state, 0, size);
+		sync_etime = ktime_get();
+		sync_delta = ktime_sub(sync_etime, sync_stime);
+
+		if (ret) {
+			pr_err("dma_iova_sync failed on %s\n", dev_name(map->dev));
+			dma_iova_unlink(map->dev, &iova_state, 0, size, dir, 0);
+			dma_iova_free(map->dev, &iova_state);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/* Pretend DMA is transmitting */
+		ndelay(map->bparam.dma_trans_ns);
+
+		/* IOVA destroy */
+		destroy_stime = ktime_get();
+		dma_iova_destroy(map->dev, &iova_state, size, dir, 0);
+		destroy_etime = ktime_get();
+		destroy_delta = ktime_sub(destroy_etime, destroy_stime);
+
+		/* Calculate sum and sum of squares */
+		alloc_100ns = div64_ul(alloc_delta, 100);
+		link_100ns = div64_ul(link_delta, 100);
+		sync_100ns = div64_ul(sync_delta, 100);
+		destroy_100ns = div64_ul(destroy_delta, 100);
+
+		alloc_sq = alloc_100ns * alloc_100ns;
+		link_sq = link_100ns * link_100ns;
+		sync_sq = sync_100ns * sync_100ns;
+		destroy_sq = destroy_100ns * destroy_100ns;
+
+		atomic64_add(alloc_100ns, &map->sum_iova_alloc_100ns);
+		atomic64_add(link_100ns, &map->sum_iova_link_100ns);
+		atomic64_add(sync_100ns, &map->sum_iova_sync_100ns);
+		atomic64_add(destroy_100ns, &map->sum_iova_destroy_100ns);
+
+		atomic64_add(alloc_sq, &map->sum_sq_iova_alloc);
+		atomic64_add(link_sq, &map->sum_sq_iova_link);
+		atomic64_add(sync_sq, &map->sum_sq_iova_sync);
+		atomic64_add(destroy_sq, &map->sum_sq_iova_destroy);
+
+		atomic64_inc(&map->iova_loops);
+
+		cond_resched();
+	}
+
+out:
+	free_pages_exact(buf, size);
+	return ret;
+}
+
+static int benchmark_thread_streaming(void *data)
 {
 	void *buf;
 	dma_addr_t dma_addr;
@@ -96,7 +215,7 @@ static int map_benchmark_thread(void *data)
 		 * we may hangup the kernel in a non-preemptible kernel when
 		 * the test kthreads number >= CPU number, the test kthreads
 		 * will run endless on every CPU since the thread resposible
-		 * for notifying the kthread stop (in do_map_benchmark())
+		 * for notifying the kthread stop (in do_streaming_benchmark())
 		 * could not be scheduled.
 		 *
 		 * Note this may degrade the test concurrency since the test
@@ -112,7 +231,250 @@ static int map_benchmark_thread(void *data)
 	return ret;
 }
 
-static int do_map_benchmark(struct map_benchmark_data *map)
+static int do_iova_benchmark(struct map_benchmark_data *map)
+{
+	struct task_struct **tsk;
+	int threads = map->bparam.threads;
+	int node = map->bparam.node;
+	u64 iova_loops;
+	int ret = 0;
+	int i;
+
+	tsk = kmalloc_array(threads, sizeof(*tsk), GFP_KERNEL);
+	if (!tsk)
+		return -ENOMEM;
+
+	get_device(map->dev);
+
+	/* Create IOVA threads only */
+	for (i = 0; i < threads; i++) {
+		tsk[i] = kthread_create_on_node(benchmark_thread_iova, map,
+				node, "dma-iova-benchmark/%d", i);
+		if (IS_ERR(tsk[i])) {
+			pr_err("create dma_iova thread failed\n");
+			ret = PTR_ERR(tsk[i]);
+			while (--i >= 0)
+				kthread_stop(tsk[i]);
+			goto out;
+		}
+
+		if (node != NUMA_NO_NODE)
+			kthread_bind_mask(tsk[i], cpumask_of_node(node));
+	}
+
+	/* Clear previous IOVA benchmark values */
+	atomic64_set(&map->sum_iova_alloc_100ns, 0);
+	atomic64_set(&map->sum_iova_link_100ns, 0);
+	atomic64_set(&map->sum_iova_sync_100ns, 0);
+	atomic64_set(&map->sum_iova_destroy_100ns, 0);
+	atomic64_set(&map->sum_sq_iova_alloc, 0);
+	atomic64_set(&map->sum_sq_iova_link, 0);
+	atomic64_set(&map->sum_sq_iova_sync, 0);
+	atomic64_set(&map->sum_sq_iova_destroy, 0);
+	atomic64_set(&map->iova_loops, 0);
+
+	/* Start all threads */
+	for (i = 0; i < threads; i++) {
+		get_task_struct(tsk[i]);
+		wake_up_process(tsk[i]);
+	}
+
+	msleep_interruptible(map->bparam.seconds * 1000);
+
+	/* Stop all threads */
+	for (i = 0; i < threads; i++) {
+		int kthread_ret = kthread_stop_put(tsk[i]);
+		if (kthread_ret)
+			ret = kthread_ret;
+	}
+
+	if (ret)
+		goto out;
+
+	/* Calculate IOVA statistics */
+	iova_loops = atomic64_read(&map->iova_loops);
+	if (likely(iova_loops > 0)) {
+		u64 alloc_variance, link_variance, sync_variance, destroy_variance;
+		u64 sum_alloc = atomic64_read(&map->sum_iova_alloc_100ns);
+		u64 sum_link = atomic64_read(&map->sum_iova_link_100ns);
+		u64 sum_sync = atomic64_read(&map->sum_iova_sync_100ns);
+		u64 sum_destroy = atomic64_read(&map->sum_iova_destroy_100ns);
+		u64 sum_sq_alloc = atomic64_read(&map->sum_sq_iova_alloc);
+		u64 sum_sq_link = atomic64_read(&map->sum_sq_iova_link);
+		u64 sum_sq_sync = atomic64_read(&map->sum_sq_iova_sync);
+		u64 sum_sq_destroy = atomic64_read(&map->sum_sq_iova_destroy);
+
+		/* Average latencies */
+		map->bparam.avg_iova_alloc_100ns = div64_u64(sum_alloc, iova_loops);
+		map->bparam.avg_iova_link_100ns = div64_u64(sum_link, iova_loops);
+		map->bparam.avg_iova_sync_100ns = div64_u64(sum_sync, iova_loops);
+		map->bparam.avg_iova_destroy_100ns = div64_u64(sum_destroy, iova_loops);
+
+		/* Standard deviations */
+		alloc_variance = div64_u64(sum_sq_alloc, iova_loops) -
+				map->bparam.avg_iova_alloc_100ns * map->bparam.avg_iova_alloc_100ns;
+		link_variance = div64_u64(sum_sq_link, iova_loops) -
+				map->bparam.avg_iova_link_100ns * map->bparam.avg_iova_link_100ns;
+		sync_variance = div64_u64(sum_sq_sync, iova_loops) -
+				map->bparam.avg_iova_sync_100ns * map->bparam.avg_iova_sync_100ns;
+		destroy_variance = div64_u64(sum_sq_destroy, iova_loops) -
+				map->bparam.avg_iova_destroy_100ns * map->bparam.avg_iova_destroy_100ns;
+
+		map->bparam.iova_alloc_stddev = int_sqrt64(alloc_variance);
+		map->bparam.iova_link_stddev = int_sqrt64(link_variance);
+		map->bparam.iova_sync_stddev = int_sqrt64(sync_variance);
+		map->bparam.iova_destroy_stddev = int_sqrt64(destroy_variance);
+	}
+
+out:
+	put_device(map->dev);
+	kfree(tsk);
+	return ret;
+}
+
+static int do_streaming_iova_benchmark(struct map_benchmark_data *map)
+{
+	struct task_struct **tsk;
+	int threads = map->bparam.threads;
+	int node = map->bparam.node;
+	int regular_threads, iova_threads;
+	u64 loops, iova_loops;
+	int ret = 0;
+	int i;
+
+	tsk = kmalloc_array(threads * 2, sizeof(*tsk), GFP_KERNEL);
+	if (!tsk)
+		return -ENOMEM;
+
+	get_device(map->dev);
+
+	/* Split threads between regular and IOVA testing */
+	regular_threads = threads / 2;
+	iova_threads = threads - regular_threads;
+
+	/* Create streaming DMA threads */
+	for (i = 0; i < regular_threads; i++) {
+		tsk[i] = kthread_create_on_node(benchmark_thread_streaming, map,
+				node, "dma-streaming-benchmark/%d", i);
+		if (IS_ERR(tsk[i])) {
+			pr_err("create dma_map thread failed\n");
+			ret = PTR_ERR(tsk[i]);
+			while (--i >= 0)
+				kthread_stop(tsk[i]);
+			goto out;
+		}
+
+		if (node != NUMA_NO_NODE)
+			kthread_bind_mask(tsk[i], cpumask_of_node(node));
+	}
+
+	/* Create IOVA DMA threads */
+	for (i = regular_threads; i < threads; i++) {
+		tsk[i] = kthread_create_on_node(benchmark_thread_iova, map,
+				node, "dma-iova-benchmark/%d", i - regular_threads);
+		if (IS_ERR(tsk[i])) {
+			pr_err("create dma_iova thread failed\n");
+			ret = PTR_ERR(tsk[i]);
+			while (--i >= 0)
+				kthread_stop(tsk[i]);
+			goto out;
+		}
+
+		if (node != NUMA_NO_NODE)
+			kthread_bind_mask(tsk[i], cpumask_of_node(node));
+	}
+
+	/* Clear previous benchmark values */
+	atomic64_set(&map->sum_map_100ns, 0);
+	atomic64_set(&map->sum_unmap_100ns, 0);
+	atomic64_set(&map->sum_sq_map, 0);
+	atomic64_set(&map->sum_sq_unmap, 0);
+	atomic64_set(&map->loops, 0);
+
+	atomic64_set(&map->sum_iova_alloc_100ns, 0);
+	atomic64_set(&map->sum_iova_link_100ns, 0);
+	atomic64_set(&map->sum_iova_sync_100ns, 0);
+	atomic64_set(&map->sum_iova_destroy_100ns, 0);
+	atomic64_set(&map->sum_sq_iova_alloc, 0);
+	atomic64_set(&map->sum_sq_iova_link, 0);
+	atomic64_set(&map->sum_sq_iova_sync, 0);
+	atomic64_set(&map->sum_sq_iova_destroy, 0);
+	atomic64_set(&map->iova_loops, 0);
+
+	/* Start all threads */
+	for (i = 0; i < threads; i++) {
+		get_task_struct(tsk[i]);
+		wake_up_process(tsk[i]);
+	}
+
+	msleep_interruptible(map->bparam.seconds * 1000);
+
+	/* Stop all threads */
+	for (i = 0; i < threads; i++) {
+		int kthread_ret = kthread_stop_put(tsk[i]);
+		if (kthread_ret)
+			ret = kthread_ret;
+	}
+
+	if (ret)
+		goto out;
+
+	/* Calculate streaming DMA statistics */
+	loops = atomic64_read(&map->loops);
+	if (loops > 0) {
+		u64 map_variance, unmap_variance;
+		u64 sum_map = atomic64_read(&map->sum_map_100ns);
+		u64 sum_unmap = atomic64_read(&map->sum_unmap_100ns);
+		u64 sum_sq_map = atomic64_read(&map->sum_sq_map);
+		u64 sum_sq_unmap = atomic64_read(&map->sum_sq_unmap);
+
+		map->bparam.avg_map_100ns = div64_u64(sum_map, loops);
+		map->bparam.avg_unmap_100ns = div64_u64(sum_unmap, loops);
+
+		map_variance = div64_u64(sum_sq_map, loops) -
+				map->bparam.avg_map_100ns * map->bparam.avg_map_100ns;
+		unmap_variance = div64_u64(sum_sq_unmap, loops) -
+				map->bparam.avg_unmap_100ns * map->bparam.avg_unmap_100ns;
+		map->bparam.map_stddev = int_sqrt64(map_variance);
+		map->bparam.unmap_stddev = int_sqrt64(unmap_variance);
+	}
+
+	/* Calculate IOVA statistics */
+	iova_loops = atomic64_read(&map->iova_loops);
+	if (iova_loops > 0) {
+		u64 alloc_variance, link_variance, sync_variance, destroy_variance;
+		u64 sum_alloc = atomic64_read(&map->sum_iova_alloc_100ns);
+		u64 sum_link = atomic64_read(&map->sum_iova_link_100ns);
+		u64 sum_sync = atomic64_read(&map->sum_iova_sync_100ns);
+		u64 sum_destroy = atomic64_read(&map->sum_iova_destroy_100ns);
+
+		map->bparam.avg_iova_alloc_100ns = div64_u64(sum_alloc, iova_loops);
+		map->bparam.avg_iova_link_100ns = div64_u64(sum_link, iova_loops);
+		map->bparam.avg_iova_sync_100ns = div64_u64(sum_sync, iova_loops);
+		map->bparam.avg_iova_destroy_100ns = div64_u64(sum_destroy, iova_loops);
+
+		alloc_variance = div64_u64(atomic64_read(&map->sum_sq_iova_alloc), iova_loops) -
+				map->bparam.avg_iova_alloc_100ns * map->bparam.avg_iova_alloc_100ns;
+		link_variance = div64_u64(atomic64_read(&map->sum_sq_iova_link), iova_loops) -
+				map->bparam.avg_iova_link_100ns * map->bparam.avg_iova_link_100ns;
+		sync_variance = div64_u64(atomic64_read(&map->sum_sq_iova_sync), iova_loops) -
+				map->bparam.avg_iova_sync_100ns * map->bparam.avg_iova_sync_100ns;
+		destroy_variance = div64_u64(atomic64_read(&map->sum_sq_iova_destroy), iova_loops) -
+				map->bparam.avg_iova_destroy_100ns * map->bparam.avg_iova_destroy_100ns;
+
+		map->bparam.iova_alloc_stddev = int_sqrt64(alloc_variance);
+		map->bparam.iova_link_stddev = int_sqrt64(link_variance);
+		map->bparam.iova_sync_stddev = int_sqrt64(sync_variance);
+		map->bparam.iova_destroy_stddev = int_sqrt64(destroy_variance);
+	}
+
+out:
+	put_device(map->dev);
+	kfree(tsk);
+	return ret;
+}
+
+static int do_streaming_benchmark(struct map_benchmark_data *map)
 {
 	struct task_struct **tsk;
 	int threads = map->bparam.threads;
@@ -128,8 +490,8 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	get_device(map->dev);
 
 	for (i = 0; i < threads; i++) {
-		tsk[i] = kthread_create_on_node(map_benchmark_thread, map,
-				map->bparam.node, "dma-map-benchmark/%d", i);
+		tsk[i] = kthread_create_on_node(benchmark_thread_streaming, map,
+				map->bparam.node, "dma-streaming-benchmark/%d", i);
 		if (IS_ERR(tsk[i])) {
 			pr_err("create dma_map thread failed\n");
 			ret = PTR_ERR(tsk[i]);
@@ -260,6 +622,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 	if (ret)
 		return ret;
 
+	if (!use_dma_iommu(map->dev))
+		map->bparam.has_iommu_dma = 0;
+	else
+		map->bparam.has_iommu_dma = 1;
+
 	switch (cmd) {
 	case DMA_MAP_BENCHMARK:
 		old_dma_mask = dma_get_mask(map->dev);
@@ -272,7 +639,7 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 		}
 
 		/* Run streaming DMA benchmark */
-		ret = do_map_benchmark(map);
+		ret = do_streaming_benchmark(map);
 
 		/*
 		 * restore the original dma_mask as many devices' dma_mask are
@@ -285,6 +652,44 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 		if (ret)
 			return ret;
 		break;
+
+	case DMA_MAP_BENCHMARK_IOVA:
+		if (!use_dma_iommu(map->dev)) {
+			pr_info("IOVA API is not supported on this device, lacks IOMMU DMA%s\n",
+				dev_name(map->dev));
+			return -EOPNOTSUPP;
+		}
+		/* Validate IOVA-specific parameters */
+		if (map->bparam.use_iova > 2) {
+			pr_err("invalid IOVA mode, must be 0-2\n");
+			return -EINVAL;
+		}
+
+		/* Save and set DMA mask */
+		old_dma_mask = dma_get_mask(map->dev);
+		ret = dma_set_mask(map->dev, DMA_BIT_MASK(map->bparam.dma_bits));
+		if (ret) {
+			pr_err("failed to set dma_mask on device %s\n",
+				dev_name(map->dev));
+			return -EINVAL;
+		}
+
+		/* Choose benchmark type based on use_iova field */
+		if (map->bparam.use_iova == 2) {
+			/* Both regular and IOVA */
+			ret = do_streaming_iova_benchmark(map);
+		} else if (map->bparam.use_iova == 1) {
+			/* IOVA only */
+			ret = do_iova_benchmark(map);
+		}
+
+		/* Restore original DMA mask */
+		dma_set_mask(map->dev, old_dma_mask);
+
+		if (ret)
+			return ret;
+		break;
+
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index b12f1f9babf8..4a2158aa56b6 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -31,10 +31,11 @@ int main(int argc, char **argv)
 	int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
 	/* default granule 1 PAGESIZE */
 	int granule = 1;
+	int use_iova = 0;
 
 	int cmd = DMA_MAP_BENCHMARK;
 
-	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
+	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:i:")) != -1) {
 		switch (opt) {
 		case 't':
 			threads = atoi(optarg);
@@ -51,6 +52,11 @@ int main(int argc, char **argv)
 		case 'd':
 			dir = atoi(optarg);
 			break;
+		case 'i':
+			use_iova = atoi(optarg);
+			if (use_iova)
+				cmd = DMA_MAP_BENCHMARK_IOVA;
+			break;
 		case 'x':
 			xdelay = atoi(optarg);
 			break;
@@ -111,18 +117,143 @@ int main(int argc, char **argv)
 	map.dma_dir = dir;
 	map.dma_trans_ns = xdelay;
 	map.granule = granule;
+	map.use_iova = use_iova;
 
 	if (ioctl(fd, cmd, &map)) {
 		perror("ioctl");
 		exit(1);
 	}
 
-	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
-			threads, seconds, node, dir[directions], granule);
-	printf("average map latency(us):%.1f standard deviation:%.1f\n",
-			map.avg_map_100ns/10.0, map.map_stddev/10.0);
-	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
-			map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
+	printf("=== DMA Mapping Benchmark Results ===\n");
+	printf("Configuration: threads:%d seconds:%d node:%d dir:%s granule:%d iova:%d, has_iommu_dma:%d\n",
+	       threads, seconds, node, directions[dir], granule, use_iova, map.has_iommu_dma);
+	printf("Buffer size: %d pages (%d KB)\n", granule, granule * 4);
+	printf("\n");
+
+	if (use_iova == 0 || use_iova == 2) {
+	    printf("STREAMING DMA RESULTS:\n");
+	    printf("  Map   latency: %7.1f μs (σ=%5.1f μs)\n",
+		   map.avg_map_100ns/10.0, map.map_stddev/10.0);
+	    printf("  Unmap latency: %7.1f μs (σ=%5.1f μs)\n",
+		   map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
+
+	    double streaming_total = map.avg_map_100ns/10.0 + map.avg_unmap_100ns/10.0;
+	    printf("  Total latency: %7.1f μs\n", streaming_total);
+	    printf("\n");
+	}
+
+	if (map.has_iommu_dma && (use_iova == 1 || use_iova == 2)) {
+	    printf("IOVA DMA RESULTS:\n");
+	    printf("  Alloc   latency: %7.1f μs (σ=%5.1f μs)\n",
+		   map.avg_iova_alloc_100ns/10.0, map.iova_alloc_stddev/10.0);
+	    printf("  Link    latency: %7.1f μs (σ=%5.1f μs)\n",
+		   map.avg_iova_link_100ns/10.0, map.iova_link_stddev/10.0);
+	    printf("  Sync    latency: %7.1f μs (σ=%5.1f μs)\n",
+		   map.avg_iova_sync_100ns/10.0, map.iova_sync_stddev/10.0);
+	    printf("  Destroy latency: %7.1f μs (σ=%5.1f μs)\n",
+		   map.avg_iova_destroy_100ns/10.0, map.iova_destroy_stddev/10.0);
+
+	    double iova_total = map.avg_iova_alloc_100ns/10.0 + map.avg_iova_link_100ns/10.0 +
+				map.avg_iova_sync_100ns/10.0 + map.avg_iova_destroy_100ns/10.0;
+	    printf("  Total latency: %7.1f μs\n", iova_total);
+	    printf("\n");
+	}
+
+	/* Performance comparison for both modes */
+	if (map.has_iommu_dma && use_iova == 2) {
+	    double streaming_total = map.avg_map_100ns/10.0 + map.avg_unmap_100ns/10.0;
+	    double iova_total = map.avg_iova_alloc_100ns/10.0 + map.avg_iova_link_100ns/10.0 +
+				map.avg_iova_sync_100ns/10.0 + map.avg_iova_destroy_100ns/10.0;
+
+	    printf("PERFORMANCE COMPARISON:\n");
+	    printf("  Streaming DMA total: %7.1f μs\n", streaming_total);
+	    printf("  IOVA DMA total:      %7.1f μs\n", iova_total);
+
+	    if (streaming_total > 0) {
+		double performance_ratio = iova_total / streaming_total;
+		double performance_diff = ((iova_total - streaming_total) / streaming_total) * 100.0;
+
+		printf("  Performance ratio:   %7.2fx", performance_ratio);
+		if (performance_ratio < 1.0) {
+		    printf(" (IOVA is %.1f%% faster)\n", -performance_diff);
+		} else {
+		    printf(" (IOVA is %.1f%% slower)\n", performance_diff);
+		}
+
+		// Throughput analysis (operations per second)
+		double streaming_ops_per_sec = 1000000.0 / streaming_total;
+		double iova_ops_per_sec = 1000000.0 / iova_total;
+
+		printf("  Streaming throughput: %8.0f ops/sec\n", streaming_ops_per_sec);
+		printf("  IOVA throughput:      %8.0f ops/sec\n", iova_ops_per_sec);
+
+		/* Memory bandwidth estimate (if applicable) */
+		double buffer_kb = granule * 4.0;
+		double streaming_bw = (streaming_ops_per_sec * buffer_kb) / 1024.0; // MB/s
+		double iova_bw = (iova_ops_per_sec * buffer_kb) / 1024.0; // MB/s
+
+		printf("  Streaming bandwidth:  %8.1f MB/s\n", streaming_bw);
+		printf("  IOVA bandwidth:       %8.1f MB/s\n", iova_bw);
+	    }
+	    printf("\n");
+	}
+
+	/* IOVA breakdown analysis (for IOVA modes) */
+	if (map.has_iommu_dma && (use_iova == 1 || use_iova == 2)) {
+	    double iova_total = map.avg_iova_alloc_100ns/10.0 + map.avg_iova_link_100ns/10.0 +
+				map.avg_iova_sync_100ns/10.0 + map.avg_iova_destroy_100ns/10.0;
+
+	    if (iova_total > 0) {
+		printf("IOVA OPERATION BREAKDOWN:\n");
+		printf("  Alloc:   %5.1f%% (%6.1f μs)\n",
+		       (map.avg_iova_alloc_100ns/10.0 / iova_total) * 100.0, map.avg_iova_alloc_100ns/10.0);
+		printf("  Link:    %5.1f%% (%6.1f μs)\n",
+		       (map.avg_iova_link_100ns/10.0 / iova_total) * 100.0, map.avg_iova_link_100ns/10.0);
+		printf("  Sync:    %5.1f%% (%6.1f μs)\n",
+		       (map.avg_iova_sync_100ns/10.0 / iova_total) * 100.0, map.avg_iova_sync_100ns/10.0);
+		printf("  Destroy: %5.1f%% (%6.1f μs)\n",
+		       (map.avg_iova_destroy_100ns/10.0 / iova_total) * 100.0, map.avg_iova_destroy_100ns/10.0);
+		printf("\n");
+	    }
+	}
+
+	/* Recommendations based on results */
+	if (map.has_iommu_dma && use_iova == 2) {
+	    double streaming_total = map.avg_map_100ns/10.0 + map.avg_unmap_100ns/10.0;
+	    double iova_total = map.avg_iova_alloc_100ns/10.0 + map.avg_iova_link_100ns/10.0 +
+				map.avg_iova_sync_100ns/10.0 + map.avg_iova_destroy_100ns/10.0;
+
+	    printf("RECOMMENDATIONS:\n");
+	    if (iova_total < streaming_total * 0.9) {
+		printf("  ✓ IOVA API shows significant performance benefits\n");
+		printf("  ✓ Consider using IOVA API for this workload\n");
+	    } else if (iova_total < streaming_total * 1.1) {
+		printf("  ~ IOVA and Streaming APIs show similar performance\n");
+	    } else {
+		printf("  ⚠ Streaming API outperforms IOVA API for this benchmark\n");
+
+		/* Identify bottlenecks */
+		double max_iova_op = map.avg_iova_alloc_100ns/10.0;
+		const char* bottleneck = "alloc";
+
+		if (map.avg_iova_link_100ns/10.0 > max_iova_op) {
+		    max_iova_op = map.avg_iova_link_100ns/10.0;
+		    bottleneck = "link";
+		}
+		if (map.avg_iova_sync_100ns/10.0 > max_iova_op) {
+		    max_iova_op = map.avg_iova_sync_100ns/10.0;
+		    bottleneck = "sync";
+		}
+		if (map.avg_iova_destroy_100ns/10.0 > max_iova_op) {
+		    max_iova_op = map.avg_iova_destroy_100ns/10.0;
+		    bottleneck = "destroy";
+		}
+
+		printf("  ➤ Primary bottleneck appears to be IOVA %s operation\n", bottleneck);
+	    }
+	}
+
+	printf("=== End of Benchmark ===\n");
 
 	return 0;
 }
-- 
2.47.2


