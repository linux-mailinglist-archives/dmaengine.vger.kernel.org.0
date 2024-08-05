Return-Path: <dmaengine+bounces-2791-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E9E947479
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 06:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE532812BA
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 04:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C063713E02B;
	Mon,  5 Aug 2024 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgTRFYPb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB213D50E;
	Mon,  5 Aug 2024 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722833990; cv=none; b=GxQgNTQPueO2RADyvq7fNuWxwoJLdHlquejQ0KB1wqhKHls8+pzGelUBQECDnP22LUjj5KmO31sh/LGD/MGRQnno48+Q4ArR13GDoEpsKtK7CsDza0YaLSfqPoybtXuhEXL0IuraAsGCJqyHgzMkMW4ggTTDtDxLy1mmKwrNV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722833990; c=relaxed/simple;
	bh=OZ0x4CPR21u7kQqc2YahNoI50X1qL/GI/Bd9yBTu6G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uvw6M51pWoD4FZ5BTfSHeQO5vh0InfRyY+zDERN0+IEZ6BkqI0TSkmzAxUIUsxU/vDNHVAQrl8ZK8zZxsTU4VsX1PPJgFApW0EUi6NQugQgUqf/CISFUxz6e/ORHvHhGTtZUN7SiWliXoP4gVKL85phGzGJ1M21ZsbVQZUYBNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgTRFYPb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722833989; x=1754369989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OZ0x4CPR21u7kQqc2YahNoI50X1qL/GI/Bd9yBTu6G0=;
  b=mgTRFYPbav14qmvktAs94Frd8zskvi4DEVW3ickHeMHkQxH1OfLAG70M
   Pau+cIeebZGL7bltq74wW4eXEWIxNvmVqWnCv9Bk205LZtr8i96jVeogJ
   j2fOpAGu9xdvgCsuD3VbfhPsZc+SXyMPjq6kmzYrOtd/4C4tLLOwBIxXb
   AwRtccvLFMQtAYbMNJOb26EiacrsFkL/xnbrDCowpqIWL6EZ2jdf8YE8l
   6Vp4E/dbAntHpy01bKJSFAVL2KIhfN7UHntrinvFLz0MnLWR+IaZRylYd
   yff47qiwlnBZ1XTD0MwuSPffAueWYCKi7myqxUM8SRfwhLZLTybrjN+in
   A==;
X-CSE-ConnectionGUID: fEAFV6nZTbaZQHaAXN+eNA==
X-CSE-MsgGUID: FIQe1zL2Rki1BeZUGajgoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20930651"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="20930651"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 21:59:48 -0700
X-CSE-ConnectionGUID: Eye9zMIKRuipOV9VFKj7FQ==
X-CSE-MsgGUID: AAUJR3eJT9OkleRqwjSRGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="86988225"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 04 Aug 2024 21:59:45 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sapos-0001js-1a;
	Mon, 05 Aug 2024 04:59:42 +0000
Date: Mon, 5 Aug 2024 12:58:49 +0800
From: kernel test robot <lkp@intel.com>
To: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v11 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA
 driver
Message-ID: <202408051242.8kGK28W7-lkp@intel.com>
References: <20240802-loongson1-dma-v11-2-85392357d4e0@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-loongson1-dma-v11-2-85392357d4e0@gmail.com>

Hi Keguang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 048d8cb65cde9fe7534eb4440bcfddcf406bb49c]

url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang-via-B4-Relay/dt-bindings-dma-Add-Loongson-1-APB-DMA/20240803-111220
base:   048d8cb65cde9fe7534eb4440bcfddcf406bb49c
patch link:    https://lore.kernel.org/r/20240802-loongson1-dma-v11-2-85392357d4e0%40gmail.com
patch subject: [PATCH v11 2/2] dmaengine: Loongson1: Add Loongson-1 APB DMA driver
config: sparc64-randconfig-r063-20240804 (https://download.01.org/0day-ci/archive/20240805/202408051242.8kGK28W7-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408051242.8kGK28W7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408051242.8kGK28W7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/loongson1-apb-dma.c: In function 'ls1x_dma_chan_probe':
>> drivers/dma/loongson1-apb-dma.c:520:34: warning: '%u' directive writing between 1 and 10 bytes into a region of size 2 [-Wformat-overflow=]
     520 |         sprintf(pdev_irqname, "ch%u", chan_id);
         |                                  ^~
   drivers/dma/loongson1-apb-dma.c:520:31: note: directive argument in the range [0, 2147483646]
     520 |         sprintf(pdev_irqname, "ch%u", chan_id);
         |                               ^~~~~~
   drivers/dma/loongson1-apb-dma.c:520:9: note: 'sprintf' output between 4 and 13 bytes into a destination of size 4
     520 |         sprintf(pdev_irqname, "ch%u", chan_id);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +520 drivers/dma/loongson1-apb-dma.c

   510	
   511	static int ls1x_dma_chan_probe(struct platform_device *pdev,
   512				       struct ls1x_dma *dma, int chan_id)
   513	{
   514		struct device *dev = &pdev->dev;
   515		struct ls1x_dma_chan *chan = &dma->chan[chan_id];
   516		char pdev_irqname[4];
   517		char *irqname;
   518		int ret;
   519	
 > 520		sprintf(pdev_irqname, "ch%u", chan_id);
   521		chan->irq = platform_get_irq_byname(pdev, pdev_irqname);
   522		if (chan->irq < 0)
   523			return -ENODEV;
   524	
   525		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:%s",
   526					 dev_name(dev), pdev_irqname);
   527		if (!irqname)
   528			return -ENOMEM;
   529	
   530		ret = devm_request_irq(dev, chan->irq, ls1x_dma_irq_handler,
   531				       IRQF_SHARED, irqname, chan);
   532		if (ret)
   533			return dev_err_probe(dev, ret, "failed to request IRQ %u\n",
   534					     chan->irq);
   535	
   536		chan->reg_base = dma->reg_base;
   537		chan->vchan.desc_free = ls1x_dma_free_desc;
   538		vchan_init(&chan->vchan, &dma->ddev);
   539		dev_info(dev, "%s (irq %d) initialized\n", pdev_irqname, chan->irq);
   540	
   541		return 0;
   542	}
   543	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

