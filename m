Return-Path: <dmaengine+bounces-6915-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2A2BF691A
	for <lists+dmaengine@lfdr.de>; Tue, 21 Oct 2025 14:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D4F407079
	for <lists+dmaengine@lfdr.de>; Tue, 21 Oct 2025 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958E6333727;
	Tue, 21 Oct 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxsK1kQM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E62F2619;
	Tue, 21 Oct 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051374; cv=none; b=birP8lmglh9IvqXx6Dg13D8kZEphRrh0rQNu7oyZOI9puKymD+MT9zP7Vide2L+gcANjZCp9Ore6NfU03DS31LKutG9xYE/TFJLN4AIhNHZ6FkZFdwbtLc1+VFOGXq1filFqmrceskqMmfRsDwSAJ6ljB8eOviMvu1gg8Fy5loY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051374; c=relaxed/simple;
	bh=+CO+/an1hiocjSGMGzZYAKHx4UcThwwf4NGM2r5oRxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFg8EJM7MBdJqQn6CpzvHMZioBo2JthXAwS53JBpb0C8M+U/OhEhgYTu7DCZkoYruv4ffG6mTk2OT1K6JQkhPbQz0NI/iwOzHSCf9Wi9QW+FNjQrsL6Wt4I/bYLgsP0mc/9FB6HMbpRMFRgxnqAdDs8snPvvcSvvz/bPs6c7/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxsK1kQM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761051373; x=1792587373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+CO+/an1hiocjSGMGzZYAKHx4UcThwwf4NGM2r5oRxc=;
  b=RxsK1kQMpNNwkTSt8tnwbuqfdOt8sseF4XYKpkt6nUa4sh9MDbJDIDmP
   8aK60dAnuU5jnKd1SvkcrkJLGCAZGF9fAdYu2ug1iI4CMhu/1hg8SN2Kx
   zm1dHgZnH7HmwpXpXY/z7U1DIZt53XsiSJvh+U6tZ9UMWSe81Rs74hXsd
   cMcII6FLEuNsdDBMARJrlfBljkWsjF2866SQkfX59AV4mxC16DCdouGQ5
   wkpauo6zy/z8D5tsqUvLEw/i9NmFpQKgUm+gSDIY0D2i829goM1rWaclp
   GuDCwMTZyM9EXZ79jgkhBHRcc6CxN75hBmqL4B2XkckyV5Fm/Nw12M9sG
   g==;
X-CSE-ConnectionGUID: ZiJEx3DmTMK+kAbMXBxPCg==
X-CSE-MsgGUID: pUlZgJ3qQMuBqUojy/Ap5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62205843"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="62205843"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:56:12 -0700
X-CSE-ConnectionGUID: BxovcXqjQZemzDJ3BcibFQ==
X-CSE-MsgGUID: qYr8i8VcSOqS+siN1Hg8+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="183443263"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 Oct 2025 05:56:08 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBBuI-000App-0T;
	Tue, 21 Oct 2025 12:56:06 +0000
Date: Tue, 21 Oct 2025 20:55:47 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-sunxi@lists.linux.dev,
	linux-sound@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] ASoC: sun4i-spdif: Support SPDIF output on A523
 family
Message-ID: <202510212039.XiolKgXp-lkp@intel.com>
References: <20251020171059.2786070-5-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020171059.2786070-5-wens@kernel.org>

Hi Chen-Yu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sunxi/sunxi/for-next]
[also build test WARNING on broonie-sound/for-next vkoul-dmaengine/next linus/master v6.18-rc2 next-20251021]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/dt-bindings-dma-allwinner-sun50i-a64-dma-Add-compatibles-for-A523/20251021-011340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
patch link:    https://lore.kernel.org/r/20251020171059.2786070-5-wens%40kernel.org
patch subject: [PATCH 04/11] ASoC: sun4i-spdif: Support SPDIF output on A523 family
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20251021/202510212039.XiolKgXp-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 754ebc6ebb9fb9fbee7aef33478c74ea74949853)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251021/202510212039.XiolKgXp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510212039.XiolKgXp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: sound/soc/sunxi/sun4i-spdif.c:180 struct member 'mclk_multiplier' not described in 'sun4i_spdif_quirks'
>> Warning: sound/soc/sunxi/sun4i-spdif.c:180 struct member 'tx_clk_name' not described in 'sun4i_spdif_quirks'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

