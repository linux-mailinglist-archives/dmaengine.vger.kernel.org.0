Return-Path: <dmaengine+bounces-2747-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20E93E0AA
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jul 2024 21:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051CD1C20C11
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jul 2024 19:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A1186E59;
	Sat, 27 Jul 2024 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGqh6HkN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57580C09;
	Sat, 27 Jul 2024 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722107502; cv=none; b=Wz0qPvUBxgsFLGST39sQMQp3b83MDIvVJkU7R6BJke5KLAQhMK1ai+UuQWwOX5f2Q460S3akb2CFaZyAdirIncuzPM+Hc/E7zvkj/6Oz+zN6M896yRHcgt5bhrzseFwLvuCtg6lgCk/YWfRUKca1OSIj5KGaZbrMcaeqCwlnlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722107502; c=relaxed/simple;
	bh=M8mrct+fcXWf4dQP4IR3e4KiOgK+DHB5K7VgHM1qCDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuxIBcqyPCBwvmWEy5XkpkPrLeg+Lix+w6zUoodxUkXFVWW/x6/WhrLc29hnHYHOIWMb7fgIi2KgzH7FQ47evlhc6q51SV7otxgmvb2huh7pwJ0kzqdSW8FN1CrcitrnI2SeJFuhCE+IuVi9EJ4hn/dCYcCyVwpdwOLuPS4Kkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGqh6HkN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722107500; x=1753643500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M8mrct+fcXWf4dQP4IR3e4KiOgK+DHB5K7VgHM1qCDM=;
  b=QGqh6HkNaLLN6pwjbKizC3hee9tPHzyCIJY2Ejh0RrUMJmgp3uguS9c+
   XxBBr4ltNUMUB0gYkX3K9owYvSRKBR1z9emzGTlXu0PiBpGaBv0OTS+za
   HDKGLHpMNdHK6Txsxpek6fwG8BbtXAhpui8G6AUUg1/7Pj7MKCZUfRKo4
   wRxtK9UU6Modgse+4bDYnAhulFBixAd80rHuK+e6+kPiwNB455GiFvCsv
   CPo/bNhXp4hhKMmSGO9XSeKD/FuDMioxoD/qorhBcmNhJ/ZNNZw6w4mrG
   KuOShxYussF0W2bGWINGMM4IptX3b/LkghuyA6kAerp5N2oJgPy5IxxIt
   Q==;
X-CSE-ConnectionGUID: rD8YJziURpCzS8cVtIjoOw==
X-CSE-MsgGUID: uW4GXKzASl2YiIHga0qfIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="23737250"
X-IronPort-AV: E=Sophos;i="6.09,242,1716274800"; 
   d="scan'208";a="23737250"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 12:11:39 -0700
X-CSE-ConnectionGUID: 2Ao0g3xGS8qfccCuivH2mA==
X-CSE-MsgGUID: QhoqwShcSuSMVXNuVVxAXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,242,1716274800"; 
   d="scan'208";a="76793712"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jul 2024 12:11:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXmpK-000qAq-1F;
	Sat, 27 Jul 2024 19:11:34 +0000
Date: Sun, 28 Jul 2024 03:11:03 +0800
From: kernel test robot <lkp@intel.com>
To: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v10 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA
 driver
Message-ID: <202407280250.YTVHsCYs-lkp@intel.com>
References: <20240726-loongson1-dma-v10-2-31bf095a6fa6@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-loongson1-dma-v10-2-31bf095a6fa6@gmail.com>

Hi Keguang,

kernel test robot noticed the following build errors:

[auto build test ERROR on 668d33c9ff922c4590c58754ab064aaf53c387dd]

url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang-via-B4-Relay/dt-bindings-dma-Add-Loongson-1-APB-DMA/20240726-212659
base:   668d33c9ff922c4590c58754ab064aaf53c387dd
patch link:    https://lore.kernel.org/r/20240726-loongson1-dma-v10-2-31bf095a6fa6%40gmail.com
patch subject: [PATCH v10 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240728/202407280250.YTVHsCYs-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240728/202407280250.YTVHsCYs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407280250.YTVHsCYs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/dma/loongson1-apb-dma.c:58:3: error: requested alignment must be 4294967296 bytes or smaller
      58 | } __aligned(LS1X_DMA_LLI_ALIGNMENT);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:33:56: note: expanded from macro '__aligned'
      33 | #define __aligned(x)                    __attribute__((__aligned__(x)))
         |                                                        ^           ~
   1 error generated.


vim +58 drivers/dma/loongson1-apb-dma.c

    53	
    54	struct ls1x_dma_lli {
    55		unsigned int hw[LS1X_DMADESC_SIZE];
    56		dma_addr_t phys;
    57		struct list_head node;
  > 58	} __aligned(LS1X_DMA_LLI_ALIGNMENT);
    59	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

