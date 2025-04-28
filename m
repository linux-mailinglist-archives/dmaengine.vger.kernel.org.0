Return-Path: <dmaengine+bounces-5034-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97716A9FEEC
	for <lists+dmaengine@lfdr.de>; Tue, 29 Apr 2025 03:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF195A5BB2
	for <lists+dmaengine@lfdr.de>; Tue, 29 Apr 2025 01:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCAA1C7006;
	Tue, 29 Apr 2025 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRraj1R+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CF1C1F07;
	Tue, 29 Apr 2025 01:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889585; cv=none; b=meTEc+RkJDvbRXsTEtz3ZfFfz1dsesmLsPibEgjv3VBbdnyUl1CY0TUkZOlXG2NepqjHQNU42JlCWbm+zPKCs6fCKQIfUcg5SbWPmZDh+pXgJicBydhlk/eWn5jkXgw1/rVyJNYFjY1TC3/o/rwRyhMN3XwzTa/PjXgYZNlvIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889585; c=relaxed/simple;
	bh=R3UAhkpOPCmKmxNTzkcTSJ8pqpaUKXLkVbgY8NNMnek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLx8iG55nHURkkjB4qC3RdLN12RoEeMxHp8rHDiP9MPIlNfiHRRtohswdKE5u5gT7pagRlw6CX/EV0iBLHfqy+RAsuRodk7GbrC62fKI1YO/+TIIf5xUKvRkpJsZ3WTCpnlVtL0DG9sBZT3XJC1kfiDDShqjS3n428fIkT0MBLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRraj1R+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745889583; x=1777425583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R3UAhkpOPCmKmxNTzkcTSJ8pqpaUKXLkVbgY8NNMnek=;
  b=lRraj1R+ehvFb3Au8U5K/nfXd6G5tWEY8wiy2yh91DIj+PeWIlJImIzA
   ZicndxjSJtl/5Q3vC4vLkh05qyV72wJD4Fo60OLrlEGuHovxNU9AEwLs1
   ykC/o/0FZ5sadgbEfBjay2zFWyTpunkj5lkJ0suvbWSPMZCNO1HH7NM0Q
   p003/scP9xsF/NyfMmLb/0CxaexABEH1bW3mchEEwdxLrG7zpr2I+OUj7
   kgxtwKMZTV9a44t+fgsb3kykT2phk9LmYh2CW28pmrCnGcXsO+ZyYwDQG
   HGUkE6baXyGQGwO58cxCf8be+eepJx76gO0t+kahJjcqPyMG8eW23xTAZ
   Q==;
X-CSE-ConnectionGUID: HVecENgfSt6YGszfYVGtWw==
X-CSE-MsgGUID: vUHwlYcsSc+9MSnmJYJX+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="51165287"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="51165287"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 18:19:35 -0700
X-CSE-ConnectionGUID: NL+2JPk/QSatszxG4Hf86A==
X-CSE-MsgGUID: SgVXDWYzSQ2Krf65Z8hqvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="164775790"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Apr 2025 18:19:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u9Zd7-00001R-1V;
	Tue, 29 Apr 2025 01:19:25 +0000
Date: Tue, 29 Apr 2025 02:45:46 +0800
From: kernel test robot <lkp@intel.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, peter.ujfalusi@gmail.com,
	vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5/8] drivers: soc: ti: k3-ringacc: handle absence of tisci
Message-ID: <202504290207.ct0tnV56-lkp@intel.com>
References: <20250428072032.946008-6-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428072032.946008-6-s-adivi@ti.com>

Hi Sai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.15-rc4]
[cannot apply to next-20250428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sai-Sree-Kartheek-Adivi/dt-bindings-dma-ti-Add-document-for-K3-BCDMA-V2/20250428-152616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20250428072032.946008-6-s-adivi%40ti.com
patch subject: [PATCH 5/8] drivers: soc: ti: k3-ringacc: handle absence of tisci
config: arm64-randconfig-001-20250428 (https://download.01.org/0day-ci/archive/20250429/202504290207.ct0tnV56-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250429/202504290207.ct0tnV56-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504290207.ct0tnV56-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/soc/ti/k3-ringacc.c:214: warning: Function parameter or struct member 'cfg' not described in 'k3_ring'
>> drivers/soc/ti/k3-ringacc.c:214: warning: Function parameter or struct member 'intr' not described in 'k3_ring'


vim +214 drivers/soc/ti/k3-ringacc.c

6b3da0b475b877 Peter Ujfalusi          2020-07-24  168  
3277e8aa2504d9 Grygorii Strashko       2020-01-15  169  /**
3277e8aa2504d9 Grygorii Strashko       2020-01-15  170   * struct k3_ring - RA Ring descriptor
3277e8aa2504d9 Grygorii Strashko       2020-01-15  171   *
3277e8aa2504d9 Grygorii Strashko       2020-01-15  172   * @rt: Ring control/status registers
3277e8aa2504d9 Grygorii Strashko       2020-01-15  173   * @fifos: Ring queues registers
3277e8aa2504d9 Grygorii Strashko       2020-01-15  174   * @proxy: Ring Proxy Datapath registers
3277e8aa2504d9 Grygorii Strashko       2020-01-15  175   * @ring_mem_dma: Ring buffer dma address
3277e8aa2504d9 Grygorii Strashko       2020-01-15  176   * @ring_mem_virt: Ring buffer virt address
3277e8aa2504d9 Grygorii Strashko       2020-01-15  177   * @ops: Ring operations
3277e8aa2504d9 Grygorii Strashko       2020-01-15  178   * @size: Ring size in elements
3277e8aa2504d9 Grygorii Strashko       2020-01-15  179   * @elm_size: Size of the ring element
3277e8aa2504d9 Grygorii Strashko       2020-01-15  180   * @mode: Ring mode
3277e8aa2504d9 Grygorii Strashko       2020-01-15  181   * @flags: flags
50883affe17e11 Lee Jones               2020-11-21  182   * @state: Ring state
3277e8aa2504d9 Grygorii Strashko       2020-01-15  183   * @ring_id: Ring Id
3277e8aa2504d9 Grygorii Strashko       2020-01-15  184   * @parent: Pointer on struct @k3_ringacc
3277e8aa2504d9 Grygorii Strashko       2020-01-15  185   * @use_count: Use count for shared rings
3277e8aa2504d9 Grygorii Strashko       2020-01-15  186   * @proxy_id: RA Ring Proxy Id (only if @K3_RINGACC_RING_USE_PROXY)
8c42379e40e2db Peter Ujfalusi          2020-10-25  187   * @dma_dev: device to be used for DMA API (allocation, mapping)
d782298c6f6b85 Grygorii Strashko       2020-12-08  188   * @asel: Address Space Select value for physical addresses
3277e8aa2504d9 Grygorii Strashko       2020-01-15  189   */
3277e8aa2504d9 Grygorii Strashko       2020-01-15  190  struct k3_ring {
3277e8aa2504d9 Grygorii Strashko       2020-01-15  191  	struct k3_ring_rt_regs __iomem *rt;
babdc2c3524293 Sai Sree Kartheek Adivi 2025-04-28  192  	struct k3_ring_cfg_regs __iomem *cfg;
babdc2c3524293 Sai Sree Kartheek Adivi 2025-04-28  193  	struct k3_ring_intr_regs __iomem *intr;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  194  	struct k3_ring_fifo_regs __iomem *fifos;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  195  	struct k3_ringacc_proxy_target_regs  __iomem *proxy;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  196  	dma_addr_t	ring_mem_dma;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  197  	void		*ring_mem_virt;
d9483b44c94eba Christophe JAILLET      2024-07-09  198  	const struct k3_ring_ops *ops;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  199  	u32		size;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  200  	enum k3_ring_size elm_size;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  201  	enum k3_ring_mode mode;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  202  	u32		flags;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  203  #define K3_RING_FLAG_BUSY	BIT(1)
3277e8aa2504d9 Grygorii Strashko       2020-01-15  204  #define K3_RING_FLAG_SHARED	BIT(2)
d782298c6f6b85 Grygorii Strashko       2020-12-08  205  #define K3_RING_FLAG_REVERSE	BIT(3)
6b3da0b475b877 Peter Ujfalusi          2020-07-24  206  	struct k3_ring_state state;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  207  	u32		ring_id;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  208  	struct k3_ringacc	*parent;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  209  	u32		use_count;
3277e8aa2504d9 Grygorii Strashko       2020-01-15  210  	int		proxy_id;
8c42379e40e2db Peter Ujfalusi          2020-10-25  211  	struct device	*dma_dev;
d782298c6f6b85 Grygorii Strashko       2020-12-08  212  	u32		asel;
d782298c6f6b85 Grygorii Strashko       2020-12-08  213  #define K3_ADDRESS_ASEL_SHIFT	48
3277e8aa2504d9 Grygorii Strashko       2020-01-15 @214  };
3277e8aa2504d9 Grygorii Strashko       2020-01-15  215  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

