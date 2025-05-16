Return-Path: <dmaengine+bounces-5189-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33236ABA22D
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 19:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDED31B659C7
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B06C1B6D06;
	Fri, 16 May 2025 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+aRvozF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407B41760;
	Fri, 16 May 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417696; cv=none; b=bVuJnEBC9zJwDIKtiK5Nlh0BkY/TYxpIULLw1ZeM0Y8V0EfbFxTb43kd2Act3cinRiTS2ronV0AoBMurOnnPFmHed8TDbve99bNGWtECU3WYCgLKZ0drBp4xC8LsJxoLAaAV0YeHa2CjQkQBEiS85APXES7EZnAYbhgm2arjf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417696; c=relaxed/simple;
	bh=SVUyvFc0fOQh8zVf1bYdRXhbpwwB58SaAA9VZ6xwr+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZsoIk2LkmjTVAzm+tNefrk8G7gFnucpXN3rAjIddAHit+6DUvL+cjl9YAkPnPRue3K/aHcklWIT+rrVxrBKGmtjVmEExWBZFsEJh43KH15rMluPP9XVaTbsPCH1XD7JWrY/ygomspSK2Q8T6P+M6gNbwcmLL7gMkSu6LEhTp5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+aRvozF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747417694; x=1778953694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SVUyvFc0fOQh8zVf1bYdRXhbpwwB58SaAA9VZ6xwr+c=;
  b=M+aRvozF2NvoR80miGaIZDxgKWS/lPoObvXPFdA7w4wzQZBxIwlcLGjy
   Rq0N6GXEiB8RVl1jwt9BYW7wcF3HeWJVSCuaQkgOzS/6j8aiZtHrSR7DC
   DiaveAst7MyKmf5vzoOY57qvr/RLnSL1Id/mnX6znCQsPbFEZJDpfbrhB
   Jz3P0+6n/h1Znimr5A3lYzZodYQA4s6gnhF95FDgxcGFG4ZwZALOP8hwB
   RgP2aKLassD2mjzXGQAUBudttW683wu1PTrIq+62LJ1+27dNNjGzTv85e
   QaXDP0FdYjeIgAW4oitOUjOCna642lEqv6fNg/PIYPVJv2kKi55cW+9cW
   A==;
X-CSE-ConnectionGUID: 24MZpaOjTWKeV3ypWEBlmQ==
X-CSE-MsgGUID: fjqqfiJiQkmoK0TFA9eD3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="53069831"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="53069831"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 10:48:14 -0700
X-CSE-ConnectionGUID: I5IyDPRQRgiAeo8QeQG/9A==
X-CSE-MsgGUID: 2VXXDIuERBSSiHMtCIEi/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="139640812"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 May 2025 10:48:11 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFzAG-000Jad-1I;
	Fri, 16 May 2025 17:48:08 +0000
Date: Sat, 17 May 2025 01:47:24 +0800
From: kernel test robot <lkp@intel.com>
To: adrianhoyin.ng@altera.com, dinguyen@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	adrianhoyin.ng@altera.com,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: Re: [PATCH 4/4] dma: dw-axi-dmac: Add support for dma-bit-mask
 property
Message-ID: <202505170130.I0p9B66f-lkp@intel.com>
References: <a10c000b7c8301018eb2b0a20fbf2d2d10e74a02.1747367749.git.adrianhoyin.ng@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a10c000b7c8301018eb2b0a20fbf2d2d10e74a02.1747367749.git.adrianhoyin.ng@altera.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on vkoul-dmaengine/next mtd/mtd/next mtd/mtd/fixes linus/master v6.15-rc6]
[cannot apply to next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/adrianhoyin-ng-altera-com/dt-bindings-dma-snps-dw-axi-dmac-Add-iommus-dma-coherent-and-dma-bit-mask-quirk/20250516-120810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/a10c000b7c8301018eb2b0a20fbf2d2d10e74a02.1747367749.git.adrianhoyin.ng%40altera.com
patch subject: [PATCH 4/4] dma: dw-axi-dmac: Add support for dma-bit-mask property
config: arm-randconfig-001-20250517 (https://download.01.org/0day-ci/archive/20250517/202505170130.I0p9B66f-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250517/202505170130.I0p9B66f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505170130.I0p9B66f-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:275:33: error: use of undeclared identifier 'dev'
     275 |         ret = device_property_read_u32(dev, "snps,dma-bit-mask", &tmp);
         |                                        ^
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:277:46: warning: shift count >= width of type [-Wshift-count-overflow]
     277 |                 ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
         |                                                            ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
>> drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:279:23: warning: shift count >= width of type [-Wshift-count-overflow]
     279 |                 if (tmp == 0 || tmp << 32 || tmp > 64)
         |                                     ^  ~~
   2 warnings and 1 error generated.


vim +/dev +275 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c

   264	
   265	static void axi_dma_hw_init(struct axi_dma_chip *chip)
   266	{
   267		int ret;
   268		u32 i, tmp;
   269	
   270		for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
   271			axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
   272			axi_chan_disable(&chip->dw->chan[i]);
   273		}
   274	
 > 275		ret = device_property_read_u32(dev, "snps,dma-bit-mask", &tmp);
   276		if (ret)
   277			ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
   278		else {
 > 279			if (tmp == 0 || tmp << 32 || tmp > 64)
   280				dev_err(chip->dev, "Invalid dma bit mask\n");
   281	
   282			ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(tmp));
   283		}
   284	
   285		if (ret)
   286			dev_warn(chip->dev, "Unable to set coherent mask\n");
   287	}
   288	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

