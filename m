Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDE5720272
	for <lists+dmaengine@lfdr.de>; Fri,  2 Jun 2023 14:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjFBM4g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Jun 2023 08:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjFBM4f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Jun 2023 08:56:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D97D196;
        Fri,  2 Jun 2023 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685710594; x=1717246594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=25GYVrBSeIZshbsRClfURyGuYpPyStjnVIsiOAveQYw=;
  b=GfoFtP09q1BlA/WcUsVAFDXAeFNKGMJdM/7CiJdn40dv7LpmD0LO3vUp
   PeEn/BrGBoaiI5y+6xNN/ZVmiGeo2fso0LH8y5RPV+bJqyt5zNrTl7otJ
   WAUi30okSES2Z4/dhQhU7oq4SMZjFAu0D07bYupnfJwAGPCG+1PpkuoVX
   IEft6303HkhgWD+LxxXrtR4Zftp1uErtzO5FXEKWV6EHLYxrFWgfGIKx9
   riCZJuK8cYUUJxaBWvHdmyeA21rg+3iWrj+kizy0HebIQO2Wcr+Rhw9l6
   OsNdCuMNUYuMIo0Mex5rIcORXhnOJsSeAKYepUf8/LrmMEPzMjuZAagly
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="419392208"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="419392208"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 05:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="831981005"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="831981005"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2023 05:56:30 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q54KT-0000Rd-2k;
        Fri, 02 Jun 2023 12:56:29 +0000
Date:   Fri, 2 Jun 2023 20:55:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, Yingkun Meng <mengyingkun@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH 2/2] dmaengine: ls2x-apb: new driver for the Loongson
 LS2X APB DMA controller
Message-ID: <202306022006.u6leN6i9-lkp@intel.com>
References: <f65ebee39b5e1827af08d9e8d1f260928915f9b0.1685448898.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f65ebee39b5e1827af08d9e8d1f260928915f9b0.1685448898.git.zhoubinbin@loongson.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Binbin,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on robh/for-next linus/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Zhou/dt-bindings-dmaengine-Add-Loongson-LS2X-APB-DMA-controller/20230531-165211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/f65ebee39b5e1827af08d9e8d1f260928915f9b0.1685448898.git.zhoubinbin%40loongson.cn
patch subject: [PATCH 2/2] dmaengine: ls2x-apb: new driver for the Loongson LS2X APB DMA controller
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230602/202306022006.u6leN6i9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c78b43fba2c7874dc293c0e2aba22c4e74500283
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Binbin-Zhou/dt-bindings-dmaengine-Add-Loongson-LS2X-APB-DMA-controller/20230531-165211
        git checkout c78b43fba2c7874dc293c0e2aba22c4e74500283
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306022006.u6leN6i9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/ls2x-apb-dma.c: In function 'ls2x_dma_write_cmd':
>> drivers/dma/ls2x-apb-dma.c:179:15: error: implicit declaration of function 'readq'; did you mean 'readw'? [-Werror=implicit-function-declaration]
     179 |         val = readq(priv->regs + LDMA_ORDER_ERG) & LDMA_ASK_ADDR_MASK;
         |               ^~~~~
         |               readw
   In file included from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/dma/ls2x-apb-dma.c:8:
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/dma/ls2x-apb-dma.c:33:33: note: in expansion of macro 'GENMASK'
      33 | #define LDMA_ASK_ADDR_MASK      GENMASK(63, 5) /* Ask Addr Mask */
         |                                 ^~~~~~~
   drivers/dma/ls2x-apb-dma.c:179:52: note: in expansion of macro 'LDMA_ASK_ADDR_MASK'
     179 |         val = readq(priv->regs + LDMA_ORDER_ERG) & LDMA_ASK_ADDR_MASK;
         |                                                    ^~~~~~~~~~~~~~~~~~
>> drivers/dma/ls2x-apb-dma.c:181:9: error: implicit declaration of function 'writeq'; did you mean 'writew'? [-Werror=implicit-function-declaration]
     181 |         writeq(val, priv->regs + LDMA_ORDER_ERG);
         |         ^~~~~~
         |         writew
   drivers/dma/ls2x-apb-dma.c: In function 'ls2x_dma_start_transfer':
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/dma/ls2x-apb-dma.c:33:33: note: in expansion of macro 'GENMASK'
      33 | #define LDMA_ASK_ADDR_MASK      GENMASK(63, 5) /* Ask Addr Mask */
         |                                 ^~~~~~~
   drivers/dma/ls2x-apb-dma.c:204:31: note: in expansion of macro 'LDMA_ASK_ADDR_MASK'
     204 |         val = (ldma_sg->llp & LDMA_ASK_ADDR_MASK) | LDMA_64BIT_EN | LDMA_START;
         |                               ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32:
   drivers/dma/ls2x-apb-dma.c: At top level:
>> drivers/dma/ls2x-apb-dma.c:628:25: error: 'ls2x_dma_dt_ids' undeclared here (not in a function); did you mean 'ls2x_dma_isr'?
     628 | MODULE_DEVICE_TABLE(of, ls2x_dma_dt_ids);
         |                         ^~~~~~~~~~~~~~~
   include/linux/module.h:244:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |               ^~~~
>> include/linux/module.h:244:21: error: '__mod_of__ls2x_dma_dt_ids_device_table' aliased to undefined symbol 'ls2x_dma_dt_ids'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |                     ^~~~~~
   drivers/dma/ls2x-apb-dma.c:628:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     628 | MODULE_DEVICE_TABLE(of, ls2x_dma_dt_ids);
         | ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +179 drivers/dma/ls2x-apb-dma.c

   173	
   174	static void ls2x_dma_write_cmd(struct ls2x_dma_chan *lchan, bool cmd)
   175	{
   176		u64 val = 0;
   177		struct ls2x_dma_priv *priv = to_ldma_priv(lchan->vchan.chan.device);
   178	
 > 179		val = readq(priv->regs + LDMA_ORDER_ERG) & LDMA_ASK_ADDR_MASK;
   180		val |= LDMA_64BIT_EN | cmd;
 > 181		writeq(val, priv->regs + LDMA_ORDER_ERG);
   182	}
   183	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
