Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65107769A05
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jul 2023 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGaOs6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjGaOsz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 10:48:55 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB2610D0
        for <dmaengine@vger.kernel.org>; Mon, 31 Jul 2023 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690814932; x=1722350932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HFPGYWs4/zmSmWP047R6mExq1+V62JkVraQ6iMi1zME=;
  b=FAOWEGXc/MMTm50+TlADW5V2HxoD4HssyKlDl5CDZS6inLCX7WFOhRq1
   StXMaQcGKR47u2thI6NwuHfuNuhVOU0KbH8O5y/nHhbshAp0lo3EIrGaj
   Zcw3ThmGZTMBYOlC3FAduz0sc+aLumc3BNl44ryuwM6rUjFZcML0726LF
   An1AfctgHapuQAOJlGoOie7gLXKgzwb3MKBlmQPGNs3cy1qXk4LG6kmW8
   Ir0KsIzldaBz6c1GZvdb1FAfLD9qpiEqAMf40H2i6/vWGqSRLJCT+BSmg
   HdoULNkDTJQ98Yb9+M25V0DNGY3nsJSbeErLd/mp9SVlGAVybYfHpaAa2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353959253"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="353959253"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 07:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757966589"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="757966589"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 07:41:14 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQU4H-0005Ac-0g;
        Mon, 31 Jul 2023 14:40:31 +0000
Date:   Mon, 31 Jul 2023 22:39:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Michal Simek <monstr@monstr.eu>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/4] dmaengine: xilinx: xdma: Support cyclic transfers
Message-ID: <202307312225.9ewyJsVx-lkp@intel.com>
References: <20230731101442.792514-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731101442.792514-5-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.5-rc4 next-20230731]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/dmaengine-xilinx-xdma-Fix-interrupt-vector-setting/20230731-181620
base:   linus/master
patch link:    https://lore.kernel.org/r/20230731101442.792514-5-miquel.raynal%40bootlin.com
patch subject: [PATCH 4/4] dmaengine: xilinx: xdma: Support cyclic transfers
config: powerpc-randconfig-r026-20230731 (https://download.01.org/0day-ci/archive/20230731/202307312225.9ewyJsVx-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230731/202307312225.9ewyJsVx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307312225.9ewyJsVx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/xilinx/xdma.c:716:6: warning: variable 'desc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     716 |         if (vd)
         |             ^~
   drivers/dma/xilinx/xdma.c:718:7: note: uninitialized use occurs here
     718 |         if (!desc || !desc->cyclic) {
         |              ^~~~
   drivers/dma/xilinx/xdma.c:716:2: note: remove the 'if' if its condition is always true
     716 |         if (vd)
         |         ^~~~~~~
     717 |                 desc = to_xdma_desc(vd);
         | ~~~~~~~~~~~~~~~~
   drivers/dma/xilinx/xdma.c:703:24: note: initialize the variable 'desc' to silence this warning
     703 |         struct xdma_desc *desc;
         |                               ^
         |                                = NULL
   1 warning generated.


vim +716 drivers/dma/xilinx/xdma.c

   697	
   698	static enum dma_status xdma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
   699					      struct dma_tx_state *state)
   700	{
   701		struct xdma_chan *xdma_chan = to_xdma_chan(chan);
   702		struct virt_dma_desc *vd;
   703		struct xdma_desc *desc;
   704		enum dma_status ret;
   705		unsigned long flags;
   706		unsigned int period_idx;
   707		u32 residue = 0;
   708	
   709		ret = dma_cookie_status(chan, cookie, state);
   710		if (ret == DMA_COMPLETE || !state)
   711			return ret;
   712	
   713		spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
   714	
   715		vd = vchan_find_desc(&xdma_chan->vchan, cookie);
 > 716		if (vd)
   717			desc = to_xdma_desc(vd);
   718		if (!desc || !desc->cyclic) {
   719			spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
   720			return ret;
   721		}
   722	
   723		period_idx = desc->completed_desc_num % desc->periods;
   724		residue = (desc->periods - period_idx) * desc->period_size;
   725	
   726		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
   727	
   728		dma_set_residue(state, residue);
   729	
   730		return ret;
   731	}
   732	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
