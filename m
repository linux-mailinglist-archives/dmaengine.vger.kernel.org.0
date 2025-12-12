Return-Path: <dmaengine+bounces-7575-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA597CB77BA
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 01:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F6BD3002537
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 00:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E1B241CB2;
	Fri, 12 Dec 2025 00:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6ZtS89H"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC90654774;
	Fri, 12 Dec 2025 00:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765500692; cv=none; b=Hdb/I43cfFzpYZk9el5OPIRiLA3pKiFKHOkwLkRDsYptvZlGibUl+0WN7ssNNiSjRiVjkFPdNEdh/O2Dc8ruYE78mWZYoNHrPSu2gp3ZtgU/XF0lhOGTtnfpjaBT/7NycUn0XKcStogsMA6gEIerR0+4D6AtHtEkIiHCuIkX8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765500692; c=relaxed/simple;
	bh=950fJsDhdIODwKQtJvg6GmxHoxivYyaDwBJ+Pj4WErI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snOjkHNDhJXoU8tMmQPylSaL5qXuXFILU/vYVAtUMVVijutj67PR2jQQu29HbCjNITomDXdq7exLnwK7ozbzrYxRjyOLYXHgXYsGWNRhkB9WSl6ODeNbXIuUaTs6dwysRBQ666ch5N54IPcTl1RD2exvrtI7iiScl3wu3qPANvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6ZtS89H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D106C4CEF7;
	Fri, 12 Dec 2025 00:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765500690;
	bh=950fJsDhdIODwKQtJvg6GmxHoxivYyaDwBJ+Pj4WErI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6ZtS89HgVeKQLJVRPL4afcpbI+XttlHgkl69x628wal32wg/7sovFkw8TvIm6v/N
	 Fa8HBIhRpAKB47JDSWr4LvKyuWlDkbvWN0hTw1Whns9n8Lw3bcKXNjfRF227/HEMnd
	 wExQ5YFA6h2ON8pMQSQ8vN0KrE6/xzHb5LjSh5AtpCdJs7GfKmqFpQ5BhXAdGOkrS8
	 o1RJdpgY/z2pp8QV+mxPMUNu8P4Zqz0syiuk96xa5Vz4eqFfeVRnbHMNIyucXPKXli
	 mUpA78/i6YZI9O3Tq68ItVKlgD6uhiLvtYZi2FyAushEHGZ9fj4SeddVBNvNqLq917
	 sRg8ZyjrP27yQ==
Date: Fri, 12 Dec 2025 09:51:20 +0900
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, 
	"vkoul@kernel.org" <vkoul@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <u5kvrlguunzhuguz54mtonrsjb2wykgtgxbccxtw753ajls24g@xmf3yztelko7>
References: <20251121113455.4029-1-devendra.verma@amd.com>
 <20251121113455.4029-3-devendra.verma@amd.com>
 <pcyikziojphmgcyeicjegmbpdpktsay5n5q3xvsexifziesxmx@wpcdf77lowo4>
 <SA1PR12MB8120143580059C4AEDA50CD395A0A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <sshal25ch5pipzodbamg7h6k6scfzzsxnkox3dd5t6lvkrjis6@gmb55objtlgw>
 <PH0PR12MB8126DB250FA4873F04C3554895A1A@PH0PR12MB8126.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR12MB8126DB250FA4873F04C3554895A1A@PH0PR12MB8126.namprd12.prod.outlook.com>

On Thu, Dec 11, 2025 at 11:39:25AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Manivannan
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: Wednesday, December 10, 2025 6:59 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; vkoul@kernel.org; dmaengine@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> > <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, Dec 10, 2025 at 11:39:59AM +0000, Verma, Devendra wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi Manivannan
> > >
> > > Please check my response inline.
> > >
> > > Regards,
> > > Devendra
> > >
> > > > -----Original Message-----
> > > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > > Sent: Monday, December 8, 2025 11:00 AM
> > > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > > Cc: bhelgaas@google.com; vkoul@kernel.org;
> > > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > > Subject: Re: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL
> > > > mode
> > > >
> > > > Caution: This message originated from an External Source. Use proper
> > > > caution when opening attachments, clicking links, or responding.
> > > >
> > > >
> > > > On Fri, Nov 21, 2025 at 05:04:55PM +0530, Devendra K Verma wrote:
> > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > > The current code does not have the mechanisms to enable the DMA
> > > > > transactions using the non-LL mode. The following two cases are
> > > > > added with this patch:
> > > > > - When a valid physical base address is not configured via the
> > > > >   Xilinx VSEC capability then the IP can still be used in non-LL
> > > > >   mode. The default mode for all the DMA transactions and for all
> > > > >   the DMA channels then is non-LL mode.
> > > > > - When a valid physical base address is configured but the client
> > > > >   wants to use the non-LL mode for DMA transactions then also the
> > > > >   flexibility is provided via the peripheral_config struct member of
> > > > >   dma_slave_config. In this case the channels can be individually
> > > > >   configured in non-LL mode. This use case is desirable for single
> > > > >   DMA transfer of a chunk, this saves the effort of preparing the
> > > > >   Link List. This particular scenario is applicable to AMD as well
> > > > >   as Synopsys IP.
> > > > >
> > > >
> > > > Which in-kernel DMA client is using this non-LL mode?
> > > >
> > > > - Mani
> > > >
> > >
> > > Existing dma client application(s) can use the non-LL mode for the AMD
> > > (Xilinx) use case with the help of a simple peripheral_config variable
> > > which is part of the dma_slave_config structure.
> >
> > There is no existing client driver making use of this non-LL mode. So essentially,
> > this patch is introducing the dead code.
> >
> > > Though, no driver is using the non-LL mode as non-LL mode is not
> > > available in the current code.
> >
> > Then introduce non-LL mode when such client drivers start using it.
> >
> > - Mani
> >
> 
> Please excuse me as I left out a use case related to AMD MDB controller.
> The AMD MDB controller has a valid use-case for non-LL mode when the base physical
> address offset of the controller side DDR is not available / configured. In the absence
> of this offset the controller is not usable as the default mode enabled is LL mode.
> With the introduction of non-LL mode, if the offset is not configured then also controller
> can be used for the DMA transactions. The choice of non-LL or LL mode is use-case specific.
> The following snippet handles that scenario in the
> dw_edma_device_config() call:
> +     if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))
> +             chan->non_ll = true;
> 
> In my previous response, I explained that it is the optional configuration using which
> DMA clients can use the non-LL mode when the default mode used is LL mode.
> 
> I hope this clarifies, the code is not dead code rather it has use case for AMD MDB *and* an
> option to use non-LL mode for both Synopsys and AMD controller when LL mode is
> default mode. The default non-LL mode case is not available for Synopsys.
> 

Ok, thanks for clarification. If you've explained this in the commit message in
the first place, it would've helped me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

