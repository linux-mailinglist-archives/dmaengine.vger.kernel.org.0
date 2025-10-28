Return-Path: <dmaengine+bounces-7021-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B77C14DAB
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 14:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9630C460BAA
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F83331A50;
	Tue, 28 Oct 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CW7YI2tR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D132E153;
	Tue, 28 Oct 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658099; cv=none; b=BBZe2CFEwcqj2BD/Z1S0g3t/Ln9NTHp39U6LeQpKZd9n6qj8jVuyVICcyfg0gysfp5kGPiwyZqeLFH7GvuzrjBahi3Uo/n1DNc8zhAO+wt++/h6gSbM9gXhLRfFFFDMnH7dmDEJ8kQdZ7WK3G/4P0ps6qIOFpZeXIWp3pxR8GJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658099; c=relaxed/simple;
	bh=x1SYv1wjHbN5ttnrkdlvInuPIPhCGzpNxaij4z0sgOM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bOMewSQZzjsaOZDG0ZoKz0imq9rlR9/0OllDv//lzmmk9MAUG5Y4fqxw6jWNrb2uP1m5xPth50GYhoIV9YTx4V8EoPdihiEWdcvG94AzFQe3dIR4KWP4xErKBD6N0mp1H5TSobWot5TQVahhQv5YwtBIW55HbfdKrQqcEXQNTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CW7YI2tR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761658098; x=1793194098;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x1SYv1wjHbN5ttnrkdlvInuPIPhCGzpNxaij4z0sgOM=;
  b=CW7YI2tR6MCUinfXRBewSo6iSWfl0mnUQ6hOfeB7LN0+bGOZF1Fr0ywk
   2JhOK4s8ow2ZnESei1B7crmn8Wv7bH7fNSS96iY/14yyqL3HQ1jPV/HCV
   rhqq6SFSl7uUcdFQ2OKFQ/TRnOPJHlyoDKkJHJ2j+Chakl/4l9JY7usVm
   zltoNtQ+3DB3YyOSCKqU7YWB98ix2eHYJcs15HkLW5NAdA1qyNNYQXXpT
   XNDdScsWalhgujAQnYMs/y3/AtEGEB7qJX1qhkWzp1OqYdP2FUoYqt+sT
   njbJL96P5ygvTuCqcM3aUQStAMCv4wcpRTg1dpgElK9w2AC5k1Hn+1MG5
   g==;
X-CSE-ConnectionGUID: 5Ipjy7U1Qou6pCngaX6tsw==
X-CSE-MsgGUID: h9bd79oER9exnzUkEJ5G3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89227072"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="89227072"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 06:28:16 -0700
X-CSE-ConnectionGUID: CfZE7yrSRjWLXdRg76+iBA==
X-CSE-MsgGUID: CFJmcYSbS66plAHaz5RT0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185807337"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 06:28:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 Oct 2025 15:28:09 +0200 (EET)
To: Devendra K Verma <devendra.verma@amd.com>
cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org, 
    dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, michal.simek@amd.com
Subject: Re: [PATCH v5 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
In-Reply-To: <20251028112858.9930-2-devendra.verma@amd.com>
Message-ID: <a550db5b-a36d-982c-0783-134abdeb1f70@linux.intel.com>
References: <20251028112858.9930-1-devendra.verma@amd.com> <20251028112858.9930-2-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Oct 2025, Devendra K Verma wrote:

> AMD MDB PCIe endpoint support. For AMD specific support
> added the following
>   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
>   - AMD MDB specific driver data
>   - AMD MDB specific VSEC capability to retrieve the device DDR
>     base address.
> 
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v5:
> Added the definitions for Xilinx specific VSEC header id,
> revision, and register offsets.
> Corrected the error type when no physical offset found for
> device side memory.
> Corrected the order of variables.
> 
> Changes in v4:
> Configured 8 read and 8 write channels for Xilinx vendor
> Added checks to validate vendor ID for vendor
> specific vsec id.
> Added Xilinx specific vendor id for vsec specific to Xilinx
> Added the LL and data region offsets, size as input params to
> function dw_edma_set_chan_region_offset().
> Moved the LL and data region offsets assignment to function
> for Xilinx specific case.
> Corrected comments.
> 
> Changes in v3:
> Corrected a typo when assigning AMD (Xilinx) vsec id macro
> and condition check.
> 
> Changes in v2:
> Reverted the devmem_phys_off type to u64.
> Renamed the function appropriately to suit the
> functionality for setting the LL & data region offsets.
> 
> Changes in v1:
> Removed the pci device id from pci_ids.h file.
> Added the vendor id macro as per the suggested method.
> Changed the type of the newly added devmem_phys_off variable.
> Added to logic to assign offsets for LL and data region blocks
> in case more number of channels are enabled than given in
> amd_mdb_data struct.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 138 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 3371e0a7..7b991a0 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -17,12 +17,27 @@
>  
>  #include "dw-edma-core.h"
>  
> +/* Synopsys */
>  #define DW_PCIE_VSEC_DMA_ID			0x6
>  #define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
>  #define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
>  #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
>  #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
>  
> +/* AMD MDB (Xilinx) specific defines */
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> +#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> +#define PCI_DEVICE_ID_AMD_MDB_B054		0xb054
> +#define DW_PCIE_AMD_MDB_INVALID_ADDR		(~0ULL)
> +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
> +#define DW_PCIE_XILINX_LL_SIZE			0x800
> +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
> +#define DW_PCIE_XILINX_DT_SIZE			0x800
> +#define DW_PCIE_XILINX_MDB_VSEC_HDR_ID		0x20
> +#define DW_PCIE_XILINX_MDB_VSEC_REV		0x1
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
> +
>  #define DW_BLOCK(a, b, c) \
>  	{ \
>  		.bar = a, \
> @@ -50,6 +65,7 @@ struct dw_edma_pcie_data {
>  	u8				irqs;
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
> +	u64				devmem_phys_off;
>  };
>  
>  static const struct dw_edma_pcie_data snps_edda_data = {
> @@ -90,6 +106,64 @@ struct dw_edma_pcie_data {
>  	.rd_ch_cnt			= 2,
>  };
>  
> +static const struct dw_edma_pcie_data amd_mdb_data = {
> +	/* MDB registers location */
> +	.rg.bar				= BAR_0,
> +	.rg.off				= 0x00001000,	/*  4 Kbytes */
> +	.rg.sz				= 0x00002000,	/*  8 Kbytes */

Please use SZ_* + check that this file #includes correct header for them.
You can then drop those comments.

-- 
 i.


> +
> +	/* Other */
> +	.mf				= EDMA_MF_HDMA_NATIVE,
> +	.irqs				= 1,
> +	.wr_ch_cnt			= 8,
> +	.rd_ch_cnt			= 8,
> +};
> +
> +static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
> +					   enum pci_barno bar, off_t start_off,
> +					   off_t ll_off_gap, size_t ll_size,
> +					   off_t dt_off_gap, size_t dt_size)
> +{
> +	u16 wr_ch = pdata->wr_ch_cnt;
> +	u16 rd_ch = pdata->rd_ch_cnt;
> +	off_t off;
> +	u16 i;
> +
> +	off = start_off;
> +
> +	/* Write channel LL region */
> +	for (i = 0; i < wr_ch; i++) {
> +		pdata->ll_wr[i].bar = bar;
> +		pdata->ll_wr[i].off = off;
> +		pdata->ll_wr[i].sz = ll_size;
> +		off += ll_off_gap;
> +	}
> +
> +	/* Read channel LL region */
> +	for (i = 0; i < rd_ch; i++) {
> +		pdata->ll_rd[i].bar = bar;
> +		pdata->ll_rd[i].off = off;
> +		pdata->ll_rd[i].sz = ll_size;
> +		off += ll_off_gap;
> +	}
> +
> +	/* Write channel data region */
> +	for (i = 0; i < wr_ch; i++) {
> +		pdata->dt_wr[i].bar = bar;
> +		pdata->dt_wr[i].off = off;
> +		pdata->dt_wr[i].sz = dt_size;
> +		off += dt_off_gap;
> +	}
> +
> +	/* Read channel data region */
> +	for (i = 0; i < rd_ch; i++) {
> +		pdata->dt_rd[i].bar = bar;
> +		pdata->dt_rd[i].off = off;
> +		pdata->dt_rd[i].sz = dt_size;
> +		off += dt_off_gap;
> +	}
> +}
> +
>  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  {
>  	return pci_irq_vector(to_pci_dev(dev), nr);
> @@ -120,9 +194,24 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	u32 val, map;
>  	u16 vsec;
>  	u64 off;
> +	int cap;
>  
> -	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> -					DW_PCIE_VSEC_DMA_ID);
> +	/*
> +	 * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> +	 * of map, channel counts, etc.
> +	 */
> +	switch (pdev->vendor) {
> +	case PCI_VENDOR_ID_SYNOPSYS:
> +		cap = DW_PCIE_VSEC_DMA_ID;
> +		break;
> +	case PCI_VENDOR_ID_XILINX:
> +		cap = DW_PCIE_XILINX_MDB_VSEC_DMA_ID;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	vsec = pci_find_vsec_capability(pdev, pdev->vendor, cap);
>  	if (!vsec)
>  		return;
>  
> @@ -155,6 +244,28 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	off <<= 32;
>  	off |= val;
>  	pdata->rg.off = off;
> +
> +	/* Xilinx specific VSEC capability */
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	if (PCI_VNDR_HEADER_ID(val) != DW_PCIE_XILINX_MDB_VSEC_HDR_ID ||
> +	    PCI_VNDR_HEADER_REV(val) != DW_PCIE_XILINX_MDB_VSEC_REV)
> +		return;
> +
> +	pci_read_config_dword(pdev,
> +			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> +			      &val);
> +	off = val;
> +	pci_read_config_dword(pdev,
> +			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> +			      &val);
> +	off <<= 32;
> +	off |= val;
> +	pdata->devmem_phys_off = off;
>  }
>  
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> @@ -179,6 +290,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	}
>  
>  	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> +	vsec_data->devmem_phys_off = DW_PCIE_AMD_MDB_INVALID_ADDR;
>  
>  	/*
>  	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
> @@ -186,6 +298,26 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	 */
>  	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> +		/*
> +		 * There is no valid address found for the LL memory
> +		 * space on the device side.
> +		 */
> +		if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
> +			return -ENOMEM;
> +
> +		/*
> +		 * Configure the channel LL and data blocks if number of
> +		 * channels enabled in VSEC capability are more than the
> +		 * channels configured in amd_mdb_data.
> +		 */
> +		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> +					       DW_PCIE_XILINX_LL_OFF_GAP,
> +					       DW_PCIE_XILINX_LL_SIZE,
> +					       DW_PCIE_XILINX_DT_OFF_GAP,
> +					       DW_PCIE_XILINX_DT_SIZE);
> +	}
> +
>  	/* Mapping PCI BAR regions */
>  	mask = BIT(vsec_data->rg.bar);
>  	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
> @@ -367,6 +499,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>  
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
> +	  (kernel_ulong_t)&amd_mdb_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> 

