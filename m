Return-Path: <dmaengine+bounces-148-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0C27EFAF9
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 22:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE895B20AFE
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCF819459;
	Fri, 17 Nov 2023 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfRPgZ0D"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEBCAD;
	Fri, 17 Nov 2023 13:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700257154; x=1731793154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6umvofAy6/SnoO7k0mKXAdEq7UcjkOXETJDh8A+vaas=;
  b=cfRPgZ0Drc5rG8gOtU+iLIjBOGf6nFEXGdCz4zi7YQsIZsIRn0QY/oE3
   V3SjSI+L9P2gdNhBZvhMZMKr6YOV5K/7lQ/kwVTdg1bfoOsmY219gqVIl
   1S2TH3rit0YPwXYpWhQAVWmv5qdaBvXkh97x7Lz+pE02kKv9RDqofHO9C
   y0mcNrfvhI7YLPaKKuc0mmjVEI8QmZErvXGT7tXYVPi4055qt6PDhlxFw
   zxU9RcJ37NudABPjK62og60O+pPI8oZ2PRPZtQ5nKfsLsymo4YhH9VuVK
   orx8fiIM5U2aqXKHB8vaYWmU1+6hG464FgeZFJYz/SAZ1ibKSLLTwJFYT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="395298083"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="395298083"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 13:39:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="939266225"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="939266225"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2023 13:39:10 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r46YO-0003Ap-1l;
	Fri, 17 Nov 2023 21:39:08 +0000
Date: Sat, 18 Nov 2023 05:38:55 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, imx@lists.linux.dev, joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: Re: [PATCH v2 3/5] dmaengine: mcf-edma: force type conversion for
 TCD pointer
Message-ID: <202311180508.h4QYgZRC-lkp@intel.com>
References: <20231116222743.2984776-4-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116222743.2984776-4-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-edma-involve-help-macro-fsl_edma_set-get-_tcd/20231117-062946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20231116222743.2984776-4-Frank.Li%40nxp.com
patch subject: [PATCH v2 3/5] dmaengine: mcf-edma: force type conversion for TCD pointer
config: csky-randconfig-r123-20231117 (https://download.01.org/0day-ci/archive/20231118/202311180508.h4QYgZRC-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311180508.h4QYgZRC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180508.h4QYgZRC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/dma/mcf-edma-main.c:205:35: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/mcf-edma-main.c:205:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le16 * @@
   drivers/dma/mcf-edma-main.c:205:35: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/dma/mcf-edma-main.c:205:35: sparse:     got restricted __le16 *
   drivers/dma/mcf-edma-main.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/__iomem +205 drivers/dma/mcf-edma-main.c

   152	
   153	static int mcf_edma_probe(struct platform_device *pdev)
   154	{
   155		struct mcf_edma_platform_data *pdata;
   156		struct fsl_edma_engine *mcf_edma;
   157		struct edma_regs *regs;
   158		int ret, i, chans;
   159	
   160		pdata = dev_get_platdata(&pdev->dev);
   161		if (!pdata) {
   162			dev_err(&pdev->dev, "no platform data supplied\n");
   163			return -EINVAL;
   164		}
   165	
   166		if (!pdata->dma_channels) {
   167			dev_info(&pdev->dev, "setting default channel number to 64");
   168			chans = 64;
   169		} else {
   170			chans = pdata->dma_channels;
   171		}
   172	
   173		mcf_edma = devm_kzalloc(&pdev->dev, struct_size(mcf_edma, chans, chans),
   174					GFP_KERNEL);
   175		if (!mcf_edma)
   176			return -ENOMEM;
   177	
   178		mcf_edma->n_chans = chans;
   179	
   180		/* Set up drvdata for ColdFire edma */
   181		mcf_edma->drvdata = &mcf_data;
   182		mcf_edma->big_endian = 1;
   183	
   184		mutex_init(&mcf_edma->fsl_edma_mutex);
   185	
   186		mcf_edma->membase = devm_platform_ioremap_resource(pdev, 0);
   187		if (IS_ERR(mcf_edma->membase))
   188			return PTR_ERR(mcf_edma->membase);
   189	
   190		fsl_edma_setup_regs(mcf_edma);
   191		regs = &mcf_edma->regs;
   192	
   193		INIT_LIST_HEAD(&mcf_edma->dma_dev.channels);
   194		for (i = 0; i < mcf_edma->n_chans; i++) {
   195			struct fsl_edma_chan *mcf_chan = &mcf_edma->chans[i];
   196	
   197			mcf_chan->edma = mcf_edma;
   198			mcf_chan->slave_id = i;
   199			mcf_chan->idle = true;
   200			mcf_chan->dma_dir = DMA_NONE;
   201			mcf_chan->vchan.desc_free = fsl_edma_free_desc;
   202			vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
   203			mcf_chan->tcd = mcf_edma->membase + EDMA_TCD
   204					+ i * sizeof(struct fsl_edma_hw_tcd);
 > 205			iowrite32(0x0, &((struct fsl_edma_hw_tcd *)mcf_chan->tcd)->csr);
   206		}
   207	
   208		iowrite32(~0, regs->inth);
   209		iowrite32(~0, regs->intl);
   210	
   211		ret = mcf_edma->drvdata->setup_irq(pdev, mcf_edma);
   212		if (ret)
   213			return ret;
   214	
   215		dma_cap_set(DMA_PRIVATE, mcf_edma->dma_dev.cap_mask);
   216		dma_cap_set(DMA_SLAVE, mcf_edma->dma_dev.cap_mask);
   217		dma_cap_set(DMA_CYCLIC, mcf_edma->dma_dev.cap_mask);
   218	
   219		mcf_edma->dma_dev.dev = &pdev->dev;
   220		mcf_edma->dma_dev.device_alloc_chan_resources =
   221				fsl_edma_alloc_chan_resources;
   222		mcf_edma->dma_dev.device_free_chan_resources =
   223				fsl_edma_free_chan_resources;
   224		mcf_edma->dma_dev.device_config = fsl_edma_slave_config;
   225		mcf_edma->dma_dev.device_prep_dma_cyclic =
   226				fsl_edma_prep_dma_cyclic;
   227		mcf_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
   228		mcf_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
   229		mcf_edma->dma_dev.device_pause = fsl_edma_pause;
   230		mcf_edma->dma_dev.device_resume = fsl_edma_resume;
   231		mcf_edma->dma_dev.device_terminate_all = fsl_edma_terminate_all;
   232		mcf_edma->dma_dev.device_issue_pending = fsl_edma_issue_pending;
   233	
   234		mcf_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
   235		mcf_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
   236		mcf_edma->dma_dev.directions =
   237				BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
   238	
   239		mcf_edma->dma_dev.filter.fn = mcf_edma_filter_fn;
   240		mcf_edma->dma_dev.filter.map = pdata->slave_map;
   241		mcf_edma->dma_dev.filter.mapcnt = pdata->slavecnt;
   242	
   243		platform_set_drvdata(pdev, mcf_edma);
   244	
   245		ret = dma_async_device_register(&mcf_edma->dma_dev);
   246		if (ret) {
   247			dev_err(&pdev->dev,
   248				"Can't register Freescale eDMA engine. (%d)\n", ret);
   249			return ret;
   250		}
   251	
   252		/* Enable round robin arbitration */
   253		iowrite32(EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
   254	
   255		return 0;
   256	}
   257	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

