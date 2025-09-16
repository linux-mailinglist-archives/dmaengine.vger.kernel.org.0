Return-Path: <dmaengine+bounces-6540-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C29DB59B96
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 17:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E14485555
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCBC229B36;
	Tue, 16 Sep 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFzKO8jA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F622AD16;
	Tue, 16 Sep 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035047; cv=none; b=pQLjVrLGEhPuW36/MA0cP75XeJj1b8/6Wabg12qFkhjtiRrv0n5gxNe6DPR1RyTG3o/1zRR6XHc8ubQa9NzgTCtYNTUEWMKnuXz9t8tF8wwQW7hQz53GCA67Dp/TTCIYwHu7OuTy1WwAKaz9kxBL3XsM/f1cBGQPNbdRAH7wSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035047; c=relaxed/simple;
	bh=A8E8x5fuXpCM+FBWZSmn2EAMAcnZvznNPoDqYpcEXng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rw0o9Kolx5+Cx1v3xjO6PHBuqXU6u7KncJ2TFzinTttpoX87Om3vYeNf3WMgNAEkUI1wOywnTmpo+Av93jTixofzpcJUOac7R1cXy3ujUE/60VzOrDdHCvnaK9T70Rr6MKFGsILgsvxTYZz8HuQ4+Smr7FimYSGv0FkhWAozZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFzKO8jA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19055C4CEEB;
	Tue, 16 Sep 2025 15:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758035047;
	bh=A8E8x5fuXpCM+FBWZSmn2EAMAcnZvznNPoDqYpcEXng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fFzKO8jAs8H5xWrhfkZOrVRr462W8nP6fV2ip/6A0skP/Q5+zuC28nyTToNBiD9Pz
	 I1R6QYUqLCHES8szK7QsqgG+5FNwiP14cv3am+J7iPyroHEuYAAGoPKAdsTjz91vkS
	 /Cfo8xS8Dmby6E9ij+ekHr8n+io2PIj/qd6SX0zSCXpc+TEgXMIw9sInuOs8azx72C
	 2dWtXT4nIVMndH8Fg9EembSo2fVN/vYmsOVujbdbjTN9kMulpUgnXv213oW9StKMKR
	 rTP8U161NQrdqMzU67GJ4ec3NrQd/32CVzJGdTuJwYPqUDkhIk4ApdLAMWEDsTQ9m2
	 uwyNPCY+Itrng==
Date: Tue, 16 Sep 2025 10:04:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <20250916150405.GA1796861@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916104320.9473-2-devendra.verma@amd.com>

On Tue, Sep 16, 2025 at 04:13:18PM +0530, Devendra K Verma wrote:
> AMD MDB PCIe endpoint support. For AMD specific support
> added the following
>   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
>   - AMD MDB specific driver data
>   - AMD MDB specific VSEC capability to retrieve the device DDR
>     base address.

> +/* Synopsys */
>  #define DW_PCIE_VSEC_DMA_ID			0x6
>  #define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
>  #define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
>  #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
>  #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
>  
> +/* AMD MDB specific defines */
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> +#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> +#define PCI_DEVICE_ID_AMD_MDB_B054		0xb054
> +#define DW_PCIE_AMD_MDB_INVALID_ADDR		(~0ULL)

> @@ -120,9 +213,22 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	u32 val, map;
>  	u16 vsec;
>  	u64 off;
> +	u16 vendor = pdev->vendor;
> +	int cap;
>  
> -	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> -					DW_PCIE_VSEC_DMA_ID);
> +	/*
> +	 * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> +	 * of map, channel counts, etc.
> +	 */
> +	if (vendor != PCI_VENDOR_ID_SYNOPSYS ||
> +	    vendor != PCI_VENDOR_ID_XILINX)
> +		return;
> +
> +	cap = DW_PCIE_VSEC_DMA_ID;
> +	if (vendor == PCI_VENDOR_ID_XILINX)
> +		cap = DW_PCIE_XILINX_MDB_VSEC_ID;
> +
> +	vsec = pci_find_vsec_capability(pdev, vendor, cap);

This looks correct, so it's OK as-is.  But it does require more
analysis to verify than it would if you did it like this:

  vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
                                  DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
  if (!vsec) {
    vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
                                    DW_PCIE_XILINX_VSEC_DMA_ID);
    if (!vsec)
      return;
  }

This way it's obvious from the pci_find_vsec_capability() calls
themselves (and could potentially be checked by coccinelle, etc) that
we're using the Vendor ID and VSEC ID correctly.

> +	/* AMD specific VSEC capability */

This should say "Xilinx specific VSEC capability" because the Vendor
ID in the device is PCI_VENDOR_ID_XILINX.  We shouldn't have to look
up the corporate ownership history and figure out that AMD acquired
Xilinx.  That's not relevant in this context.

> +	vsec = pci_find_vsec_capability(pdev, vendor,
> +					DW_PCIE_XILINX_MDB_VSEC_ID);

But this one is wrong.  We do know that the device Vendor ID is either
PCI_VENDOR_ID_SYNOPSYS or PCI_VENDOR_ID_XILINX from above, but we
*don't* know what VSEC ID 0x20 means for Synopsys devices.

We only know what VSEC ID 0x20 means for Xilinx devices.  So this has
to be:

  vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
                                  DW_PCIE_XILINX_MDB_VSEC_ID);

Bjorn

