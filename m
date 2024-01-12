Return-Path: <dmaengine+bounces-730-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4596282BC0D
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jan 2024 08:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC77FB2174E
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jan 2024 07:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7681A5D734;
	Fri, 12 Jan 2024 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyExNmij"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80815D72A;
	Fri, 12 Jan 2024 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705045866; x=1736581866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xl/4Y7vFo/j15AbuTLfV9oqpl4jq6vvLAHasmyBlIMk=;
  b=CyExNmijT4++vg+gDPyuzdS3Vf0aMW5Hu4Rwu9L15tTs19ra/IpfQbd4
   KsAUOJHiDu5LkrVVu3jrXwPYUB2KJVEYicw1j0NoQn6VlTq8hj6AJbsYl
   YQD6eszenJ6FaqUP2CHrEnvhkHpzGCJmiitBZXC/2htXv1l6YndVZSTos
   TH5uwpzRg3uS+Lsgfa+5Raqpw9VlSp0fPy+z+gU8Ct6QQH3fe2x4mlHCP
   zKASJOrM9wXLv68EvozE6bik5HWrGSMz+wX2ePxCrmxun+NVNrjHZsp8G
   bB7P9ovQ6XEARbwKm4oPBcV3++gQyXQe/MJOiwTNA23NY9snmIY9CpdbT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5838478"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="5838478"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 23:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="24632527"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 11 Jan 2024 23:51:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOCJd-0009DA-1R;
	Fri, 12 Jan 2024 07:50:58 +0000
Date: Fri, 12 Jan 2024 15:50:07 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
	Fabio Estevam <festevam@denx.de>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH] dmaengine: fsl-edma: fix Makefile logic
Message-ID: <202401121539.8Awy5Che-lkp@intel.com>
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
config: powerpc-ge_imp3a_defconfig (https://download.01.org/0day-ci/archive/20240112/202401121539.8Awy5Che-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121539.8Awy5Che-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121539.8Awy5Che-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/dma/fsl-edma-common.o: in function `fsl_edma_prep_dma_cyclic':
>> fsl-edma-common.c:(.text+0x85e): undefined reference to `vchan_tx_submit'
>> powerpc-linux-ld: fsl-edma-common.c:(.text+0x866): undefined reference to `vchan_tx_desc_free'
>> powerpc-linux-ld: fsl-edma-common.c:(.text+0x86e): undefined reference to `vchan_tx_submit'
   powerpc-linux-ld: fsl-edma-common.c:(.text+0x876): undefined reference to `vchan_tx_desc_free'
   powerpc-linux-ld: drivers/dma/fsl-edma-common.o: in function `fsl_edma_prep_memcpy':
   fsl-edma-common.c:(.text+0xa56): undefined reference to `vchan_tx_submit'
   powerpc-linux-ld: fsl-edma-common.c:(.text+0xa5a): undefined reference to `vchan_tx_desc_free'
   powerpc-linux-ld: fsl-edma-common.c:(.text+0xa66): undefined reference to `vchan_tx_submit'
   powerpc-linux-ld: fsl-edma-common.c:(.text+0xa6a): undefined reference to `vchan_tx_desc_free'
   powerpc-linux-ld: drivers/dma/fsl-edma-common.o: in function `fsl_edma_prep_slave_sg':
   fsl-edma-common.c:(.text+0xe32): undefined reference to `vchan_tx_submit'
   powerpc-linux-ld: fsl-edma-common.c:(.text+0xe36): undefined reference to `vchan_tx_desc_free'
   powerpc-linux-ld: fsl-edma-common.c:(.text+0xe42): undefined reference to `vchan_tx_submit'
   powerpc-linux-ld: fsl-edma-common.c:(.text+0xe46): undefined reference to `vchan_tx_desc_free'
   powerpc-linux-ld: drivers/dma/fsl-edma-common.o: in function `fsl_edma_terminate_all':
>> fsl-edma-common.c:(.text+0x13c0): undefined reference to `vchan_dma_desc_free_list'
   powerpc-linux-ld: drivers/dma/fsl-edma-common.o: in function `fsl_edma_free_chan_resources':
   fsl-edma-common.c:(.text+0x15d4): undefined reference to `vchan_dma_desc_free_list'
   powerpc-linux-ld: drivers/dma/fsl-edma-common.o: in function `fsl_edma_tx_status':
>> fsl-edma-common.c:(.text+0x1e10): undefined reference to `vchan_find_desc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

