Return-Path: <dmaengine+bounces-4457-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C384A34039
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2025 14:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB146188C383
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2025 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FCA221733;
	Thu, 13 Feb 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHJ8jx8G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C723F417;
	Thu, 13 Feb 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453080; cv=none; b=BdYE/z8X2/0HmlKfOkyIYCtsFuJ7oY7oJAnOnEIlaHPTK7coAtV9pAr8cbF6U/IvdsLv9Ak90HGk4I+T+UsuWD6KJokrKOXog7YE9qmf0X7EpZTUPaRsvzuqj44pub3B2Hdszq0xpFQArfekJx+4VDP+o3TE4MpnrsPHFzj5vQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453080; c=relaxed/simple;
	bh=XP35AnA2T+WAfWlH155CjBEZAPtv6z1yE0FxKBjSd/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOv1TIasSiVMuGqVCVMA2H6dQG/PrSqhspwmLAIk1U1gSbhwacftG4wfkKlem8qayiN3prDHeOPXtNdliwIAA+ZWCBJGiqfoy4mPF9f1ip/WNJZRHsIwVVuHdGr4/WhIh9F7YqyXzPG9DFzAFdLU1DG8aKb1ElODEftvJTvyiNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHJ8jx8G; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739453078; x=1770989078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XP35AnA2T+WAfWlH155CjBEZAPtv6z1yE0FxKBjSd/Q=;
  b=HHJ8jx8GLJ90Z1RhY6K8TanVopLMbsAYYR1OodGdarThNJom2jm9uJF4
   HGJGZoEZDKtmnWXSi+5DuMKe6v0AnP59U8RQOT+pXGqJDqJktkbGG/P3Y
   t9y6EjxPkPEW+ti2rtGo6nJbuGHaKI4avHLieEw8h/gFwbEBYLAmVaCTV
   l6wUUkce7kI2eYwgVx5dspAMIqvLfqaJn0vBl6mlkBm90OVnMZUf9D6b1
   xUsQL2hkcPQmlT6v9BGstvvrfupo0Gp98yOqRr7mNYy/ynp/fw/Zzum2g
   xwBxTy9DrHJM6xvypJuDJU1DDBBvuFQtB6VYZ61PJflY3y3IYw8GvvXA2
   Q==;
X-CSE-ConnectionGUID: OCVk9lsnRCKCZoqJpC7jYg==
X-CSE-MsgGUID: CekgjrX3Ti6D0NhhkMvA5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40185329"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40185329"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:24:38 -0800
X-CSE-ConnectionGUID: uewYs/I3RhSPZkKw/8disg==
X-CSE-MsgGUID: 3Xh4enoiSliKHRqYVEe59A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112978250"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Feb 2025 05:24:34 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiZCi-00175r-0B;
	Thu, 13 Feb 2025 13:24:32 +0000
Date: Thu, 13 Feb 2025 21:24:08 +0800
From: kernel test robot <lkp@intel.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
Message-ID: <202502132123.1ePmN98r-lkp@intel.com>
References: <20250212221305.431716-7-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212221305.431716-7-fabrizio.castro.jz@renesas.com>

Hi Fabrizio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on geert-renesas-drivers/renesas-clk robh/for-next linus/master v6.14-rc2 next-20250213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabrizio-Castro/clk-renesas-r9a09g057-Add-entries-for-the-DMACs/20250213-061714
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20250212221305.431716-7-fabrizio.castro.jz%40renesas.com
patch subject: [PATCH v2 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
config: powerpc64-randconfig-001-20250213 (https://download.01.org/0day-ci/archive/20250213/202502132123.1ePmN98r-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502132123.1ePmN98r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502132123.1ePmN98r-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/sh/rz-dmac.c:979:15: warning: cast to smaller integer type 'enum rz_dmac_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
     979 |         dmac->type = (enum rz_dmac_type)of_device_get_match_data(dmac->dev);
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +979 drivers/dma/sh/rz-dmac.c

   962	
   963	static int rz_dmac_probe(struct platform_device *pdev)
   964	{
   965		const char *irqname = "error";
   966		struct dma_device *engine;
   967		struct rz_dmac *dmac;
   968		int channel_num;
   969		int ret;
   970		int irq;
   971		u8 i;
   972	
   973		dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
   974		if (!dmac)
   975			return -ENOMEM;
   976	
   977		dmac->dev = &pdev->dev;
   978		platform_set_drvdata(pdev, dmac);
 > 979		dmac->type = (enum rz_dmac_type)of_device_get_match_data(dmac->dev);
   980	
   981		ret = rz_dmac_parse_of(&pdev->dev, dmac);
   982		if (ret < 0)
   983			return ret;
   984	
   985		dmac->channels = devm_kcalloc(&pdev->dev, dmac->n_channels,
   986					      sizeof(*dmac->channels), GFP_KERNEL);
   987		if (!dmac->channels)
   988			return -ENOMEM;
   989	
   990		/* Request resources */
   991		dmac->base = devm_platform_ioremap_resource(pdev, 0);
   992		if (IS_ERR(dmac->base))
   993			return PTR_ERR(dmac->base);
   994	
   995		if (dmac->type == RZ_DMAC_RZG2L) {
   996			dmac->ext_base = devm_platform_ioremap_resource(pdev, 1);
   997			if (IS_ERR(dmac->ext_base))
   998				return PTR_ERR(dmac->ext_base);
   999		} else {
  1000			ret = rz_dmac_parse_of_icu(&pdev->dev, dmac);
  1001			if (ret)
  1002				return ret;
  1003		}
  1004	
  1005		/* Register interrupt handler for error */
  1006		irq = platform_get_irq_byname(pdev, irqname);
  1007		if (irq < 0)
  1008			return irq;
  1009	
  1010		ret = devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
  1011				       irqname, NULL);
  1012		if (ret) {
  1013			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
  1014				irq, ret);
  1015			return ret;
  1016		}
  1017	
  1018		/* Initialize the channels. */
  1019		INIT_LIST_HEAD(&dmac->engine.channels);
  1020	
  1021		dmac->rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
  1022		if (IS_ERR(dmac->rstc))
  1023			return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
  1024					     "failed to get resets\n");
  1025	
  1026		pm_runtime_enable(&pdev->dev);
  1027		ret = pm_runtime_resume_and_get(&pdev->dev);
  1028		if (ret < 0) {
  1029			dev_err(&pdev->dev, "pm_runtime_resume_and_get failed\n");
  1030			goto err_pm_disable;
  1031		}
  1032	
  1033		ret = reset_control_deassert(dmac->rstc);
  1034		if (ret)
  1035			goto err_pm_runtime_put;
  1036	
  1037		for (i = 0; i < dmac->n_channels; i++) {
  1038			ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
  1039			if (ret < 0)
  1040				goto err;
  1041		}
  1042	
  1043		/* Register the DMAC as a DMA provider for DT. */
  1044		ret = of_dma_controller_register(pdev->dev.of_node, rz_dmac_of_xlate,
  1045						 NULL);
  1046		if (ret < 0)
  1047			goto err;
  1048	
  1049		/* Register the DMA engine device. */
  1050		engine = &dmac->engine;
  1051		dma_cap_set(DMA_SLAVE, engine->cap_mask);
  1052		dma_cap_set(DMA_MEMCPY, engine->cap_mask);
  1053		rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
  1054		rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
  1055	
  1056		engine->dev = &pdev->dev;
  1057	
  1058		engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
  1059		engine->device_free_chan_resources = rz_dmac_free_chan_resources;
  1060		engine->device_tx_status = dma_cookie_status;
  1061		engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
  1062		engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
  1063		engine->device_config = rz_dmac_config;
  1064		engine->device_terminate_all = rz_dmac_terminate_all;
  1065		engine->device_issue_pending = rz_dmac_issue_pending;
  1066		engine->device_synchronize = rz_dmac_device_synchronize;
  1067	
  1068		engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
  1069		dma_set_max_seg_size(engine->dev, U32_MAX);
  1070	
  1071		ret = dma_async_device_register(engine);
  1072		if (ret < 0) {
  1073			dev_err(&pdev->dev, "unable to register\n");
  1074			goto dma_register_err;
  1075		}
  1076		return 0;
  1077	
  1078	dma_register_err:
  1079		of_dma_controller_free(pdev->dev.of_node);
  1080	err:
  1081		channel_num = i ? i - 1 : 0;
  1082		for (i = 0; i < channel_num; i++) {
  1083			struct rz_dmac_chan *channel = &dmac->channels[i];
  1084	
  1085			dma_free_coherent(&pdev->dev,
  1086					  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
  1087					  channel->lmdesc.base,
  1088					  channel->lmdesc.base_dma);
  1089		}
  1090	
  1091		reset_control_assert(dmac->rstc);
  1092	err_pm_runtime_put:
  1093		pm_runtime_put(&pdev->dev);
  1094	err_pm_disable:
  1095		pm_runtime_disable(&pdev->dev);
  1096	
  1097		return ret;
  1098	}
  1099	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

