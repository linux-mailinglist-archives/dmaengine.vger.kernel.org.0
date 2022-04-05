Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC104F4F82
	for <lists+dmaengine@lfdr.de>; Wed,  6 Apr 2022 04:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiDFAwX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 20:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444576AbiDEPlo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 11:41:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BA4AD126
        for <dmaengine@vger.kernel.org>; Tue,  5 Apr 2022 07:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649167570; x=1680703570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N0NFTkpFQl/qecbw6wmL6YP13wN2X3pakdXix1QzrOI=;
  b=k9H6/UiukQOEhOW/W3nwZQzkgUnm/5Q+XfOvFrsSkwul3o2QDzqXgyYy
   6DLJTCrZKOffSDWndNOzhfa2mdw8AP4+1xdwGJDdN+BVoKWkt9IcPx3/r
   l3GV6sArwZrnanh6jQ8HeT2GvHb76sZ2PqSJv9snABPg3u8liQ38xECzg
   laK1pC2dQUE2UxpiA4iHq/tkNH2f7vgjlh/psgwnU03Cw4WzT9dvcaHfF
   RGCwJ+MMPEQ5GrV7HjchQfcdcOejkyxpLcPZEboHDXf0gtFL3UVPQWJ4W
   T4/zbhIQtMErWsqAjgouCUkLrGoBpwS/Nt4aVV8HY8uzc6AzON106+j/E
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260932517"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260932517"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="549067236"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Apr 2022 07:06:06 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbjos-0003Mh-45;
        Tue, 05 Apr 2022 14:06:06 +0000
Date:   Tue, 5 Apr 2022 22:05:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org
Cc:     kbuild-all@lists.01.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, Shengjiu Wang <shengjiu.wang@gmail.com>
Subject: Re: [PATCH v3 12/20] ASoC: fsl_micfil: add multi fifo support
Message-ID: <202204052143.2nZlY7hL-lkp@intel.com>
References: <20220405075959.2744803-13-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405075959.2744803-13-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sascha,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on shawnguo/for-next vkoul-dmaengine/next linus/master v5.18-rc1 next-20220405]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sascha-Hauer/ASoC-fsl_micfil-Driver-updates/20220405-161030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: alpha-randconfig-r023-20220405 (https://download.01.org/0day-ci/archive/20220405/202204052143.2nZlY7hL-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/05755df1cf507c46e44c4742bed6090e546b2905
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sascha-Hauer/ASoC-fsl_micfil-Driver-updates/20220405-161030
        git checkout 05755df1cf507c46e44c4742bed6090e546b2905
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash sound/soc/fsl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sound/soc/fsl/fsl_micfil.c:19:10: fatal error: linux/platform_data/dma-imx.h: No such file or directory
      19 | #include <linux/platform_data/dma-imx.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +19 sound/soc/fsl/fsl_micfil.c

     3	
     4	#include <linux/bitfield.h>
     5	#include <linux/clk.h>
     6	#include <linux/device.h>
     7	#include <linux/interrupt.h>
     8	#include <linux/kobject.h>
     9	#include <linux/kernel.h>
    10	#include <linux/module.h>
    11	#include <linux/of.h>
    12	#include <linux/of_address.h>
    13	#include <linux/of_irq.h>
    14	#include <linux/of_platform.h>
    15	#include <linux/pm_runtime.h>
    16	#include <linux/regmap.h>
    17	#include <linux/sysfs.h>
    18	#include <linux/types.h>
  > 19	#include <linux/platform_data/dma-imx.h>
    20	#include <sound/dmaengine_pcm.h>
    21	#include <sound/pcm.h>
    22	#include <sound/soc.h>
    23	#include <sound/tlv.h>
    24	#include <sound/core.h>
    25	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
