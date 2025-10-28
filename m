Return-Path: <dmaengine+bounces-7022-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E219EC14DDA
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 14:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D8334FD0C3
	for <lists+dmaengine@lfdr.de>; Tue, 28 Oct 2025 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A55333734;
	Tue, 28 Oct 2025 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOHxgh6L"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A83009FA;
	Tue, 28 Oct 2025 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658362; cv=none; b=dFS/GpnopN1ffreoG/D+4TI5qn9YWE2fD52hA+l/9c5qKgzbE7r5CXdfD7BsdKSAgBkbMOyjjTPSpbIiv3twaS6V/gjQWxdX60eRHQlqp9LiLyZqDeM6b0hbsVffEAGjY6F+Fj6hpD8QrN1sRneiI7m30uX2WTf3Zl2QcakMNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658362; c=relaxed/simple;
	bh=hFDob0VQtTTXin4OiLiVcRRlBB3AMs70s0Y1t84BVAI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MGelj4Cqjl7H+hK2h3uQvA6DyafeOKAjGBXNyLQvchoQ/MkYwsfXmFI9EypfNYXV1AqLDGcIMPRfn71jnH+aXrNT4VMwUNk9TLQisNvT6d/+T9kpdw9eVpN1TM/Kj9d/YYCEIdIDZ/n7WNMOaNk0p/t6TiIcdgvFbzuet2fCNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOHxgh6L; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761658360; x=1793194360;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hFDob0VQtTTXin4OiLiVcRRlBB3AMs70s0Y1t84BVAI=;
  b=kOHxgh6L060ncKclW+9nGYzkh6xwezSnIhFesZwP+1+jmHnXjh8M58Nd
   ec25Y+2tJBRqG1fS6L5uJCrZ+rk7kxn0CSnDX8iIgej2PfPVlVWeiTDwA
   uIddHES194PfIF6Td983JtSY1yB6p6jr9dFM1isLizojI1ty6vOsAWn9Y
   203sCINZFKEDYNoZO0UkmN3xGFdkHojIpDgBztK+EkNJwZmv/cbQI8v79
   rGHyWuldpZoJarhFdfv16qx28bMLo+lW4ToqlUGoqBCiiG+3h5kM8GeXi
   L7jwFZrOHBwl57NbsPWzX8TXWZemQcEQwnBtNLyGRqgOpnXKJvhbr2+fc
   w==;
X-CSE-ConnectionGUID: 7zKjJQ/aS/ercLS0K8Fesw==
X-CSE-MsgGUID: 7/vF3qn/RgSKa2sZxT9W/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74043225"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="74043225"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 06:32:39 -0700
X-CSE-ConnectionGUID: m2QdbbtMQluqwNfyGl5fcQ==
X-CSE-MsgGUID: rNOV0AJCQCyx8hy8t4KbCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="208942353"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 06:32:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 Oct 2025 15:32:32 +0200 (EET)
To: Devendra K Verma <devendra.verma@amd.com>
cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org, 
    dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, michal.simek@amd.com
Subject: Re: [PATCH v5 2/2] dmaengine: dw-edma: Add non-LL mode
In-Reply-To: <20251028112858.9930-3-devendra.verma@amd.com>
Message-ID: <c5f6bdd8-417a-c360-eb62-c7e9409caf7f@linux.intel.com>
References: <20251028112858.9930-1-devendra.verma@amd.com> <20251028112858.9930-3-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Oct 2025, Devendra K Verma wrote:

> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> The current code does not have the mechanisms to enable the
> DMA transactions using the non-LL mode. The following two cases
> are added with this patch:
> - When a valid physical base address is not configured via the
>   Xilinx VSEC capability then the IP can still be used in non-LL
>   mode. The default mode for all the DMA transactions and for all
>   the DMA channels then is non-LL mode.
> - When a valid physical base address is configured but the client
>   wants to use the non-LL mode for DMA transactions then also the
>   flexibility is provided via the peripheral_config struct member of
>   dma_slave_config. In this case the channels can be individually
>   configured in non-LL mode. This use case is desirable for single
>   DMA transfer of a chunk, this saves the effort of preparing the
>   Link List. This particular scenario is applicable to AMD as well
>   as Synopsys IP.
> 
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v5
>   Variable name 'nollp' changed to 'non_ll'.
>   In the dw_edma_device_config() WARN_ON replaced with dev_err().
>   Comments follow the 80-column guideline.
> 
> Changes in v4
>   No change
> 
> Changes in v3
>   No change
> 
> Changes in v2
>   Reverted the function return type to u64 for
>   dw_edma_get_phys_addr().
> 
> Changes in v1
>   Changed the function return type for dw_edma_get_phys_addr().
>   Corrected the typo raised in review.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 41 ++++++++++++++++++++---
>  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
>  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++++++--------
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 62 ++++++++++++++++++++++++++++++++++-
>  include/linux/dma/edma.h              |  1 +
>  5 files changed, 130 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index b43255f..60a3279 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -223,8 +223,31 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	int non_ll = 0;
> +
> +	if (config->peripheral_config &&
> +	    config->peripheral_size != sizeof(int)) {
> +		dev_err(dchan->device->dev,
> +			"config param peripheral size mismatch\n");
> +		return -EINVAL;
> +	}
>  
>  	memcpy(&chan->config, config, sizeof(*config));
> +
> +	/*
> +	 * When there is no valid LLP base address available then the default
> +	 * DMA ops will use the non-LL mode.
> +	 * Cases where LL mode is enabled and client wants to use the non-LL
> +	 * mode then also client can do so via providing the peripheral_config
> +	 * param.
> +	 */
> +	if (config->peripheral_config)
> +		non_ll = *(int *)config->peripheral_config;
> +
> +	chan->non_ll = false;
> +	if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))
> +		chan->non_ll = true;
> +
>  	chan->configured = true;
>  
>  	return 0;
> @@ -353,7 +376,7 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
>  	enum dma_transfer_direction dir = xfer->direction;
>  	struct scatterlist *sg = NULL;
> -	struct dw_edma_chunk *chunk;
> +	struct dw_edma_chunk *chunk = NULL;
>  	struct dw_edma_burst *burst;
>  	struct dw_edma_desc *desc;
>  	u64 src_addr, dst_addr;
> @@ -419,9 +442,11 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
>  	if (unlikely(!desc))
>  		goto err_alloc;
>  
> -	chunk = dw_edma_alloc_chunk(desc);
> -	if (unlikely(!chunk))
> -		goto err_alloc;
> +	if (!chan->non_ll) {
> +		chunk = dw_edma_alloc_chunk(desc);
> +		if (unlikely(!chunk))
> +			goto err_alloc;
> +	}
>  
>  	if (xfer->type == EDMA_XFER_INTERLEAVED) {
>  		src_addr = xfer->xfer.il->src_start;
> @@ -450,7 +475,13 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
>  		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
>  			break;
>  
> -		if (chunk->bursts_alloc == chan->ll_max) {
> +		/*
> +		 * For non-LL mode, only a single burst can be handled
> +		 * in a single chunk unlike LL mode where multiple bursts
> +		 * can be configured in a single chunk.
> +		 */
> +		if ((chunk && chunk->bursts_alloc == chan->ll_max) ||
> +		    chan->non_ll) {
>  			chunk = dw_edma_alloc_chunk(desc);
>  			if (unlikely(!chunk))
>  				goto err_alloc;
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 71894b9..c8e3d19 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -86,6 +86,7 @@ struct dw_edma_chan {
>  	u8				configured;
>  
>  	struct dma_slave_config		config;
> +	bool				non_ll;
>  };
>  
>  struct dw_edma_irq {
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 7b991a0..b02977c 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -268,6 +268,15 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	pdata->devmem_phys_off = off;
>  }
>  
> +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> +				 struct dw_edma_pcie_data *pdata,
> +				 enum pci_barno bar)
> +{
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> +		return pdata->devmem_phys_off;
> +	return pci_bus_address(pdev, bar);
> +}
> +
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> @@ -277,6 +286,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_chip *chip;
>  	int err, nr_irqs;
>  	int i, mask;
> +	bool non_ll = false;
>  
>  	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
>  	if (!vsec_data)
> @@ -301,21 +311,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
>  		/*
>  		 * There is no valid address found for the LL memory
> -		 * space on the device side.
> +		 * space on the device side. In the absence of LL base
> +		 * address use the non-LL mode or simple mode supported by
> +		 * the HDMA IP.
>  		 */
>  		if (vsec_data->devmem_phys_off == DW_PCIE_AMD_MDB_INVALID_ADDR)
> -			return -ENOMEM;
> +			non_ll = true;
>  
>  		/*
>  		 * Configure the channel LL and data blocks if number of
>  		 * channels enabled in VSEC capability are more than the
>  		 * channels configured in amd_mdb_data.
>  		 */
> -		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> -					       DW_PCIE_XILINX_LL_OFF_GAP,
> -					       DW_PCIE_XILINX_LL_SIZE,
> -					       DW_PCIE_XILINX_DT_OFF_GAP,
> -					       DW_PCIE_XILINX_DT_SIZE);
> +		if (!non_ll)
> +			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> +						       DW_PCIE_XILINX_LL_OFF_GAP,
> +						       DW_PCIE_XILINX_LL_SIZE,
> +						       DW_PCIE_XILINX_DT_OFF_GAP,
> +						       DW_PCIE_XILINX_DT_SIZE);
>  	}
>  
>  	/* Mapping PCI BAR regions */
> @@ -363,6 +376,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->mf = vsec_data->mf;
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_plat_ops;
> +	chip->non_ll = non_ll;
>  
>  	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
> @@ -371,7 +385,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	if (!chip->reg_base)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < chip->ll_wr_cnt; i++) {
> +	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
>  		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
> @@ -382,7 +396,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>  
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> +		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>  
> @@ -391,12 +406,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>  
>  		dt_region->vaddr.io += dt_block->off;
> -		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> +		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
>  
> -	for (i = 0; i < chip->ll_rd_cnt; i++) {
> +	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
>  		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
> @@ -407,7 +423,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>  
>  		ll_region->vaddr.io += ll_block->off;
> -		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
> +		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 ll_block->bar);
>  		ll_region->paddr += ll_block->off;
>  		ll_region->sz = ll_block->sz;
>  
> @@ -416,7 +433,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;
>  
>  		dt_region->vaddr.io += dt_block->off;
> -		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
> +		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
> +							 dt_block->bar);
>  		dt_region->paddr += dt_block->off;
>  		dt_region->sz = dt_block->sz;
>  	}
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index e3f8db4..47ecc84 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
>  		readl(chunk->ll_region.vaddr.io);
>  }
>  
> -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
>  {
>  	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma *dw = chan->dw;
> @@ -263,6 +263,66 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
>  }
>  
> +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +	struct dw_edma *dw = chan->dw;
> +	struct dw_edma_burst *child;
> +	u32 val;
> +
> +	list_for_each_entry(child, &chunk->burst->list, list) {
> +		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));

Please name BIT(0) with a define.

> +
> +		/* Source address */
> +		SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> +			  lower_32_bits(child->sar));
> +		SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> +			  upper_32_bits(child->sar));
> +
> +		/* Destination address */
> +		SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> +			  lower_32_bits(child->dar));
> +		SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> +			  upper_32_bits(child->dar));
> +
> +		/* Transfer size */
> +		SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
> +
> +		/* Interrupt setup */
> +		val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> +				HDMA_V0_STOP_INT_MASK |
> +				HDMA_V0_ABORT_INT_MASK |
> +				HDMA_V0_LOCAL_STOP_INT_EN |
> +				HDMA_V0_LOCAL_ABORT_INT_EN;
> +
> +		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> +			val |= HDMA_V0_REMOTE_STOP_INT_EN |
> +			       HDMA_V0_REMOTE_ABORT_INT_EN;
> +		}
> +
> +		SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> +
> +		/* Channel control setup */
> +		val = GET_CH_32(dw, chan->dir, chan->id, control1);
> +		val &= ~HDMA_V0_LINKLIST_EN;
> +		SET_CH_32(dw, chan->dir, chan->id, control1, val);
> +
> +		/* Ring the doorbell */
> +		SET_CH_32(dw, chan->dir, chan->id, doorbell,
> +			  HDMA_V0_DOORBELL_START);

Doesn't the code explain itself already, why you need to have that comment 
above it, it doesn't seem to add any real value?

> +	}
> +}
> +
> +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> +{
> +	struct dw_edma_chan *chan = chunk->chan;
> +
> +	if (!chan->non_ll)
> +		dw_hdma_v0_core_ll_start(chunk, first);
> +	else
> +		dw_hdma_v0_core_non_ll_start(chunk);
> +}
> +
>  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  {
>  	struct dw_edma *dw = chan->dw;
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3080747..78ce31b 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -99,6 +99,7 @@ struct dw_edma_chip {
>  	enum dw_edma_map_format	mf;
>  
>  	struct dw_edma		*dw;
> +	bool			non_ll;
>  };
>  
>  /* Export to the platform drivers */
> 

-- 
 i.


