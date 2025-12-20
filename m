Return-Path: <dmaengine+bounces-7854-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B0CD3500
	for <lists+dmaengine@lfdr.de>; Sat, 20 Dec 2025 19:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B9F300D143
	for <lists+dmaengine@lfdr.de>; Sat, 20 Dec 2025 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5103830E822;
	Sat, 20 Dec 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+2V9U4i"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635D233134;
	Sat, 20 Dec 2025 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766254963; cv=none; b=VwZJqLDDcJ9fkEBRJanuM1zIbwgcX+yTjLR3OrOQG6V4D3BFaj4f+Aq2OsW1TiA5z6rhEdRr+HXmiFTt+F0StSzggW3XdSYVKm0AXzub0yyaTP6VpS3sak7guKAI8CQb7qXj8c85naPAkONK07WMvIhQSl426NwjHOGiT2hPTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766254963; c=relaxed/simple;
	bh=jwD9JF1XWRo08bLaqC1IP6DQSrv2Y2f69IjjEBAuUTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVFxEyDyECWc/+XFBenWFciMKdBFJxIFWEAaxgntJGLaPfeF+WDSv5F1jU3a6qa6CFu9FWPZXBmotnximDO5AeZTZVo1V8Rt5TD35A4NBpFpWM2oe4rDDJNladPkn++ISYXy7ZSR49HobeAWdJpr0jIzwtKzyhO5pLGmf4XctE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+2V9U4i; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766254961; x=1797790961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jwD9JF1XWRo08bLaqC1IP6DQSrv2Y2f69IjjEBAuUTs=;
  b=X+2V9U4ilXZ62z4oprkds/3ER5YR9WVfFjSoD29UzAeArVOtQRdIgbEZ
   I51pkoIyt4L/HQ64EPpYSBJcz2iM2POZOCmKc47X3SlMuh21ADDTOtTwF
   SQbRR+gkbzg/7YxmGxBoJSsjfBjMDneVH+jWlpm17lSeY6CWKWtygE/Hw
   623cuo6vrfDi4z/oUvF4OjQlIjDvqKL4z6K6Dou9srgXPx9symKe0uCGq
   CEQTCUtvMAKT/6p7gG1h8iOew58nm1dlHDBMGLi9Vu6qwiA9XwqxwFXRv
   XWTJcIYbFUc4uffslPTQJCd0emlPCEEpkAKiQ0ELr9zFaswU+QrUvMmMy
   g==;
X-CSE-ConnectionGUID: Woa9krmbSCiVYfBpU+hFKg==
X-CSE-MsgGUID: /qBsMdQ1SAKHdjVnY9v7HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="68334610"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="68334610"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 10:22:41 -0800
X-CSE-ConnectionGUID: eZWzadxLTG6eqk7+ipkMVQ==
X-CSE-MsgGUID: 7F/cbxTQSpuWktK5vEPTeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="236556869"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Dec 2025 10:22:38 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX1b9-0000000050X-00FL;
	Sat, 20 Dec 2025 18:22:35 +0000
Date: Sun, 21 Dec 2025 02:21:44 +0800
From: kernel test robot <lkp@intel.com>
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-amlogic@lists.infradead.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH 2/3] dma: amlogic: Add general DMA driver for SoCs
Message-ID: <202512210111.1UZxHivt-lkp@intel.com>
References: <20251216-amlogic-dma-v1-2-e289e57e96a7@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-amlogic-dma-v1-2-e289e57e96a7@amlogic.com>

Hi Xianwei,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Xianwei-Zhao-via-B4-Relay/dt-bindings-dma-Add-Amlogic-general-DMA/20251216-163238
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20251216-amlogic-dma-v1-2-e289e57e96a7%40amlogic.com
patch subject: [PATCH 2/3] dma: amlogic: Add general DMA driver for SoCs
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20251221/202512210111.1UZxHivt-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210111.1UZxHivt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210111.1UZxHivt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/dma/amlogic-dma.c:132:41: error: argument 'chan_ns' to the 'counted_by' attribute is not a field declaration in the same structure as 'aml_chans'
     132 |         struct aml_dma_chan             aml_chans[]__counted_by(chan_ns);
         |                                         ^~~~~~~~~


vim +132 drivers/dma/amlogic-dma.c

   120	
   121	struct aml_dma_dev {
   122		struct dma_device		dma_device;
   123		void __iomem			*base;
   124		struct regmap			*regmap;
   125		struct clk			*clk;
   126		int				irq;
   127		struct platform_device		*pdev;
   128		struct aml_dma_chan		*aml_rch[MAX_CHAN_ID];
   129		struct aml_dma_chan		*aml_wch[MAX_CHAN_ID];
   130		unsigned int			chan_nr;
   131		unsigned int			chan_used;
 > 132		struct aml_dma_chan		aml_chans[]__counted_by(chan_ns);
   133	};
   134	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

