Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A726AA877
	for <lists+dmaengine@lfdr.de>; Sat,  4 Mar 2023 07:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCDGvo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 Mar 2023 01:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCDGvn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 4 Mar 2023 01:51:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98273B749;
        Fri,  3 Mar 2023 22:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677912702; x=1709448702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JGi8y72DqKWL+R1ytY0Z+Y7NhTUceMCbtC1BVCCR8g0=;
  b=PuDrtH/Fo2emD1ImMbK2g6r+vEP6kGHY5fx2NHjdKIjbfTqVweqLnH5L
   zffpYE0F0PX35d3lgc7pbaMSgMofuD2b08TAASrCezhBtAxTc0u6SHOm1
   qJTapbqp2yNKUHyJcTcfiCb+6oKiA/sdckKvWioke8rOO4FMlEefpkf1B
   eHyrLKA+NyBBJr+rqygek36pGNb3XFJW2bLaJAfewrh1zzB9d3L4ARUry
   ELKS4JkQX9YdiiZegi3yyKX170lpzfuQ6+mWyWagxD2pqtMr4eYuPQFuo
   f2w3G8fdBHwmuFLHYCG65LU1Npe+qp8mFoSsZn21F9QJ3uaI1nkuzidXA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="332710341"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="332710341"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 22:51:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="764666624"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="764666624"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2023 22:51:38 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYLk2-0001wG-0F;
        Sat, 04 Mar 2023 06:51:38 +0000
Date:   Sat, 4 Mar 2023 14:51:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>, fancer.lancer@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Cai huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <202303041444.2M7BzjRU-lkp@intel.com>
References: <20230303124642.5519-4-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303124642.5519-4-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Cai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on linus/master next-20230303]
[cannot apply to vkoul-dmaengine/next pci/for-linus v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cai-Huoqing/dmaengine-dw-edma-Rename-dw_edma_core_ops-structure-to-dw_edma_plat_ops/20230303-204905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230303124642.5519-4-cai.huoqing%40linux.dev
patch subject: [PATCH v5 3/4] dmaengine: dw-edma: Add support for native HDMA
config: arm-randconfig-r016-20230303 (https://download.01.org/0day-ci/archive/20230304/202303041444.2M7BzjRU-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/061ed1e9b9bf70de12d7885880ee6302865a72d0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cai-Huoqing/dmaengine-dw-edma-Rename-dw_edma_core_ops-structure-to-dw_edma_plat_ops/20230303-204905
        git checkout 061ed1e9b9bf70de12d7885880ee6302865a72d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303041444.2M7BzjRU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/dma/dw-edma/dw-hdma-v0-core.c:12:
>> drivers/dma/dw-edma/dw-hdma-v0-regs.h:71:4: warning: field msi_stop within 'struct dw_hdma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-hdma-v0-regs.h:65:2)' and is usually due to 'struct dw_hdma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } msi_stop;
             ^
>> drivers/dma/dw-edma/dw-hdma-v0-regs.h:78:4: warning: field msi_watermark within 'struct dw_hdma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-hdma-v0-regs.h:72:2)' and is usually due to 'struct dw_hdma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } msi_watermark;
             ^
>> drivers/dma/dw-edma/dw-hdma-v0-regs.h:85:4: warning: field msi_abort within 'struct dw_hdma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-hdma-v0-regs.h:79:2)' and is usually due to 'struct dw_hdma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } msi_abort;
             ^
   3 warnings generated.


vim +71 drivers/dma/dw-edma/dw-hdma-v0-regs.h

    26	
    27	struct dw_hdma_v0_ch_regs {
    28		u32 ch_en;				/* 0x0000 */
    29		u32 doorbell;				/* 0x0004 */
    30		u32 prefetch;				/* 0x0008 */
    31		u32 handshake;				/* 0x000c */
    32		union {
    33			u64 reg;			/* 0x0010..0x0014 */
    34			struct {
    35				u32 lsb;		/* 0x0010 */
    36				u32 msb;		/* 0x0014 */
    37			};
    38		} llp;
    39		u32 cycle_sync;				/* 0x0018 */
    40		u32 transfer_size;			/* 0x001c */
    41		union {
    42			u64 reg;			/* 0x0020..0x0024 */
    43			struct {
    44				u32 lsb;		/* 0x0020 */
    45				u32 msb;		/* 0x0024 */
    46			};
    47		} sar;
    48		union {
    49			u64 reg;			/* 0x0028..0x002c */
    50			struct {
    51				u32 lsb;		/* 0x0028 */
    52				u32 msb;		/* 0x002c */
    53			};
    54		} dar;
    55	
    56		u32 watermark_en;			/* 0x0030 */
    57		u32 control1;				/* 0x0034 */
    58		u32 func_num;				/* 0x0038 */
    59		u32 qos;				/* 0x003c */
    60		u32 reserved;				/* 0x0040..0x007c */
    61		u32 ch_stat;				/* 0x0080 */
    62		u32 int_stat;				/* 0x0084 */
    63		u32 int_setup;				/* 0x0088 */
    64		u32 int_clear;				/* 0x008c */
    65		union {
    66			u64 reg;			/* 0x0090..0x0094 */
    67			struct {
    68				u32 lsb;		/* 0x0090 */
    69				u32 msb;		/* 0x0094 */
    70			};
  > 71		} msi_stop;
    72		union {
    73			u64 reg;			/* 0x0098..0x009c */
    74			struct {
    75				u32 lsb;		/* 0x0098 */
    76				u32 msb;		/* 0x009c */
    77			};
  > 78		} msi_watermark;
    79		union {
    80			u64 reg;			/* 0x00a0..0x00a4 */
    81			struct {
    82				u32 lsb;		/* 0x00a0 */
    83				u32 msb;		/* 0x00a4 */
    84			};
  > 85		} msi_abort;
    86		u32 msi_msgdata;			/* 0x00a8 */
    87	} __packed;
    88	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
