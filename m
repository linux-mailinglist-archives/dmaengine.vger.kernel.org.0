Return-Path: <dmaengine+bounces-2644-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC449291F6
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jul 2024 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA37C1C20ABE
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jul 2024 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597F518040;
	Sat,  6 Jul 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAuj91tl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94F4D8A3;
	Sat,  6 Jul 2024 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254819; cv=none; b=ut3xtEC/tvOuxErpiPaXRrXYO5HXt4q5y6+vSDkQolFW8O+AiYEYYCk5twHyCSSxR72BED5U5V1/2XfsKWQL9P0SHxUr2ymjy1b+6igaPqnc8e9S+wDCZpnvLx78OvrpFPwU2dISnfKooHFy5pJis00pB86E1OEykocQAHNLuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254819; c=relaxed/simple;
	bh=gweVUkEpsyKJeMAR+yP604+Q865gQcQV9BkPOORMKFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFf129TUfMMMQv27edqPUCL3SmQfJQN99sCv7okTCtu8IDIXoFKpyVEuloLv053E4Ztrf+UPgb1wUd3j0DkKLxZWyFZcjQBd9kRtTv+EFg8pbrkv19i2Oj4LkEiImkPfJBkta/9VvD2y08FcCu55dVarqtqlk0zrQNH7lGj4sIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAuj91tl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720254817; x=1751790817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gweVUkEpsyKJeMAR+yP604+Q865gQcQV9BkPOORMKFc=;
  b=SAuj91tlNC1/MHIKYsVtdYdnXXIwXlbPSM/1p49q6UqSrUtuRAjAGDOx
   9a7VceXeEx4XKhRbgmuy05ZHrtHo2XpRHR3/lXHKSbxzgkzLmRrXJS20b
   ThwS1drNfgjbNsCnb5homK2CKsIjouCjD0+2+z3ZxVYDJzw8bSPCLQ3NO
   y4c3qXfOzR+uFRuxjTLXctTJqRAdMvtsxz/s1AtZK4g4nAjRmIizOW455
   UsX7fYfBgRM8V4Ics//iotLcqmbgStZ/ywPP6IRu//U8kouL5d1BEZgNc
   nZ+eKnfJhSa98rTFkk6WTB/YMOCL+zXNn5cGLieYcZoFIKS+RQ8fEAQ9w
   A==;
X-CSE-ConnectionGUID: /1mpumi3SyG+Yo1Zweruow==
X-CSE-MsgGUID: tGwOKKWbTsqdzXD/rr2nzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="34966871"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="34966871"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 01:33:37 -0700
X-CSE-ConnectionGUID: +6MHJ8tASyijdlSEPfvsFQ==
X-CSE-MsgGUID: tf2SDI7TS0CzyEzgmnh1ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="47702042"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Jul 2024 01:33:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQ0rL-000TVw-1h;
	Sat, 06 Jul 2024 08:33:31 +0000
Date: Sat, 6 Jul 2024 16:33:17 +0800
From: kernel test robot <lkp@intel.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
	vkoul@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dmaengine: dw-edma: Add change to remove
 watermark interrupt enablement
Message-ID: <202407061620.Z6kfeKgF-lkp@intel.com>
References: <1720187733-5380-3-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720187733-5380-3-git-send-email-quic_msarkar@quicinc.com>

Hi Mrinmay,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on mani-mhi/mhi-next linus/master v6.10-rc6 next-20240703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mrinmay-Sarkar/dmaengine-dw-edma-Add-fix-to-unmask-the-interrupt-bit-for-HDMA/20240706-040233
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/1720187733-5380-3-git-send-email-quic_msarkar%40quicinc.com
patch subject: [PATCH v1 2/2] dmaengine: dw-edma: Add change to remove watermark interrupt enablement
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20240706/202407061620.Z6kfeKgF-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240706/202407061620.Z6kfeKgF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407061620.Z6kfeKgF-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `__kernel_entry':
>> (.text+0x0): relocation truncated to fit: R_MIPS_26 against `kernel_entry'
   arch/mips/kernel/head.o: in function `smp_bootstrap':
>> (.ref.text+0xd8): relocation truncated to fit: R_MIPS_26 against `start_secondary'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x10): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x18): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0x50): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x58): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x90): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x98): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0xd0): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xd8): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x108): additional relocation overflows omitted from the output
--
   drivers/dma/dw-edma/dw-hdma-v0-core.c: In function 'dw_hdma_v0_core_write_chunk':
>> drivers/dma/dw-edma/dw-hdma-v0-core.c:198:30: warning: unused variable 'chan' [-Wunused-variable]
     198 |         struct dw_edma_chan *chan = chunk->chan;
         |                              ^~~~


vim +/chan +198 drivers/dma/dw-edma/dw-hdma-v0-core.c

e74c39573d35e9 Cai Huoqing    2023-05-20  194  
e74c39573d35e9 Cai Huoqing    2023-05-20  195  static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
e74c39573d35e9 Cai Huoqing    2023-05-20  196  {
e74c39573d35e9 Cai Huoqing    2023-05-20  197  	struct dw_edma_burst *child;
e74c39573d35e9 Cai Huoqing    2023-05-20 @198  	struct dw_edma_chan *chan = chunk->chan;
e74c39573d35e9 Cai Huoqing    2023-05-20  199  	u32 control = 0, i = 0;
e74c39573d35e9 Cai Huoqing    2023-05-20  200  
e74c39573d35e9 Cai Huoqing    2023-05-20  201  	if (chunk->cb)
e74c39573d35e9 Cai Huoqing    2023-05-20  202  		control = DW_HDMA_V0_CB;
e74c39573d35e9 Cai Huoqing    2023-05-20  203  
882e8634dc8dd2 Mrinmay Sarkar 2024-07-05  204  	list_for_each_entry(child, &chunk->burst->list, list)
e74c39573d35e9 Cai Huoqing    2023-05-20  205  		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
e74c39573d35e9 Cai Huoqing    2023-05-20  206  					 child->sar, child->dar);
e74c39573d35e9 Cai Huoqing    2023-05-20  207  
e74c39573d35e9 Cai Huoqing    2023-05-20  208  	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
e74c39573d35e9 Cai Huoqing    2023-05-20  209  	if (!chunk->cb)
e74c39573d35e9 Cai Huoqing    2023-05-20  210  		control |= DW_HDMA_V0_CB;
e74c39573d35e9 Cai Huoqing    2023-05-20  211  
e74c39573d35e9 Cai Huoqing    2023-05-20  212  	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
e74c39573d35e9 Cai Huoqing    2023-05-20  213  }
e74c39573d35e9 Cai Huoqing    2023-05-20  214  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

