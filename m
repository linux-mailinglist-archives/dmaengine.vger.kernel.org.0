Return-Path: <dmaengine+bounces-5518-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C389FADCC90
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB979189CBDF
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EC62E3AE8;
	Tue, 17 Jun 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbZwbvw3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB321884A;
	Tue, 17 Jun 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165300; cv=none; b=O0mEF0V+K626mQ4Dy+/uqfJXGeHYw2HrU3XN7QCxgbE5kJXmrGCcEl+Db8aV/dRtK3j71f97jbZw9mApeQ8r9xcsPN+pygKBjlJVnadUygvki5EnsNzKwpOz/BbAWwMTPYXsBG/4Y9vQbxA8Gc/oSdN0E3UcIXT2cVuMDOadBlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165300; c=relaxed/simple;
	bh=JT/FyMm6rtyU5K/Eg4xo2fqlp5PZJ0E1GunTSFLwSyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4L3pfq5wET3zirhllkGKL11K6THFwYGmdA02VnfYbb/4Us3cat51DS698N9b9ySWXM6RcYFB6np43q4xm86KZfrKT1x56GRHPZclKHzlXpf15XzOi79Ft1LX4PysEhpceld50bohrDJ1BlKFrtntFb9Dz5riCEkjdJAWD0EuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbZwbvw3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750165298; x=1781701298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JT/FyMm6rtyU5K/Eg4xo2fqlp5PZJ0E1GunTSFLwSyw=;
  b=UbZwbvw3kCXAUOHkuNU249wJiH21d6Dqy59kRw31KgkahHG0JpNxGAds
   JKIN5G53isrVl618YXNZB3WBwD9HagqZJ/lARPLyXdKaeXg4BW+7Vlc4t
   hJ/Ew0YfSZqMMjzuARvT3lpDi1o5u47C8LR8HhIwcoBcHSISET5HK58GJ
   2fzmUa1m/xGKhtPudNXs67eoRZnACHzgeQW+Q3k4EGVNlOcS6nS+fSpEm
   bBw4BkcE78Sdu7a/Z8h6Kmw9ncTQf4GHrDZuWLMa3KDu/H7EJenZsq5w0
   HaFrtUcX6fE9Szm67H/eNt2d/q5bbD89f0cUq76c0hclkKkzb1ZZ5yeqM
   g==;
X-CSE-ConnectionGUID: K12SYrUeQQWPflGtPF6IOA==
X-CSE-MsgGUID: xML3zwHGQHON/A0mnhc/GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="51451818"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="51451818"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 06:01:37 -0700
X-CSE-ConnectionGUID: SRv1tUJ3QomuZ+q2fDkxwA==
X-CSE-MsgGUID: tIncxs5jTrGRSQX8Seff8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="153667138"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jun 2025 06:01:31 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRVwO-000Fza-2N;
	Tue, 17 Jun 2025 13:01:28 +0000
Date: Tue, 17 Jun 2025 21:00:52 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Kochetkov <al.kochet@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Nishad Saraf <nishads@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Andy Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 2/2] !!! TESTING ONLY !!! Allow compile virt-dma users
 on ARM64 platform
Message-ID: <202506172031.WOhp9AYg-lkp@intel.com>
References: <20250616124934.141782-3-al.kochet@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616124934.141782-3-al.kochet@gmail.com>

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on shawnguo/for-next sunxi/sunxi/for-next lee-mfd/for-mfd-next linus/master v6.16-rc2 next-20250617]
[cannot apply to atorgue-stm32/stm32-next lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Kochetkov/dmaengine-virt-dma-convert-tasklet-to-BH-workqueue-for-callback-invocation/20250616-205118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20250616124934.141782-3-al.kochet%40gmail.com
patch subject: [PATCH v2 2/2] !!! TESTING ONLY !!! Allow compile virt-dma users on ARM64 platform
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250617/202506172031.WOhp9AYg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250617/202506172031.WOhp9AYg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506172031.WOhp9AYg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/dma/fsldma.c:37:
   drivers/dma/fsldma.c: In function 'set_sr':
>> drivers/dma/fsldma.h:254:25: error: implicit declaration of function 'fsl_iowrite32be'; did you mean 'iowrite32be'? [-Wimplicit-function-declaration]
     254 |                         fsl_iowrite##width##be(val, addr) : fsl_iowrite \
         |                         ^~~~~~~~~~~
   drivers/dma/fsldma.c:52:9: note: in expansion of macro 'FSL_DMA_OUT'
      52 |         FSL_DMA_OUT(chan, &chan->regs->sr, val, 32);
         |         ^~~~~~~~~~~
>> drivers/dma/fsldma.h:254:61: error: implicit declaration of function 'fsl_iowrite32'; did you mean 'gf_iowrite32'? [-Wimplicit-function-declaration]
     254 |                         fsl_iowrite##width##be(val, addr) : fsl_iowrite \
         |                                                             ^~~~~~~~~~~
   drivers/dma/fsldma.c:52:9: note: in expansion of macro 'FSL_DMA_OUT'
      52 |         FSL_DMA_OUT(chan, &chan->regs->sr, val, 32);
         |         ^~~~~~~~~~~
   drivers/dma/fsldma.c: In function 'get_sr':
>> drivers/dma/fsldma.h:250:25: error: implicit declaration of function 'fsl_ioread32be'; did you mean 'ioread32be'? [-Wimplicit-function-declaration]
     250 |                         fsl_ioread##width##be(addr) : fsl_ioread##width(addr))
         |                         ^~~~~~~~~~
   drivers/dma/fsldma.c:57:16: note: in expansion of macro 'FSL_DMA_IN'
      57 |         return FSL_DMA_IN(chan, &chan->regs->sr, 32);
         |                ^~~~~~~~~~
>> drivers/dma/fsldma.h:250:55: error: implicit declaration of function 'fsl_ioread32'; did you mean 'gf_ioread32'? [-Wimplicit-function-declaration]
     250 |                         fsl_ioread##width##be(addr) : fsl_ioread##width(addr))
         |                                                       ^~~~~~~~~~
   drivers/dma/fsldma.c:57:16: note: in expansion of macro 'FSL_DMA_IN'
      57 |         return FSL_DMA_IN(chan, &chan->regs->sr, 32);
         |                ^~~~~~~~~~
   drivers/dma/fsldma.c: In function 'set_cdar':
>> drivers/dma/fsldma.h:254:25: error: implicit declaration of function 'fsl_iowrite64be' [-Wimplicit-function-declaration]
     254 |                         fsl_iowrite##width##be(val, addr) : fsl_iowrite \
         |                         ^~~~~~~~~~~
   drivers/dma/fsldma.c:72:9: note: in expansion of macro 'FSL_DMA_OUT'
      72 |         FSL_DMA_OUT(chan, &chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
         |         ^~~~~~~~~~~
>> drivers/dma/fsldma.h:254:61: error: implicit declaration of function 'fsl_iowrite64' [-Wimplicit-function-declaration]
     254 |                         fsl_iowrite##width##be(val, addr) : fsl_iowrite \
         |                                                             ^~~~~~~~~~~
   drivers/dma/fsldma.c:72:9: note: in expansion of macro 'FSL_DMA_OUT'
      72 |         FSL_DMA_OUT(chan, &chan->regs->cdar, addr | FSL_DMA_SNEN, 64);
         |         ^~~~~~~~~~~
   drivers/dma/fsldma.c: In function 'get_cdar':
>> drivers/dma/fsldma.h:250:25: error: implicit declaration of function 'fsl_ioread64be' [-Wimplicit-function-declaration]
     250 |                         fsl_ioread##width##be(addr) : fsl_ioread##width(addr))
         |                         ^~~~~~~~~~
   drivers/dma/fsldma.c:77:16: note: in expansion of macro 'FSL_DMA_IN'
      77 |         return FSL_DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
         |                ^~~~~~~~~~
>> drivers/dma/fsldma.h:250:55: error: implicit declaration of function 'fsl_ioread64' [-Wimplicit-function-declaration]
     250 |                         fsl_ioread##width##be(addr) : fsl_ioread##width(addr))
         |                                                       ^~~~~~~~~~
   drivers/dma/fsldma.c:77:16: note: in expansion of macro 'FSL_DMA_IN'
      77 |         return FSL_DMA_IN(chan, &chan->regs->cdar, 64) & ~FSL_DMA_SNEN;
         |                ^~~~~~~~~~
   drivers/dma/fsldma.c: In function 'fsl_chan_set_src_loop_size':
>> drivers/dma/fsldma.c:269:44: error: implicit declaration of function '__ilog2'; did you mean 'ilog2'? [-Wimplicit-function-declaration]
     269 |                 mode |= FSL_DMA_MR_SAHE | (__ilog2(size) << 14);
         |                                            ^~~~~~~
         |                                            ilog2


vim +254 drivers/dma/fsldma.h

a1ff82a9c165ba Peng Ma   2018-10-30  247  
a1ff82a9c165ba Peng Ma   2018-10-30  248  #define FSL_DMA_IN(fsl_dma, addr, width)			\
a1ff82a9c165ba Peng Ma   2018-10-30  249  		(((fsl_dma)->feature & FSL_DMA_BIG_ENDIAN) ?	\
a1ff82a9c165ba Peng Ma   2018-10-30 @250  			fsl_ioread##width##be(addr) : fsl_ioread##width(addr))
a1ff82a9c165ba Peng Ma   2018-10-30  251  
a1ff82a9c165ba Peng Ma   2018-10-30  252  #define FSL_DMA_OUT(fsl_dma, addr, val, width)			\
a1ff82a9c165ba Peng Ma   2018-10-30  253  		(((fsl_dma)->feature & FSL_DMA_BIG_ENDIAN) ?	\
a1ff82a9c165ba Peng Ma   2018-10-30 @254  			fsl_iowrite##width##be(val, addr) : fsl_iowrite	\
a1ff82a9c165ba Peng Ma   2018-10-30  255  		##width(val, addr))
173acc7ce8538f Zhang Wei 2008-03-01  256  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

