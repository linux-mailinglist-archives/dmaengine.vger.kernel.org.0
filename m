Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6729955CF12
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiF0Gzq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 27 Jun 2022 02:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiF0Gzp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 02:55:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E99C559B;
        Sun, 26 Jun 2022 23:55:43 -0700 (PDT)
Received: from canpemm100008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LWdlB0WLTz9sx5;
        Mon, 27 Jun 2022 14:55:02 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 canpemm100008.china.huawei.com (7.192.104.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 14:55:40 +0800
Received: from kwepemm600007.china.huawei.com ([7.193.23.208]) by
 kwepemm600007.china.huawei.com ([7.193.23.208]) with mapi id 15.01.2375.024;
 Mon, 27 Jun 2022 14:55:40 +0800
From:   haijie <haijie1@huawei.com>
To:     kernel test robot <lkp@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/8] dmaengine: hisilicon: Fix CQ head update
Thread-Topic: [PATCH 2/8] dmaengine: hisilicon: Fix CQ head update
Thread-Index: AQHYiGfM3YbFHDZNZ0e0XQ9uDDsCpq1hLPWAgAGn48A=
Date:   Mon, 27 Jun 2022 06:55:40 +0000
Message-ID: <25b3ee4b9c574856aee9ed9c5293d43f@huawei.com>
References: <20220625074422.3479591-3-haijie1@huawei.com>
 <202206262132.9GLS9dHC-lkp@intel.com>
In-Reply-To: <202206262132.9GLS9dHC-lkp@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.102.167]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, kernel test robot,

Thanks and this will be corrected in the next version.

-----Original Message-----
From: kernel test robot [mailto:lkp@intel.com] 
Sent: Sunday, June 26, 2022 9:38 PM
To: haijie <haijie1@huawei.com>; vkoul@kernel.org; Wangzhou (B) <wangzhou1@hisilicon.com>
Cc: kbuild-all@lists.01.org; dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dmaengine: hisilicon: Fix CQ head update

Hi Jie,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vkoul-dmaengine/next] [also build test ERROR on linus/master v5.19-rc3 next-20220624] [If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in https://git-scm.com/docs/git-format-patch]

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
>> drivers/dma/hisi_dma.c:441:37: error: 'q_base' undeclared (first use 
>> in this function)
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
