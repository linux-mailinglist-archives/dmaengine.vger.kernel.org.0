Return-Path: <dmaengine+bounces-7557-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7AACB3D07
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1300300A571
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 19:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A75329C41;
	Wed, 10 Dec 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRryjixB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E5322B70;
	Wed, 10 Dec 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393555; cv=none; b=AMBoUA9Z8OHj8iRo7BzAmH7Ond2YdTW7iq5nDH++/TJ5N3mFF7iZRt91IRe/2jX/k5pvwRU7vsZ1oNrKGe9RI+BRrTRGyd0LYcw1G1sEa4pCtJfVXVZr+RCSYwTZCyISBRAI0cLU3aTy/c/25jX6Mguyd58fwF/+uSn+VRNmbLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393555; c=relaxed/simple;
	bh=boHYArrLfilo5Sv64y0CaCmooWdnIhESwdLtZzAruxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcxFAs0PcwvyClifw9u0BNVFWVrt24cGQ1bO93C5jFMvZv2xJY5lEg+TzeqPKXDYnboD+mYuKJqRxHT4jOz6hX73eNyYfnCO6OvvvKXsZWUFuMg6UatkvZDMFQXZsJhD3yL2zbZHnLlIItnogCiWLNiaoEl1Fmd4WNTpT28NjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRryjixB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765393554; x=1796929554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=boHYArrLfilo5Sv64y0CaCmooWdnIhESwdLtZzAruxg=;
  b=kRryjixBx4Lyl7USgenNJp/9MqGyhQlolc/mC8xpfkEOnPv8ll6LL+3m
   JugCuq5xsu7ZAI0DPeWrDoMDoH4G7VoLzzSvmAcNB+J78wawa4YvGepsS
   jJtyM51cLDjhrLYkocDP8Gqbc+PEwXbZXiRialRQf2eYVv6YuDZs/tkjs
   W8Sc773J/X0gDEGB6tDiSqOZqQx6TTuUTp9Ba+I/4GIAutsVWbR5Ix0vf
   CVPWBjYbBk0D8VCBkRHtuqTczvUma1el0ivsVn3BF8LfGa+fMLDSRwakQ
   xZ06ML+QGyucrwdU6M5f/t8E0NRy6NHQTrdxQWeh+tSpQbNRxG4uMlbC+
   g==;
X-CSE-ConnectionGUID: kTjcXKyJSMOEYdeBEmMDjQ==
X-CSE-MsgGUID: nBa5C+UTSWKCVL6MPO3NtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="54917266"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="54917266"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 11:05:53 -0800
X-CSE-ConnectionGUID: Etk4k57vSziwm/yZiYAtjg==
X-CSE-MsgGUID: h4VcFQvCTOSLNUrttT2hvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="201029660"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 Dec 2025 11:05:48 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTPVR-000000003fJ-2YeN;
	Wed, 10 Dec 2025 19:05:45 +0000
Date: Thu, 11 Dec 2025 03:05:08 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 6/8] nvmet: pci-epf: Use
 dmaengine_prep_slave_single_config() API
Message-ID: <202512110249.kCiMC4sb-lkp@intel.com>
References: <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bc04acf4aeca588496124a6cf54bfce3db327039]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-Add-API-to-combine-configuration-and-preparation-sg-and-single/20251209-011820
base:   bc04acf4aeca588496124a6cf54bfce3db327039
patch link:    https://lore.kernel.org/r/20251208-dma_prep_config-v1-6-53490c5e1e2a%40nxp.com
patch subject: [PATCH 6/8] nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20251211/202512110249.kCiMC4sb-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251211/202512110249.kCiMC4sb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512110249.kCiMC4sb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/pci-epf.c: In function 'nvmet_pci_epf_dma_transfer':
>> drivers/nvme/target/pci-epf.c:369:23: warning: variable 'lock' set but not used [-Wunused-but-set-variable]
     369 |         struct mutex *lock;
         |                       ^~~~


vim +/lock +369 drivers/nvme/target/pci-epf.c

0faa0fe6f90ea5 Damien Le Moal 2025-01-04  357  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  358  static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  359  		struct nvmet_pci_epf_segment *seg, enum dma_data_direction dir)
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  360  {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  361  	struct pci_epf *epf = nvme_epf->epf;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  362  	struct dma_async_tx_descriptor *desc;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  363  	struct dma_slave_config sconf = {};
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  364  	struct device *dev = &epf->dev;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  365  	struct device *dma_dev;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  366  	struct dma_chan *chan;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  367  	dma_cookie_t cookie;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  368  	dma_addr_t dma_addr;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04 @369  	struct mutex *lock;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  370  	int ret;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  371  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  372  	switch (dir) {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  373  	case DMA_FROM_DEVICE:
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  374  		lock = &nvme_epf->dma_rx_lock;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  375  		chan = nvme_epf->dma_rx_chan;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  376  		sconf.direction = DMA_DEV_TO_MEM;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  377  		sconf.src_addr = seg->pci_addr;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  378  		break;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  379  	case DMA_TO_DEVICE:
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  380  		lock = &nvme_epf->dma_tx_lock;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  381  		chan = nvme_epf->dma_tx_chan;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  382  		sconf.direction = DMA_MEM_TO_DEV;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  383  		sconf.dst_addr = seg->pci_addr;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  384  		break;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  385  	default:
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  386  		return -EINVAL;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  387  	}
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  388  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  389  	dma_dev = dmaengine_get_dma_device(chan);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  390  	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  391  	ret = dma_mapping_error(dma_dev, dma_addr);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  392  	if (ret)
f9f42a84df49d9 Frank Li       2025-12-08  393  		return ret;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  394  
f9f42a84df49d9 Frank Li       2025-12-08  395  	desc = dmaengine_prep_slave_single_config(chan, dma_addr, seg->length,
f9f42a84df49d9 Frank Li       2025-12-08  396  						  sconf.direction,
f9f42a84df49d9 Frank Li       2025-12-08  397  						  DMA_CTRL_ACK,
f9f42a84df49d9 Frank Li       2025-12-08  398  						  &sconf);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  399  	if (!desc) {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  400  		dev_err(dev, "Failed to prepare DMA\n");
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  401  		ret = -EIO;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  402  		goto unmap;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  403  	}
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  404  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  405  	cookie = dmaengine_submit(desc);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  406  	ret = dma_submit_error(cookie);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  407  	if (ret) {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  408  		dev_err(dev, "Failed to do DMA submit (err=%d)\n", ret);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  409  		goto unmap;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  410  	}
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  411  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  412  	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  413  		dev_err(dev, "DMA transfer failed\n");
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  414  		ret = -EIO;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  415  	}
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  416  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  417  unmap:
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  418  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  419  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  420  	return ret;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  421  }
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  422  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

