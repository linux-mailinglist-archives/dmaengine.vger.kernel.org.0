Return-Path: <dmaengine+bounces-7340-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9ECC84042
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 09:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B286E4E9398
	for <lists+dmaengine@lfdr.de>; Tue, 25 Nov 2025 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B6A2FB62E;
	Tue, 25 Nov 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYUdvJWX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D742D0C64;
	Tue, 25 Nov 2025 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059781; cv=none; b=kZiDVNplm8KftqlWMLC6moT4PDOta3UEd9rRGI1b41txFg3ksb2mhsF8UD+ewObZS/0+vzl+cGCAnVkW8YYmjtqlLVTi0cpAIBk9UiKlgrpXJ1Mqb0tluoM6NQsRaUM8JOAXcCwvhMVkA/pML+LFmLkczSVQJF77+zxJSpQYsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059781; c=relaxed/simple;
	bh=X0XjT64sT/WdpRuEO/Hl2etOjQix3IiRxfA7bAlxIos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlEf43q4X7wctTcg8G8B1cRd3xAGIv2/NS5G6lsqii7A8Jt1OzdwayC7KKRvz2y9x9o+7taqW5Oluirg39/0r89K/D5UiCJheKwHEIW9jykLSLHSImhF9BmqDMlE0lcfgLl+LKFIayOpCA6dTjYFUUjN6coin/mpGt4buJRxomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYUdvJWX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764059779; x=1795595779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X0XjT64sT/WdpRuEO/Hl2etOjQix3IiRxfA7bAlxIos=;
  b=WYUdvJWXQoHhOsaNtRA05BwlkStdFM79OLX+TMIoHBcIFUhU9yY083X5
   6/vymYpW+PiIyX0AJX47+y0ABSn08UbBzgBoRp7gCwYeXui42Aun17y5I
   Lxm4Y+ctFKmV2nF2ah7JI8mSYMqo3+vFrFNvlyZoAWgAPicwA8tM0pdRk
   zUIubAOsyz0hhFPciiQLJFVCXwWcbOH3dn+s7g5pgDQ61GACimW+19Q40
   WhrV4gjFv8uO5kY3z9eos3UHyYWF7myeb98VAGvJnMBgivTffNf813zgS
   OeJislCr+f7Uet0NTCurWyzLev6FNH3uzfPLrvFbnXFykidOrEWrtWYr3
   Q==;
X-CSE-ConnectionGUID: jrP1EiprSne/iQJSFU8jgQ==
X-CSE-MsgGUID: TiL2iSd3SxanYed17Xewzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="65071667"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="65071667"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:36:18 -0800
X-CSE-ConnectionGUID: 7luyBKC2TAC97/xvON/MMQ==
X-CSE-MsgGUID: rLU+iZilTkmS8KmXXIuJlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="193012469"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 00:36:16 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vNoWz-000000001X7-3arI;
	Tue, 25 Nov 2025 08:36:13 +0000
Date: Tue, 25 Nov 2025 16:35:43 +0800
From: kernel test robot <lkp@intel.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Greg Ungerer <gerg@linux-m68k.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: Re: [PATCH 3/7] dma: mcf-edma: Add per-channel IRQ naming for
 debugging
Message-ID: <202511251608.l7i5CNAr-lkp@intel.com>
References: <20251124-dma-coldfire-v1-3-dc8f93185464@yoseli.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-dma-coldfire-v1-3-dc8f93185464@yoseli.org>

Hi Jean-Michel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d13f3ac64efb868d09cb2726b1e84929afe90235]

url:    https://github.com/intel-lab-lkp/linux/commits/Jean-Michel-Hautbois/dma-fsl-edma-Add-write-barrier-after-TCD-descriptor-fill/20251124-205625
base:   d13f3ac64efb868d09cb2726b1e84929afe90235
patch link:    https://lore.kernel.org/r/20251124-dma-coldfire-v1-3-dc8f93185464%40yoseli.org
patch subject: [PATCH 3/7] dma: mcf-edma: Add per-channel IRQ naming for debugging
config: x86_64-buildonly-randconfig-002-20251125 (https://download.01.org/0day-ci/archive/20251125/202511251608.l7i5CNAr-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251125/202511251608.l7i5CNAr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511251608.l7i5CNAr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/mcf-edma-main.c: In function 'mcf_edma_irq_init':
>> drivers/dma/mcf-edma-main.c:86:56: warning: format '%d' expects argument of type 'int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
      86 |                                                 "eDMA-%d", i - res->start);
         |                                                       ~^   ~~~~~~~~~~~~~~
         |                                                        |     |
         |                                                        int   resource_size_t {aka long long unsigned int}
         |                                                       %lld
   drivers/dma/mcf-edma-main.c:100:56: warning: format '%d' expects argument of type 'int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
     100 |                                                 "eDMA-%d", 16 + i - res->start);
         |                                                       ~^   ~~~~~~~~~~~~~~~~~~~
         |                                                        |          |
         |                                                        int        resource_size_t {aka long long unsigned int}
         |                                                       %lld


vim +86 drivers/dma/mcf-edma-main.c

    72	
    73	static int mcf_edma_irq_init(struct platform_device *pdev,
    74					struct fsl_edma_engine *mcf_edma)
    75	{
    76		int ret = 0, i;
    77		struct resource *res;
    78	
    79		res = platform_get_resource_byname(pdev,
    80					IORESOURCE_IRQ, "edma-tx-00-15");
    81		if (!res)
    82			return -1;
    83	
    84		for (ret = 0, i = res->start; i <= res->end; ++i) {
    85			char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
  > 86							"eDMA-%d", i - res->start);
    87	
    88			ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
    89		}
    90		if (ret)
    91			return ret;
    92	
    93		res = platform_get_resource_byname(pdev,
    94				IORESOURCE_IRQ, "edma-tx-16-55");
    95		if (!res)
    96			return -1;
    97	
    98		for (ret = 0, i = res->start; i <= res->end; ++i) {
    99			char *irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
   100							"eDMA-%d", 16 + i - res->start);
   101	
   102			ret |= request_irq(i, mcf_edma_tx_handler, 0, irq_name, mcf_edma);
   103		}
   104		if (ret)
   105			return ret;
   106	
   107		ret = platform_get_irq_byname(pdev, "edma-tx-56-63");
   108		if (ret != -ENXIO) {
   109			ret = request_irq(ret, mcf_edma_tx_handler,
   110					  0, "eDMA-tx-56", mcf_edma);
   111			if (ret)
   112				return ret;
   113		}
   114	
   115		ret = platform_get_irq_byname(pdev, "edma-err");
   116		if (ret != -ENXIO) {
   117			ret = request_irq(ret, mcf_edma_err_handler,
   118					  0, "eDMA-err", mcf_edma);
   119			if (ret)
   120				return ret;
   121		}
   122	
   123		return 0;
   124	}
   125	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

