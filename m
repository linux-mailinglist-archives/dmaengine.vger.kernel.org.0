Return-Path: <dmaengine+bounces-1600-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D988F8A6
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD031C232D1
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F02561F;
	Thu, 28 Mar 2024 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOOytuCo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369A413ACC;
	Thu, 28 Mar 2024 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610869; cv=none; b=FhadZ13hDmMdHNNU5KXy6SIkErIlidNfEZ/vADSqJI7HnnEGgfpvdfU5Hy0Ozw5+AJsOuPhcod8nUxdBu/Yk7CKMKQ/Wqo956wTQG/3OPy6OhqCpOGHtuNbYHpyqZVnnLXNOF7Gp4iDIwqd62j7ORTKlJlBt5uHRedq8NE3rylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610869; c=relaxed/simple;
	bh=nEcoLKbWbbnmmhagJLDz5mxJHGXM7Y7imMxfavzWVFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwmXvukmimi9hXXNE7lt9NRsbBnYpQ6Kji7CJAZHIZrguA/BH4tbD9t3+UqH0CK6BRU7PHJTsfap4M7WwUuMwd0JBXKUin/WLjwb4EcpodHxKBCQ9MupMSn3Fd7FD0MqUP+9xKpfqD8ntHIHUAMjuFto+mYtu2Ff3LHwv1PRXi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOOytuCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA1AC433F1;
	Thu, 28 Mar 2024 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711610869;
	bh=nEcoLKbWbbnmmhagJLDz5mxJHGXM7Y7imMxfavzWVFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOOytuCo32SXKvu9CCqI+7WhrAn2GjGLDKCkhHBsc/+K9K6bQfvSmDOyxmt0SpL1z
	 RV7KMOXCBbORlNujIal2rut2yUo9+0IOMtLV2mCVYiWTz0pjISqu2MjWyKaUzoFpzn
	 9uhBm/ZeoOJh2jsWhG58+lZgcByTjkiECcty95nVDDVhCYFFpLvtcXlAi62ynhRiLI
	 wlA3n9FFGheMjLsW18lxQgYE9pFzJAKEPsbuJN2VlnbCvIj6MbJG85x1g2e6lEvjpn
	 BCPIekYGrm3BwT0Q+Ek7p3BDmVgYhoRtAH6Scw71YALKcTzFltY7V0doAXdkXx6yxF
	 d/95lCjhtV7Ug==
Date: Thu, 28 Mar 2024 12:57:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: nikita.shubin@maquefel.me, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 09/38] dma: cirrus: Convert to DT for Cirrus EP93xx
Message-ID: <ZgUb8JKn3nXmhkGn@matsya>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <20240326-ep93xx-v9-9-156e2ae5dfc8@maquefel.me>
 <ZgTytMtgvqcHlEsO@matsya>
 <d620c37f58b303260096f73e04dfff6bb65ed1ef.camel@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d620c37f58b303260096f73e04dfff6bb65ed1ef.camel@gmail.com>

On 28-03-24, 08:21, Alexander Sverdlin wrote:
> Hello Vinod!
> 
> On Thu, 2024-03-28 at 10:01 +0530, Vinod Koul wrote:
> > On 26-03-24, 12:18, Nikita Shubin via B4 Relay wrote:
> > > From: Nikita Shubin <nikita.shubin@maquefel.me>
> > > 
> > > Convert Cirrus EP93xx DMA to device tree usage:
> > 
> > Subsytem is dmaengine: pls fix that
> > 
> > > 
> > > - add OF ID match table with data
> > > - add of_probe for device tree
> > > - add xlate for m2m/m2p
> > > - drop subsys_initcall code
> > > - drop platform probe
> > > - drop platform structs usage
> > > 
> > > > From now on it only supports device tree probing.
> > > 
> > > Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > > ---
> > >   drivers/dma/ep93xx_dma.c                 | 239 ++++++++++++++++++++++++-------
> > >   include/linux/platform_data/dma-ep93xx.h |   6 +
> > >   2 files changed, 191 insertions(+), 54 deletions(-)
> > > 
> > > diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> > > index d6c60635e90d..17c8e2badee2 100644
> > > --- a/drivers/dma/ep93xx_dma.c
> > > +++ b/drivers/dma/ep93xx_dma.c
> 
> [...]
> 
> > >   
> > > @@ -104,6 +106,11 @@
> > >   #define DMA_MAX_CHAN_BYTES		0xffff
> > >   #define DMA_MAX_CHAN_DESCRIPTORS	32
> > >   
> > > +enum ep93xx_dma_type {
> > > +	M2P_DMA,
> > 
> > Is this missing P2M?
> 
> Not really. It's not the most obvious one, but anyway a way to enumerate
> two types of DMA engines:
> 
> "7.1.1 DMA Features List
> DMA specific features are:
> • Ten fully independent, programmable DMA controller internal M2P/P2M
> channels (5 Tx and 5 Rx).
> • Two dedicated channels for Memory-to-Memory (M2M) and
> Memory-to-External Peripheral Transfers (external M2P/P2M)."
> 
> Now the confusing part is that this "M2M" engine is actually used
> to transfer to and from *some* devices, like SPI and IDE.
> So both engines are capable of M2P and P2M, maybe Cirrus has named
> two engines in a sub-optimal way decades ago and this is now a bit
> historical naming.

Okay, thanks for clarifying (might be worthwhile to mention this in
comments)

-- 
~Vinod

