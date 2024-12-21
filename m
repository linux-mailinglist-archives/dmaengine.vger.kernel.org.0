Return-Path: <dmaengine+bounces-4050-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2099FA009
	for <lists+dmaengine@lfdr.de>; Sat, 21 Dec 2024 11:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A6A188A23D
	for <lists+dmaengine@lfdr.de>; Sat, 21 Dec 2024 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0200D1EC4E5;
	Sat, 21 Dec 2024 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqpcWqWS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0831DF269;
	Sat, 21 Dec 2024 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734775284; cv=none; b=C+qhhxOWoQ4ezwNg+4EeB4lbqLFsBXpCf0Nu7eaMB9qaE8CVFegxkFk6jy0ADD/xqiq6piMAPE6Myisne5snhwIYCari0PxGytgN9Ji2J/v2U02tkkX/gdM+FEJvm+ZmxW7JwFqVcSOQbdbFsZ548zhqxnf82A6HjkoZWaRF+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734775284; c=relaxed/simple;
	bh=6yQ+wGfGspqtxH/JHNxABxToUM+Ojl3svROxFQpvuf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvrqxtGpVnt9OVKNtXjEvBG/8BXAY5WdXRmlKubPrjs/Bt7d2SSaAGP+bcn5LLh0Y57cIsTeuJkmy0Ix9Uobk/NhRXuj/QZAtGKMOy3nJ2GLqIrMwDnS2gRASlcI8bYWibnjtrR1PTy2uIVyjUJhdMap/PLBysUKZvJE0+VNP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqpcWqWS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734775284; x=1766311284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6yQ+wGfGspqtxH/JHNxABxToUM+Ojl3svROxFQpvuf0=;
  b=lqpcWqWScwcIC2ubtY9/NHS/vRg57kFHsfMAeFCnfzX5hnQn1GNhMINX
   wTChhpeolV0HMUO56DOUAoQPbyUbFs0iV6ee57LVitNaeDD+rFBLn5ZbI
   WD0a5D6DnCZ8OxdOyJh4n+oj+7yKZOpf1Q4VmUvMPfFfuOgFVI4sl6W9O
   8oxAVdrGadiOBfKnQA1AV5SN8VqT9iVGakYRbOaGXJMej192aQBNCf0e8
   scLUnrAL8fGLHl6i5CEzebzYrcVbT2c5j5UR4lSQFQ/i+vledraxy1qFQ
   0AwSkPrHRxBMUxoH8dXm8EH+44Co+KJKghZ3EAt2IuzyICsZXLx+glJWG
   g==;
X-CSE-ConnectionGUID: Of+n6vclQaea84tuqX90Cw==
X-CSE-MsgGUID: cqTkDy/oRQmz+QzRvx/Huw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35460277"
X-IronPort-AV: E=Sophos;i="6.12,253,1728975600"; 
   d="scan'208";a="35460277"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 02:01:23 -0800
X-CSE-ConnectionGUID: d4HMwCv6TEK3EmWBJSPDoA==
X-CSE-MsgGUID: /HIAoLcwQmW0xAmH6+x/eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,253,1728975600"; 
   d="scan'208";a="129562413"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Dec 2024 02:01:21 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOwIQ-00027v-33;
	Sat, 21 Dec 2024 10:01:18 +0000
Date: Sat, 21 Dec 2024 18:01:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH next] dma: Add devm_dma_request_chan()
Message-ID: <202412211754.Jh1oIu6A-lkp@intel.com>
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
config: arm-randconfig-002-20241221 (https://download.01.org/0day-ci/archive/20241221/202412211754.Jh1oIu6A-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241221/202412211754.Jh1oIu6A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412211754.Jh1oIu6A-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/dmaengine.c:944:18: warning: no previous prototype for 'devm_dma_request_chan' [-Wmissing-prototypes]
     944 | struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
         |                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/dma/dmaengine.c: In function 'devm_dma_request_chan':
>> drivers/dma/dmaengine.c:953:32: error: passing argument 1 of 'PTR_ERR' makes pointer from integer without a cast [-Wint-conversion]
     953 |                 return PTR_ERR(ret);
         |                                ^~~
         |                                |
         |                                int
   In file included from include/linux/string.h:10,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/sched.h:2182,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/dma/dmaengine.c:34:
   include/linux/err.h:52:61: note: expected 'const void *' but argument is of type 'int'
      52 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                                 ~~~~~~~~~~~~^~~
>> drivers/dma/dmaengine.c:953:24: error: returning 'long int' from a function with return type 'struct dma_chan *' makes pointer from integer without a cast [-Wint-conversion]
     953 |                 return PTR_ERR(ret);
         |                        ^~~~~~~~~~~~


vim +/PTR_ERR +953 drivers/dma/dmaengine.c

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
   944	struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
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

