Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1338045DBA9
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 14:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355375AbhKYNyG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 08:54:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:37419 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355291AbhKYNwD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Nov 2021 08:52:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="259414637"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="259414637"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 05:43:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="457407725"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Nov 2021 05:43:38 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqF2H-0006Qt-LJ; Thu, 25 Nov 2021 13:43:37 +0000
Date:   Thu, 25 Nov 2021 21:42:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Akhil R <akhilrajeev@nvidia.com>, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v13 2/4] dmaengine: tegra: Add tegra gpcdma driver
Message-ID: <202111252148.4CbCTolF-lkp@intel.com>
References: <1637573292-13214-3-git-send-email-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637573292-13214-3-git-send-email-akhilrajeev@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Akhil,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on vkoul-dmaengine/next arm64/for-next/core v5.16-rc2 next-20211125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Akhil-R/Add-NVIDIA-Tegra-GPC-DMA-driver/20211122-173019
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arc-randconfig-m031-20211123 (https://download.01.org/0day-ci/archive/20211125/202111252148.4CbCTolF-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7707da9f914433ccc5718dd3431153d3b5bf485d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Akhil-R/Add-NVIDIA-Tegra-GPC-DMA-driver/20211122-173019
        git checkout 7707da9f914433ccc5718dd3431153d3b5bf485d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/dma/tegra186-gpc-dma.c:966:81: warning: right shift count >= width of type [-Wshift-count-overflow]
     966 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
         |                                                                                 ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:966:33: note: in expansion of macro 'FIELD_PREP'
     966 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
         |                                 ^~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:966:81: warning: right shift count >= width of type [-Wshift-count-overflow]
     966 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
         |                                                                                 ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:966:33: note: in expansion of macro 'FIELD_PREP'
     966 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
         |                                 ^~~~~~~~~~
   In file included from drivers/dma/tegra186-gpc-dma.c:8:
   drivers/dma/tegra186-gpc-dma.c:966:81: warning: right shift count >= width of type [-Wshift-count-overflow]
     966 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
         |                                                                                 ^~
   include/linux/bitfield.h:95:34: note: in definition of macro 'FIELD_PREP'
      95 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                  ^~~~
   In file included from <command-line>:
   drivers/dma/tegra186-gpc-dma.c:971:81: warning: right shift count >= width of type [-Wshift-count-overflow]
     971 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
         |                                                                                 ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:971:33: note: in expansion of macro 'FIELD_PREP'
     971 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
         |                                 ^~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:971:81: warning: right shift count >= width of type [-Wshift-count-overflow]
     971 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
         |                                                                                 ^~
   include/linux/compiler_types.h:315:23: note: in definition of macro '__compiletime_assert'
     315 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:335:9: note: in expansion of macro '_compiletime_assert'
     335 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:49:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      49 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:94:17: note: in expansion of macro '__BF_FIELD_CHECK'
      94 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/dma/tegra186-gpc-dma.c:971:33: note: in expansion of macro 'FIELD_PREP'
     971 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
         |                                 ^~~~~~~~~~
   In file included from drivers/dma/tegra186-gpc-dma.c:8:
   drivers/dma/tegra186-gpc-dma.c:971:81: warning: right shift count >= width of type [-Wshift-count-overflow]
     971 |                                 FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
         |                                                                                 ^~
   include/linux/bitfield.h:95:34: note: in definition of macro 'FIELD_PREP'
      95 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                  ^~~~
   drivers/dma/tegra186-gpc-dma.c: In function 'tegra_dma_probe':
>> drivers/dma/tegra186-gpc-dma.c:1121:31: error: 'struct iommu_fwspec' has no member named 'ids'
    1121 |         stream_id = iommu_spec->ids[0] & 0xffff;
         |                               ^~


vim +1121 drivers/dma/tegra186-gpc-dma.c

  1081	
  1082	static int tegra_dma_probe(struct platform_device *pdev)
  1083	{
  1084		const struct tegra_dma_chip_data *cdata = NULL;
  1085		struct iommu_fwspec *iommu_spec;
  1086		unsigned int stream_id, i;
  1087		struct tegra_dma *tdma;
  1088		struct resource	*res;
  1089		int ret;
  1090	
  1091		cdata = of_device_get_match_data(&pdev->dev);
  1092	
  1093		tdma = devm_kzalloc(&pdev->dev, sizeof(*tdma) + cdata->nr_channels *
  1094				sizeof(struct tegra_dma_channel), GFP_KERNEL);
  1095		if (!tdma)
  1096			return -ENOMEM;
  1097	
  1098		tdma->dev = &pdev->dev;
  1099		tdma->chip_data = cdata;
  1100		platform_set_drvdata(pdev, tdma);
  1101	
  1102		tdma->base_addr = devm_platform_ioremap_resource(pdev, 0);
  1103		if (IS_ERR(tdma->base_addr))
  1104			return PTR_ERR(tdma->base_addr);
  1105	
  1106		tdma->rst = devm_reset_control_get_exclusive(&pdev->dev, "gpcdma");
  1107		if (IS_ERR(tdma->rst)) {
  1108			dev_err_probe(&pdev->dev, PTR_ERR(tdma->rst),
  1109				      "Missing controller reset\n");
  1110			return PTR_ERR(tdma->rst);
  1111		}
  1112		reset_control_reset(tdma->rst);
  1113	
  1114		tdma->dma_dev.dev = &pdev->dev;
  1115	
  1116		iommu_spec = dev_iommu_fwspec_get(&pdev->dev);
  1117		if (!iommu_spec) {
  1118			dev_err(&pdev->dev, "Missing iommu stream-id\n");
  1119			return -EINVAL;
  1120		}
> 1121		stream_id = iommu_spec->ids[0] & 0xffff;
  1122	
  1123		INIT_LIST_HEAD(&tdma->dma_dev.channels);
  1124		for (i = 0; i < cdata->nr_channels; i++) {
  1125			struct tegra_dma_channel *tdc = &tdma->channels[i];
  1126	
  1127			tdc->chan_base_offset = TEGRA_GPCDMA_CHANNEL_BASE_ADD_OFFSET +
  1128						i * cdata->channel_reg_size;
  1129			res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
  1130			if (!res) {
  1131				dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
  1132				return -EINVAL;
  1133			}
  1134			tdc->irq = res->start;
  1135			snprintf(tdc->name, sizeof(tdc->name), "gpcdma.%d", i);
  1136	
  1137			tdc->tdma = tdma;
  1138			tdc->id = i;
  1139			tdc->slave_id = -1;
  1140	
  1141			vchan_init(&tdc->vc, &tdma->dma_dev);
  1142			tdc->vc.desc_free = tegra_dma_desc_free;
  1143			raw_spin_lock_init(&tdc->lock);
  1144	
  1145			/* program stream-id for this channel */
  1146			tegra_dma_program_sid(tdc, i, stream_id);
  1147			tdc->stream_id = stream_id;
  1148		}
  1149	
  1150		dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
  1151		dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
  1152		dma_cap_set(DMA_MEMCPY, tdma->dma_dev.cap_mask);
  1153		dma_cap_set(DMA_MEMSET, tdma->dma_dev.cap_mask);
  1154	
  1155		/*
  1156		 * Only word aligned transfers are supported. Set the copy
  1157		 * alignment shift.
  1158		 */
  1159		tdma->dma_dev.copy_align = 2;
  1160		tdma->dma_dev.fill_align = 2;
  1161		tdma->dma_dev.device_alloc_chan_resources =
  1162						tegra_dma_alloc_chan_resources;
  1163		tdma->dma_dev.device_free_chan_resources =
  1164						tegra_dma_free_chan_resources;
  1165		tdma->dma_dev.device_prep_slave_sg = tegra_dma_prep_slave_sg;
  1166		tdma->dma_dev.device_prep_dma_memcpy = tegra_dma_prep_dma_memcpy;
  1167		tdma->dma_dev.device_prep_dma_memset = tegra_dma_prep_dma_memset;
  1168		tdma->dma_dev.device_config = tegra_dma_slave_config;
  1169		tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
  1170		tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
  1171		tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
  1172		tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
  1173		tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
  1174	
  1175		/* Register DMA channel interrupt handlers after everything is setup */
  1176		for (i = 0; i < cdata->nr_channels; i++) {
  1177			struct tegra_dma_channel *tdc = &tdma->channels[i];
  1178	
  1179			ret = devm_request_irq(&pdev->dev, tdc->irq,
  1180					       tegra_dma_isr, 0, tdc->name, tdc);
  1181			if (ret) {
  1182				dev_err_probe(&pdev->dev, ret,
  1183					      "request_irq failed for channel %d\n", i);
  1184				return ret;
  1185			}
  1186		}
  1187	
  1188		ret = dma_async_device_register(&tdma->dma_dev);
  1189		if (ret < 0) {
  1190			dev_err_probe(&pdev->dev, ret,
  1191				      "GPC DMA driver registration failed\n");
  1192			return ret;
  1193		}
  1194	
  1195		ret = of_dma_controller_register(pdev->dev.of_node,
  1196						 tegra_dma_of_xlate, tdma);
  1197		if (ret < 0) {
  1198			dev_err_probe(&pdev->dev, ret,
  1199				      "GPC DMA OF registration failed\n");
  1200	
  1201			dma_async_device_unregister(&tdma->dma_dev);
  1202			return ret;
  1203		}
  1204	
  1205		dev_info(&pdev->dev, "GPC DMA driver register %d channels\n",
  1206			 cdata->nr_channels);
  1207	
  1208		return 0;
  1209	}
  1210	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
