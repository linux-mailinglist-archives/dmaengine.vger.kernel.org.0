Return-Path: <dmaengine+bounces-6918-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F254BF8EA5
	for <lists+dmaengine@lfdr.de>; Tue, 21 Oct 2025 23:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26453AD7A5
	for <lists+dmaengine@lfdr.de>; Tue, 21 Oct 2025 21:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97234286897;
	Tue, 21 Oct 2025 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaR7OxGX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874A27FD5D;
	Tue, 21 Oct 2025 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081282; cv=none; b=NK9pRNlrULbLrf4bfz9eFLcC9NhSfVqKjBQgD9BCqEy45uvyE4oTOIA2PYPebUzaqXvAijbwgLRSaVd+B+WTGFYKxPzAbYqm9GhqPFk0Hy2CtoafBJV5MznKFo1sSKi0y28S24BEbLEPtVqM7Qw/xGzJ6I2OuWdnSvMG+kg9tsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081282; c=relaxed/simple;
	bh=YQidWeBQThI4lFjuPpKQQPtrlVPDUTen2IXLFencNZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw9791Z8X+2/ZSRyvAJ+vqEB9A9BSLmsYM9rEdhW2L8GiqiSzd6hKlVYoDmXLnP+ijgr7ivBb4kViIj/WIwU/pWs7vC/+AEWxByvxzrhFb3VvZxmH0rJ2DyeBOJGbYWYAzN8nfRJ/E1c91qmOf+4AnTx3rTnx9f0xSX3kYQSR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaR7OxGX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761081281; x=1792617281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YQidWeBQThI4lFjuPpKQQPtrlVPDUTen2IXLFencNZg=;
  b=BaR7OxGXHHT/mVpNv2Y6U7cCO/dPAjk3r001s6swgow+40dalA++6tsl
   R0g2lv/uNRVnVAznmgsGTDU5vZM/UcgGm0GXbgjnJ33WvWmDoMUzx7hIQ
   rKhR0gfVhyw5dRWhUB48AgqBwkXVQTqViB1/wsPe3aysSY+2KjWSY3ptV
   aOhTg0AYzztcQ/r5YeTf4AXzpIQrC19PnkBoI6QOt0XCtR7P535XV8NNL
   znVzIwQTgau3E49SvoMeHXEshkAy2Eew22waCCcbV+s7P+DPPCiqMVy24
   5uFLRQEwyNCJkjeV89NUZnvTkkp84xYtk1VhGM+0o9kFIF/bjyc4hfoCh
   g==;
X-CSE-ConnectionGUID: G6Zgw3joRQCDOPp24MfpdQ==
X-CSE-MsgGUID: MI38fL+bS6uI2Jk3XgGoUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67055832"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67055832"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 14:14:40 -0700
X-CSE-ConnectionGUID: GNdgFLJ0Ta2cVivOZcsn6A==
X-CSE-MsgGUID: N2vP9ISWSX2pfQevM9jjTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="187959834"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 21 Oct 2025 14:14:35 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBJgf-000Bm5-1n;
	Tue, 21 Oct 2025 21:14:33 +0000
Date: Wed, 22 Oct 2025 05:14:13 +0800
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
Subject: Re: [PATCH 11/11] [EXAMPLE] arm64: dts: allwinner: a527-cubie-a5e:
 Enable I2S and SPDIF output
Message-ID: <202510220453.UbrhVlRH-lkp@intel.com>
References: <20251020171059.2786070-12-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020171059.2786070-12-wens@kernel.org>

Hi Chen-Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on sunxi/sunxi/for-next]
[also build test ERROR on broonie-sound/for-next vkoul-dmaengine/next linus/master v6.18-rc2 next-20251021]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/dt-bindings-dma-allwinner-sun50i-a64-dma-Add-compatibles-for-A523/20251021-011340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
patch link:    https://lore.kernel.org/r/20251020171059.2786070-12-wens%40kernel.org
patch subject: [PATCH 11/11] [EXAMPLE] arm64: dts: allwinner: a527-cubie-a5e: Enable I2S and SPDIF output
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20251022/202510220453.UbrhVlRH-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510220453.UbrhVlRH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510220453.UbrhVlRH-lkp@intel.com/

All errors (new ones prefixed by >>):

   also defined at arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts:393.8-397.3
>> ERROR: Input tree has errors, aborting (use -f to force output)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

