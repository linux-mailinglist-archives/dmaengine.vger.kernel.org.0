Return-Path: <dmaengine+bounces-6454-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB0B53D37
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 22:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F5D3A8240
	for <lists+dmaengine@lfdr.de>; Thu, 11 Sep 2025 20:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F309A2C236B;
	Thu, 11 Sep 2025 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcrG6NH0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76AB2DC77C;
	Thu, 11 Sep 2025 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623422; cv=none; b=CDz5AoSFDSAMkq8TpehqwwYAeNOWGmxVblE/Nyg32wrMCbGa9ToFaKABAtbLi4JKYyqISxlaD7K6Hlz+dgnn346o5eNyVo3qVy0GUUDl+YHmLkoCGU9UyghLMZwgWU6vTK1mT75NfwvuN17Lf0WrtIGoD/FVDZQPjjKf9byYqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623422; c=relaxed/simple;
	bh=5jfTK8qp37ri/0OUIgzUb+MsW/3Rl3jCY4BUaO8ZRk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gr9xXmG35+3tpulBw78F5Zix/qYaGDwADT8ymiD71TcGmk2iLTsvfa0VG+BLp11K4DBdLIq0V/nVc9MIFCkBxKNoew6qM10GSmZUmAR+G5iT9Vhq9HiaPxgBCOg4/4BIg09iyl4YsfBNx5/BQGn/bapBU4FQ3RR7aSiN8zEI4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcrG6NH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454FEC4CEF0;
	Thu, 11 Sep 2025 20:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757623422;
	bh=5jfTK8qp37ri/0OUIgzUb+MsW/3Rl3jCY4BUaO8ZRk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XcrG6NH0QU8sxJwMSCVQ8O1tF/RhSxEzF48HPagONuJ0RGiZ73/oKqRhbJr1t/RmI
	 ZxlerT6npf6usu9olJV4ZOOnNOXBQBuxMZ9zx57ZjBwU2nxDC1bycQagKEHrYacU1o
	 YMC2/Femf2nYL3dOm8WBzuaYDhZicOOrw+bFO6L7n6FfL0umfy1QYEWhrnD8V1sMtb
	 Id27n2rZCUwzDUdhg0b7o6sNGwK4BWl7FrZBGpuBSs4iK9bjQ8md3/9MkjVY/5EyLa
	 R7gCTBPXxfdGxkdzQw+gTpW9UK1/ljvfHUf3FB+EqpxNiejr9uu+GcZaOx8/qItWFi
	 nJh5fRysOE7/w==
Date: Thu, 11 Sep 2025 15:43:40 -0500
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
Message-ID: <20250911204340.GA1584422@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB812027AB20BEE7C28F30A5FE9509A@SA1PR12MB8120.namprd12.prod.outlook.com>

On Thu, Sep 11, 2025 at 11:42:31AM +0000, Verma, Devendra wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>

> > On Wed, Sep 10, 2025 at 12:30:39PM +0000, Verma, Devendra wrote:
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> >
> > [redundant headers removed]
> >
> > > > On Fri, Sep 05, 2025 at 03:46:59PM +0530, Devendra K Verma wrote:
> > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > > The current code does not have the mechanisms to enable the DMA
> > > > > transactions using the non-LL mode. The following two cases are
> > > > > added with this patch:
> >
> > > > > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > > > +                              struct dw_edma_pcie_data *pdata,
> > > > > +                              enum pci_barno bar) {
> > > > > +     if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> > > > > +             return pdata->phys_addr;
> > > > > +     return pci_bus_address(pdev, bar);
> > > >
> > > > This doesn't seem right.  pci_bus_address() returns pci_bus_addr_t,
> > > > so pdata->phys_addr should also be a pci_bus_addr_t, and the
> > > > function should return pci_bus_addr_t.
> > > >
> > > > A pci_bus_addr_t is not a "phys_addr"; it is an address that is
> > > > valid on the PCI side of a PCI host bridge, which may be different
> > > > than the CPU physical address on the CPU side of the bridge because
> > > > of things like IOMMUs.
> > > >
> > > > Seems like the struct dw_edma_region.paddr should be renamed to
> > > > something like "bus_addr" and made into a pci_bus_addr_t.
> > >
> > > In case of AMD, it is not an address that is accessible from host via
> > > PCI, it is the device side DDR offset of physical address which is not
> > > known to host,that is why the VSEC capability is used to let know host
> > > of the DDR offset to correctly programming the LLP of DMA controller.
> > > Without programming the LLP controller will not know from where to
> > > start reading the LL for DMA processing. DMA controller requires the
> > > physical address of LL present on its side of DDR.
> >
> > I guess "device side DDR offset" means this Xilinx device has some
> > DDR internal to the PCI device, and the CPU cannot access it via a
> > BAR?
> 
> The host can access the DDR internal to the PCI device via BAR, but
> it involves an iATU translation. The host can use the virtual /
> physical address to access that DDR.  The issue is not with the host
> rather DMA controller which does not understand the physical address
> provided by the host, eg, the address returned by pci_bus_addr(pdev,
> barno).

Does this mean dw_edma_get_phys_addr() depends on iATU programming
done by the PCI controller driver?  Is it possible for that driver to
change the iATU programming after dw_edma_get_phys_addr() in a way
that breaks this?

Bjorn

