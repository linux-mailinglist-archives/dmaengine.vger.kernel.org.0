Return-Path: <dmaengine+bounces-4051-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5899FA00B
	for <lists+dmaengine@lfdr.de>; Sat, 21 Dec 2024 11:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F286A1686C5
	for <lists+dmaengine@lfdr.de>; Sat, 21 Dec 2024 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5F1F0E55;
	Sat, 21 Dec 2024 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSVpeKHs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995C1EC4F7;
	Sat, 21 Dec 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734775285; cv=none; b=VIwpb++bP5AhP2Sk303Rh1btxmO7xcQQxI+CPObZd5ZfBAbJ0pqg5ZWsiKvbJSda9qe/dBxEi9B22w0BOqcqvdjnqO+LWYhFh5IPhIHxuMXcD9pKl8rYaYqY75aC4HiraCcsKOfJ9E9P3yMG3hpIHTXfDp+Gz1v6JfDutA5ACHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734775285; c=relaxed/simple;
	bh=QfdImvP58EeCPvKEQ5eIyWLi1kmX2PnIg6c0NV/k4kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1RJ0i/6tw5q3rVgc3O3PuvK12Dg9irXTraWdh8rtbTg0uqKpbjGahxC3GNqoAFB7mxk8jURdbndd8ZoVhCrtJ5ivk/04gaQi9xFq79ERZBC+bBC9fHhNn5PtumLCZVDkX+DSPJiTH1bWkpcWquM0hM7y86hwpBvfT57jX2nvfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSVpeKHs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734775284; x=1766311284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QfdImvP58EeCPvKEQ5eIyWLi1kmX2PnIg6c0NV/k4kc=;
  b=DSVpeKHsMG81kqRN9OGKZ3D7aRrHlw/Dt/4lqzdRodiGrgjQ1UJcsXzf
   fCzGaqUIoPulcroWjcNZtFI+VA/Psd0wxg+GIwzfIX9h7XVRTTLSZdtEB
   PRpe4pcUfS+F+bkghw+ZiGV1YRCA3Vs4coCZXOuz7kD+GVcLLsFwz1H8N
   ES/rxDuHAQPwbvUtWpk5u0ShrYLwcHbKOYQOuL8pRuI+CcMY+zintJBR3
   soBKV6nk8tiISgbE4Kk0QSSVuxtiD/5IbXSU4huU3lqWDGdtXVlXnvcoV
   dhOtXkOuVHQmnvn5ddhsd0+N4mdwrlxWUGXiDEDqfhKgZgmFWi3oJYLHS
   A==;
X-CSE-ConnectionGUID: qKE6WVD0RmygMMurIDH98w==
X-CSE-MsgGUID: Jn8Ut7nLRjeUnota5sTBWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="45808219"
X-IronPort-AV: E=Sophos;i="6.12,253,1728975600"; 
   d="scan'208";a="45808219"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 02:01:24 -0800
X-CSE-ConnectionGUID: 2HI1Kg3BRIiDFPg7U5tMEA==
X-CSE-MsgGUID: HrB3sxnZQZe6lo7KEDx5Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="103810590"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Dec 2024 02:01:21 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOwIQ-00027x-39;
	Sat, 21 Dec 2024 10:01:18 +0000
Date: Sat, 21 Dec 2024 18:01:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH next] dma: Add devm_dma_request_chan()
Message-ID: <202412211736.wXS6zm9z-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20241220]

url:    https://github.com/intel-lab-lkp/linux/commits/Bence-Cs-k-s/dma-Add-devm_dma_request_chan/20241220-211523
base:   next-20241220
patch link:    https://lore.kernel.org/r/20241220131350.544009-1-csokas.bence%40prolan.hu
patch subject: [PATCH next] dma: Add devm_dma_request_chan()
config: i386-buildonly-randconfig-004-20241221 (https://download.01.org/0day-ci/archive/20241221/202412211736.wXS6zm9z-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241221/202412211736.wXS6zm9z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412211736.wXS6zm9z-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/dma/dmaengine.c:953:18: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'const void *' [-Wint-conversion]
     953 |                 return PTR_ERR(ret);
         |                                ^~~
   include/linux/err.h:52:61: note: passing argument to parameter 'ptr' here
      52 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                             ^
>> drivers/dma/dmaengine.c:953:10: error: incompatible integer to pointer conversion returning 'long' from a function with result type 'struct dma_chan *' [-Wint-conversion]
     953 |                 return PTR_ERR(ret);
         |                        ^~~~~~~~~~~~
>> drivers/dma/dmaengine.c:944:18: warning: no previous prototype for function 'devm_dma_request_chan' [-Wmissing-prototypes]
     944 | struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
         |                  ^
   drivers/dma/dmaengine.c:944:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     944 | struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
         | ^
         | static 
   1 warning and 2 errors generated.


vim +953 drivers/dma/dmaengine.c

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

