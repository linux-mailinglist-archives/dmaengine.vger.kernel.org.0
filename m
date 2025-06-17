Return-Path: <dmaengine+bounces-5516-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F359AADC85A
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 12:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C013B7B9A
	for <lists+dmaengine@lfdr.de>; Tue, 17 Jun 2025 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318FA290BD5;
	Tue, 17 Jun 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDY1hF9T"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E215296151;
	Tue, 17 Jun 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750156407; cv=none; b=YRUPjpnBZmdmM6gNdvuF1nrpKENAN906CFW94h1VaFLdDeu0q2St8I6nndBBb28YKN8T9B9sOsBptfJJJ+cP5RBh9QGAgKHHtzYFUd62E5SUXcwJVwnonMMm9XwfkiYRF3eIKIS8gJf+mBTWyznKUQI76x6Arrbx/OLzaTyjTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750156407; c=relaxed/simple;
	bh=WsA1pcPyl3CyLxsXc8aBLN/G/mSkAPdRu5xXeb+nmuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Scfj3Y/bpRiDdfW4n7WV5ZSkdljcl9N6HIKg9FlcbEI0CJ1Jl4HG3I4lpgY5Uoeuhp5og1V0VZEziFgYnvLKVhKFbvuDgXsIufOYWRdV67qF1bmA6fioWZyZ0eQ4Yi5ago09ExrRNQwH8d/CuEzC9MIifCcTBwIyccJe3WtHqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDY1hF9T; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750156406; x=1781692406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WsA1pcPyl3CyLxsXc8aBLN/G/mSkAPdRu5xXeb+nmuA=;
  b=IDY1hF9T7jHmCkiLU0snRg84fD0DqFT5LHe9uqCPdcPxmA+fiPuftyMe
   U6Hg5DDBPZDsgvksnBYnDxQSojEEGapNEp3vqhq1GvNalrQH+7v3o5CKH
   4Zv6Hc5/bYz9LZ/ZzX2LN+Og4WTHBbIEpuyGCTPJco4RPwWAaHatU3F8r
   kiZBCqBeqk2BB8/2BxuNkBJETGqKMXMDeV3lckfxZYOQUG2e9pJF7Xov7
   Wrpa2oCCGLtgidAuBdFZQRd3duST3Zox0BfpFfimoJAx2ZRArG6hBcnxN
   woLsDVAwMqBGQ70Mo1fG3+BZkq/axKHOJwHvMcvyGCgBb4JGr7tfyg8aj
   A==;
X-CSE-ConnectionGUID: f73QTcp6SsWhYuARvKnuTA==
X-CSE-MsgGUID: tTzBr/iqRxe7QrLoYNBZTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="39932637"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="39932637"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 03:33:25 -0700
X-CSE-ConnectionGUID: TRED8RPnRTCLmLfR7kSwvA==
X-CSE-MsgGUID: Mu+pwlVtRCqC1B+PxwbUMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="149627521"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 17 Jun 2025 03:33:16 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRTcw-000Ft6-08;
	Tue, 17 Jun 2025 10:33:14 +0000
Date: Tue, 17 Jun 2025 18:32:24 +0800
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
Message-ID: <202506171823.CHs69U2q-lkp@intel.com>
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
config: arm64-kismet-CONFIG_TI_K3_RINGACC-CONFIG_TI_K3_UDMA-0-0 (https://download.01.org/0day-ci/archive/20250617/202506171823.CHs69U2q-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250617/202506171823.CHs69U2q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506171823.CHs69U2q-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for TI_K3_RINGACC when selected by TI_K3_UDMA
   WARNING: unmet direct dependencies detected for TI_K3_RINGACC
     Depends on [n]: SOC_TI [=n] && (ARCH_K3 [=n] || COMPILE_TEST [=y]) && TI_SCI_INTA_IRQCHIP [=y]
     Selected by [y]:
     - TI_K3_UDMA [=y] && DMADEVICES [=y] && (ARCH_K3 [=n] || COMPILE_TEST [=y]) && TI_SCI_PROTOCOL [=y] && TI_SCI_INTA_IRQCHIP [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

