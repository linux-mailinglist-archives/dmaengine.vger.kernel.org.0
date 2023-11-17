Return-Path: <dmaengine+bounces-149-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F7C7EFBFE
	for <lists+dmaengine@lfdr.de>; Sat, 18 Nov 2023 00:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91311F26608
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 23:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F239543161;
	Fri, 17 Nov 2023 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRnlbzH5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95573D5D;
	Fri, 17 Nov 2023 15:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700262206; x=1731798206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gqtwBJ9vqRsExwV1byrbbxDyp+pjvr8SABEziXOGx3E=;
  b=SRnlbzH5Akep3Be+HcBDhwAMdT9zBIxL5+/nKLuLwj5o97WbXQrmHadz
   LP67427/Fg9NVsZpYNnS1/E1WrBkQQjc3boTpmROJYpfrnpO065O7jf6Z
   X4xzz+z29DhBBVwX3/y03TE1pPiKl9fzY2y3gAL+H36MOJmOjE2w621t/
   LBwSlMO9hk7hZqgUYtA22ij/WmDu/EClrGpeY1M6Dm3QKP2bSCdJ4sKsO
   6yJ97IuWSb28L/ElaGJ+09w3h6UveFQD8QY2isHXc4Qg+wVOtn5SIwufz
   iWanEO2GyxIKAIEolG93BGtrwmq5/bKZE5OtmciRrXjfsJdOjLVVCE9EC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="477597418"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="477597418"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 15:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="889384113"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="889384113"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Nov 2023 15:03:22 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r47rr-0003GS-2m;
	Fri, 17 Nov 2023 23:03:19 +0000
Date: Sat, 18 Nov 2023 07:03:03 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: Re: [PATCH v2 5/5] dmaengine: fsl-edma: integrate TCD64 support for
 i.MX95
Message-ID: <202311180609.osug47KZ-lkp@intel.com>
References: <20231116222743.2984776-6-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116222743.2984776-6-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-edma-involve-help-macro-fsl_edma_set-get-_tcd/20231117-062946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20231116222743.2984776-6-Frank.Li%40nxp.com
patch subject: [PATCH v2 5/5] dmaengine: fsl-edma: integrate TCD64 support for i.MX95
config: x86_64-randconfig-r113-20231117 (https://download.01.org/0day-ci/archive/20231118/202311180609.osug47KZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311180609.osug47KZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180609.osug47KZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/dma/fsl-edma-main.c:59:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:63:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:554:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:554:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:554:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:554:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:554:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:554:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:554:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:554:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:554:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:554:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:554:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:554:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:554:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:554:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-main.c:554:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:554:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:554:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:676:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:676:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:676:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:676:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:676:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:676:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:676:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:676:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:676:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:676:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:676:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:676:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:676:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:676:17: sparse:     got restricted __le16 *
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-main.c:676:17: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/fsl-edma-main.c:676:17: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-main.c:676:17: sparse:     got restricted __le16 *
--
   drivers/dma/fsl-edma-common.c:76:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:93:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:104:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:106:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:131:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:140:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:361:26: sparse: sparse: cast to restricted __le16
   drivers/dma/fsl-edma-common.c:361:26: sparse: sparse: cast from restricted __le32
>> drivers/dma/fsl-edma-common.c:361:26: sparse: sparse: cast to restricted __le64
   drivers/dma/fsl-edma-common.c:361:26: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:364:33: sparse: sparse: cast to restricted __le32
   drivers/dma/fsl-edma-common.c:364:33: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:364:33: sparse: sparse: cast to restricted __le64
   drivers/dma/fsl-edma-common.c:364:33: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:373:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:373:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:373:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:373:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:373:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:373:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:373:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:373:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:373:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:373:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-common.c:373:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:373:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:373:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:374:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:374:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:374:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:374:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:374:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:374:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:374:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:374:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:374:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:374:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:374:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:374:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:374:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:376:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:376:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:376:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:376:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:376:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:376:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:376:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:376:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:376:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:376:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:376:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:376:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:376:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:377:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:377:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:377:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:377:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/dma/fsl-edma-common.c:377:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:377:36: sparse:     got restricted __le32 *
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:377:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:377:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:377:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:377:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-common.c:377:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __le64 * @@
   drivers/dma/fsl-edma-common.c:377:36: sparse:     expected void [noderef] __iomem *addr
   drivers/dma/fsl-edma-common.c:377:36: sparse:     got restricted __le64 *
   drivers/dma/fsl-edma-common.c:383:26: sparse: sparse: cast to restricted __le16
   drivers/dma/fsl-edma-common.c:383:26: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:383:26: sparse: sparse: cast to restricted __le64
   drivers/dma/fsl-edma-common.c:383:26: sparse: sparse: cast from restricted __le32
   drivers/dma/fsl-edma-common.c:387:33: sparse: sparse: cast to restricted __le32
   drivers/dma/fsl-edma-common.c:387:33: sparse: sparse: cast from restricted __le16
   drivers/dma/fsl-edma-common.c:387:33: sparse: sparse: cast to restricted __le64
   drivers/dma/fsl-edma-common.c:387:33: sparse: sparse: cast from restricted __le16
>> drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: restricted __le64 degrades to integer
>> drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: restricted __le32 degrades to integer
>> drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: restricted __le64 degrades to integer
>> drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: restricted __le32 degrades to integer
>> drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: restricted __le64 degrades to integer
>> drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: cast to restricted __le16
>> drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: restricted __le64 degrades to integer
>> drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: cast to restricted __le32
>> drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: restricted __le64 degrades to integer
>> drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: restricted __le32 degrades to integer
   drivers/dma/fsl-edma-common.c:390:36: sparse: sparse: cast to restricted __le64
   drivers/dma/fsl-edma-common.c:392:36: sparse: sparse: too many warnings

vim +554 drivers/dma/fsl-edma-main.c

72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  427  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  428  static int fsl_edma_probe(struct platform_device *pdev)
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  429  {
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  430  	struct device_node *np = pdev->dev.of_node;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  431  	struct fsl_edma_engine *fsl_edma;
af802728e4ab07 drivers/dma/fsl-edma.c      Robin Gong        2019-06-25  432  	const struct fsl_edma_drvdata *drvdata = NULL;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  433  	u32 chan_mask[2] = {0, 0};
377eaf3b3c4ad7 drivers/dma/fsl-edma.c      Angelo Dureghello 2018-08-19  434  	struct edma_regs *regs;
33a0b734543ed5 drivers/dma/fsl-edma.c      Yu Liao           2023-08-21  435  	int chans;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  436  	int ret, i;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  437  
a67ba97dfb3048 drivers/dma/fsl-edma-main.c Rob Herring       2023-10-06  438  	drvdata = device_get_match_data(&pdev->dev);
af802728e4ab07 drivers/dma/fsl-edma.c      Robin Gong        2019-06-25  439  	if (!drvdata) {
af802728e4ab07 drivers/dma/fsl-edma.c      Robin Gong        2019-06-25  440  		dev_err(&pdev->dev, "unable to find driver data\n");
af802728e4ab07 drivers/dma/fsl-edma.c      Robin Gong        2019-06-25  441  		return -EINVAL;
af802728e4ab07 drivers/dma/fsl-edma.c      Robin Gong        2019-06-25  442  	}
af802728e4ab07 drivers/dma/fsl-edma.c      Robin Gong        2019-06-25  443  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  444  	ret = of_property_read_u32(np, "dma-channels", &chans);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  445  	if (ret) {
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  446  		dev_err(&pdev->dev, "Can't get dma-channels.\n");
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  447  		return ret;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  448  	}
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  449  
33a0b734543ed5 drivers/dma/fsl-edma.c      Yu Liao           2023-08-21  450  	fsl_edma = devm_kzalloc(&pdev->dev, struct_size(fsl_edma, chans, chans),
33a0b734543ed5 drivers/dma/fsl-edma.c      Yu Liao           2023-08-21  451  				GFP_KERNEL);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  452  	if (!fsl_edma)
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  453  		return -ENOMEM;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  454  
af802728e4ab07 drivers/dma/fsl-edma.c      Robin Gong        2019-06-25  455  	fsl_edma->drvdata = drvdata;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  456  	fsl_edma->n_chans = chans;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  457  	mutex_init(&fsl_edma->fsl_edma_mutex);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  458  
4b23603a251d24 drivers/dma/fsl-edma.c      Tudor Ambarus     2022-11-10  459  	fsl_edma->membase = devm_platform_ioremap_resource(pdev, 0);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  460  	if (IS_ERR(fsl_edma->membase))
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  461  		return PTR_ERR(fsl_edma->membase);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  462  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  463  	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)) {
377eaf3b3c4ad7 drivers/dma/fsl-edma.c      Angelo Dureghello 2018-08-19  464  		fsl_edma_setup_regs(fsl_edma);
377eaf3b3c4ad7 drivers/dma/fsl-edma.c      Angelo Dureghello 2018-08-19  465  		regs = &fsl_edma->regs;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  466  	}
377eaf3b3c4ad7 drivers/dma/fsl-edma.c      Angelo Dureghello 2018-08-19  467  
9e006b243962a4 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  468  	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
a9903de3aa1673 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  469  		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
232a7f18cf8ecb drivers/dma/fsl-edma.c      Robin Gong        2019-07-24  470  		if (IS_ERR(fsl_edma->dmaclk)) {
232a7f18cf8ecb drivers/dma/fsl-edma.c      Robin Gong        2019-07-24  471  			dev_err(&pdev->dev, "Missing DMA block clock.\n");
232a7f18cf8ecb drivers/dma/fsl-edma.c      Robin Gong        2019-07-24  472  			return PTR_ERR(fsl_edma->dmaclk);
232a7f18cf8ecb drivers/dma/fsl-edma.c      Robin Gong        2019-07-24  473  		}
232a7f18cf8ecb drivers/dma/fsl-edma.c      Robin Gong        2019-07-24  474  	}
232a7f18cf8ecb drivers/dma/fsl-edma.c      Robin Gong        2019-07-24  475  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  476  	if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  477  		fsl_edma->chclk = devm_clk_get_enabled(&pdev->dev, "mp");
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  478  		if (IS_ERR(fsl_edma->chclk)) {
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  479  			dev_err(&pdev->dev, "Missing MP block clock.\n");
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  480  			return PTR_ERR(fsl_edma->chclk);
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  481  		}
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  482  	}
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  483  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  484  	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  485  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  486  	if (ret > 0) {
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  487  		fsl_edma->chan_masked = chan_mask[1];
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  488  		fsl_edma->chan_masked <<= 32;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  489  		fsl_edma->chan_masked |= chan_mask[0];
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  490  	}
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  491  
af802728e4ab07 drivers/dma/fsl-edma.c      Robin Gong        2019-06-25  492  	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  493  		char clkname[32];
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  494  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  495  		/* eDMAv3 mux register move to TCD area if ch_mux exist */
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  496  		if (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  497  			break;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  498  
4b23603a251d24 drivers/dma/fsl-edma.c      Tudor Ambarus     2022-11-10  499  		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
4b23603a251d24 drivers/dma/fsl-edma.c      Tudor Ambarus     2022-11-10  500  								      1 + i);
2610acf46b9ed5 drivers/dma/fsl-edma.c      Andreas Platschek 2017-12-14  501  		if (IS_ERR(fsl_edma->muxbase[i])) {
2610acf46b9ed5 drivers/dma/fsl-edma.c      Andreas Platschek 2017-12-14  502  			/* on error: disable all previously enabled clks */
2610acf46b9ed5 drivers/dma/fsl-edma.c      Andreas Platschek 2017-12-14  503  			fsl_disable_clocks(fsl_edma, i);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  504  			return PTR_ERR(fsl_edma->muxbase[i]);
2610acf46b9ed5 drivers/dma/fsl-edma.c      Andreas Platschek 2017-12-14  505  		}
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  506  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  507  		sprintf(clkname, "dmamux%d", i);
a9903de3aa1673 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  508  		fsl_edma->muxclk[i] = devm_clk_get_enabled(&pdev->dev, clkname);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  509  		if (IS_ERR(fsl_edma->muxclk[i])) {
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  510  			dev_err(&pdev->dev, "Missing DMAMUX block clock.\n");
2610acf46b9ed5 drivers/dma/fsl-edma.c      Andreas Platschek 2017-12-14  511  			/* on error: disable all previously enabled clks */
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  512  			return PTR_ERR(fsl_edma->muxclk[i]);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  513  		}
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  514  	}
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  515  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  516  	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  517  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  518  	if (drvdata->flags & FSL_EDMA_DRV_HAS_PD) {
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  519  		ret = fsl_edma3_attach_pd(pdev, fsl_edma);
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  520  		if (ret)
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  521  			return ret;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  522  	}
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  523  
718250845ce432 drivers/dma/fsl-edma-main.c Frank Li          2023-11-16  524  	if (drvdata->flags & FSL_EDMA_DRV_TCD64)
718250845ce432 drivers/dma/fsl-edma-main.c Frank Li          2023-11-16  525  		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
718250845ce432 drivers/dma/fsl-edma-main.c Frank Li          2023-11-16  526  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  527  	INIT_LIST_HEAD(&fsl_edma->dma_dev.channels);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  528  	for (i = 0; i < fsl_edma->n_chans; i++) {
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  529  		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  530  		int len;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  531  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  532  		if (fsl_edma->chan_masked & BIT(i))
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  533  			continue;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  534  
9b05554c5ca682 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  535  		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
9b05554c5ca682 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  536  							   dev_name(&pdev->dev), i);
9b05554c5ca682 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  537  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  538  		fsl_chan->edma = fsl_edma;
82d149b86d31e1 drivers/dma/fsl-edma.c      Yuan Yao          2015-10-30  539  		fsl_chan->pm_state = RUNNING;
82d149b86d31e1 drivers/dma/fsl-edma.c      Yuan Yao          2015-10-30  540  		fsl_chan->slave_id = 0;
82d149b86d31e1 drivers/dma/fsl-edma.c      Yuan Yao          2015-10-30  541  		fsl_chan->idle = true;
0fa89f972da607 drivers/dma/fsl-edma.c      Laurentiu Tudor   2019-01-18  542  		fsl_chan->dma_dir = DMA_NONE;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  543  		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  544  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  545  		len = (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) ?
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  546  				offsetof(struct fsl_edma3_ch_reg, tcd) : 0;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  547  		fsl_chan->tcd = fsl_edma->membase
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  548  				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
9dc1dc9f63c698 drivers/dma/fsl-edma-main.c Frank Li          2023-11-16  549  		fsl_chan->mux_addr = fsl_edma->membase + drvdata->mux_off + i * drvdata->mux_skip;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  550  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  551  		fsl_chan->pdev = pdev;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  552  		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  553  
7536f8b371adcc drivers/dma/fsl-edma-main.c Frank Li          2023-08-21 @554  		edma_write_tcdreg(fsl_chan, 0, csr);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  555  		fsl_edma_chan_mux(fsl_chan, 0, false);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  556  	}
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  557  
af802728e4ab07 drivers/dma/fsl-edma.c      Robin Gong        2019-06-25  558  	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
0fe25d61102d44 drivers/dma/fsl-edma.c      Stefan Agner      2015-06-07  559  	if (ret)
0fe25d61102d44 drivers/dma/fsl-edma.c      Stefan Agner      2015-06-07  560  		return ret;
0fe25d61102d44 drivers/dma/fsl-edma.c      Stefan Agner      2015-06-07  561  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  562  	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  563  	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  564  	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
e0674853943287 drivers/dma/fsl-edma.c      Joy Zou           2021-10-26  565  	dma_cap_set(DMA_MEMCPY, fsl_edma->dma_dev.cap_mask);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  566  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  567  	fsl_edma->dma_dev.dev = &pdev->dev;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  568  	fsl_edma->dma_dev.device_alloc_chan_resources
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  569  		= fsl_edma_alloc_chan_resources;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  570  	fsl_edma->dma_dev.device_free_chan_resources
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  571  		= fsl_edma_free_chan_resources;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  572  	fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  573  	fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  574  	fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
e0674853943287 drivers/dma/fsl-edma.c      Joy Zou           2021-10-26  575  	fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;
d80f381f321ab7 drivers/dma/fsl-edma.c      Maxime Ripard     2014-11-17  576  	fsl_edma->dma_dev.device_config = fsl_edma_slave_config;
d80f381f321ab7 drivers/dma/fsl-edma.c      Maxime Ripard     2014-11-17  577  	fsl_edma->dma_dev.device_pause = fsl_edma_pause;
d80f381f321ab7 drivers/dma/fsl-edma.c      Maxime Ripard     2014-11-17  578  	fsl_edma->dma_dev.device_resume = fsl_edma_resume;
d80f381f321ab7 drivers/dma/fsl-edma.c      Maxime Ripard     2014-11-17  579  	fsl_edma->dma_dev.device_terminate_all = fsl_edma_terminate_all;
ba1cab79cfc629 drivers/dma/fsl-edma.c      Andrey Smirnov    2019-07-31  580  	fsl_edma->dma_dev.device_synchronize = fsl_edma_synchronize;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  581  	fsl_edma->dma_dev.device_issue_pending = fsl_edma_issue_pending;
f45c431148e1ba drivers/dma/fsl-edma.c      Maxime Ripard     2014-11-17  582  
f45c431148e1ba drivers/dma/fsl-edma.c      Maxime Ripard     2014-11-17  583  	fsl_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
f45c431148e1ba drivers/dma/fsl-edma.c      Maxime Ripard     2014-11-17  584  	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  585  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  586  	if (drvdata->flags & FSL_EDMA_DRV_BUS_8BYTE) {
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  587  		fsl_edma->dma_dev.src_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  588  		fsl_edma->dma_dev.dst_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  589  	}
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  590  
f45c431148e1ba drivers/dma/fsl-edma.c      Maxime Ripard     2014-11-17  591  	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  592  	if (drvdata->flags & FSL_EDMA_DRV_DEV_TO_DEV)
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  593  		fsl_edma->dma_dev.directions |= BIT(DMA_DEV_TO_DEV);
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  594  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  595  	fsl_edma->dma_dev.copy_align = drvdata->flags & FSL_EDMA_DRV_ALIGN_64BYTE ?
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  596  					DMAENGINE_ALIGN_64_BYTES :
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  597  					DMAENGINE_ALIGN_32_BYTES;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  598  
e0674853943287 drivers/dma/fsl-edma.c      Joy Zou           2021-10-26  599  	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
e0674853943287 drivers/dma/fsl-edma.c      Joy Zou           2021-10-26  600  	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
e0674853943287 drivers/dma/fsl-edma.c      Joy Zou           2021-10-26  601  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  602  	fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  603  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  604  	platform_set_drvdata(pdev, fsl_edma);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  605  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  606  	ret = dma_async_device_register(&fsl_edma->dma_dev);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  607  	if (ret) {
a86144da9d1a43 drivers/dma/fsl-edma.c      Peter Griffin     2016-06-07  608  		dev_err(&pdev->dev,
a86144da9d1a43 drivers/dma/fsl-edma.c      Peter Griffin     2016-06-07  609  			"Can't register Freescale eDMA engine. (%d)\n", ret);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  610  		return ret;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  611  	}
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  612  
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  613  	ret = of_dma_controller_register(np,
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  614  			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  615  			fsl_edma);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  616  	if (ret) {
a86144da9d1a43 drivers/dma/fsl-edma.c      Peter Griffin     2016-06-07  617  		dev_err(&pdev->dev,
a86144da9d1a43 drivers/dma/fsl-edma.c      Peter Griffin     2016-06-07  618  			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  619  		dma_async_device_unregister(&fsl_edma->dma_dev);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  620  		return ret;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  621  	}
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  622  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  623  	/* enable round robin arbitration */
72f5801a4e2b71 drivers/dma/fsl-edma-main.c Frank Li          2023-08-21  624  	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
377eaf3b3c4ad7 drivers/dma/fsl-edma.c      Angelo Dureghello 2018-08-19  625  		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  626  
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  627  	return 0;
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  628  }
d6be34fbd39b7d drivers/dma/fsl-edma.c      Jingchang Lu      2014-02-18  629  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

