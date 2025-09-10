Return-Path: <dmaengine+bounces-6444-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D7AB51F88
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 19:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625C85E7591
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF9320A36;
	Wed, 10 Sep 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRe4zWcM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C456258EC9;
	Wed, 10 Sep 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526999; cv=none; b=t/bkzjOCGHSCVD81og+QKGiEDXJ5wbeW5Oqr3goZvyVhRl9Jf2HB7khOzX/8fzYJUW58OA9VRnmLx09hfGO9cgyf9kPz8Wo+KWXzOqmPp3VvjAeP0cf1WcYZf2nMmc/lV0JOHoJBr38BfLVvU564BxUOKfyFs++3UiT0eUSJLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526999; c=relaxed/simple;
	bh=dfx1QaAI0kMvhYWbrVkmXlfwZKY2ldtz8H0dhNG7WB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fMSWoF37duoKf2ztpto+hkhqB9EpuBY8zdShtawCqlAZsX3x48oZucDzPUloe8HEwl9qrVfDl/oYNWvmQbQ+3DzzuwQ+OQO9t9rJX2Hm58nD4Cy60VE6nIwiEFqm+gHDsGoAK8to4DM0RcsVqpUE0ak6XGbxPkNr/e36ivsWArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRe4zWcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AD3C4CEEB;
	Wed, 10 Sep 2025 17:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757526998;
	bh=dfx1QaAI0kMvhYWbrVkmXlfwZKY2ldtz8H0dhNG7WB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jRe4zWcMZHGYVN74V/1AJ/RR2YxEknyGXojZPMJPAXKzCcUsWiYO7XK3pRkSWg/9H
	 +2fDQbPHhT/8ZjKfE5OWvhwZ1xfBaj68k5xQiSjAOvdX84b1dgC1EC7/20wvrPNHcA
	 jCKo676PQIRA938vU+osLyFjB3p6WfF6mWtMHbnLMPe+61M0sFF0OsSOkZP3AIQO0k
	 DRc6vwwAL8fUMqiz4Cw20Y4AxKihAd848QAKNyOhzt03TUZEKHkC8k1EIk6B+h2dhp
	 wi7XUzEXqldcZ+0qEddD6SbaF91V9KHJ1ymZAKeTZfUlS+9B8KKyQENONIHBsVt925
	 xPMz0GqWHu7Nw==
Date: Wed, 10 Sep 2025 12:56:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <20250910175637.GA1541229@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB81200F594C9B842C563F3DFE950EA@SA1PR12MB8120.namprd12.prod.outlook.com>

On Wed, Sep 10, 2025 at 12:30:39PM +0000, Verma, Devendra wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>

[redundant headers removed]

> > On Fri, Sep 05, 2025 at 03:46:59PM +0530, Devendra K Verma wrote:
> > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > The current code does not have the mechanisms to enable the DMA
> > > transactions using the non-LL mode. The following two cases are added
> > > with this patch:

> > > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > +                              struct dw_edma_pcie_data *pdata,
> > > +                              enum pci_barno bar) {
> > > +     if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> > > +             return pdata->phys_addr;
> > > +     return pci_bus_address(pdev, bar);
> >
> > This doesn't seem right.  pci_bus_address() returns
> > pci_bus_addr_t, so pdata->phys_addr should also be a
> > pci_bus_addr_t, and the function should return pci_bus_addr_t.
> >
> > A pci_bus_addr_t is not a "phys_addr"; it is an address that is
> > valid on the PCI side of a PCI host bridge, which may be different
> > than the CPU physical address on the CPU side of the bridge
> > because of things like IOMMUs.
> >
> > Seems like the struct dw_edma_region.paddr should be renamed to
> > something like "bus_addr" and made into a pci_bus_addr_t.
> 
> In case of AMD, it is not an address that is accessible from host
> via PCI, it is the device side DDR offset of physical address which
> is not known to host,that is why the VSEC capability is used to let
> know host of the DDR offset to correctly programming the LLP of DMA
> controller.  Without programming the LLP controller will not know
> from where to start reading the LL for DMA processing. DMA
> controller requires the physical address of LL present on its side
> of DDR.

I guess "device side DDR offset" means this Xilinx device has some DDR
internal to the PCI device, and the CPU cannot access it via a BAR?

But you need addresses inside that device DDR even though the CPU
can't access it, and the VSEC gives you the base address of the DDR?

This makes me wonder about how dw_edma_region is used elsewhere
because some of those places seem like they assume the CPU *can*
access this area.

dw_pcie_edma_ll_alloc() uses dmam_alloc_coherent(), which allocates
RAM and gives you a CPU virtual address (ll->vaddr.mem) and a DMA
address (ll->paddr).  dw_edma_pcie_probe() will later overwrite the
ll->paddr with the DDR offset based on VSEC.

But it sounds like ll->vaddr.mem is useless for Xilinx devices since
the CPU can't access the DDR?

If the CPU can't use ll->vaddr.mem, what happens in places like
dw_hdma_v0_write_ll_data() where we access it?

Bjorn

