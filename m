Return-Path: <dmaengine+bounces-4626-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29DAA4AD6C
	for <lists+dmaengine@lfdr.de>; Sat,  1 Mar 2025 19:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCC8167E31
	for <lists+dmaengine@lfdr.de>; Sat,  1 Mar 2025 18:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AB21E4929;
	Sat,  1 Mar 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NszrmjNc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E155D1C3BE0;
	Sat,  1 Mar 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740854994; cv=none; b=XXTYgKQXUpuEtfwnonvt5pk09feRnP1dIMxyGciC72tR1anZQMcMYFohUbZtOjnuQiYeWeV0OxS3QL9QyZnbJqUctXENY5kugUhHhLHz2cWOg8pKir3f12+JjrfVp5hYWw4Shr/50oGPZmyz0IhlPO1L44vLmQGBuFeQ4yHMmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740854994; c=relaxed/simple;
	bh=spCrMjTY6Hpbwf+1cmyrHlATFQqZasSJYz/+jT86L9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QszSyaKKR7AfeCmYGTmhA4QK7/UM3zTX3NeAjmZmSDCHHtqr4JkogwNVqp6ZraGC4Skz62D8/f12B7QOE4AEXqNdYguPYsn5ra+sXjTHwctPrty5i3CMYvhaLBb3w3SvxIuzHHtcRa1E1sHnP8Sze95RW70uABIWwanyfNhdY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NszrmjNc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740854993; x=1772390993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=spCrMjTY6Hpbwf+1cmyrHlATFQqZasSJYz/+jT86L9s=;
  b=NszrmjNcnBjYpsU3cQMSRDF37V+deknv/rq3w1UTtgS+uivwNJ/M5Ix3
   d2oZ2rB4Zj91My2+7gfOmLeCAuP7736LcFKPwsmhIN4au/arwHTzuwcmQ
   LTAay2oZjznUFwURFrTjcI74tl9vmveA7LaoLiuHMr7QU0xUAtMJdJjnS
   PtFtdzbLDgZvEj8H+obiXXltctIZkY5grpQaUBVOyaQex9XflouF9dN0g
   3NleaVgO/Q4H2Uq5OAb6VzzI/MzeY/3DPm483c715boEwqsgbmbffFfnI
   jbZXzzxcnCdGwSmxvgOrykQy/DW8uID40wl+kTQuaMJ36oyd5dzs0XDkP
   A==;
X-CSE-ConnectionGUID: /yS+vPAHTWqdCGv0PYWX6A==
X-CSE-MsgGUID: uP8BQz8wSpexHefpwTVOxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="45416184"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="45416184"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 10:49:53 -0800
X-CSE-ConnectionGUID: FIUMgNttTQCCdvZJ9MVmMg==
X-CSE-MsgGUID: rsFOSBnNRnSmClZcvBfr/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="122762858"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 01 Mar 2025 10:49:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toRuG-000GaE-16;
	Sat, 01 Mar 2025 18:49:48 +0000
Date: Sun, 2 Mar 2025 02:49:36 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, vkoul@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dmaengine: Add Arm DMA-350 driver
Message-ID: <202503020214.QiJLAEK2-lkp@intel.com>
References: <55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy@arm.com>

Hi Robin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/dt-bindings-dma-Add-Arm-DMA-350/20250301-012733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy%40arm.com
patch subject: [PATCH 2/2] dmaengine: Add Arm DMA-350 driver
config: hexagon-randconfig-001-20250302 (https://download.01.org/0day-ci/archive/20250302/202503020214.QiJLAEK2-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020214.QiJLAEK2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020214.QiJLAEK2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/arm-dma350.c:485:13: warning: logical not is only applied to the left hand side of this bitwise operator [-Wlogical-not-parentheses]
     485 |         } else if (!ch_status & CH_STAT_INTR_DONE) {
         |                    ^          ~
   drivers/dma/arm-dma350.c:485:13: note: add parentheses after the '!' to evaluate the bitwise operator first
     485 |         } else if (!ch_status & CH_STAT_INTR_DONE) {
         |                    ^                             
         |                     (                            )
   drivers/dma/arm-dma350.c:485:13: note: add parentheses around left hand side expression to silence this warning
     485 |         } else if (!ch_status & CH_STAT_INTR_DONE) {
         |                    ^
         |                    (         )
   1 warning generated.


vim +485 drivers/dma/arm-dma350.c

   462	
   463	static irqreturn_t d350_irq(int irq, void *data)
   464	{
   465		struct d350_chan *dch = data;
   466		struct device *dev = dch->vc.chan.device->dev;
   467		struct virt_dma_desc *vd = &dch->desc->vd;
   468		u32 ch_status;
   469	
   470		ch_status = readl(dch->base + CH_STATUS);
   471		if (!ch_status)
   472			return IRQ_NONE;
   473	
   474		if (ch_status & CH_STAT_INTR_ERR) {
   475			u32 errinfo = readl_relaxed(dch->base + CH_ERRINFO);
   476	
   477			if (errinfo & (CH_ERRINFO_AXIRDPOISERR | CH_ERRINFO_AXIRDRESPERR))
   478				vd->tx_result.result = DMA_TRANS_READ_FAILED;
   479			else if (errinfo & CH_ERRINFO_AXIWRRESPERR)
   480				vd->tx_result.result = DMA_TRANS_WRITE_FAILED;
   481			else
   482				vd->tx_result.result = DMA_TRANS_ABORTED;
   483	
   484			vd->tx_result.residue = d350_get_residue(dch);
 > 485		} else if (!ch_status & CH_STAT_INTR_DONE) {
   486			dev_warn(dev, "Unexpected IRQ source? 0x%08x\n", ch_status);
   487		}
   488		writel_relaxed(ch_status, dch->base + CH_STATUS);
   489	
   490		spin_lock(&dch->vc.lock);
   491		vchan_cookie_complete(vd);
   492		if (ch_status & CH_STAT_INTR_DONE) {
   493			dch->status = DMA_COMPLETE;
   494			dch->residue = 0;
   495			d350_start_next(dch);
   496		} else {
   497			dch->status = DMA_ERROR;
   498			dch->residue = vd->tx_result.residue;
   499		}
   500		spin_unlock(&dch->vc.lock);
   501	
   502		return IRQ_HANDLED;
   503	}
   504	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

