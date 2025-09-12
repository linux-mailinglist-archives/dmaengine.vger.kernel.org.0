Return-Path: <dmaengine+bounces-6494-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD020B553BB
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 17:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22A1B64FE0
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96B31690A;
	Fri, 12 Sep 2025 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfk5xoK0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD03128C8;
	Fri, 12 Sep 2025 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691240; cv=none; b=DrD0zdDZiv0HxCgAE3RFZBSlE4kygdrA+XDr1WYjUOkV4/xE1Z4L3YIk8EFSvwpi1NA2T9cr5Qcng4rnDQVeoH1x43E4ccvKzdl0uph3Z0bw0wz5a4FbI9vfG8Nte+9Wz7xK6dYLfdVlNGC1XHbo3QuNqH3KtzBzhXetYoM1lPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691240; c=relaxed/simple;
	bh=UjNP+gz35xIYAwtkGxP8yyGBEgjqvxljaBoIFuNHqJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XN7fh3izCHSkOXEg1EhNdvhc/khfSot+OnnuOPuTQQdc02I5hfCHlRj0cUNv2HjIJkNa4O98f67xqEGx6y7qT/FXL+w89gPo7OEHpQ7fDijA/e2RZpUAgKBlvq300kpDGva/nEt1Ez6j/Z8Y7p5ZCTF5uGY24qk3hAH7QKSSiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfk5xoK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D391C4CEFC;
	Fri, 12 Sep 2025 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757691240;
	bh=UjNP+gz35xIYAwtkGxP8yyGBEgjqvxljaBoIFuNHqJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mfk5xoK0Q7thxy9nZCGyDFaXIs6vUYL5i/fJc0a+UaFFsFfeigmY3ICTcjeMaOSmn
	 7x/y1w/VrmjX3DJXakng0q/dFkBaEoGwWvBrh2RgwLHPZFcW3cfySZJuerhH1sidvx
	 E5oQD1pCsST04zzWjf89Wm8qtrAXqxLsO5wSIG4uANn42LHVyyuGv8lpwNyLroHGCV
	 ULBk6RvG9K66vCXskir7fzLh0Yw4KEIsf9ve8/AIrZIDUOyMQyvvSaXn41zVVSv89Y
	 SQoonBl1DLH/fzSxSGYDsDzhIJ1+mDECjBEeMBwvmrBIpw3Ny/xUi/xspw07kY5ngs
	 nSYTX9TGzESzw==
Date: Fri, 12 Sep 2025 10:33:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v1 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <20250912153358.GA1625522@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120288197801A3F6C41993A9508A@SA1PR12MB8120.namprd12.prod.outlook.com>

On Fri, Sep 12, 2025 at 09:35:56AM +0000, Verma, Devendra wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>

[redundant headers removed]

> > On Thu, Sep 11, 2025 at 05:14:51PM +0530, Devendra K Verma wrote:
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
> > >   Link List.
> >
> > > +static pci_bus_addr_t dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > +                                         struct dw_edma_pcie_data *pdata,
> > > +                                         enum pci_barno bar) {
> > > +     if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> > > +             return pdata->devmem_phys_off;
> > > +     return pci_bus_address(pdev, bar);
> >
> > Does this imply that non-Xilinx devices don't have the iATU that
> > translates a PCI bus address to an internal device address?
> 
> Non-Xilinx devices can have iATU enabled or bypassed as well. In
> bypass mode no translation is done and the TLPs are simply forwarded
> untranslated.

What happens on a non-Xilinx device with iATU enabled?  Does
pci_bus_address() return the correct address in that case?

I can't figure out what's different about Xilinx that requires this
special handling.

