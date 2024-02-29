Return-Path: <dmaengine+bounces-1202-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B136886D2D2
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 20:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C811C21634
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8F134439;
	Thu, 29 Feb 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOXGXdD7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501C134431;
	Thu, 29 Feb 2024 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233737; cv=none; b=FEp2F5T0EWJN/t74DtJPxT250u/0tYCoPHutiD0vDffDyJ7Ti6I+lawx6zEUK4uzk5BI8uKWycso35lRVLhN7QFe0/G0+8vZCiCeA2I2cX7TT9r/5lP0ICOqE4QR4KRfB32WoBMrOhnCcBfQ+dmcBDtqbiQ1QCS2hAzEPnZIg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233737; c=relaxed/simple;
	bh=0U1r3Qu+GxSx2ucDrDnXmdR2XAz3quO+6oo/ITF3EOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLQax2d9Fr0sIn9uzzQkqscVqkz9zL1+1ZlU0yDthIy3O0zi2wTn1//+yf6+frzPUHn2L8nQQLBr63wAJYZh7nPPGLC3ZcX1DLHivjxyrlfp0PejKryaXya67ELRvNMxVh+7ZaQqXJY2fqiUxQ97WAMY0/vJdUy1Qiow//c9XsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOXGXdD7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709233736; x=1740769736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0U1r3Qu+GxSx2ucDrDnXmdR2XAz3quO+6oo/ITF3EOU=;
  b=kOXGXdD72wgpf5YrJbz9hwsFGqTat+f8lMdBM9zltAe7NfcyuLOwxECi
   KKWJ4JEIGuaV+ITk6MgXVqrTrMoQVdlRlHERGjy/poGPy+jO3o0nvDANt
   Cnn7kqF2fLAqc9kxBIU8ep/reQRForXxqF/gqqCIIPTjAx5cX5Fp4ZfLx
   CPJdI5td1YdnIh1NICiKMt0ktc28yxgzbTmhnRx2uDkGdxpvSTjaTTY5E
   OZMxj0j+y+hODAwyKdWT27lMVpnBe105S1Vj6kkAsbR7raSQ2pVvr/Otv
   +sl+dVXrgoV1m/f1rbsckWWRELBH6WOfXqNX1ffH+v11eRbcgp0q2s0ph
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14304520"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14304520"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 11:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12587396"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 29 Feb 2024 11:08:52 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfllx-000DDf-1u;
	Thu, 29 Feb 2024 19:08:49 +0000
Date: Fri, 1 Mar 2024 03:08:21 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/5] dmaengine: fsl-edma: remove 'slave_id' from
 fsl_edma_chan
Message-ID: <202403010227.FvhhLScs-lkp@intel.com>
References: <20240227-8ulp_edma-v1-1-7fcfe1e265c2@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227-8ulp_edma-v1-1-7fcfe1e265c2@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-fsl-edma-remove-slave_id-from-fsl_edma_chan/20240228-012842
base:   2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
patch link:    https://lore.kernel.org/r/20240227-8ulp_edma-v1-1-7fcfe1e265c2%40nxp.com
patch subject: [PATCH 1/5] dmaengine: fsl-edma: remove 'slave_id' from fsl_edma_chan
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240301/202403010227.FvhhLScs-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403010227.FvhhLScs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403010227.FvhhLScs-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/mcf-edma-main.c: In function 'mcf_edma_probe':
>> drivers/dma/mcf-edma-main.c:198:25: error: 'struct fsl_edma_chan' has no member named 'slave_id'
     198 |                 mcf_chan->slave_id = i;
         |                         ^~
   drivers/dma/mcf-edma-main.c: In function 'mcf_edma_filter_fn':
   drivers/dma/mcf-edma-main.c:280:33: error: 'struct fsl_edma_chan' has no member named 'slave_id'
     280 |                 return (mcf_chan->slave_id == (uintptr_t)param);
         |                                 ^~


vim +198 drivers/dma/mcf-edma-main.c

af802728e4ab07 drivers/dma/mcf-edma.c      Robin Gong         2019-06-25  152  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  153  static int mcf_edma_probe(struct platform_device *pdev)
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  154  {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  155  	struct mcf_edma_platform_data *pdata;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  156  	struct fsl_edma_engine *mcf_edma;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  157  	struct edma_regs *regs;
923b138388928a drivers/dma/mcf-edma.c      Christophe JAILLET 2023-05-06  158  	int ret, i, chans;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  159  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  160  	pdata = dev_get_platdata(&pdev->dev);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  161  	if (!pdata) {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  162  		dev_err(&pdev->dev, "no platform data supplied\n");
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  163  		return -EINVAL;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  164  	}
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  165  
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  166  	if (!pdata->dma_channels) {
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  167  		dev_info(&pdev->dev, "setting default channel number to 64");
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  168  		chans = 64;
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  169  	} else {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  170  		chans = pdata->dma_channels;
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  171  	}
0a46781c89dece drivers/dma/mcf-edma.c      Christophe JAILLET 2023-07-12  172  
923b138388928a drivers/dma/mcf-edma.c      Christophe JAILLET 2023-05-06  173  	mcf_edma = devm_kzalloc(&pdev->dev, struct_size(mcf_edma, chans, chans),
923b138388928a drivers/dma/mcf-edma.c      Christophe JAILLET 2023-05-06  174  				GFP_KERNEL);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  175  	if (!mcf_edma)
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  176  		return -ENOMEM;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  177  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  178  	mcf_edma->n_chans = chans;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  179  
af802728e4ab07 drivers/dma/mcf-edma.c      Robin Gong         2019-06-25  180  	/* Set up drvdata for ColdFire edma */
af802728e4ab07 drivers/dma/mcf-edma.c      Robin Gong         2019-06-25  181  	mcf_edma->drvdata = &mcf_data;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  182  	mcf_edma->big_endian = 1;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  183  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  184  	mutex_init(&mcf_edma->fsl_edma_mutex);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  185  
4b23603a251d24 drivers/dma/mcf-edma.c      Tudor Ambarus      2022-11-10  186  	mcf_edma->membase = devm_platform_ioremap_resource(pdev, 0);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  187  	if (IS_ERR(mcf_edma->membase))
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  188  		return PTR_ERR(mcf_edma->membase);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  189  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  190  	fsl_edma_setup_regs(mcf_edma);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  191  	regs = &mcf_edma->regs;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  192  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  193  	INIT_LIST_HEAD(&mcf_edma->dma_dev.channels);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  194  	for (i = 0; i < mcf_edma->n_chans; i++) {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  195  		struct fsl_edma_chan *mcf_chan = &mcf_edma->chans[i];
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  196  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  197  		mcf_chan->edma = mcf_edma;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19 @198  		mcf_chan->slave_id = i;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  199  		mcf_chan->idle = true;
0fa89f972da607 drivers/dma/mcf-edma.c      Laurentiu Tudor    2019-01-18  200  		mcf_chan->dma_dir = DMA_NONE;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  201  		mcf_chan->vchan.desc_free = fsl_edma_free_desc;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  202  		vchan_init(&mcf_chan->vchan, &mcf_edma->dma_dev);
7536f8b371adcc drivers/dma/mcf-edma-main.c Frank Li           2023-08-21  203  		mcf_chan->tcd = mcf_edma->membase + EDMA_TCD
7536f8b371adcc drivers/dma/mcf-edma-main.c Frank Li           2023-08-21  204  				+ i * sizeof(struct fsl_edma_hw_tcd);
b51dd7c8aac292 drivers/dma/mcf-edma-main.c Frank Li           2023-12-21  205  		edma_write_tcdreg(mcf_chan, cpu_to_le32(0), csr);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  206  	}
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  207  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  208  	iowrite32(~0, regs->inth);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  209  	iowrite32(~0, regs->intl);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  210  
af802728e4ab07 drivers/dma/mcf-edma.c      Robin Gong         2019-06-25  211  	ret = mcf_edma->drvdata->setup_irq(pdev, mcf_edma);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  212  	if (ret)
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  213  		return ret;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  214  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  215  	dma_cap_set(DMA_PRIVATE, mcf_edma->dma_dev.cap_mask);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  216  	dma_cap_set(DMA_SLAVE, mcf_edma->dma_dev.cap_mask);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  217  	dma_cap_set(DMA_CYCLIC, mcf_edma->dma_dev.cap_mask);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  218  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  219  	mcf_edma->dma_dev.dev = &pdev->dev;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  220  	mcf_edma->dma_dev.device_alloc_chan_resources =
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  221  			fsl_edma_alloc_chan_resources;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  222  	mcf_edma->dma_dev.device_free_chan_resources =
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  223  			fsl_edma_free_chan_resources;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  224  	mcf_edma->dma_dev.device_config = fsl_edma_slave_config;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  225  	mcf_edma->dma_dev.device_prep_dma_cyclic =
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  226  			fsl_edma_prep_dma_cyclic;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  227  	mcf_edma->dma_dev.device_prep_slave_sg = fsl_edma_prep_slave_sg;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  228  	mcf_edma->dma_dev.device_tx_status = fsl_edma_tx_status;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  229  	mcf_edma->dma_dev.device_pause = fsl_edma_pause;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  230  	mcf_edma->dma_dev.device_resume = fsl_edma_resume;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  231  	mcf_edma->dma_dev.device_terminate_all = fsl_edma_terminate_all;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  232  	mcf_edma->dma_dev.device_issue_pending = fsl_edma_issue_pending;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  233  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  234  	mcf_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  235  	mcf_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  236  	mcf_edma->dma_dev.directions =
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  237  			BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  238  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  239  	mcf_edma->dma_dev.filter.fn = mcf_edma_filter_fn;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  240  	mcf_edma->dma_dev.filter.map = pdata->slave_map;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  241  	mcf_edma->dma_dev.filter.mapcnt = pdata->slavecnt;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  242  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  243  	platform_set_drvdata(pdev, mcf_edma);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  244  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  245  	ret = dma_async_device_register(&mcf_edma->dma_dev);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  246  	if (ret) {
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  247  		dev_err(&pdev->dev,
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  248  			"Can't register Freescale eDMA engine. (%d)\n", ret);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  249  		return ret;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  250  	}
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  251  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  252  	/* Enable round robin arbitration */
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  253  	iowrite32(EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  254  
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  255  	return 0;
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  256  }
e7a3ff92eaf19e drivers/dma/mcf-edma.c      Angelo Dureghello  2018-08-19  257  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

