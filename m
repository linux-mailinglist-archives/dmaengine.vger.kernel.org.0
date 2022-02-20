Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7F84BD08F
	for <lists+dmaengine@lfdr.de>; Sun, 20 Feb 2022 19:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbiBTSRM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Feb 2022 13:17:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242781AbiBTSRL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Feb 2022 13:17:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD1E3135E;
        Sun, 20 Feb 2022 10:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645381010; x=1676917010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lIcyYOwdyn7z2tCHZIyCN4ToCOA0DGhj82Dg+n4foQA=;
  b=Hes0yJKjPyLIPqTCiWclSBIPvO/9q2DftDffI1cPjc2/YtUM39Gcfz0D
   EcKPkLiLrEvZejpK/ZeHELoEKtLVgVuyMANSO3c2GEWkLt7eHCUnKX6zk
   bS9gaM5kTtQM4VV+Pxo1oMHsfDZuJMijwkPcHg0lW6N0u8Mdvf/xdTOVO
   l2kIJ4UqG3Pj1vMuPVrqIWxh9GwVJ6UjWin8cs1MzcpLw6aN9+lrSixBX
   OYfacSsWJxurJPcxFmNT4KV5mlmvy2bjwhsOkFdE9KqRkyNm0uHHGsUc9
   oPb/rANs/29axSuXW+iSfvmhm2v4VQe8R+gR0BZlzhhiik3t61QD78lmA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="337824622"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="337824622"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 10:16:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="590735033"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2022 10:16:46 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLqlJ-0000ZK-Jw; Sun, 20 Feb 2022 18:16:45 +0000
Date:   Mon, 21 Feb 2022 02:16:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 3/8] soc: renesas: rzn1-sysc: Export function to set
 dmamux
Message-ID: <202202210247.Ul5J6pwr-lkp@intel.com>
References: <20220218181226.431098-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218181226.431098-4-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Miquel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on geert-renesas-devel/next]
[also build test WARNING on geert-renesas-drivers/renesas-clk robh/for-next linus/master v5.17-rc4 next-20220217]
[cannot apply to vkoul-dmaengine/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/RZN1-DMA-support/20220220-182519
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
config: arc-randconfig-r043-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210247.Ul5J6pwr-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/ed9b880ea7f2b23b42feeed7a6ed898cd09ae2f1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miquel-Raynal/RZN1-DMA-support/20220220-182519
        git checkout ed9b880ea7f2b23b42feeed7a6ed898cd09ae2f1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/clk/renesas/ drivers/mtd/spi-nor/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/renesas/r9a06g032-clocks.c:320:5: warning: no previous prototype for 'r9a06g032_syscon_set_dmamux' [-Wmissing-prototypes]
     320 | int r9a06g032_syscon_set_dmamux(u32 mask, u32 val)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/r9a06g032_syscon_set_dmamux +320 drivers/clk/renesas/r9a06g032-clocks.c

   317	
   318	/* Exported helper to access the DMAMUX register */
   319	static struct r9a06g032_priv *syscon_priv;
 > 320	int r9a06g032_syscon_set_dmamux(u32 mask, u32 val)
   321	{
   322		u32 dmamux;
   323	
   324		if (!syscon_priv)
   325			return -EPROBE_DEFER;
   326	
   327		spin_lock(&syscon_priv->lock);
   328	
   329		dmamux = readl(syscon_priv->reg + R9A06G032_SYSCON_DMAMUX);
   330		dmamux &= ~mask;
   331		dmamux |= val & mask;
   332		writel(dmamux, syscon_priv->reg + R9A06G032_SYSCON_DMAMUX);
   333	
   334		spin_unlock(&syscon_priv->lock);
   335	
   336		return 0;
   337	}
   338	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
