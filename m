Return-Path: <dmaengine+bounces-4049-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D49F9FBF
	for <lists+dmaengine@lfdr.de>; Sat, 21 Dec 2024 10:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAEF188935C
	for <lists+dmaengine@lfdr.de>; Sat, 21 Dec 2024 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6C31EC4CA;
	Sat, 21 Dec 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3e+PkJp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4E1DE2D7;
	Sat, 21 Dec 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734772761; cv=none; b=NU6w1WnUwfytCorjGaqwliVUs6EB+1Y/KNl9VPRqGJx894Y84f13fQZj6HR1NLXBkBpjB5SVvEAwQmuzIFv/iN56Avti7gtGnGQP0cGGG5y4ETJFmwh5ls3Qzf8m+jiEoKxj4YhE5C4mKOCT2MUPnyT+r8vL7S+xI8C3WMbGGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734772761; c=relaxed/simple;
	bh=K/gGzoIkY2j0sBPvvxT1OamLtEYly3fG3k78EOkLbxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvCI/6FSIzdMxdLh7G8mSu06zlpbLGUixmhfXN3I/CDzFCzKpCymFWuBQTb8UOIIcgMNzBsKmrgyBcQjv6ErqdWrVadET0oUI8VMaoqA+rERwcXH9eES90NBgHKvNKpBUtTzm8e/ebN6cnLB4sCaMSAMQn4hwyYPpk1Ren+KHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3e+PkJp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734772759; x=1766308759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K/gGzoIkY2j0sBPvvxT1OamLtEYly3fG3k78EOkLbxg=;
  b=l3e+PkJpRra4UicFrXmSnBc4ByDyecAYyN9FA64OON0axm7oUbLMmgnb
   y5FH11clv9DZrgy+jX7+jNMtf3vEcIIT/vvkwCvqqQZew4UJ8AQxxy2h3
   xN6f/5uEJLN5S4avOZOBFoSJm9yBqZh+/Q9w38MNgeUu55vVIpasZrzlq
   bC2OZjw+1W3EnVT/hOz79rGCI85dlwFibkSu5FbZqRparrNoaPkVseS9G
   zuKQchm+IK4sATufsRHg8K5oPlYGzxN5kbIzERsxLWPNCFEid2L1LKbST
   FGw9gdCTqrfNn0d7rK9FMyYi2gvVyHc9nAQIz+8gmEwX3H6+ZySVmDc7b
   A==;
X-CSE-ConnectionGUID: u9ReohokRPyJMB+E8btmUw==
X-CSE-MsgGUID: QRbETUm/RfSwGj1P0Hy0jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="38997320"
X-IronPort-AV: E=Sophos;i="6.12,253,1728975600"; 
   d="scan'208";a="38997320"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 01:19:19 -0800
X-CSE-ConnectionGUID: 7jwalMGLSc2vUaJ4bxcTfg==
X-CSE-MsgGUID: A/b7KilcRHeyeaDNEV5z2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99588308"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 21 Dec 2024 01:19:18 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOvdj-00026w-0n;
	Sat, 21 Dec 2024 09:19:15 +0000
Date: Sat, 21 Dec 2024 17:19:04 +0800
From: kernel test robot <lkp@intel.com>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH next] dma: Add devm_dma_request_chan()
Message-ID: <202412211953.UwS2Qw11-lkp@intel.com>
References: <20241220131350.544009-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220131350.544009-1-csokas.bence@prolan.hu>

Hi Bence,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20241220]

url:    https://github.com/intel-lab-lkp/linux/commits/Bence-Cs-k-s/dma-Add-devm_dma_request_chan/20241220-211523
base:   next-20241220
patch link:    https://lore.kernel.org/r/20241220131350.544009-1-csokas.bence%40prolan.hu
patch subject: [PATCH next] dma: Add devm_dma_request_chan()
config: x86_64-buildonly-randconfig-002-20241221 (https://download.01.org/0day-ci/archive/20241221/202412211953.UwS2Qw11-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241221/202412211953.UwS2Qw11-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412211953.UwS2Qw11-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/dmaengine.c:944:18: warning: no previous prototype for 'devm_dma_request_chan' [-Wmissing-prototypes]
     944 | struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
         |                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/dma/dmaengine.c: In function 'devm_dma_request_chan':
>> drivers/dma/dmaengine.c:953:32: warning: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
     953 |                 return PTR_ERR(ret);
         |                                ^~~
         |                                |
         |                                int
   In file included from arch/x86/include/asm/processor.h:36,
                    from include/linux/sched.h:13,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/dma/dmaengine.c:34:
   include/linux/err.h:52:61: note: expected 'const void *' but argument is of type 'int'
      52 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                 ~~~~~~~~~~~~^~~
>> drivers/dma/dmaengine.c:953:24: warning: returning 'long int' from a function with return type 'struct dma_chan *' makes pointer from integer without a cast [-Wint-conversion]
     953 |                 return PTR_ERR(ret);
         |                        ^~~~~~~~~~~~


vim +/devm_dma_request_chan +944 drivers/dma/dmaengine.c

   933	
   934	/**
   935	 * devm_dma_request_chan - try to allocate an exclusive slave channel
   936	 * @dev:	pointer to client device structure
   937	 * @name:	slave channel name
   938	 *
   939	 * Returns pointer to appropriate DMA channel on success or an error pointer.
   940	 *
   941	 * The operation is managed and will be undone on driver detach.
   942	 */
   943	
 > 944	struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
   945	{
   946		struct dma_chan *chan = dma_request_chan(dev, name);
   947		int ret = 0;
   948	
   949		if (!IS_ERR(chan))
   950			ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
   951	
   952		if (ret)
 > 953			return PTR_ERR(ret);
   954	
   955		return chan;
   956	}
   957	EXPORT_SYMBOL_GPL(devm_dma_request_chan);
   958	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

