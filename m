Return-Path: <dmaengine+bounces-5261-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC602AC34E7
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 15:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357E61895FCD
	for <lists+dmaengine@lfdr.de>; Sun, 25 May 2025 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEAD1E98EF;
	Sun, 25 May 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXT+rDv/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769E1DACB1;
	Sun, 25 May 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748179734; cv=none; b=Fv1nuTS0glZNZYv3n/ZMozJ1KJd4mgHecSi76Mo+tKlk05gJ3oxBIg0Q5y/CTmr28/A14kCccFECd5aroWdZzCbNXFYFu9U1iCAOCy89MfRLIeRmascRC9YZGZS7RrfLRzNh+/zC1dyT80gW+2ooPYuE7OvH8aCT0uimasXfYzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748179734; c=relaxed/simple;
	bh=zgP0WvUVk0EyOxWqJtWUylni9ScXVYHpKVhMXiLCehA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ty+bwESW8LkRDgP0zy4Ro4tKgHA26TvoqbP95lTAMtrKxzXXH5NCnf1zJLlTJvajIjY+cGR4kmYl3wvy/fGmWn+U/W+CoRFoRUu1nCbvP4r5OZamQG1fWf9ONPdFGExy9/a92jjr7P+rcZe/M5ojNiIke1Kf1UQe5Pu2EL2iD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXT+rDv/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748179733; x=1779715733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zgP0WvUVk0EyOxWqJtWUylni9ScXVYHpKVhMXiLCehA=;
  b=GXT+rDv/V4dVImpBqAa95hd+R9hlv6Mf4XaDteYCRxBumZADxJpD+RoG
   I8jTqWJjSt0s8BIwoiMItPtZ6XrOOQQYMcLzzhg1Ij94q4dUw/yd8rp3A
   Bs8bGk2w20qSU6paWU9gNb88CdWxxuY9NovoTd4kGyUMvbTAsB5HgOMuA
   lXLD3chdmwPPNbV8g+F8asmirNHnxBQEC1EbY1VLRlsgNhEF23/sI9J7d
   uZ0EYpIyfxMFXWStP4UokKv82gf0MvMdVcQeH7fKoUj52Vpj2lojXUnSf
   5UN/pcXQbTFpUq1ecvoB3jsoLackDbwnWHfgmT9BSsj2IRvoHLMQk8K3f
   w==;
X-CSE-ConnectionGUID: B3iezTrITDiFgUkcBR3rPA==
X-CSE-MsgGUID: sNaW6+kNQoSBXEu03Mk6Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="53824100"
X-IronPort-AV: E=Sophos;i="6.15,313,1739865600"; 
   d="scan'208";a="53824100"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 06:28:53 -0700
X-CSE-ConnectionGUID: ATnCZY7XQECv1sPWjZZL7g==
X-CSE-MsgGUID: ckdh9z1PTZqY4Wh7Bpd7Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,313,1739865600"; 
   d="scan'208";a="141807838"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 25 May 2025 06:28:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJBPC-000Rpo-2x;
	Sun, 25 May 2025 13:28:46 +0000
Date: Sun, 25 May 2025 21:28:46 +0800
From: kernel test robot <lkp@intel.com>
To: Suraj Gupta <suraj.gupta2@amd.com>, vkoul@kernel.org,
	michal.simek@amd.com, radhey.shyam.pandey@amd.com,
	thomas.gessler@brueckmann-gmbh.de
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	harini.katakam@amd.com
Subject: Re: [PATCH 2/2] dmaengine: xilinx_dma: Add support to
 configure/report coalesce parameters from/to client using AXI DMA
Message-ID: <202505252153.Nm1BzFUq-lkp@intel.com>
References: <20250525101617.1168991-3-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525101617.1168991-3-suraj.gupta2@amd.com>

Hi Suraj,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on xilinx-xlnx/master soc/for-next linus/master v6.15-rc7 next-20250523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Suraj-Gupta/dmaengine-Add-support-to-configure-and-read-IRQ-coalescing-parameters/20250525-181817
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20250525101617.1168991-3-suraj.gupta2%40amd.com
patch subject: [PATCH 2/2] dmaengine: xilinx_dma: Add support to configure/report coalesce parameters from/to client using AXI DMA
config: i386-buildonly-randconfig-004-20250525 (https://download.01.org/0day-ci/archive/20250525/202505252153.Nm1BzFUq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250525/202505252153.Nm1BzFUq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505252153.Nm1BzFUq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:28,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/scatterlist.h:8,
                    from include/linux/dmapool.h:14,
                    from drivers/dma/xilinx/xilinx_dma.c:37:
   drivers/dma/xilinx/xilinx_dma.c: In function 'xilinx_dma_start_transfer':
>> drivers/dma/xilinx/xilinx_dma.c:1594:28: error: implicit declaration of function 'FIELD_MAX' [-Werror=implicit-function-declaration]
    1594 |         timer = min(timer, FIELD_MAX(XILINX_DMA_DMACR_DELAY_MASK));
         |                            ^~~~~~~~~
   include/linux/minmax.h:92:49: note: in definition of macro '__careful_cmp_once'
      92 |         __auto_type ux = (x); __auto_type uy = (y);     \
         |                                                 ^
   include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
     105 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/dma/xilinx/xilinx_dma.c:1594:17: note: in expansion of macro 'min'
    1594 |         timer = min(timer, FIELD_MAX(XILINX_DMA_DMACR_DELAY_MASK));
         |                 ^~~
   In file included from <command-line>:
>> include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_299' declared with attribute error: min(timer, FIELD_MAX((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)((24) > (31)) * 0l)) : (int *)8))), (24) > (31), false))); }))) + (((~((0UL))) << (24)) & (~((0UL)) >> (32 - 1 - (31))))))) signedness error
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:538:25: note: in definition of macro '__compiletime_assert'
     538 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:557:9: note: in expansion of macro '_compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
      98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
     105 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   drivers/dma/xilinx/xilinx_dma.c:1594:17: note: in expansion of macro 'min'
    1594 |         timer = min(timer, FIELD_MAX(XILINX_DMA_DMACR_DELAY_MASK));
         |                 ^~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/kernel.h:28,
                    from include/linux/cpumask.h:11,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/scatterlist.h:8,
                    from include/linux/dmapool.h:14,
                    from xilinx_dma.c:37:
   xilinx_dma.c: In function 'xilinx_dma_start_transfer':
   xilinx_dma.c:1594:28: error: implicit declaration of function 'FIELD_MAX' [-Werror=implicit-function-declaration]
    1594 |         timer = min(timer, FIELD_MAX(XILINX_DMA_DMACR_DELAY_MASK));
         |                            ^~~~~~~~~
   include/linux/minmax.h:92:49: note: in definition of macro '__careful_cmp_once'
      92 |         __auto_type ux = (x); __auto_type uy = (y);     \
         |                                                 ^
   include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
     105 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   xilinx_dma.c:1594:17: note: in expansion of macro 'min'
    1594 |         timer = min(timer, FIELD_MAX(XILINX_DMA_DMACR_DELAY_MASK));
         |                 ^~~
   In file included from <command-line>:
>> include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_299' declared with attribute error: min(timer, FIELD_MAX((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr((sizeof(int) == sizeof(*(8 ? ((void *)((long)((24) > (31)) * 0l)) : (int *)8))), (24) > (31), false))); }))) + (((~((0UL))) << (24)) & (~((0UL)) >> (32 - 1 - (31))))))) signedness error
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:538:25: note: in definition of macro '__compiletime_assert'
     538 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:557:9: note: in expansion of macro '_compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
      98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
     105 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   xilinx_dma.c:1594:17: note: in expansion of macro 'min'
    1594 |         timer = min(timer, FIELD_MAX(XILINX_DMA_DMACR_DELAY_MASK));
         |                 ^~~
   cc1: some warnings being treated as errors


vim +/FIELD_MAX +1594 drivers/dma/xilinx/xilinx_dma.c

  1539	
  1540	/**
  1541	 * xilinx_dma_start_transfer - Starts DMA transfer
  1542	 * @chan: Driver specific channel struct pointer
  1543	 */
  1544	static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
  1545	{
  1546		struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
  1547		struct xilinx_axidma_tx_segment *tail_segment;
  1548		struct dma_slave_config *slave_cfg = &chan->slave_cfg;
  1549		u64 clk_rate;
  1550		u32 reg, usec, timer;
  1551	
  1552		if (chan->err)
  1553			return;
  1554	
  1555		if (list_empty(&chan->pending_list))
  1556			return;
  1557	
  1558		if (!chan->idle)
  1559			return;
  1560	
  1561		head_desc = list_first_entry(&chan->pending_list,
  1562					     struct xilinx_dma_tx_descriptor, node);
  1563		tail_desc = list_last_entry(&chan->pending_list,
  1564					    struct xilinx_dma_tx_descriptor, node);
  1565		tail_segment = list_last_entry(&tail_desc->segments,
  1566					       struct xilinx_axidma_tx_segment, node);
  1567	
  1568		reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
  1569	
  1570		reg &= ~XILINX_DMA_CR_COALESCE_MAX;
  1571		reg  &= ~XILINX_DMA_CR_DELAY_MAX;
  1572	
  1573		/* Use dma_slave_config if it has valid values */
  1574		if (slave_cfg->coalesce_cnt &&
  1575		    slave_cfg->coalesce_cnt <= XILINX_DMA_COALESCE_MAX)
  1576			reg |= slave_cfg->coalesce_cnt <<
  1577				XILINX_DMA_CR_COALESCE_SHIFT;
  1578		else if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX)
  1579			reg |= chan->desc_pendingcount <<
  1580					  XILINX_DMA_CR_COALESCE_SHIFT;
  1581	
  1582		if (slave_cfg->coalesce_usecs <= XILINX_DMA_DMACR_DELAY_MAX)
  1583			usec = slave_cfg->coalesce_usecs;
  1584		else
  1585			usec = chan->irq_delay;
  1586	
  1587		/* Scale with SG clock rate rather than being a fixed number of
  1588		 * clock cycles.
  1589		 * 1 Timeout Interval = 125 * (clock period of SG clock)
  1590		 */
  1591		clk_rate = clk_get_rate(chan->xdev->rx_clk);
  1592		timer = DIV64_U64_ROUND_CLOSEST((u64)usec * clk_rate,
  1593						XILINX_DMA_DELAY_SCALE);
> 1594		timer = min(timer, FIELD_MAX(XILINX_DMA_DMACR_DELAY_MASK));
  1595		reg |= timer << XILINX_DMA_CR_DELAY_SHIFT;
  1596	
  1597		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
  1598	
  1599		if (chan->has_sg)
  1600			xilinx_write(chan, XILINX_DMA_REG_CURDESC,
  1601				     head_desc->async_tx.phys);
  1602	
  1603		xilinx_dma_start(chan);
  1604	
  1605		if (chan->err)
  1606			return;
  1607	
  1608		/* Start the transfer */
  1609		if (chan->has_sg) {
  1610			if (chan->cyclic)
  1611				xilinx_write(chan, XILINX_DMA_REG_TAILDESC,
  1612					     chan->cyclic_seg_v->phys);
  1613			else
  1614				xilinx_write(chan, XILINX_DMA_REG_TAILDESC,
  1615					     tail_segment->phys);
  1616		} else {
  1617			struct xilinx_axidma_tx_segment *segment;
  1618			struct xilinx_axidma_desc_hw *hw;
  1619	
  1620			segment = list_first_entry(&head_desc->segments,
  1621						   struct xilinx_axidma_tx_segment,
  1622						   node);
  1623			hw = &segment->hw;
  1624	
  1625			xilinx_write(chan, XILINX_DMA_REG_SRCDSTADDR,
  1626				     xilinx_prep_dma_addr_t(hw->buf_addr));
  1627	
  1628			/* Start the transfer */
  1629			dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
  1630				       hw->control & chan->xdev->max_buffer_len);
  1631		}
  1632	
  1633		list_splice_tail_init(&chan->pending_list, &chan->active_list);
  1634		chan->desc_pendingcount = 0;
  1635		chan->idle = false;
  1636	}
  1637	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

