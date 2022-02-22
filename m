Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC40A4C02FD
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiBVU2d (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 15:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiBVU2d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 15:28:33 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B9FB153A;
        Tue, 22 Feb 2022 12:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645561687; x=1677097687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jxp5Mg8uxJI/IXPsPKFUQEHG9hiu8FZCtEBbIRMLu8=;
  b=c1dEjXSog6SuJu8nzQ5emFHZWfa1QmaVtK7AJsNMe6QnYDyuC3O78j3F
   2VALdVFl+b8ihtjrFVeF/+RCXPm13Szaxec4qDKOWm34QTEUtES0SqLZF
   z4hvfQCqK2VAVuuhNo6lifH6xUkND7eT0lLbsUia3R/8V3JYt2E8Q4njn
   yXaEN5OLqUUX3aS/A5fG0mZAtuDXf3PTKGvARaXmsxYb2zeVmqfnZVQwH
   wSPSzKCm9ZbK1Fc45kjAUSi1UU59dGnr96+L358ivGvs9CLMUOCUHhZun
   t/i5iFQtKDT4Gs1hPI2kjJcxXchwKgLswleh6Q0hV74fTew82huwZ3Xgs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251725028"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="251725028"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 12:28:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="627825309"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Feb 2022 12:28:02 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMblR-0000bD-9X; Tue, 22 Feb 2022 20:28:01 +0000
Date:   Wed, 23 Feb 2022 04:27:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@lists.01.org, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 4/8] dma: dmamux: Introduce RZN1 DMA router support
Message-ID: <202202230444.xjzzeOlo-lkp@intel.com>
References: <20220222103437.194779-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222103437.194779-5-miquel.raynal@bootlin.com>
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

I love your patch! Yet something to improve:

[auto build test ERROR on geert-renesas-devel/next]
[also build test ERROR on geert-renesas-drivers/renesas-clk robh/for-next linus/master v5.17-rc5 next-20220217]
[cannot apply to vkoul-dmaengine/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/RZN1-DMA-support/20220222-183549
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220223/202202230444.xjzzeOlo-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b62059e893c7e3779b96e1c69ae6818260d352de
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miquel-Raynal/RZN1-DMA-support/20220222-183549
        git checkout b62059e893c7e3779b96e1c69ae6818260d352de
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: missing MODULE_LICENSE() in drivers/dma/dw/dmamux.o
>> ERROR: modpost: "r9a06g032_sysctrl_set_dmamux" [drivers/dma/dw/dmamux.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
