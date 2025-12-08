Return-Path: <dmaengine+bounces-7531-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9A1CAC6FE
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 08:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB9033011755
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24D02D47FF;
	Mon,  8 Dec 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCcZSls7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B01EF0B0;
	Mon,  8 Dec 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765180648; cv=none; b=ZBlwtKfSTaC6XMRGrQMP6ctjQBynMC/EpA6owCVlrLQdqrdBs4FatNAHX5a5zNX/EyEZBTcYt8+OlYSlTL0vu/iE1WoVtYn87rrJDH001WL3w4p2SuE3A4NCRAEuuUpsSVLQE03O+IlwbbPm10uREGAE9KPzdmXO4YHU1xPlEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765180648; c=relaxed/simple;
	bh=j8oWjVwkHFBC1tJGURNhcjmPeuMGWK1e31YVEBQPuqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j66RnKfswRTsI5YrYD/UpyeVbVfs4PliVpM0Fu/tOb25xh4iYfa094EXB56RNKf7+87vp/SqLBTCQTaG4sBypwAki+9IF7UlInDFrbK2KjlZo9TkWl9zVWHwr6exRE8CNJVlzAszhViTBF0JmdpAODl+tYg+dq49rDfTioIQqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCcZSls7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AFDC4CEF1;
	Mon,  8 Dec 2025 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765180647;
	bh=j8oWjVwkHFBC1tJGURNhcjmPeuMGWK1e31YVEBQPuqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCcZSls7ka97pwp7Rf7eGBZh3+91dhPxfBm6p9JsQyjzGu1W5FXNe9F3bWqaRyoVT
	 WbdR4xtURGD6VKp4nGgW3ECjaDHHB7G6wfekV1H/pp6TEDGNXRDmK4fNOo3EEAg2Pk
	 8F4b1ZiLz3VHxj62fzkq3VPUIhEJWUBT6zVxEXR4/lj37zZ4QCWho25ZXvAkf3UHIx
	 Y31efflkKCbp24gHOQ9jYoBMzOLkW2DxB43i+qbD51/vuM5PJ4gdSaTfkyVu0HYY3z
	 OLEpQEyGgnWPz7lAIr+KRkfJPA0tDF75lcCsCQyQuIG1HPghqXsYoyZAD8iUI/z3yW
	 wzuW2dR49lFxw==
Date: Mon, 8 Dec 2025 08:57:19 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com, mani@kernel.org, kwilczynski@kernel.org,
	kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net,
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
	arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aTaE3yB7tQ-Homju@ryzen>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251129160405.2568284-20-den@valinux.co.jp>

On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> for the MSI target address on every interrupt and tears it down again
> via dw_pcie_ep_unmap_addr().
> 
> On systems that heavily use the AXI bridge interface (for example when
> the integrated eDMA engine is active), this means the outbound iATU
> registers are updated while traffic is in flight. The DesignWare
> endpoint spec warns that updating iATU registers in this situation is
> not supported, and the behavior is undefined.
> 
> Under high MSI and eDMA load this pattern results in occasional bogus
> outbound transactions and IOMMU faults such as:
> 
>   ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
> 
> followed by the system becoming unresponsive. This is the actual output
> observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.
> 
> There is no need to reprogram the iATU region used for MSI on every
> interrupt. The host-provided MSI address is stable while MSI is enabled,
> and the endpoint driver already dedicates a scratch buffer for MSI
> generation.
> 
> Cache the aligned MSI address and map size, program the outbound iATU
> once, and keep the window enabled. Subsequent interrupts only perform a
> write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
> the hot path and fixing the lockups seen under load.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
>  2 files changed, 47 insertions(+), 6 deletions(-)
> 

I don't like that this patch modifies dw_pcie_ep_raise_msi_irq() but does
not modify dw_pcie_ep_raise_msix_irq()

both functions call dw_pcie_ep_map_addr() before doing the writel(),
so I think they should be treated the same.


I do however understand that it is a bit wasteful to dedicate one
outbound iATU for MSI and one outbound iATU for MSI-X, as the PCI
spec does not allow both of them to be enabled at the same PCI,
see:

6.1.4 MSI and MSI-X Operation § in PCIe 6.0 spec:
"A Function is permitted to implement both MSI and MSI-X,
but system software is prohibited from enabling both at the
same time. If system software enables both at the same time,
the behavior is undefined."


I guess the problem is that some EPF drivers, even if only
one capability can be enabled (MSI/MSI-X), call both
pci_epc_set_msi() and pci_epc_set_msix(), e.g.:
https://github.com/torvalds/linux/blob/v6.18/drivers/pci/endpoint/functions/pci-epf-test.c#L969-L987

To fill in the number of MSI/MSI-X irqs.

While other EPF drivers only call either pci_epc_set_msi() or
pci_epc_set_msix(), depending on the IRQ type that will actually
be used:
https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L2247-L2262

I think both versions is okay, just because the number of IRQs
is filled in for both MSI/MSI-X, AFAICT, only one of them will
get enabled.


I guess it might be hard for an EPC driver to know which capability
that is currently enabled, as to enable a capability is only a config
space write by the host side.

I guess in most real hardware, e.g. a NIC device, you do an
"enable engine"/"stop enginge" type of write to a BAR.

Perhaps we should have similar callbacks in struct pci_epc_ops ?

My thinking is that after "start engine", an EPC driver could read
the MSI and MSI-X capabilities, to see which is enabled.
As it should not be allowed to change between MSI and MSI-X without
doing a "stop engine" first.


Kind regards,
Niklas

