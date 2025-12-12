Return-Path: <dmaengine+bounces-7576-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA59CB77C9
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 01:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAAD4300AB10
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 00:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6DA2459E5;
	Fri, 12 Dec 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROygXj6M"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C2239E97;
	Fri, 12 Dec 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765500902; cv=none; b=cgIVPFjxG3nx0Qz6jgtKhus8UmW+jutqgeE/PWKmC1AnD3vhKqqy01qQ9aI2SOeWTtkPOScdhZbXRqRLbuN9Tgui9tJNpssnX8vFP7WuiEajc8YFaRupkERE7wlqNlZQVEVzMpar5UNTi/aazPib1o686fp/HdkZRTmDd2I1KRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765500902; c=relaxed/simple;
	bh=7XuU/j4oXsp3wSSPQRo5hX3AjF2tjsZ/bHzcBL+TgyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfa3Fav1vfc3kIMJRArNdGcuFvpuX1uVk1M3PTx1e17goYevC6GOXFkHrdSDe0y1VpgQ1qXk+q5jd2nd1Z8baaX+o3W7gOHI/mUyuoUVy03Suv/WXe+n5G1JwU6YDPQCH+fbjRLWbMio5QGH0xki9hsKX3v4YBwSFtGO1NhoXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROygXj6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133F3C4CEF7;
	Fri, 12 Dec 2025 00:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765500902;
	bh=7XuU/j4oXsp3wSSPQRo5hX3AjF2tjsZ/bHzcBL+TgyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ROygXj6MAc06NChJEs/ZiPtJ8xwU7YF4LvcRNV1N2Geaxum3HdWA29IXTaERtJyP1
	 BFBhdLvwBV9ecTiPCUHPhp4f2cEdAD23q8wmphA2z+rZKhAbpSrtCzdqBH8DMlyaF2
	 5ri7H689/UzrswPpd09AKb5TaVz5YnLjH0EMH5cLj3dGsDGw1wZtTNHSFiYXD7SzPv
	 ydB7t4pn9Xo8gFMBFtaEC4NHZRf6VH9SbHbD8zuvXZfBI3hHcTu26t7LZb36BDYsIg
	 CvCeDkzChLYRYsRCUegKvGjix4vuzSC2UO0DxdJqeNsJ+wBvOTpd2n1Tbb0RIDhW3R
	 EqAgtWAFtdoRA==
Date: Fri, 12 Dec 2025 09:54:52 +0900
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Verma, Devendra" <Devendra.Verma@amd.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "vkoul@kernel.org" <vkoul@kernel.org>, 
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
Message-ID: <jtqs5hwzibkozyz5refb5wzqn3gbdoruqp3squa7ziwltj43lq@wts4vsqo4kcs>
References: <b2s6genayrgyicxawx2scpswfji3c62vxn7cgvpzwfbm6vodtx@5dseozibsrte>
 <20251210163228.GA3526502@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251210163228.GA3526502@bhelgaas>

On Wed, Dec 10, 2025 at 10:32:28AM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 10, 2025 at 10:26:38PM +0900, Manivannan Sadhasivam wrote:
> > On Wed, Dec 10, 2025 at 11:40:04AM +0000, Verma, Devendra wrote:
> > > > -----Original Message-----
> > > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > > On Fri, Nov 21, 2025 at 05:04:54PM +0530, Devendra K Verma wrote:
> > > > > AMD MDB PCIe endpoint support. For AMD specific support added the
> > > > > following
> > > > >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> > > > >   - AMD MDB specific driver data
> > > > >   - AMD MDB specific VSEC capability to retrieve the device DDR
> > > > >     base address.
> 
> > > > > +/* Synopsys */
> > > > >  #define DW_PCIE_VSEC_DMA_ID                  0x6
> 
> > > > > +/* AMD MDB (Xilinx) specific defines */
> > > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> 
> > > > > static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> 
> > > > > +      * Synopsys and AMD (Xilinx) use the same VSEC ID for the
> > > > > + purpose
> > > >
> > > > Same or different?
> > > 
> > > It is the same capability for which Synosys and AMD (Xilinx) share
> > > the common value.
> > 
> > This is confusing. You are searching for either DW_PCIE_VSEC_DMA_ID
> > or DW_PCIE_XILINX_MDB_VSEC_DMA_ID below, which means that the VSEC
> > IDs are different.
> 
> This is perennially confusing.
> 
> Since this is a "Vendor-Specific" (not a "Designated Vendor-Specific")
> capability, we must search for the per-vendor VSEC ID, i.e.,
> DW_PCIE_VSEC_DMA_ID for PCI_VENDOR_ID_SYNOPSYS devices or
> DW_PCIE_XILINX_MDB_VSEC_DMA_ID for PCI_VENDOR_ID_XILINX devices.
> 
> The fact that DW_PCIE_VSEC_DMA_ID == DW_PCIE_XILINX_MDB_VSEC_DMA_ID is
> a coincidence and is not relevant to the code.  The comment that
> "Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose"
> should be removed because it adds confusion and the code doesn't rely
> on that.
> 
> However, the subsequent code DOES rely on the fact that the Synopsys
> and the Xilinx VSECs have the same *registers* at the same offsets:
> 
>         pci_read_config_dword(pdev, vsec + 0x8, &val);
>         map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
>         pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
> 
>         pci_read_config_dword(pdev, vsec + 0xc, &val);
>         pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
>                                  FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
>         pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
>                                  FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
> 
>         pci_read_config_dword(pdev, vsec + 0x14, &val);
>         off = val;
> 
>         pci_read_config_dword(pdev, vsec + 0x10, &val);
> 
> The VSEC ID *values* are not relevant, but the fact that the registers
> in the Synopsys and the Xilinx capabilities are identical *is*
> important and not obvious, so if you share the code that reads those
> registers, there should be a comment about that.
> 
> The normal way to use VSEC is to look for a capability for a single
> vendor and interpret it using code for that specific vendor.  I think
> I would split this into separate dw_edma_pcie_get_synopsys_dma_data()
> and dw_edma_pcie_get_xilinx_dma_data() functions to make it obvious
> that these are indeed controlled by different vendors, e.g.,
> 
>   dw_edma_pcie_get_synopsys_dma_data()
>   {
>     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
>                                     DW_PCIE_VSEC_DMA_ID);
>     if (!vsec)
>       return;
> 
>     pci_read_config_dword(pdev, vsec + 0x8, &val);
>     ...
>   }
> 
>   dw_edma_pcie_get_xilinx_dma_data()
>   {
>     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>                                     DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
>     if (!vsec)
>       return;
> 
>     pci_read_config_dword(pdev, vsec + 0x8, &val);
>     ...
> 
>     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>                                     DW_PCIE_XILINX_MDB_VSEC_ID);
>     if (!vsec)
>       return;
>     ...
>   }
> 
> It's safe to call both of them for all devices like this:
> 
>   dw_edma_pcie_probe
>   {
>     ...
>     dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
>     dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
>     ...
>   }
> 
> Most of the code in dw_edma_pcie_get_synopsys_dma_data() would be
> duplicated, but that's OK and acknowledges the fact that Synopsys and
> Xilinx can evolve that VSEC independently.
> 

Yes, it will make it clear and obvious!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

