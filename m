Return-Path: <dmaengine+bounces-2690-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6026930757
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jul 2024 23:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477BC1F21A09
	for <lists+dmaengine@lfdr.de>; Sat, 13 Jul 2024 21:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8DF143C5F;
	Sat, 13 Jul 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXhYp/jk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D413C838;
	Sat, 13 Jul 2024 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905112; cv=none; b=UmR6945R3F/XUACgWKgrE6bMOPSFVPsgtyHeu8TRR4vSrVEnyhovrMTVU3lSX3QRHbAub9cgEE3deI1hFQDTCJA3lJfRsV1nAFyDhoFQ0XRvjZAajGNX+gBdEuTiAcsXD5e15fGWZOmAWOAsCBrXrtC7tNSz8W4hJkquIsaXd0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905112; c=relaxed/simple;
	bh=oaFByJPL12+FUprAqJYDqhzErP7nO44Id9JmB2tyyXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0mod2eymE9oxFl+vP8y1Dh2QchxyrF4gTkY6snyEo3UjqDzSPKKhBGY8NopV7bGmOeRCt8qSxbTfE6gPS5J6AQYiKjciPjmoPfBEsMVEl8WBi+gR6N6m91Kjpt/7FUSMl/3JDeQVTHZm1a3c9/0NwSzD8+Hd0vHtpWjtq+s1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXhYp/jk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720905110; x=1752441110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oaFByJPL12+FUprAqJYDqhzErP7nO44Id9JmB2tyyXM=;
  b=XXhYp/jkrAsXdtF8sCK0N9p7kA9P1SeSqH1j7kso9D2ljyViUdR9NMGX
   8TT/JlSn1XhQQ18EvR/R/Xvss3utZ5eCcaXweji8+2TyLsgy8pwg33jaL
   ThX1KFHK7Lqf2+CLOX+1t+Jye90HnmGy4tHRLr86KZhyfAaqTw3gFD2zF
   EYxbCcSa99V9hWB5Myk7Ca45NWa+1huvPxAxrtrwaFrep/OR7eaaR6Cbn
   qCg6LVI5UA5H/EtbfPLWbVVr1fOxu7DKycB9jzIutXuMoHXeU2dFfqpIX
   rZSFrZrpj05U+FSA+53TN3Wb78yaMD2MEgLXBWLPtD1xsRr+der+9qGqu
   w==;
X-CSE-ConnectionGUID: OxayXOuVQCqghM2G8oXdXQ==
X-CSE-MsgGUID: dS4b9Sm+T+K7+rteeWXmtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11132"; a="18456490"
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="18456490"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 14:11:49 -0700
X-CSE-ConnectionGUID: WzhOHMcnS0euBvTBoE/FTA==
X-CSE-MsgGUID: rvDBRUFGThm1yHvQDCddyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,206,1716274800"; 
   d="scan'208";a="54173404"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Jul 2024 14:11:46 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSk1v-000ckQ-2f;
	Sat, 13 Jul 2024 21:11:43 +0000
Date: Sun, 14 Jul 2024 05:11:14 +0800
From: kernel test robot <lkp@intel.com>
To: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH RESEND v9 2/2] dmaengine: Loongson1: Add Loongson-1 APB
 DMA driver
Message-ID: <202407140536.iIizeGVy-lkp@intel.com>
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240714/202407140536.iIizeGVy-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240714/202407140536.iIizeGVy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407140536.iIizeGVy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:598,
                    from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/fortify-string.h:6,
                    from include/linux/string.h:374,
                    from include/linux/scatterlist.h:5,
                    from include/linux/dmapool.h:14,
                    from drivers/dma/loongson1-apb-dma.c:8:
   drivers/dma/loongson1-apb-dma.c: In function 'ls1x_dma_start':
>> drivers/dma/loongson1-apb-dma.c:137:34: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
     137 |         dev_dbg(chan2dev(dchan), "cookie=%d, starting hwdesc=%x\n",
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/dma/loongson1-apb-dma.c:137:9: note: in expansion of macro 'dev_dbg'
     137 |         dev_dbg(chan2dev(dchan), "cookie=%d, starting hwdesc=%x\n",
         |         ^~~~~~~
   drivers/dma/loongson1-apb-dma.c:137:63: note: format string is defined here
     137 |         dev_dbg(chan2dev(dchan), "cookie=%d, starting hwdesc=%x\n",
         |                                                              ~^
         |                                                               |
         |                                                               unsigned int
         |                                                              %llx


vim +137 drivers/dma/loongson1-apb-dma.c

   130	
   131	static inline int ls1x_dma_start(struct ls1x_dma_chan *chan,
   132					 dma_addr_t *hwdesc_phys)
   133	{
   134		struct dma_chan *dchan = &chan->vchan.chan;
   135		int val, ret;
   136	
 > 137		dev_dbg(chan2dev(dchan), "cookie=%d, starting hwdesc=%x\n",
   138			dchan->cookie, *hwdesc_phys);
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

