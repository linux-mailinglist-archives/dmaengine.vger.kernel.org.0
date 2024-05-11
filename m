Return-Path: <dmaengine+bounces-2026-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9122E8C30BE
	for <lists+dmaengine@lfdr.de>; Sat, 11 May 2024 12:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460FF1F2323F
	for <lists+dmaengine@lfdr.de>; Sat, 11 May 2024 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29834204F;
	Sat, 11 May 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bliNSHdp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25C28E7
	for <dmaengine@vger.kernel.org>; Sat, 11 May 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715424905; cv=none; b=lGVKIe05VAJAOepRraWpCe2GJL95D0zEBW6b63EdnRXpDUlK3q+ITuwORPE3b469vlZUrIrboUqlV2RtRLmkyzKfMXkPrNbcXcGX1plCVFFO/fSBMEZuyJ4zD1X2BoLV6wFWiSNaAR+XbH8BU+QUohPmnxCVsLpxFyPuSzlNVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715424905; c=relaxed/simple;
	bh=CAEcq8wHgIYILZB7x96+DWhEP/wavUYAVA2uoKPC+dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJN3rZWFwIRzCn6K1UrddwUhMP6WyaZuN7JcHgUaaMXl81HDm2q5yns3gmB8UOV97S8kb8V3DooMjrD/7mgV0j7eX9Oc15AnVEp8l57ZA8LuYEgAlwfBS/RSoyNJDk400uvwAOTS87kdU3yw487P6Zbf/nbM4X7sW3l1R9gwpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bliNSHdp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715424903; x=1746960903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CAEcq8wHgIYILZB7x96+DWhEP/wavUYAVA2uoKPC+dc=;
  b=bliNSHdpKDMivvFeUEgUyjRxNYV8S1/xXxSgM8GoJmckbkp19g3Vq0KI
   0N3w/jkgbc/9haKKkAyuBr0GUJJdAwBzoYiO/W2QWTOmZnp2Q4DkHk4jS
   au25OlUdk8zY3YEdNVUZgbP5Hly9zCfv+BCp8XsmmxxJY7Tct/nJRSsZx
   mlF+SqxP6wfBpctQjOXu1tuHFFK3xLEd9uh6K7gvAIOUre538mgkw0gxg
   DonFdsHIqIqQa17wFqmWO7HQ+rCsrAI7iZYBkOjhy5tIgQ70weVtSRt+K
   JQJrhJbt70xkGV95Ifzjfjln/OTV3vBxgd6UX+agFwWhPs9Pfsxfs5kTh
   w==;
X-CSE-ConnectionGUID: TWmK/eVNTa2cy/5PSsdC0w==
X-CSE-MsgGUID: U/0YuS/7RnKjV7Sg3XcRqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="22823774"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="22823774"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 03:55:02 -0700
X-CSE-ConnectionGUID: 3m49cR5/TTy9m2xNaz96DA==
X-CSE-MsgGUID: hghfJFJiRSypWDiwIHE7cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="29847937"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 May 2024 03:55:01 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5kNW-0007HH-2H;
	Sat, 11 May 2024 10:54:58 +0000
Date: Sat, 11 May 2024 18:54:43 +0800
From: kernel test robot <lkp@intel.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
	dmaengine@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Raju.Rangoju@amd.com,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH 4/7] dmaengine: ptdma: Extend ptdma to support
 multi-channel and version
Message-ID: <202405111809.dOmIUtt3-lkp@intel.com>
References: <20240510082053.875923-5-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510082053.875923-5-Basavaraj.Natikar@amd.com>

Hi Basavaraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Basavaraj-Natikar/dmaengine-Move-AMD-DMA-driver-to-separate-directory/20240510-162221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20240510082053.875923-5-Basavaraj.Natikar%40amd.com
patch subject: [PATCH 4/7] dmaengine: ptdma: Extend ptdma to support multi-channel and version
config: x86_64-randconfig-122-20240511 (https://download.01.org/0day-ci/archive/20240511/202405111809.dOmIUtt3-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405111809.dOmIUtt3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405111809.dOmIUtt3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/amd/ptdma/ptdma-dmaengine.c: In function 'pt_create_desc':
>> drivers/dma/amd/ptdma/ptdma-dmaengine.c:208:30: warning: variable 'cmd_q' set but not used [-Wunused-but-set-variable]
     208 |         struct pt_cmd_queue *cmd_q;
         |                              ^~~~~


vim +/cmd_q +208 drivers/dma/amd/ptdma/ptdma-dmaengine.c

   197	
   198	static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
   199						  dma_addr_t dst,
   200						  dma_addr_t src,
   201						  unsigned int len,
   202						  unsigned long flags)
   203	{
   204		struct pt_dma_chan *chan = to_pt_chan(dma_chan);
   205		struct pt_passthru_engine *pt_engine;
   206		struct pt_device *pt = chan->pt;
   207		struct ae4_cmd_queue *ae4cmd_q;
 > 208		struct pt_cmd_queue *cmd_q;
   209		struct pt_dma_desc *desc;
   210		struct ae4_device *ae4;
   211		struct pt_cmd *pt_cmd;
   212	
   213		desc = pt_alloc_dma_desc(chan, flags);
   214		if (!desc)
   215			return NULL;
   216	
   217		pt_cmd = &desc->pt_cmd;
   218		pt_cmd->pt = pt;
   219		pt_engine = &pt_cmd->passthru;
   220		pt_cmd->engine = PT_ENGINE_PASSTHRU;
   221		pt_engine->src_dma = src;
   222		pt_engine->dst_dma = dst;
   223		pt_engine->src_len = len;
   224		pt_cmd->pt_cmd_callback = pt_cmd_callback;
   225		pt_cmd->data = desc;
   226	
   227		desc->len = len;
   228	
   229		if (pt->ver == AE4_DMA_VERSION) {
   230			ae4 = container_of(pt, struct ae4_device, pt);
   231			ae4cmd_q = &ae4->ae4cmd_q[chan->id];
   232			cmd_q = &ae4cmd_q->cmd_q;
   233			mutex_lock(&ae4cmd_q->cmd_lock);
   234			list_add_tail(&pt_cmd->entry, &ae4cmd_q->cmd);
   235			mutex_unlock(&ae4cmd_q->cmd_lock);
   236		}
   237	
   238		return desc;
   239	}
   240	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

