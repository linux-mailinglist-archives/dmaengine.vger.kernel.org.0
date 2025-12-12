Return-Path: <dmaengine+bounces-7588-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E5CB9843
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 19:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5D713012449
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 18:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B862F0699;
	Fri, 12 Dec 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vha5Ng+h"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE112D77EA;
	Fri, 12 Dec 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765562890; cv=none; b=sNWk0jG41lWqB/wzCExIAjqaI20WeWzBz3hrkO1LyaqqvlOGEf3BmMWSEOWHYhw/ExSZhTbmTTvHZFc7aZYp4/oJKkzdcdE1YXYlvf30Xk5o177PeZz9jRb+0Hwvm30m+V0KRfg1L5FJymZyolT3PfrYbcT9oviD4oXVPc4tZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765562890; c=relaxed/simple;
	bh=6nAtonLglnUwDYSz6eucjK8KLKabE12fM1gh78hx9Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k7rnp7Axy17A4S3g2bBWp4hQjiizJBxJ2dWJI7MLJF5oipgsvBqa75rv+fHhWhHDKRGa3GkEzzSGCcrH6NvXZ1LlObdbLzVQtZIPqHUCvLXkpLEciCXb9zOSYReiHKAJfz42ARw4BNVhjGaQ3QlCGL0omWJNhbqcOc99l6AxDZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vha5Ng+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB975C4CEF1;
	Fri, 12 Dec 2025 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765562890;
	bh=6nAtonLglnUwDYSz6eucjK8KLKabE12fM1gh78hx9Ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Vha5Ng+hB6Vv0e/zk2DLwmxB4mRDXwMynVoS2IT7Iv4YTTGCAEjHag+WWOvVdxcn7
	 d1IzVcrHHIzP+8cBwltu4w6SqSVzLUPw2SsRgSIr3LYtd9EnBWwyLA9143KBIlbJho
	 udcLYb2Mb2OfXWLBRkjM86K8bXRzbg5KpIJmewAZdbElwsBrnuxWnz8z1M8nb//RnP
	 MTao9cCQk8eNx0eMZiGCwuKWTAif2qN2y3OqfjkTa0RnUi6E5Mn4TYMFYUqACaP5Il
	 XabxZyQ2rI8Yx6J+fKNw+2K1YnLOHYfij3NGE0uxXPkqN0CFbrQhKcy8SC9lN9T9XQ
	 w9dZ4Vo+y2I2g==
Date: Fri, 12 Dec 2025 12:08:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v7 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <20251212180808.GA3645554@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212122056.8153-2-devendra.verma@amd.com>

On Fri, Dec 12, 2025 at 05:50:55PM +0530, Devendra K Verma wrote:
> AMD MDB PCIe endpoint support. For AMD specific support
> added the following
>   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
>   - AMD MDB specific driver data
>   - AMD MDB specific VSEC capability to retrieve the device DDR
>     base address.
> ...

> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

> +/* Synopsys */
>  #define DW_PCIE_VSEC_DMA_ID			0x6
>  #define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
>  #define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
>  #define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
>  #define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)

These should include "SYNOPSYS" since they are specific to
PCI_VENDOR_ID_SYNOPSYS.  Add corresponding XILINX #defines below for
the XILINX VSEC.  They'll be the same masks.

> +/* AMD MDB (Xilinx) specific defines */
> +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
> +#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
> +#define PCI_DEVICE_ID_AMD_MDB_B054		0xb054

Looks odd to me that PCI_DEVICE_ID_AMD_MDB_B054 goes with
PCI_VENDOR_ID_XILINX.  To me this would make more sense as
PCI_DEVICE_ID_XILINX_B054.  Move it so it's not in the middle of the
VSEC-related things.

> +#define DW_PCIE_AMD_MDB_INVALID_ADDR		(~0ULL)

It looks like this is related to the value from
DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG and is only used for Xilinx, so
should be named similarly, e.g., DW_PCIE_XILINX_MDB_INVALID_ADDR, and
moved to be next to it.

> +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
> +#define DW_PCIE_XILINX_LL_SIZE			0x800
> +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
> +#define DW_PCIE_XILINX_DT_SIZE			0x800

These LL/DT gap and size #defines don't look like they're directly
related to the VSEC, so they should at least be moved after the
DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG #defines, since those *are* part of
the VSEC.

> +#define DW_PCIE_XILINX_MDB_VSEC_HDR_ID		0x20

DW_PCIE_XILINX_MDB_VSEC_HDR_ID is pointless and should be removed.
See below.

> +#define DW_PCIE_XILINX_MDB_VSEC_REV		0x1
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
> +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8

> +static const struct dw_edma_pcie_data amd_mdb_data = {

This is a confusing mix of "xilinx" and "amd_mdb".  The DEVICE_ID
#define uses "AMD_MDB".  The other #defines mostly use XILINX.  This
data structure uses "amd_mdb".  The function uses "xilinx".

Since this patch only applies to PCI_VENDOR_ID_XILINX, I would make
this "xilinx_mdb_data".  If new devices come with a different vendor
ID, e.g., AMD, you can add a corresponding block for that.

> +static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> +					     struct dw_edma_pcie_data *pdata)
> +{
> +	u32 val, map;
> +	u16 vsec;
> +	u64 off;
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
> +	    PCI_VNDR_HEADER_LEN(val) != 0x18)
> +		return;
> +
> +	pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability DMA\n");

Perhaps reword this to "Detected Xilinx Vendor-Specific Extended
Capability DMA", and the one in dw_edma_pcie_get_synopsys_dma_data()
to similarly mention "Synopsys" to reinforce the fact that these are
Xilinx-specific and Synopsys-specific.

I think the REV and LEN checks are unnecessary; see below.

> +	pci_read_config_dword(pdev, vsec + 0x8, &val);
> +	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);

Should use XILINX #defines.  Another reason for adding "SYNOPSYS" to
the #defines for the Synopsys VSEC.

> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> +					DW_PCIE_XILINX_MDB_VSEC_ID);
> +	if (!vsec)
> +		return;
> +
> +	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	if (PCI_VNDR_HEADER_ID(val) != DW_PCIE_XILINX_MDB_VSEC_HDR_ID ||

pci_find_vsec_capability() already checks that PCI_VNDR_HEADER_ID() ==
DW_PCIE_XILINX_MDB_VSEC_ID, so there's no need to check this again.

> +	    PCI_VNDR_HEADER_REV(val) != DW_PCIE_XILINX_MDB_VSEC_REV)

I know this is copied from dw_edma_pcie_get_vsec_dma_data(), but I
think it's a bad idea to check for the exact revision because it
forces a change to existing, working code if there's ever a device
with a new revision of this VSEC ID.

If there are new revisions of this VSEC, they should preserve the
semantics of previous revisions.  If there was a rev 0 of this VSEC, I
think we should check for PCI_VNDR_HEADER_REV() >= 1.  If rev 1 was
the first revision, you could skip the check altogether.

If rev 2 *adds* new registers or functionality, we would have to add
new code to support that, and *that* code should check for
PCI_VNDR_HEADER_REV() >= 2.

I think the REV and LEN checking in dw_edma_pcie_get_vsec_dma_data()
is also too aggressive.

>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> @@ -179,12 +318,34 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	}
>  
>  	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> +	vsec_data->devmem_phys_off = DW_PCIE_AMD_MDB_INVALID_ADDR;

Seems weird to set devmem_phys_off here since it's only used for
PCI_VENDOR_ID_XILINX.  Couldn't this be done in
dw_edma_pcie_get_xilinx_dma_data()?

> -	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> +	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
> +	dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
> +
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

This PCI_VENDOR_ID_XILINX block looks like maybe it would make sense
inside dw_edma_pcie_get_xilinx_dma_data()?  That function could look
like:

  dw_edma_pcie_get_xilinx_dma_data(...)
  {
    if (pdev->vendor != PCI_VENDOR_ID_XILINX)
      return;

    pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
    ...

>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_AMD_MDB_B054),
> +	  (kernel_ulong_t)&amd_mdb_data },

