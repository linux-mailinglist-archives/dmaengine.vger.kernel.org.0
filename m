Return-Path: <dmaengine+bounces-5511-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21337ADC68C
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 11:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1F0189A71B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38894295510;
	Tue, 17 Jun 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dh9o0Bj9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8EF2957CD;
	Tue, 17 Jun 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152682; cv=none; b=H6OqrWselGYmqtQYO1V3EAaSws5n7ZJJ9OMoUljz3M84VrCAHt1bokSYyfp1L+68xxQV8rxvdukNG9TGRcdISXACWBVjNzQQLe86lM7XO9LIg7KVkQ98g7o3nVdm47FI341/gIsY6hmdWTOagEQhwS3AcERObvI9yGKg2cl3AwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152682; c=relaxed/simple;
	bh=GZlLgUIl5lOWdd+wFiEVFZna3MNtcvJ7P2PYvJaY+FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3BALZuOBTnqGrSq8aIfcmbbDMkZToaQAexG7cvK2PRc/x1/k6k4PZrPivhfmcEGGD+DFmB9rRD6xoYwpFC//49e15J2QHmhbCmRfoDLIJmTqU0yVQzBLf7RnZIkjsclivUO7e9185TQftwSJAWsohZ3mh7EEPc0SHDWFSGHX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dh9o0Bj9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750152680; x=1781688680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GZlLgUIl5lOWdd+wFiEVFZna3MNtcvJ7P2PYvJaY+FU=;
  b=Dh9o0Bj94Se9wiuwr+75jV761XywJTLwfu2+qjGiXISRi4sFKe/tQkC4
   shv+Eo1sVDFFashk9491E5LzRij76IPX9hAvECOWC06iKZ0+0TDfzq6xZ
   yRbI8CmaP7CZhUGVg31Z7xZQPtDjqgWuVnvG4xT/s46bN3o6IS5NhM02A
   ngEYX2GKqZA1uC6bWe4EGAXwkZKT56OFkmQ6SjQKZYQ/YYnd61z8LIkYp
   YYsB1tMjQmA0iADoLLIW/Zp+3c6L7xaSCUD6j0lXH/GE/J8a9RFuyC/yd
   BRFSeEZknDahggabP5BDwGww/HWJZLcvN0kI3LeFrRjw0PKNgy4zIf8NO
   w==;
X-CSE-ConnectionGUID: 7wGZd00NS4ahmPq8ZyuIYg==
X-CSE-MsgGUID: yEPzzcG8Qv+J11ga3K6TSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="39927600"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="39927600"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 02:31:19 -0700
X-CSE-ConnectionGUID: BfJ+WOBxTtG//SOiMxqeyw==
X-CSE-MsgGUID: KqJpLp2pS525asif6M3Vaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="154023430"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 17 Jun 2025 02:31:11 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRSeq-000FpR-2Y;
	Tue, 17 Jun 2025 09:31:08 +0000
Date: Tue, 17 Jun 2025 17:30:13 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Kochetkov <al.kochet@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nishad Saraf <nishads@amd.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Andy Shevchenko <andy@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 2/2] !!! TESTING ONLY !!! Allow compile virt-dma users
 on ARM64 platform
Message-ID: <202506171615.p1kpBZuQ-lkp@intel.com>
References: <20250616124934.141782-3-al.kochet@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616124934.141782-3-al.kochet@gmail.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on shawnguo/for-next sunxi/sunxi/for-next lee-mfd/for-mfd-next linus/master v6.16-rc2 next-20250617]
[cannot apply to atorgue-stm32/stm32-next lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Kochetkov/dmaengine-virt-dma-convert-tasklet-to-BH-workqueue-for-callback-invocation/20250616-205118
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20250616124934.141782-3-al.kochet%40gmail.com
patch subject: [PATCH v2 2/2] !!! TESTING ONLY !!! Allow compile virt-dma users on ARM64 platform
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250617/202506171615.p1kpBZuQ-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250617/202506171615.p1kpBZuQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506171615.p1kpBZuQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/qcom/qcom_adm.c:245:7: error: incompatible pointer types assigning to 'u32 *' (aka 'unsigned int *') from 'phys_addr_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     245 |                 src = &achan->slave.src_addr;
         |                     ^ ~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/qcom/qcom_adm.c:251:7: error: incompatible pointer types assigning to 'u32 *' (aka 'unsigned int *') from 'phys_addr_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     251 |                 dst = &achan->slave.dst_addr;
         |                     ^ ~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/qcom/qcom_adm.c:309:7: error: incompatible pointer types assigning to 'u32 *' (aka 'unsigned int *') from 'phys_addr_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     309 |                 src = &achan->slave.src_addr;
         |                     ^ ~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/qcom/qcom_adm.c:313:7: error: incompatible pointer types assigning to 'u32 *' (aka 'unsigned int *') from 'phys_addr_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     313 |                 dst = &achan->slave.dst_addr;
         |                     ^ ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma/qcom/qcom_adm.c:848:59: warning: implicit conversion from 'unsigned long' to 'unsigned int' changes value from 18446744072371568648 to 2956984328 [-Wconstant-conversion]
     848 |         writel(ADM_CI_RANGE_START(0x40) | ADM_CI_RANGE_END(0xb0) |
         |         ~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
     849 |                ADM_CI_BURST_8_WORDS, adev->regs + ADM_CI_CONF(0));
         |                ~~~~~~~~~~~~~~~~~~~~
   1 warning and 4 errors generated.


vim +848 drivers/dma/qcom/qcom_adm.c

03de6b273805b3 Arnd Bergmann     2021-11-22  745  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  746  static int adm_dma_probe(struct platform_device *pdev)
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  747  {
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  748  	struct adm_device *adev;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  749  	int ret;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  750  	u32 i;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  751  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  752  	adev = devm_kzalloc(&pdev->dev, sizeof(*adev), GFP_KERNEL);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  753  	if (!adev)
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  754  		return -ENOMEM;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  755  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  756  	adev->dev = &pdev->dev;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  757  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  758  	adev->regs = devm_platform_ioremap_resource(pdev, 0);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  759  	if (IS_ERR(adev->regs))
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  760  		return PTR_ERR(adev->regs);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  761  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  762  	adev->irq = platform_get_irq(pdev, 0);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  763  	if (adev->irq < 0)
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  764  		return adev->irq;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  765  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  766  	ret = of_property_read_u32(pdev->dev.of_node, "qcom,ee", &adev->ee);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  767  	if (ret) {
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  768  		dev_err(adev->dev, "Execution environment unspecified\n");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  769  		return ret;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  770  	}
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  771  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  772  	adev->core_clk = devm_clk_get(adev->dev, "core");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  773  	if (IS_ERR(adev->core_clk))
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  774  		return PTR_ERR(adev->core_clk);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  775  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  776  	adev->iface_clk = devm_clk_get(adev->dev, "iface");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  777  	if (IS_ERR(adev->iface_clk))
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  778  		return PTR_ERR(adev->iface_clk);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  779  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  780  	adev->clk_reset = devm_reset_control_get_exclusive(&pdev->dev, "clk");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  781  	if (IS_ERR(adev->clk_reset)) {
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  782  		dev_err(adev->dev, "failed to get ADM0 reset\n");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  783  		return PTR_ERR(adev->clk_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  784  	}
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  785  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  786  	adev->c0_reset = devm_reset_control_get_exclusive(&pdev->dev, "c0");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  787  	if (IS_ERR(adev->c0_reset)) {
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  788  		dev_err(adev->dev, "failed to get ADM0 C0 reset\n");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  789  		return PTR_ERR(adev->c0_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  790  	}
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  791  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  792  	adev->c1_reset = devm_reset_control_get_exclusive(&pdev->dev, "c1");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  793  	if (IS_ERR(adev->c1_reset)) {
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  794  		dev_err(adev->dev, "failed to get ADM0 C1 reset\n");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  795  		return PTR_ERR(adev->c1_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  796  	}
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  797  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  798  	adev->c2_reset = devm_reset_control_get_exclusive(&pdev->dev, "c2");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  799  	if (IS_ERR(adev->c2_reset)) {
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  800  		dev_err(adev->dev, "failed to get ADM0 C2 reset\n");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  801  		return PTR_ERR(adev->c2_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  802  	}
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  803  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  804  	ret = clk_prepare_enable(adev->core_clk);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  805  	if (ret) {
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  806  		dev_err(adev->dev, "failed to prepare/enable core clock\n");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  807  		return ret;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  808  	}
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  809  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  810  	ret = clk_prepare_enable(adev->iface_clk);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  811  	if (ret) {
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  812  		dev_err(adev->dev, "failed to prepare/enable iface clock\n");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  813  		goto err_disable_core_clk;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  814  	}
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  815  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  816  	reset_control_assert(adev->clk_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  817  	reset_control_assert(adev->c0_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  818  	reset_control_assert(adev->c1_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  819  	reset_control_assert(adev->c2_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  820  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  821  	udelay(2);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  822  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  823  	reset_control_deassert(adev->clk_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  824  	reset_control_deassert(adev->c0_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  825  	reset_control_deassert(adev->c1_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  826  	reset_control_deassert(adev->c2_reset);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  827  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  828  	adev->channels = devm_kcalloc(adev->dev, ADM_MAX_CHANNELS,
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  829  				      sizeof(*adev->channels), GFP_KERNEL);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  830  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  831  	if (!adev->channels) {
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  832  		ret = -ENOMEM;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  833  		goto err_disable_clks;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  834  	}
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  835  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  836  	/* allocate and initialize channels */
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  837  	INIT_LIST_HEAD(&adev->common.channels);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  838  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  839  	for (i = 0; i < ADM_MAX_CHANNELS; i++)
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  840  		adm_channel_init(adev, &adev->channels[i], i);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  841  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  842  	/* reset CRCIs */
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  843  	for (i = 0; i < 16; i++)
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  844  		writel(ADM_CRCI_CTL_RST, adev->regs +
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  845  			ADM_CRCI_CTL(i, adev->ee));
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  846  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  847  	/* configure client interfaces */
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14 @848  	writel(ADM_CI_RANGE_START(0x40) | ADM_CI_RANGE_END(0xb0) |
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  849  	       ADM_CI_BURST_8_WORDS, adev->regs + ADM_CI_CONF(0));
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  850  	writel(ADM_CI_RANGE_START(0x2a) | ADM_CI_RANGE_END(0x2c) |
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  851  	       ADM_CI_BURST_8_WORDS, adev->regs + ADM_CI_CONF(1));
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  852  	writel(ADM_CI_RANGE_START(0x12) | ADM_CI_RANGE_END(0x28) |
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  853  	       ADM_CI_BURST_8_WORDS, adev->regs + ADM_CI_CONF(2));
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  854  	writel(ADM_GP_CTL_LP_EN | ADM_GP_CTL_LP_CNT(0xf),
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  855  	       adev->regs + ADM_GP_CTL);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  856  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  857  	ret = devm_request_irq(adev->dev, adev->irq, adm_dma_irq,
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  858  			       0, "adm_dma", adev);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  859  	if (ret)
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  860  		goto err_disable_clks;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  861  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  862  	platform_set_drvdata(pdev, adev);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  863  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  864  	adev->common.dev = adev->dev;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  865  	adev->common.dev->dma_parms = &adev->dma_parms;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  866  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  867  	/* set capabilities */
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  868  	dma_cap_zero(adev->common.cap_mask);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  869  	dma_cap_set(DMA_SLAVE, adev->common.cap_mask);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  870  	dma_cap_set(DMA_PRIVATE, adev->common.cap_mask);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  871  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  872  	/* initialize dmaengine apis */
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  873  	adev->common.directions = BIT(DMA_DEV_TO_MEM | DMA_MEM_TO_DEV);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  874  	adev->common.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  875  	adev->common.src_addr_widths = DMA_SLAVE_BUSWIDTH_4_BYTES;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  876  	adev->common.dst_addr_widths = DMA_SLAVE_BUSWIDTH_4_BYTES;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  877  	adev->common.device_free_chan_resources = adm_free_chan;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  878  	adev->common.device_prep_slave_sg = adm_prep_slave_sg;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  879  	adev->common.device_issue_pending = adm_issue_pending;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  880  	adev->common.device_tx_status = adm_tx_status;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  881  	adev->common.device_terminate_all = adm_terminate_all;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  882  	adev->common.device_config = adm_slave_config;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  883  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  884  	ret = dma_async_device_register(&adev->common);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  885  	if (ret) {
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  886  		dev_err(adev->dev, "failed to register dma async device\n");
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  887  		goto err_disable_clks;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  888  	}
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  889  
03de6b273805b3 Arnd Bergmann     2021-11-22  890  	ret = of_dma_controller_register(pdev->dev.of_node, adm_dma_xlate,
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  891  					 &adev->common);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  892  	if (ret)
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  893  		goto err_unregister_dma;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  894  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  895  	return 0;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  896  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  897  err_unregister_dma:
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  898  	dma_async_device_unregister(&adev->common);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  899  err_disable_clks:
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  900  	clk_disable_unprepare(adev->iface_clk);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  901  err_disable_core_clk:
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  902  	clk_disable_unprepare(adev->core_clk);
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  903  
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  904  	return ret;
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  905  }
5c9f8c2dbdbe53 Jonathan McDowell 2020-11-14  906  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

