Return-Path: <dmaengine+bounces-6443-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFF6B51E38
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA05F583856
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBFB2798F8;
	Wed, 10 Sep 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gke1Yb9w"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940862797A9;
	Wed, 10 Sep 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522954; cv=none; b=r4PLAZAg74hl4OhwsXxtLK2wQkt4nZ8JPr/N1aCIkycCG5h+uO0pFOwyof28tGqTp+O23MSDVmzbzXQxuibJKNeH/Os85kus66tavtkz8wbdRhJdTc5DnTeqVltZM4L1oh49RS8O6dVvXuAuoumyAdQvzlVQk4h2IpbSNvz3Xs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522954; c=relaxed/simple;
	bh=WP/WCzco2EhFkx9bRYe7aQR1RWSdm1plG74aSwV7vZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NxLgDRVPujCmP7nkhR0xLP/quMNysQ1hndyCPcRbvOMjl4zPo1MoowV/ZMkarR7nppcWxnArtUrwO9vecf1+uAETwtRlc5nxsQxCmzTxQZ0m4yXZPqVtYu086JMujUyZ+IqaDRmwjKrAbc/yjq7BJLy2FAssMeLqnAcVRFdlr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gke1Yb9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F90C4CEEB;
	Wed, 10 Sep 2025 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522954;
	bh=WP/WCzco2EhFkx9bRYe7aQR1RWSdm1plG74aSwV7vZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gke1Yb9wWDd8SOWgyCyZmWYQcdKIT4HvDV+yxhKIKem5CdHFSA0pdS+/99VKZtVG8
	 qCDrZVI/75x78JOQMwNRT4eXKJnvUm4+BxO+2lqHsEXSvTtTGRfDqKh80qRUgDRcWX
	 1Vuq321x9Z0Zc5QFuidzAooL0TMPe61jz4oFAO5Wpn4wb460XuIl+y073D9RGTrX9C
	 4rS+zTwyvtvZugCfZkgGRYXSlTWreQCD6EMYSGB6QiQ+plYz97uTgsJ1vX0U82UUor
	 TEtzrqDjc70KIVu6IdyeWZLtX28iPtQx1S7BgAfo2UGGm3kDCiizk7YNVazDfsEKsi
	 lsUtE6ifyK4FQ==
Date: Wed, 10 Sep 2025 11:49:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <20250910164912.GA1540975@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120B9D69376F56AD2540E15950EA@SA1PR12MB8120.namprd12.prod.outlook.com>

On Wed, Sep 10, 2025 at 12:28:40PM +0000, Verma, Devendra wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>

[redundant quoted headers removed]

> > On Fri, Sep 05, 2025 at 03:46:58PM +0530, Devendra K Verma wrote:
> > > AMD MDB PCIe endpoint support. For AMD specific support added the
> > > following
> > >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> > >   - AMD MDB specific driver data
> > >   - AMD MDB specific VSEC capability to retrieve the device DDR
> > >     base address.

> > > static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
> > >       u32 val, map;
> > >       u16 vsec;
> > >       u64 off;
> > > +     u16 vendor;
> > >
> > > -     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> > > -                                     DW_PCIE_VSEC_DMA_ID);
> > > +     vendor = pdev->vendor;
> > > +     if (vendor != PCI_VENDOR_ID_SYNOPSYS &&
> > > +         vendor != PCI_VENDOR_ID_XILINX)
> > > +             return;
> > > +
> > > +     vsec = pci_find_vsec_capability(pdev, vendor,
> > > + DW_PCIE_VSEC_DMA_ID);
> >
> > The vendor of a device assigns VSEC IDs and determines what each
> > ID means, so the semantics of a VSEC Capability are determined by
> > the tuple of (device Vendor ID, VSEC ID), where the Vendor ID is
> > the value at 0x00 in config space.
> 
> As AMD is a vendor for this device, it is determined as VSEC
> capability to support some of the functionality not supported by the
> other vendor Synopsys.

Based on your code, the vendor of this device (the value at 0x00 in
config space) is either PCI_VENDOR_ID_SYNOPSYS or
PCI_VENDOR_ID_XILINX.  Whoever controls those Vendor IDs also
controls the VSEC ID allocations for those Vendor IDs.

> > The DVSEC Capability is a more generic solution to this problem.
> > The VSEC ID namespace is determined by the Vendor ID of the
> > *device*.
> >
> > By contrast, the DVSEC ID namespace is determined by a Vendor ID
> > in the DVSEC Capability itself, not by the Vendor ID of the
> > device.
> >
> > So AMD could define a DVSEC ID, e.g., 6, and define the semantics
> > of that DVSEC.  Then devices from *any* vendor could include a
> > DVSEC Capability with (PCI_VENDOR_ID_AMD, 6), and generic code
> > could look for that DVSEC independent of what is at 0x00 in config
> > space.
> 
> As AMD itself becomes the vendor for this device, VSEC capability is
> chosen to support the functionality missing in the code.

For VSEC, it doesn't matter who *sells* the device or who supplies IP
contained in the device.  What matters is the Vendor ID at 0x00 in
config space.

Bjorn

