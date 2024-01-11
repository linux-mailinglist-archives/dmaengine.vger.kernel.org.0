Return-Path: <dmaengine+bounces-729-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2567F82B831
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jan 2024 00:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83AB1F24E18
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 23:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868EA59B6F;
	Thu, 11 Jan 2024 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyXCygAr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB457870;
	Thu, 11 Jan 2024 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705016713; x=1736552713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v72etu5y7sZ+gduFKZmkV/OgzunlUF6teBcVsS2AH8k=;
  b=LyXCygArFCnvrY7S3rSZ3De3sMiMNY/BsKqyrXdseNcietPeVhFnSiLz
   kNo53MNparly6YHdq82BthEcpwQuIBFAFfVnX1yAIVtsZvV7c8B1T+YmK
   hJpg2iMNg05t1Z6GSaGBxKmfgbT9xrsIK71scjaGYowuA1UpJad2fh6Fe
   F0561ZKhjTFLpROu6fQf+OrN6GO4nWOR7i/UQ6I3rr3PzllEyjPrZo8Z4
   fn6TZ1OEYSYvYZmk3fiqfc/H1II/d2LuaohSqKU7rtMXbzguXOmZpULMr
   QDkUL1tdE9J2ph2HCBCq+U827ah/owF9VhdjmxE6dw8M+42mmiZpRATiD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463314016"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="463314016"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 15:45:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1114016155"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="1114016155"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jan 2024 15:45:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO4jT-0008rC-0I;
	Thu, 11 Jan 2024 23:45:07 +0000
Date: Fri, 12 Jan 2024 07:45:06 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
	Fabio Estevam <festevam@denx.de>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] dmaengine: fsl-edma: fix Makefile logic
Message-ID: <202401120722.iFJbAOb8-lkp@intel.com>
References: <20240110232255.1099757-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110232255.1099757-1-arnd@kernel.org>

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7 next-20240111]
[cannot apply to vkoul-dmaengine/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/dmaengine-fsl-edma-fix-Makefile-logic/20240111-072410
base:   linus/master
patch link:    https://lore.kernel.org/r/20240110232255.1099757-1-arnd%40kernel.org
patch subject: [PATCH] dmaengine: fsl-edma: fix Makefile logic
config: m68k-stmark2_defconfig (https://download.01.org/0day-ci/archive/20240112/202401120722.iFJbAOb8-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401120722.iFJbAOb8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401120722.iFJbAOb8-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/dma/mcf-edma-main.o: in function `mcf_edma_probe':
>> mcf-edma-main.c:(.text+0x4de): undefined reference to `fsl_edma_alloc_chan_resources'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x4f8): undefined reference to `fsl_edma_slave_config'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x506): undefined reference to `fsl_edma_prep_slave_sg'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x516): undefined reference to `fsl_edma_pause'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x524): undefined reference to `fsl_edma_terminate_all'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x5d2): undefined reference to `fsl_edma_free_desc'
   m68k-linux-ld: drivers/dma/mcf-edma-main.o: in function `mcf_edma_remove':
>> mcf-edma-main.c:(.text+0xb4): undefined reference to `fsl_edma_cleanup_vchan'
   m68k-linux-ld: drivers/dma/mcf-edma-main.o: in function `mcf_edma_err_handler':
>> mcf-edma-main.c:(.text+0x12e): undefined reference to `fsl_edma_disable_request'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x17a): undefined reference to `fsl_edma_disable_request'
   m68k-linux-ld: drivers/dma/mcf-edma-main.o: in function `mcf_edma_tx_handler':
>> mcf-edma-main.c:(.text+0x20e): undefined reference to `fsl_edma_tx_chan_handler'
   m68k-linux-ld: drivers/dma/mcf-edma-main.o: in function `mcf_edma_probe':
>> mcf-edma-main.c:(.text+0x466): undefined reference to `fsl_edma_setup_regs'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x4d4): undefined reference to `fsl_edma_free_chan_resources'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x4e4): undefined reference to `fsl_edma_prep_dma_cyclic'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x4ee): undefined reference to `fsl_edma_tx_status'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x50c): undefined reference to `fsl_edma_resume'
>> m68k-linux-ld: mcf-edma-main.c:(.text+0x52a): undefined reference to `fsl_edma_issue_pending'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

