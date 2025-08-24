Return-Path: <dmaengine+bounces-6190-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD1B33264
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 21:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D431B232EE
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69471220F37;
	Sun, 24 Aug 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ldv31Tmn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6831372613;
	Sun, 24 Aug 2025 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756064343; cv=none; b=c3FR98moUNXJA8C9jQL1WOskY/xyWwUidZtP7gPAnSdU91N4+j4hYvnlIjtXrEH/N5xd/YMFoeAeF1DE8dAVGqZBmI4Vp/D3+IR6uVCJJC/wA7aPGCKzbkmthqd1IpKBshpe09HoDZyWZoDwRyrJkKRTUcAa4TkD4diUWmdPUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756064343; c=relaxed/simple;
	bh=8DlnE/rWJ6b3Mfl7JEc3Sc72YTacrmk6cJufKubDOs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpiTZjxz2SIproBGO6IQtma6Istf8q+P7q7PPx2lKT06N7dJHCitVBb1Vilc0oICGIRxnYqfAHWck8BYYZYiTqXmVHuUf86n3t48QHooSNwagE7Rjs/wpxffk7Bqz5dvJkmZ5lRBo6Qet6TWP/aPQ7aOKyxQa/a07xIwaNpuPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ldv31Tmn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756064341; x=1787600341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8DlnE/rWJ6b3Mfl7JEc3Sc72YTacrmk6cJufKubDOs4=;
  b=Ldv31TmnDZcQGYdCOuS0SZcbvRA+IGb1ej0d3Tj+jZmjyHxE9GSpea+Z
   OIWuLJUgsuM/TrjumN4mCfZdHLRhT2jPUwogg5EskvCqSgemRb8GKUK9F
   iSSQ7s8zidIH1fLFYcU3O301d3atzD0zXdpMvN0nvCZIcVXrTA2vZ9RxM
   YHrFafhyyyrA6jsd0gh8Zq/0a/Xn8P57buDdju58XXdWYx4goxzqbo/BF
   DOcv5eKjgE9hOc69nhyeDPj33pRsVyfSxiQeWT9/qn0FlI5EWz9JlvcVc
   bEaxAMFd4xuGtn4GoULSOIjm9pGOqb1JRw6kpcM2cBCIDn5J3OodMi917
   A==;
X-CSE-ConnectionGUID: bOtJvWX1QWaM0iTRh1J5qw==
X-CSE-MsgGUID: 6a31BhUtQo+EtyoQ17HR7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69386969"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="69386969"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 12:39:00 -0700
X-CSE-ConnectionGUID: MSw73TzIQPKqeRD6Q/wQQw==
X-CSE-MsgGUID: E77TZh/xTvu73DwINgJcmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="192793643"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 24 Aug 2025 12:38:58 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqGYJ-000NBP-1Q;
	Sun, 24 Aug 2025 19:38:55 +0000
Date: Mon, 25 Aug 2025 03:38:06 +0800
From: kernel test robot <lkp@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] dmaengine: dma350: Support ARM DMA-250
Message-ID: <202508250351.vxyvTsJa-lkp@intel.com>
References: <20250823154009.25992-15-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823154009.25992-15-jszhang@kernel.org>

Hi Jisheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.17-rc2 next-20250822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/dmaengine-dma350-Fix-CH_CTRL_USESRCTRIGIN-definition/20250824-000425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20250823154009.25992-15-jszhang%40kernel.org
patch subject: [PATCH 14/14] dmaengine: dma350: Support ARM DMA-250
config: x86_64-buildonly-randconfig-002-20250824 (https://download.01.org/0day-ci/archive/20250825/202508250351.vxyvTsJa-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250825/202508250351.vxyvTsJa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508250351.vxyvTsJa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/arm-dma350.c:849:34: warning: variable 'sg' is uninitialized when used here [-Wuninitialized]
     849 |         sglen = DIV_ROUND_UP(sg_dma_len(sg), step_max) * periods;
         |                                         ^~
   include/linux/scatterlist.h:34:27: note: expanded from macro 'sg_dma_len'
      34 | #define sg_dma_len(sg)          ((sg)->dma_length)
         |                                   ^~
   include/uapi/linux/const.h:51:40: note: expanded from macro '__KERNEL_DIV_ROUND_UP'
      51 | #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
         |                                        ^
   drivers/dma/arm-dma350.c:835:24: note: initialize the variable 'sg' to silence this warning
     835 |         struct scatterlist *sg;
         |                               ^
         |                                = NULL
   1 warning generated.


vim +/sg +849 drivers/dma/arm-dma350.c

   824	
   825	static struct dma_async_tx_descriptor *
   826	d250_prep_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
   827			 size_t buf_len, size_t period_len, enum dma_transfer_direction dir,
   828			 unsigned long flags)
   829	{
   830		struct d350_chan *dch = to_d350_chan(chan);
   831		u32 len, periods, trig, *cmd, tsz;
   832		dma_addr_t src, dst, phys, mem_addr;
   833		size_t xfer_len, step_max;
   834		struct d350_desc *desc;
   835		struct scatterlist *sg;
   836		struct d350_sg *dsg;
   837		int sglen, i;
   838	
   839		if (unlikely(!is_slave_direction(dir) || !buf_len || !period_len))
   840			return NULL;
   841	
   842		if (dir == DMA_MEM_TO_DEV)
   843			tsz = __ffs(dch->config.dst_addr_width | (1 << dch->tsz));
   844		else
   845			tsz = __ffs(dch->config.src_addr_width | (1 << dch->tsz));
   846		step_max = ((1UL << 16) - 1) << tsz;
   847	
   848		periods = buf_len / period_len;
 > 849		sglen = DIV_ROUND_UP(sg_dma_len(sg), step_max) * periods;
   850	
   851		desc = kzalloc(struct_size(desc, sg, sglen), GFP_NOWAIT);
   852		if (!desc)
   853			return NULL;
   854	
   855		dch->cyclic = true;
   856		dch->periods = periods;
   857		desc->sglen = sglen;
   858	
   859		sglen = 0;
   860		for (i = 0; i < periods; i++) {
   861			len = period_len;
   862			mem_addr = buf_addr + i * period_len;
   863			do {
   864				desc->sg[sglen].command = dma_pool_zalloc(dch->cmd_pool, GFP_NOWAIT, &phys);
   865				if (unlikely(!desc->sg[sglen].command))
   866					goto err_cmd_alloc;
   867	
   868				xfer_len = (len > step_max) ? step_max : len;
   869				desc->sg[sglen].phys = phys;
   870				dsg = &desc->sg[sglen];
   871	
   872				if (dir == DMA_MEM_TO_DEV) {
   873					src = mem_addr;
   874					dst = dch->config.dst_addr;
   875					trig = CH_CTRL_USEDESTRIGIN;
   876				} else {
   877					src = dch->config.src_addr;
   878					dst = mem_addr;
   879					trig = CH_CTRL_USESRCTRIGIN;
   880				}
   881				dsg->tsz = tsz;
   882				dsg->xsize = lower_16_bits(xfer_len >> dsg->tsz);
   883	
   884				cmd = dsg->command;
   885				cmd[0] = LINK_CTRL | LINK_SRCADDR | LINK_DESADDR |
   886					 LINK_XSIZE | LINK_SRCTRANSCFG |
   887					 LINK_DESTRANSCFG | LINK_XADDRINC | LINK_LINKADDR;
   888	
   889				cmd[1] = FIELD_PREP(CH_CTRL_TRANSIZE, dsg->tsz) |
   890					 FIELD_PREP(CH_CTRL_XTYPE, CH_CTRL_XTYPE_CONTINUE) |
   891					 FIELD_PREP(CH_CTRL_DONETYPE, CH_CTRL_DONETYPE_CMD) | trig;
   892	
   893				cmd[2] = lower_32_bits(src);
   894				cmd[3] = lower_32_bits(dst);
   895				cmd[4] = FIELD_PREP(CH_XY_SRC, dsg->xsize) |
   896					 FIELD_PREP(CH_XY_DES, dsg->xsize);
   897				if (dir == DMA_MEM_TO_DEV) {
   898					cmd[0] |= LINK_DESTRIGINCFG;
   899					cmd[5] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
   900					cmd[6] = TRANSCFG_DEVICE;
   901					cmd[7] = FIELD_PREP(CH_XY_SRC, 1);
   902					cmd[8] = FIELD_PREP(CH_DESTRIGINMODE, CH_DESTRIG_DMA_FC) |
   903						  FIELD_PREP(CH_DESTRIGINTYPE, CH_DESTRIG_HW_REQ);
   904				} else {
   905					cmd[0] |= LINK_SRCTRIGINCFG;
   906					cmd[5] = TRANSCFG_DEVICE;
   907					cmd[6] = dch->coherent ? TRANSCFG_WB : TRANSCFG_NC;
   908					cmd[7] = FIELD_PREP(CH_XY_DES, 1);
   909					cmd[8] = FIELD_PREP(CH_SRCTRIGINMODE, CH_SRCTRIG_DMA_FC) |
   910						  FIELD_PREP(CH_SRCTRIGINTYPE, CH_SRCTRIG_HW_REQ);
   911				}
   912	
   913				if (sglen)
   914					desc->sg[sglen - 1].command[9] = phys | CH_LINKADDR_EN;
   915	
   916				len -= xfer_len;
   917				mem_addr += xfer_len;
   918				sglen++;
   919			} while (len);
   920			desc->sg[sglen - 1].command[1] |= FIELD_PREP(CH_CTRL_DONETYPE,
   921								     CH_CTRL_DONETYPE_CMD);
   922		}
   923	
   924		/* cyclic list */
   925		desc->sg[sglen - 1].command[9] = desc->sg[0].phys | CH_LINKADDR_EN;
   926	
   927		mb();
   928	
   929		return vchan_tx_prep(&dch->vc, &desc->vd, flags);
   930	
   931	err_cmd_alloc:
   932		for (i = 0; i < sglen; i++)
   933			dma_pool_free(dch->cmd_pool, desc->sg[i].command, desc->sg[i].phys);
   934		kfree(desc);
   935		return NULL;
   936	}
   937	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

