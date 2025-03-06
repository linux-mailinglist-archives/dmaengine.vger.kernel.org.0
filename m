Return-Path: <dmaengine+bounces-4653-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7543A549AD
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 12:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BB61885F77
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 11:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B0020D4E8;
	Thu,  6 Mar 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAHtQOn6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CAB20AF8D;
	Thu,  6 Mar 2025 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260826; cv=none; b=jSW6+ynrdKVrrsnGRZ18ljbDIfKc0iLHcNCG8blhc8+xpojY8GDeL+G9ZeaSW/a2wqHK1/4LS+LwcP8kqqc+zB5qZUP68x1uWFF8kVu0etL4LVbEtkePADMpNi6VJwd+H6ylouq9Gpofl3AVdtYxjWvyIIYWgDtSxBlY+rK8ZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260826; c=relaxed/simple;
	bh=0RkHv2NVUIjDTMRzp3ZLW9jex5M/ZIevpBWyXbznxKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGRJ1GU4rAF4mQJmttI+Cg48bliRPkp/Wu7ZkK9/4F5UIQ3q30MF1feKPPVlYMxQRSpo5Swy7w8HD4HAA/NAW+YwSt6drqFbNDCrFJukPNIxJDFiU8UmKhjlUzFJ909Zp+za7ScEqFgG0FeILPtmaGe0Ha+7h4u1fy0NESsEn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAHtQOn6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741260825; x=1772796825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0RkHv2NVUIjDTMRzp3ZLW9jex5M/ZIevpBWyXbznxKs=;
  b=JAHtQOn6hDyOcaqX4dzp6SJ/JhHAsyveLdX9qhvXD4IHzL26STVhpDVF
   QIa0jz4SO0tkocladzGvuYw/VB2A0/2iejZKcjWZXFvaiYepCN72SBc6F
   aVGyYr2GD1KIGYxvrZhB32Ci6BkR/dGu1bPJbtYTqOHaEspeGi5AW3eL+
   mQbKJzkvBgTENsvFO/NHaWSp6a5d9wT6bphU+Zu7oA00Ig+w0ren01B3Z
   HXcEHysUjMbrunCyT/H62eBgLwDESg8YVIqTV1uWQHeXjhr9XAD7OgPQl
   LSZNLOYBwkaybX6q6mUL8cSBq1RVa8B3oLXM8g9WiBPk/Iyw4KklPBnNA
   Q==;
X-CSE-ConnectionGUID: CyYVksOmT3WTqjuhTJFreA==
X-CSE-MsgGUID: dwDFRNYVQbuocXGhbyzfGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59673239"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="59673239"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:33:45 -0800
X-CSE-ConnectionGUID: iKI6AAlYRAmEUJI/bGQSYA==
X-CSE-MsgGUID: wyJvtgh2SWSibKMKNc9NZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="124093820"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 06 Mar 2025 03:33:42 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq9Tw-000Mz8-1P;
	Thu, 06 Mar 2025 11:33:40 +0000
Date: Thu, 6 Mar 2025 19:33:28 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, vkoul@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dmaengine: Add Arm DMA-350 driver
Message-ID: <202503061910.eJW7M2H3-lkp@intel.com>
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
[also build test WARNING on linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/dt-bindings-dma-Add-Arm-DMA-350/20250301-012733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/55e084dd2b5720bdddf503ffac560d111032aa96.1740762136.git.robin.murphy%40arm.com
patch subject: [PATCH 2/2] dmaengine: Add Arm DMA-350 driver
config: nios2-randconfig-r111-20250306 (https://download.01.org/0day-ci/archive/20250306/202503061910.eJW7M2H3-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250306/202503061910.eJW7M2H3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061910.eJW7M2H3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/dma/arm-dma350.c:485:31: sparse: sparse: dubious: !x & y
   drivers/dma/arm-dma350.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

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

