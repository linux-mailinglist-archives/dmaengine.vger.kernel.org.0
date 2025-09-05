Return-Path: <dmaengine+bounces-6421-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9A2B46323
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 21:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8996B7C740D
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3F315D52;
	Fri,  5 Sep 2025 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpaJIlUN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA5315D22;
	Fri,  5 Sep 2025 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099183; cv=none; b=omXfxwQtH6Wi8gitf2Wh0mTS2HACygx4GDowD2Uro+K1IxNGeWe47C94w2Td/Qztjb+OG4USmnJf+pJ/ZmAWp+pNheM4fceHY6IGXaSZ8UJYYYYOJ/W3BxXoY5oHEnhJpmC2gFJC1WPiZS/bnArUCRPo46qMefvjRmfkRk6S+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099183; c=relaxed/simple;
	bh=dWbtCTPv7/HyKpTriCzGQwV15g/46tnLdeWiSBuQqmE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fVq2jwYfUba9DXvMH9c62lJz+pNAp3JCEu+h3VbF16GA4zTBXXo5ZG19we4LM7nNUEFcvCnAdae1/ygwy9QLR/TJyV4UBCIsa3f8NU7iuyJmKvyjYoAFss7TQdNAoHr0iJJ9EMqeLDat7GssFPpcX4d7sN0A4EGCtrizXLFDfNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpaJIlUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EA1C4CEF1;
	Fri,  5 Sep 2025 19:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757099182;
	bh=dWbtCTPv7/HyKpTriCzGQwV15g/46tnLdeWiSBuQqmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rpaJIlUNlgXmx63FhVxMTcxEC5aBPzMRmGNXexM6772Z5oIfb6zjQTyaD5+jrmecd
	 xBveoTr4plZF9+uYP/FWkNJg7tQo1uIgJqYkUY/+y11Wqh+1c14Ncrsn8bvkySQod/
	 NVo0pvIIYGDqV5zjSEy6KeKnckQ1EtJfN7OsR6+IPsSgH+5f13PbUx4nGhoTVhFjgg
	 WPrby0+mjKxFc8EA/2O0BWqL3IAi1an8jg0k0RNzZMC4cCpFlxG6CqOniAc2o0PNxm
	 DbleahZMfUkj8cx3g9XOzQz0MgTGAP0QWZIFMz8bBle0ErLgWoB+DKakQh/Qgd0eLM
	 rioQEcZGCOEww==
Date: Fri, 5 Sep 2025 14:06:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <20250905190621.GA1306997@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905101659.95700-3-devendra.verma@amd.com>

On Fri, Sep 05, 2025 at 03:46:59PM +0530, Devendra K Verma wrote:
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
>   Link List.

> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -223,8 +223,28 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	int nollp = 0;
> +
> +	if (WARN_ON(config->peripheral_config &&
> +		    config->peripheral_size != sizeof(int)))
> +		return -EINVAL;
>  
>  	memcpy(&chan->config, config, sizeof(*config));
> +
> +	/*
> +	 * When there is no valid LLP base address available
> +	 * then the default DMA ops will use the non-LL mode.
> +	 * Cases where LL mode is enabled and client wants
> +	 * to use the non-LL mode then also client can do
> +	 * so via the providing the peripheral_config param.

s/via the/via/

> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -224,6 +224,15 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
>  	pdata->phys_addr = off;
>  }
>  
> +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> +				 struct dw_edma_pcie_data *pdata,
> +				 enum pci_barno bar)
> +{
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> +		return pdata->phys_addr;
> +	return pci_bus_address(pdev, bar);

This doesn't seem right.  pci_bus_address() returns pci_bus_addr_t, so
pdata->phys_addr should also be a pci_bus_addr_t, and the function
should return pci_bus_addr_t.

A pci_bus_addr_t is not a "phys_addr"; it is an address that is valid
on the PCI side of a PCI host bridge, which may be different than the
CPU physical address on the CPU side of the bridge because of things
like IOMMUs.

Seems like the struct dw_edma_region.paddr should be renamed to
something like "bus_addr" and made into a pci_bus_addr_t.

Bjorn

