Return-Path: <dmaengine+bounces-7912-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEDDCD9F83
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 17:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66568308BE7B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BAA302157;
	Tue, 23 Dec 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAROg1Xk"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585A2222A9;
	Tue, 23 Dec 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507324; cv=none; b=cYzOuC+yUHJ7Igv1i2L4/L2gDHo8Yg/7POFcvvggXgtpoSX/cAjLQ5Qf12WStNdquUS1lS3TOdS37mNXXdkG/IKiLxxdsxCqW/V+IWlNnUqPBRXr3hLpeHrlBRO42Ee4ik0N8qi2vepXEsdoZvULBTOEwao/OgDdBGK1S6yKYqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507324; c=relaxed/simple;
	bh=k5BQkIt0NB7ozx6foGOfAycuSqqq5wW1jsLWOKfYEwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tnw3PRrQcc7sOM33aAY5frljcF38Cg0xhgS3mbHYGSa3x/Dr0/vuAAsli30GX2dw0xF14Tx9yEKd33FDXIJ2f/iBWTov2ojuLK+RO4XGIaup2bMCeOOeZovDRbNa5ZdJMDhEc2Rh8Tdos+9AyHsIY9R7A9aFzb5KrwXSoP6AxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAROg1Xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8AEC113D0;
	Tue, 23 Dec 2025 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766507324;
	bh=k5BQkIt0NB7ozx6foGOfAycuSqqq5wW1jsLWOKfYEwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uAROg1Xka0OYDVHm57STv2RFPVgdCB7PxVki8aTFfjzWTI4h/P75zOoPVJ37ypSfQ
	 qm9qsI3kGFWRcwXWdcodgUdZLNoJgR7lpSejF4MP77+O99WYkotIWrzveXO8uD6z+C
	 +ZbL9PqZKMqRBJhLTkoGSyGUaFjP8/3Slc9NXvYKYFWO2Td8WbPx9yefvNwg959/7R
	 lt+OOI9Pb8Qv0MXFpoiDKAtyvYAqAxdnl/HjLtM/Z/lVIppgqtbPoIXYkw+gK2aYH1
	 iUzZxbOgjjURRsCmoqOsj7RmqKCLt2FH8YrxAL+lTUHv+wHn3vAM+LhAeuAMqZQCYR
	 XvEBmkT3tldFQ==
Date: Tue, 23 Dec 2025 10:28:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <20251223162842.GA4022246@bhelgaas>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120306AAE9B655A8F8273B795AAA@SA1PR12MB8120.namprd12.prod.outlook.com>

On Tue, Dec 16, 2025 at 10:15:34AM +0000, Verma, Devendra wrote:
> > From: Bjorn Helgaas <helgaas@kernel.org>

[snipped pointless header quotes]

> > On Fri, Dec 12, 2025 at 05:50:56PM +0530, Devendra K Verma wrote:
> > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > The current code does not have the mechanisms to enable the DMA
> > > transactions using the non-LL mode. The following two cases are added
> > > with this patch:
> > > - For the AMD (Xilinx) only, when a valid physical base address of
> > >   the device side DDR is not configured, then the IP can still be
> > >   used in non-LL mode. For all the channels DMA transactions will
> > >   be using the non-LL mode only. This, the default non-LL mode,
> > >   is not applicable for Synopsys IP with the current code addition.
> > >
> > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> > >   and if user wants to use non-LL mode then user can do so via
> > >   configuring the peripheral_config param of dma_slave_config.
> > > ...
> >
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -223,8 +223,31 @@ static int dw_edma_device_config(struct
> > dma_chan *dchan,
> > >                                struct dma_slave_config *config)  {
> > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +     int non_ll = 0;
> >
> > Other "non_ll" uses below are bool, so a little bit of an int/bool mix.
> >
> > The name also leads to a lot of double negative use ("!non_ll", etc), which is
> > hard to read.  I suppose "non-LL" corresponds to some spec language, but it
> > would be nice if we could avoid some of the negation by testing for "ll_mode"
> > or calling the other mode "single_burst" or similar.
> >
> 
> Yes, non-LL is being referred in the Synosys databook extensively to
> differentiate between LL and non-LL mode.
>
> I agree with the concern raised here but, at the moment, this is the
> only suitable term that can handle the following cases:

> 1) Choice of variable of the DMA client to use non-LL mode,
> 2) Establish flow for the non-LL use-case in the driver.
> 
> Before, using the term with negation (non_ll), the possibility was explored
> to use a term which does not result in double negation, eg, ll or ll_mode.
> But this again breaks the above either one or both use-cases.
> If using ll_mode as a variable, then with this, DMA client shall
> either provide ll_mode=false or non_ll=true.
> 
> When ll_mode=false. This option would be as good as
> passing a valid reference to peripheral_config pointer as
> the value of ll_mode would never be used for ll_mode=true
> due to default mode being LL.
> On the basis of ll_mode=true, the DMA client given option, no code
> is impacted with these patches.
> 
> When DMA client gives non_ll=true; this causes confusion,
> DMA client does right but internally ll_mode as a variable is set
> to establish the flow for non-LL mode. The different variable is
> used for establishing the non-LL mode inside the driver code.
> Also, it uses the combination of double negation variable.
> 
> Though, the use of non_ll, raises concern due to double
> negation but its use fits the use-case from both DMA client
> and in the driver to establish the non-LL flow. Additionally,
> The use of non_ll also aligns with the documentation of the
> vendor making it easier to follow.
> Please let me know your thoughts on this.

OK.  It's good to match the databook.  Maybe there's a way to
restructure the code to prefer "if (chan->non_ll)" tests over
"if (!chan->non_ll)"?

