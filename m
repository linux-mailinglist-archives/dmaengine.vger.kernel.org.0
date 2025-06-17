Return-Path: <dmaengine+bounces-5519-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E103AADCD09
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C2D16F557
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 13:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20DC2E7175;
	Tue, 17 Jun 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWgz2FZ7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CCC2DE215;
	Tue, 17 Jun 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166561; cv=none; b=SlT4g02HsO0VvK+DIcKtvYtoSs0CBwnmo6r9s+VTrH5CHdAppRfLsaaeDURSQYq/DjXFvikiT+QrvDSNf6H+JaiiBjuXKFTRBDKtEcyzk9jpOujBBR5CMihVqX2dEhCvcjDSauEvRPtFbTeTDw2fBPIX7GTEuAzydmBOTIzmnN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166561; c=relaxed/simple;
	bh=mtfjAvMUwVQD5LjcQAMrNSUEtO+aja2BRtG/zJIG5z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv/kRKEM7iAt5Yz0ZnvCkqxxFV/ECQKd3f2fpoyMVGqfGVypajUevfhIDAQGUHYoIorU0Kz7FvVaP80IYSJpl6kO7oGaTZWpptNStGVH58NYaxCSc79Dk4MZoMcsRAVpBJYRx5iHjNpzjoKuJkfLM+mOljVUp5W4zkikb1qyr/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWgz2FZ7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750166560; x=1781702560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mtfjAvMUwVQD5LjcQAMrNSUEtO+aja2BRtG/zJIG5z0=;
  b=SWgz2FZ7mYa+2fN0ox3zGTKpjvixVT933VU95CUFU7S/udXr4jfawiTO
   aBfk14NN1+QBH/e9+9hR3b/nIhwLPb18Xv7XuOAMZK5lYuo27Uyb9aTtP
   ckLGBoZVoIi3enuLUp9Mkb8qUbc0Mhg02DX3HMam7enjBjenBQgqNdChl
   RsnuyRNxtdqbNkuzS+Huows+73SeXBxyQST/92KjuILnesWgs08XitExi
   UCZSWVOfXsZqqGq7BCBlHQPfxCLNdhhOlN2CwaXG3LIDcmTjsLal/7Jcy
   rZAWw3ejYqwB5QgPIztiJrsqOxM3RwiVZt0eb0NOS9oAZN57/rWDJMVuc
   w==;
X-CSE-ConnectionGUID: 9cZuZeB9QNONjCqqVAhkCQ==
X-CSE-MsgGUID: rd7eD+9+TpWGuhoezry+5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52258087"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52258087"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 06:22:39 -0700
X-CSE-ConnectionGUID: uy6Q+LdwR5yrR8Ci8N/CHQ==
X-CSE-MsgGUID: JQsHNTR2RhmPrB4ibjx/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="149671821"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Jun 2025 06:22:32 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRWGk-000G0i-1S;
	Tue, 17 Jun 2025 13:22:30 +0000
Date: Tue, 17 Jun 2025 21:21:52 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Kochetkov <al.kochet@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, Nishad Saraf <nishads@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Jacky Huang <ychuang3@nuvoton.com>,
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
Message-ID: <202506172123.A2I5Sxtj-lkp@intel.com>
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
config: sh-kismet-CONFIG_COMMON_CLK-CONFIG_MFD_INTEL_LPSS-0-0 (https://download.01.org/0day-ci/archive/20250617/202506172123.A2I5Sxtj-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250617/202506172123.A2I5Sxtj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506172123.A2I5Sxtj-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for COMMON_CLK when selected by MFD_INTEL_LPSS
   WARNING: unmet direct dependencies detected for COMMON_CLK
     Depends on [n]: !HAVE_LEGACY_CLK [=y]
     Selected by [y]:
     - MFD_INTEL_LPSS [=y] && HAS_IOMEM [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

