Return-Path: <dmaengine+bounces-5842-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CAFB0EBD4
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 09:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50F73A6C3E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E0027145E;
	Wed, 23 Jul 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eURqjYdv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35E2701D1;
	Wed, 23 Jul 2025 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255238; cv=none; b=u5+Cb6fTczY6v2kzvfViDOwdSe0km9hgOlO01o3mDUaWmQ5y9g03FGjcAxWlT5LuY3PdzOWq7kRblfizrbf+wzqd7B3a0Mrvgph2S5wD/t4xrME83lpPiPnMwMdodhAYzmD2xl3GiHlx0JMYlc4zImsiakPpfPmioRvKJqgnN2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255238; c=relaxed/simple;
	bh=Vxz6oiIqIgOHJzowDL4yIofRLk/aDZkZ6xpVY+bDf4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHprPHiBwi4slUYU+x6jjxfBptTnKkRVPt4+B/DC8hZvCliYYif6GKuctzo3BeT51tRmGCROw/XZbwDwU/E3wrR8OIlDtK2i1UKuerTt0S2bs4s60tPQWopaA3Hhy7PlDKGbLiPJr+ueySiQkX9I/GwnfyiTO0z8A7b3MSCSDLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eURqjYdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5FAC4CEF7;
	Wed, 23 Jul 2025 07:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753255238;
	bh=Vxz6oiIqIgOHJzowDL4yIofRLk/aDZkZ6xpVY+bDf4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eURqjYdvLvvTzLu+pTAML/z+NRsJAn0RGdSfgKc8Af05VWhEfCpct55SwQtYBYtNw
	 Yh9m8aI1LopqogjprRVmcRiXfPtqN49fAGVqOsZ5f0WsM4G+2w0qrUcapEhG0bPUuc
	 +uh58UcKyd5EPzAr6G6yG20kw8we7zqpwRVajXN++53raEtduqV7HY21nVyCOMri/2
	 0EHMbBc2vd6P4DMm+9G7lmT7VgAoMb6pcPHIX6KOccxqTocDddlDiyOcKXm0BXSAko
	 vX/WsMdwmqLdL6COZleQ8xcK61F92S4FG072I+7bC49h3Uit39VWURZttiSw3rC2uV
	 HAA4gPDoa5SXQ==
Date: Wed, 23 Jul 2025 12:50:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mani@kernel.org" <mani@kernel.org>
Subject: Re: [RESEND PATCH] dmaengine: dw-edma: Add Simple Mode Support
Message-ID: <aICNQuhw3SrZJrYS@vaman>
References: <20250623061733.1864392-1-devverma@amd.com>
 <aF3Eg_xtxZjZTEop@vaman>
 <SA1PR12MB81208BAD2A5D264482333FF79540A@SA1PR12MB8120.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB81208BAD2A5D264482333FF79540A@SA1PR12MB8120.namprd12.prod.outlook.com>

On 02-07-25, 09:38, Verma, Devendra wrote:
> > On 23-06-25, 11:47, Devendra K Verma wrote:
> > > The HDMA IP supports the simple mode (non-linked list).
> > > In this mode the channel registers are configured to initiate a single
> > > DMA data transfer. The channel can be configured in simple mode via
> > > peripheral param of dma_slave_config param.
> > >
> > > Signed-off-by: Devendra K Verma <devverma@amd.com>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-core.c    | 10 +++++
> > >  drivers/dma/dw-edma/dw-edma-core.h    |  2 +
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 53
> > ++++++++++++++++++++++++++-
> > >  include/linux/dma/edma.h              |  8 ++++
> > >  4 files changed, 72 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > index c2b88cc99e5d..4dafd6554277 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -235,9 +235,19 @@ static int dw_edma_device_config(struct dma_chan
> > *dchan,
> > >                                struct dma_slave_config *config)  {
> > >       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > > +     struct dw_edma_peripheral_config *pconfig = config->peripheral_config;
> > > +     unsigned long flags;
> > > +
> > > +     if (WARN_ON(config->peripheral_config &&
> > > +                 config->peripheral_size != sizeof(*pconfig)))
> > > +             return -EINVAL;
> > >
> > > +     spin_lock_irqsave(&chan->vc.lock, flags);
> > >       memcpy(&chan->config, config, sizeof(*config));
> > > +
> > > +     chan->non_ll_en = pconfig ? pconfig->non_ll_en : false;
> > >       chan->configured = true;
> > > +     spin_unlock_irqrestore(&chan->vc.lock, flags);
> > >
> > >       return 0;
> > >  }
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.h
> > > b/drivers/dma/dw-edma/dw-edma-core.h
> > > index 71894b9e0b15..c0266976aa22 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > > @@ -86,6 +86,8 @@ struct dw_edma_chan {
> > >       u8                              configured;
> > >
> > >       struct dma_slave_config         config;
> > > +
> > > +     bool                            non_ll_en;
> >
> > why do you need this? What is the decision to use non ll vs ll one?
> 
> The IP supports both the modes, LL mode and non-LL mode.
> In the current driver code, the support for non-LL mode is not
> present. This patch enables the non-LL aka simple mode support
> by means of the peripheral_config option in the dmaengine_slave_config.

That does not answer my question, what decides which mode should be
used?

-- 
~Vinod

