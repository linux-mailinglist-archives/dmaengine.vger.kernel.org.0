Return-Path: <dmaengine+bounces-5188-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D11ABA1F1
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 19:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4A69E422F
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770B2505C5;
	Fri, 16 May 2025 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0ksiJY4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404B21D5BD;
	Fri, 16 May 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417034; cv=none; b=XL5vvbLeX1tlzPZ0Ll2UB4ULikZMyQKRnvpgty2S1zKTzqHqC4Q66gmYiT8I6iRclUOB1od/JrdHdQJrVFbOf1N9onCUlbrLTxA7fzDpe5lAuc17eM7VyBVtzA71oS4yvHPtqpTzq/lm9zrekLOIlyVAQGDX1N+RJ5lCG/nPocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417034; c=relaxed/simple;
	bh=40Ng1e/p4FwwPbVoNfstSAWKg1bujMa4nNE3yHR1Pk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdcmsVG9IZUqwIpGVtN8jE6/SPQKrPLmvwPtrpOhwFllHag1HfQ0C7u9Pt0LAXbwlEAKzISkC/xE1k+s7oWdV4VtMg+AUnSTNrd4kOdq2dsFBEbKpwVWJh5DNk44q34WMntU/QET5PP6VauxZo7qbzQXGNh7qwzmvSgp+WsBpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0ksiJY4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747417034; x=1778953034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40Ng1e/p4FwwPbVoNfstSAWKg1bujMa4nNE3yHR1Pk0=;
  b=X0ksiJY4e3LWhSHkCOphewb2C/d/1B/oClRaJ9X5KJaOUgjnAuZxfQx/
   9kGl0ju2xww8aEvpBcDZJjUFkib6dXn2EDgBdaHRkJdwV8DHIeWJocSYS
   rKpfmIqc9D/t5OnuCQ3wsu0jlL+IqbzXqL537OwtXrEtfc9YVG+EyQpsK
   oB4XIcnJcvY93i4CSLy+Gd8ijgkotd3dLK0izb/3Hqd2axM7j68uuzbvt
   RWDdYU9t+TWTNyz2vfz6R3TrlfDuqhg1G2pm+Y4eniC/AIHirPSs9xm0z
   d+CCVGYeYJ6KOovvEUMhKY6bHzcEgvjYgqfQKj2ShEMR8PyTTHqKe6PJU
   A==;
X-CSE-ConnectionGUID: YMZBz6NXQYmFbBlWrNAD0g==
X-CSE-MsgGUID: dS/6wdhGQtKFW2Db5ugYJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49274108"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49274108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 10:37:13 -0700
X-CSE-ConnectionGUID: Fb8DaDi4TDS9m/QhyjBuwA==
X-CSE-MsgGUID: SaeIarkDQrKTAl9YgaptnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="138490538"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 May 2025 10:37:10 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFyzb-000Ja7-1k;
	Fri, 16 May 2025 17:37:07 +0000
Date: Sat, 17 May 2025 01:36:26 +0800
From: kernel test robot <lkp@intel.com>
To: adrianhoyin.ng@altera.com, dinguyen@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, adrianhoyin.ng@altera.com,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: Re: [PATCH 4/4] dma: dw-axi-dmac: Add support for dma-bit-mask
 property
Message-ID: <202505170152.aOv0x3eD-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on vkoul-dmaengine/next mtd/mtd/next mtd/mtd/fixes linus/master v6.15-rc6]
[cannot apply to next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/adrianhoyin-ng-altera-com/dt-bindings-dma-snps-dw-axi-dmac-Add-iommus-dma-coherent-and-dma-bit-mask-quirk/20250516-120810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/a10c000b7c8301018eb2b0a20fbf2d2d10e74a02.1747367749.git.adrianhoyin.ng%40altera.com
patch subject: [PATCH 4/4] dma: dw-axi-dmac: Add support for dma-bit-mask property
config: arc-randconfig-001-20250517 (https://download.01.org/0day-ci/archive/20250517/202505170152.aOv0x3eD-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250517/202505170152.aOv0x3eD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505170152.aOv0x3eD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'axi_dma_hw_init':
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:275:33: error: 'dev' undeclared (first use in this function); did you mean 'cdev'?
     275 |  ret = device_property_read_u32(dev, "snps,dma-bit-mask", &tmp);
         |                                 ^~~
         |                                 cdev
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:275:33: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:279:23: warning: left shift count >= width of type [-Wshift-count-overflow]
     279 |   if (tmp == 0 || tmp << 32 || tmp > 64)
         |                       ^~


vim +279 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c

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
   275		ret = device_property_read_u32(dev, "snps,dma-bit-mask", &tmp);
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

