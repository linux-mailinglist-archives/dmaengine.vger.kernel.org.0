Return-Path: <dmaengine+bounces-6183-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E65DB32DDE
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 09:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E140316FE1B
	for <lists+dmaengine@lfdr.de>; Sun, 24 Aug 2025 07:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A731A256E;
	Sun, 24 Aug 2025 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JV16iiLW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D184139D;
	Sun, 24 Aug 2025 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756018928; cv=none; b=ikApePezMc40iYwaNBrN9bzMT7rhKzR2xaq0BbD7CoDE/G/dRdddYXa56kZh3qfIrTH76aAHDp91ltaN20HKPA1ogQlMPzye9iZk0cc5Q4S2xVeSWNdk4UsU8S2Gfd9eejWpFj/99nybFVGh85mMiTW54HR8J/86sw6uADD908Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756018928; c=relaxed/simple;
	bh=yL0lGPAOO93gDrZ7xJMIvQXzfdJ9VVCP89jSwd6gbDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I55D89tf/Nd26wU2pgT1kDAbdVeGAuFFXVy6dWuWmye8KQl+7t15LyRer8rm2ZZ3mzItK2dRSTJAhcIjP8KGt626/MGehYWsCdb47vFzsikXtdgliu7Lnf3wk6Rd/NB+7zZnUY3fVQHWpFwSyJY1ydd+FpuCteDeQylGHE0VXFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JV16iiLW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756018926; x=1787554926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yL0lGPAOO93gDrZ7xJMIvQXzfdJ9VVCP89jSwd6gbDw=;
  b=JV16iiLWsxgCghtptr1S45nRVKwtTxyVIqOCw9TVhD6Kvr7xgzw+K4MB
   bi0ag0026dzofYSZy0C1WKx5yh3NhUxTPzyxSxhqxhYGFQqG58PszJDWU
   Rhasp8AhSjGnWembYBUu1kd1r6lJnEFt35aFqmKhl3T3dwFAbRRyRSwvf
   m2G9yEk3hRJHqrXL+hNXZPEiE+p7o+54wIVDIpP1bZlwwxeybndo1FxCv
   pSmFRlHp9/9/5kbFILODCwLy3q9fjuRM53+BVcS0Hdyq6K2SAEw1p402a
   Er0Bues2oYwz2JTwxqEO5fyz/iJUkrMBHIQcxjJn2fMEzsxKT3HpOEDkI
   A==;
X-CSE-ConnectionGUID: 8/V4Gr1zTf+3IRs1KG4+1w==
X-CSE-MsgGUID: BzgKhN+5R+m+Y3pNLn//cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68531096"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68531096"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 00:02:05 -0700
X-CSE-ConnectionGUID: ib3gjzHqQGKXPhM7YT4g6g==
X-CSE-MsgGUID: 0Lahs1t0TuaDcAFWmlTz8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168952862"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 24 Aug 2025 00:02:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uq4jm-000MqZ-0Q;
	Sun, 24 Aug 2025 07:01:58 +0000
Date: Sun, 24 Aug 2025 15:01:31 +0800
From: kernel test robot <lkp@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] dmaengine: dma350: Support dma-channel-mask
Message-ID: <202508241415.b7kiTLel-lkp@intel.com>
References: <20250823154009.25992-10-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823154009.25992-10-jszhang@kernel.org>

Hi Jisheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vkoul-dmaengine/next]
[also build test WARNING on robh/for-next linus/master v6.17-rc2 next-20250822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/dmaengine-dma350-Fix-CH_CTRL_USESRCTRIGIN-definition/20250824-000425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20250823154009.25992-10-jszhang%40kernel.org
patch subject: [PATCH 09/14] dmaengine: dma350: Support dma-channel-mask
config: arm64-randconfig-002-20250824 (https://download.01.org/0day-ci/archive/20250824/202508241415.b7kiTLel-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250824/202508241415.b7kiTLel-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508241415.b7kiTLel-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/arm-dma350.c: In function 'd350_probe':
>> drivers/dma/arm-dma350.c:620:61: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Wformat-truncation=]
     620 |                 snprintf(ch_irqname, sizeof(ch_irqname), "ch%d", i);
         |                                                             ^~
   drivers/dma/arm-dma350.c:620:58: note: directive argument in the range [0, 2147483646]
     620 |                 snprintf(ch_irqname, sizeof(ch_irqname), "ch%d", i);
         |                                                          ^~~~~~
   drivers/dma/arm-dma350.c:620:17: note: 'snprintf' output between 4 and 13 bytes into a destination of size 8
     620 |                 snprintf(ch_irqname, sizeof(ch_irqname), "ch%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +620 drivers/dma/arm-dma350.c

   531	
   532	static int d350_probe(struct platform_device *pdev)
   533	{
   534		struct device *dev = &pdev->dev;
   535		struct d350 *dmac;
   536		void __iomem *base;
   537		u32 reg, dma_chan_mask;
   538		int ret, nchan, dw, aw, r, p;
   539		bool coherent, memset;
   540	
   541		base = devm_platform_ioremap_resource(pdev, 0);
   542		if (IS_ERR(base))
   543			return PTR_ERR(base);
   544	
   545		reg = readl_relaxed(base + DMAINFO + IIDR);
   546		r = FIELD_GET(IIDR_VARIANT, reg);
   547		p = FIELD_GET(IIDR_REVISION, reg);
   548		if (FIELD_GET(IIDR_IMPLEMENTER, reg) != IMPLEMENTER_ARM ||
   549		    FIELD_GET(IIDR_PRODUCTID, reg) != PRODUCTID_DMA350)
   550			return dev_err_probe(dev, -ENODEV, "Not a DMA-350!");
   551	
   552		reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG0);
   553		nchan = FIELD_GET(DMA_CFG_NUM_CHANNELS, reg) + 1;
   554		dw = 1 << FIELD_GET(DMA_CFG_DATA_WIDTH, reg);
   555		aw = FIELD_GET(DMA_CFG_ADDR_WIDTH, reg) + 1;
   556	
   557		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(aw));
   558		coherent = device_get_dma_attr(dev) == DEV_DMA_COHERENT;
   559	
   560		dmac = devm_kzalloc(dev, struct_size(dmac, channels, nchan), GFP_KERNEL);
   561		if (!dmac)
   562			return -ENOMEM;
   563	
   564		dmac->nchan = nchan;
   565	
   566		/* Enable all channels by default */
   567		dma_chan_mask = nchan - 1;
   568	
   569		ret = of_property_read_u32(dev->of_node, "dma-channel-mask", &dma_chan_mask);
   570		if (ret < 0 && (ret != -EINVAL)) {
   571			dev_err(&pdev->dev, "dma-channel-mask is not complete.\n");
   572			return ret;
   573		}
   574	
   575		reg = readl_relaxed(base + DMAINFO + DMA_BUILDCFG1);
   576		dmac->nreq = FIELD_GET(DMA_CFG_NUM_TRIGGER_IN, reg);
   577	
   578		dev_dbg(dev, "DMA-350 r%dp%d with %d channels, %d requests\n", r, p, dmac->nchan, dmac->nreq);
   579	
   580		dmac->dma.dev = dev;
   581		for (int i = min(dw, 16); i > 0; i /= 2) {
   582			dmac->dma.src_addr_widths |= BIT(i);
   583			dmac->dma.dst_addr_widths |= BIT(i);
   584		}
   585		dmac->dma.directions = BIT(DMA_MEM_TO_MEM);
   586		dmac->dma.descriptor_reuse = true;
   587		dmac->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
   588		dmac->dma.device_alloc_chan_resources = d350_alloc_chan_resources;
   589		dmac->dma.device_free_chan_resources = d350_free_chan_resources;
   590		dma_cap_set(DMA_MEMCPY, dmac->dma.cap_mask);
   591		dmac->dma.device_prep_dma_memcpy = d350_prep_memcpy;
   592		dmac->dma.device_pause = d350_pause;
   593		dmac->dma.device_resume = d350_resume;
   594		dmac->dma.device_terminate_all = d350_terminate_all;
   595		dmac->dma.device_synchronize = d350_synchronize;
   596		dmac->dma.device_tx_status = d350_tx_status;
   597		dmac->dma.device_issue_pending = d350_issue_pending;
   598		INIT_LIST_HEAD(&dmac->dma.channels);
   599	
   600		/* Would be nice to have per-channel caps for this... */
   601		memset = true;
   602		for (int i = 0; i < nchan; i++) {
   603			struct d350_chan *dch = &dmac->channels[i];
   604			char ch_irqname[8];
   605	
   606			/* skip for reserved channels */
   607			if (!test_bit(i, (unsigned long *)&dma_chan_mask))
   608				continue;
   609	
   610			dch->coherent = coherent;
   611			dch->base = base + DMACH(i);
   612			writel_relaxed(CH_CMD_CLEAR, dch->base + CH_CMD);
   613	
   614			reg = readl_relaxed(dch->base + CH_BUILDCFG1);
   615			if (!(FIELD_GET(CH_CFG_HAS_CMDLINK, reg))) {
   616				dev_warn(dev, "No command link support on channel %d\n", i);
   617				continue;
   618			}
   619	
 > 620			snprintf(ch_irqname, sizeof(ch_irqname), "ch%d", i);
   621			dch->irq = platform_get_irq_byname(pdev, ch_irqname);
   622			if (dch->irq < 0)
   623				return dch->irq;
   624	
   625			dch->has_wrap = FIELD_GET(CH_CFG_HAS_WRAP, reg);
   626			dch->has_trig = FIELD_GET(CH_CFG_HAS_TRIGIN, reg) &
   627					FIELD_GET(CH_CFG_HAS_TRIGSEL, reg);
   628	
   629			/* Fill is a special case of Wrap */
   630			memset &= dch->has_wrap;
   631	
   632			reg = readl_relaxed(dch->base + CH_BUILDCFG0);
   633			dch->tsz = FIELD_GET(CH_CFG_DATA_WIDTH, reg);
   634	
   635			reg = FIELD_PREP(CH_LINK_SHAREATTR, coherent ? SHAREATTR_ISH : SHAREATTR_OSH);
   636			reg |= FIELD_PREP(CH_LINK_MEMATTR, coherent ? MEMATTR_WB : MEMATTR_NC);
   637			writel_relaxed(reg, dch->base + CH_LINKATTR);
   638	
   639			dch->vc.desc_free = d350_desc_free;
   640			vchan_init(&dch->vc, &dmac->dma);
   641		}
   642	
   643		if (memset) {
   644			dma_cap_set(DMA_MEMSET, dmac->dma.cap_mask);
   645			dmac->dma.device_prep_dma_memset = d350_prep_memset;
   646		}
   647	
   648		platform_set_drvdata(pdev, dmac);
   649	
   650		ret = dmaenginem_async_device_register(&dmac->dma);
   651		if (ret)
   652			return dev_err_probe(dev, ret, "Failed to register DMA device\n");
   653	
   654		return of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id, &dmac->dma);
   655	}
   656	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

