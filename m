Return-Path: <dmaengine+bounces-1601-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E420188F8AB
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829EB1F264F9
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057A4E1D1;
	Thu, 28 Mar 2024 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/6iqpYV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B72561F;
	Thu, 28 Mar 2024 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610921; cv=none; b=QctZqf6+uvY2PhfYYA+cD/S4fs1RGOaK5Fkuj542YKc0dRM/RXVnGeWBDhTNuripLareD4pIrPe9Ui28G3f9d3cm1CftsY4veGt8FySFsOI5cEhUPK/kG6oOuuVPS8qn/05afEY5vtCalr8YVDKRAnk7ij6zelGYYgYwhAo/w2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610921; c=relaxed/simple;
	bh=ijOEeCiS3qSRc5vkkBFknmGBS+NCZHRyFeKZjNVu8LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISaI8v82eQsdTWU3cXmB8i60TJGYjHk+PEPU9hlaEuLbh6Q9tuYyI7vXewA0dcnAPyKsryEFNuM2f50tj1wrzl7YMHC4J6HsTp+eXpHkhPeDvLlifgVYzCb+i3+m2xMhl3f0I72kq6Ve/80LzAG8qyKzQXL90Io8cxm897MWFjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/6iqpYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97067C433C7;
	Thu, 28 Mar 2024 07:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711610921;
	bh=ijOEeCiS3qSRc5vkkBFknmGBS+NCZHRyFeKZjNVu8LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/6iqpYVddWxSoR5VY0JmEmW4RcV/6iab+8AbRwbjn4SjChctq6U3Alq9l+CjysUZ
	 qZNTL9Izuu8wY2frtyAVw3wDuRHzpUE69hGn36EbvtqVJ4TYZkyrFhYNfjpP3tgn2+
	 cnzKqD5vtY1KFUKigjos8wS21Qt4lzA0SQ5WZV7/O9Wm7DOob8OAoK1+Oq9U8zzTeO
	 hVPuwAF9OL9DbOJ75C3pu4BwkibFNTRcBW945xSeK7Wipm1xFc9a6k8VeV0Xu+Jffz
	 CTaSO7cblVE8SXngaSMsRb7mU2T04eEC9FzDD2Aa54t/uf1VA2IlZ3SKyyGo7zakM1
	 CwqxWbkerrB9g==
Date: Thu, 28 Mar 2024 12:58:36 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 09/38] dma: cirrus: Convert to DT for Cirrus EP93xx
Message-ID: <ZgUcJByXpLJfG10T@matsya>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
 <20240326-ep93xx-v9-9-156e2ae5dfc8@maquefel.me>
 <ZgTytMtgvqcHlEsO@matsya>
 <821da3f70fcd326860a995514791b228e3f3f7b7.camel@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <821da3f70fcd326860a995514791b228e3f3f7b7.camel@maquefel.me>

On 28-03-24, 10:24, Nikita Shubin wrote:
> Hello Vinod!
> 
> Thank you for looking into this.
> 
> On Thu, 2024-03-28 at 10:01 +0530, Vinod Koul wrote:
> > On 26-03-24, 12:18, Nikita Shubin via B4 Relay wrote:
> > > From: Nikita Shubin <nikita.shubin@maquefel.me>
> > > 
> > > +enum ep93xx_dma_type {
> > > +       M2P_DMA,
> > 
> > Is this missing P2M?
> > 
> > > +       M2M_DMA,
> > > +};
> > > +
> 
> These are internal types used only to distinguish M2P/P2M and M2M
> capable controllers in "of_device_id ep93xx_dma_of_ids[]".
> 
> So M2P_DMA is M2P/P2M, a can rename M2P_DMA to M2P_P2M_DMA to avoid
> confusion.
> 
> 
> > >  struct ep93xx_dma_engine;
> > >  static int ep93xx_dma_slave_config_write(struct dma_chan *chan,
> > >                                          enum
> > > dma_transfer_direction dir,
> > > @@ -129,11 +136,17 @@ struct ep93xx_dma_desc {
> > >         struct list_head                node;
> > >  };
> > >  
> > > +struct ep93xx_dma_chan_cfg {
> > > +       u8                              port;
> > > +       enum dma_transfer_direction     dir;
> > 
> > Why is direction stored here, it should be derived from the prep_xxx
> > call, that has direction as an argument
> > 
> > 
> 
> M2P/P2M channels aren't unidirectional.
> 
> Citing "EP9xx User Guide":
> 
> "Ten fully independent, programmable DMA controller internal M2P/P2M
> channels (5 Tx and 5 Rx)."
> 
> We need to return correct channel based on Device Tree provided data,
> because we need direction in device_alloc_chan_resources() for hardware
> setup before prepping.

Okay it sounds okay in that case...

> 
> May be i am mistaking somewhere.

-- 
~Vinod

