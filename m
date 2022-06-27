Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E855C333
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiF0Gzc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 27 Jun 2022 02:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiF0Gza (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 02:55:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902095599;
        Sun, 26 Jun 2022 23:55:29 -0700 (PDT)
Received: from canpemm100007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LWdj47064z1L8Zs;
        Mon, 27 Jun 2022 14:53:12 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 canpemm100007.china.huawei.com (7.192.105.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 14:55:26 +0800
Received: from kwepemm600007.china.huawei.com ([7.193.23.208]) by
 kwepemm600007.china.huawei.com ([7.193.23.208]) with mapi id 15.01.2375.024;
 Mon, 27 Jun 2022 14:55:26 +0800
From:   haijie <haijie1@huawei.com>
To:     kernel test robot <lkp@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/8] dmaengine: hisilicon: Add dfx feature for hisi dma
 driver
Thread-Topic: [PATCH 6/8] dmaengine: hisilicon: Add dfx feature for hisi dma
 driver
Thread-Index: AQHYiGePl3qe1bnD2EmWvPQXM3aZFK1fVy6AgAN9IYA=
Date:   Mon, 27 Jun 2022 06:55:25 +0000
Message-ID: <3c9f48ded5214615af662f3e7351eb40@huawei.com>
References: <20220625074422.3479591-7-haijie1@huawei.com>
 <202206251706.xUdAPcyU-lkp@intel.com>
In-Reply-To: <202206251706.xUdAPcyU-lkp@intel.com>
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
Sent: Saturday, June 25, 2022 5:37 PM
To: haijie <haijie1@huawei.com>; vkoul@kernel.org; Wangzhou (B) <wangzhou1@hisilicon.com>
Cc: kbuild-all@lists.01.org; dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] dmaengine: hisilicon: Add dfx feature for hisi dma driver

Hi Jie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on vkoul-dmaengine/next] [also build test WARNING on linus/master v5.19-rc3 next-20220624] [If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jie-Hai/dmaengine-hisilicon-Add-support-for-hisi-dma-driver/20220625-154524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
config: microblaze-randconfig-r022-20220625
compiler: microblaze-linux-gcc (GCC) 11.3.0 reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ffaa89af83c2321f12a2b4d87711c9e7f7e37134
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jie-Hai/dmaengine-hisilicon-Add-support-for-hisi-dma-driver/20220625-154524
        git checkout ffaa89af83c2321f12a2b4d87711c9e7f7e37134
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/hisi_dma.c:87: warning: This comment starts with '/**', 
>> but isn't a kernel-doc comment. Refer 
>> Documentation/doc-guide/kernel-doc.rst
    * The HIP08B(HiSilicon IP08) and HIP09A(HiSilicon IP09) are DMA iEPs, they


vim +87 drivers/dma/hisi_dma.c

ffaa89af83c232 Jie Hai 2022-06-25  85
ae8a14d7255c1e Jie Hai 2022-06-25  86  /**
ae8a14d7255c1e Jie Hai 2022-06-25 @87   * The HIP08B(HiSilicon IP08) and HIP09A(HiSilicon IP09) are DMA iEPs, they
ae8a14d7255c1e Jie Hai 2022-06-25  88   * have the same pci device id but different pci revision.
ae8a14d7255c1e Jie Hai 2022-06-25  89   * Unfortunately, they have different register layouts, so two layout
ae8a14d7255c1e Jie Hai 2022-06-25  90   * enumerations are defined.
ae8a14d7255c1e Jie Hai 2022-06-25  91   */
ae8a14d7255c1e Jie Hai 2022-06-25  92  enum hisi_dma_reg_layout {
ae8a14d7255c1e Jie Hai 2022-06-25  93  	HISI_DMA_REG_LAYOUT_INVALID = 0,
ae8a14d7255c1e Jie Hai 2022-06-25  94  	HISI_DMA_REG_LAYOUT_HIP08,
ae8a14d7255c1e Jie Hai 2022-06-25  95  	HISI_DMA_REG_LAYOUT_HIP09
ae8a14d7255c1e Jie Hai 2022-06-25  96  };
7ddbde084de590 Jie Hai 2022-06-25  97  

--
0-DAY CI Kernel Test Service
https://01.org/lkp
