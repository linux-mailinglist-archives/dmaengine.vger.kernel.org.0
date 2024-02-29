Return-Path: <dmaengine+bounces-1191-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061486CB02
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 15:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE635284348
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AD91350D1;
	Thu, 29 Feb 2024 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6nnL434"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589D112FB29;
	Thu, 29 Feb 2024 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215731; cv=none; b=iNfL1qaBQ4S6fSEevbm5eHJJ80nYK2n9ueNJUqynsHXawx+bsRhXb16IyZAiXZP8j1Rwl2ZSWOTcmcAt1iIRTc6+ZYD392bMtUgV44CFFKQXZzre5ebY84rk/PFY3yPTxtPdBLre+of8HX8f44AWWhrS30xRew7+ziDCETdjJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215731; c=relaxed/simple;
	bh=ym05Q0VtUBiooHL8P6y0fx2F46T1H7KQDS2DIuAFPf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oC5L7OADTM5Pw7B6Vx3uRHaAgL1DVyEpuEy87I+r9VE+i1hpmLzCiOAVY3LYzGIbHQaw23fArmjak47fwTNiCDrPU146CO2goaTBC4S8I+68TudiCgZgUcnWWbdYRp1ErzzsIQhtP+cwQFuuGPsb5fai7QViwXzJnAuBknErlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6nnL434; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709215729; x=1740751729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ym05Q0VtUBiooHL8P6y0fx2F46T1H7KQDS2DIuAFPf0=;
  b=D6nnL434XWLSDBrLgX07+qh30I9yYGKs7ERFIB/KZZqcy3HlwWpnpt3n
   cfCsJNt5Xe6QejZWAqyl7jYxHfAOUaCk8XVWUM5k2PWOPZh1uYlERdG1V
   OgawiDdMBWY38fuXy+1Hn03NwAnBEwuw5AJYxuRZ4R0zbWGm1ca+ggoH3
   pzdxfKicum20bQBwxv1VQvC12tcmA0O/t2VFY7x83AKRt99ICWy1yhf8g
   cpo9BaJps7SesixL7n+wmSV+CoW0hldJuEU3Xt1j/CA0z87sv4tyX04W/
   Kzy49na7aaVBqpCH7elFCJQDpKZHJhtoGluQ7AbjxWdTMZ2xzYteq61P3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3851602"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3851602"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:08:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38864039"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 29 Feb 2024 06:08:45 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfh5W-000Czd-0V;
	Thu, 29 Feb 2024 14:08:42 +0000
Date: Thu, 29 Feb 2024 22:08:11 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/5] dmaengine: fsl-edma: remove 'slave_id' from
 fsl_edma_chan
Message-ID: <202402292240.149bq00a-lkp@intel.com>
References: <20240227-8ulp_edma-v1-1-7fcfe1e265c2@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227-8ulp_edma-v1-1-7fcfe1e265c2@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-edma-remove-slave_id-from-fsl_edma_chan/20240228-012842
base:   2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
patch link:    https://lore.kernel.org/r/20240227-8ulp_edma-v1-1-7fcfe1e265c2%40nxp.com
patch subject: [PATCH 1/5] dmaengine: fsl-edma: remove 'slave_id' from fsl_edma_chan
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240229/202402292240.149bq00a-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240229/202402292240.149bq00a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402292240.149bq00a-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/dma/mcf-edma-main.c:6:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2193:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/dma/mcf-edma-main.c:8:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/dma/mcf-edma-main.c:8:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/dma/mcf-edma-main.c:8:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/dma/mcf-edma-main.c:198:13: error: no member named 'slave_id' in 'struct fsl_edma_chan'
     198 |                 mcf_chan->slave_id = i;
         |                 ~~~~~~~~  ^
   drivers/dma/mcf-edma-main.c:280:21: error: no member named 'slave_id' in 'struct fsl_edma_chan'
     280 |                 return (mcf_chan->slave_id == (uintptr_t)param);
         |                         ~~~~~~~~  ^
   17 warnings and 2 errors generated.


vim +198 drivers/dma/mcf-edma-main.c

af802728e4ab07 drivers/dma/mcf-edma.c      Robin Gong         2019-06-25  152  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  153  static int mcf_edma_probe(struct platform_device *pdev)
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  154  {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  155  	struct mcf_edma_platform_data *pdata;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  156  	struct fsl_edma_engine *mcf_edma;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  157  	struct edma_regs *regs;
923b138388928a drivers/dma/mcf-edma.c      Christophe JAILLET 2023-05-06  158  	int ret, i, chans;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  159  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  160  	pdata = dev_get_platdata(&pdev->dev);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  161  	if (!pdata) {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  162  		dev_err(&pdev->dev, "no platform data supplied\n");
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  163  		return -EINVAL;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  164  	}
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  165  
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  166  	if (!pdata->dma_channels) {
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  167  		dev_info(&pdev->dev, "setting default channel number to 64");
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  168  		chans = 64;
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  169  	} else {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  170  		chans = pdata->dma_channels;
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  171  	}
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  172  
923b138388928a drivers/dma/mcf-edma.c      Christophe JAILLET 2023-05-06  173  	mcf_edma = devm_kzalloc(&pdev->dev, struct_size(mcf_edma, chans, chans),
923b138388928a drivers/dma/mcf-edma.c      Christophe JAILLET 2023-05-06  174  				GFP_KERNEL);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  175  	if (!mcf_edma)
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  176  		return -ENOMEM;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  177  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  178  	mcf_edma->n_chans = chans;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  179  
af802728e4ab07 drivers/dma/mcf-edma.c      Robin Gong         2019-06-25  180  	/* Set up drvdata for ColdFire edma */
af802728e4ab07 drivers/dma/mcf-edma.c      Robin Gong         2019-06-25  181  	mcf_edma->drvdata = &mcf_data;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  182  	mcf_edma->big_endian = 1;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  183  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  184  	mutex_init(&mcf_edma->fsl_edma_mutex);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  185  
4b23603a251d24 drivers/dma/mcf-edma.c      Tudor Ambarus      2022-11-10  186  	mcf_edma->membase = devm_platform_ioremap_resource(pdev, 0);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  187  	if (IS_ERR(mcf_edma->membase))
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  188  		return PTR_ERR(mcf_edma->membase);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  189  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  190  	fsl_edma_setup_regs(mcf_edma);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  191  	regs = &mcf_edma->regs;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  192  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  193  	INIT_LIST_HEAD(&mcf_edma->dma_dev.channels);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  194  	for (i = 0; i < mcf_edma->n_chans; i++) {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  195  		struct fsl_edma_chan *mcf_chan = &mcf_edma->chans[i];
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  196  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  197  		mcf_chan->edma = mcf_edma;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19 @198  		mcf_chan->slave_id = i;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  199  		mcf_chan->idle = true;
0fa89f972da607 drivers/dma/mcf-edma.c      Laurentiu Tudor    2019-01-18  200  		mcf_chan->dma_dir = DMA_NONE;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  201  		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  202  		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
7536f8b371adcc drivers/dma/mcf-edma-main.c Frank Li           2023-08-21  203  		mcf_chan->tcd = mcf_edma->membase + EDMA_TCD
7536f8b371adcc drivers/dma/mcf-edma-main.c Frank Li           2023-08-21  204  				+ i * sizeof(struct fsl_edma_hw_tcd);
b51dd7c8aac292 drivers/dma/mcf-edma-main.c Frank Li           2023-12-21  205  		edma_write_tcdreg(mcf_chan, cpu_to_le32(0), csr);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  206  	}
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  207  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  208  	iowrite32(~0, regs->inth);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  209  	iowrite32(~0, regs->intl);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  210  
af802728e4ab07 drivers/dma/mcf-edma.c      Robin Gong         2019-06-25  211  	ret = mcf_edma->drvdata->setup_irq(pdev, mcf_edma);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  212  	if (ret)
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  213  		return ret;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  214  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  215  	dma_cap_set(DMA_PRIVATE, mcf_edma->dma_dev.cap_mask);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  216  	dma_cap_set(DMA_SLAVE, mcf_edma->dma_dev.cap_mask);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  217  	dma_cap_set(DMA_CYCLIC, mcf_edma->dma_dev.cap_mask);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  218  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  219  	mcf_edma->dma_dev.dev = &pdev->dev;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  220  	mcf_edma->dma_dev.device_alloc_chan_resources =
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  221  			fsl_edma_alloc_chan_resources;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  222  	mcf_edma->dma_dev.device_free_chan_resources =
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  223  			fsl_edma_free_chan_resources;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  224  	mcf_edma->dma_dev.device_config = fsl_edma_slave_config;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  225  	mcf_edma->dma_dev.device_prep_dma_cyclic =
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  226  			fsl_edma_prep_dma_cyclic;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  227  	mcf_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  228  	mcf_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  229  	mcf_edma->dma_dev.device_pause = fsl_edma_pause;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  230  	mcf_edma->dma_dev.device_resume = fsl_edma_resume;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  231  	mcf_edma->dma_dev.device_terminate_all = fsl_edma_terminate_all;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  232  	mcf_edma->dma_dev.device_issue_pending = fsl_edma_issue_pending;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  233  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  234  	mcf_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  235  	mcf_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  236  	mcf_edma->dma_dev.directions =
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  237  			BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  238  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  239  	mcf_edma->dma_dev.filter.fn = mcf_edma_filter_fn;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  240  	mcf_edma->dma_dev.filter.map = pdata->slave_map;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  241  	mcf_edma->dma_dev.filter.mapcnt = pdata->slavecnt;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  242  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  243  	platform_set_drvdata(pdev, mcf_edma);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  244  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  245  	ret = dma_async_device_register(&mcf_edma->dma_dev);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  246  	if (ret) {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  247  		dev_err(&pdev->dev,
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  248  			"Can't register Freescale eDMA engine. (%d)\n", ret);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  249  		return ret;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  250  	}
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  251  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  252  	/* Enable round robin arbitration */
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  253  	iowrite32(EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  254  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  255  	return 0;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  256  }
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  257  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

