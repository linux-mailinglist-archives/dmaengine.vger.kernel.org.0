Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3EC4D3E92
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 02:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiCJBIX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 20:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiCJBIV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 20:08:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E5121534;
        Wed,  9 Mar 2022 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646874442; x=1678410442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fGSNyt7jWba9WqdnHOS4UIzGPJ7XPpWz0AKT3Bmx+oY=;
  b=RXq83Dc4z78gbFJwac1CCTGBAFM60HaQF9lU/bsoTHZLG5KgQBfC/hai
   gKBmuti+RV4fKXOjx6ilVU/yIr4AOcU2gUHc4Mwdu5iv32xn5dKMEzg4l
   Vw5FNSPdY1Fz6lUul7/ED+EpENwiye1SGYpC5aqYQOoEde416E92td/tn
   d5L/P/50GGTyaM7IHZjlpDhJfSTy7dqfNWGONZ0ppeZ3rA7qZ2pxAW6iw
   aB5UYdQcqhlypUua6Km9ae8rc180MR1aod82K3Fek+SjqjMj4H7E0m/uF
   Ru+iGLEG1tXjjBiqn0+sSYSTTnq5t7Iio3bEcNmlc1IzW1QkFfkLyeUqa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="242574206"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="242574206"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:07:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="611566901"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2022 17:07:16 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS7Gu-00046O-0H; Thu, 10 Mar 2022 01:07:16 +0000
Date:   Thu, 10 Mar 2022 09:07:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v4 7/8] dmaengine: dw-edma: add flags at struct
 dw_edma_chip
Message-ID: <202203100909.fpkA804r-lkp@intel.com>
References: <20220309211204.26050-8-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309211204.26050-8-Frank.Li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Frank,

I love your patch! Yet something to improve:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on helgaas-pci/next linus/master v5.17-rc7 next-20220309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Frank-Li/Enable-designware-PCI-EP-EDMA-locally/20220310-051510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220310/202203100909.fpkA804r-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f7947d784b0fe089bdaef2fee8e57f84e390d3f2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Frank-Li/Enable-designware-PCI-EP-EDMA-locally/20220310-051510
        git checkout f7947d784b0fe089bdaef2fee8e57f84e390d3f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/dma/dw-edma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/dma/dw-edma/dw-edma-v0-core.c:427:4: error: implicit declaration of function 'SET_CH_64' [-Werror,-Wimplicit-function-declaration]
                           SET_CH_64(dw, chan->dir, chan->id, llp.reg,
                           ^
>> drivers/dma/dw-edma/dw-edma-v0-core.c:427:39: error: use of undeclared identifier 'llp'
                           SET_CH_64(dw, chan->dir, chan->id, llp.reg,
                                                              ^
   2 errors generated.


vim +/SET_CH_64 +427 drivers/dma/dw-edma/dw-edma-v0-core.c

   359	
   360	void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
   361	{
   362		struct dw_edma_chan *chan = chunk->chan;
   363		struct dw_edma *dw = chan->dw;
   364		u32 tmp;
   365	
   366		dw_edma_v0_core_write_chunk(chunk);
   367	
   368		if (first) {
   369			/* Enable engine */
   370			SET_RW_32(dw, chan->dir, engine_en, BIT(0));
   371			if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
   372				switch (chan->id) {
   373				case 0:
   374					SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
   375						      BIT(0));
   376					break;
   377				case 1:
   378					SET_RW_COMPAT(dw, chan->dir, ch1_pwr_en,
   379						      BIT(0));
   380					break;
   381				case 2:
   382					SET_RW_COMPAT(dw, chan->dir, ch2_pwr_en,
   383						      BIT(0));
   384					break;
   385				case 3:
   386					SET_RW_COMPAT(dw, chan->dir, ch3_pwr_en,
   387						      BIT(0));
   388					break;
   389				case 4:
   390					SET_RW_COMPAT(dw, chan->dir, ch4_pwr_en,
   391						      BIT(0));
   392					break;
   393				case 5:
   394					SET_RW_COMPAT(dw, chan->dir, ch5_pwr_en,
   395						      BIT(0));
   396					break;
   397				case 6:
   398					SET_RW_COMPAT(dw, chan->dir, ch6_pwr_en,
   399						      BIT(0));
   400					break;
   401				case 7:
   402					SET_RW_COMPAT(dw, chan->dir, ch7_pwr_en,
   403						      BIT(0));
   404					break;
   405				}
   406			}
   407			/* Interrupt unmask - done, abort */
   408			tmp = GET_RW_32(dw, chan->dir, int_mask);
   409			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
   410			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
   411			SET_RW_32(dw, chan->dir, int_mask, tmp);
   412			/* Linked list error */
   413			tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
   414			tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
   415			SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
   416			/* Channel control */
   417			SET_CH_32(dw, chan->dir, chan->id, ch_control1,
   418				  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
   419			/* Linked list */
   420			if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
   421			    !IS_ENABLED(CONFIG_64BIT)) {
   422				SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
   423					  lower_32_bits(chunk->ll_region.paddr));
   424				SET_CH_32(dw, chan->dir, chan->id, llp.msb,
   425					  upper_32_bits(chunk->ll_region.paddr));
   426			} else {
 > 427				SET_CH_64(dw, chan->dir, chan->id, llp.reg,
   428					  chunk->ll_region.paddr);
   429			}
   430		}
   431		/* Doorbell */
   432		SET_RW_32(dw, chan->dir, doorbell,
   433			  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
   434	}
   435	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
