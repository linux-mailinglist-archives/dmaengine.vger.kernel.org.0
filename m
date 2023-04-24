Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1386EC36C
	for <lists+dmaengine@lfdr.de>; Mon, 24 Apr 2023 03:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjDXBgp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 Apr 2023 21:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjDXBgo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 23 Apr 2023 21:36:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7101997;
        Sun, 23 Apr 2023 18:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682300201; x=1713836201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G22SleDyELmqv+4z24qsjjgOeXAlE59i3fa4mNcnIW8=;
  b=XUXVHW9JKgJY4wMvo1F1sjPAIgqOKAt+iXF7r9sSm6Yja981Qq4HI/rq
   njUO2EBJPPwVwwyw41RqaWpWWRdBWXyoOvkULU3r50NTDIfui3gSAKhLA
   c6K1y3ioFshumrh9K+MKssnGBKH7nC2hAMBw6iQlHaT4Grg7UOvqJ1Vrv
   xrqqf0XmFdj5QGJj7raFdeByEQj/WxQj6lolb9Hic17Np1iC1p+PBAlkC
   CDhdE9gAkE8kEw65EUZmgQWQ7OtYkeEVzQv1s5PVsZAuAAi7uFNVTMoZl
   lAlZFhQuIArawZxB5HW/uhaLmVfpUtzsOZR8PtnbuObuaJCbpa0cWkMyu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="432607648"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="432607648"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 18:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="670334040"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="670334040"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Apr 2023 18:36:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pql89-000iCl-0n;
        Mon, 24 Apr 2023 01:36:37 +0000
Date:   Mon, 24 Apr 2023 09:36:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kelvin Cao <kelvin.cao@microchip.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, logang@deltatee.com,
        george.ge@microchip.com, christophe.jaillet@wanadoo.fr,
        hch@infradead.org
Subject: Re: [PATCH v4 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <202304240915.MYWRJpvn-lkp@intel.com>
References: <20230423213717.318655-2-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423213717.318655-2-kelvin.cao@microchip.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kelvin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v6.3 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kelvin-Cao/dmaengine-switchtec-dma-Introduce-Switchtec-DMA-engine-PCI-driver/20230424-065123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20230423213717.318655-2-kelvin.cao%40microchip.com
patch subject: [PATCH v4 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA engine PCI driver
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230424/202304240915.MYWRJpvn-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bd3b335b60238af4f01bd6c28a96873988330557
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kelvin-Cao/dmaengine-switchtec-dma-Introduce-Switchtec-DMA-engine-PCI-driver/20230424-065123
        git checkout bd3b335b60238af4f01bd6c28a96873988330557
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304240915.MYWRJpvn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/switchtec_dma.c: In function 'switchtec_dma_create':
>> drivers/dma/switchtec_dma.c:1410:13: warning: variable 'i' set but not used [-Wunused-but-set-variable]
    1410 |         int i;
         |             ^


vim +/i +1410 drivers/dma/switchtec_dma.c

  1400	
  1401	static int switchtec_dma_create(struct pci_dev *pdev)
  1402	{
  1403		struct switchtec_dma_dev *swdma_dev;
  1404		struct dma_device *dma;
  1405		struct dma_chan *chan;
  1406		int chan_cnt;
  1407		int nr_vecs;
  1408		int irq;
  1409		int rc;
> 1410		int i;
  1411	
  1412		/*
  1413		 * Create the switchtec dma device
  1414		 */
  1415		swdma_dev = kzalloc(sizeof(*swdma_dev), GFP_KERNEL);
  1416		if (!swdma_dev)
  1417			return -ENOMEM;
  1418	
  1419		swdma_dev->bar = ioremap(pci_resource_start(pdev, 0),
  1420					 pci_resource_len(pdev, 0));
  1421	
  1422		pci_info(pdev, "Switchtec PSX/PFX DMA EP\n");
  1423	
  1424		RCU_INIT_POINTER(swdma_dev->pdev, pdev);
  1425	
  1426		nr_vecs = pci_msix_vec_count(pdev);
  1427		rc = pci_alloc_irq_vectors(pdev, nr_vecs, nr_vecs, PCI_IRQ_MSIX);
  1428		if (rc < 0)
  1429			goto err_exit;
  1430	
  1431		tasklet_init(&swdma_dev->chan_status_task,
  1432			     switchtec_dma_chan_status_task,
  1433			     (unsigned long)swdma_dev);
  1434	
  1435		irq = readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);
  1436		pci_dbg(pdev, "Channel pause irq vector %d\n", irq);
  1437	
  1438		irq = pci_irq_vector(pdev, irq);
  1439		if (irq < 0) {
  1440			rc = irq;
  1441			goto err_exit;
  1442		}
  1443	
  1444		rc = request_irq(irq, switchtec_dma_chan_status_isr, 0,
  1445				 KBUILD_MODNAME, swdma_dev);
  1446		if (rc)
  1447			goto err_exit;
  1448	
  1449		swdma_dev->chan_status_irq = irq;
  1450	
  1451		chan_cnt = readl(swdma_dev->bar + SWITCHTEC_REG_CHAN_CNT);
  1452		if (!chan_cnt) {
  1453			pci_err(pdev, "No channel configured.\n");
  1454			rc = -ENXIO;
  1455			goto err_exit;
  1456		}
  1457	
  1458		chan_cnt = switchtec_dma_chans_enumerate(swdma_dev, chan_cnt);
  1459		if (chan_cnt < 0) {
  1460			pci_err(pdev, "Failed to enumerate dma channels: %d\n",
  1461				chan_cnt);
  1462			rc = -ENXIO;
  1463			goto err_exit;
  1464		}
  1465	
  1466		swdma_dev->chan_cnt = chan_cnt;
  1467	
  1468		dma = &swdma_dev->dma_dev;
  1469		dma->copy_align = DMAENGINE_ALIGN_1_BYTE;
  1470		dma_cap_set(DMA_MEMCPY, dma->cap_mask);
  1471		dma_cap_set(DMA_PRIVATE, dma->cap_mask);
  1472		dma->dev = get_device(&pdev->dev);
  1473	
  1474		dma->device_alloc_chan_resources = switchtec_dma_alloc_chan_resources;
  1475		dma->device_free_chan_resources = switchtec_dma_free_chan_resources;
  1476		dma->device_prep_dma_memcpy = switchtec_dma_prep_memcpy;
  1477		dma->device_prep_dma_imm_data = switchtec_dma_prep_wimm_data;
  1478		dma->device_issue_pending = switchtec_dma_issue_pending;
  1479		dma->device_tx_status = switchtec_dma_tx_status;
  1480		dma->device_pause = switchtec_dma_pause;
  1481		dma->device_resume = switchtec_dma_resume;
  1482		dma->device_terminate_all = switchtec_dma_terminate_all;
  1483		dma->device_synchronize = switchtec_dma_synchronize;
  1484		dma->device_release = switchtec_dma_release;
  1485	
  1486		rc = dma_async_device_register(dma);
  1487		if (rc) {
  1488			pci_err(pdev, "Failed to register dma device: %d\n", rc);
  1489			goto err_chans_release_exit;
  1490		}
  1491	
  1492		pci_info(pdev, "Channel count: %d\n", chan_cnt);
  1493	
  1494		i = 0;
  1495		list_for_each_entry(chan, &dma->channels, device_node)
  1496			pci_info(pdev, "%s\n", dma_chan_name(chan));
  1497	
  1498		pci_set_drvdata(pdev, swdma_dev);
  1499	
  1500		return 0;
  1501	
  1502	err_chans_release_exit:
  1503		switchtec_dma_chans_release(swdma_dev);
  1504	
  1505	err_exit:
  1506		if (swdma_dev->chan_status_irq)
  1507			free_irq(swdma_dev->chan_status_irq, swdma_dev);
  1508	
  1509		iounmap(swdma_dev->bar);
  1510		kfree(swdma_dev);
  1511		return rc;
  1512	}
  1513	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
