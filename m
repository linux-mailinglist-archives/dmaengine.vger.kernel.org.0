Return-Path: <dmaengine+bounces-9516-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH7IJ/g5u2mJhAIAu9opvQ
	(envelope-from <dmaengine+bounces-9516-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 00:49:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECDE2C3EA4
	for <lists+dmaengine@lfdr.de>; Thu, 19 Mar 2026 00:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D539E3029608
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0A3921E7;
	Wed, 18 Mar 2026 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFljARgi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434138F251;
	Wed, 18 Mar 2026 23:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877747; cv=none; b=sZakdFE9IsGo5+hqgWnsSMyzWV51IbVDKnWyLGY6v4Ee8JNoptonuDHEH3d6wOWrbwuq59UkYKiS7HwRlbCC8NJwLzBxg/qEIq+/G+qUu9/9NIMoxiaFLkSzgwrA+STM501DmEqxP/qiWBKEfU+1BBz6h1FVvANlMfOW2ngHdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877747; c=relaxed/simple;
	bh=2Y1T4P2y8nfo8rEBpPRjqu1G7Nk53ZqugMUvnSqHK5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvLDZkdhVmsJsMy4Eb4CvlSemL351YiJs2nmV9n9xCMQXiunyytRq7TiCmbtOLMK9SONvpiJ01WlRAg5kXYimN4j3E2biPX06tlFOk3xVemhlRbpRBMIKM0m58jgW0birKUla8yWnYl0cb+OH6bYnPW7JGTby4pCmHsPyx/aD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFljARgi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773877746; x=1805413746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Y1T4P2y8nfo8rEBpPRjqu1G7Nk53ZqugMUvnSqHK5o=;
  b=gFljARgiCZButRwUCDFluy7a4v/e3+OIdJsPwWBGVZNZcopdkgBIwm4h
   m9u/3Sbbz2f/zDVxiSVwZ9Oa90tsgx236UvhbpihP1rBbaoSqUaGCBkne
   bsEpEscoJJULUdPnAY3OPZKda8OG3F0klO+Af3Dcc3Z72awyCE4u16tY5
   C0Qhha5UHLi9fE3xV6aIKOF+4WkhArbKHKOkUE2RNS95lQwdla7m7zffV
   jnmdDqH2UDohwiAZgKDTsuvZn6Xcr37JQOm0jwrlorbDLxYCDPJ9upBP3
   XU5YxEI1hUEM0oCQuPk77bJWQgnyAgy4idwfQtwNpO/1zZQD/fS1iQOmF
   A==;
X-CSE-ConnectionGUID: 4hRdAfypQsyMQo+E5r3Bpg==
X-CSE-MsgGUID: ijv+bknCRjqoH4es4HAycw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="77555040"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="77555040"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 16:49:06 -0700
X-CSE-ConnectionGUID: gNHpDHCHRweZCW0b8lnR9w==
X-CSE-MsgGUID: lIs+AGcuQjCvMOsQQTdltA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="227739876"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 18 Mar 2026 16:49:02 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w30b2-0000000005T-3Tk0;
	Wed, 18 Mar 2026 23:47:43 +0000
Date: Thu, 19 Mar 2026 07:42:28 +0800
From: kernel test robot <lkp@intel.com>
To: Sheetal <sheetal@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Frank Li <Frank.Li@kernel.org>, Mohan Kumar <mkumard@nvidia.com>,
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sheetal <sheetal@nvidia.com>
Subject: Re: [PATCH] dmaengine: tegra210-adma: Add error logging on failure
 paths
Message-ID: <202603190728.xcKzTcOu-lkp@intel.com>
References: <20260318073922.1760132-1-sheetal@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318073922.1760132-1-sheetal@nvidia.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9516-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:dkim,intel.com:email,intel.com:mid,git-scm.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ECDE2C3EA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sheetal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on linus/master v7.0-rc4 next-20260318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sheetal/dmaengine-tegra210-adma-Add-error-logging-on-failure-paths/20260318-214221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20260318073922.1760132-1-sheetal%40nvidia.com
patch subject: [PATCH] dmaengine: tegra210-adma: Add error logging on failure paths
config: i386-buildonly-randconfig-001-20260319 (https://download.01.org/0day-ci/archive/20260319/202603190728.xcKzTcOu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260319/202603190728.xcKzTcOu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603190728.xcKzTcOu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/tegra210-adma.c:1083:55: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
    1083 |                                 dev_err(&pdev->dev, "invalid page number %llu\n", page_no);
         |                                                                          ~~~~     ^~~~~~~
         |                                                                          %u
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +1083 drivers/dma/tegra210-adma.c

  1033	
  1034	static int tegra_adma_probe(struct platform_device *pdev)
  1035	{
  1036		const struct tegra_adma_chip_data *cdata;
  1037		struct tegra_adma *tdma;
  1038		struct resource *res_page, *res_base;
  1039		int ret, i;
  1040	
  1041		cdata = of_device_get_match_data(&pdev->dev);
  1042		if (!cdata) {
  1043			dev_err(&pdev->dev, "device match data not found\n");
  1044			return -ENODEV;
  1045		}
  1046	
  1047		tdma = devm_kzalloc(&pdev->dev,
  1048				    struct_size(tdma, channels, cdata->nr_channels),
  1049				    GFP_KERNEL);
  1050		if (!tdma)
  1051			return -ENOMEM;
  1052	
  1053		tdma->dev = &pdev->dev;
  1054		tdma->cdata = cdata;
  1055		tdma->nr_channels = cdata->nr_channels;
  1056		platform_set_drvdata(pdev, tdma);
  1057	
  1058		res_page = platform_get_resource_byname(pdev, IORESOURCE_MEM, "page");
  1059		if (res_page) {
  1060			tdma->ch_base_addr = devm_ioremap_resource(&pdev->dev, res_page);
  1061			if (IS_ERR(tdma->ch_base_addr)) {
  1062				dev_err(&pdev->dev, "failed to map page resource\n");
  1063				return PTR_ERR(tdma->ch_base_addr);
  1064			}
  1065	
  1066			res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
  1067			if (res_base) {
  1068				resource_size_t page_offset, page_no;
  1069				unsigned int ch_base_offset;
  1070	
  1071				if (res_page->start < res_base->start) {
  1072					dev_err(&pdev->dev, "invalid page/global resource order\n");
  1073					return -EINVAL;
  1074				}
  1075	
  1076				page_offset = res_page->start - res_base->start;
  1077				ch_base_offset = cdata->ch_base_offset;
  1078				if (!ch_base_offset)
  1079					return -EINVAL;
  1080	
  1081				page_no = div_u64(page_offset, ch_base_offset);
  1082				if (!page_no || page_no > INT_MAX) {
> 1083					dev_err(&pdev->dev, "invalid page number %llu\n", page_no);
  1084					return -EINVAL;
  1085				}
  1086	
  1087				tdma->ch_page_no = page_no - 1;
  1088				tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
  1089				if (IS_ERR(tdma->base_addr)) {
  1090					dev_err(&pdev->dev, "failed to map global resource\n");
  1091					return PTR_ERR(tdma->base_addr);
  1092				}
  1093			}
  1094		} else {
  1095			/* If no 'page' property found, then reg DT binding would be legacy */
  1096			res_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1097			if (res_base) {
  1098				tdma->base_addr = devm_ioremap_resource(&pdev->dev, res_base);
  1099				if (IS_ERR(tdma->base_addr)) {
  1100					dev_err(&pdev->dev, "failed to map base resource\n");
  1101					return PTR_ERR(tdma->base_addr);
  1102				}
  1103			} else {
  1104				dev_err(&pdev->dev, "failed to map mem resource\n");
  1105				return -ENODEV;
  1106			}
  1107	
  1108			tdma->ch_base_addr = tdma->base_addr + cdata->ch_base_offset;
  1109		}
  1110	
  1111		tdma->ahub_clk = devm_clk_get(&pdev->dev, "d_audio");
  1112		if (IS_ERR(tdma->ahub_clk)) {
  1113			dev_err(&pdev->dev, "Error: Missing ahub controller clock\n");
  1114			return PTR_ERR(tdma->ahub_clk);
  1115		}
  1116	
  1117		tdma->dma_chan_mask = devm_kzalloc(&pdev->dev,
  1118						   BITS_TO_LONGS(tdma->nr_channels) * sizeof(unsigned long),
  1119						   GFP_KERNEL);
  1120		if (!tdma->dma_chan_mask)
  1121			return -ENOMEM;
  1122	
  1123		/* Enable all channels by default */
  1124		bitmap_fill(tdma->dma_chan_mask, tdma->nr_channels);
  1125	
  1126		ret = of_property_read_u32_array(pdev->dev.of_node, "dma-channel-mask",
  1127						 (u32 *)tdma->dma_chan_mask,
  1128						 BITS_TO_U32(tdma->nr_channels));
  1129		if (ret < 0 && (ret != -EINVAL)) {
  1130			dev_err(&pdev->dev, "dma-channel-mask is not complete.\n");
  1131			return ret;
  1132		}
  1133	
  1134		INIT_LIST_HEAD(&tdma->dma_dev.channels);
  1135		for (i = 0; i < tdma->nr_channels; i++) {
  1136			struct tegra_adma_chan *tdc = &tdma->channels[i];
  1137	
  1138			/* skip for reserved channels */
  1139			if (!test_bit(i, tdma->dma_chan_mask))
  1140				continue;
  1141	
  1142			tdc->chan_addr = tdma->ch_base_addr + (cdata->ch_reg_size * i);
  1143	
  1144			if (tdma->base_addr) {
  1145				if (cdata->global_ch_fifo_base)
  1146					tdc->global_ch_fifo_offset = cdata->global_ch_fifo_base + (4 * i);
  1147	
  1148				if (cdata->global_ch_config_base)
  1149					tdc->global_ch_config_offset =
  1150						cdata->global_ch_config_base + (4 * i);
  1151			}
  1152	
  1153			tdc->irq = of_irq_get(pdev->dev.of_node, i);
  1154			if (tdc->irq <= 0) {
  1155				ret = tdc->irq ?: -ENXIO;
  1156				dev_err_probe(&pdev->dev, ret, "failed to get IRQ for channel %d\n", i);
  1157				goto irq_dispose;
  1158			}
  1159	
  1160			vchan_init(&tdc->vc, &tdma->dma_dev);
  1161			tdc->vc.desc_free = tegra_adma_desc_free;
  1162			tdc->tdma = tdma;
  1163		}
  1164	
  1165		pm_runtime_enable(&pdev->dev);
  1166	
  1167		ret = pm_runtime_resume_and_get(&pdev->dev);
  1168		if (ret < 0) {
  1169			dev_err(&pdev->dev, "runtime PM resume failed: %d\n", ret);
  1170			goto rpm_disable;
  1171		}
  1172	
  1173		ret = tegra_adma_init(tdma);
  1174		if (ret) {
  1175			dev_err(&pdev->dev, "failed to initialize ADMA: %d\n", ret);
  1176			goto rpm_put;
  1177		}
  1178	
  1179		dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
  1180		dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
  1181		dma_cap_set(DMA_CYCLIC, tdma->dma_dev.cap_mask);
  1182	
  1183		tdma->dma_dev.dev = &pdev->dev;
  1184		tdma->dma_dev.device_alloc_chan_resources =
  1185						tegra_adma_alloc_chan_resources;
  1186		tdma->dma_dev.device_free_chan_resources =
  1187						tegra_adma_free_chan_resources;
  1188		tdma->dma_dev.device_issue_pending = tegra_adma_issue_pending;
  1189		tdma->dma_dev.device_prep_dma_cyclic = tegra_adma_prep_dma_cyclic;
  1190		tdma->dma_dev.device_config = tegra_adma_slave_config;
  1191		tdma->dma_dev.device_tx_status = tegra_adma_tx_status;
  1192		tdma->dma_dev.device_terminate_all = tegra_adma_terminate_all;
  1193		tdma->dma_dev.device_synchronize = tegra_adma_synchronize;
  1194		tdma->dma_dev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
  1195		tdma->dma_dev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
  1196		tdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
  1197		tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
  1198		tdma->dma_dev.device_pause = tegra_adma_pause;
  1199		tdma->dma_dev.device_resume = tegra_adma_resume;
  1200	
  1201		ret = dma_async_device_register(&tdma->dma_dev);
  1202		if (ret < 0) {
  1203			dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
  1204			goto rpm_put;
  1205		}
  1206	
  1207		ret = of_dma_controller_register(pdev->dev.of_node,
  1208						 tegra_dma_of_xlate, tdma);
  1209		if (ret < 0) {
  1210			dev_err(&pdev->dev, "ADMA OF registration failed %d\n", ret);
  1211			goto dma_remove;
  1212		}
  1213	
  1214		pm_runtime_put(&pdev->dev);
  1215	
  1216		dev_info(&pdev->dev, "Tegra210 ADMA driver registered %d channels\n",
  1217			 tdma->nr_channels);
  1218	
  1219		return 0;
  1220	
  1221	dma_remove:
  1222		dma_async_device_unregister(&tdma->dma_dev);
  1223	rpm_put:
  1224		pm_runtime_put_sync(&pdev->dev);
  1225	rpm_disable:
  1226		pm_runtime_disable(&pdev->dev);
  1227	irq_dispose:
  1228		while (--i >= 0)
  1229			irq_dispose_mapping(tdma->channels[i].irq);
  1230	
  1231		return ret;
  1232	}
  1233	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

