Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1646E694AEE
	for <lists+dmaengine@lfdr.de>; Mon, 13 Feb 2023 16:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBMPUb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Feb 2023 10:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjBMPUa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Feb 2023 10:20:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8607B76A4;
        Mon, 13 Feb 2023 07:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676301627; x=1707837627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObQP9l0TevncY/9K8ieb/b6KtPH6c9i6zQUdHqY1bFg=;
  b=hP9Cfkx+BJQQ4YyOp7gONaFgeVs264mPywHV27uEe+1K0QocCsTQWFaN
   3+1u1MtInoEPHaTuK5IP29utZtfyPsvR4tOz0V+Eg9bVpx7Nwn/MOOaZX
   KcBPAX1vgW7mfL5HDl6O4w+zRq6gUiTunUZa4wBqtJMacvgJ0Yv88rlQQ
   BmdDf77Vlb4EDC5S9Tuj9LkJJ5TYQ2haS1ubzAC24TjEw5VLxLpPELFkr
   NfRVa+e0IFuqrnJ/yekqTxgt3iu8SR5gF8AI9jmsH9XKvgdrEF7s0CVR+
   a3f1faFaQi0GGeExnHcHZtj/QRVMWvAPwQ6f5BV6GBIPZVJnc3lqrXaCT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333047988"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333047988"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 07:20:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="699196719"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="699196719"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Feb 2023 07:20:23 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRacw-0007op-2S;
        Mon, 13 Feb 2023 15:20:22 +0000
Date:   Mon, 13 Feb 2023 23:20:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Sergey.Semin@baikalelectronics.ru
Cc:     oe-kbuild-all@lists.linux.dev, Cai huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <202302132344.oOgPHjYP-lkp@intel.com>
References: <20230213132411.65524-4-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213132411.65524-4-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Cai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20230213]
[cannot apply to vkoul-dmaengine/next linus/master v6.2-rc8 v6.2-rc7 v6.2-rc6 v6.2-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cai-Huoqing/dmaengine-dw-edma-Rename-dw_edma_core_ops-structure-to-dw_edma_plat_ops/20230213-213412
patch link:    https://lore.kernel.org/r/20230213132411.65524-4-cai.huoqing%40linux.dev
patch subject: [PATCH v3 3/4] dmaengine: dw-edma: Add support for native HDMA
config: i386-randconfig-a016-20230213 (https://download.01.org/0day-ci/archive/20230213/202302132344.oOgPHjYP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/04d89cfa187deda4fa5a7cc947dbb797ce05e72f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cai-Huoqing/dmaengine-dw-edma-Rename-dw_edma_core_ops-structure-to-dw_edma_plat_ops/20230213-213412
        git checkout 04d89cfa187deda4fa5a7cc947dbb797ce05e72f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302132344.oOgPHjYP-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/dw-edma/dw-hdma-v0-core.c: In function 'dw_hdma_v0_write_ll_data':
>> drivers/dma/dw-edma/dw-hdma-v0-core.c:195:17: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
     195 |                 writeq(sar, &lli->sar.reg);
         |                 ^~~~~~
         |                 writel
   cc1: some warnings being treated as errors


vim +195 drivers/dma/dw-edma/dw-hdma-v0-core.c

   177	
   178	static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
   179					     u32 control, u32 size, u64 sar, u64 dar)
   180	{
   181		ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
   182	
   183		if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
   184			struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
   185	
   186			lli->control = control;
   187			lli->transfer_size = size;
   188			lli->sar.reg = sar;
   189			lli->dar.reg = dar;
   190		} else {
   191			struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
   192	
   193			writel(control, &lli->control);
   194			writel(size, &lli->transfer_size);
 > 195			writeq(sar, &lli->sar.reg);
   196			writeq(dar, &lli->dar.reg);
   197		}
   198	}
   199	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
