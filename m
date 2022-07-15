Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4A57667F
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jul 2022 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiGOSBr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jul 2022 14:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGOSBp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Jul 2022 14:01:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7EF42AD1;
        Fri, 15 Jul 2022 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657908104; x=1689444104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2oOfC55LrtmXB2jCaFUlj9F/z3nDDWKlHIARcSj/KtA=;
  b=eygym2Ej9RJSiINj3CJv99cLya4SEWGmUNGgjrxxy/f9tTYOKv4eA6OY
   M1O5o88HpRJ/BsizSFJov2C3m5xAkx/by1g9fZr0JZZKAflNkA5gu/2zy
   MBeoqwWyoZAHVinARRRX4Nb15CH6XZxc2Hb+4BiVW8LM0t0GO+50U/qd1
   PahFCPedoxr4j6BwwXIk97KAfcLgFZ7llWCpZzC2Ug8dHLJJWGzxtYRPK
   qLNxDPrRxOY/e7GdZc2e7KWpJYdEHvqCb9r/3ofwRDDNK/OMAccno1p0C
   zY5IfF7YlwW0uk1xab0zSI/MSZ7ZTiKuPiXtpFXva4YWC8fgktz9eBMYj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="283422717"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="283422717"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 11:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="546742759"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2022 11:01:40 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCPdD-0000c6-GP;
        Fri, 15 Jul 2022 18:01:39 +0000
Date:   Sat, 16 Jul 2022 02:01:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: Re: [PATCH v2 3/4] dmaengine: stm32-dma: add support to trigger
 STM32 MDMA
Message-ID: <202207160125.oxFFO8ZQ-lkp@intel.com>
References: <20220713142148.239253-4-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713142148.239253-4-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Amelie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on atorgue-stm32/stm32-next]
[also build test WARNING on lwn-2.6/docs-next vkoul-dmaengine/next linus/master v5.19-rc6 next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Amelie-Delaunay/STM32-DMA-MDMA-chaining-feature/20220713-222358
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
config: hexagon-buildonly-randconfig-r004-20220715 (https://download.01.org/0day-ci/archive/20220716/202207160125.oxFFO8ZQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 2da550140aa98cf6a3e96417c87f1e89e3a26047)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e1f4515659df0475a1e4d6dafd8559771c2b49b0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Amelie-Delaunay/STM32-DMA-MDMA-chaining-feature/20220713-222358
        git checkout e1f4515659df0475a1e4d6dafd8559771c2b49b0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/dma/ drivers/iio/adc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/dma/stm32-dma.c:211: warning: expecting prototype for struct stm32_dma_mdma_cfg. Prototype was for struct stm32_dma_mdma_config instead


vim +211 drivers/dma/stm32-dma.c

   199	
   200	/**
   201	 * struct stm32_dma_mdma_cfg - STM32 DMA MDMA configuration
   202	 * @stream_id: DMA request to trigger STM32 MDMA transfer
   203	 * @ifcr: DMA interrupt flag clear register address,
   204	 *        used by STM32 MDMA to clear DMA Transfer Complete flag
   205	 * @tcf: DMA Transfer Complete flag
   206	 */
   207	struct stm32_dma_mdma_config {
   208		u32 stream_id;
   209		u32 ifcr;
   210		u32 tcf;
 > 211	};
   212	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
