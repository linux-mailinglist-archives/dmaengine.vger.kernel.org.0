Return-Path: <dmaengine+bounces-6376-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B00B4312F
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 06:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C767C14DD
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 04:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641226E717;
	Thu,  4 Sep 2025 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqcJTkuX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2BB26D4DE;
	Thu,  4 Sep 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960358; cv=none; b=mvanAcDC8YXwbnqEpnZHr76FQK7V11CQXsWZxIi+Ty2bQ6FcKsIt/2RiPC+o2TNMG7rSirhy3Zx8UFGeZEpQOHyEBiddMBXuXFuv89lTeRdzKB1K91r/89kfGvuEAf0HTqhHJ7+tvA1tG2b+hyNDvJiq7GD1OHMPvwEtnGIvRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960358; c=relaxed/simple;
	bh=M5TwpNr55usP9Sz8MApwPf1Fs9RyfM3185mpZDbrJyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6jvo0iU1FgjCFua+y2bxdEmviKq2WHN8fxmGc5Su6shKS4mKacgpT9O7m3gb+OyrT+hAb1yyOcDOdzSHjqYkHUqnWv9WeF8YcZozErXyb6/hQRJgCqvWbfNC3cxoYPxopl+gJQZNEoDQ2j0tOERGS+xCQapriq+wwfPsGEhHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqcJTkuX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756960357; x=1788496357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M5TwpNr55usP9Sz8MApwPf1Fs9RyfM3185mpZDbrJyc=;
  b=mqcJTkuXkG6TAKpsUZQp7ZNebQXjjMWqXHRebLew2nFfPyQJiXKFoAAz
   4peVl4egnB+/mVrfgM+y8jSR4lsc3fPwlt0n2dCPoHXJ8BNOEZ8ID2e7V
   5z6ohE3luqmE3jAIpc+0yDcWmL4bAyyKJDn9ygmkuo17MZSuX2YuSvD8v
   8ztz4/eHE+DxIf8JZY8A9WIHzMqOSS46O5UiEHLa5ak4XV5Df34L7RdXA
   63Facm6hs+wSsADhDN/YZBwD5b+ygCeIHPifZi4jKMp+6OrBdknBI+I1B
   2nI0tQJDlAuLllFFr82Az24m3R7fzlw9dK2R4eOPiRbBs1DnGs1amnNlk
   A==;
X-CSE-ConnectionGUID: EM46VKQlQ9aI52wa5vYnbw==
X-CSE-MsgGUID: uonlUqdnTB6UMnIFMx+cCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59204240"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59204240"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 21:32:36 -0700
X-CSE-ConnectionGUID: AbAUldJwTX65zWZ58P+kng==
X-CSE-MsgGUID: asiFdFQmTLGNLDtAmDZW5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="202625452"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 03 Sep 2025 21:32:34 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uu1eA-0004kZ-2S;
	Thu, 04 Sep 2025 04:32:30 +0000
Date: Thu, 4 Sep 2025 12:31:55 +0800
From: kernel test robot <lkp@intel.com>
To: Marco Felsch <m.felsch@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH 11/11] dmaengine: imx-sdma: fix spba-bus handling for
 i.MX8M
Message-ID: <202509041238.qCKW7MeD-lkp@intel.com>
References: <20250903-v6-16-topic-sdma-v1-11-ac7bab629e8b@pengutronix.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-v6-16-topic-sdma-v1-11-ac7bab629e8b@pengutronix.de>

Hi Marco,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 038d61fd642278bab63ee8ef722c50d10ab01e8f]

url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Felsch/dmaengine-imx-sdma-drop-legacy-device_node-np-check/20250903-212133
base:   038d61fd642278bab63ee8ef722c50d10ab01e8f
patch link:    https://lore.kernel.org/r/20250903-v6-16-topic-sdma-v1-11-ac7bab629e8b%40pengutronix.de
patch subject: [PATCH 11/11] dmaengine: imx-sdma: fix spba-bus handling for i.MX8M
config: arm-randconfig-002-20250904 (https://download.01.org/0day-ci/archive/20250904/202509041238.qCKW7MeD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250904/202509041238.qCKW7MeD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509041238.qCKW7MeD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/dma/imx-sdma.c:477 struct member 'spba_start_addr' not described in 'sdma_channel'
>> Warning: drivers/dma/imx-sdma.c:477 struct member 'spba_end_addr' not described in 'sdma_channel'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

