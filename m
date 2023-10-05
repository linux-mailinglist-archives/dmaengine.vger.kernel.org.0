Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889167BA86E
	for <lists+dmaengine@lfdr.de>; Thu,  5 Oct 2023 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjJERsF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Oct 2023 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjJERri (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Oct 2023 13:47:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112AC6;
        Thu,  5 Oct 2023 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696528056; x=1728064056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m2KYgIJRlXqKxK7hnx7y4PECzNsQwX7LLE3ZQMk+OyI=;
  b=Owds59HOIwsn26C5y+acD5+rqcfnqz0U/W9s3DCU9up2NOhquY0Ihckv
   v7LKBeltlyak5w1SrUNR6XMxyoEdOk1r2JBqeNH5oHhM8aeAjhrb6dzZj
   pzBwoOnbP18l2aoKliYsyYMtNWwUNwJcJEYYO3XtprDbcwKzIVGv+txUN
   pawjaOon9JtAzEXNDFHj7bsW97XLj5omNKP2I2LDEv8CdSZc8Ra++T1qe
   5ZQeZiOaNL/RUM08n4kB5g4rp6WWnZkcd9Dzdy60xRyRcukGNCLwpGDx+
   Vs/NlpbR1RrvDXH/LUVQt2+KKleRbKsCmd+mlAhgfUHP9Umuq3on9YW1V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="387444251"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="387444251"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 10:47:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999034222"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999034222"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2023 10:47:33 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoSRf-000Ljc-1n;
        Thu, 05 Oct 2023 17:47:31 +0000
Date:   Fri, 6 Oct 2023 01:46:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergey Khimich <serghox@gmail.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS >
 16
Message-ID: <202310060144.oLP6NoVL-lkp@intel.com>
References: <20231005113638.2039726-1-serghox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005113638.2039726-1-serghox@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sergey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.6-rc4 next-20231005]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergey-Khimich/dmaengine-dw-axi-dmac-Add-support-DMAX_NUM_CHANNELS-16/20231006-002509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20231005113638.2039726-1-serghox%40gmail.com
patch subject: [PATCH] dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231006/202310060144.oLP6NoVL-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310060144.oLP6NoVL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310060144.oLP6NoVL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'axi_chan_disable':
>> drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:202:33: warning: left shift count >= width of type [-Wshift-count-overflow]
     202 |                                 << (DMAC_CHAN_EN_SHIFT + DMAC_CHAN_BLOCK_SHIFT));
         |                                 ^~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:204:33: warning: left shift count >= width of type [-Wshift-count-overflow]
     204 |                                 << (DMAC_CHAN_EN2_WE_SHIFT + DMAC_CHAN_BLOCK_SHIFT);
         |                                 ^~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'axi_chan_enable':
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:229:33: warning: left shift count >= width of type [-Wshift-count-overflow]
     229 |                                 << (DMAC_CHAN_EN_SHIFT + DMAC_CHAN_BLOCK_SHIFT) |
         |                                 ^~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:231:33: warning: left shift count >= width of type [-Wshift-count-overflow]
     231 |                                 << (DMAC_CHAN_EN2_WE_SHIFT + DMAC_CHAN_BLOCK_SHIFT);
         |                                 ^~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'axi_chan_is_hw_enable':
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:260:66: warning: left shift count >= width of type [-Wshift-count-overflow]
     260 |                 return !!(val & ((BIT(chan->id) >> DMAC_CHAN_16) << DMAC_CHAN_BLOCK_SHIFT));
         |                                                                  ^~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'dma_chan_pause':
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1232:33: warning: left shift count >= width of type [-Wshift-count-overflow]
    1232 |                                 << (DMAC_CHAN_SUSP2_SHIFT + DMAC_CHAN_BLOCK_SHIFT) |
         |                                 ^~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1234:33: warning: left shift count >= width of type [-Wshift-count-overflow]
    1234 |                                 << (DMAC_CHAN_SUSP2_WE_SHIFT + DMAC_CHAN_BLOCK_SHIFT);
         |                                 ^~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'axi_chan_resume':
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1279:33: warning: left shift count >= width of type [-Wshift-count-overflow]
    1279 |                                 << (DMAC_CHAN_SUSP2_SHIFT + DMAC_CHAN_BLOCK_SHIFT));
         |                                 ^~
   drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1281:33: warning: left shift count >= width of type [-Wshift-count-overflow]
    1281 |                                 << (DMAC_CHAN_SUSP2_WE_SHIFT + DMAC_CHAN_BLOCK_SHIFT));
         |                                 ^~


vim +202 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c

   193	
   194	static inline void axi_chan_disable(struct axi_dma_chan *chan)
   195	{
   196		u64 val;
   197	
   198		if (chan->chip->dw->hdata->nr_channels >= DMAC_CHAN_16) {
   199			val = axi_dma_ioread64(chan->chip, DMAC_CHEN);
   200			if (chan->id >= DMAC_CHAN_16) {
   201				val &= ~((BIT(chan->id) >> DMAC_CHAN_16)
 > 202					<< (DMAC_CHAN_EN_SHIFT + DMAC_CHAN_BLOCK_SHIFT));
   203				val |=   (BIT(chan->id) >> DMAC_CHAN_16)
   204					<< (DMAC_CHAN_EN2_WE_SHIFT + DMAC_CHAN_BLOCK_SHIFT);
   205			} else {
   206				val &= ~(BIT(chan->id) << DMAC_CHAN_EN_SHIFT);
   207				val |=   BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
   208			}
   209			axi_dma_iowrite64(chan->chip, DMAC_CHEN, val);
   210		} else {
   211			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
   212			val &= ~(BIT(chan->id) << DMAC_CHAN_EN_SHIFT);
   213			if (chan->chip->dw->hdata->reg_map_8_channels)
   214				val |=   BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
   215			else
   216				val |=   BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
   217			axi_dma_iowrite32(chan->chip, DMAC_CHEN, (u32)val);
   218		}
   219	}
   220	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
