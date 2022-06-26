Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0593755B249
	for <lists+dmaengine@lfdr.de>; Sun, 26 Jun 2022 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiFZNiT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 Jun 2022 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiFZNiT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 Jun 2022 09:38:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B7A45D;
        Sun, 26 Jun 2022 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656250698; x=1687786698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kxS+Hd8ciLGEOc4OUv7lM1xi/hzO+2ID9BxcmTd+74w=;
  b=PHze+GXEsiD3aTLdZEf7yYe9oNgrYeJAYtmQbP1d6JKZ2kdp+FZ09Q7o
   AZ86ENFERAw7jlfMht6+oxbbaATo3QXVwIposdMP21LRqiEf59NocsjVj
   UHyg+DXbXlIRSH/0JfP2t/SshDybnpjJQVqr4jIXW0h8rF9G82tplYx8r
   d/Z7Kbb9A0J+YA/kL5plJsqs9/lM4yEWAqTLlhr9iqCzH4IW2qE3/zn6G
   ixadXvqhtxsvGmnT3kvG9DyF466QVLOZia9T/eX8+gIplfFzPiuCgf3PO
   p0yo/yh6AQ0Gqn8Q3EusiGovkK/HfyvfR9SsIXKqQIn5mr34yqoytMuF2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="280040572"
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="280040572"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 06:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,224,1650956400"; 
   d="scan'208";a="616477359"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jun 2022 06:38:15 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5SSt-0007Lb-8K;
        Sun, 26 Jun 2022 13:38:15 +0000
Date:   Sun, 26 Jun 2022 21:37:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jie Hai <haijie1@huawei.com>, vkoul@kernel.org,
        wangzhou1@hisilicon.com
Cc:     kbuild-all@lists.01.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dmaengine: hisilicon: Fix CQ head update
Message-ID: <202206262132.9GLS9dHC-lkp@intel.com>
References: <20220625074422.3479591-3-haijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625074422.3479591-3-haijie1@huawei.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jie,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v5.19-rc3 next-20220624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jie-Hai/dmaengine-hisilicon-Add-support-for-hisi-dma-driver/20220625-154524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
config: arc-allyesconfig
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4a79d13d35e4f95c88bc0dfb44923dbd030bb126
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jie-Hai/dmaengine-hisilicon-Add-support-for-hisi-dma-driver/20220625-154524
        git checkout 4a79d13d35e4f95c88bc0dfb44923dbd030bb126
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-review/Jie-Hai/dmaengine-hisilicon-Add-support-for-hisi-dma-driver/20220625-154524 HEAD e823cc5940ad1d20993113591a7ba26946ae0840 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/dma/hisi_dma.c: In function 'hisi_dma_irq':
>> drivers/dma/hisi_dma.c:441:37: error: 'q_base' undeclared (first use in this function)
     441 |                 hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_HEAD_PTR,
         |                                     ^~~~~~
   drivers/dma/hisi_dma.c:441:37: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/dma/hisi_dma.c:441:45: error: 'HISI_DMA_Q_CQ_HEAD_PTR' undeclared (first use in this function); did you mean 'HISI_DMA_CQ_HEAD_PTR'?
     441 |                 hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_HEAD_PTR,
         |                                             ^~~~~~~~~~~~~~~~~~~~~~
         |                                             HISI_DMA_CQ_HEAD_PTR


vim +/q_base +441 drivers/dma/hisi_dma.c

   426	
   427	static irqreturn_t hisi_dma_irq(int irq, void *data)
   428	{
   429		struct hisi_dma_chan *chan = data;
   430		struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
   431		struct hisi_dma_desc *desc;
   432		struct hisi_dma_cqe *cqe;
   433	
   434		spin_lock(&chan->vc.lock);
   435	
   436		desc = chan->desc;
   437		cqe = chan->cq + chan->cq_head;
   438		if (desc) {
   439			chan->cq_head = (chan->cq_head + 1) %
   440					hdma_dev->chan_depth;
 > 441			hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_HEAD_PTR,
   442					    chan->qp_num, chan->cq_head);
   443			if (FIELD_GET(STATUS_MASK, cqe->w0) == STATUS_SUCC) {
   444				vchan_cookie_complete(&desc->vd);
   445			} else {
   446				dev_err(&hdma_dev->pdev->dev, "task error!\n");
   447			}
   448	
   449			chan->desc = NULL;
   450		}
   451	
   452		spin_unlock(&chan->vc.lock);
   453	
   454		return IRQ_HANDLED;
   455	}
   456	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
