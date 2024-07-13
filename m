Return-Path: <dmaengine+bounces-2691-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00121930807
	for <lists+dmaengine@lfdr.de>; Sun, 14 Jul 2024 01:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9DF1F2155F
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jul 2024 23:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E019149E1A;
	Sat, 13 Jul 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIfAGHsU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE313E88B;
	Sat, 13 Jul 2024 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720913157; cv=none; b=lDgfdF1zUz7YpkRUjgs62ER50SltoUXgPDbsCmqvQRgbJSkYLpzEGDD8vg8sQtXCNl8fUOAXqnpkZdta+nsia/HCep262AlgwBqGY70W0eXbHMFsglrl893gqczntJkgiaCHkGpvhX5AguCJ1FDrTafqoD8P4UMlTi5kaQWIeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720913157; c=relaxed/simple;
	bh=PImxgGKyVk7kPOsf77JMkli5keQyd7AsTSM8XarLkFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuWkZZ5Mz5wBfOJucIayYxOi3NOR1ThuZJe5iXpYRtUXOqhzbwV0dT76jWRsxZ9BZgT7z0YnPeWzhdWDTNLB/8b0C7qVxpsxJrCwqxEozTgq90/Q7GlDaEQ9+riQ7QZF0KPtmO5fi3nhiIcssnXxF3SGrIJeyuN52c8f8RIntnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIfAGHsU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720913155; x=1752449155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PImxgGKyVk7kPOsf77JMkli5keQyd7AsTSM8XarLkFI=;
  b=XIfAGHsUlR8Jk2873iNuk3zlEoa4PxNcEnQSQh4fkIOi4s24ha5n3ups
   YFXTaZlGuP1lj4YljrVJ85Vy2Ih86B30KnmPw3ltnxPJ79EX6xQQtIS+r
   5n40GoKUIW2Qn4/qFXEpK+3H/JhIg1GY0OPcpz3oOcnhfkyvpFoldjNfQ
   GOC2WA1+sbXJr3KYR8oZpewbsNJo3emM3Dcyzhg0fqQnl2nxOy4FpAkSb
   X2yKsjRRmX/ihka0qFF/EHUmLmAzXK/3P+WVN0NRkZFnAUFS49IwB7uwI
   zDZPvUGay3LtF1EmfxX273Ut9HEcs1Rctiv3ZnNsqMLwijSjd7+SCpui6
   g==;
X-CSE-ConnectionGUID: wR5tpD9CR7KadXasfrftuA==
X-CSE-MsgGUID: RxE7AoNYT0eIOi8K2mLXzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="22143508"
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="22143508"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 16:25:54 -0700
X-CSE-ConnectionGUID: 31244haTR72HJOvqgTZu5A==
X-CSE-MsgGUID: IWY47mOpS06iLoo7usBlFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,207,1716274800"; 
   d="scan'208";a="54434821"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Jul 2024 16:25:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSm7g-000cqQ-1k;
	Sat, 13 Jul 2024 23:25:48 +0000
Date: Sun, 14 Jul 2024 07:24:57 +0800
From: kernel test robot <lkp@intel.com>
To: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH RESEND v9 2/2] dmaengine: Loongson1: Add Loongson-1 APB
 DMA driver
Message-ID: <202407140701.jQbPNAYb-lkp@intel.com>
References: <20240711-loongson1-dma-v9-2-5ce8b5e85a56@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-loongson1-dma-v9-2-5ce8b5e85a56@gmail.com>

Hi Keguang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d35b2284e966c0bef3e2182a5c5ea02177dd32e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang-via-B4-Relay/dt-bindings-dma-Add-Loongson-1-APB-DMA/20240711-191657
base:   d35b2284e966c0bef3e2182a5c5ea02177dd32e4
patch link:    https://lore.kernel.org/r/20240711-loongson1-dma-v9-2-5ce8b5e85a56%40gmail.com
patch subject: [PATCH RESEND v9 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240714/202407140701.jQbPNAYb-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240714/202407140701.jQbPNAYb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407140701.jQbPNAYb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/loongson1-apb-dma.c:138:18: warning: format specifies type 'unsigned int' but the argument has type 'dma_addr_t' (aka 'unsigned long long') [-Wformat]
     137 |         dev_dbg(chan2dev(dchan), "cookie=%d, starting hwdesc=%x\n",
         |                                                              ~~
         |                                                              %llx
     138 |                 dchan->cookie, *hwdesc_phys);
         |                                ^~~~~~~~~~~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:274:19: note: expanded from macro 'dynamic_dev_dbg'
     274 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
>> drivers/dma/loongson1-apb-dma.c:338:53: warning: format specifies type 'int' but the argument has type 'size_t' (aka 'unsigned long') [-Wformat]
     338 |                 "buf_len=%d period_len=%zu flags=0x%lx dir=%s\n", buf_len,
         |                          ~~                                       ^~~~~~~
         |                          %zu
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:274:19: note: expanded from macro 'dynamic_dev_dbg'
     274 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   2 warnings generated.


vim +138 drivers/dma/loongson1-apb-dma.c

   130	
   131	static inline int ls1x_dma_start(struct ls1x_dma_chan *chan,
   132					 dma_addr_t *hwdesc_phys)
   133	{
   134		struct dma_chan *dchan = &chan->vchan.chan;
   135		int val, ret;
   136	
   137		dev_dbg(chan2dev(dchan), "cookie=%d, starting hwdesc=%x\n",
 > 138			dchan->cookie, *hwdesc_phys);
   139	
   140		val = *hwdesc_phys & DMA_ADDR_MASK;
   141		val |= DMA_START;
   142		val |= dchan->chan_id;
   143		chan_writel(chan, DMA_CTRL, val);
   144		ret = readl_poll_timeout(chan->reg_base + DMA_CTRL, val,
   145					 !(val & DMA_START), 0, 3000);
   146		if (ret)
   147			dev_err(chan2dev(dchan), "failed to start DMA\n");
   148	
   149		return ret;
   150	}
   151	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

