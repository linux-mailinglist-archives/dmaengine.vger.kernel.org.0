Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CCC4BD0EF
	for <lists+dmaengine@lfdr.de>; Sun, 20 Feb 2022 20:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbiBTT3R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Feb 2022 14:29:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243180AbiBTT3O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Feb 2022 14:29:14 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6436442EDA;
        Sun, 20 Feb 2022 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645385333; x=1676921333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M7/i6xnRFkEXEKJukN+sGwvyQIdCKObg+1yeNQa6vvI=;
  b=BNK/veTKDtiptWH5dxPMC5ZcvrLF5fLhtLjyP+ShFD2U0qTCZDlJJU63
   BzPcnLU1vyekFx5rQ/HZIsvsVtBPKXzoSx4kAF+I2/RNOvIrTqf3Y/mMa
   6heqxyTifuQSp/sKwNxHohx7HNcDn6Az3c+2XEftOZmhbtp6HA7YqoNtr
   ZMWm8MpawNwM5BptEMLtxE65lI59gntrbXdPBERFb66UG76nGskJR/mBI
   GILIG7kPfW7TSveyx9bZnoAonj0MtYEMgCpkdY1JBZf3wvA5nxSHeKwaj
   uigWJ+38ReYvXQsUQqsKPZAjd71IaWGy3UnL+GtB26d9bysLRVvaxPiY1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="234937631"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="234937631"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 11:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="778502463"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Feb 2022 11:28:48 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLrt1-0000e7-Q2; Sun, 20 Feb 2022 19:28:47 +0000
Date:   Mon, 21 Feb 2022 03:28:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Laetitia MARIOTTINI <laetitia.mariottini@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 3/8] soc: renesas: rzn1-sysc: Export function to set
 dmamux
Message-ID: <202202210355.JzDJ9Lyz-lkp@intel.com>
References: <20220218181226.431098-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218181226.431098-4-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: arm-randconfig-r022-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210355.JzDJ9Lyz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/ed9b880ea7f2b23b42feeed7a6ed898cd09ae2f1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miquel-Raynal/RZN1-DMA-support/20220220-182519
        git checkout ed9b880ea7f2b23b42feeed7a6ed898cd09ae2f1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/renesas/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/renesas/r9a06g032-clocks.c:320:5: warning: no previous prototype for function 'r9a06g032_syscon_set_dmamux' [-Wmissing-prototypes]
   int r9a06g032_syscon_set_dmamux(u32 mask, u32 val)
       ^
   drivers/clk/renesas/r9a06g032-clocks.c:320:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int r9a06g032_syscon_set_dmamux(u32 mask, u32 val)
   ^
   static 
   1 warning generated.


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
