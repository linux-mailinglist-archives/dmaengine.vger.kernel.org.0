Return-Path: <dmaengine+bounces-4555-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA5A3F331
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 12:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352A87A49B1
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7085520897C;
	Fri, 21 Feb 2025 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRGOQhEs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA01F4E3B;
	Fri, 21 Feb 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138159; cv=none; b=PkENLmXEQ5OE+mmz63nkG6tM2DPAc460JDQqcnh+pY0FodP1v1nIBgk4Zje/scE3A9T0keySR7N8iFiAGmXiCP05VyBQSNSpHUXJDXVfpUHLC3sBD9DTmhz1nftBhLAyCKWO7qRFiibdOCHs4xps/4oCfsYE7lxDLwuPLo/b8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138159; c=relaxed/simple;
	bh=OPgVE0qTEqF3hoIsG3hCs4ZHVM+vrprB1P+zL4Vj7DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcV9wD2b9634R3Q1UFX+5eepJmxX9hOd0hFMsxMhaP6ObjprF5fT0WUN4nEwS4tus48dfiH9glb8YF/Yj52bD49keB1l9OZyQieQMtSGVASnoA4Pf7bQZZuoACT5q9C4EN/4F7kvIPCnKPtMzwmflZUQSx6MWM3StIZDfUMqNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRGOQhEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38789C4CED6;
	Fri, 21 Feb 2025 11:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740138158;
	bh=OPgVE0qTEqF3hoIsG3hCs4ZHVM+vrprB1P+zL4Vj7DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRGOQhEsvEGIA53VzQnCJPO4ZZ5ITsRavKdQp0gwWmx2i1m0vfj1m/OTsBMqYDCxO
	 sH6YrBK5SrqUdubYXd+05bPmyyhUQy2QXo01klOH4QfkeaCMfJKcdbnAk8VmSozqHY
	 b7GcioJEsvf9olV6oOfc3MuUcCh+XF/G6a4HDRK9B+hm8hX7k+96JziffQGMLBDZZs
	 X5Xkloz3p7KsVfCScxVvhzmYB82CwJPo6spwxTCpp1/UySkJKP45L1/TsDTGCItm86
	 ukxh8G7eO590QdRIqLvAZGMARJh15hvlIIcix3E+DGrbf4iHfZaI1VpVfPf3bnUVgw
	 S4BhAwMeI5izA==
Date: Fri, 21 Feb 2025 12:42:35 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Devendra K Verma <devverma@amd.com>, vkoul@kernel.org,
	dmaengine@vger.kernel.org, michal.simek@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: Add simple mode support
Message-ID: <Z7hmq9YO43383WQO@ryzen>
References: <20250219110847.725628-1-devverma@amd.com>
 <20250221074612.dzbyiqet4jyvrdab@thinkpad>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221074612.dzbyiqet4jyvrdab@thinkpad>

On Fri, Feb 21, 2025 at 01:16:12PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Feb 19, 2025 at 04:38:47PM +0530, Devendra K Verma wrote:
> 
> + Niklas (who also looked into the MEMCPY for eDMA)
> 
> > Added the simple or non-linked list DMA mode of transfer.
> > 
> 
> Patch subject and description are also simple :) You completely forgot to
> mention that you are adding the DMA_MEMCPY support to this driver. That too only
> for HDMA.
> 
> > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 38 +++++++++++++++++
> >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 59 ++++++++++++++++++++++++++-
> >  3 files changed, 97 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 68236247059d..bd975e6d419a 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -595,6 +595,43 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
> >  	return dw_edma_device_transfer(&xfer);
> >  }
> >  
> > +static struct dma_async_tx_descriptor *
> > +dw_edma_device_prep_dma_memcpy(struct dma_chan *dchan,
> > +			       dma_addr_t dst,
> > +			       dma_addr_t src, size_t len,
> > +			       unsigned long flags)
> > +{
> > +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +	struct dw_edma_chunk *chunk;
> > +	struct dw_edma_burst *burst;
> > +	struct dw_edma_desc *desc;
> > +
> > +	desc = dw_edma_alloc_desc(chan);
> > +	if (unlikely(!desc))
> > +		return NULL;
> > +
> > +	chunk = dw_edma_alloc_chunk(desc);
> > +	if (unlikely(!chunk))
> > +		goto err_alloc;
> > +
> > +	burst = dw_edma_alloc_burst(chunk);
> > +	if (unlikely(!burst))
> > +		goto err_alloc;
> > +
> > +	burst->sar = src;
> > +	burst->dar = dst;
> 
> Niklas looked into adding MEMCPY support but blocked by the fact that the
> device_prep_dma_memcpy() assumes that the direction is always MEM_TO_MEM. But
> the eDMA driver (HDMA also?) only support transfers between remote and local
> DDR. So only MEM_TO_DEV and DEV_TO_MEM are valid directions (assuming that we
> call the remote DDR as DEV).

In rk3588 TRM:

MAP_FORMAT
0x0 (EDMA_LEGACY_PL): Legacy DMA register map accessed by the port-logic
    registers
0x1 (EDMA_LEGACY_UNROLL): Legacy DMA register map, mapped to a PF/BAR
0x5 (HDMA_COMPATIBILITY_MODE): HDMA compatibility mode (CC_LEGACY_DMA_MAP =1)
    register map, mapped to a PF/BAR
0x7 (HDMA_NATIVE): HDMA native (CC_LEGACY_DMA_MAP =0) register map, mapped to
    a PF/BAR

Read-only register. Value After Reset: 0x1.

So eDMA in rk3588 is EDMA_LEGACY_UNROLL.


I don't know if this limitation that you correctly described applies to all
the other formats as well.


Kind regards,
Niklas

