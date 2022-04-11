Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6714FB5DF
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343715AbiDKIYO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243837AbiDKIYK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 04:24:10 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9793E5CE;
        Mon, 11 Apr 2022 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649665317; x=1681201317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=scsOcqJzNI6mZ2YEH5vHXnC/k0h5kNwTVDSSNWSTjAA=;
  b=ll/JbAKfULVpsfSXyYAdw+csSpJhOdNX/aNcrMMNB8hfTDbk5kgD04z1
   qTAC7+2G+miThrHPEp9vPCCxiql1bq/v5Ydsc5qBUfc+I+/16m1p1DIxt
   ahGsbLlmKOxMeNPyc3g3ntbvhr0lOQK32lbHipJzMhlvFHJ7K93Tlp7lo
   ewwNewfJmRZ6pzUwBz++eZ+gik6XSMXFn9OEkC0V35cHB1KJD0fnPS39m
   5/ZSE0pJy3MC2fAKcZEOewoA3hSDT41VeC8eDnRqha6BJLIxzc70f1hZa
   jdgkyBsOl2wrv/RUle8g7O/qggJ94zYqRss9kjv6Nf04JfqBndYe56dCS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="348503221"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="348503221"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="622754005"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2022 01:21:53 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndpJ3-0001gN-6G;
        Mon, 11 Apr 2022 08:21:53 +0000
Date:   Mon, 11 Apr 2022 16:20:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/4] dmaengine: sun6i: Do not use virt_to_phys
Message-ID: <202204111641.yuvoMU5q-lkp@intel.com>
References: <20220411044633.39014-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411044633.39014-3-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Samuel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on sunxi/sunxi/for-next v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/dmaengine-sun6i-Allwinner-D1-support/20220411-124826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
config: hexagon-randconfig-r041-20220410 (https://download.01.org/0day-ci/archive/20220411/202204111641.yuvoMU5q-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c6e83f560f06cdfe8aa47b248d8bdc58f947274b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/280420721fd264a03a3d3f9fbe2b4e6bfddd0f79
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Samuel-Holland/dmaengine-sun6i-Allwinner-D1-support/20220411-124826
        git checkout 280420721fd264a03a3d3f9fbe2b4e6bfddd0f79
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/sun6i-dma.c:253:15: warning: format specifies type 'unsigned long' but the argument has type 'int' [-Wformat]
                   pchan->idx, pchan->base - sdev->base,
                               ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:39: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                        ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:167:19: note: expanded from macro 'dynamic_dev_dbg'
                              dev, fmt, ##__VA_ARGS__)
                                   ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   1 warning generated.


vim +253 drivers/dma/sun6i-dma.c

   240	
   241	static inline void sun6i_dma_dump_chan_regs(struct sun6i_dma_dev *sdev,
   242						    struct sun6i_pchan *pchan)
   243	{
   244		dev_dbg(sdev->slave.dev, "Chan %d reg: 0x%lx\n"
   245			"\t___en(%04x): \t0x%08x\n"
   246			"\tpause(%04x): \t0x%08x\n"
   247			"\tstart(%04x): \t0x%08x\n"
   248			"\t__cfg(%04x): \t0x%08x\n"
   249			"\t__src(%04x): \t0x%08x\n"
   250			"\t__dst(%04x): \t0x%08x\n"
   251			"\tcount(%04x): \t0x%08x\n"
   252			"\t_para(%04x): \t0x%08x\n\n",
 > 253			pchan->idx, pchan->base - sdev->base,
   254			DMA_CHAN_ENABLE,
   255			readl(pchan->base + DMA_CHAN_ENABLE),
   256			DMA_CHAN_PAUSE,
   257			readl(pchan->base + DMA_CHAN_PAUSE),
   258			DMA_CHAN_LLI_ADDR,
   259			readl(pchan->base + DMA_CHAN_LLI_ADDR),
   260			DMA_CHAN_CUR_CFG,
   261			readl(pchan->base + DMA_CHAN_CUR_CFG),
   262			DMA_CHAN_CUR_SRC,
   263			readl(pchan->base + DMA_CHAN_CUR_SRC),
   264			DMA_CHAN_CUR_DST,
   265			readl(pchan->base + DMA_CHAN_CUR_DST),
   266			DMA_CHAN_CUR_CNT,
   267			readl(pchan->base + DMA_CHAN_CUR_CNT),
   268			DMA_CHAN_CUR_PARA,
   269			readl(pchan->base + DMA_CHAN_CUR_PARA));
   270	}
   271	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
