Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE215B7E3F
	for <lists+dmaengine@lfdr.de>; Wed, 14 Sep 2022 03:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiINB0G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Sep 2022 21:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiINB0F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Sep 2022 21:26:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006546B658;
        Tue, 13 Sep 2022 18:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663118763; x=1694654763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mJVxyJFWo45bZ2CDtxtawCQCsQQ+ZLsf08JzYOfSQQI=;
  b=UqktmH0IvfAOUoU3zfidqpawRlMMSY1XIMzhWyDUg5OS7/3rijUHsTSJ
   C1v+3zHXyEdkevQVByr4ezhcJsA5TkQPEE/qim+UNfpZY7Go0s/BXD0Q8
   csRXQ5MuCDt2KBgo1aLzjMA5MOTSXbnMLy2+UbuTaJAhvBHE6/nArt4fF
   f3VzWxIX9YmA4YkYAhCZl8vqo4zFiZpRl+63T4Yuo0KlRcXt7J5bt+zjq
   BW2VKAQyMVFDnwA/KdRRLBOIsWtLuNfnFxMDHJYqcCEtGDspp6j8SuZw6
   G5EaY82tAetmP9qdEoc9FbKbJu2UY+ACuwrtsszonaLMzjjTaTibjbaCP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="362268333"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="362268333"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 18:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="594178545"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Sep 2022 18:25:59 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYHA7-0004Cn-0Q;
        Wed, 14 Sep 2022 01:25:59 +0000
Date:   Wed, 14 Sep 2022 09:25:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akhil R <akhilrajeev@nvidia.com>, ldewangan@nvidia.com,
        jonathanh@nvidia.com, vkoul@kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, akhilrajeev@nvidia.com
Subject: Re: [PATCH 3/3] dmaengine: tegra: Add support for dma-channel-mask
Message-ID: <202209140942.NsWTm6xM-lkp@intel.com>
References: <20220913155251.59375-4-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913155251.59375-4-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Akhil,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on vkoul-dmaengine/next linus/master v6.0-rc5 next-20220913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akhil-R/Tegra-GCPDMA-Add-dma-channel-mask-support/20220914-010611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220914/202209140942.NsWTm6xM-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b760183e9631ceaf2f36072fc4a7438c3d62887b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Akhil-R/Tegra-GCPDMA-Add-dma-channel-mask-support/20220914-010611
        git checkout b760183e9631ceaf2f36072fc4a7438c3d62887b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dmaengine.h:8,
                    from drivers/dma/tegra186-gpc-dma.c:9:
   drivers/dma/tegra186-gpc-dma.c: In function 'tegra_dma_probe':
>> drivers/dma/tegra186-gpc-dma.c:1469:30: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Wformat=]
    1469 |         dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/dma/tegra186-gpc-dma.c:1469:9: note: in expansion of macro 'dev_info'
    1469 |         dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
         |         ^~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:1469:56: note: format string is defined here
    1469 |         dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
         |                                                       ~^
         |                                                        |
         |                                                        int
         |                                                       %ld


vim +1469 drivers/dma/tegra186-gpc-dma.c

ee17028009d49f Akhil R 2022-02-25  1346  
ee17028009d49f Akhil R 2022-02-25  1347  static int tegra_dma_probe(struct platform_device *pdev)
ee17028009d49f Akhil R 2022-02-25  1348  {
ee17028009d49f Akhil R 2022-02-25  1349  	const struct tegra_dma_chip_data *cdata = NULL;
ee17028009d49f Akhil R 2022-02-25  1350  	struct iommu_fwspec *iommu_spec;
ee17028009d49f Akhil R 2022-02-25  1351  	unsigned int stream_id, i;
ee17028009d49f Akhil R 2022-02-25  1352  	struct tegra_dma *tdma;
ee17028009d49f Akhil R 2022-02-25  1353  	int ret;
ee17028009d49f Akhil R 2022-02-25  1354  
ee17028009d49f Akhil R 2022-02-25  1355  	cdata = of_device_get_match_data(&pdev->dev);
ee17028009d49f Akhil R 2022-02-25  1356  
ee17028009d49f Akhil R 2022-02-25  1357  	tdma = devm_kzalloc(&pdev->dev,
ee17028009d49f Akhil R 2022-02-25  1358  			    struct_size(tdma, channels, cdata->nr_channels),
ee17028009d49f Akhil R 2022-02-25  1359  			    GFP_KERNEL);
ee17028009d49f Akhil R 2022-02-25  1360  	if (!tdma)
ee17028009d49f Akhil R 2022-02-25  1361  		return -ENOMEM;
ee17028009d49f Akhil R 2022-02-25  1362  
ee17028009d49f Akhil R 2022-02-25  1363  	tdma->dev = &pdev->dev;
ee17028009d49f Akhil R 2022-02-25  1364  	tdma->chip_data = cdata;
ee17028009d49f Akhil R 2022-02-25  1365  	platform_set_drvdata(pdev, tdma);
ee17028009d49f Akhil R 2022-02-25  1366  
ee17028009d49f Akhil R 2022-02-25  1367  	tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
ee17028009d49f Akhil R 2022-02-25  1368  	if (IS_ERR(tdma->base_addr))
ee17028009d49f Akhil R 2022-02-25  1369  		return PTR_ERR(tdma->base_addr);
ee17028009d49f Akhil R 2022-02-25  1370  
ee17028009d49f Akhil R 2022-02-25  1371  	tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
ee17028009d49f Akhil R 2022-02-25  1372  	if (IS_ERR(tdma->rst)) {
ee17028009d49f Akhil R 2022-02-25  1373  		return dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
ee17028009d49f Akhil R 2022-02-25  1374  			      "Missing controller reset\n");
ee17028009d49f Akhil R 2022-02-25  1375  	}
ee17028009d49f Akhil R 2022-02-25  1376  	reset_control_reset(tdma->rst);
ee17028009d49f Akhil R 2022-02-25  1377  
ee17028009d49f Akhil R 2022-02-25  1378  	tdma->dma_dev.dev = &pdev->dev;
ee17028009d49f Akhil R 2022-02-25  1379  
ee17028009d49f Akhil R 2022-02-25  1380  	iommu_spec = dev_iommu_fwspec_get(&pdev->dev);
ee17028009d49f Akhil R 2022-02-25  1381  	if (!iommu_spec) {
ee17028009d49f Akhil R 2022-02-25  1382  		dev_err(&pdev->dev, "Missing iommu stream-id\n");
ee17028009d49f Akhil R 2022-02-25  1383  		return -EINVAL;
ee17028009d49f Akhil R 2022-02-25  1384  	}
ee17028009d49f Akhil R 2022-02-25  1385  	stream_id = iommu_spec->ids[0] & 0xffff;
ee17028009d49f Akhil R 2022-02-25  1386  
b760183e9631ce Akhil R 2022-09-13  1387  	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
b760183e9631ce Akhil R 2022-09-13  1388  				       &tdma->chan_mask);
b760183e9631ce Akhil R 2022-09-13  1389  	if (ret) {
b760183e9631ce Akhil R 2022-09-13  1390  		dev_warn(&pdev->dev,
b760183e9631ce Akhil R 2022-09-13  1391  			 "Missing dma-channel-mask property, using default channel mask %#x\n",
b760183e9631ce Akhil R 2022-09-13  1392  			 TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK);
b760183e9631ce Akhil R 2022-09-13  1393  		tdma->chan_mask = TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK;
b760183e9631ce Akhil R 2022-09-13  1394  	}
b760183e9631ce Akhil R 2022-09-13  1395  
ee17028009d49f Akhil R 2022-02-25  1396  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
ee17028009d49f Akhil R 2022-02-25  1397  	for (i = 0; i < cdata->nr_channels; i++) {
ee17028009d49f Akhil R 2022-02-25  1398  		struct tegra_dma_channel *tdc = &tdma->channels[i];
ee17028009d49f Akhil R 2022-02-25  1399  
b760183e9631ce Akhil R 2022-09-13  1400  		/* Check for channel mask */
b760183e9631ce Akhil R 2022-09-13  1401  		if (!((1 << i) & tdma->chan_mask))
b760183e9631ce Akhil R 2022-09-13  1402  			continue;
b760183e9631ce Akhil R 2022-09-13  1403  
461cd3709f266d Akhil R 2022-05-05  1404  		tdc->irq = platform_get_irq(pdev, i);
461cd3709f266d Akhil R 2022-05-05  1405  		if (tdc->irq < 0)
461cd3709f266d Akhil R 2022-05-05  1406  			return tdc->irq;
461cd3709f266d Akhil R 2022-05-05  1407  
b760183e9631ce Akhil R 2022-09-13  1408  		tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADDR_OFFSET +
ee17028009d49f Akhil R 2022-02-25  1409  					i * cdata->channel_reg_size;
ee17028009d49f Akhil R 2022-02-25  1410  		snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
ee17028009d49f Akhil R 2022-02-25  1411  		tdc->tdma = tdma;
ee17028009d49f Akhil R 2022-02-25  1412  		tdc->id = i;
ee17028009d49f Akhil R 2022-02-25  1413  		tdc->slave_id = -1;
ee17028009d49f Akhil R 2022-02-25  1414  
ee17028009d49f Akhil R 2022-02-25  1415  		vchan_init(&tdc->vc, &tdma->dma_dev);
ee17028009d49f Akhil R 2022-02-25  1416  		tdc->vc.desc_free = tegra_dma_desc_free;
ee17028009d49f Akhil R 2022-02-25  1417  
ee17028009d49f Akhil R 2022-02-25  1418  		/* program stream-id for this channel */
ee17028009d49f Akhil R 2022-02-25  1419  		tegra_dma_program_sid(tdc, stream_id);
ee17028009d49f Akhil R 2022-02-25  1420  		tdc->stream_id = stream_id;
ee17028009d49f Akhil R 2022-02-25  1421  	}
ee17028009d49f Akhil R 2022-02-25  1422  
ee17028009d49f Akhil R 2022-02-25  1423  	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
ee17028009d49f Akhil R 2022-02-25  1424  	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
ee17028009d49f Akhil R 2022-02-25  1425  	dma_cap_set(DMA_MEMCPY, tdma->dma_dev.cap_mask);
ee17028009d49f Akhil R 2022-02-25  1426  	dma_cap_set(DMA_MEMSET, tdma->dma_dev.cap_mask);
ee17028009d49f Akhil R 2022-02-25  1427  	dma_cap_set(DMA_CYCLIC, tdma->dma_dev.cap_mask);
ee17028009d49f Akhil R 2022-02-25  1428  
ee17028009d49f Akhil R 2022-02-25  1429  	/*
ee17028009d49f Akhil R 2022-02-25  1430  	 * Only word aligned transfers are supported. Set the copy
ee17028009d49f Akhil R 2022-02-25  1431  	 * alignment shift.
ee17028009d49f Akhil R 2022-02-25  1432  	 */
ee17028009d49f Akhil R 2022-02-25  1433  	tdma->dma_dev.copy_align = 2;
ee17028009d49f Akhil R 2022-02-25  1434  	tdma->dma_dev.fill_align = 2;
ee17028009d49f Akhil R 2022-02-25  1435  	tdma->dma_dev.device_alloc_chan_resources =
ee17028009d49f Akhil R 2022-02-25  1436  					tegra_dma_alloc_chan_resources;
ee17028009d49f Akhil R 2022-02-25  1437  	tdma->dma_dev.device_free_chan_resources =
ee17028009d49f Akhil R 2022-02-25  1438  					tegra_dma_free_chan_resources;
ee17028009d49f Akhil R 2022-02-25  1439  	tdma->dma_dev.device_prep_slave_sg = tegra_dma_prep_slave_sg;
ee17028009d49f Akhil R 2022-02-25  1440  	tdma->dma_dev.device_prep_dma_memcpy = tegra_dma_prep_dma_memcpy;
ee17028009d49f Akhil R 2022-02-25  1441  	tdma->dma_dev.device_prep_dma_memset = tegra_dma_prep_dma_memset;
ee17028009d49f Akhil R 2022-02-25  1442  	tdma->dma_dev.device_prep_dma_cyclic = tegra_dma_prep_dma_cyclic;
ee17028009d49f Akhil R 2022-02-25  1443  	tdma->dma_dev.device_config = tegra_dma_slave_config;
ee17028009d49f Akhil R 2022-02-25  1444  	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
ee17028009d49f Akhil R 2022-02-25  1445  	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
ee17028009d49f Akhil R 2022-02-25  1446  	tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
ee17028009d49f Akhil R 2022-02-25  1447  	tdma->dma_dev.device_pause = tegra_dma_device_pause;
ee17028009d49f Akhil R 2022-02-25  1448  	tdma->dma_dev.device_resume = tegra_dma_device_resume;
ee17028009d49f Akhil R 2022-02-25  1449  	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
ee17028009d49f Akhil R 2022-02-25  1450  	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
ee17028009d49f Akhil R 2022-02-25  1451  
ee17028009d49f Akhil R 2022-02-25  1452  	ret = dma_async_device_register(&tdma->dma_dev);
ee17028009d49f Akhil R 2022-02-25  1453  	if (ret < 0) {
ee17028009d49f Akhil R 2022-02-25  1454  		dev_err_probe(&pdev->dev, ret,
ee17028009d49f Akhil R 2022-02-25  1455  			      "GPC DMA driver registration failed\n");
ee17028009d49f Akhil R 2022-02-25  1456  		return ret;
ee17028009d49f Akhil R 2022-02-25  1457  	}
ee17028009d49f Akhil R 2022-02-25  1458  
ee17028009d49f Akhil R 2022-02-25  1459  	ret = of_dma_controller_register(pdev->dev.of_node,
ee17028009d49f Akhil R 2022-02-25  1460  					 tegra_dma_of_xlate, tdma);
ee17028009d49f Akhil R 2022-02-25  1461  	if (ret < 0) {
ee17028009d49f Akhil R 2022-02-25  1462  		dev_err_probe(&pdev->dev, ret,
ee17028009d49f Akhil R 2022-02-25  1463  			      "GPC DMA OF registration failed\n");
ee17028009d49f Akhil R 2022-02-25  1464  
ee17028009d49f Akhil R 2022-02-25  1465  		dma_async_device_unregister(&tdma->dma_dev);
ee17028009d49f Akhil R 2022-02-25  1466  		return ret;
ee17028009d49f Akhil R 2022-02-25  1467  	}
ee17028009d49f Akhil R 2022-02-25  1468  
ee17028009d49f Akhil R 2022-02-25 @1469  	dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
b760183e9631ce Akhil R 2022-09-13  1470  		 hweight_long(tdma->chan_mask));
ee17028009d49f Akhil R 2022-02-25  1471  
ee17028009d49f Akhil R 2022-02-25  1472  	return 0;
ee17028009d49f Akhil R 2022-02-25  1473  }
ee17028009d49f Akhil R 2022-02-25  1474  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
