Return-Path: <dmaengine+bounces-3562-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 709E99AF6CD
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 03:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E20B233E8
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 01:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72852AEE3;
	Fri, 25 Oct 2024 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoAb7KeX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF00433D9
	for <dmaengine@vger.kernel.org>; Fri, 25 Oct 2024 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819475; cv=none; b=O5Cjq3ajXH3MbxdTJeEN2xq/eLphZ1rR64wOSxe4zyl7hOXOXPQWFinOQ9PpIxMVYEJEBl2kt63yEWpNjVOme6NyWGzW1BJ19I5oQi8MUPO1bl9flvZ2JmamlOr4t8YB3WTaN7ay6zPgPD2YSRHwHhqe5RbKqNF/wiU/jzHCdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819475; c=relaxed/simple;
	bh=FVDNq14EOZUAPVTR4UJ7HWA3O/emKnfVI/klyQ5hmLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABVgMe4fpg3EbeRD9COMy4pmVLZ/yJYRm5I5pl6/IhlYeUqOaub3HkmC2dtnjylpayDPR+lV2EEmvQXvwh3mrw8xsuCUho0rw0e5m50LcRtNIxROG9Mz5uJzVrTaZsDQx/VvFGaSll+acU8eBznarDjpM58Mgrf8aXgijO08Wzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoAb7KeX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729819474; x=1761355474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FVDNq14EOZUAPVTR4UJ7HWA3O/emKnfVI/klyQ5hmLU=;
  b=EoAb7KeXRSJtk5ralGXMcCehElKgmKfH6ciNakYdFxVxDEXkQn9HMTeE
   XAPx9+VvvtNmMX1bPEq3zFlMu7jQVnE9UtxKFWl6oNJGReQvU+Yz37eO+
   MwZGBDgEe8QpVRiJ1OSejzKbO4zfSQ8CGDLcX8QtIW8VUWDf09PnUSHXH
   ZC+fX0Ke8+RBK1k3KWO53hPDfrVReW2oIu11pxF3+QmfBYd20S8Y7FO84
   oczBWIgbZvAUeY3L2YwTvrD1JVgpSYWMHAPySNQjNz1Brq5oFAkTtQAQw
   u01LhjQAX1jQJrYCA1a8TmyacJ6rMNDpq/Lsa9AMBriM4zC7UD3V9DJsJ
   Q==;
X-CSE-ConnectionGUID: NoYsl9VaQRezfJ4hRfa3nA==
X-CSE-MsgGUID: kz25KkojSomNfwprAxzXgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52031164"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52031164"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 18:24:34 -0700
X-CSE-ConnectionGUID: qvBRMzlmSmuTKbEfm8r/7g==
X-CSE-MsgGUID: JR2d6RFKRaGrtTx9ixUEJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85564525"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 24 Oct 2024 18:24:31 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4940-000XMp-1u;
	Fri, 25 Oct 2024 01:24:28 +0000
Date: Fri, 25 Oct 2024 09:24:27 +0800
From: kernel test robot <lkp@intel.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Raju.Rangoju@amd.com, Frank.li@nxp.com, helgaas@kernel.org,
	pstanner@redhat.com, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH v7 4/6] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
Message-ID: <202410250904.txsoe5RZ-lkp@intel.com>
References: <20241023123613.710671-5-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023123613.710671-5-Basavaraj.Natikar@amd.com>

Hi Basavaraj,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Basavaraj-Natikar/dmaengine-Move-AMD-PTDMA-driver-to-amd-directory/20241023-203903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20241023123613.710671-5-Basavaraj.Natikar%40amd.com
patch subject: [PATCH v7 4/6] dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register
config: x86_64-buildonly-randconfig-003-20241025 (https://download.01.org/0day-ci/archive/20241025/202410250904.txsoe5RZ-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250904.txsoe5RZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250904.txsoe5RZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/dma/amd/ptdma/ptdma-dmaengine.c:12:
   In file included from drivers/dma/amd/ptdma/ptdma.h:17:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/dma/amd/ptdma/ptdma-dmaengine.c:115:13: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     115 |         bool soc = FIELD_GET(DWORD0_SOC, desc->dwouv.dw0);
         |                    ^
>> drivers/dma/amd/ptdma/ptdma-dmaengine.c:119:22: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     119 |                 desc->dwouv.dw0 |= FIELD_PREP(DWORD0_IOC, desc->dwouv.dw0);
         |                                    ^
   1 warning and 2 errors generated.


vim +/FIELD_GET +115 drivers/dma/amd/ptdma/ptdma-dmaengine.c

   112	
   113	static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *ae4cmd_q)
   114	{
 > 115		bool soc = FIELD_GET(DWORD0_SOC, desc->dwouv.dw0);
   116		struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
   117	
   118		if (soc) {
 > 119			desc->dwouv.dw0 |= FIELD_PREP(DWORD0_IOC, desc->dwouv.dw0);
   120			desc->dwouv.dw0 &= ~DWORD0_SOC;
   121		}
   122	
   123		mutex_lock(&ae4cmd_q->cmd_lock);
   124		memcpy(&cmd_q->qbase[ae4cmd_q->tail_wi], desc, sizeof(struct ae4dma_desc));
   125		ae4cmd_q->q_cmd_count++;
   126		ae4cmd_q->tail_wi = (ae4cmd_q->tail_wi + 1) % CMD_Q_LEN;
   127		writel(ae4cmd_q->tail_wi, cmd_q->reg_control + AE4_WR_IDX_OFF);
   128		mutex_unlock(&ae4cmd_q->cmd_lock);
   129	
   130		wake_up(&ae4cmd_q->q_w);
   131	
   132		return 0;
   133	}
   134	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

