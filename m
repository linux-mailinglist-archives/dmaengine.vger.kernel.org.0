Return-Path: <dmaengine+bounces-5100-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49C6AAD82E
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 09:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B69D188AC10
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86E921930A;
	Wed,  7 May 2025 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+Jioq5z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172021C84D6;
	Wed,  7 May 2025 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603111; cv=none; b=gtV4sPCIAuroxt3kQeKgjtpoxffUHCbWLYSTQLFXfZMAwhTx90hO8Ef3/Nm5uE4GxFz1jd0JCRzzZJRP5xoQxJhpIAYggQzGFBQiQlEq56nLz7KHaKJRN5z+xmyTLCLY+WC0NerQVGl3Wn+kjZcOkN90ENX5g1lOjQqCesQwDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603111; c=relaxed/simple;
	bh=0cur8ilifh2WKjNlVxEGKdLdHBX8xWsGsKF2bcY55+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWiQKdLze1ehMbN/r0u0T2DqPl7fDgC0DzxxNb1afkba3ufPawtBd2XTPSjM64UnnIubVi0SGZS4I2POJzC5jlAeIOkBdHZoFy8lfT5AftCt+FJXyEjDknAsTctLyzFbLsn7BihiLV3t3SzP4zcrAfMNZosrW3bNZQEs8nL8iks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+Jioq5z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746603110; x=1778139110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0cur8ilifh2WKjNlVxEGKdLdHBX8xWsGsKF2bcY55+U=;
  b=F+Jioq5zr7qQewoZ3a1JJxXWmsMvMFXeOn6IIW2n0JualFSHEC9jbbuw
   F58CT8rMBtiu29HDqmL1hXqe5RXFi4sOpxcttU1VGwtp/hui24i3qjqzk
   8vn1Wu03W8mzu4S/rLZYg/Pt2DfX7iI2US/WC+rSJwhm9dZqThK1MRlqN
   YHZOy/t6uWFUT11YmsiCHa2aBx5Wu1npt3xD+3DAQO7tVdz3rvKNSZqb7
   w0daGjkXbGcS2LkTySKIxO9QX6kCHQ4i/NZ0AFHgQhuzSOLM4DjkmVOxK
   bWwh76z/71YY/KtGBnpmq61w+5szRA0FJzdXO/tqg2UVU2M1LXPGl5YpQ
   Q==;
X-CSE-ConnectionGUID: 8EKWOhpFRL2/vYrDmYehzg==
X-CSE-MsgGUID: rn/heQAzSIa8letC0iLNYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="35944827"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="35944827"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:31:44 -0700
X-CSE-ConnectionGUID: RSlEYW6FRciUmNy6dTwI/Q==
X-CSE-MsgGUID: FDmAR+czTniIup4AsqAqUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="173064110"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 May 2025 00:31:40 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCZFi-0007JR-10;
	Wed, 07 May 2025 07:31:38 +0000
Date: Wed, 7 May 2025 15:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, peter.ujfalusi@gmail.com,
	vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6/8] dmaengine: ti: New driver for K3 BCDMA_V2
Message-ID: <202505071527.yZZNwWXf-lkp@intel.com>
References: <20250428072032.946008-7-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428072032.946008-7-s-adivi@ti.com>

Hi Sai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.15-rc5]
[cannot apply to next-20250506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sai-Sree-Kartheek-Adivi/dt-bindings-dma-ti-Add-document-for-K3-BCDMA-V2/20250428-152616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20250428072032.946008-7-s-adivi%40ti.com
patch subject: [PATCH 6/8] dmaengine: ti: New driver for K3 BCDMA_V2
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250507/202505071527.yZZNwWXf-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505071527.yZZNwWXf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071527.yZZNwWXf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/ti/k3-udma-v2.c:147:14: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     147 |         int status, ret;
         |                     ^
>> drivers/dma/ti/k3-udma-v2.c:1042:6: warning: variable 'cap2' set but not used [-Wunused-but-set-variable]
    1042 |         u32 cap2, cap3;
         |             ^
>> drivers/dma/ti/k3-udma-v2.c:1042:12: warning: variable 'cap3' set but not used [-Wunused-but-set-variable]
    1042 |         u32 cap2, cap3;
         |                   ^
   3 warnings generated.


vim +/ret +147 drivers/dma/ti/k3-udma-v2.c

   142	
   143	static int udma_v2_start(struct udma_chan *uc)
   144	{
   145		struct virt_dma_desc *vd = vchan_next_desc(&uc->vc);
   146		struct udma_dev *ud = uc->ud;
 > 147		int status, ret;
   148	
   149		if (!vd) {
   150			uc->desc = NULL;
   151			return -ENOENT;
   152		}
   153	
   154		list_del(&vd->node);
   155	
   156		uc->desc = to_udma_desc(&vd->tx);
   157	
   158		/* Channel is already running and does not need reconfiguration */
   159		if (udma_is_chan_running(uc) && !udma_chan_needs_reconfiguration(uc)) {
   160			udma_start_desc(uc);
   161			goto out;
   162		}
   163	
   164		/* Make sure that we clear the teardown bit, if it is set */
   165		ud->udma_reset_chan(uc, false);
   166	
   167		/* Push descriptors before we start the channel */
   168		udma_start_desc(uc);
   169	
   170		switch (uc->desc->dir) {
   171		case DMA_DEV_TO_MEM:
   172			/* Config remote TR */
   173			if (uc->config.ep_type == PSIL_EP_PDMA_XY) {
   174				u32 val = PDMA_STATIC_TR_Y(uc->desc->static_tr.elcnt) |
   175					  PDMA_STATIC_TR_X(uc->desc->static_tr.elsize);
   176				const struct udma_match_data *match_data =
   177								uc->ud->match_data;
   178	
   179				if (uc->config.enable_acc32)
   180					val |= PDMA_STATIC_TR_XY_ACC32;
   181				if (uc->config.enable_burst)
   182					val |= PDMA_STATIC_TR_XY_BURST;
   183	
   184				udma_chanrt_write(uc,
   185						   UDMA_CHAN_RT_STATIC_TR_XY_REG,
   186						   val);
   187	
   188				udma_chanrt_write(uc,
   189					UDMA_CHAN_RT_STATIC_TR_Z_REG,
   190					PDMA_STATIC_TR_Z(uc->desc->static_tr.bstcnt,
   191							 match_data->statictr_z_mask));
   192	
   193				/* save the current staticTR configuration */
   194				memcpy(&uc->static_tr, &uc->desc->static_tr,
   195				       sizeof(uc->static_tr));
   196			}
   197	
   198			udma_chanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
   199					UDMA_CHAN_RT_CTL_EN | UDMA_CHAN_RT_CTL_AUTOPAIR);
   200	
   201			/* Poll for autopair completion */
   202			ret = read_poll_timeout_atomic(udma_v2_check_chan_autopair_completion,
   203					status, status != 0, 100, 500, false, uc);
   204	
   205			if (status <= 0)
   206				return -ETIMEDOUT;
   207	
   208			break;
   209		case DMA_MEM_TO_DEV:
   210			/* Config remote TR */
   211			if (uc->config.ep_type == PSIL_EP_PDMA_XY) {
   212				u32 val = PDMA_STATIC_TR_Y(uc->desc->static_tr.elcnt) |
   213					  PDMA_STATIC_TR_X(uc->desc->static_tr.elsize);
   214	
   215				if (uc->config.enable_acc32)
   216					val |= PDMA_STATIC_TR_XY_ACC32;
   217				if (uc->config.enable_burst)
   218					val |= PDMA_STATIC_TR_XY_BURST;
   219	
   220				udma_chanrt_write(uc,
   221						   UDMA_CHAN_RT_STATIC_TR_XY_REG,
   222						   val);
   223	
   224				/* save the current staticTR configuration */
   225				memcpy(&uc->static_tr, &uc->desc->static_tr,
   226				       sizeof(uc->static_tr));
   227			}
   228	
   229			udma_chanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
   230					UDMA_CHAN_RT_CTL_EN | UDMA_CHAN_RT_CTL_AUTOPAIR);
   231	
   232			/* Poll for autopair completion */
   233			ret = read_poll_timeout_atomic(udma_v2_check_chan_autopair_completion,
   234					status, status != 0, 100, 500, false, uc);
   235	
   236			if (status <= 0)
   237				return -ETIMEDOUT;
   238	
   239			break;
   240		case DMA_MEM_TO_MEM:
   241			udma_bchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
   242					   UDMA_CHAN_RT_CTL_EN);
   243			udma_bchanrt_write(uc, UDMA_CHAN_RT_CTL_REG,
   244					   UDMA_CHAN_RT_CTL_EN);
   245	
   246			break;
   247		default:
   248			return -EINVAL;
   249		}
   250	
   251		uc->state = UDMA_CHAN_IS_ACTIVE;
   252	out:
   253	
   254		return 0;
   255	}
   256	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

