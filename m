Return-Path: <dmaengine+bounces-6456-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD4B53E28
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 23:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204143B79D0
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 21:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7FB258EC9;
	Thu, 11 Sep 2025 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1cIU9mF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044BB1957FC;
	Thu, 11 Sep 2025 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627629; cv=none; b=PZr/EUuiiXspzm7Mj16N4vU6LghpRxxOsJRDuRcQKQqVlNz1bWPDkOisEGWHhpXUZOjSAdK03iPMOzkgRaRKId20LFj7whvyhLexYl960Sm9sxdwHEsT5O5bJZzNiGFaCSayd2eEASWDrN/gpvduyDFxdO33g60THEUxmXPqpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627629; c=relaxed/simple;
	bh=1TNKDOxG2GqpKo5rO+DaIjNngyRXhVq03oruUJ+w3S8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a00f6AIwKe5XxxvXCea1lDIQGeccFsAugFLcnUFcPC1c6ZzQnAsAGd8/ilP8fa2+fh5ArhiDYJQ5fN2/GZRO/zHUCHkCXdmOmLDSmRZaWRcdZ86YdPoQEzcG2U/Stgiguyh/mIOcmDQFS85QzNnhCaG2oA3XMPdc2ybHv5Ib3RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1cIU9mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F39C4CEF0;
	Thu, 11 Sep 2025 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757627628;
	bh=1TNKDOxG2GqpKo5rO+DaIjNngyRXhVq03oruUJ+w3S8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X1cIU9mFeBbZKTDPsVZlraneuD33Wjjd9PJIvOGFA7N2kWpyKDc8sMoXMFC0DEIQ2
	 uFMn9MOUjm9mrkSPkSMqaq40+nECes8VDHHkSYFzMfehbyO0WKOGpViTW0kbVyjyuI
	 bDCNFb/x23dFfbBNPkDDW+I4SDTc5BlcXqETvk+BxD69anKKZfnBBLOQxh8gKBbKpo
	 LymkF5l7TZttahNm5VkcFF4amr6Wkf7UkAqdw6ZyrdMLtjqX5fjWomF84grO550gxk
	 yZ2rGXumI4/Qy6/Xzz/w3mDp1/0VImbVIU8Zw6v/O/SUfluKnLWScUHpORK5ol1pzj
	 Eyj49Xneioz9Q==
Date: Thu, 11 Sep 2025 16:53:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v1 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <20250911215347.GA1594166@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911114451.15947-3-devendra.verma@amd.com>

On Thu, Sep 11, 2025 at 05:14:51PM +0530, Devendra K Verma wrote:
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

> +static pci_bus_addr_t dw_edma_get_phys_addr(struct pci_dev *pdev,
> +					    struct dw_edma_pcie_data *pdata,
> +					    enum pci_barno bar)
> +{
> +	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> +		return pdata->devmem_phys_off;
> +	return pci_bus_address(pdev, bar);

Does this imply that non-Xilinx devices don't have the iATU that
translates a PCI bus address to an internal device address?

> +}

