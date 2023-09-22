Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832897AB7FD
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 19:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjIVRoO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 13:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjIVRoN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 13:44:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E929F;
        Fri, 22 Sep 2023 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695404647; x=1726940647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=erDccOGpni/Pxklbfq3AGnS0yt/c6zFaReiV6D8hxuE=;
  b=miriu4WKpuR/tM9uZZ8OFMPB7tXs+rwz3C3BdNZX8nNrX6odXUGixOyU
   QMX4y9EpZQA5/H3R5ofaLshKwtatb5fEqnXXZW4Ja9/nSRO4aAc39z5Rl
   Iy+hNIu/HifuZiDvKj6I5hJ/ADN/C/T92scHtRn1tkXnlpQddp4E4i2Lh
   7Q4uL/gjc411Iv8GPYUkh74c+WhCQWZiH/o9a+EHznJeZgh4a/yXapWMk
   0ZE7vmFGHBG5hX65+OzB+buaPuGx/v6E7bykZSsIxO7rQMkFHXjA6GRo5
   +9MY3CLsQQs99kM/dZUZ2kS5xiIoC/0ExhdGx3kLSNKXrQ0IXwcqLMc04
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="378185016"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="378185016"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 10:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="747608750"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="747608750"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2023 10:44:04 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjkC9-00016T-2z;
        Fri, 22 Sep 2023 17:44:01 +0000
Date:   Sat, 23 Sep 2023 01:43:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>, Michal Simek <monstr@monstr.eu>
Cc:     oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/2] dmaengine: xilinx: xdma: Support cyclic transfers
Message-ID: <202309230103.YgvYkSCn-lkp@intel.com>
References: <20230922162056.594933-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922162056.594933-3-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.6-rc2]
[also build test WARNING on linus/master next-20230921]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Raynal/dmaengine-xilinx-xdma-Prepare-the-introduction-of-cyclic-transfers/20230923-002252
base:   v6.6-rc2
patch link:    https://lore.kernel.org/r/20230922162056.594933-3-miquel.raynal%40bootlin.com
patch subject: [PATCH v2 2/2] dmaengine: xilinx: xdma: Support cyclic transfers
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230923/202309230103.YgvYkSCn-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309230103.YgvYkSCn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309230103.YgvYkSCn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/xilinx/xdma.c:262: warning: Function parameter or member 'cyclic' not described in 'xdma_alloc_desc'


vim +262 drivers/dma/xilinx/xdma.c

17ce252266c7f0 Lizhi Hou     2023-01-19  254  
17ce252266c7f0 Lizhi Hou     2023-01-19  255  /**
17ce252266c7f0 Lizhi Hou     2023-01-19  256   * xdma_alloc_desc - Allocate descriptor
17ce252266c7f0 Lizhi Hou     2023-01-19  257   * @chan: DMA channel pointer
17ce252266c7f0 Lizhi Hou     2023-01-19  258   * @desc_num: Number of hardware descriptors
17ce252266c7f0 Lizhi Hou     2023-01-19  259   */
17ce252266c7f0 Lizhi Hou     2023-01-19  260  static struct xdma_desc *
9dfa9406316d5c Miquel Raynal 2023-09-22  261  xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num, bool cyclic)
17ce252266c7f0 Lizhi Hou     2023-01-19 @262  {
17ce252266c7f0 Lizhi Hou     2023-01-19  263  	struct xdma_desc *sw_desc;
17ce252266c7f0 Lizhi Hou     2023-01-19  264  	struct xdma_hw_desc *desc;
17ce252266c7f0 Lizhi Hou     2023-01-19  265  	dma_addr_t dma_addr;
17ce252266c7f0 Lizhi Hou     2023-01-19  266  	u32 dblk_num;
34df67fe3afc84 Miquel Raynal 2023-09-22  267  	u32 control;
17ce252266c7f0 Lizhi Hou     2023-01-19  268  	void *addr;
17ce252266c7f0 Lizhi Hou     2023-01-19  269  	int i, j;
17ce252266c7f0 Lizhi Hou     2023-01-19  270  
17ce252266c7f0 Lizhi Hou     2023-01-19  271  	sw_desc = kzalloc(sizeof(*sw_desc), GFP_NOWAIT);
17ce252266c7f0 Lizhi Hou     2023-01-19  272  	if (!sw_desc)
17ce252266c7f0 Lizhi Hou     2023-01-19  273  		return NULL;
17ce252266c7f0 Lizhi Hou     2023-01-19  274  
17ce252266c7f0 Lizhi Hou     2023-01-19  275  	sw_desc->chan = chan;
17ce252266c7f0 Lizhi Hou     2023-01-19  276  	sw_desc->desc_num = desc_num;
9dfa9406316d5c Miquel Raynal 2023-09-22  277  	sw_desc->cyclic = cyclic;
17ce252266c7f0 Lizhi Hou     2023-01-19  278  	dblk_num = DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
17ce252266c7f0 Lizhi Hou     2023-01-19  279  	sw_desc->desc_blocks = kcalloc(dblk_num, sizeof(*sw_desc->desc_blocks),
17ce252266c7f0 Lizhi Hou     2023-01-19  280  				       GFP_NOWAIT);
17ce252266c7f0 Lizhi Hou     2023-01-19  281  	if (!sw_desc->desc_blocks)
17ce252266c7f0 Lizhi Hou     2023-01-19  282  		goto failed;
17ce252266c7f0 Lizhi Hou     2023-01-19  283  
9dfa9406316d5c Miquel Raynal 2023-09-22  284  	if (cyclic)
9dfa9406316d5c Miquel Raynal 2023-09-22  285  		control = XDMA_DESC_CONTROL_CYCLIC;
9dfa9406316d5c Miquel Raynal 2023-09-22  286  	else
34df67fe3afc84 Miquel Raynal 2023-09-22  287  		control = XDMA_DESC_CONTROL(1, 0);
34df67fe3afc84 Miquel Raynal 2023-09-22  288  
17ce252266c7f0 Lizhi Hou     2023-01-19  289  	sw_desc->dblk_num = dblk_num;
17ce252266c7f0 Lizhi Hou     2023-01-19  290  	for (i = 0; i < sw_desc->dblk_num; i++) {
17ce252266c7f0 Lizhi Hou     2023-01-19  291  		addr = dma_pool_alloc(chan->desc_pool, GFP_NOWAIT, &dma_addr);
17ce252266c7f0 Lizhi Hou     2023-01-19  292  		if (!addr)
17ce252266c7f0 Lizhi Hou     2023-01-19  293  			goto failed;
17ce252266c7f0 Lizhi Hou     2023-01-19  294  
17ce252266c7f0 Lizhi Hou     2023-01-19  295  		sw_desc->desc_blocks[i].virt_addr = addr;
17ce252266c7f0 Lizhi Hou     2023-01-19  296  		sw_desc->desc_blocks[i].dma_addr = dma_addr;
17ce252266c7f0 Lizhi Hou     2023-01-19  297  		for (j = 0, desc = addr; j < XDMA_DESC_ADJACENT; j++)
34df67fe3afc84 Miquel Raynal 2023-09-22  298  			desc[j].control = cpu_to_le32(control);
17ce252266c7f0 Lizhi Hou     2023-01-19  299  	}
17ce252266c7f0 Lizhi Hou     2023-01-19  300  
9dfa9406316d5c Miquel Raynal 2023-09-22  301  	if (cyclic)
9dfa9406316d5c Miquel Raynal 2023-09-22  302  		xdma_link_cyclic_desc_blocks(sw_desc);
9dfa9406316d5c Miquel Raynal 2023-09-22  303  	else
34df67fe3afc84 Miquel Raynal 2023-09-22  304  		xdma_link_sg_desc_blocks(sw_desc);
17ce252266c7f0 Lizhi Hou     2023-01-19  305  
17ce252266c7f0 Lizhi Hou     2023-01-19  306  	return sw_desc;
17ce252266c7f0 Lizhi Hou     2023-01-19  307  
17ce252266c7f0 Lizhi Hou     2023-01-19  308  failed:
17ce252266c7f0 Lizhi Hou     2023-01-19  309  	xdma_free_desc(&sw_desc->vdesc);
17ce252266c7f0 Lizhi Hou     2023-01-19  310  	return NULL;
17ce252266c7f0 Lizhi Hou     2023-01-19  311  }
17ce252266c7f0 Lizhi Hou     2023-01-19  312  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
