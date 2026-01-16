Return-Path: <dmaengine+bounces-8304-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B0FD2B133
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 04:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EDAE300DDAA
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jan 2026 03:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E412342CB1;
	Fri, 16 Jan 2026 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moVrqKOX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F2342534;
	Fri, 16 Jan 2026 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535982; cv=none; b=T/x7i9ZE+KL0DskXXN8HYzzG0KxnX/PBQKV5flBaYjLeWTpDDqqUoC4rT/lOUy3oIMyyUX62Z8Z8KLl72jAPyseo5IxD52mAg5kzesk+ALr95zPLefNA0T7BUw0PqDvby4rcCEe1OqPXol+ISZq40eT+KjoIV/peiN32UppwnUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535982; c=relaxed/simple;
	bh=CmGnH7AqqI0yoJCUsFq4Tmdh1ZlRFTL2l6zzaWwnmZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5iXdGtfmZuWDm1IfmFKiJFNLgGyjkX2/cByDhrSO8GhOnAyLTZ8WE1XY2AUsBzGoTHWnl/b1nQNlJgT7GLykTVc2GBlZdtLIvvNDuDST/yilJdwnL3XmfMUJetMNfW5yLMZP4O4nyPf+xMCA04T+Lyws+wjVINnC+M54v6fZsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moVrqKOX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768535979; x=1800071979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmGnH7AqqI0yoJCUsFq4Tmdh1ZlRFTL2l6zzaWwnmZk=;
  b=moVrqKOXalxNfTcIE7B/EwHlZlUGZhnsoKQTqgC9vmy40T8bDjUtqvJx
   AOy6zEaE6j+jZbimPZZdT9xQ9MU1DG/g+xlCnGcCwdvC3HmjR6wcrbp9W
   0Qdi6iF4vfROg7bEpNd42l0eoALa9jOgHHbY4i2YPyg61J8BYQZql95CR
   LQwQwH1GlVOY8ka6nMqZublRUENCKk/LK70LMB0xxCzgeD7YFILrlJfeM
   Byd1JLys9Pnz4jG5vDOuvQHezyqg02prJ5wfvYUhbWUxjuJdwLNj7dhMN
   Xy9XXdzIuralhUhvUy5ORG1c+xQPK19k/0OnUm6ZhjLwlF4+/LTlbRM3H
   Q==;
X-CSE-ConnectionGUID: dXAZYE+USjWQ0wkb8Gsk3w==
X-CSE-MsgGUID: nA4Ec/UkT7yz35HtxOsOMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="87428007"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="87428007"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 19:59:39 -0800
X-CSE-ConnectionGUID: bw4zyM8gTpesuT+M4QFy1Q==
X-CSE-MsgGUID: KVT9E3iySwWcgq+yCDtZ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="228174765"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Jan 2026 19:59:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgazl-00000000KLq-3MS5;
	Fri, 16 Jan 2026 03:59:33 +0000
Date: Fri, 16 Jan 2026 11:59:30 +0800
From: kernel test robot <lkp@intel.com>
To: Devendra K Verma <devendra.verma@amd.com>, bhelgaas@google.com,
	mani@kernel.org, vkoul@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, Devendra.Verma@amd.com
Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <202601161151.MTsHwjVO-lkp@intel.com>
References: <20260109120354.306048-3-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109120354.306048-3-devendra.verma@amd.com>

Hi Devendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.19-rc4]
[also build test ERROR on linus/master next-20260115]
[cannot apply to vkoul-dmaengine/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Devendra-K-Verma/dmaengine-dw-edma-Add-AMD-MDB-Endpoint-Support/20260109-200654
base:   v6.19-rc4
patch link:    https://lore.kernel.org/r/20260109120354.306048-3-devendra.verma%40amd.com
patch subject: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260116/202601161151.MTsHwjVO-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260116/202601161151.MTsHwjVO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601161151.MTsHwjVO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/dw-edma/dw-edma-pcie.c: In function 'dw_edma_pcie_probe':
>> drivers/dma/dw-edma/dw-edma-pcie.c:348:51: error: 'DW_PCIE_AMD_MDB_INVALID_ADDR' undeclared (first use in this function); did you mean 'DW_PCIE_XILINX_MDB_INVALID_ADDR'?
     348 |                 if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                   DW_PCIE_XILINX_MDB_INVALID_ADDR
   drivers/dma/dw-edma/dw-edma-pcie.c:348:51: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/dma/dw-edma/dw-edma-pcie.c:358:56: error: 'DW_PCIE_XILINX_LL_OFF_GAP' undeclared (first use in this function); did you mean 'DW_PCIE_XILINX_MDB_LL_OFF_GAP'?
     358 |                                                        DW_PCIE_XILINX_LL_OFF_GAP,
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                        DW_PCIE_XILINX_MDB_LL_OFF_GAP
>> drivers/dma/dw-edma/dw-edma-pcie.c:359:56: error: 'DW_PCIE_XILINX_LL_SIZE' undeclared (first use in this function); did you mean 'DW_PCIE_XILINX_MDB_LL_SIZE'?
     359 |                                                        DW_PCIE_XILINX_LL_SIZE,
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~
         |                                                        DW_PCIE_XILINX_MDB_LL_SIZE
>> drivers/dma/dw-edma/dw-edma-pcie.c:360:56: error: 'DW_PCIE_XILINX_DT_OFF_GAP' undeclared (first use in this function); did you mean 'DW_PCIE_XILINX_MDB_DT_OFF_GAP'?
     360 |                                                        DW_PCIE_XILINX_DT_OFF_GAP,
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                        DW_PCIE_XILINX_MDB_DT_OFF_GAP
>> drivers/dma/dw-edma/dw-edma-pcie.c:361:56: error: 'DW_PCIE_XILINX_DT_SIZE' undeclared (first use in this function); did you mean 'DW_PCIE_XILINX_MDB_DT_SIZE'?
     361 |                                                        DW_PCIE_XILINX_DT_SIZE);
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~
         |                                                        DW_PCIE_XILINX_MDB_DT_SIZE


vim +348 drivers/dma/dw-edma/dw-edma-pcie.c

   309	
   310	static int dw_edma_pcie_probe(struct pci_dev *pdev,
   311				      const struct pci_device_id *pid)
   312	{
   313		struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
   314		struct dw_edma_pcie_data *vsec_data __free(kfree) = NULL;
   315		struct device *dev = &pdev->dev;
   316		struct dw_edma_chip *chip;
   317		int err, nr_irqs;
   318		int i, mask;
   319		bool non_ll = false;
   320	
   321		vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
   322		if (!vsec_data)
   323			return -ENOMEM;
   324	
   325		/* Enable PCI device */
   326		err = pcim_enable_device(pdev);
   327		if (err) {
   328			pci_err(pdev, "enabling device failed\n");
   329			return err;
   330		}
   331	
   332		memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
   333	
   334		/*
   335		 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
   336		 * for the DMA, if one exists, then reconfigures it.
   337		 */
   338		dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
   339		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
   340	
   341		if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
   342			/*
   343			 * There is no valid address found for the LL memory
   344			 * space on the device side. In the absence of LL base
   345			 * address use the non-LL mode or simple mode supported by
   346			 * the HDMA IP.
   347			 */
 > 348			if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
   349				non_ll = true;
   350	
   351			/*
   352			 * Configure the channel LL and data blocks if number of
   353			 * channels enabled in VSEC capability are more than the
   354			 * channels configured in xilinx_mdb_data.
   355			 */
   356			if (!non_ll)
   357				dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
 > 358							       DW_PCIE_XILINX_LL_OFF_GAP,
 > 359							       DW_PCIE_XILINX_LL_SIZE,
 > 360							       DW_PCIE_XILINX_DT_OFF_GAP,
 > 361							       DW_PCIE_XILINX_DT_SIZE);
   362		}
   363	
   364		/* Mapping PCI BAR regions */
   365		mask = BIT(vsec_data->rg.bar);
   366		for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
   367			mask |= BIT(vsec_data->ll_wr[i].bar);
   368			mask |= BIT(vsec_data->dt_wr[i].bar);
   369		}
   370		for (i = 0; i < vsec_data->rd_ch_cnt; i++) {
   371			mask |= BIT(vsec_data->ll_rd[i].bar);
   372			mask |= BIT(vsec_data->dt_rd[i].bar);
   373		}
   374		err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
   375		if (err) {
   376			pci_err(pdev, "eDMA BAR I/O remapping failed\n");
   377			return err;
   378		}
   379	
   380		pci_set_master(pdev);
   381	
   382		/* DMA configuration */
   383		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
   384		if (err) {
   385			pci_err(pdev, "DMA mask 64 set failed\n");
   386			return err;
   387		}
   388	
   389		/* Data structure allocation */
   390		chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
   391		if (!chip)
   392			return -ENOMEM;
   393	
   394		/* IRQs allocation */
   395		nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
   396						PCI_IRQ_MSI | PCI_IRQ_MSIX);
   397		if (nr_irqs < 1) {
   398			pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
   399				nr_irqs);
   400			return -EPERM;
   401		}
   402	
   403		/* Data structure initialization */
   404		chip->dev = dev;
   405	
   406		chip->mf = vsec_data->mf;
   407		chip->nr_irqs = nr_irqs;
   408		chip->ops = &dw_edma_pcie_plat_ops;
   409		chip->non_ll = non_ll;
   410	
   411		chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
   412		chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
   413	
   414		chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
   415		if (!chip->reg_base)
   416			return -ENOMEM;
   417	
   418		for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
   419			struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
   420			struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
   421			struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
   422			struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
   423	
   424			ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
   425			if (!ll_region->vaddr.io)
   426				return -ENOMEM;
   427	
   428			ll_region->vaddr.io += ll_block->off;
   429			ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
   430								 ll_block->bar);
   431			ll_region->paddr += ll_block->off;
   432			ll_region->sz = ll_block->sz;
   433	
   434			dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
   435			if (!dt_region->vaddr.io)
   436				return -ENOMEM;
   437	
   438			dt_region->vaddr.io += dt_block->off;
   439			dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
   440								 dt_block->bar);
   441			dt_region->paddr += dt_block->off;
   442			dt_region->sz = dt_block->sz;
   443		}
   444	
   445		for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
   446			struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
   447			struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
   448			struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
   449			struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
   450	
   451			ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
   452			if (!ll_region->vaddr.io)
   453				return -ENOMEM;
   454	
   455			ll_region->vaddr.io += ll_block->off;
   456			ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
   457								 ll_block->bar);
   458			ll_region->paddr += ll_block->off;
   459			ll_region->sz = ll_block->sz;
   460	
   461			dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
   462			if (!dt_region->vaddr.io)
   463				return -ENOMEM;
   464	
   465			dt_region->vaddr.io += dt_block->off;
   466			dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
   467								 dt_block->bar);
   468			dt_region->paddr += dt_block->off;
   469			dt_region->sz = dt_block->sz;
   470		}
   471	
   472		/* Debug info */
   473		if (chip->mf == EDMA_MF_EDMA_LEGACY)
   474			pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", chip->mf);
   475		else if (chip->mf == EDMA_MF_EDMA_UNROLL)
   476			pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
   477		else if (chip->mf == EDMA_MF_HDMA_COMPAT)
   478			pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
   479		else if (chip->mf == EDMA_MF_HDMA_NATIVE)
   480			pci_dbg(pdev, "Version:\tHDMA Native (0x%x)\n", chip->mf);
   481		else
   482			pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
   483	
   484		pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
   485			vsec_data->rg.bar, vsec_data->rg.off, vsec_data->rg.sz,
   486			chip->reg_base);
   487	
   488	
   489		for (i = 0; i < chip->ll_wr_cnt; i++) {
   490			pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
   491				i, vsec_data->ll_wr[i].bar,
   492				vsec_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
   493				chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
   494	
   495			pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
   496				i, vsec_data->dt_wr[i].bar,
   497				vsec_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
   498				chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
   499		}
   500	
   501		for (i = 0; i < chip->ll_rd_cnt; i++) {
   502			pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
   503				i, vsec_data->ll_rd[i].bar,
   504				vsec_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
   505				chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
   506	
   507			pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
   508				i, vsec_data->dt_rd[i].bar,
   509				vsec_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
   510				chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
   511		}
   512	
   513		pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
   514	
   515		/* Validating if PCI interrupts were enabled */
   516		if (!pci_dev_msi_enabled(pdev)) {
   517			pci_err(pdev, "enable interrupt failed\n");
   518			return -EPERM;
   519		}
   520	
   521		/* Starting eDMA driver */
   522		err = dw_edma_probe(chip);
   523		if (err) {
   524			pci_err(pdev, "eDMA probe failed\n");
   525			return err;
   526		}
   527	
   528		/* Saving data structure reference */
   529		pci_set_drvdata(pdev, chip);
   530	
   531		return 0;
   532	}
   533	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

