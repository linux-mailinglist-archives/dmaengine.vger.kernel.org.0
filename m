Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1A26E5146
	for <lists+dmaengine@lfdr.de>; Mon, 17 Apr 2023 21:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjDQTzR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Apr 2023 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjDQTzL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Apr 2023 15:55:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22DD7DB6;
        Mon, 17 Apr 2023 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681761307; x=1713297307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NGOu5n7YwmnCb6XTnm4UZwVjfuJFIs9IjaQS1qZj7LM=;
  b=D6CRgsXobxhjoDLcSvRKjgFT4vMpsw4rWWiJNAoECOCHKVOstTR2cNR1
   xy8/TAJ/d1LqyDK7p0jO7TawHSM4bvvWH7HuVaqsl+XP6qbZmOkxIc03A
   pPCKx6MIYXTNE19qn2hrGuO8J7loJfcmab9S6CttE21xBt80nrnYwZZBP
   g2h7I57Pqx6Q8Pgff8RZ4dxKWO7Sa/S4YqWZe5+ocWpu9xO45wc4JpagQ
   sLHz/dMQKUzl2jtLuj+bANrk22+v245QgI4ApY9jL1cf2EsVi3xpAQEpD
   V7VG88ZwU0nzki6PI5VBcxUrozEcLj8ohwSJMLGyvnw4J9fSmncEu42hl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="333794983"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="333794983"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 12:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="780231017"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="780231017"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Apr 2023 12:55:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poUwI-000cef-2i;
        Mon, 17 Apr 2023 19:55:02 +0000
Date:   Tue, 18 Apr 2023 03:54:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/7] dmaengine: ste_dma40: Get LCPA SRAM from SRAM node
Message-ID: <202304180357.gfLjNPk9-lkp@intel.com>
References: <20230417-ux500-dma40-cleanup-v1-2-b26324956e47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417-ux500-dma40-cleanup-v1-2-b26324956e47@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Linus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on fe15c26ee26efa11741a7b632e9f23b01aca4cc6]

url:    https://github.com/intel-lab-lkp/linux/commits/Linus-Walleij/dt-bindings-dma-dma40-Prefer-to-pass-sram-through-phandle/20230417-160001
base:   fe15c26ee26efa11741a7b632e9f23b01aca4cc6
patch link:    https://lore.kernel.org/r/20230417-ux500-dma40-cleanup-v1-2-b26324956e47%40linaro.org
patch subject: [PATCH 2/7] dmaengine: ste_dma40: Get LCPA SRAM from SRAM node
config: arm-buildonly-randconfig-r005-20230417 (https://download.01.org/0day-ci/archive/20230418/202304180357.gfLjNPk9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/168b5818186247983ec0f99554e13c3aaa9383bb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Linus-Walleij/dt-bindings-dma-dma40-Prefer-to-pass-sram-through-phandle/20230417-160001
        git checkout 168b5818186247983ec0f99554e13c3aaa9383bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304180357.gfLjNPk9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/dma/ste_dma40.c:9:
   drivers/dma/ste_dma40.c: In function 'd40_probe':
>> drivers/dma/ste_dma40.c:3555:30: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
    3555 |         dev_info(&pdev->dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/dma/ste_dma40.c:3555:9: note: in expansion of macro 'dev_info'
    3555 |         dev_info(&pdev->dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
         |         ^~~~~~~~
   drivers/dma/ste_dma40.c:3555:55: note: format string is defined here
    3555 |         dev_info(&pdev->dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
         |                                                    ~~~^
         |                                                       |
         |                                                       unsigned int
         |                                                    %08llx
   drivers/dma/ste_dma40.c:3562:26: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka 'long long unsigned int'} [-Wformat=]
    3562 |                          "[%s] Mismatch LCPA dma 0x%x, def %08x\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:146:61: note: in expansion of macro 'dev_fmt'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/dma/ste_dma40.c:3561:17: note: in expansion of macro 'dev_warn'
    3561 |                 dev_warn(&pdev->dev,
         |                 ^~~~~~~~
   drivers/dma/ste_dma40.c:3562:63: note: format string is defined here
    3562 |                          "[%s] Mismatch LCPA dma 0x%x, def %08x\n",
         |                                                            ~~~^
         |                                                               |
         |                                                               unsigned int
         |                                                            %08llx


vim +3555 drivers/dma/ste_dma40.c

  3505	
  3506	static int __init d40_probe(struct platform_device *pdev)
  3507	{
  3508		struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
  3509		struct device_node *np = pdev->dev.of_node;
  3510		struct device_node *np_lcpa;
  3511		int ret = -ENOENT;
  3512		struct d40_base *base;
  3513		struct resource *res;
  3514		struct resource res_lcpa;
  3515		int num_reserved_chans;
  3516		u32 val;
  3517	
  3518		if (!plat_data) {
  3519			if (np) {
  3520				if (d40_of_probe(pdev, np)) {
  3521					ret = -ENOMEM;
  3522					goto report_failure;
  3523				}
  3524			} else {
  3525				d40_err(&pdev->dev, "No pdata or Device Tree provided\n");
  3526				goto report_failure;
  3527			}
  3528		}
  3529	
  3530		base = d40_hw_detect_init(pdev);
  3531		if (!base)
  3532			goto report_failure;
  3533	
  3534		num_reserved_chans = d40_phy_res_init(base);
  3535	
  3536		platform_set_drvdata(pdev, base);
  3537	
  3538		spin_lock_init(&base->interrupt_lock);
  3539		spin_lock_init(&base->execmd_lock);
  3540	
  3541		/* Get IO for logical channel parameter address (LCPA) */
  3542		np_lcpa = of_parse_phandle(np, "sram", 0);
  3543		if (!np_lcpa) {
  3544			dev_err(&pdev->dev, "no LCPA SRAM node\n");
  3545			goto report_failure;
  3546		}
  3547		/* This is no device so read the address directly from the node */
  3548		ret = of_address_to_resource(np_lcpa, 0, &res_lcpa);
  3549		if (ret) {
  3550			dev_err(&pdev->dev, "no LCPA SRAM resource\n");
  3551			goto report_failure;
  3552		}
  3553		base->lcpa_size = resource_size(&res_lcpa);
  3554		base->phy_lcpa = res_lcpa.start;
> 3555		dev_info(&pdev->dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
  3556			 base->phy_lcpa, base->lcpa_size);
  3557	
  3558		/* We make use of ESRAM memory for this. */
  3559		val = readl(base->virtbase + D40_DREG_LCPA);
  3560		if (base->phy_lcpa != val && val != 0) {
  3561			dev_warn(&pdev->dev,
  3562				 "[%s] Mismatch LCPA dma 0x%x, def %08x\n",
  3563				 __func__, val, base->phy_lcpa);
  3564		} else
  3565			writel(base->phy_lcpa, base->virtbase + D40_DREG_LCPA);
  3566	
  3567		base->lcpa_base = ioremap(base->phy_lcpa, base->lcpa_size);
  3568		if (!base->lcpa_base) {
  3569			ret = -ENOMEM;
  3570			d40_err(&pdev->dev, "Failed to ioremap LCPA region\n");
  3571			goto release_base;
  3572		}
  3573		/* If lcla has to be located in ESRAM we don't need to allocate */
  3574		if (base->plat_data->use_esram_lcla) {
  3575			res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
  3576								"lcla_esram");
  3577			if (!res) {
  3578				ret = -ENOENT;
  3579				d40_err(&pdev->dev,
  3580					"No \"lcla_esram\" memory resource\n");
  3581				goto destroy_cache;
  3582			}
  3583			base->lcla_pool.base = ioremap(res->start,
  3584							resource_size(res));
  3585			if (!base->lcla_pool.base) {
  3586				ret = -ENOMEM;
  3587				d40_err(&pdev->dev, "Failed to ioremap LCLA region\n");
  3588				goto destroy_cache;
  3589			}
  3590			writel(res->start, base->virtbase + D40_DREG_LCLA);
  3591	
  3592		} else {
  3593			ret = d40_lcla_allocate(base);
  3594			if (ret) {
  3595				d40_err(&pdev->dev, "Failed to allocate LCLA area\n");
  3596				goto destroy_cache;
  3597			}
  3598		}
  3599	
  3600		spin_lock_init(&base->lcla_pool.lock);
  3601	
  3602		base->irq = platform_get_irq(pdev, 0);
  3603	
  3604		ret = request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
  3605		if (ret) {
  3606			d40_err(&pdev->dev, "No IRQ defined\n");
  3607			goto destroy_cache;
  3608		}
  3609	
  3610		if (base->plat_data->use_esram_lcla) {
  3611	
  3612			base->lcpa_regulator = regulator_get(base->dev, "lcla_esram");
  3613			if (IS_ERR(base->lcpa_regulator)) {
  3614				d40_err(&pdev->dev, "Failed to get lcpa_regulator\n");
  3615				ret = PTR_ERR(base->lcpa_regulator);
  3616				base->lcpa_regulator = NULL;
  3617				goto destroy_cache;
  3618			}
  3619	
  3620			ret = regulator_enable(base->lcpa_regulator);
  3621			if (ret) {
  3622				d40_err(&pdev->dev,
  3623					"Failed to enable lcpa_regulator\n");
  3624				regulator_put(base->lcpa_regulator);
  3625				base->lcpa_regulator = NULL;
  3626				goto destroy_cache;
  3627			}
  3628		}
  3629	
  3630		writel_relaxed(D40_DREG_GCC_ENABLE_ALL, base->virtbase + D40_DREG_GCC);
  3631	
  3632		pm_runtime_irq_safe(base->dev);
  3633		pm_runtime_set_autosuspend_delay(base->dev, DMA40_AUTOSUSPEND_DELAY);
  3634		pm_runtime_use_autosuspend(base->dev);
  3635		pm_runtime_mark_last_busy(base->dev);
  3636		pm_runtime_set_active(base->dev);
  3637		pm_runtime_enable(base->dev);
  3638	
  3639		ret = d40_dmaengine_init(base, num_reserved_chans);
  3640		if (ret)
  3641			goto destroy_cache;
  3642	
  3643		ret = dma_set_max_seg_size(base->dev, STEDMA40_MAX_SEG_SIZE);
  3644		if (ret) {
  3645			d40_err(&pdev->dev, "Failed to set dma max seg size\n");
  3646			goto destroy_cache;
  3647		}
  3648	
  3649		d40_hw_init(base);
  3650	
  3651		if (np) {
  3652			ret = of_dma_controller_register(np, d40_xlate, NULL);
  3653			if (ret)
  3654				dev_err(&pdev->dev,
  3655					"could not register of_dma_controller\n");
  3656		}
  3657	
  3658		dev_info(base->dev, "initialized\n");
  3659		return 0;
  3660	 destroy_cache:
  3661		kmem_cache_destroy(base->desc_slab);
  3662		if (base->virtbase)
  3663			iounmap(base->virtbase);
  3664	
  3665		if (base->lcla_pool.base && base->plat_data->use_esram_lcla) {
  3666			iounmap(base->lcla_pool.base);
  3667			base->lcla_pool.base = NULL;
  3668		}
  3669	
  3670		if (base->lcla_pool.dma_addr)
  3671			dma_unmap_single(base->dev, base->lcla_pool.dma_addr,
  3672					 SZ_1K * base->num_phy_chans,
  3673					 DMA_TO_DEVICE);
  3674	
  3675		if (!base->lcla_pool.base_unaligned && base->lcla_pool.base)
  3676			free_pages((unsigned long)base->lcla_pool.base,
  3677				   base->lcla_pool.pages);
  3678	
  3679		kfree(base->lcla_pool.base_unaligned);
  3680	
  3681		if (base->lcpa_base)
  3682			iounmap(base->lcpa_base);
  3683	
  3684	release_base:
  3685		if (base->phy_start)
  3686			release_mem_region(base->phy_start,
  3687					   base->phy_size);
  3688		if (base->clk) {
  3689			clk_disable_unprepare(base->clk);
  3690			clk_put(base->clk);
  3691		}
  3692	
  3693		if (base->lcpa_regulator) {
  3694			regulator_disable(base->lcpa_regulator);
  3695			regulator_put(base->lcpa_regulator);
  3696		}
  3697	
  3698		kfree(base->lcla_pool.alloc_map);
  3699		kfree(base->lookup_log_chans);
  3700		kfree(base->lookup_phy_chans);
  3701		kfree(base->phy_res);
  3702		kfree(base);
  3703	 report_failure:
  3704		d40_err(&pdev->dev, "probe failed\n");
  3705		return ret;
  3706	}
  3707	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
