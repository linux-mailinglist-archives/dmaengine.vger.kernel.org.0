Return-Path: <dmaengine+bounces-7555-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C0ECB3063
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 14:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3DF306CF63
	for <lists+dmaengine@lfdr.de>; Wed, 10 Dec 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932B331B809;
	Wed, 10 Dec 2025 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1jSLUNF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651BF2F6921;
	Wed, 10 Dec 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373335; cv=none; b=BnCGEFwlkhxwzpnWNhq8viYq0eFoMqEFCnr+wz7N9/EvzSKBpjsCAZgdKyfCDx9WpHtTavm8ZR8QEygvzDAzjMY7VEUUCYQVol/FCnrCAV/0okIkEPahKnZFm5QzudPQuyaHnkbtPP4oRW9LoRhb9O81Fotunj1KH3Inxt2cFjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373335; c=relaxed/simple;
	bh=P2KiuDfTJZyyeegmlMu/tzLjG7kjB+eVL46tLpx8yhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEZmOK9On/gbVOWST7yNcEfumkrcxonM0Fi7SxlEu0H1kaVtDiDP0NTslocS1/2A99Yh502OaN/Zl1Vd2aJHbd/vOBxF8Ol21REfZsDybYgMNoraZYrVgBeWBbNH0hQ7tyg+eBiUOaDczBxDpRLzjA9MEdxYNeGLZ9Axa3TupTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1jSLUNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC75C4CEF1;
	Wed, 10 Dec 2025 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765373334;
	bh=P2KiuDfTJZyyeegmlMu/tzLjG7kjB+eVL46tLpx8yhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1jSLUNFqDGq8Dh39OkfITvP40vSy5t+L4MjvHcfGTfv67niJKOgvKoEKpT4y3jxu
	 0gzFfa66WC9ewVX0GCPoAv8+JtcmjFX2ZmZsHad+RqN1BMNXaNq+YLS8thVwR9/glr
	 Jjmeb65xlh1aLMw81+u5VkobSnsvwXyyavLtyIZSzp9e7alnCUnGSQSXjU7qeMOjL5
	 X78E2VWAVCVEgfTcldZJZhIJXYScrnZLutUz9R5FMiCIrB1ocVA+gteXksdmb3LNub
	 C7/Hznz/kiTT6emIIDTRoHUqIyLOzNlkvRYzTEEmVsF8QWTY2kg8h6gRcA+2BKscPc
	 Bwty7JGYiSHFw==
Date: Wed, 10 Dec 2025 22:28:51 +0900
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, 
	"vkoul@kernel.org" <vkoul@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <sshal25ch5pipzodbamg7h6k6scfzzsxnkox3dd5t6lvkrjis6@gmb55objtlgw>
References: <20251121113455.4029-1-devendra.verma@amd.com>
 <20251121113455.4029-3-devendra.verma@amd.com>
 <pcyikziojphmgcyeicjegmbpdpktsay5n5q3xvsexifziesxmx@wpcdf77lowo4>
 <SA1PR12MB8120143580059C4AEDA50CD395A0A@SA1PR12MB8120.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR12MB8120143580059C4AEDA50CD395A0A@SA1PR12MB8120.namprd12.prod.outlook.com>

On Wed, Dec 10, 2025 at 11:39:59AM +0000, Verma, Devendra wrote:
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
> > Sent: Monday, December 8, 2025 11:00 AM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; vkoul@kernel.org; dmaengine@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> > <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, Nov 21, 2025 at 05:04:55PM +0530, Devendra K Verma wrote:
> > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > The current code does not have the mechanisms to enable the DMA
> > > transactions using the non-LL mode. The following two cases are added
> > > with this patch:
> > > - When a valid physical base address is not configured via the
> > >   Xilinx VSEC capability then the IP can still be used in non-LL
> > >   mode. The default mode for all the DMA transactions and for all
> > >   the DMA channels then is non-LL mode.
> > > - When a valid physical base address is configured but the client
> > >   wants to use the non-LL mode for DMA transactions then also the
> > >   flexibility is provided via the peripheral_config struct member of
> > >   dma_slave_config. In this case the channels can be individually
> > >   configured in non-LL mode. This use case is desirable for single
> > >   DMA transfer of a chunk, this saves the effort of preparing the
> > >   Link List. This particular scenario is applicable to AMD as well
> > >   as Synopsys IP.
> > >
> >
> > Which in-kernel DMA client is using this non-LL mode?
> >
> > - Mani
> >
> 
> Existing dma client application(s) can use the non-LL mode for the
> AMD (Xilinx) use case with the help of a simple peripheral_config
> variable which is part of the dma_slave_config structure.

There is no existing client driver making use of this non-LL mode. So
essentially, this patch is introducing the dead code.

> Though, no driver is using the non-LL mode as non-LL mode is not available
> in the current code.

Then introduce non-LL mode when such client drivers start using it.

- Mani

> Based on the following input (peripheral_config) from client in
> dw_edma_device_config(), non-LL mode can be decided by the controller driver.
> +     if (config->peripheral_config)
> +             non_ll = *(int *)config->peripheral_config;
> 
> > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > ---
> > > Changes in v6
> > >   Gave definition to bits used for channel configuration.
> > >   Removed the comment related to doorbell.
> > >
> > > Changes in v5
> > >   Variable name 'nollp' changed to 'non_ll'.
> > >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> > >   Comments follow the 80-column guideline.
> > >
> > > Changes in v4
> > >   No change
> > >
> > > Changes in v3
> > >   No change
> > >
> > > Changes in v2
> > >   Reverted the function return type to u64 for
> > >   dw_edma_get_phys_addr().
> > >
> > > Changes in v1
> > >   Changed the function return type for dw_edma_get_phys_addr().
> > >   Corrected the typo raised in review.
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c    | 41 ++++++++++++++++++++---
> > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++++++--------
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > ++++++++++++++++++++++++++++++++++-
> > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> > >  include/linux/dma/edma.h              |  1 +
> > >  6 files changed, 130 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > index b43255f..60a3279 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -223,8 +223,31 @@ static int dw_edma_device_config(struct
> > dma_chan *dchan,
> > >                                struct dma_slave_config *config)  {
> > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +     int non_ll = 0;
> > > +
> > > +     if (config->peripheral_config &&
> > > +         config->peripheral_size != sizeof(int)) {
> > > +             dev_err(dchan->device->dev,
> > > +                     "config param peripheral size mismatch\n");
> > > +             return -EINVAL;
> > > +     }
> > >
> > >       memcpy(&chan->config, config, sizeof(*config));
> > > +
> > > +     /*
> > > +      * When there is no valid LLP base address available then the default
> > > +      * DMA ops will use the non-LL mode.
> > > +      * Cases where LL mode is enabled and client wants to use the non-LL
> > > +      * mode then also client can do so via providing the peripheral_config
> > > +      * param.
> > > +      */
> > > +     if (config->peripheral_config)
> > > +             non_ll = *(int *)config->peripheral_config;
> > > +
> > > +     chan->non_ll = false;
> > > +     if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))
> > > +             chan->non_ll = true;
> > > +
> > >       chan->configured = true;
> > >
> > >       return 0;
> > > @@ -353,7 +376,7 @@ static void dw_edma_device_issue_pending(struct
> > dma_chan *dchan)
> > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
> > >       enum dma_transfer_direction dir = xfer->direction;
> > >       struct scatterlist *sg = NULL;
> > > -     struct dw_edma_chunk *chunk;
> > > +     struct dw_edma_chunk *chunk = NULL;
> > >       struct dw_edma_burst *burst;
> > >       struct dw_edma_desc *desc;
> > >       u64 src_addr, dst_addr;
> > > @@ -419,9 +442,11 @@ static void dw_edma_device_issue_pending(struct
> > dma_chan *dchan)
> > >       if (unlikely(!desc))
> > >               goto err_alloc;
> > >
> > > -     chunk = dw_edma_alloc_chunk(desc);
> > > -     if (unlikely(!chunk))
> > > -             goto err_alloc;
> > > +     if (!chan->non_ll) {
> > > +             chunk = dw_edma_alloc_chunk(desc);
> > > +             if (unlikely(!chunk))
> > > +                     goto err_alloc;
> > > +     }
> > >
> > >       if (xfer->type == EDMA_XFER_INTERLEAVED) {
> > >               src_addr = xfer->xfer.il->src_start; @@ -450,7 +475,13
> > > @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
> > >               if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
> > >                       break;
> > >
> > > -             if (chunk->bursts_alloc == chan->ll_max) {
> > > +             /*
> > > +              * For non-LL mode, only a single burst can be handled
> > > +              * in a single chunk unlike LL mode where multiple bursts
> > > +              * can be configured in a single chunk.
> > > +              */
> > > +             if ((chunk && chunk->bursts_alloc == chan->ll_max) ||
> > > +                 chan->non_ll) {
> > >                       chunk = dw_edma_alloc_chunk(desc);
> > >                       if (unlikely(!chunk))
> > >                               goto err_alloc; diff --git
> > > a/drivers/dma/dw-edma/dw-edma-core.h
> > > b/drivers/dma/dw-edma/dw-edma-core.h
> > > index 71894b9..c8e3d19 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > > @@ -86,6 +86,7 @@ struct dw_edma_chan {
> > >       u8                              configured;
> > >
> > >       struct dma_slave_config         config;
> > > +     bool                            non_ll;
> > >  };
> > >
> > >  struct dw_edma_irq {
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 3d7247c..e7e95df 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -269,6 +269,15 @@ static void
> > dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > >       pdata->devmem_phys_off = off;
> > >  }
> > >
> > > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > +                              struct dw_edma_pcie_data *pdata,
> > > +                              enum pci_barno bar) {
> > > +     if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> > > +             return pdata->devmem_phys_off;
> > > +     return pci_bus_address(pdev, bar); }
> > > +
> > >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >                             const struct pci_device_id *pid)  { @@
> > > -278,6 +287,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >       struct dw_edma_chip *chip;
> > >       int err, nr_irqs;
> > >       int i, mask;
> > > +     bool non_ll = false;
> > >
> > >       vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
> > >       if (!vsec_data)
> > > @@ -302,21 +312,24 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >       if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
> > >               /*
> > >                * There is no valid address found for the LL memory
> > > -              * space on the device side.
> > > +              * space on the device side. In the absence of LL base
> > > +              * address use the non-LL mode or simple mode supported by
> > > +              * the HDMA IP.
> > >                */
> > >               if (vsec_data->devmem_phys_off ==
> > DW_PCIE_AMD_MDB_INVALID_ADDR)
> > > -                     return -ENOMEM;
> > > +                     non_ll = true;
> > >
> > >               /*
> > >                * Configure the channel LL and data blocks if number of
> > >                * channels enabled in VSEC capability are more than the
> > >                * channels configured in amd_mdb_data.
> > >                */
> > > -             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > -                                            DW_PCIE_XILINX_LL_OFF_GAP,
> > > -                                            DW_PCIE_XILINX_LL_SIZE,
> > > -                                            DW_PCIE_XILINX_DT_OFF_GAP,
> > > -                                            DW_PCIE_XILINX_DT_SIZE);
> > > +             if (!non_ll)
> > > +                     dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > +                                                    DW_PCIE_XILINX_LL_OFF_GAP,
> > > +                                                    DW_PCIE_XILINX_LL_SIZE,
> > > +                                                    DW_PCIE_XILINX_DT_OFF_GAP,
> > > +
> > > + DW_PCIE_XILINX_DT_SIZE);
> > >       }
> > >
> > >       /* Mapping PCI BAR regions */
> > > @@ -364,6 +377,7 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >       chip->mf = vsec_data->mf;
> > >       chip->nr_irqs = nr_irqs;
> > >       chip->ops = &dw_edma_pcie_plat_ops;
> > > +     chip->non_ll = non_ll;
> > >
> > >       chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
> > >       chip->ll_rd_cnt = vsec_data->rd_ch_cnt; @@ -372,7 +386,7 @@
> > > static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > >       if (!chip->reg_base)
> > >               return -ENOMEM;
> > >
> > > -     for (i = 0; i < chip->ll_wr_cnt; i++) {
> > > +     for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> > >               struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
> > >               struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
> > >               struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
> > > @@ -383,7 +397,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >                       return -ENOMEM;
> > >
> > >               ll_region->vaddr.io += ll_block->off;
> > > -             ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> > > +             ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > > +                                                      ll_block->bar);
> > >               ll_region->paddr += ll_block->off;
> > >               ll_region->sz = ll_block->sz;
> > >
> > > @@ -392,12 +407,13 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >                       return -ENOMEM;
> > >
> > >               dt_region->vaddr.io += dt_block->off;
> > > -             dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> > > +             dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > > +                                                      dt_block->bar);
> > >               dt_region->paddr += dt_block->off;
> > >               dt_region->sz = dt_block->sz;
> > >       }
> > >
> > > -     for (i = 0; i < chip->ll_rd_cnt; i++) {
> > > +     for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
> > >               struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
> > >               struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
> > >               struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
> > > @@ -408,7 +424,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >                       return -ENOMEM;
> > >
> > >               ll_region->vaddr.io += ll_block->off;
> > > -             ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> > > +             ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > > +                                                      ll_block->bar);
> > >               ll_region->paddr += ll_block->off;
> > >               ll_region->sz = ll_block->sz;
> > >
> > > @@ -417,7 +434,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> > *pdev,
> > >                       return -ENOMEM;
> > >
> > >               dt_region->vaddr.io += dt_block->off;
> > > -             dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> > > +             dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> > > +                                                      dt_block->bar);
> > >               dt_region->paddr += dt_block->off;
> > >               dt_region->sz = dt_block->sz;
> > >       }
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > index e3f8db4..ee31c9a 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct
> > dw_edma_chunk *chunk)
> > >               readl(chunk->ll_region.vaddr.io);  }
> > >
> > > -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > > first)
> > > +static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk,
> > > +bool first)
> > >  {
> > >       struct dw_edma_chan *chan = chunk->chan;
> > >       struct dw_edma *dw = chan->dw;
> > > @@ -263,6 +263,65 @@ static void dw_hdma_v0_core_start(struct
> > dw_edma_chunk *chunk, bool first)
> > >       SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > HDMA_V0_DOORBELL_START);  }
> > >
> > > +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk
> > *chunk)
> > > +{
> > > +     struct dw_edma_chan *chan = chunk->chan;
> > > +     struct dw_edma *dw = chan->dw;
> > > +     struct dw_edma_burst *child;
> > > +     u32 val;
> > > +
> > > +     list_for_each_entry(child, &chunk->burst->list, list) {
> > > +             SET_CH_32(dw, chan->dir, chan->id, ch_en,
> > > + HDMA_V0_CH_EN);
> > > +
> > > +             /* Source address */
> > > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > > +                       lower_32_bits(child->sar));
> > > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > > +                       upper_32_bits(child->sar));
> > > +
> > > +             /* Destination address */
> > > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > > +                       lower_32_bits(child->dar));
> > > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > > +                       upper_32_bits(child->dar));
> > > +
> > > +             /* Transfer size */
> > > +             SET_CH_32(dw, chan->dir, chan->id, transfer_size,
> > > + child->sz);
> > > +
> > > +             /* Interrupt setup */
> > > +             val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > > +                             HDMA_V0_STOP_INT_MASK |
> > > +                             HDMA_V0_ABORT_INT_MASK |
> > > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > > +                             HDMA_V0_LOCAL_ABORT_INT_EN;
> > > +
> > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > > +                     val |= HDMA_V0_REMOTE_STOP_INT_EN |
> > > +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> > > +             }
> > > +
> > > +             SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> > > +
> > > +             /* Channel control setup */
> > > +             val = GET_CH_32(dw, chan->dir, chan->id, control1);
> > > +             val &= ~HDMA_V0_LINKLIST_EN;
> > > +             SET_CH_32(dw, chan->dir, chan->id, control1, val);
> > > +
> > > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > +                       HDMA_V0_DOORBELL_START);
> > > +     }
> > > +}
> > > +
> > > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool
> > > +first) {
> > > +     struct dw_edma_chan *chan = chunk->chan;
> > > +
> > > +     if (!chan->non_ll)
> > > +             dw_hdma_v0_core_ll_start(chunk, first);
> > > +     else
> > > +             dw_hdma_v0_core_non_ll_start(chunk);
> > > +}
> > > +
> > >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)  {
> > >       struct dw_edma *dw = chan->dw;
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > index eab5fd7..7759ba9 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/dmaengine.h>
> > >
> > >  #define HDMA_V0_MAX_NR_CH                    8
> > > +#define HDMA_V0_CH_EN                                BIT(0)
> > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> > >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h index
> > > 3080747..78ce31b 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > >       enum dw_edma_map_format mf;
> > >
> > >       struct dw_edma          *dw;
> > > +     bool                    non_ll;
> > >  };
> > >
> > >  /* Export to the platform drivers */
> > > --
> > > 1.8.3.1
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

