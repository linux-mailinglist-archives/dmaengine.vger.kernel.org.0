Return-Path: <dmaengine+bounces-5752-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01C2AFE77F
	for <lists+dmaengine@lfdr.de>; Wed,  9 Jul 2025 13:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6FE6E0A78
	for <lists+dmaengine@lfdr.de>; Wed,  9 Jul 2025 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E22D6631;
	Wed,  9 Jul 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLnY2YD4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F62D6629;
	Wed,  9 Jul 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059868; cv=none; b=A/ViBIn1fx2JGG4aM6/1mUU8eE2fNtEoV+nhM0EBn7Eg3PNo1/i+laGod5hnhsoJXQl6EH9/3WN/pnacuGVgPEv+DKKuiNzIbSRExW6avhHeD/lnnA9OvigtKW47aRhyUxsCKTLxc5b9zodJ0eKZqyjM3F3aMhumyglTlyMryNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059868; c=relaxed/simple;
	bh=qiFpo4aWjkNV01oyl4o4tAaO61XVSJG4q2F1qca3ljU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0RMpM+d2aqYFAeH/Oq1EURdr4T/V3kg66vkDJpLZrN2lig4fV+6+a4De218wxJXiZ0i9OOVPcyMog53woS5l4rwoKWONDI/hNhkaFHMavCYGbgqEiY4yWAtVSTVN1LM5ehbrxnyf+C3g5ppHmAsGBaPki4jl76m+VLS7ibCfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLnY2YD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D262C4CEF7;
	Wed,  9 Jul 2025 11:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752059867;
	bh=qiFpo4aWjkNV01oyl4o4tAaO61XVSJG4q2F1qca3ljU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WLnY2YD4tRgwgHE5E7cV6sZ9pBFWaYEtwqlESV7ogZ5vDf7h++jwBrzQgIqgZooPn
	 8OuLXGbrtkNS6ANiNcmpUR2dMLXCKxSH0B6JsFalqD/wOnRhTd5N0KsOKgiFGdi3iL
	 Vm6KSsowCOhAPViGsgthmAigZsGT+Qaapryvkp8c3rCK2rE+9bHCtJtoXDABDoeIV1
	 JRFoeciAVREzM65239liUnVABedwFu1O9HJRQPp3gjQ71k0wxpwoEzTyyVOSR6lsGu
	 7D10Cza5mkJXhzHumPAcumFdIOqhj/Uzz7rLWirmvk8QLyVCkwxiSdNHMbTjehoCWe
	 zLnoYoqyG1TDw==
Date: Wed, 9 Jul 2025 16:47:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Abinash Singh <abinashlalotra@gmail.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Abinash Singh <abinashsinghlalotra@gmail.com>
Subject: Re: [PATCH RFC] dma: dw-edma: Fix build warning in
 dw_edma_pcie_probe()
Message-ID: <qxsh3sqy7wxra4saidnfofx5md2nkachytn7b4tz4e2p7y42ht@ektcwnnaurfo>
References: <20250705160055.808165-1-abinashsinghlalotra@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250705160055.808165-1-abinashsinghlalotra@gmail.com>

On Sat, Jul 05, 2025 at 09:30:55PM GMT, Abinash Singh wrote:
> The function dw_edma_pcie_probe() in dw-edma-pcie.c triggered a
> frame size warning:
> ld.lld:warning:
>   drivers/dma/dw-edma/dw-edma-pcie.c:162:0: stack frame size (1040) exceeds limit (1024) in function 'dw_edma_pcie_probe'
> 
> This patch reduces the stack usage by dynamically allocating the
> `vsec_data` structure using kmalloc(), rather than placing it on
> the stack. This eliminates the overflow warning and improves kernel
> robustness.
> 
> Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> The stack usage was further confirmed by using -fstack-usage flag.
> it was usiing 928 bytes:
> ..............................
> drivers/dma/dw-edma/dw-edma-pcie.c:377:cleanup_module   8       static
> drivers/dma/dw-edma/dw-edma-pcie.c:160:dw_edma_pcie_probe       928     static
> ......................................
> After applying the patch it becomes :
> .........
> drivers/dma/dw-edma/dw-edma-pcie.c:381:cleanup_module   8       static
> drivers/dma/dw-edma/dw-edma-pcie.c:160:dw_edma_pcie_probe       120     static
> .......
> 
> This function is used for probing . So dynamic allocation will not create
> any issues.
> 
> Thank You
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 60 ++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 49f09998e5c0..1536395eacd2 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -161,12 +161,16 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
>  	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
> -	struct dw_edma_pcie_data vsec_data;
> +	struct dw_edma_pcie_data *vsec_data __free(kfree) = NULL;
>  	struct device *dev = &pdev->dev;
>  	struct dw_edma_chip *chip;
>  	int err, nr_irqs;
>  	int i, mask;
>  
> +	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
> +	if (!vsec_data)
> +		return -ENOMEM;
> +
>  	/* Enable PCI device */
>  	err = pcim_enable_device(pdev);
>  	if (err) {
> @@ -174,23 +178,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		return err;
>  	}
>  
> -	memcpy(&vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
> +	memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));
>  
>  	/*
>  	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
>  	 * for the DMA, if one exists, then reconfigures it.
>  	 */
> -	dw_edma_pcie_get_vsec_dma_data(pdev, &vsec_data);
> +	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
>  
>  	/* Mapping PCI BAR regions */
> -	mask = BIT(vsec_data.rg.bar);
> -	for (i = 0; i < vsec_data.wr_ch_cnt; i++) {
> -		mask |= BIT(vsec_data.ll_wr[i].bar);
> -		mask |= BIT(vsec_data.dt_wr[i].bar);
> +	mask = BIT(vsec_data->rg.bar);
> +	for (i = 0; i < vsec_data->wr_ch_cnt; i++) {
> +		mask |= BIT(vsec_data->ll_wr[i].bar);
> +		mask |= BIT(vsec_data->dt_wr[i].bar);
>  	}
> -	for (i = 0; i < vsec_data.rd_ch_cnt; i++) {
> -		mask |= BIT(vsec_data.ll_rd[i].bar);
> -		mask |= BIT(vsec_data.dt_rd[i].bar);
> +	for (i = 0; i < vsec_data->rd_ch_cnt; i++) {
> +		mask |= BIT(vsec_data->ll_rd[i].bar);
> +		mask |= BIT(vsec_data->dt_rd[i].bar);
>  	}
>  	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
>  	if (err) {
> @@ -213,7 +217,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		return -ENOMEM;
>  
>  	/* IRQs allocation */
> -	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
> +	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
>  					PCI_IRQ_MSI | PCI_IRQ_MSIX);
>  	if (nr_irqs < 1) {
>  		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=%u)\n",
> @@ -224,22 +228,22 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	/* Data structure initialization */
>  	chip->dev = dev;
>  
> -	chip->mf = vsec_data.mf;
> +	chip->mf = vsec_data->mf;
>  	chip->nr_irqs = nr_irqs;
>  	chip->ops = &dw_edma_pcie_plat_ops;
>  
> -	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
> -	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
> +	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
> +	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
>  
> -	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> +	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
>  	if (!chip->reg_base)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < chip->ll_wr_cnt; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
> -		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
> -		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
> +		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
> +		struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
>  
>  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
>  		if (!ll_region->vaddr.io)
> @@ -263,8 +267,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	for (i = 0; i < chip->ll_rd_cnt; i++) {
>  		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
>  		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
> -		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
> -		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
> +		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
> +		struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
>  
>  		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
>  		if (!ll_region->vaddr.io)
> @@ -298,31 +302,31 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
>  
>  	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
> -		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
> +		vsec_data->rg.bar, vsec_data->rg.off, vsec_data->rg.sz,
>  		chip->reg_base);
>  
>  
>  	for (i = 0; i < chip->ll_wr_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> -			i, vsec_data.ll_wr[i].bar,
> -			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
> +			i, vsec_data->ll_wr[i].bar,
> +			vsec_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
>  			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
>  
>  		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> -			i, vsec_data.dt_wr[i].bar,
> -			vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
> +			i, vsec_data->dt_wr[i].bar,
> +			vsec_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
>  			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
>  	}
>  
>  	for (i = 0; i < chip->ll_rd_cnt; i++) {
>  		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> -			i, vsec_data.ll_rd[i].bar,
> -			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
> +			i, vsec_data->ll_rd[i].bar,
> +			vsec_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
>  			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
>  
>  		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
> -			i, vsec_data.dt_rd[i].bar,
> -			vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
> +			i, vsec_data->dt_rd[i].bar,
> +			vsec_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
>  			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
>  	}
>  
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

