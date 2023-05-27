Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9139E713423
	for <lists+dmaengine@lfdr.de>; Sat, 27 May 2023 12:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjE0KoF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 May 2023 06:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjE0KoF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 May 2023 06:44:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A749E;
        Sat, 27 May 2023 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685184243; x=1716720243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=htgVJ0Mc9jfpsCqyHX2MoPkxQc8Odo9Ce4AmOTBizhE=;
  b=L/rril5Eyuh0Liy/lAbwjZ8OvMsII1IwAZXza3DdlzKEXeRtyJFNMgBe
   L8nl75ksilMBO47+ebvVejqiTwLcby0hht3VNYiDla2OV9rAPnOJR26Ge
   Z27men4KVcipAgSwCOHL8F2rIEhOpklb1OA7DHKlAy0FQA+019ZEcfAQ9
   76qaHEAKyaRubLfzgGyjCw2ktVBHN+8+RUhsPSJD/Fodekf1RwKG2ymp9
   g0GKcqXdOeAQR0u/rKgYIAWi2deLMPsDpWPOtp82977trbStjcHzEb4e0
   Wz/r9FjZv/CUeh2mRXfIuYo6jNGr7se+HnpX9Kvu8id8erZGmz8PrYtUe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="417866954"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="417866954"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 03:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="699679398"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="699679398"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 May 2023 03:44:00 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2rOx-000JuI-2L;
        Sat, 27 May 2023 10:43:59 +0000
Date:   Sat, 27 May 2023 18:43:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Nishad Saraf <nishads@amd.com>,
        max.zhen@amd.com, sonal.santan@amd.com, nishad.saraf@amd.com,
        Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH V1 QDMA 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Message-ID: <202305271839.2OLecczN-lkp@intel.com>
References: <1685119795-11729-2-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685119795-11729-2-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lizhi,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lizhi-Hou/dmaengine-amd-qdma-Add-AMD-QDMA-driver/20230527-005214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/1685119795-11729-2-git-send-email-lizhi.hou%40amd.com
patch subject: [PATCH V1 QDMA 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230527/202305271839.2OLecczN-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d300fd23b7ecbcc89512dba3fa745941c1c03fac
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lizhi-Hou/dmaengine-amd-qdma-Add-AMD-QDMA-driver/20230527-005214
        git checkout d300fd23b7ecbcc89512dba3fa745941c1c03fac
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 ~/bin/make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305271839.2OLecczN-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x234): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x254): additional relocation overflows omitted from the output
   mips-linux-ld: drivers/dma/amd/qdma.o: in function `qdma_get_field.isra.0':
>> qdma.c:(.text.qdma_get_field.isra.0+0xa8): undefined reference to `__ffsdi2'
>> mips-linux-ld: qdma.c:(.text.qdma_get_field.isra.0+0x200): undefined reference to `__ffsdi2'
   mips-linux-ld: qdma.c:(.text.qdma_get_field.isra.0+0x3e0): undefined reference to `__ffsdi2'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
