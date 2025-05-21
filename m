Return-Path: <dmaengine+bounces-5240-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B85ABFF7B
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 00:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137C27AFEA8
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AA823A9B3;
	Wed, 21 May 2025 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/GSq8+v"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69662397BE;
	Wed, 21 May 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866448; cv=none; b=CYoocumgv3JU3jM48rw23fBlzMg/a8MAswpWXGbsV/MstIY47SgIFAKWsOxkAtmve+5SKzrc122RiBzoC88UNf7u4nBGHgPcQm6kzgYCJQ1grtlPKtMqykVyp75vWveaMIcUmxWKPhXZbORMU+PqgUmdC0pcLbPlfK37WIIMIz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866448; c=relaxed/simple;
	bh=nVc93vCmktqileE7Tf+CRDL/dCMWPXlgPpMpY4VQdy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC7AeJuYjBeViHjhY3jgMPfaR2EUaEzKlyp81FkWUYlTfFGVh2hKax9Mjuq7MfSkt478mLSIbO8olnPja4vC3395VOyJwVlSgzCrB/auUUcZPWOvOPZyanpbp7OWK7lqfn2Lz1WFvq46zNxGuqHgANX/VACeant1qKGwTWFkELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/GSq8+v; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747866447; x=1779402447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nVc93vCmktqileE7Tf+CRDL/dCMWPXlgPpMpY4VQdy4=;
  b=J/GSq8+v3XEiGVRtd9XEFg8oq30DNEgRxGuNx9XquFn8Nqk8wnQB3msG
   m6QP8TRzS2hxs3tgRvC4Xp92hc/7wVd+Vjk8j/g8I/ESwvUVScMUB1E/+
   hiRByy3fzTbilSCfaBgnbJ03+U6w8KTb4MzH0F0dbZD5Q4htZwta3mNoo
   KNha7RPqIge9xwA9OFPuodoi9uoWWjnYt5zwccXxrVG2J8qIQupxD6IdU
   qAdIA0y8SYLDe4HrV7/9zk4zYOJKhjMHQDpIQ2MQiCnYcg3VoR0EU7wUg
   uQClQKJf1JKHUp8Od62lb3KAOSDyBCT9v7bGtRID3NhfXOlI6+kMbIbR5
   w==;
X-CSE-ConnectionGUID: pGqhCYnXSRa+vw++I/4x5w==
X-CSE-MsgGUID: Ada3Dq9hRXS2JjygE07lVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="75265416"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="75265416"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 15:27:25 -0700
X-CSE-ConnectionGUID: V2uNsPfvRUCmkue3Xi77pg==
X-CSE-MsgGUID: Bk73LJyJRy+3ZwbOlKsz8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="177438999"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 21 May 2025 15:27:22 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHruB-000Ofw-1T;
	Wed, 21 May 2025 22:27:19 +0000
Date: Thu, 22 May 2025 06:26:33 +0800
From: kernel test robot <lkp@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>, vkoul@kernel.org,
	chenxiang66@hisilicon.com, m.szyprowski@samsung.com,
	robin.murphy@arm.com, leon@kernel.org, jgg@nvidia.com,
	alex.williamson@redhat.com, joel.granados@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH 3/6] dmatest: move printing to its own routine
Message-ID: <202505220605.kiB8N7DJ-lkp@intel.com>
References: <20250520223913.3407136-4-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520223913.3407136-4-mcgrof@kernel.org>

Hi Luis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.15-rc7 next-20250521]
[cannot apply to vkoul-dmaengine/next shuah-kselftest/next shuah-kselftest/fixes sysctl/sysctl-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luis-Chamberlain/fake-dma-add-fake-dma-engine-driver/20250521-064035
base:   linus/master
patch link:    https://lore.kernel.org/r/20250520223913.3407136-4-mcgrof%40kernel.org
patch subject: [PATCH 3/6] dmatest: move printing to its own routine
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20250522/202505220605.kiB8N7DJ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250522/202505220605.kiB8N7DJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505220605.kiB8N7DJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/dmatest.c: In function 'dmatest_func':
>> drivers/dma/dmatest.c:957:17: warning: variable 'start_time' set but not used [-Wunused-but-set-variable]
     957 |         ktime_t start_time, streaming_start;
         |                 ^~~~~~~~~~


vim +/start_time +957 drivers/dma/dmatest.c

   932	
   933	/*
   934	 * This function repeatedly tests DMA transfers of various lengths and
   935	 * offsets for a given operation type until it is told to exit by
   936	 * kthread_stop(). There may be multiple threads running this function
   937	 * in parallel for a single channel, and there may be multiple channels
   938	 * being tested in parallel.
   939	 *
   940	 * Before each test, the source and destination buffer is initialized
   941	 * with a known pattern. This pattern is different depending on
   942	 * whether it's in an area which is supposed to be copied or
   943	 * overwritten, and different in the source and destination buffers.
   944	 * So if the DMA engine doesn't copy exactly what we tell it to copy,
   945	 * we'll notice.
   946	 */
   947	static int dmatest_func(void *data)
   948	{
   949		struct dmatest_thread *thread = data;
   950		struct dmatest_info *info = thread->info;
   951		struct dmatest_params *params = &info->params;
   952		struct dma_chan *chan = thread->chan;
   953		unsigned int buf_size;
   954		u8 align;
   955		bool is_memset;
   956		unsigned int total_iterations = 0;
 > 957		ktime_t start_time, streaming_start;
   958		ktime_t filltime = 0;
   959		ktime_t comparetime = 0;
   960		int ret;
   961	
   962		set_freezable();
   963		smp_rmb();
   964		thread->pending = false;
   965	
   966		/* Initialize statistics */
   967		thread->streaming_tests = 0;
   968		thread->streaming_failures = 0;
   969		thread->streaming_total_len = 0;
   970		thread->streaming_runtime = 0;
   971	
   972		/* Setup test parameters and allocate buffers */
   973		ret = dmatest_setup_test(thread, &buf_size, &align, &is_memset);
   974		if (ret)
   975			goto err_thread_type;
   976	
   977		set_user_nice(current, 10);
   978	
   979		start_time = ktime_get();
   980		while (!(kthread_should_stop() ||
   981			(params->iterations && total_iterations >= params->iterations))) {
   982	
   983			/* Test streaming DMA path */
   984			streaming_start = ktime_get();
   985			ret = dmatest_do_dma_test(thread, buf_size, align, is_memset,
   986						  &thread->streaming_tests, &thread->streaming_failures,
   987						  &thread->streaming_total_len,
   988						  &filltime, &comparetime);
   989			thread->streaming_runtime = ktime_add(thread->streaming_runtime,
   990							    ktime_sub(ktime_get(), streaming_start));
   991			if (ret < 0)
   992				break;
   993	
   994			total_iterations++;
   995		}
   996	
   997		/* Subtract fill and compare time from both paths */
   998		thread->streaming_runtime = ktime_sub(thread->streaming_runtime,
   999						   ktime_divns(filltime, 2));
  1000		thread->streaming_runtime = ktime_sub(thread->streaming_runtime,
  1001						   ktime_divns(comparetime, 2));
  1002	
  1003		ret = 0;
  1004		dmatest_cleanup_test(thread);
  1005	
  1006	err_thread_type:
  1007		/* Print detailed statistics */
  1008		dmatest_print_detailed_stats(thread);
  1009	
  1010		/* terminate all transfers on specified channels */
  1011		if (ret || (thread->streaming_failures))
  1012			dmaengine_terminate_sync(chan);
  1013	
  1014		thread->done = true;
  1015		wake_up(&thread_wait);
  1016	
  1017		return ret;
  1018	}
  1019	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

