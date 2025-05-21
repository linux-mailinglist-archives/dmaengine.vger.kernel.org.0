Return-Path: <dmaengine+bounces-5232-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998BABF38F
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 13:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BEB1BC36CA
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E645264A70;
	Wed, 21 May 2025 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWTjqRqC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F2256C9F;
	Wed, 21 May 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828740; cv=none; b=dTCiD0HDG48Adni4wZJ1oCLIaqOToyyH8txurQCxzvhZP+zD9wRTX+9W48fCCd42qiWDj3UP4Bg/eHI9I35pRsjt25jy3g246GjeojMpr4R/swZ535i6uMlLZnUz2nEV2Ki6dzE4hDFHUWNYrSTC2KxGuM0qZXPYntsEnTYzKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828740; c=relaxed/simple;
	bh=H1VBDSIJ2HMkJrDKIgh+iSVkesoM3W4lbNhILfvcvMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHwFTDjtIQj7fgwPA8V2zsKh+WFI16hp0wzp36bNlNXF31DkdV0CclI3Lly1F4tCnHsTV+tKj9eoXoTRFdPXv9IxSQUl0xY8IvcjHyPMQiaTYdTN6NL6yCoU5EBtS5QZo9J0h9AIhsZ1qNj83kHm/ZtHMTiKbDcpBt4UlIWsUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWTjqRqC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747828738; x=1779364738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H1VBDSIJ2HMkJrDKIgh+iSVkesoM3W4lbNhILfvcvMY=;
  b=IWTjqRqChEKagejg42xjsFKkT+j5Oc6n12s01HtRUYUsUSLNN9H2VGZZ
   vayvRpBmGYaGYTKC06Ygn3KGF42dKOyoDnA+iNr/GdvAWEvGn8IO51nSD
   rmDfz/i+iMXKCqX1a7eBRfb6TkqDFiizLyMaz6N7JKsdn/Vwtj0DAI+XJ
   PybdrsvqdaPrH0a7QUztY2oIAEJO4r1msFvINEvSet5kzEEGoZSHzV52m
   rIYo0SBDCDCEj9kh8VcZGhbYp4kW/dVO4CNKXMX3ov55oxaUACkvP5FfG
   eWwW8qpCaMX568t+UZlOXya59x5GOuQXl8vyGJ0bMIHd1qyr6w6Yu2Ykw
   w==;
X-CSE-ConnectionGUID: bdHIeUyjQnG5mZREP+DiNw==
X-CSE-MsgGUID: dWIOjG87Q1aLjMgi7iBsTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49676845"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49676845"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 04:58:57 -0700
X-CSE-ConnectionGUID: UyTnJ1iNSvyVOiQTzKqTQw==
X-CSE-MsgGUID: qJGJTHuZRWW2G7aWSZdiEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140546167"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 21 May 2025 04:58:54 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHi5z-000ODQ-29;
	Wed, 21 May 2025 11:58:51 +0000
Date: Wed, 21 May 2025 19:58:22 +0800
From: kernel test robot <lkp@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>, vkoul@kernel.org,
	chenxiang66@hisilicon.com, m.szyprowski@samsung.com,
	robin.murphy@arm.com, leon@kernel.org, jgg@nvidia.com,
	alex.williamson@redhat.com, joel.granados@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	mcgrof@kernel.org
Subject: Re: [PATCH 6/6] dma-mapping: benchmark: add IOVA support
Message-ID: <202505211909.CzQtqtu8-lkp@intel.com>
References: <20250520223913.3407136-7-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520223913.3407136-7-mcgrof@kernel.org>

Hi Luis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.15-rc7 next-20250516]
[cannot apply to vkoul-dmaengine/next shuah-kselftest/next shuah-kselftest/fixes sysctl/sysctl-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luis-Chamberlain/fake-dma-add-fake-dma-engine-driver/20250521-064035
base:   linus/master
patch link:    https://lore.kernel.org/r/20250520223913.3407136-7-mcgrof%40kernel.org
patch subject: [PATCH 6/6] dma-mapping: benchmark: add IOVA support
config: hexagon-randconfig-002-20250521 (https://download.01.org/0day-ci/archive/20250521/202505211909.CzQtqtu8-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250521/202505211909.CzQtqtu8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505211909.CzQtqtu8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/dma/map_benchmark.c:60:25: error: variable has incomplete type 'struct dma_iova_state'
      60 |                 struct dma_iova_state iova_state;
         |                                       ^
   kernel/dma/map_benchmark.c:60:10: note: forward declaration of 'struct dma_iova_state'
      60 |                 struct dma_iova_state iova_state;
         |                        ^
   kernel/dma/map_benchmark.c:76:8: error: call to undeclared function 'dma_iova_try_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      76 |                 if (!dma_iova_try_alloc(map->dev, &iova_state, phys, size)) {
         |                      ^
   kernel/dma/map_benchmark.c:88:9: error: call to undeclared function 'dma_iova_link'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      88 |                 ret = dma_iova_link(map->dev, &iova_state, phys, 0, size, dir, 0);
         |                       ^
   kernel/dma/map_benchmark.c:94:4: error: call to undeclared function 'dma_iova_free'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      94 |                         dma_iova_free(map->dev, &iova_state);
         |                         ^
   kernel/dma/map_benchmark.c:101:9: error: call to undeclared function 'dma_iova_sync'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     101 |                 ret = dma_iova_sync(map->dev, &iova_state, 0, size);
         |                       ^
   kernel/dma/map_benchmark.c:107:4: error: call to undeclared function 'dma_iova_unlink'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     107 |                         dma_iova_unlink(map->dev, &iova_state, 0, size, dir, 0);
         |                         ^
   kernel/dma/map_benchmark.c:108:4: error: call to undeclared function 'dma_iova_free'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     108 |                         dma_iova_free(map->dev, &iova_state);
         |                         ^
   kernel/dma/map_benchmark.c:118:3: error: call to undeclared function 'dma_iova_destroy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     118 |                 dma_iova_destroy(map->dev, &iova_state, size, dir, 0);
         |                 ^
>> kernel/dma/map_benchmark.c:340:23: warning: variable 'iova_threads' set but not used [-Wunused-but-set-variable]
     340 |         int regular_threads, iova_threads;
         |                              ^
   1 warning and 8 errors generated.


vim +/iova_threads +340 kernel/dma/map_benchmark.c

   334	
   335	static int do_streaming_iova_benchmark(struct map_benchmark_data *map)
   336	{
   337		struct task_struct **tsk;
   338		int threads = map->bparam.threads;
   339		int node = map->bparam.node;
 > 340		int regular_threads, iova_threads;
   341		u64 loops, iova_loops;
   342		int ret = 0;
   343		int i;
   344	
   345		tsk = kmalloc_array(threads * 2, sizeof(*tsk), GFP_KERNEL);
   346		if (!tsk)
   347			return -ENOMEM;
   348	
   349		get_device(map->dev);
   350	
   351		/* Split threads between regular and IOVA testing */
   352		regular_threads = threads / 2;
   353		iova_threads = threads - regular_threads;
   354	
   355		/* Create streaming DMA threads */
   356		for (i = 0; i < regular_threads; i++) {
   357			tsk[i] = kthread_create_on_node(benchmark_thread_streaming, map,
   358					node, "dma-streaming-benchmark/%d", i);
   359			if (IS_ERR(tsk[i])) {
   360				pr_err("create dma_map thread failed\n");
   361				ret = PTR_ERR(tsk[i]);
   362				while (--i >= 0)
   363					kthread_stop(tsk[i]);
   364				goto out;
   365			}
   366	
   367			if (node != NUMA_NO_NODE)
   368				kthread_bind_mask(tsk[i], cpumask_of_node(node));
   369		}
   370	
   371		/* Create IOVA DMA threads */
   372		for (i = regular_threads; i < threads; i++) {
   373			tsk[i] = kthread_create_on_node(benchmark_thread_iova, map,
   374					node, "dma-iova-benchmark/%d", i - regular_threads);
   375			if (IS_ERR(tsk[i])) {
   376				pr_err("create dma_iova thread failed\n");
   377				ret = PTR_ERR(tsk[i]);
   378				while (--i >= 0)
   379					kthread_stop(tsk[i]);
   380				goto out;
   381			}
   382	
   383			if (node != NUMA_NO_NODE)
   384				kthread_bind_mask(tsk[i], cpumask_of_node(node));
   385		}
   386	
   387		/* Clear previous benchmark values */
   388		atomic64_set(&map->sum_map_100ns, 0);
   389		atomic64_set(&map->sum_unmap_100ns, 0);
   390		atomic64_set(&map->sum_sq_map, 0);
   391		atomic64_set(&map->sum_sq_unmap, 0);
   392		atomic64_set(&map->loops, 0);
   393	
   394		atomic64_set(&map->sum_iova_alloc_100ns, 0);
   395		atomic64_set(&map->sum_iova_link_100ns, 0);
   396		atomic64_set(&map->sum_iova_sync_100ns, 0);
   397		atomic64_set(&map->sum_iova_destroy_100ns, 0);
   398		atomic64_set(&map->sum_sq_iova_alloc, 0);
   399		atomic64_set(&map->sum_sq_iova_link, 0);
   400		atomic64_set(&map->sum_sq_iova_sync, 0);
   401		atomic64_set(&map->sum_sq_iova_destroy, 0);
   402		atomic64_set(&map->iova_loops, 0);
   403	
   404		/* Start all threads */
   405		for (i = 0; i < threads; i++) {
   406			get_task_struct(tsk[i]);
   407			wake_up_process(tsk[i]);
   408		}
   409	
   410		msleep_interruptible(map->bparam.seconds * 1000);
   411	
   412		/* Stop all threads */
   413		for (i = 0; i < threads; i++) {
   414			int kthread_ret = kthread_stop_put(tsk[i]);
   415			if (kthread_ret)
   416				ret = kthread_ret;
   417		}
   418	
   419		if (ret)
   420			goto out;
   421	
   422		/* Calculate streaming DMA statistics */
   423		loops = atomic64_read(&map->loops);
   424		if (loops > 0) {
   425			u64 map_variance, unmap_variance;
   426			u64 sum_map = atomic64_read(&map->sum_map_100ns);
   427			u64 sum_unmap = atomic64_read(&map->sum_unmap_100ns);
   428			u64 sum_sq_map = atomic64_read(&map->sum_sq_map);
   429			u64 sum_sq_unmap = atomic64_read(&map->sum_sq_unmap);
   430	
   431			map->bparam.avg_map_100ns = div64_u64(sum_map, loops);
   432			map->bparam.avg_unmap_100ns = div64_u64(sum_unmap, loops);
   433	
   434			map_variance = div64_u64(sum_sq_map, loops) -
   435					map->bparam.avg_map_100ns * map->bparam.avg_map_100ns;
   436			unmap_variance = div64_u64(sum_sq_unmap, loops) -
   437					map->bparam.avg_unmap_100ns * map->bparam.avg_unmap_100ns;
   438			map->bparam.map_stddev = int_sqrt64(map_variance);
   439			map->bparam.unmap_stddev = int_sqrt64(unmap_variance);
   440		}
   441	
   442		/* Calculate IOVA statistics */
   443		iova_loops = atomic64_read(&map->iova_loops);
   444		if (iova_loops > 0) {
   445			u64 alloc_variance, link_variance, sync_variance, destroy_variance;
   446			u64 sum_alloc = atomic64_read(&map->sum_iova_alloc_100ns);
   447			u64 sum_link = atomic64_read(&map->sum_iova_link_100ns);
   448			u64 sum_sync = atomic64_read(&map->sum_iova_sync_100ns);
   449			u64 sum_destroy = atomic64_read(&map->sum_iova_destroy_100ns);
   450	
   451			map->bparam.avg_iova_alloc_100ns = div64_u64(sum_alloc, iova_loops);
   452			map->bparam.avg_iova_link_100ns = div64_u64(sum_link, iova_loops);
   453			map->bparam.avg_iova_sync_100ns = div64_u64(sum_sync, iova_loops);
   454			map->bparam.avg_iova_destroy_100ns = div64_u64(sum_destroy, iova_loops);
   455	
   456			alloc_variance = div64_u64(atomic64_read(&map->sum_sq_iova_alloc), iova_loops) -
   457					map->bparam.avg_iova_alloc_100ns * map->bparam.avg_iova_alloc_100ns;
   458			link_variance = div64_u64(atomic64_read(&map->sum_sq_iova_link), iova_loops) -
   459					map->bparam.avg_iova_link_100ns * map->bparam.avg_iova_link_100ns;
   460			sync_variance = div64_u64(atomic64_read(&map->sum_sq_iova_sync), iova_loops) -
   461					map->bparam.avg_iova_sync_100ns * map->bparam.avg_iova_sync_100ns;
   462			destroy_variance = div64_u64(atomic64_read(&map->sum_sq_iova_destroy), iova_loops) -
   463					map->bparam.avg_iova_destroy_100ns * map->bparam.avg_iova_destroy_100ns;
   464	
   465			map->bparam.iova_alloc_stddev = int_sqrt64(alloc_variance);
   466			map->bparam.iova_link_stddev = int_sqrt64(link_variance);
   467			map->bparam.iova_sync_stddev = int_sqrt64(sync_variance);
   468			map->bparam.iova_destroy_stddev = int_sqrt64(destroy_variance);
   469		}
   470	
   471	out:
   472		put_device(map->dev);
   473		kfree(tsk);
   474		return ret;
   475	}
   476	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

