Return-Path: <dmaengine+bounces-3606-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B5C9B1FD7
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 20:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23B71F21344
	for <lists+dmaengine@lfdr.de>; Sun, 27 Oct 2024 19:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4401714B4;
	Sun, 27 Oct 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLGEv9rX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB421BF37;
	Sun, 27 Oct 2024 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730056408; cv=none; b=EcPRglF9J6vw5K57CCcBAvnQZwnskwz1o1biZqIfDqQowIy27tMbNEDa+6fmu1tDlfNnmlN1YJ4oqasV7F3yu1wneRhKb7nX7EVNna4Ggn+dGcZPRRhb1eICcx/A1dkaQaXx9/EEOIC/esDGXAtLLGKJjjur6LSaxdSIZYK/SGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730056408; c=relaxed/simple;
	bh=UOBtR7avR4LJi9ncivSqNFYPGG3xDXyQQ8t6Oyigaus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyRsp85PxiLpX/l3p2pCD70GUf3PmlaLOKgFsPl9adzwEefM6Maz+y0OfZ7hMtMLeawKNXJh836YWUIOTbJEzrv9QYXNBw4nsYNM0JOl/CAmZEGPyedhXDb3xNsVFc3ycSOWO86LTYNyGrrEG6GXQb4vHe/cslfZECdio4wAwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLGEv9rX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730056405; x=1761592405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UOBtR7avR4LJi9ncivSqNFYPGG3xDXyQQ8t6Oyigaus=;
  b=mLGEv9rXac1mY5n6zDvFIyiXB0ZEKomTd7dVd/IofC3lfB8IYsrhN6ny
   ge1E0loiMM3ttCcOiNuGY8hlkIX/QCWArWXSaVLZZ0OiNEA6CF4GITlMd
   RJBfH+yW6+OXRlg+LcxximqFQ7Bq1+CN+UXprCgY4SK0eaMdr2PIcvqfm
   6zm2qmk7s/xFDei6OB8w8MAbC7lMayk5Ke6DQoqBtnDr/Y/3VcXqPD+kc
   LctMU0nobpGCXFovngStp2LQoXaSrqtho7kmy40kGUHP1JuZ14JuNjnpC
   Bx462YTcYspd3cVT7/jwun2dWSPcwP/tkEmBAnsK2tp99uafF54EVsQR8
   A==;
X-CSE-ConnectionGUID: ehkuWjfMTnKOWup07UIVMA==
X-CSE-MsgGUID: xavNRLF+Q76dNdq0R37MvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="33454094"
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="33454094"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 12:13:25 -0700
X-CSE-ConnectionGUID: EmkVCLkfRJqj4ztNf3jeUQ==
X-CSE-MsgGUID: 50isPq14Ty+074B2ysi87g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="81854668"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Oct 2024 12:13:22 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t58hT-000avQ-25;
	Sun, 27 Oct 2024 19:13:19 +0000
Date: Mon, 28 Oct 2024 03:12:53 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Mesih Kilinc <mesihkilinc@gmail.com>,
	=?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>,
	Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 02/10] dma-engine: sun4i: Add has_reset option to quirk
Message-ID: <202410280225.baqFmTsa-lkp@intel.com>
References: <20241027091440.1913863-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027091440.1913863-2-csokas.bence@prolan.hu>

Hi Bence,

kernel test robot noticed the following build errors:

[auto build test ERROR on sunxi/sunxi/for-next]
[also build test ERROR on vkoul-dmaengine/next broonie-sound/for-next arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next arm/for-next arm/fixes linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cs-k-s-Bence/dma-engine-sun4i-Add-has_reset-option-to-quirk/20241027-172307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
patch link:    https://lore.kernel.org/r/20241027091440.1913863-2-csokas.bence%40prolan.hu
patch subject: [PATCH v2 02/10] dma-engine: sun4i: Add has_reset option to quirk
config: arm-multi_v7_defconfig (https://download.01.org/0day-ci/archive/20241028/202410280225.baqFmTsa-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241028/202410280225.baqFmTsa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410280225.baqFmTsa-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/dma/sun4i-dma.c: In function 'sun4i_dma_probe':
>> drivers/dma/sun4i-dma.c:1225:51: warning: passing argument 2 of 'dev_err_probe' makes integer from pointer without a cast [-Wint-conversion]
    1225 |                         dev_err_probe(&pdev->dev, "Failed to get reset control\n");
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                   |
         |                                                   char *
   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:8,
                    from drivers/dma/sun4i-dma.c:10:
   include/linux/dev_printk.h:278:64: note: expected 'int' but argument is of type 'char *'
     278 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                                                            ~~~~^~~
>> drivers/dma/sun4i-dma.c:1225:25: error: too few arguments to function 'dev_err_probe'
    1225 |                         dev_err_probe(&pdev->dev, "Failed to get reset control\n");
         |                         ^~~~~~~~~~~~~
   include/linux/dev_printk.h:278:20: note: declared here
     278 | __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
         |                    ^~~~~~~~~~~~~


vim +/dev_err_probe +1225 drivers/dma/sun4i-dma.c

  1193	
  1194	static int sun4i_dma_probe(struct platform_device *pdev)
  1195	{
  1196		struct sun4i_dma_dev *priv;
  1197		int i, j, ret;
  1198	
  1199		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
  1200		if (!priv)
  1201			return -ENOMEM;
  1202	
  1203		priv->cfg = of_device_get_match_data(&pdev->dev);
  1204		if (!priv->cfg)
  1205			return -ENODEV;
  1206	
  1207		priv->base = devm_platform_ioremap_resource(pdev, 0);
  1208		if (IS_ERR(priv->base))
  1209			return PTR_ERR(priv->base);
  1210	
  1211		priv->irq = platform_get_irq(pdev, 0);
  1212		if (priv->irq < 0)
  1213			return priv->irq;
  1214	
  1215		priv->clk = devm_clk_get(&pdev->dev, NULL);
  1216		if (IS_ERR(priv->clk)) {
  1217			dev_err(&pdev->dev, "No clock specified\n");
  1218			return PTR_ERR(priv->clk);
  1219		}
  1220	
  1221		if (priv->cfg->has_reset) {
  1222			priv->rst = devm_reset_control_get_exclusive(&pdev->dev,
  1223								     NULL);
  1224			if (IS_ERR(priv->rst)) {
> 1225				dev_err_probe(&pdev->dev, "Failed to get reset control\n");
  1226				return PTR_ERR(priv->rst);
  1227			}
  1228		}
  1229	
  1230		platform_set_drvdata(pdev, priv);
  1231		spin_lock_init(&priv->lock);
  1232	
  1233		dma_set_max_seg_size(&pdev->dev, SUN4I_DMA_MAX_SEG_SIZE);
  1234	
  1235		dma_cap_zero(priv->slave.cap_mask);
  1236		dma_cap_set(DMA_PRIVATE, priv->slave.cap_mask);
  1237		dma_cap_set(DMA_MEMCPY, priv->slave.cap_mask);
  1238		dma_cap_set(DMA_CYCLIC, priv->slave.cap_mask);
  1239		dma_cap_set(DMA_SLAVE, priv->slave.cap_mask);
  1240	
  1241		INIT_LIST_HEAD(&priv->slave.channels);
  1242		priv->slave.device_free_chan_resources	= sun4i_dma_free_chan_resources;
  1243		priv->slave.device_tx_status		= sun4i_dma_tx_status;
  1244		priv->slave.device_issue_pending	= sun4i_dma_issue_pending;
  1245		priv->slave.device_prep_slave_sg	= sun4i_dma_prep_slave_sg;
  1246		priv->slave.device_prep_dma_memcpy	= sun4i_dma_prep_dma_memcpy;
  1247		priv->slave.device_prep_dma_cyclic	= sun4i_dma_prep_dma_cyclic;
  1248		priv->slave.device_config		= sun4i_dma_config;
  1249		priv->slave.device_terminate_all	= sun4i_dma_terminate_all;
  1250		priv->slave.copy_align			= 2;
  1251		priv->slave.src_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
  1252							  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
  1253							  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
  1254		priv->slave.dst_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
  1255							  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
  1256							  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
  1257		priv->slave.directions			= BIT(DMA_DEV_TO_MEM) |
  1258							  BIT(DMA_MEM_TO_DEV);
  1259		priv->slave.residue_granularity		= DMA_RESIDUE_GRANULARITY_BURST;
  1260	
  1261		priv->slave.dev = &pdev->dev;
  1262	
  1263		priv->pchans = devm_kcalloc(&pdev->dev, priv->cfg->dma_nr_max_channels,
  1264					    sizeof(struct sun4i_dma_pchan), GFP_KERNEL);
  1265		priv->vchans = devm_kcalloc(&pdev->dev, SUN4I_DMA_NR_MAX_VCHANS,
  1266					    sizeof(struct sun4i_dma_vchan), GFP_KERNEL);
  1267		priv->pchans_used = devm_kcalloc(&pdev->dev,
  1268						 BITS_TO_LONGS(priv->cfg->dma_nr_max_channels),
  1269						 sizeof(unsigned long), GFP_KERNEL);
  1270		if (!priv->vchans || !priv->pchans || !priv->pchans_used)
  1271			return -ENOMEM;
  1272	
  1273		/*
  1274		 * [0..priv->cfg->ndma_nr_max_channels) are normal pchans, and
  1275		 * [priv->cfg->ndma_nr_max_channels..priv->cfg->dma_nr_max_channels) are
  1276		 * dedicated ones
  1277		 */
  1278		for (i = 0; i < priv->cfg->ndma_nr_max_channels; i++)
  1279			priv->pchans[i].base = priv->base +
  1280				SUN4I_NDMA_CHANNEL_REG_BASE(i);
  1281	
  1282		for (j = 0; i < priv->cfg->dma_nr_max_channels; i++, j++) {
  1283			priv->pchans[i].base = priv->base +
  1284				SUN4I_DDMA_CHANNEL_REG_BASE(j);
  1285			priv->pchans[i].is_dedicated = 1;
  1286		}
  1287	
  1288		for (i = 0; i < SUN4I_DMA_NR_MAX_VCHANS; i++) {
  1289			struct sun4i_dma_vchan *vchan = &priv->vchans[i];
  1290	
  1291			spin_lock_init(&vchan->vc.lock);
  1292			vchan->vc.desc_free = sun4i_dma_free_contract;
  1293			vchan_init(&vchan->vc, &priv->slave);
  1294		}
  1295	
  1296		ret = clk_prepare_enable(priv->clk);
  1297		if (ret) {
  1298			dev_err(&pdev->dev, "Couldn't enable the clock\n");
  1299			return ret;
  1300		}
  1301	
  1302		/* Deassert the reset control */
  1303		ret = reset_control_deassert(priv->rst);
  1304		if (ret) {
  1305			dev_err(&pdev->dev,
  1306				"Failed to deassert the reset control\n");
  1307			goto err_clk_disable;
  1308		}
  1309	
  1310		/*
  1311		 * Make sure the IRQs are all disabled and accounted for. The bootloader
  1312		 * likes to leave these dirty
  1313		 */
  1314		writel(0, priv->base + SUN4I_DMA_IRQ_ENABLE_REG);
  1315		writel(0xFFFFFFFF, priv->base + SUN4I_DMA_IRQ_PENDING_STATUS_REG);
  1316	
  1317		ret = devm_request_irq(&pdev->dev, priv->irq, sun4i_dma_interrupt,
  1318				       0, dev_name(&pdev->dev), priv);
  1319		if (ret) {
  1320			dev_err(&pdev->dev, "Cannot request IRQ\n");
  1321			goto err_clk_disable;
  1322		}
  1323	
  1324		ret = dma_async_device_register(&priv->slave);
  1325		if (ret) {
  1326			dev_warn(&pdev->dev, "Failed to register DMA engine device\n");
  1327			goto err_clk_disable;
  1328		}
  1329	
  1330		ret = of_dma_controller_register(pdev->dev.of_node, sun4i_dma_of_xlate,
  1331						 priv);
  1332		if (ret) {
  1333			dev_err(&pdev->dev, "of_dma_controller_register failed\n");
  1334			goto err_dma_unregister;
  1335		}
  1336	
  1337		dev_dbg(&pdev->dev, "Successfully probed SUN4I_DMA\n");
  1338	
  1339		return 0;
  1340	
  1341	err_dma_unregister:
  1342		dma_async_device_unregister(&priv->slave);
  1343	err_clk_disable:
  1344		clk_disable_unprepare(priv->clk);
  1345		return ret;
  1346	}
  1347	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

