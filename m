Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B610973733C
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjFTRug (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 13:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjFTRuf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 13:50:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A0D10F9;
        Tue, 20 Jun 2023 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687283434; x=1718819434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/+vNaIXG9iaFY0nknjQbsz4ucYkJfdHZeLAfTVowxUw=;
  b=KsWXrLQjclS4AZkJfy67zU12PXSFSajBYhjkysXx4CQRheLTVhWP+SN7
   vFNQmITH0vCmmW4oFPZVZ8wNFl6Yd8ID5PYetmgce+r5Bbd2UWTDgL6Tm
   D7QP1ubaW3sPuDGdyMQxE/Jq2IdodEZehZ1QLeE7/rC9DtM8ZTcKSjCEz
   YAQy8niSbbK8j1UH18lKg8I6+ivSUPillS/oaDloCsETyOtqcXXDs2QGy
   Izjki2jXB+fojlib88RoQSTdKK2LSNrtNNUBr8lqZi7/IfHxJttJ1S0CN
   x+cBXQ/ktSKmU8U+yEt3nMjSnoIf4ZMmlaarQVK9C2BGsb85c+/DWWQS7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340278995"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="340278995"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="827097063"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="827097063"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2023 10:50:31 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBfUs-000664-1V;
        Tue, 20 Jun 2023 17:50:30 +0000
Date:   Wed, 21 Jun 2023 01:49:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: Re: [PATCH v8 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL
 in fsl-edma-common.c
Message-ID: <202306210131.zaHVasxz-lkp@intel.com>
References: <20230618180925.2350169-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618180925.2350169-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.4-rc7 next-20230620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-edma-clean-up-EXPORT_SYMBOL_GPL-in-fsl-edma-common-c/20230619-021341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20230618180925.2350169-2-Frank.Li%40nxp.com
patch subject: [PATCH v8 01/12] dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
config: s390-randconfig-c034-20230620 (https://download.01.org/0day-ci/archive/20230621/202306210131.zaHVasxz-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306210131.zaHVasxz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306210131.zaHVasxz-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x58): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0xc8): undefined reference to `iounmap'
   s390-linux-ld: drivers/dma/fsl-edma-main.o: in function `fsl_edma_probe':
   fsl-edma-main.c:(.text+0xb5c): undefined reference to `devm_platform_ioremap_resource'
>> s390-linux-ld: fsl-edma-main.c:(.text+0xf4c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   idma64.c:(.text+0x20ea): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
   xillybus_of.c:(.text+0xaa): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   drivers/pcmcia/cistpl.c:103: undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.c:110: undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.c:117: undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.c:118: undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   drivers/pcmcia/cistpl.c:72: undefined reference to `iounmap'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
