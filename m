Return-Path: <dmaengine+bounces-5236-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63833ABFADD
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 18:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386271648FB
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B621A5B86;
	Wed, 21 May 2025 16:08:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3010C17C21B;
	Wed, 21 May 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843696; cv=none; b=shx/F3J3w//UYTfluH4zB/Iq+RotZCGUOGucREasUIBbT+iQIkqmbXF1MH4iD9EIEEESLvlFtPHn4+C7VDTcwfwDl/gP+6F5XzDEKDIaA/8LY27BjOP6ZQVrkmEkbH2tXAe6fBkHicp/4wVEB1r2oidZXhWbg7rCFOhJjIEogs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843696; c=relaxed/simple;
	bh=r+PsOW+3c8fAoEJM7Hiht9PiePv9tWx8sLhz5yI7E0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeIYux1/Cunt+9QScbGWr2YAHt9Vr7pdOgsKYc+Apke401dF9Gq3egCCw7WBcyhRqHtkmuJIE/8LVc4POerzpt4JcuR2kYwRgnORZ5RnVnq40aqIa2huhZkfl1fA4yrLWv6GGgwEklbbbAD5sbGFwiZ1Gv+CwH53htN7I007phE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 883A71515;
	Wed, 21 May 2025 09:07:58 -0700 (PDT)
Received: from [10.57.64.80] (unknown [10.57.64.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D6A43F6A8;
	Wed, 21 May 2025 09:08:10 -0700 (PDT)
Message-ID: <a1e9c606-0255-4e3b-87d3-dadc3b819622@arm.com>
Date: Wed, 21 May 2025 17:08:08 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] dma-mapping: benchmark: add IOVA support
To: Luis Chamberlain <mcgrof@kernel.org>, vkoul@kernel.org,
 chenxiang66@hisilicon.com, m.szyprowski@samsung.com, leon@kernel.org,
 jgg@nvidia.com, alex.williamson@redhat.com, joel.granados@kernel.org
Cc: iommu@lists.linux.dev, dmaengine@vger.kernel.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20250520223913.3407136-1-mcgrof@kernel.org>
 <20250520223913.3407136-7-mcgrof@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250520223913.3407136-7-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-05-20 11:39 pm, Luis Chamberlain wrote:
> Add support to use the IOVA DMA API, and allow comparing and contrasting
> to the streaming DMA API. Since the IOVA is intended to be an enhancement
> when using an IOMMU which supports DMA over it only allow the IOVA to be
> used proactively for devices which have this support, that is when
> use_dma_iommu() is true. We don't try a fallback as the goal is clear,
> only to use the IOVA when intended.
> 
> Example output, using intel-iommu on qemu against a random number
> generator device, this output is completely artificial as its a VM
> and its using more threads than the guest even has cores, the goal was
> to at least visualize some numerical output on both paths:
> 
> ./tools/testing/selftests/dma/dma_map_benchmark -t 24 -i 2
> === DMA Mapping Benchmark Results ===
> Configuration: threads:24 seconds:20 node:-1 dir:BIDIRECTIONAL granule:1 iova:2
> Buffer size: 1 pages (4 KB)
> 
> STREAMING DMA RESULTS:
>    Map   latency:    12.3 μs (σ=257.9 μs)
>    Unmap latency:     3.7 μs (σ=142.5 μs)
>    Total latency:    16.0 μs
> 
> IOVA DMA RESULTS:
>    Alloc   latency:     0.1 μs (σ= 31.1 μs)
>    Link    latency:     2.5 μs (σ=116.9 μs)
>    Sync    latency:     9.6 μs (σ=227.8 μs)
>    Destroy latency:     3.6 μs (σ=141.2 μs)
>    Total latency:    15.8 μs
> 
> PERFORMANCE COMPARISON:
>    Streaming DMA total:    16.0 μs
>    IOVA DMA total:         15.8 μs
>    Performance ratio:      0.99x (IOVA is 1.3% faster)
>    Streaming throughput:    62500 ops/sec
>    IOVA throughput:         63291 ops/sec
>    Streaming bandwidth:     244.1 MB/s
>    IOVA bandwidth:          247.2 MB/s
> 
> IOVA OPERATION BREAKDOWN:
>    Alloc:     0.6% (   0.1 μs)
>    Link:     15.8% (   2.5 μs)
>    Sync:     60.8% (   9.6 μs)
>    Destroy:  22.8% (   3.6 μs)
> 
> RECOMMENDATIONS:
>    ~ IOVA and Streaming APIs show similar performance
> === End of Benchmark ===
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   include/linux/map_benchmark.h                 |  11 +
>   kernel/dma/Kconfig                            |   4 +-
>   kernel/dma/map_benchmark.c                    | 417 +++++++++++++++++-
>   .../testing/selftests/dma/dma_map_benchmark.c | 145 +++++-
>   4 files changed, 562 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
> index 62674c83bde4..da7c9e3ddf21 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -7,6 +7,7 @@
>   #define _KERNEL_DMA_BENCHMARK_H
>   
>   #define DMA_MAP_BENCHMARK       _IOWR('d', 1, struct map_benchmark)
> +#define DMA_MAP_BENCHMARK_IOVA	_IOWR('d', 2, struct map_benchmark)
>   #define DMA_MAP_MAX_THREADS     1024
>   #define DMA_MAP_MAX_SECONDS     300
>   #define DMA_MAP_MAX_TRANS_DELAY (10 * NSEC_PER_MSEC)
> @@ -27,5 +28,15 @@ struct map_benchmark {
>   	__u32 dma_dir; /* DMA data direction */
>   	__u32 dma_trans_ns; /* time for DMA transmission in ns */
>   	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
> +	__u32 has_iommu_dma;

Why would userspace care about this? Either they asked for a streaming 
benchmark and it's irrelevant, or they asked for an IOVA benchmark, 
which either succeeded, or failed and this is ignored anyway.

> +	__u64 avg_iova_alloc_100ns;
> +	__u64 avg_iova_link_100ns;
> +	__u64 avg_iova_sync_100ns;
> +	__u64 avg_iova_destroy_100ns;
> +	__u64 iova_alloc_stddev;
> +	__u64 iova_link_stddev;
> +	__u64 iova_sync_stddev;
> +	__u64 iova_destroy_stddev;
> +	__u32 use_iova; /* 0=regular, 1=IOVA, 2=both */

Conversely, why should the kernel have to care about this? If userspace 
wants both benchmarks, they can just run both benchmarks, with whatever 
number of threads for each they fancy. No need to have all that 
complexity kernel-side. If there's a valid desire for running multiple 
different benchmarks *simultaneously* then we should support that in 
general (I can imagine it being potentially interesting to thrash the 
IOVA allocator with several different sizes at once, for example.)

That way, I'd also be inclined to give the new ioctl its own separate 
structure for IOVA results, and avoid impacting the existing ABI.

>   };
>   #endif /* _KERNEL_DMA_BENCHMARK_H */
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 31cfdb6b4bc3..e2d5784f46eb 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -261,10 +261,10 @@ config DMA_API_DEBUG
>   	  If unsure, say N.
>   
>   config DMA_MAP_BENCHMARK
> -	bool "Enable benchmarking of streaming DMA mapping"
> +	bool "Enable benchmarking of streaming and IOVA DMA mapping"
>   	depends on DEBUG_FS
>   	help
>   	  Provides /sys/kernel/debug/dma_map_benchmark that helps with testing
> -	  performance of dma_(un)map_page.
> +	  performance of the streaming DMA dma_(un)map_page and IOVA API.
>   
>   	  See tools/testing/selftests/dma/dma_map_benchmark.c
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index b54345a757cb..3ae34433420b 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -18,6 +18,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/timekeeping.h>
> +#include <linux/iommu-dma.h>

Nit: these are currently in nice alphabetical order.

>   struct map_benchmark_data {
>   	struct map_benchmark bparam;
[...]
> @@ -112,7 +231,250 @@ static int map_benchmark_thread(void *data)
>   	return ret;
>   }
>   
> -static int do_map_benchmark(struct map_benchmark_data *map)
> +static int do_iova_benchmark(struct map_benchmark_data *map)
> +{
> +	struct task_struct **tsk;
> +	int threads = map->bparam.threads;
> +	int node = map->bparam.node;
> +	u64 iova_loops;
> +	int ret = 0;
> +	int i;
> +
> +	tsk = kmalloc_array(threads, sizeof(*tsk), GFP_KERNEL);
> +	if (!tsk)
> +		return -ENOMEM;
> +
> +	get_device(map->dev);
> +
> +	/* Create IOVA threads only */
> +	for (i = 0; i < threads; i++) {
> +		tsk[i] = kthread_create_on_node(benchmark_thread_iova, map,
> +				node, "dma-iova-benchmark/%d", i);
> +		if (IS_ERR(tsk[i])) {
> +			pr_err("create dma_iova thread failed\n");
> +			ret = PTR_ERR(tsk[i]);
> +			while (--i >= 0)
> +				kthread_stop(tsk[i]);
> +			goto out;
> +		}
> +
> +		if (node != NUMA_NO_NODE)
> +			kthread_bind_mask(tsk[i], cpumask_of_node(node));
> +	}

Duplicating all the thread-wrangling code seems needlessly horrible - 
surely it's easy enough to factor out the stats initialisation and final 
calculation, along with the thread function itself. Perhaps as callbacks 
in the map_benchmark_data?

Similarly, each "thread function" itself only only actually needs to 
consist of the respective "while (!kthread_should_stop())" loop - the 
rest of map_benchmark_thread() could still be used as a common harness 
to avoid duplicating the buffer management code as well.

Thanks,
Robin.

