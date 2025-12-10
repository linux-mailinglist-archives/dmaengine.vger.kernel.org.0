Return-Path: <dmaengine+bounces-7556-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A313CB37BA
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 17:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15E1C305863B
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2836028504F;
	Wed, 10 Dec 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XafJolWo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3B1494DB;
	Wed, 10 Dec 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765384351; cv=none; b=ISu6QJT1SrvLWKPriUlvN8lSgu+53hj1w9pGobJFPukbMpSmPKnlgXjDUtq/kxvCiGwtPWQi4a6/7P+EzVs7a7UeScFtNAdsHw8EDC+Pb00LYdiyR+2HNG+Pxj9ivfBNyM7XV58ByfcA+I1XqM1MglPJHLjmFM92Rpom6pma+Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765384351; c=relaxed/simple;
	bh=gU3uGmHH0y8w6wJf1aHQd4wAmRCE1fZ3jrJ9fQnI0xI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lmHe3zdvzB9CI201Gl/SHr4goZEasAZEbq5K8ayRlg9/gX4z/M/wP6ULCmm2msna1H+kbA2TtweOYFdj0p+QrkXhM0wjQsF9mhXc6QJEefU4I7rOcLmoK2HzXeV4vX9zm9lTMjja3bX8+0HRrh39DSKboW212ZEddoB1YGtzcMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XafJolWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A8EC4CEF1;
	Wed, 10 Dec 2025 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765384350;
	bh=gU3uGmHH0y8w6wJf1aHQd4wAmRCE1fZ3jrJ9fQnI0xI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XafJolWoE7AiPbYG4zkAtPMh1NeW2lGt40anXMCKT9CYx50S5HyjXtZA4hxSvNGZw
	 2JLQU8f482hno/MagRUmxLazJibILSHlehFt6F9tj+xvMiEeJFS0PaBfQQQnT9xxZW
	 Kx/KwQpoR0z691bBGQviHN2Ed1dWtOfiRHfLOf3YsZ4N343V+LTZ8BIqRQ5z+sZOEB
	 mn8Lj23CWUXrg5kEXHSj2nA3v9rZC+zK31N0+QbRcOyVZZa74/0GdS3wKkNl4/6bkQ
	 /BLyugCSBDrllBUwV2L6fQfHDf2fw2pZSHwoqOosgfefe89HjM93WOebXAkM+B+V73
	 4mEZPu9Lt8djw==
Date: Wed, 10 Dec 2025 10:32:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Verma, Devendra" <Devendra.Verma@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
Message-ID: <20251210163228.GA3526502@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2s6genayrgyicxawx2scpswfji3c62vxn7cgvpzwfbm6vodtx@5dseozibsrte>

On Wed, Dec 10, 2025 at 10:26:38PM +0900, Manivannan Sadhasivam wrote:
> On Wed, Dec 10, 2025 at 11:40:04AM +0000, Verma, Devendra wrote:
> > > -----Original Message-----
> > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > On Fri, Nov 21, 2025 at 05:04:54PM +0530, Devendra K Verma wrote:
> > > > AMD MDB PCIe endpoint support. For AMD specific support added the
> > > > following
> > > >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> > > >   - AMD MDB specific driver data
> > > >   - AMD MDB specific VSEC capability to retrieve the device DDR
> > > >     base address.

> > > > +/* Synopsys */
> > > >  #define DW_PCIE_VSEC_DMA_ID                  0x6

> > > > +/* AMD MDB (Xilinx) specific defines */
> > > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6

> > > > static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,

> > > > +      * Synopsys and AMD (Xilinx) use the same VSEC ID for the
> > > > + purpose
> > >
> > > Same or different?
> > 
> > It is the same capability for which Synosys and AMD (Xilinx) share
> > the common value.
> 
> This is confusing. You are searching for either DW_PCIE_VSEC_DMA_ID
> or DW_PCIE_XILINX_MDB_VSEC_DMA_ID below, which means that the VSEC
> IDs are different.

This is perennially confusing.

Since this is a "Vendor-Specific" (not a "Designated Vendor-Specific")
capability, we must search for the per-vendor VSEC ID, i.e.,
DW_PCIE_VSEC_DMA_ID for PCI_VENDOR_ID_SYNOPSYS devices or
DW_PCIE_XILINX_MDB_VSEC_DMA_ID for PCI_VENDOR_ID_XILINX devices.

The fact that DW_PCIE_VSEC_DMA_ID == DW_PCIE_XILINX_MDB_VSEC_DMA_ID is
a coincidence and is not relevant to the code.  The comment that
"Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose"
should be removed because it adds confusion and the code doesn't rely
on that.

However, the subsequent code DOES rely on the fact that the Synopsys
and the Xilinx VSECs have the same *registers* at the same offsets:

        pci_read_config_dword(pdev, vsec + 0x8, &val);
        map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
        pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);

        pci_read_config_dword(pdev, vsec + 0xc, &val);
        pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
                                 FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
        pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
                                 FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));

        pci_read_config_dword(pdev, vsec + 0x14, &val);
        off = val;

        pci_read_config_dword(pdev, vsec + 0x10, &val);

The VSEC ID *values* are not relevant, but the fact that the registers
in the Synopsys and the Xilinx capabilities are identical *is*
important and not obvious, so if you share the code that reads those
registers, there should be a comment about that.

The normal way to use VSEC is to look for a capability for a single
vendor and interpret it using code for that specific vendor.  I think
I would split this into separate dw_edma_pcie_get_synopsys_dma_data()
and dw_edma_pcie_get_xilinx_dma_data() functions to make it obvious
that these are indeed controlled by different vendors, e.g.,

  dw_edma_pcie_get_synopsys_dma_data()
  {
    vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
                                    DW_PCIE_VSEC_DMA_ID);
    if (!vsec)
      return;

    pci_read_config_dword(pdev, vsec + 0x8, &val);
    ...
  }

  dw_edma_pcie_get_xilinx_dma_data()
  {
    vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
                                    DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
    if (!vsec)
      return;

    pci_read_config_dword(pdev, vsec + 0x8, &val);
    ...

    vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
                                    DW_PCIE_XILINX_MDB_VSEC_ID);
    if (!vsec)
      return;
    ...
  }

It's safe to call both of them for all devices like this:

  dw_edma_pcie_probe
  {
    ...
    dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
    dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
    ...
  }

Most of the code in dw_edma_pcie_get_synopsys_dma_data() would be
duplicated, but that's OK and acknowledges the fact that Synopsys and
Xilinx can evolve that VSEC independently.

Bjorn

