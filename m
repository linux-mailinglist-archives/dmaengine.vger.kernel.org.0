Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3049D58E59C
	for <lists+dmaengine@lfdr.de>; Wed, 10 Aug 2022 05:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiHJDrM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Aug 2022 23:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiHJDrL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Aug 2022 23:47:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA927CB61;
        Tue,  9 Aug 2022 20:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660103230; x=1691639230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rlV22Dxlugsde7bIcBHszfPKMtsuv8IziBg8SxpsemQ=;
  b=MLL0j14DmRL/9tZ9WpZ9bPg+w+pKoJgP4ZbnfRIOHCbryAHQ2j6e0kIc
   59qsYdTsb4YN4IGaT4J9zEFGyaXrgikV9F0QDJQ0Xq/nAaVF/DWrADTJd
   sda5h2GOyHeyArqaUQ0YLxxHBvCqJ8ez/G8/fSEZvR4/hybhR/g1zj6UC
   E7t1f6zv+MVY6ES3938WO71OOjXPmbh0XjmamgREJndPICeu2kTN3M3yX
   H6lSjAcl/359vea9mA1jJSpTSJPP/42t5S9YKXpmxr2S/w9DKCv6Ym8fm
   CIH3w54quyJfDMIhZsO8kLKYPBPoQQYUBKoKQcxyo5FBeJQwx8fc1k4JE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="377279622"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="377279622"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 20:47:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="747284038"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2022 20:47:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLcgV-000NUA-0X;
        Wed, 10 Aug 2022 03:47:07 +0000
Date:   Wed, 10 Aug 2022 11:46:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com
Cc:     kbuild-all@lists.01.org, Lizhi Hou <lizhi.hou@amd.com>,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
Subject: Re: [PATCH V1 XDMA 1/1] dmaengine: xilinx: xdma: add xilinx xdma
 driver
Message-ID: <202208101134.qoV0PSu7-lkp@intel.com>
References: <1660064398-55898-2-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660064398-55898-2-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lizhi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v5.19 next-20220809]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lizhi-Hou/xilinx-XDMA-driver/20220810-010405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
config: microblaze-randconfig-s042-20220810 (https://download.01.org/0day-ci/archive/20220810/202208101134.qoV0PSu7-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/097b3b1f980c265a944c1e61a27cd50493fd0608
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lizhi-Hou/xilinx-XDMA-driver/20220810-010405
        git checkout 097b3b1f980c265a944c1e61a27cd50493fd0608
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/dma/xilinx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/dma/xilinx/xdma.c:872:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *reg_base @@     got void [noderef] __iomem * @@
   drivers/dma/xilinx/xdma.c:872:18: sparse:     expected void *reg_base
   drivers/dma/xilinx/xdma.c:872:18: sparse:     got void [noderef] __iomem *
>> drivers/dma/xilinx/xdma.c:878:24: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] __iomem *regs @@     got void *reg_base @@
   drivers/dma/xilinx/xdma.c:878:24: sparse:     expected void [noderef] __iomem *regs
   drivers/dma/xilinx/xdma.c:878:24: sparse:     got void *reg_base

vim +872 drivers/dma/xilinx/xdma.c

   832	
   833	/**
   834	 * xdma_probe - Driver probe function
   835	 * @pdev: Pointer to the platform_device structure
   836	 */
   837	static int xdma_probe(struct platform_device *pdev)
   838	{
   839		struct xdma_platdata *pdata = dev_get_platdata(&pdev->dev);
   840		struct xdma_device *xdev;
   841		struct resource *res;
   842		int ret = -ENODEV;
   843		void *reg_base;
   844	
   845		if (pdata->max_dma_channels > XDMA_MAX_CHANNELS) {
   846			dev_err(&pdev->dev, "invalid max dma channels %d",
   847				pdata->max_dma_channels);
   848			return -EINVAL;
   849		}
   850	
   851		xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
   852		if (!xdev)
   853			return -ENOMEM;
   854	
   855		platform_set_drvdata(pdev, xdev);
   856		xdev->pdev = pdev;
   857	
   858		res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
   859		if (!res) {
   860			dev_err(&pdev->dev, "failed to get irq resource");
   861			goto failed;
   862		}
   863		xdev->irq_start = res->start;
   864		xdev->irq_num = res->end - res->start + 1;
   865	
   866		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   867		if (!res) {
   868			dev_err(&pdev->dev, "failed to get io resource");
   869			goto failed;
   870		}
   871	
 > 872		reg_base = devm_ioremap_resource(&pdev->dev, res);
   873		if (!reg_base) {
   874			dev_err(&pdev->dev, "ioremap failed");
   875			goto failed;
   876		}
   877	
 > 878		xdev->regmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
   879						     &xdma_regmap_config);
   880		if (!xdev->regmap) {
   881			dev_err(&pdev->dev, "config regmap failed: %d", ret);
   882			goto failed;
   883		}
   884		INIT_LIST_HEAD(&xdev->dma_dev.channels);
   885	
   886		ret = xdma_config_channels(xdev, DMA_MEM_TO_DEV);
   887		if (ret) {
   888			dev_err(&pdev->dev, "config H2C channels failed: %d", ret);
   889			goto failed;
   890		}
   891	
   892		ret = xdma_config_channels(xdev, DMA_DEV_TO_MEM);
   893		if (ret) {
   894			dev_err(&pdev->dev, "config C2H channels failed: %d", ret);
   895			goto failed;
   896		}
   897	
   898		dma_cap_set(DMA_SLAVE, xdev->dma_dev.cap_mask);
   899		dma_cap_set(DMA_PRIVATE, xdev->dma_dev.cap_mask);
   900	
   901		xdev->dma_dev.dev = &pdev->dev;
   902		xdev->dma_dev.device_free_chan_resources = xdma_free_chan_resources;
   903		xdev->dma_dev.device_alloc_chan_resources = xdma_alloc_chan_resources;
   904		xdev->dma_dev.device_tx_status = dma_cookie_status;
   905		xdev->dma_dev.device_prep_slave_sg = xdma_prep_device_sg;
   906		xdev->dma_dev.device_config = xdma_device_config;
   907		xdev->dma_dev.device_issue_pending = xdma_issue_pending;
   908		xdev->dma_dev.filter.map = pdata->device_map;
   909		xdev->dma_dev.filter.mapcnt = pdata->device_map_cnt;
   910		xdev->dma_dev.filter.fn = xdma_filter_fn;
   911	
   912		ret = dma_async_device_register(&xdev->dma_dev);
   913		if (ret) {
   914			dev_err(&pdev->dev, "failed to register Xilinx XDMA: %d", ret);
   915			goto failed;
   916		}
   917		xdev->status |= XDMA_DEV_STATUS_REG_DMA;
   918	
   919		ret = xdma_irq_init(xdev);
   920		if (ret) {
   921			dev_err(&pdev->dev, "failed to init msix: %d", ret);
   922			goto failed;
   923		}
   924		xdev->status |= XDMA_DEV_STATUS_INIT_MSIX;
   925	
   926		return 0;
   927	
   928	failed:
   929		xdma_remove(pdev);
   930	
   931		return ret;
   932	}
   933	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
