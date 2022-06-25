Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E316855A8BE
	for <lists+dmaengine@lfdr.de>; Sat, 25 Jun 2022 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiFYJhE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 Jun 2022 05:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiFYJhE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 Jun 2022 05:37:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63833E18;
        Sat, 25 Jun 2022 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656149823; x=1687685823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AosgoZ5iUyjESSvVZR9eYtSqDnBeirVxIJmgRqnV6CM=;
  b=h8glOvTbZxu09LHjmQr+IgYMlonY59fZtbyj3KDsItaJDIF7B+rweQW8
   T6lka8BpuIoHqA4WcOWE0i59wEljlgk+c2kuFXmg8oHOIg/mo9lnqZZyg
   DYumwpboYqgAEa9FORkbpZLSls+gkj2DKIUX7uzSLCaJ0ruosOMdtO6fd
   bwhFy0JgG5d98hyDSdHriRbsoVpskIiXeE4iN1PaTWa/lGRe1ysg/z8E+
   5Ws8uawCuQLZ4lxxjMB+82RZ0swxoScU4RSYMikzE6dlMelk/ch5Rpg8O
   8UHJlo8j2revgTUQRRBeS8Fj1B8DlZ/lIRw0JjhGmTfm3b3YCiLt8Im8m
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="260979963"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="260979963"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 02:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="835464737"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2022 02:37:01 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o52Ds-0005b5-GM;
        Sat, 25 Jun 2022 09:37:00 +0000
Date:   Sat, 25 Jun 2022 17:36:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jie Hai <haijie1@huawei.com>, vkoul@kernel.org,
        wangzhou1@hisilicon.com
Cc:     kbuild-all@lists.01.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] dmaengine: hisilicon: Add dfx feature for hisi dma
 driver
Message-ID: <202206251706.xUdAPcyU-lkp@intel.com>
References: <20220625074422.3479591-7-haijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625074422.3479591-7-haijie1@huawei.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Jie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v5.19-rc3 next-20220624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jie-Hai/dmaengine-hisilicon-Add-support-for-hisi-dma-driver/20220625-154524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
config: microblaze-randconfig-r022-20220625
compiler: microblaze-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
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

>> drivers/dma/hisi_dma.c:87: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
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
