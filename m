Return-Path: <dmaengine+bounces-4176-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487EA1A2BD
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2025 12:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E7D1884A2D
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2025 11:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57AF20E011;
	Thu, 23 Jan 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClYtesHo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55873145A16;
	Thu, 23 Jan 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630970; cv=none; b=GwLHmVep+rZOEkPrApelg1TSVhP9LVG/zvpVHcZt+0mvuDGlt3KlH38ZeaBYnuHWPU1faS4pfLu6KtfG2FdjS0VvDWsrD0N6sIWjAiVWwiUM+FPXEajwb3zhsU3srdl+531y3nMv++0V4yIlhZ3RAsYVkqoSPkGp+BAmcLUi028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630970; c=relaxed/simple;
	bh=5Cz3JuNDr+ExBTbgwX6Lb6uNnmnKpu0gWkh0CTOb8Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2ohAJLEluz6/qQ5B5I4AWn7RCEcqO9a4KetQKkPzctnBl93qZ01UNZiisGdk5NU5d4THcFzmqqch3Sw3wORpyx89zezYnKzI/H+hJrJELDNAKHabPXS0faZ8k+uAHnHFGfR0FXHkm0/hg1il3TKV5awnya5iaQ17tpiUwOmdR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClYtesHo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737630968; x=1769166968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Cz3JuNDr+ExBTbgwX6Lb6uNnmnKpu0gWkh0CTOb8Y8=;
  b=ClYtesHojx7gM+wwpV80kA8E+y/qKS5pnYrj5AtiLsnHzbU3IexEPaGP
   FFKRHoonyrej71z+Fgu6XQolxjPn4zUFf343cn9dLKGeEADYTlueIjQxJ
   CNSq5IpBeuIHuYr7V0CGjt6TtgtqXXQTva1+ySrx7l1VlGKngBgwr64jq
   liQ7TtTvJILzn9+APRAdLKw3fb4jKDYIPhz+hLgnlJnMZTygCxP8AP3gS
   pycxa6jQDZSBlG5FEvkXwVXtyTgEWYySOtoJTut0IUVkhya/ib1S6HF1V
   m+ESsYO2+kua8UC5h3tw4KgYQ0Hr1Kle1MQrIn1pKoJnDrJRQOvD3YReM
   A==;
X-CSE-ConnectionGUID: w1MfIZ9GTtqDjjLKzPkEIw==
X-CSE-MsgGUID: Qtb8xbuHTkOtLVmuyf2X/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="38039966"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="38039966"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 03:16:07 -0800
X-CSE-ConnectionGUID: CsXKwGQ6Rs20KwpQzkTghQ==
X-CSE-MsgGUID: s6lMtdZhSTKdNdPQ97sWHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107350853"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 23 Jan 2025 03:16:03 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tavBo-000b6d-2j;
	Thu, 23 Jan 2025 11:16:00 +0000
Date: Thu, 23 Jan 2025 19:15:54 +0800
From: kernel test robot <lkp@intel.com>
To: Charan Pedumuru <charan.pedumuru@microchip.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Durai Manickam KR <durai.manickamkr@microchip.com>,
	Charan Pedumuru <charan.pedumuru@microchip.com>
Subject: Re: [PATCH v2] dt-bindings: dma: convert atmel-dma.txt to YAML
Message-ID: <202501231832.JO111vnL-lkp@intel.com>
References: <20250123-dma-v1-1-054f1a77e733@microchip.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123-dma-v1-1-054f1a77e733@microchip.com>

Hi Charan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 232f121837ad8b1c21cc80f2c8842a4090c5a2a0]

url:    https://github.com/intel-lab-lkp/linux/commits/Charan-Pedumuru/dt-bindings-dma-convert-atmel-dma-txt-to-YAML/20250123-173101
base:   232f121837ad8b1c21cc80f2c8842a4090c5a2a0
patch link:    https://lore.kernel.org/r/20250123-dma-v1-1-054f1a77e733%40microchip.com
patch subject: [PATCH v2] dt-bindings: dma: convert atmel-dma.txt to YAML
reproduce: (https://download.01.org/0day-ci/archive/20250123/202501231832.JO111vnL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501231832.JO111vnL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt_link<../../networking/netlink_spec/rt_link>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Warning: Documentation/arch/powerpc/cxl.rst references a file that doesn't exist: Documentation/ABI/testing/sysfs-class-cxl
>> Warning: Documentation/devicetree/bindings/misc/atmel-ssc.txt references a file that doesn't exist: Documentation/devicetree/bindings/dma/atmel-dma.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
   Warning: Documentation/translations/zh_CN/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/translations/zh_TW/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/dma/atmel-dma.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
   Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

