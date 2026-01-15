Return-Path: <dmaengine+bounces-8271-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B2AD2402F
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 11:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A37BE302A3B9
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 10:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5736D4F0;
	Thu, 15 Jan 2026 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuVr/n/y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA84236C0D0;
	Thu, 15 Jan 2026 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473963; cv=none; b=K5E3ROTQcvQlL30jQwOJruF2VRvag+hnLUpjvDvzkXyB8mv++HO55JyA34/s89cvtfRa20ubAeO2H72bnz5kQXBuZpgzfiLNml4BDkhf1I3lFWhJ0cWVFCQJBMmsubjBpro1/hMD45AdLb1jvPqfA7n/VmbSWwqG6n0ZNrAt6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473963; c=relaxed/simple;
	bh=AYhbb/ilK8QiUl3qPi2RlveC6/IIr877+41kLSNmhVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh/smABtNKOEIoZrDqsv4IX5mVQbgmGU/+3fWW+Gz8D4LAPOxQGOwFdda4EqJCCiFjQ42UU9GKiTi/D+MOIz6x4b/xoyhym75hzLixnUaJ+5X9aP27zZ7sWtKt197IKtFR9jukmWAxRkY7fuqHjMrACnyMlVyY148nAJwrGow5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuVr/n/y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768473962; x=1800009962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AYhbb/ilK8QiUl3qPi2RlveC6/IIr877+41kLSNmhVc=;
  b=HuVr/n/yKo7aLF6F15RiZbzIq3lpfOFZwjZTseKlaJ6pLm8TuIzTwtMk
   dG+xUiLMuC4rcFCizt+eTwUJUQzoGh0CSLwKTDQxlUspIadqdNu4tMcQK
   QLbgbWlHP6dqtd2A1syW0pmAV3Kz8Jl+MNEYh8WFtrhCcHTOJZCZBmJi4
   R66F1GsSfeR2mi4vx6Alef9Ir38dybNHonURg1hVbfZN3HMwfpyKAtO3x
   S/3+BVFaIGBK313IwyvrY8vavNQYH404mBgPZyydP4VKwOKBXUYD07AC8
   wqAYrmgEPhyODeUW4qTFDu+rw83Ln7sMR7NBVXQxvZY78DWNqcY/1fYQl
   A==;
X-CSE-ConnectionGUID: 89JSBNa9QsqMs4JF6oToLQ==
X-CSE-MsgGUID: /ehewHEUQhWNGOdg3EUYCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80499593"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="80499593"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 02:46:01 -0800
X-CSE-ConnectionGUID: cA0Rcv7TT72BfFOxDGNZAQ==
X-CSE-MsgGUID: Z/vQEeZqQIa3gYUaCCFDmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="204956903"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Jan 2026 02:45:58 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgKrU-00000000HrI-0DgH;
	Thu, 15 Jan 2026 10:45:56 +0000
Date: Thu, 15 Jan 2026 18:45:06 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 01/13] dmaengine: of_dma: Add
 devm_of_dma_controller_register()
Message-ID: <202601151857.D1ikP7GO-lkp@intel.com>
References: <20260114-mxsdma-module-v1-1-9b2a9eaa4226@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-mxsdma-module-v1-1-9b2a9eaa4226@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-of_dma-Add-devm_of_dma_controller_register/20260115-063955
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20260114-mxsdma-module-v1-1-9b2a9eaa4226%40nxp.com
patch subject: [PATCH 01/13] dmaengine: of_dma: Add devm_of_dma_controller_register()
config: x86_64-randconfig-161-20260115 (https://download.01.org/0day-ci/archive/20260115/202601151857.D1ikP7GO-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
smatch version: v0.5.0-8985-g2614ff1a
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601151857.D1ikP7GO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601151857.D1ikP7GO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/dma/dmaengine.c:54:
>> include/linux/of_dma.h:88:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
      87 | static inline
         | ~~~~~~~~~~~~~
         | int
      88 | devm_of_dma_controller_register(struct device *dev, struct device_node *np,
         | ^
   1 error generated.


vim +/int +88 include/linux/of_dma.h

    86	
    87	static inline
  > 88	devm_of_dma_controller_register(struct device *dev, struct device_node *np,
    89					struct dma_chan *(*of_dma_xlate)
    90					(struct of_phandle_args *, struct of_dma *),
    91					void *data)
    92	{
    93		return -ENODEV;
    94	}
    95	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

