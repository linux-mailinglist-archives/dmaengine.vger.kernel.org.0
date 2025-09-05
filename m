Return-Path: <dmaengine+bounces-6406-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA0CB45F65
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3227C5452
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CE0309EE3;
	Fri,  5 Sep 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OICIoC7/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720231D736;
	Fri,  5 Sep 2025 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091268; cv=none; b=SyF1EMj0w5Zxqx/Z2Ze0r3NjSHrK3nzru4U7sDVPCX1aL3MyPZBfqzP1dOfRGIKvqM7xdXZbXTiPN52OJK6wXOsZ72lUqURVTI+Mk/iJbv3R6vHsC6VjpRpt9kss8RnQSO0KBqn1AmRObxpsEWzI0PfGjxZYx/274LzdUmVWxoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091268; c=relaxed/simple;
	bh=Iz8mTq/GEt9A4ZHGarw24hhU9Mlb6/EwBsMoab+mPtk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GgW51QQysqJ2ehjZ5ZMNa31Qu8EmsNw28rKWh/tY2ljph/Uf6cgdJe5L49t0ml4AdR7ibI73apwytHZ0iFn9zqoupE2mdDG9sGxXOosJfodW+Z5N/ed5ZCOYp3jDWVK3yKgALzVbpdxKeUWKtSwYbzwVpc+Frn904g+xxLN1sag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OICIoC7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5E4C4CEF1;
	Fri,  5 Sep 2025 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757091268;
	bh=Iz8mTq/GEt9A4ZHGarw24hhU9Mlb6/EwBsMoab+mPtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OICIoC7/LLKx9fTTyxBxRcGy4DbUKkKVichVDNEOiapVC4hlwFdwbzVpx3HaZIScj
	 LAN12dddrAPyuDATCQpXKBcBwOs6DGvCsPOdl3A1mVq3uVaIA/LQ6Zeo6llPEaVNOP
	 42E286+2qeHqhaE8QZ2lvMQpwjZHGGa4AuzVHULiUBaDPoJazjPZ8CHXq8WsV1nyPc
	 iWDsoHrd/R6sVt+aYYdab8MJOzuo8OR5CRayL3P5HpHwAm9c8vEtSnZQX1h/fOE58o
	 7CNKIqS5XTp/9h9AGrP7+zDOSDJVYj/g8gRFQrqgHwvG744dhAUcMUevtbuNHIWAWZ
	 W4OcFT6Sd0t7A==
Date: Fri, 5 Sep 2025 11:54:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <20250905165426.GA1307227@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905101659.95700-2-devendra.verma@amd.com>

On Fri, Sep 05, 2025 at 03:46:58PM +0530, Devendra K Verma wrote:
> AMD MDB PCIe endpoint support. For AMD specific support
> added the following
>   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
>   - AMD MDB specific driver data
>   - AMD MDB specific VSEC capability to retrieve the device DDR
>     base address.
> 
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 83 +++++++++++++++++++++++++++++++++++++-
>  include/linux/pci_ids.h            |  1 +
>  2 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 3371e0a7..749067b 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -18,10 +18,12 @@
>  #include "dw-edma-core.h"
>  
>  #define DW_PCIE_VSEC_DMA_ID			0x6
> +#define DW_PCIE_AMD_MDB_VSEC_ID			0x20
>  #define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
>  #define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
>  #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
>  #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
> +#define DW_PCIE_AMD_MDB_INVALID_ADDR		(~0ULL)
>  
>  #define DW_BLOCK(a, b, c) \
>  	{ \
> @@ -50,6 +52,7 @@ struct dw_edma_pcie_data {
>  	u8				irqs;
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
> +	u64				phys_addr;
>  };
>  
>  static const struct dw_edma_pcie_data snps_edda_data = {
> @@ -90,6 +93,44 @@ struct dw_edma_pcie_data {
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
>  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
>  {
>  	return pci_irq_vector(to_pci_dev(dev), nr);
> @@ -120,9 +161,14 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	u32 val, map;
>  	u16 vsec;
>  	u64 off;
> +	u16 vendor;
>  
> -	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> -					DW_PCIE_VSEC_DMA_ID);
> +	vendor = pdev->vendor;
> +	if (vendor != PCI_VENDOR_ID_SYNOPSYS &&
> +	    vendor != PCI_VENDOR_ID_XILINX)
> +		return;
> +
> +	vsec = pci_find_vsec_capability(pdev, vendor, DW_PCIE_VSEC_DMA_ID);

The vendor of a device assigns VSEC IDs and determines what each ID
means, so the semantics of a VSEC Capability are determined by the
tuple of (device Vendor ID, VSEC ID), where the Vendor ID is the value
at 0x00 in config space.

This code assumes that Synopsys and Xilinx agreed on the same VSEC ID
(6) and semantics of that Capability.

I assume you know this is true in this particular case, but it is not
safe for in general because even if other vendors incorporate this
same IP into their devices, they may choose different VSEC IDs because
they may have already assigned the VSEC ID 6 for something else.

So you should add a comment to the effect that "Synopsys and Xilinx
happened to use the same VSEC ID and semantics.  This may vary for
other vendors."

The DVSEC Capability is a more generic solution to this problem.  The
VSEC ID namespace is determined by the Vendor ID of the *device*.

By contrast, the DVSEC ID namespace is determined by a Vendor ID in
the DVSEC Capability itself, not by the Vendor ID of the device.

So AMD could define a DVSEC ID, e.g., 6, and define the semantics of
that DVSEC.  Then devices from *any* vendor could include a DVSEC
Capability with (PCI_VENDOR_ID_AMD, 6), and generic code could look
for that DVSEC independent of what is at 0x00 in config space.

>  	if (!vsec)
>  		return;
>  
> @@ -155,6 +201,27 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	off <<= 32;
>  	off |= val;
>  	pdata->rg.off = off;
> +
> +	/* AMD specific VSEC capability */
> +	if (vendor != PCI_VENDOR_ID_XILINX)
> +		return;
> +
> +	vsec = pci_find_vsec_capability(pdev, vendor,
> +					DW_PCIE_AMD_MDB_VSEC_ID);

pci_find_vsec_capability() finds a Vendor-Specific Extended Capability
defined by the vendor of the device (Xilinx in this case).

pci_find_vsec_capability() already checks that dev->vendor matches the
vendor argument so you don't need the "vendor != PCI_VENDOR_ID_XILINX"
check above.

DW_PCIE_AMD_MDB_VSEC_ID should include "XILINX" because this ID is in
the namespace created by PCI_VENDOR_ID_XILINX, i.e., it's somewhere in
the (PCI_VENDOR_ID_XILINX, x) space.

This code should look something like this (you could add "MDB" or
something if it makes sense):

  #define PCI_VSEC_ID_XILINX_DMA_DATA               0x20

  vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
                                  PCI_VSEC_ID_XILINX_DMA_DATA);

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
> +	pdata->phys_addr = off;
>  }
>  
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> @@ -179,6 +246,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	}
>  
>  	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> +	vsec_data->phys_addr = DW_PCIE_AMD_MDB_INVALID_ADDR;
>  
>  	/*
>  	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
> @@ -186,6 +254,15 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	 */
>  	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> +		/*
> +		 * There is no valid address found for the LL memory
> +		 * space on the device side.
> +		 */
> +		if (vsec_data->phys_addr == DW_PCIE_AMD_MDB_INVALID_ADDR)
> +			return -EINVAL;
> +	}
> +
>  	/* Mapping PCI BAR regions */
>  	mask = BIT(vsec_data->rg.bar);
>  	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
> @@ -367,6 +444,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
>  
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
> +	  (kernel_ulong_t)&amd_mdb_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 92ffc43..c15607d 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -636,6 +636,7 @@
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
>  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
>  #define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
> +#define PCI_DEVICE_ID_AMD_MDB_B054	0xb054

Unless PCI_DEVICE_ID_AMD_MDB_B054 is used in more than one driver,
move the #define into the file that uses it.  See the note at the top
of pci_ids.h.

