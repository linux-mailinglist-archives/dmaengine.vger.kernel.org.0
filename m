Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F17A8EAA
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 23:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjITVpU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 17:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjITVpU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 17:45:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBABCA3;
        Wed, 20 Sep 2023 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695246313; x=1726782313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mae0R828eRcYBJfhPsWcpEqbpL5UEVSwKtsrdnvQcTU=;
  b=O5DMdbQXrpMGJJ6CMQzt26vmPpA/e6XjIjY+RACHymtN6EosLO3px/JU
   Kn5gOFV5tDIYmSvV5g6ZyvvEAzl9uvtJ+X9c8S0365nOTJPFQDxTdMv2a
   Q/GTOLpJWmKpJLCVvc68v4FnXTYDo4xXmqHixJ7KixKZh436U5KqfiPht
   feF8Jl28Q1O5FE+sBG2vXY5eG/dZtV10ECExaEz51GkNjNWFBlh2ENBco
   sMc/0luqEyYZX/SisS08E/xq5Cerf7ouxB+7GPXrozGnuYdYrjv/qmEu1
   MLiQeHDDNT+4VnCM/zV2ycHyIJarXqRCZxwR8hHJghSQ/RM1tQJBxIrwL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="365409905"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="365409905"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 14:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="776166984"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="776166984"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2023 14:45:09 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qj50M-0009B8-2l;
        Wed, 20 Sep 2023 21:45:06 +0000
Date:   Thu, 21 Sep 2023 05:45:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dmaengine: fsl-emda: add debugfs support
Message-ID: <202309210500.owiirl4c-lkp@intel.com>
References: <20230919151430.2919042-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919151430.2919042-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.6-rc2 next-20230920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-emda-add-debugfs-support/20230920-010257
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20230919151430.2919042-2-Frank.Li%40nxp.com
patch subject: [PATCH v2 1/2] dmaengine: fsl-emda: add debugfs support
config: arm-imxrt_defconfig (https://download.01.org/0day-ci/archive/20230921/202309210500.owiirl4c-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309210500.owiirl4c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309210500.owiirl4c-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/dma/fsl-edma-main.c:24:
>> drivers/dma/fsl-edma-common.h:342:47: warning: 'struct dw_edma' declared inside parameter list will not be visible outside of this definition or declaration
     342 | static inline void fsl_edma_debugfs_on(struct dw_edma *edma)
         |                                               ^~~~~~~
   drivers/dma/fsl-edma-main.c: In function 'fsl_edma_probe':
>> drivers/dma/fsl-edma-main.c:615:29: error: passing argument 1 of 'fsl_edma_debugfs_on' from incompatible pointer type [-Werror=incompatible-pointer-types]
     615 |         fsl_edma_debugfs_on(fsl_edma);
         |                             ^~~~~~~~
         |                             |
         |                             struct fsl_edma_engine *
   In file included from drivers/dma/fsl-edma-main.c:24:
   drivers/dma/fsl-edma-common.h:342:56: note: expected 'struct dw_edma *' but argument is of type 'struct fsl_edma_engine *'
     342 | static inline void fsl_edma_debugfs_on(struct dw_edma *edma)
         |                                        ~~~~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/dma/fsl-edma-common.c:13:
>> drivers/dma/fsl-edma-common.h:342:47: warning: 'struct dw_edma' declared inside parameter list will not be visible outside of this definition or declaration
     342 | static inline void fsl_edma_debugfs_on(struct dw_edma *edma)
         |                                               ^~~~~~~


vim +/fsl_edma_debugfs_on +615 drivers/dma/fsl-edma-main.c

   416	
   417	static int fsl_edma_probe(struct platform_device *pdev)
   418	{
   419		const struct of_device_id *of_id =
   420				of_match_device(fsl_edma_dt_ids, &pdev->dev);
   421		struct device_node *np = pdev->dev.of_node;
   422		struct fsl_edma_engine *fsl_edma;
   423		const struct fsl_edma_drvdata *drvdata = NULL;
   424		u32 chan_mask[2] = {0, 0};
   425		struct edma_regs *regs;
   426		int chans;
   427		int ret, i;
   428	
   429		if (of_id)
   430			drvdata = of_id->data;
   431		if (!drvdata) {
   432			dev_err(&pdev->dev, "unable to find driver data\n");
   433			return -EINVAL;
   434		}
   435	
   436		ret = of_property_read_u32(np, "dma-channels", &chans);
   437		if (ret) {
   438			dev_err(&pdev->dev, "Can't get dma-channels.\n");
   439			return ret;
   440		}
   441	
   442		fsl_edma = devm_kzalloc(&pdev->dev, struct_size(fsl_edma, chans, chans),
   443					GFP_KERNEL);
   444		if (!fsl_edma)
   445			return -ENOMEM;
   446	
   447		fsl_edma->drvdata = drvdata;
   448		fsl_edma->n_chans = chans;
   449		mutex_init(&fsl_edma->fsl_edma_mutex);
   450	
   451		fsl_edma->membase = devm_platform_ioremap_resource(pdev, 0);
   452		if (IS_ERR(fsl_edma->membase))
   453			return PTR_ERR(fsl_edma->membase);
   454	
   455		if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)) {
   456			fsl_edma_setup_regs(fsl_edma);
   457			regs = &fsl_edma->regs;
   458		}
   459	
   460		if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
   461			fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
   462			if (IS_ERR(fsl_edma->dmaclk)) {
   463				dev_err(&pdev->dev, "Missing DMA block clock.\n");
   464				return PTR_ERR(fsl_edma->dmaclk);
   465			}
   466		}
   467	
   468		if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
   469			fsl_edma->chclk = devm_clk_get_enabled(&pdev->dev, "mp");
   470			if (IS_ERR(fsl_edma->chclk)) {
   471				dev_err(&pdev->dev, "Missing MP block clock.\n");
   472				return PTR_ERR(fsl_edma->chclk);
   473			}
   474		}
   475	
   476		ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
   477	
   478		if (ret > 0) {
   479			fsl_edma->chan_masked = chan_mask[1];
   480			fsl_edma->chan_masked <<= 32;
   481			fsl_edma->chan_masked |= chan_mask[0];
   482		}
   483	
   484		for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
   485			char clkname[32];
   486	
   487			/* eDMAv3 mux register move to TCD area if ch_mux exist */
   488			if (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
   489				break;
   490	
   491			fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
   492									      1 + i);
   493			if (IS_ERR(fsl_edma->muxbase[i])) {
   494				/* on error: disable all previously enabled clks */
   495				fsl_disable_clocks(fsl_edma, i);
   496				return PTR_ERR(fsl_edma->muxbase[i]);
   497			}
   498	
   499			sprintf(clkname, "dmamux%d", i);
   500			fsl_edma->muxclk[i] = devm_clk_get_enabled(&pdev->dev, clkname);
   501			if (IS_ERR(fsl_edma->muxclk[i])) {
   502				dev_err(&pdev->dev, "Missing DMAMUX block clock.\n");
   503				/* on error: disable all previously enabled clks */
   504				return PTR_ERR(fsl_edma->muxclk[i]);
   505			}
   506		}
   507	
   508		fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
   509	
   510		if (drvdata->flags & FSL_EDMA_DRV_HAS_PD) {
   511			ret = fsl_edma3_attach_pd(pdev, fsl_edma);
   512			if (ret)
   513				return ret;
   514		}
   515	
   516		INIT_LIST_HEAD(&fsl_edma->dma_dev.channels);
   517		for (i = 0; i < fsl_edma->n_chans; i++) {
   518			struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
   519			int len;
   520	
   521			if (fsl_edma->chan_masked & BIT(i))
   522				continue;
   523	
   524			snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
   525								   dev_name(&pdev->dev), i);
   526	
   527			fsl_chan->edma = fsl_edma;
   528			fsl_chan->pm_state = RUNNING;
   529			fsl_chan->slave_id = 0;
   530			fsl_chan->idle = true;
   531			fsl_chan->dma_dir = DMA_NONE;
   532			fsl_chan->vchan.desc_free = fsl_edma_free_desc;
   533	
   534			len = (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) ?
   535					offsetof(struct fsl_edma3_ch_reg, tcd) : 0;
   536			fsl_chan->tcd = fsl_edma->membase
   537					+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
   538	
   539			fsl_chan->pdev = pdev;
   540			vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
   541	
   542			edma_write_tcdreg(fsl_chan, 0, csr);
   543			fsl_edma_chan_mux(fsl_chan, 0, false);
   544		}
   545	
   546		ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
   547		if (ret)
   548			return ret;
   549	
   550		dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
   551		dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
   552		dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
   553		dma_cap_set(DMA_MEMCPY, fsl_edma->dma_dev.cap_mask);
   554	
   555		fsl_edma->dma_dev.dev = &pdev->dev;
   556		fsl_edma->dma_dev.device_alloc_chan_resources
   557			= fsl_edma_alloc_chan_resources;
   558		fsl_edma->dma_dev.device_free_chan_resources
   559			= fsl_edma_free_chan_resources;
   560		fsl_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
   561		fsl_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
   562		fsl_edma->dma_dev.device_prep_dma_cyclic = fsl_edma_prep_dma_cyclic;
   563		fsl_edma->dma_dev.device_prep_dma_memcpy = fsl_edma_prep_memcpy;
   564		fsl_edma->dma_dev.device_config = fsl_edma_slave_config;
   565		fsl_edma->dma_dev.device_pause = fsl_edma_pause;
   566		fsl_edma->dma_dev.device_resume = fsl_edma_resume;
   567		fsl_edma->dma_dev.device_terminate_all = fsl_edma_terminate_all;
   568		fsl_edma->dma_dev.device_synchronize = fsl_edma_synchronize;
   569		fsl_edma->dma_dev.device_issue_pending = fsl_edma_issue_pending;
   570	
   571		fsl_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
   572		fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
   573	
   574		if (drvdata->flags & FSL_EDMA_DRV_BUS_8BYTE) {
   575			fsl_edma->dma_dev.src_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
   576			fsl_edma->dma_dev.dst_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
   577		}
   578	
   579		fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
   580		if (drvdata->flags & FSL_EDMA_DRV_DEV_TO_DEV)
   581			fsl_edma->dma_dev.directions |= BIT(DMA_DEV_TO_DEV);
   582	
   583		fsl_edma->dma_dev.copy_align = drvdata->flags & FSL_EDMA_DRV_ALIGN_64BYTE ?
   584						DMAENGINE_ALIGN_64_BYTES :
   585						DMAENGINE_ALIGN_32_BYTES;
   586	
   587		/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
   588		dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
   589	
   590		fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
   591	
   592		platform_set_drvdata(pdev, fsl_edma);
   593	
   594		ret = dma_async_device_register(&fsl_edma->dma_dev);
   595		if (ret) {
   596			dev_err(&pdev->dev,
   597				"Can't register Freescale eDMA engine. (%d)\n", ret);
   598			return ret;
   599		}
   600	
   601		ret = of_dma_controller_register(np,
   602				drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
   603				fsl_edma);
   604		if (ret) {
   605			dev_err(&pdev->dev,
   606				"Can't register Freescale eDMA of_dma. (%d)\n", ret);
   607			dma_async_device_unregister(&fsl_edma->dma_dev);
   608			return ret;
   609		}
   610	
   611		/* enable round robin arbitration */
   612		if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
   613			edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
   614	
 > 615		fsl_edma_debugfs_on(fsl_edma);
   616	
   617		return 0;
   618	}
   619	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
