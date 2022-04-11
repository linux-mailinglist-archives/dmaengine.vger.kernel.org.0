Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B796F4FB5A7
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbiDKINL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 04:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiDKINL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 04:13:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C03DDFB;
        Mon, 11 Apr 2022 01:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649664657; x=1681200657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hPb1P11BoaRdswU6QxaSdbDYm7MHWgRDtXX/XYA3XRg=;
  b=i170sgS0bk+zZa8v8TygcpcPlpzgZdg7SZPHD+Q/VoKNuFRUl7Iwn5Dg
   kp9TVOc6vmSBFvJq/f+BYzXgXjwHaW+RkpNt/O6eDCofJALfyXZhRIoSv
   8J6CEl1ZwCgkhcDobWhU4O48PLscnWtT60jSjxCMoSBHHZrc8QfxrIv/I
   u8dJc+wgyKHHF6aXC7KWA61xHASSrTJmDVJqSTzDY+fKkWYNxM8GMKLha
   KQgyv3bTqF3EmOQ8pc9E6YDBuu1edplVkgS8n2JCq3CRKubF0idSTc2Nu
   m6GNoyuZ0ENGENqguIbqYexTpbtf3aWttEVVfzoYpIQ4KbZvtkCnPDliT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322508171"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="322508171"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="853838324"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Apr 2022 01:10:53 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndp8O-0001fn-Pn;
        Mon, 11 Apr 2022 08:10:52 +0000
Date:   Mon, 11 Apr 2022 16:10:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/4] dmaengine: sun6i: Do not use virt_to_phys
Message-ID: <202204111614.kGz2adbh-lkp@intel.com>
References: <20220411044633.39014-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411044633.39014-3-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
[cannot apply to mripard/sunxi/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/dmaengine-sun6i-Allwinner-D1-support/20220411-124826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
config: microblaze-buildonly-randconfig-r004-20220411 (https://download.01.org/0day-ci/archive/20220411/202204111614.kGz2adbh-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/280420721fd264a03a3d3f9fbe2b4e6bfddd0f79
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Samuel-Holland/dmaengine-sun6i-Allwinner-D1-support/20220411-124826
        git checkout 280420721fd264a03a3d3f9fbe2b4e6bfddd0f79
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/dma/sun6i-dma.c:12:
   drivers/dma/sun6i-dma.c: In function 'sun6i_dma_dump_chan_regs':
>> drivers/dma/sun6i-dma.c:244:34: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'int' [-Wformat=]
     244 |         dev_dbg(sdev->slave.dev, "Chan %d reg: 0x%lx\n"
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                         ^~~
   include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
     163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
         |                                             ^~~~~~~
   drivers/dma/sun6i-dma.c:244:9: note: in expansion of macro 'dev_dbg'
     244 |         dev_dbg(sdev->slave.dev, "Chan %d reg: 0x%lx\n"
         |         ^~~~~~~
   drivers/dma/sun6i-dma.c:244:52: note: format string is defined here
     244 |         dev_dbg(sdev->slave.dev, "Chan %d reg: 0x%lx\n"
         |                                                  ~~^
         |                                                    |
         |                                                    long unsigned int
         |                                                  %x


vim +244 drivers/dma/sun6i-dma.c

   240	
   241	static inline void sun6i_dma_dump_chan_regs(struct sun6i_dma_dev *sdev,
   242						    struct sun6i_pchan *pchan)
   243	{
 > 244		dev_dbg(sdev->slave.dev, "Chan %d reg: 0x%lx\n"
   245			"\t___en(%04x): \t0x%08x\n"
   246			"\tpause(%04x): \t0x%08x\n"
   247			"\tstart(%04x): \t0x%08x\n"
   248			"\t__cfg(%04x): \t0x%08x\n"
   249			"\t__src(%04x): \t0x%08x\n"
   250			"\t__dst(%04x): \t0x%08x\n"
   251			"\tcount(%04x): \t0x%08x\n"
   252			"\t_para(%04x): \t0x%08x\n\n",
   253			pchan->idx, pchan->base - sdev->base,
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
