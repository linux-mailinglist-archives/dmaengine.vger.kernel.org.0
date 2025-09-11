Return-Path: <dmaengine+bounces-6455-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384AEB53E16
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 23:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFB63B62F1
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 21:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614FB25A2C3;
	Thu, 11 Sep 2025 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpCuGA0s"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AD1221FC7;
	Thu, 11 Sep 2025 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627450; cv=none; b=XyGgN4GEASnuIvT1gUeOAv5AEgMZb6mB20SsTSxr5GlPnDsO8iA5EKAkz1EEnUsGZ61WKgsG9oHGK5go8dBaIqxZUBYeAGnvaG1CLqkaSNba4wNGPSH64e9+d4zy3QqFRw3KGgxHgsm5ncPm01s4tCrBsJc6jMvgAiQJ+FIxSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627450; c=relaxed/simple;
	bh=0xFWuWckeYn7i+UQkHAiDtVNRwOXcCZQjBQISDrUu28=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=inDqght26+hEWzAaTxqRyr0dMZAVswx0Zfmp/C9MYucQ5d4IRaW2XBK4uNKUqw3j5sNOhSc50W4XFR5GnZ2w5u3f1lk12Qc3QWC3Wb9kM0ALsevWHWM1sztsJdhCEb86yrVKIBBopUopdOiOXkupeQAdXCB/BmLDwhM2GyE2jQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpCuGA0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97945C4CEF1;
	Thu, 11 Sep 2025 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757627449;
	bh=0xFWuWckeYn7i+UQkHAiDtVNRwOXcCZQjBQISDrUu28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bpCuGA0soSywcvGUOnM0DKH1nS9egRpSVYcRnBnj2p1mWJSuxIAgYbjRU0nkAiguR
	 FCDtR9aiwhMZzliJ1PEvIRoEML+Atn4eppdgr+EOPsc9WaNTGQVFkGah67sGdvXxPX
	 +DCDqiHRq0wJs0l1Kee0nIeGjKOVI5UxX7+0p593tomuUl4i03ckCQOvsHxt/2dxNJ
	 QLnYbfLwxHBYr9cQlYQsokoiG/eiYx1z2WVO5JfsVhOI2kVVuDRs6Niu/++YiGNL7M
	 OjAdUodsqIEoPuUPyzpkAZ3WLdj6OSFG1sVkrO+GevbBGcj56i/0eOLfXM2s+G+wIU
	 EYpSuxIcfR9Lg==
Date: Thu, 11 Sep 2025 16:50:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v1 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <20250911215048.GA1591374@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911114451.15947-2-devendra.verma@amd.com>

On Thu, Sep 11, 2025 at 05:14:50PM +0530, Devendra K Verma wrote:
> AMD MDB PCIe endpoint support. For AMD specific support
> added the following
>   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
>   - AMD MDB specific driver data
>   - AMD MDB specific VSEC capability to retrieve the device DDR
>     base address.
> 
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v1:
> Removed the pci device id from pci_ids.h file.
> Added the vendor id macro as per the suggested method.
> Changed the type of the newly added devmem_phys_off variable.
> Added to logic to assign offsets for LL and data region blocks
> in case more number of channels are enabled than given in
> amd_mdb_data struct.
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 132 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 131 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 3371e0a7..48ecfce 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -23,6 +23,11 @@
>  #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
>  #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
>  
> +/* AMD MDB specific defines */
> +#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> +#define PCI_DEVICE_ID_AMD_MDB_B054		0xb054
> +#define DW_PCIE_AMD_MDB_INVALID_ADDR		(~0ULL)
> +
>  #define DW_BLOCK(a, b, c) \
>  	{ \
>  		.bar = a, \
> @@ -50,6 +55,7 @@ struct dw_edma_pcie_data {
>  	u8				irqs;
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
> +	pci_bus_addr_t			devmem_phys_off;

Based on your previous response, I don't think pci_bus_addr_t is the
right type.  IIUC devmem_phys_off is not an address that a PCIe
analyzer would ever see in a TLP.  It sounds like it's the result of
applying an iATU translation to a PCI bus address.

I'm not sure there's a special type for that, so u64 might be as good
as anything.

>  };
>  
>  static const struct dw_edma_pcie_data snps_edda_data = {
> @@ -90,6 +96,89 @@ struct dw_edma_pcie_data {
>  	.rd_ch_cnt			= 2,
>  };
>  
> +static const struct dw_edma_pcie_data amd_mdb_data = {
> +	/* MDB registers location */
> +	.rg.bar				= BAR_0,
> +	.rg.off				= 0x00001000,	/*  4 Kbytes */
> +	.rg.sz				= 0x00002000,	/*  8 Kbytes */
> +	/* MDB memory linked list location */
> +	.ll_wr = {
> +		/* Channel 0 - BAR 2, offset 0 Mbytes, size 2 Kbytes */
> +		DW_BLOCK(BAR_2, 0x00000000, 0x00000800)
> +		/* Channel 1 - BAR 2, offset 2 Mbytes, size 2 Kbytes */
> +		DW_BLOCK(BAR_2, 0x00200000, 0x00000800)
> +	},
> +	.ll_rd = {
> +		/* Channel 0 - BAR 2, offset 4 Mbytes, size 2 Kbytes */
> +		DW_BLOCK(BAR_2, 0x00400000, 0x00000800)
> +		/* Channel 1 - BAR 2, offset 6 Mbytes, size 2 Kbytes */
> +		DW_BLOCK(BAR_2, 0x00600000, 0x00000800)
> +	},
> +	/* MDB memory data location */
> +	.dt_wr = {
> +		/* Channel 0 - BAR 2, offset 8 Mbytes, size 2 Kbytes */
> +		DW_BLOCK(BAR_2, 0x00800000, 0x00000800)
> +		/* Channel 1 - BAR 2, offset 9 Mbytes, size 2 Kbytes */
> +		DW_BLOCK(BAR_2, 0x00900000, 0x00000800)
> +	},
> +	.dt_rd = {
> +		/* Channel 0 - BAR 2, offset 10 Mbytes, size 2 Kbytes */
> +		DW_BLOCK(BAR_2, 0x00a00000, 0x00000800)
> +		/* Channel 1 - BAR 2, offset 11 Mbytes, size 2 Kbytes */
> +		DW_BLOCK(BAR_2, 0x00b00000, 0x00000800)
> +	},
> +	/* Other */
> +	.mf				= EDMA_MF_HDMA_NATIVE,
> +	.irqs				= 1,
> +	.wr_ch_cnt			= 2,
> +	.rd_ch_cnt			= 2,
> +};
> +
> +static void dw_edma_assign_chan_data(struct dw_edma_pcie_data *pdata,
> +				     enum pci_barno bar)
> +{
> +	u16 i;
> +	off_t off = 0, offsz = 0x200000;
> +	size_t size = 0x800;
> +	u16 wr_ch = pdata->wr_ch_cnt;
> +	u16 rd_ch = pdata->rd_ch_cnt;
> +
> +	if (wr_ch <= 2 || rd_ch <= 2)
> +		return;
> +
> +	/* Write channel LL region */
> +	for (i = 0; i < wr_ch; i++) {
> +		pdata->ll_wr[i].bar = bar;
> +		pdata->ll_wr[i].off = off;
> +		pdata->ll_wr[i].sz = size;
> +		off += offsz + size;
> +	}
> +
> +	/* Read channel LL region */
> +	for (i = 0; i < rd_ch; i++) {
> +		pdata->ll_rd[i].bar = bar;
> +		pdata->ll_rd[i].off = off;
> +		pdata->ll_rd[i].sz = size;
> +		off += offsz + size;
> +	}
> +
> +	/* Write channel data region */
> +	for (i = 0; i < wr_ch; i++) {
> +		pdata->dt_wr[i].bar = bar;
> +		pdata->dt_wr[i].off = off;
> +		pdata->dt_wr[i].sz = size;
> +		off += offsz + size;
> +	}
> +
> +	/* Read channel data region */
> +	for (i = 0; i < rd_ch; i++) {
> +		pdata->dt_rd[i].bar = bar;
> +		pdata->dt_rd[i].off = off;
> +		pdata->dt_rd[i].sz = size;
> +		off += offsz + size;
> +	}
> +}
> +
>  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  {
>  	return pci_irq_vector(to_pci_dev(dev), nr);
> @@ -121,7 +210,11 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	u16 vsec;
>  	u64 off;
>  
> -	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> +	/*
> +	 * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> +	 * of map, channel counts, etc.
> +	 */
> +	vsec = pci_find_vsec_capability(pdev, pdev->vendor,
>  					DW_PCIE_VSEC_DMA_ID);

You must validate pdev->vendor first.  Passing pdev->vendor means this
will find any VSEC with ID 0x6 on any device at all.  For example, you
could find a VSEC with ID 0x6 on an Intel device where VSEC ID 0x6
means something completely different.

You have to know what the Vendor ID is before calling
pci_find_vsec_capability() because otherwise you don't know what the
VSEC ID means.

The best way to do this would be to use a separate #define for each
vendor to remove the assumption that each vendor uses the same ID:

  #define DW_PCIE_SYNOPSYS_VSEC_DMA_ID 0x6
  #define DW_PCIE_XILINX_VSEC_DMA_ID   0x6

  vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
                                  DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
  if (!vsec) {
    vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
                                    DW_PCIE_XILINX_VSEC_DMA_ID);
    if (!vsec)
      return;
  }

That way it's clear that this only applies to Synopsys devices and
Xilinx devices, Synopsys and Xilinx implemented a VSEC with the same
semantics, and it's just a coincidence that they assigned the same
VSEC ID.

>  	if (!vsec)
>  		return;
> @@ -155,6 +248,24 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	off <<= 32;
>  	off |= val;
>  	pdata->rg.off = off;
> +
> +	/* AMD specific VSEC capability */
> +	vsec = pci_find_vsec_capability(pdev, pdev->vendor,
> +					DW_PCIE_XILINX_MDB_VSEC_ID);

Same here.  This will find a VSEC with ID 0x20 on any device from any
vendor at all.  But you only know what 0x20 means on Xilinx devices,
so this should be:

  vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
                                  DW_PCIE_XILINX_MDB_VSEC_ID);

> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	if (PCI_VNDR_HEADER_ID(val) != 0x20 ||
> +	    PCI_VNDR_HEADER_REV(val) != 0x1)
> +		return;
> +
> +	pci_read_config_dword(pdev, vsec + 0xc, &val);
> +	off = val;
> +	pci_read_config_dword(pdev, vsec + 0x8, &val);
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
> @@ -186,6 +298,22 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	 */
>  	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> +		/*
> +		 * There is no valid address found for the LL memory
> +		 * space on the device side.
> +		 */
> +		if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
> +			return -EINVAL;
> +
> +		/*
> +		 * Configure the channel LL and data blocks if number of
> +		 * channels enabled in VSEC capability are more than the
> +		 * channels configured in amd_mdb_data.
> +		 */
> +		dw_edma_assign_chan_data(vsec_data, BAR_2);
> +	}
> +
>  	/* Mapping PCI BAR regions */
>  	mask = BIT(vsec_data->rg.bar);
>  	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
> @@ -367,6 +495,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>  
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
> +	  (kernel_ulong_t)&amd_mdb_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> -- 
> 1.8.3.1
> 

