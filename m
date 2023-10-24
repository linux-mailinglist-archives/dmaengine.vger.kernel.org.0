Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5420B7D5C2D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Oct 2023 22:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjJXUL2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Oct 2023 16:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbjJXUL2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Oct 2023 16:11:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B4A2;
        Tue, 24 Oct 2023 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698178286; x=1729714286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YudBLGZr0gCql3V9cMN5cR9Flg1k4kS3Q1phrCfKcdY=;
  b=OQWuoUwldmufqpZwmOzRG4P8Ysr5GxzwGivehvxjkwGbppRF6TcbLHpT
   LC+8/yrSRq4vNAsRC7g53Z6MIF6+uU/rTAf9/N+TS3hIBu0WQXekvstRA
   z18ohjCyC8CkYZom2XlTzi6XqUdA4BbCsVOF5g+QdrfrAkIeGJifPyFlb
   Rz2EwZIP5dzLEzeogPsF4kCEgHy8SCB3F5pAJUDQFFEzhnECsrIRvYX3q
   PEyajSluIwLLVotHDrU0W4C6Zb48hZ32hTj9/koMeeH2G3VbCDLSyoPk6
   X1/dm1TeYVajpqFUxCcl5vm/HV706ZENvg04vY9CEwfldgFDqoNTtnuU+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451386634"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="451386634"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 13:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="932152965"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="932152965"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2023 13:11:22 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvNkG-0008Er-21;
        Tue, 24 Oct 2023 20:11:20 +0000
Date:   Wed, 25 Oct 2023 04:10:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Mengqi <guomengqi3@huawei.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, xuqiang36@huawei.com,
        chenweilong@huawei.com, guomengqi3@huawei.com
Subject: Re: [PATCH v5 1/2] dmaengine: Add HiSilicon Ascend SDMA engine
 support
Message-ID: <202310250352.srnfVXxw-lkp@intel.com>
References: <20231021093454.39822-2-guomengqi3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021093454.39822-2-guomengqi3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Guo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.6-rc7 next-20231024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guo-Mengqi/dmaengine-Add-HiSilicon-Ascend-SDMA-engine-support/20231021-174034
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20231021093454.39822-2-guomengqi3%40huawei.com
patch subject: [PATCH v5 1/2] dmaengine: Add HiSilicon Ascend SDMA engine support
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20231025/202310250352.srnfVXxw-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231025/202310250352.srnfVXxw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310250352.srnfVXxw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/dma/hisi-ascend-sdma.c:6:
   drivers/dma/hisi-ascend-sdma.c: In function 'of_sdma_collect_info':
>> drivers/dma/hisi-ascend-sdma.c:683:31: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     683 |                 dev_warn(dev, "reg size %#llx check failed, use %#x\n",
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:146:61: note: in expansion of macro 'dev_fmt'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/dma/hisi-ascend-sdma.c:683:17: note: in expansion of macro 'dev_warn'
     683 |                 dev_warn(dev, "reg size %#llx check failed, use %#x\n",
         |                 ^~~~~~~~
   drivers/dma/hisi-ascend-sdma.c:683:45: note: format string is defined here
     683 |                 dev_warn(dev, "reg size %#llx check failed, use %#x\n",
         |                                         ~~~~^
         |                                             |
         |                                             long long unsigned int
         |                                         %#x


vim +683 drivers/dma/hisi-ascend-sdma.c

   658	
   659	static int of_sdma_collect_info(struct platform_device *pdev, struct sdma_hardware_info *info)
   660	{
   661		int ret;
   662		u32 chan_mask[2] = {0};
   663		struct resource res;
   664		struct device *dev = &pdev->dev;
   665		struct device_node *np = pdev->dev.of_node;
   666	
   667		ret = of_property_read_variable_u32_array(np, "dma-channel-mask",
   668				chan_mask, 1, 2);
   669		if (ret < 0) {
   670			dev_err(dev, "get dma channel mask from dtb failed, %d\n", ret);
   671			return ret;
   672		}
   673		bitmap_from_arr32(&info->channel_map, chan_mask, SDMA_MAX_CHANNEL_NUM);
   674	
   675		ret = of_address_to_resource(np, 0, &res);
   676		if (ret < 0) {
   677			dev_err(dev, "get io_base info from dtb failed, %d\n", ret);
   678			return ret;
   679		}
   680	
   681		info->base_addr = res.start;
   682		if (resource_size(&res) != SDMA_IOMEM_SIZE)
 > 683			dev_warn(dev, "reg size %#llx check failed, use %#x\n",
   684					resource_size(&res), SDMA_IOMEM_SIZE);
   685	
   686		return 0;
   687	}
   688	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
