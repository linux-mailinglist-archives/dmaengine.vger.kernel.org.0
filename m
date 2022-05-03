Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB192518582
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiECNgU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiECNgT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 09:36:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDFC33E84;
        Tue,  3 May 2022 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651584767; x=1683120767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JlxBmqr/aIao9xFMLDsFN5AI8Tah43lYMJLHQyXhOXQ=;
  b=JSLY7m+aal0ZRO/dki6fRnU+Pc7k3c+Cc/onybqG9yhXKuNR1J8//cYF
   tM8HfRCnqmwCoMJgqdMEakbdsZk80rmITwBnCIbYK01HI6ZPzP/pzgVMf
   BikbdEMqyWz/2P1RLqVDFhNoChIdQBVVEK2VsQSK8qhl7coxE6h+/pwbf
   o2DI6qfDO79/B5cqypY6O8mBzIjz/icKrgslMLTbaDFEuditLfrb4urnd
   WwTNO1rsmxyJKgcLroo87+x94vT7TPkB2Z1N1ojvt4q6q1QE4GcW0A5Om
   +Pp9s79bTFL59ZICJ4obuAFBRs6SCtw2Xn9V8YYUZxylammnAvFj8p7KL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267069472"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267069472"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 06:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="599070638"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 May 2022 06:32:44 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlsdv-000AUZ-Cs;
        Tue, 03 May 2022 13:32:43 +0000
Date:   Tue, 3 May 2022 21:32:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sean.wang@mediatek.com
Cc:     kbuild-all@lists.01.org, vkoul@kernel.org, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dmaengine: mediatek-cqdma: Add SoC-specific match
 data
Message-ID: <202205032104.sDnKlXcO-lkp@intel.com>
References: <20220503105328.54755-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503105328.54755-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi AngeloGioacchino,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on v5.18-rc5 next-20220503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/MediaTek-Helio-X10-MT6795-CQDMA-driver/20220503-185610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220503/202205032104.sDnKlXcO-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1516c04b4553b4a3037e86dada37c202af23e4b3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review AngeloGioacchino-Del-Regno/MediaTek-Helio-X10-MT6795-CQDMA-driver/20220503-185610
        git checkout 1516c04b4553b4a3037e86dada37c202af23e4b3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/dma/mediatek/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dma/mediatek/mtk-cqdma.c: In function 'mtk_cqdma_start':
   drivers/dma/mediatek/mtk-cqdma.c:243:42: error: implicit declaration of function 'to_cqma_dev'; did you mean 'to_cqdma_dev'? [-Werror=implicit-function-declaration]
     243 |         struct mtk_cqdma_device *cqdma = to_cqma_dev(cvd->ch);
         |                                          ^~~~~~~~~~~
         |                                          to_cqdma_dev
>> drivers/dma/mediatek/mtk-cqdma.c:243:42: warning: initialization of 'struct mtk_cqdma_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/dma/mediatek/mtk-cqdma.c:259:30: error: 'struct mtk_cqdma_device' has no member named 'plat'
     259 |         mtk_dma_set(pc, cqdma->plat->reg_src2, 0);
         |                              ^~
   drivers/dma/mediatek/mtk-cqdma.c:267:30: error: 'struct mtk_cqdma_device' has no member named 'plat'
     267 |         mtk_dma_set(pc, cqdma->plat->reg_dst2, 0);
         |                              ^~
   drivers/dma/mediatek/mtk-cqdma.c: At top level:
   drivers/dma/mediatek/mtk-cqdma.c:754:54: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     754 | static const struct mtk_cqdma_plat_data cqdma_mt6765 {
         |                                                      ^
   drivers/dma/mediatek/mtk-cqdma.c:760:59: error: 'cqdma_mt6765' undeclared here (not in a function)
     760 |         { .compatible = "mediatek,mt6765-cqdma", .data = &cqdma_mt6765 },
         |                                                           ^~~~~~~~~~~~
   drivers/dma/mediatek/mtk-cqdma.c: In function 'mtk_cqdma_probe':
   drivers/dma/mediatek/mtk-cqdma.c:777:14: error: 'struct mtk_cqdma_device' has no member named 'plat'
     777 |         cqdma->plat = device_get_match_data(&pdev->dev);
         |              ^~
   drivers/dma/mediatek/mtk-cqdma.c:778:18: error: 'struct mtk_cqdma_device' has no member named 'plat'
     778 |         if (cqdma->plat)
         |                  ^~
   cc1: some warnings being treated as errors


vim +243 drivers/dma/mediatek/mtk-cqdma.c

   239	
   240	static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
   241				    struct mtk_cqdma_vdesc *cvd)
   242	{
 > 243		struct mtk_cqdma_device *cqdma = to_cqma_dev(cvd->ch);
   244	
   245		/* wait for the previous transaction done */
   246		if (mtk_cqdma_poll_engine_done(pc, true) < 0)
   247			dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)), "cqdma wait transaction timeout\n");
   248	
   249		/* warm reset the dma engine for the new transaction */
   250		mtk_dma_set(pc, MTK_CQDMA_RESET, MTK_CQDMA_WARM_RST_BIT);
   251		if (mtk_cqdma_poll_engine_done(pc, true) < 0)
   252			dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)), "cqdma warm reset timeout\n");
   253	
   254		/* setup the source */
   255		mtk_dma_set(pc, MTK_CQDMA_SRC, cvd->src & MTK_CQDMA_ADDR_LIMIT);
   256	#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
   257		mtk_dma_set(pc, cqdma->plat->reg_src2, cvd->src >> MTK_CQDMA_ADDR2_SHFIT);
   258	#else
   259		mtk_dma_set(pc, cqdma->plat->reg_src2, 0);
   260	#endif
   261	
   262		/* setup the destination */
   263		mtk_dma_set(pc, MTK_CQDMA_DST, cvd->dest & MTK_CQDMA_ADDR_LIMIT);
   264	#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
   265		mtk_dma_set(pc, cqdma->plat->reg_dst2, cvd->dest >> MTK_CQDMA_ADDR2_SHFIT);
   266	#else
   267		mtk_dma_set(pc, cqdma->plat->reg_dst2, 0);
   268	#endif
   269	
   270		/* setup the length */
   271		mtk_dma_set(pc, MTK_CQDMA_LEN1, cvd->len);
   272	
   273		/* start dma engine */
   274		mtk_dma_set(pc, MTK_CQDMA_EN, MTK_CQDMA_EN_BIT);
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
