Return-Path: <dmaengine+bounces-7554-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD2CB303C
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 14:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19383301CF85
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 13:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB1B322A0A;
	Wed, 10 Dec 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmECU3LT"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5A1D416C;
	Wed, 10 Dec 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373202; cv=none; b=cE5cD7y/k9gC2gzHLuV9klO2RMxwoFv+JK4BoBQ3u775lHYTPfHhUuaEd8qOSwjmKFEPPmgOql90+Rp8P+XjcxU5OY/gVMYeS+E7+aFCfRx7KZRZcInv+lXM2kFEPJkGlPjfh7YG81CHjLj7Ii2iD0siHqN1MDRVhLkmqqpOv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373202; c=relaxed/simple;
	bh=GWmhjomXDJNzLWkvxLSNcXtct2ZI1H8+AihqKNSjUCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8ulMVPytlpgNkZ21cW4f0uPkwl69YiBQDSBisqefO2JgBKyA/IHb3iXH1vevweljJcJZ9DUZEQ8t4c6A2Htr+jexqI75klkvy+uLXZtcSAyvHV3iL5ddVplYpD7eLQllcbW2beTiizWKwOVeIxOj2DtyFyoQZfvgTbsLcz8gF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmECU3LT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12FAC4CEF1;
	Wed, 10 Dec 2025 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765373202;
	bh=GWmhjomXDJNzLWkvxLSNcXtct2ZI1H8+AihqKNSjUCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmECU3LTHgNaWjKsAPKC5edZif+Wp1XdsjFgj+/WejGrEHFvBYicpuUnEW/oBcA+N
	 jqUdyvZyk6mw0AeSddHIgzFC1Z6w85MeDSDo2oNZjCuzKOTvrfF5MWf9dVKq8MOfWI
	 eAUywHMEyqgdy9z99dQRshxuaB0i8B9OHZ6U7OWpDItDqWqnhlDwweBLRo+OCDo+7c
	 J1ELdqk6iq38mnVMg6c0pnvgIgTr/vTwRMNO8yjIMTtkW7Jq3jHDeQoIT07BKHbdQl
	 CXUtjqQMTsXooEfii+vQut0UghuQ2uclhY+Ey+zbjekZp0aTodMbQH6rSyKn6B6UWg
	 zF+ev/C8lBRBg==
Date: Wed, 10 Dec 2025 22:26:38 +0900
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, 
	"vkoul@kernel.org" <vkoul@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
 Support
Message-ID: <b2s6genayrgyicxawx2scpswfji3c62vxn7cgvpzwfbm6vodtx@5dseozibsrte>
References: <20251121113455.4029-1-devendra.verma@amd.com>
 <20251121113455.4029-2-devendra.verma@amd.com>
 <4zdl6m4u3i3zjqubzqoirzi53psjt7k7pmhensly322ucgcbon@vouphvvxf22a>
 <SA1PR12MB812014670126E9AFE671586B95A0A@SA1PR12MB8120.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR12MB812014670126E9AFE671586B95A0A@SA1PR12MB8120.namprd12.prod.outlook.com>

On Wed, Dec 10, 2025 at 11:40:04AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Manivannan
> 
> Please check my response inline.
> 
> Regards,
> Devendra
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: Monday, December 8, 2025 10:55 AM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; vkoul@kernel.org; dmaengine@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> > <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v6 1/2] dmaengine: dw-edma: Add AMD MDB
> > Endpoint Support
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, Nov 21, 2025 at 05:04:54PM +0530, Devendra K Verma wrote:
> > > AMD MDB PCIe endpoint support. For AMD specific support added the
> > > following
> > >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> > >   - AMD MDB specific driver data
> > >   - AMD MDB specific VSEC capability to retrieve the device DDR
> > >     base address.
> > >
> > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > ---
> > > Changes in v6:
> > > Included "sizes.h" header and used the appropriate definitions instead
> > > of constants.
> > >
> > > Changes in v5:
> > > Added the definitions for Xilinx specific VSEC header id, revision,
> > > and register offsets.
> > > Corrected the error type when no physical offset found for device side
> > > memory.
> > > Corrected the order of variables.
> > >
> > > Changes in v4:
> > > Configured 8 read and 8 write channels for Xilinx vendor Added checks
> > > to validate vendor ID for vendor specific vsec id.
> > > Added Xilinx specific vendor id for vsec specific to Xilinx Added the
> > > LL and data region offsets, size as input params to function
> > > dw_edma_set_chan_region_offset().
> > > Moved the LL and data region offsets assignment to function for Xilinx
> > > specific case.
> > > Corrected comments.
> > >
> > > Changes in v3:
> > > Corrected a typo when assigning AMD (Xilinx) vsec id macro and
> > > condition check.
> > >
> > > Changes in v2:
> > > Reverted the devmem_phys_off type to u64.
> > > Renamed the function appropriately to suit the functionality for
> > > setting the LL & data region offsets.
> > >
> > > Changes in v1:
> > > Removed the pci device id from pci_ids.h file.
> > > Added the vendor id macro as per the suggested method.
> > > Changed the type of the newly added devmem_phys_off variable.
> > > Added to logic to assign offsets for LL and data region blocks in case
> > > more number of channels are enabled than given in amd_mdb_data struct.
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-pcie.c | 139
> > > ++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 137 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 3371e0a7..3d7247c 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -14,15 +14,31 @@
> > >  #include <linux/pci-epf.h>
> > >  #include <linux/msi.h>
> > >  #include <linux/bitfield.h>
> > > +#include <linux/sizes.h>
> > >
> > >  #include "dw-edma-core.h"
> > >
> > > +/* Synopsys */
> > >  #define DW_PCIE_VSEC_DMA_ID                  0x6
> > >  #define DW_PCIE_VSEC_DMA_BAR                 GENMASK(10, 8)
> > >  #define DW_PCIE_VSEC_DMA_MAP                 GENMASK(2, 0)
> > >  #define DW_PCIE_VSEC_DMA_WR_CH                       GENMASK(9, 0)
> > >  #define DW_PCIE_VSEC_DMA_RD_CH                       GENMASK(25, 16)
> > >
> > > +/* AMD MDB (Xilinx) specific defines */
> > > +#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID               0x6
> > > +#define DW_PCIE_XILINX_MDB_VSEC_ID           0x20
> > > +#define PCI_DEVICE_ID_AMD_MDB_B054           0xb054
> > > +#define DW_PCIE_AMD_MDB_INVALID_ADDR         (~0ULL)
> > > +#define DW_PCIE_XILINX_LL_OFF_GAP            0x200000
> > > +#define DW_PCIE_XILINX_LL_SIZE                       0x800
> > > +#define DW_PCIE_XILINX_DT_OFF_GAP            0x100000
> > > +#define DW_PCIE_XILINX_DT_SIZE                       0x800
> > > +#define DW_PCIE_XILINX_MDB_VSEC_HDR_ID               0x20
> > > +#define DW_PCIE_XILINX_MDB_VSEC_REV          0x1
> > > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH       0xc
> > > +#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW        0x8
> > > +
> > >  #define DW_BLOCK(a, b, c) \
> > >       { \
> > >               .bar = a, \
> > > @@ -50,6 +66,7 @@ struct dw_edma_pcie_data {
> > >       u8                              irqs;
> > >       u16                             wr_ch_cnt;
> > >       u16                             rd_ch_cnt;
> > > +     u64                             devmem_phys_off;
> > >  };
> > >
> > >  static const struct dw_edma_pcie_data snps_edda_data = { @@ -90,6
> > > +107,64 @@ struct dw_edma_pcie_data {
> > >       .rd_ch_cnt                      = 2,
> > >  };
> > >
> > > +static const struct dw_edma_pcie_data amd_mdb_data = {
> > > +     /* MDB registers location */
> > > +     .rg.bar                         = BAR_0,
> > > +     .rg.off                         = SZ_4K,        /*  4 Kbytes */
> > > +     .rg.sz                          = SZ_8K,        /*  8 Kbytes */
> > > +
> > > +     /* Other */
> > > +     .mf                             = EDMA_MF_HDMA_NATIVE,
> > > +     .irqs                           = 1,
> > > +     .wr_ch_cnt                      = 8,
> > > +     .rd_ch_cnt                      = 8,
> > > +};
> > > +
> > > +static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data
> > *pdata,
> > > +                                        enum pci_barno bar, off_t start_off,
> > > +                                        off_t ll_off_gap, size_t ll_size,
> > > +                                        off_t dt_off_gap, size_t
> > > +dt_size) {
> > > +     u16 wr_ch = pdata->wr_ch_cnt;
> > > +     u16 rd_ch = pdata->rd_ch_cnt;
> > > +     off_t off;
> > > +     u16 i;
> > > +
> > > +     off = start_off;
> > > +
> > > +     /* Write channel LL region */
> > > +     for (i = 0; i < wr_ch; i++) {
> > > +             pdata->ll_wr[i].bar = bar;
> > > +             pdata->ll_wr[i].off = off;
> > > +             pdata->ll_wr[i].sz = ll_size;
> > > +             off += ll_off_gap;
> > > +     }
> > > +
> > > +     /* Read channel LL region */
> > > +     for (i = 0; i < rd_ch; i++) {
> > > +             pdata->ll_rd[i].bar = bar;
> > > +             pdata->ll_rd[i].off = off;
> > > +             pdata->ll_rd[i].sz = ll_size;
> > > +             off += ll_off_gap;
> > > +     }
> > > +
> > > +     /* Write channel data region */
> > > +     for (i = 0; i < wr_ch; i++) {
> > > +             pdata->dt_wr[i].bar = bar;
> > > +             pdata->dt_wr[i].off = off;
> > > +             pdata->dt_wr[i].sz = dt_size;
> > > +             off += dt_off_gap;
> > > +     }
> > > +
> > > +     /* Read channel data region */
> > > +     for (i = 0; i < rd_ch; i++) {
> > > +             pdata->dt_rd[i].bar = bar;
> > > +             pdata->dt_rd[i].off = off;
> > > +             pdata->dt_rd[i].sz = dt_size;
> > > +             off += dt_off_gap;
> > > +     }
> > > +}
> > > +
> > >  static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int
> > > nr)  {
> > >       return pci_irq_vector(to_pci_dev(dev), nr); @@ -120,9 +195,24 @@
> > > static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > >       u32 val, map;
> > >       u16 vsec;
> > >       u64 off;
> > > +     int cap;
> > > +
> > > +     /*
> > > +      * Synopsys and AMD (Xilinx) use the same VSEC ID for the
> > > + purpose
> >
> > Same or different?
> 
> It is the same capability for which Synosys and AMD (Xilinx) share the common value.
> 

This is confusing. You are searching for either DW_PCIE_VSEC_DMA_ID or
DW_PCIE_XILINX_MDB_VSEC_DMA_ID below, which means that the VSEC IDs are
different.

> >
> > > +      * of map, channel counts, etc.
> > > +      */
> > > +     switch (pdev->vendor) {
> > > +     case PCI_VENDOR_ID_SYNOPSYS:
> > > +             cap = DW_PCIE_VSEC_DMA_ID;
> > > +             break;
> > > +     case PCI_VENDOR_ID_XILINX:
> > > +             cap = DW_PCIE_XILINX_MDB_VSEC_DMA_ID;
> > > +             break;
> > > +     default:
> > > +             return;
> > > +     }
> > >
> > > -     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> > > -                                     DW_PCIE_VSEC_DMA_ID);
> > > +     vsec = pci_find_vsec_capability(pdev, pdev->vendor, cap);
> > >       if (!vsec)
> > >               return;
> > >
> > > @@ -155,6 +245,28 @@ static void
> > dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > >       off <<= 32;
> > >       off |= val;
> > >       pdata->rg.off = off;
> > > +
> > > +     /* Xilinx specific VSEC capability */
> > > +     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> > > +                                     DW_PCIE_XILINX_MDB_VSEC_ID);
> > > +     if (!vsec)
> > > +             return;
> > > +
> > > +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> > > +     if (PCI_VNDR_HEADER_ID(val) != DW_PCIE_XILINX_MDB_VSEC_HDR_ID

Also, this check is pointless as it essentially duplicates the check inside
pci_find_vsec_capability(). If pci_find_vsec_capability() returns a vsec cap
offset, it means, it has *found* the supplied VSEC ID. And there is no separate
DW_PCIE_XILINX_MDB_VSEC_HDR_ID. It is exactly the same as
DW_PCIE_XILINX_MDB_VSEC_ID.

> > ||
> > > +         PCI_VNDR_HEADER_REV(val) != DW_PCIE_XILINX_MDB_VSEC_REV)
> > > +             return;
> > > +
> > > +     pci_read_config_dword(pdev,
> > > +                           vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
> > > +                           &val);
> > > +     off = val;
> > > +     pci_read_config_dword(pdev,
> > > +                           vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
> > > +                           &val);
> > > +     off <<= 32;
> > > +     off |= val;
> > > +     pdata->devmem_phys_off = off;
> > >  }
> > >
> > >  static int dw_edma_pcie_probe(struct pci_dev *pdev, @@ -179,6 +291,7
> > > @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >       }
> > >
> > >       memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> > > +     vsec_data->devmem_phys_off = DW_PCIE_AMD_MDB_INVALID_ADDR;
> > >
> > >       /*
> > >        * Tries to find if exists a PCIe Vendor-Specific Extended
> > > Capability @@ -186,6 +299,26 @@ static int dw_edma_pcie_probe(struct
> > pci_dev *pdev,
> > >        */
> > >       dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
> > >
> > > +     if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> > > +             /*
> > > +              * There is no valid address found for the LL memory
> > > +              * space on the device side.
> > > +              */
> > > +             if (vsec_data->devmem_phys_off ==
> > DW_PCIE_AMD_MDB_INVALID_ADDR)
> > > +                     return -ENOMEM;
> >
> > Move this check to dw_edma_pcie_get_vsec_dma_data() and return -
> > ENOMEM directly.
> 
> In the subsequent patch of the same series (2/2), based on this check,
> instead of returning, a flag is set based on the retrieval of the address offset,
> which decides the actual flow for non-LL mode.
> For the similar functionality as above, dw_edma_pcie_get_vsec_dma_data() may
> require multiple changes alongside a comparison at the current location,
> be it error check or address value check to provide the almost similar functionality for
> non-LL mode.
> 

Fair enough.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

