Return-Path: <dmaengine+bounces-6608-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E819B81B80
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 22:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452BE7B4416
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 20:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4022A271468;
	Wed, 17 Sep 2025 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avAxU2Po"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107031E4BE;
	Wed, 17 Sep 2025 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139697; cv=none; b=MGmnd25bADQ4ZYO4EBVIKU1O9X6SDmOblmUpW7DsJyie/pvrscyryZH1E3oMDx50OMFyZm2r5HQKWDlc8GUJvmqhwj11gVI6ZwCR5o0gDv5dWTEJIAoSBjWta6c+z/hHOWz200fR+YqgfWBGV5+0dKprCGIGKl09/P9tlgKT79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139697; c=relaxed/simple;
	bh=C2l07gKv9oUofg16haxjhhZY+dVl35j0/BCf4Jr6Gpk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fjdIYrhBuExbE3siPu0SGg9T0MY8AReLdO9REqsjxhiNYa+J9lRnKL+PqVfBzdE/U4LBZlw8658h8EccElfLT0Bi6zP84XhXuby9sjAs2gDXWl7Ps26GVP/5kq+GAhRgBE136Eo35dh1AJywJJFSUSUUI55G/1j6MM7p19+k7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avAxU2Po; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75E2C4CEE7;
	Wed, 17 Sep 2025 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758139696;
	bh=C2l07gKv9oUofg16haxjhhZY+dVl35j0/BCf4Jr6Gpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=avAxU2PoSQgXWU1mBBdyRdl6s40B/u+AJkIInXtSF90qMaIZtMm6z4jA8IBHNhT0B
	 uVocZCRXUoDi5cnZHxUP8LzbcBoJvwT9acfe4N7Gs+iPRKhb3ZbLDw33KApnenGiRl
	 EyrsD1Me+Dga3UUMDCKce037c58a8NliJsTCFW14njegkEIe1y82RoVt/9zBO/TgFc
	 mNQDcybk4fQgCTN96KIm3L4YCRkN7rC+OjZwNf9eT2b2pO6n9R8qr3870T5vvlNATF
	 YDPacV+pL26cY5A3rqhjVRKX3eS6SF+BNXtoEXH5+2GczmMMhWGpnbF/uPu33Ko+d0
	 ZNTfqATvymc2A==
Date: Wed, 17 Sep 2025 15:08:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Message-ID: <20250917200815.GA1872720@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120DB05E469F3645F3C18A09517A@SA1PR12MB8120.namprd12.prod.outlook.com>

On Wed, Sep 17, 2025 at 11:59:09AM +0000, Verma, Devendra wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Tuesday, September 16, 2025 20:34
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint
> > Support
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Tue, Sep 16, 2025 at 04:13:18PM +0530, Devendra K Verma wrote:
> > > AMD MDB PCIe endpoint support. For AMD specific support added the
> > > following
> > >   - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
> > >   - AMD MDB specific driver data
> > >   - AMD MDB specific VSEC capability to retrieve the device DDR
> > >     base address.

> > > -     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> > > -                                     DW_PCIE_VSEC_DMA_ID);
> > > +     /*
> > > +      * Synopsys and AMD (Xilinx) use the same VSEC ID for the purpose
> > > +      * of map, channel counts, etc.
> > > +      */
> > > +     if (vendor != PCI_VENDOR_ID_SYNOPSYS ||
> > > +         vendor != PCI_VENDOR_ID_XILINX)
> > > +             return;
> > > +
> > > +     cap = DW_PCIE_VSEC_DMA_ID;
> > > +     if (vendor == PCI_VENDOR_ID_XILINX)
> > > +             cap = DW_PCIE_XILINX_MDB_VSEC_ID;
> > > +
> > > +     vsec = pci_find_vsec_capability(pdev, vendor, cap);
> >
> > This looks correct, so it's OK as-is.  But it does require more
> > analysis to verify than it would if you did it like this:
> >
> >   vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
> >                                   DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
> >   if (!vsec) {
> >     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
> >                                     DW_PCIE_XILINX_VSEC_DMA_ID);
> >     if (!vsec)
> >       return;
> >   }
> >
> > This way it's obvious from the pci_find_vsec_capability() calls
> > themselves (and could potentially be checked by coccinelle, etc)
> > that we're using the Vendor ID and VSEC ID correctly.
> 
> Instead of the above format, a clear assignment to vendor and cap
> would be good enough.  Reason for this is, if a third vendor comes
> and supports the same VSEC=0x6 id with similar capabilities then it
> looks bulky to put another clause as given above. Instead of this a
> cleaner approach would be to have a single
> pci_find_vsec_capability() and clear assignment to vendor and cap
> variables to make it look cleaner. Eg:

> switch (pdev->vendor) {
> case PCI_VENDOR_ID_XILINX:
>         vendor = pdev->vendor;
>         cap = DW_PCIE_XILINX_MDB_VSEC_DMA_ID;
> case PCI_VENDOR_ID_SYNOPSYS:
>         ...
> default:
>         return;
> }
> vsec = pci_find_vsec_capability(pdev, vendor, cap);

OK, that is less clumsy although not as mechanically checkable.

There's not much point in assigning "vendor = pdev->vendor".  You
could just do this:

  switch (pdev->vendor) {
  case PCI_VENDOR_ID_XILINX:
    cap = DW_PCIE_XILINX_MDB_VSEC_DMA_ID;
    break;
  case PCI_VENDOR_ID_SYNOPSYS:
    cap = DW_PCIE_SYNOPSYS_VSEC_DMA_ID;
    break;
  default:
    return;
  }

  pci_find_vsec_capability(pdev, pdev->vendor, cap);

