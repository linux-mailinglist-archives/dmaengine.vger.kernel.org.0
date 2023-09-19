Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC17A6FAE
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjISXvq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Sep 2023 19:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjISXvp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Sep 2023 19:51:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612DBC9;
        Tue, 19 Sep 2023 16:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695167498; x=1726703498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hWI5yKjRNjw1L5BCA0gWNtIRjZ6cJ+2M9IG2WFP/77Y=;
  b=OIWH/V4DT4K2QXDMDU8vKahsWb/KdRMxqi+OahstAgWaoo2jSvLqGWYf
   vmdJsEwbI34tozfmXz/+L9w7mX4aUYWheaCupcR7cUHVqaK6ai+hsWOiY
   XebCdJd+jURpamUGZsEd5ecD8XwBqrze2yYqU+UtqOazdIZJP26rdAjVP
   wyNRagLo4vQzFKoSktXH1DU/Tsf2LuApk6aeTvJrGsRi0OlSH5BFkawQR
   gZuN0/krwYpdK9y0rPhM/R/d0IVQSGmDpVinL6v4mJU8oYIWCEL2GMa0u
   qmaAYGbo5gQkHW20c6Z8GcleUJYJEDZROgqLnnTjmRHMcF8iDeTZQd2Pl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="466399146"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="466399146"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 16:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="811917263"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="811917263"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 19 Sep 2023 16:51:34 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qikVA-00084m-2C;
        Tue, 19 Sep 2023 23:51:32 +0000
Date:   Wed, 20 Sep 2023 07:51:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dmaengine: fsl-emda: add debugfs support
Message-ID: <202309200741.0Cx6Gz9M-lkp@intel.com>
References: <20230919151430.2919042-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919151430.2919042-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.6-rc2 next-20230919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-emda-add-debugfs-support/20230920-010257
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20230919151430.2919042-2-Frank.Li%40nxp.com
patch subject: [PATCH v2 1/2] dmaengine: fsl-emda: add debugfs support
config: x86_64-randconfig-123-20230920 (https://download.01.org/0day-ci/archive/20230920/202309200741.0Cx6Gz9M-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309200741.0Cx6Gz9M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309200741.0Cx6Gz9M-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/dma/fsl-edma-debugfs.c:17:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-debugfs.c:17:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:18:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:18:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:19:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:19:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:20:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:20:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:21:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:21:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:22:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:22:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:23:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:23:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:24:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:24:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:25:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:25:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:26:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:26:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:27:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:27:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/fsl-edma-debugfs.c:35:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/fsl-edma-debugfs.c:72:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *cr @@
   drivers/dma/fsl-edma-debugfs.c:72:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:72:9: sparse:     got void [noderef] __iomem *cr
>> drivers/dma/fsl-edma-debugfs.c:73:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *es @@
   drivers/dma/fsl-edma-debugfs.c:73:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:73:9: sparse:     got void [noderef] __iomem *es
>> drivers/dma/fsl-edma-debugfs.c:74:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *erqh @@
   drivers/dma/fsl-edma-debugfs.c:74:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:74:9: sparse:     got void [noderef] __iomem *erqh
>> drivers/dma/fsl-edma-debugfs.c:75:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *erql @@
   drivers/dma/fsl-edma-debugfs.c:75:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:75:9: sparse:     got void [noderef] __iomem *erql
>> drivers/dma/fsl-edma-debugfs.c:76:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *eeih @@
   drivers/dma/fsl-edma-debugfs.c:76:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:76:9: sparse:     got void [noderef] __iomem *eeih
>> drivers/dma/fsl-edma-debugfs.c:77:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *eeil @@
   drivers/dma/fsl-edma-debugfs.c:77:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:77:9: sparse:     got void [noderef] __iomem *eeil
>> drivers/dma/fsl-edma-debugfs.c:78:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *seei @@
   drivers/dma/fsl-edma-debugfs.c:78:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:78:9: sparse:     got void [noderef] __iomem *seei
>> drivers/dma/fsl-edma-debugfs.c:79:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *ceei @@
   drivers/dma/fsl-edma-debugfs.c:79:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:79:9: sparse:     got void [noderef] __iomem *ceei
>> drivers/dma/fsl-edma-debugfs.c:80:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *serq @@
   drivers/dma/fsl-edma-debugfs.c:80:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:80:9: sparse:     got void [noderef] __iomem *serq
>> drivers/dma/fsl-edma-debugfs.c:81:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *cerq @@
   drivers/dma/fsl-edma-debugfs.c:81:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:81:9: sparse:     got void [noderef] __iomem *cerq
>> drivers/dma/fsl-edma-debugfs.c:82:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *cint @@
   drivers/dma/fsl-edma-debugfs.c:82:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:82:9: sparse:     got void [noderef] __iomem *cint
>> drivers/dma/fsl-edma-debugfs.c:83:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *cerr @@
   drivers/dma/fsl-edma-debugfs.c:83:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:83:9: sparse:     got void [noderef] __iomem *cerr
>> drivers/dma/fsl-edma-debugfs.c:84:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *ssrt @@
   drivers/dma/fsl-edma-debugfs.c:84:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:84:9: sparse:     got void [noderef] __iomem *ssrt
>> drivers/dma/fsl-edma-debugfs.c:85:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *cdne @@
   drivers/dma/fsl-edma-debugfs.c:85:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:85:9: sparse:     got void [noderef] __iomem *cdne
>> drivers/dma/fsl-edma-debugfs.c:86:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *inth @@
   drivers/dma/fsl-edma-debugfs.c:86:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:86:9: sparse:     got void [noderef] __iomem *inth
>> drivers/dma/fsl-edma-debugfs.c:87:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *errh @@
   drivers/dma/fsl-edma-debugfs.c:87:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:87:9: sparse:     got void [noderef] __iomem *errh
>> drivers/dma/fsl-edma-debugfs.c:88:9: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected unsigned int [usertype] *value @@     got void [noderef] __iomem *errl @@
   drivers/dma/fsl-edma-debugfs.c:88:9: sparse:     expected unsigned int [usertype] *value
   drivers/dma/fsl-edma-debugfs.c:88:9: sparse:     got void [noderef] __iomem *errl

vim +/__iomem +17 drivers/dma/fsl-edma-debugfs.c

    11	
    12	#define fsl_edma_debugfs_regv1(reg, dir, __name)				\
    13		debugfs_create_x32(__stringify(__name), 0644, dir, reg.__name)
    14	
    15	static void fsl_edma_debufs_tcdreg(struct fsl_edma_chan *chan, struct dentry *dir)
    16	{
  > 17		fsl_edma_debugfs_reg(chan->tcd, dir, saddr);
    18		fsl_edma_debugfs_reg(chan->tcd, dir, soff);
    19		fsl_edma_debugfs_reg(chan->tcd, dir, attr);
    20		fsl_edma_debugfs_reg(chan->tcd, dir, nbytes);
    21		fsl_edma_debugfs_reg(chan->tcd, dir, slast);
    22		fsl_edma_debugfs_reg(chan->tcd, dir, daddr);
    23		fsl_edma_debugfs_reg(chan->tcd, dir, doff);
  > 24		fsl_edma_debugfs_reg(chan->tcd, dir, citer);
  > 25		fsl_edma_debugfs_reg(chan->tcd, dir, dlast_sga);
    26		fsl_edma_debugfs_reg(chan->tcd, dir, csr);
  > 27		fsl_edma_debugfs_reg(chan->tcd, dir, biter);
    28	}
    29	
    30	static void fsl_edma3_debufs_chan(struct fsl_edma_chan *chan, struct dentry *entry)
    31	{
    32		struct fsl_edma3_ch_reg *reg;
    33		struct dentry *dir;
    34	
    35		reg = container_of(chan->tcd, struct fsl_edma3_ch_reg, tcd);
    36		fsl_edma_debugfs_reg(reg, entry, ch_csr);
    37		fsl_edma_debugfs_reg(reg, entry, ch_int);
    38		fsl_edma_debugfs_reg(reg, entry, ch_sbr);
    39		fsl_edma_debugfs_reg(reg, entry, ch_pri);
    40		fsl_edma_debugfs_reg(reg, entry, ch_mux);
    41		fsl_edma_debugfs_reg(reg, entry, ch_mattr);
    42	
    43		dir = debugfs_create_dir("tcd_regs", entry);
    44	
    45		fsl_edma_debufs_tcdreg(chan, dir);
    46	}
    47	
    48	static void fsl_edma3_debugfs_init(struct fsl_edma_engine *edma)
    49	{
    50		struct fsl_edma_chan *chan;
    51		struct dentry *dir;
    52		int i;
    53	
    54		for (i = 0; i < edma->n_chans; i++) {
    55			if (edma->chan_masked & BIT(i))
    56				continue;
    57	
    58			chan = &edma->chans[i];
    59			dir = debugfs_create_dir(chan->chan_name, edma->dma_dev.dbg_dev_root);
    60	
    61			fsl_edma3_debufs_chan(chan, dir);
    62		}
    63	
    64	}
    65	
    66	static void fsl_edma_debugfs_init(struct fsl_edma_engine *edma)
    67	{
    68		struct fsl_edma_chan *chan;
    69		struct dentry *dir;
    70		int i;
    71	
  > 72		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cr);
  > 73		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, es);
  > 74		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, erqh);
  > 75		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, erql);
  > 76		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, eeih);
  > 77		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, eeil);
  > 78		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, seei);
  > 79		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, ceei);
  > 80		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, serq);
  > 81		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cerq);
  > 82		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cint);
  > 83		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cerr);
  > 84		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, ssrt);
  > 85		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, cdne);
  > 86		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, inth);
  > 87		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, errh);
  > 88		fsl_edma_debugfs_regv1(edma->regs, edma->dma_dev.dbg_dev_root, errl);
    89	
    90		for (i = 0; i < edma->n_chans; i++) {
    91			if (edma->chan_masked & BIT(i))
    92				continue;
    93	
    94			chan = &edma->chans[i];
    95			dir = debugfs_create_dir(chan->chan_name, edma->dma_dev.dbg_dev_root);
    96	
    97			fsl_edma_debufs_tcdreg(chan, dir);
    98		}
    99	}
   100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
