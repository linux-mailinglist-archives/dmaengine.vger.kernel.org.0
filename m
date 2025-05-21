Return-Path: <dmaengine+bounces-5243-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E6AAC00BC
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 01:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1733AC098
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 23:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928A823E325;
	Wed, 21 May 2025 23:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qr9rr0HD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E7523E229;
	Wed, 21 May 2025 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747870898; cv=none; b=IFNGZKPX0G3vpSfgfnGhK0UK8OAPXDtbBon2eCzUJF6wFbZAhIxwm4taeE2iAHEB/paMvhu8jEwk7JAjrUezu7zNx5J2uLj++jL2vTbkUbe4Qnx0n1oSuWg1ZSN4jxvAKjABvAzN3mh6MQbkZD6KPjixC0t78FQt8RVpUcqzYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747870898; c=relaxed/simple;
	bh=dmXBPaP+dUDCyAOUcCFQ6VMDi1A2rED504MmFv/HvAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTCaI29FXFy97/taqDYWoDeh7OP8jL5S3l5chtvJacxDEyhJ5PgGWo1DBMGW8S/kdcrQLWXLGEWknfjc7JcIfK/7e9GWu2AeAueGXRWC5X9W7Tj6j77atJCczOcp8A+rOkzB/NiZYpFVtxVPgS+uDaK295r5aSPnaSbiv0sk7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qr9rr0HD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747870897; x=1779406897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dmXBPaP+dUDCyAOUcCFQ6VMDi1A2rED504MmFv/HvAs=;
  b=Qr9rr0HDKWov/+Q0/NVRtGHnerwKY6vs4Pw6Yj6Ki/L4QhrsVsN3rn8h
   uQSkYzc7WI+V3Wx9tFdK302nrqC8NfrHjX9CKTjrnTah4zeQ/vp6LhuMz
   XM5Woe+XFGSwRLX/GF73WWgsWKom+xHuBh+67NdhLPBOY/5OobxzNoOtv
   70UOEqtk7WsZSuKptfCgY9yT1fu+PDbF3qqvHEu81eLoBM+RPYPtgqtMb
   lKptwtQAeCXVrKPMzkECmn2+jlV6rl6iX7QZSTv3xQmTtu7om5DIxOnzT
   s4a9pDIoLIv4HabfO+3MXufk+oCG/HcPCQKiAnh7+YocCeCt82LNTONe2
   g==;
X-CSE-ConnectionGUID: LL7qSx7KQzCUsJvJ6Aii2A==
X-CSE-MsgGUID: t9d+uEyOQXeQQ35mfQ+sPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="50014404"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="50014404"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 16:41:33 -0700
X-CSE-ConnectionGUID: EZOuNzdTTNKiUHZ2LdKp4A==
X-CSE-MsgGUID: Cu7r3II8RwerSm5FlU65kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140836538"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 May 2025 16:41:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHt3u-000Ojg-18;
	Wed, 21 May 2025 23:41:26 +0000
Date: Thu, 22 May 2025 07:40:29 +0800
From: kernel test robot <lkp@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>, vkoul@kernel.org,
	chenxiang66@hisilicon.com, m.szyprowski@samsung.com,
	robin.murphy@arm.com, leon@kernel.org, jgg@nvidia.com,
	alex.williamson@redhat.com, joel.granados@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH 1/6] fake-dma: add fake dma engine driver
Message-ID: <202505220711.3GeHexsR-lkp@intel.com>
References: <20250520223913.3407136-2-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520223913.3407136-2-mcgrof@kernel.org>

Hi Luis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.15-rc7 next-20250521]
[cannot apply to vkoul-dmaengine/next shuah-kselftest/next shuah-kselftest/fixes sysctl/sysctl-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luis-Chamberlain/fake-dma-add-fake-dma-engine-driver/20250521-064035
base:   linus/master
patch link:    https://lore.kernel.org/r/20250520223913.3407136-2-mcgrof%40kernel.org
patch subject: [PATCH 1/6] fake-dma: add fake dma engine driver
config: alpha-randconfig-r113-20250522 (https://download.01.org/0day-ci/archive/20250522/202505220711.3GeHexsR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250522/202505220711.3GeHexsR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505220711.3GeHexsR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/dma/fake-dma.c:69:24: sparse: sparse: symbol 'single_fake_dma' was not declared. Should it be static?

vim +/single_fake_dma +69 drivers/dma/fake-dma.c

    68	
  > 69	struct fake_dma_device *single_fake_dma;
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

