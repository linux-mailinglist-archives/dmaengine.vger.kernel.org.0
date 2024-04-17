Return-Path: <dmaengine+bounces-1875-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B78A8BA2
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 20:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121501F22705
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D941200D1;
	Wed, 17 Apr 2024 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WicuUJ2b"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13F171A5;
	Wed, 17 Apr 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379968; cv=none; b=N5z959PjbJtGtUESWDVqYZAPCnEvrC2ihOKiE6KzpzgIW2bh9i06L1PPLHr+ovVJ/Q7yz3YYDGu1CgA8lKiqcf9l9hSkfYHXgTOrW9cTyRqLI357GefzT++KVFsp1sq8/Ivdn/5eLLmt3NeKTetOoG1qFLmoJp4bwR3K8uP49ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379968; c=relaxed/simple;
	bh=K+tgtTWDf1hYngG6HFAqbuU/XT5EMpmdIjRfrLTx8D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaCKcR2km5oX9VhCyzVCFDgP+kl06N6z0IBL1Rm/xtPTHuNk3oNNtjl/jmF2r4D3bVmtwP2D0j5h4sXpplaEaHQ0ybnrR/hR47ojv8QqXEL5e103JfbyNpihYT8Ygz5AhK+WUPJGEYXcrXy7hwQm0dBkrVpi+fg6MM3cZwTvM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WicuUJ2b; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so449981fa.2;
        Wed, 17 Apr 2024 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713379965; x=1713984765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gxVZKKBojDfS52bqlNEjy2/nWDdF4WxO0AvebDP1tQ=;
        b=WicuUJ2bDzFE6+tXqV8udiHeYv6vouuj8N8LqApisROjOzNnanlIhpZ+P7IZgOwr4v
         LDw2j36SS33U4rrZmjie7ZnHST5YS9pVsiQdHQyfkBCW24W5AzXEqiqpjmGg7trU/WN+
         EAQtFF7xTmskQTGAG2yW9NoSwwIc/UdmYY8pRBXDSfx/6pCSdfUKfWa2K/Nr5slgrRs1
         PXV/0I4UDrZGHWDDPpQ5cuchNwaWccMmBXbnmy6EaI6abS+W78yEm4P4kojAIMuMU8uj
         g8xXsc8cwTveHGob+JUgqUUR09/JiuyBxLspzTVW3it0l8ESH0YpFdxxnwa6UT6HUR4S
         jZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379965; x=1713984765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gxVZKKBojDfS52bqlNEjy2/nWDdF4WxO0AvebDP1tQ=;
        b=dZ+BDTqTxqIZ5KH44TDJ5H9K3OXImB6VI1O59oqi4Hg9KzdQCIonbUZ8ww/2HXrj1r
         kvyE59zmKomVytDdzHH9GdLegatjsLlt2sz5uW5OmkroE/z1YUDWB1UF+fGeXpnjGw21
         jb57AddmpMfKKe3rOzaoid4ALTnoTWfWSup3cpfy076UG7eimBzb6HA3CRQIKd0AU3Gi
         UYvjgFAfOYyoz4j2ML/JinfMPg1z9NQVlhnnL9yB/QohKpmdnI7IW5Qf0H/z9ogAiNuC
         cyc3cIg63m0RzCMXBypghGUtkB2Yu8qFhsZtA/4ZAaroyvX8KpDU7OwbXsVmYn8U//kt
         hQ7g==
X-Forwarded-Encrypted: i=1; AJvYcCU0NoKFnkWIo2vrbuVuGRw+YQXi66i+JPMYdt+bEbNJpSqzrgQbouOEoo0C0ojaQ+N4zvYm3gOJ2qHsHsGnKjnCaDgbmOvjt7PcV6xuL8vC+bnZQXhmi1O2qbT5nBnZ0Ds90/sDLYMqSiuByL/D1t4Sr7502EhmxjXxgyYblomXZHe//SIq
X-Gm-Message-State: AOJu0Yxz356Qg7VFftlO8b3toaIwufoGEVMH2Z60BWywbDNeDSWVxZaU
	ppjuLufARrhZnTnCgIvmfANrvSoQmFEClviVBCTd1pxeAGAkCkar
X-Google-Smtp-Source: AGHT+IEVPF55JUIr6GJAfQDwc+O0ordKbTs0fx4HLuaXvJhywQqPe5NIP6rTvx3hPVsLzNrhrbGnPQ==
X-Received: by 2002:a2e:95cf:0:b0:2d4:99f8:8b9f with SMTP id y15-20020a2e95cf000000b002d499f88b9fmr88243ljh.50.1713379964328;
        Wed, 17 Apr 2024 11:52:44 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id b15-20020a05651c032f00b002da6c946722sm1075405ljp.124.2024.04.17.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:52:43 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:52:42 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] dmaengine: dw: Add memory bus width verification
Message-ID: <nroj7c7hvo5ao5gfuububc2zqj7z4rpkoji5flhbrie3xrmgwg@6rhzllxwgj4w>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-3-fancer.lancer@gmail.com>
 <Zh7Hpuo-TzSmlz69@smile.fi.intel.com>
 <lzipslbrr4fkpqc3plfllltls2sy2mrlentp7clpjoppvgscoi@zlmysqym2kyb>
 <ZiAGpsldQMB-dKkn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiAGpsldQMB-dKkn@smile.fi.intel.com>

On Wed, Apr 17, 2024 at 08:28:06PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 17, 2024 at 08:13:59PM +0300, Serge Semin wrote:
> > On Tue, Apr 16, 2024 at 09:47:02PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 16, 2024 at 07:28:56PM +0300, Serge Semin wrote:
> > > > Currently in case of the DEV_TO_MEM or MEM_TO_DEV DMA transfers the memory
> > > > data width (single transfer width) is determined based on the buffer
> > > > length, buffer base address or DMA master-channel max address width
> > > > capability. It isn't enough in case of the channel disabling prior the
> > > > block transfer is finished. Here is what DW AHB DMA IP-core databook says
> > > > regarding the port suspension (DMA-transfer pause) implementation in the
> > > > controller:
> > > > 
> > > > "When CTLx.SRC_TR_WIDTH < CTLx.DST_TR_WIDTH and the CFGx.CH_SUSP bit is
> > > > high, the CFGx.FIFO_EMPTY is asserted once the contents of the FIFO do not
> > > > permit a single word of CTLx.DST_TR_WIDTH to be formed. However, there may
> > > > still be data in the channel FIFO, but not enough to form a single
> > > > transfer of CTLx.DST_TR_WIDTH. In this scenario, once the channel is
> > > > disabled, the remaining data in the channel FIFO is not transferred to the
> > > > destination peripheral."
> > > > 
> > > > So in case if the port gets to be suspended and then disabled it's
> > > > possible to have the data silently discarded even though the controller
> > > > reported that FIFO is empty and the CTLx.BLOCK_TS indicated the dropped
> > > > data already received from the source device. This looks as if the data
> > > > somehow got lost on a way from the peripheral device to memory and causes
> > > > problems for instance in the DW APB UART driver, which pauses and disables
> > > > the DMA-transfer as soon as the recv data timeout happens. Here is the way
> > > > it looks:
> > > > 
> > > >  Memory <------- DMA FIFO <------ UART FIFO <---------------- UART
> > > >   DST_TR_WIDTH -+--------|       |         |
> > > >                 |        |       |         |                No more data
> > > >    Current lvl -+--------|       |---------+- DMA-burst lvl
> > > >                 |        |       |---------+- Leftover data
> > > >                 |        |       |---------+- SRC_TR_WIDTH
> > > >                -+--------+-------+---------+
> > > > 
> > > > In the example above: no more data is getting received over the UART port
> > > > and BLOCK_TS is not even close to be fully received; some data is left in
> > > > the UART FIFO, but not enough to perform a bursted DMA-xfer to the DMA
> > > > FIFO; some data is left in the DMA FIFO, but not enough to be passed
> > > > further to the system memory in a single transfer. In this situation the
> > > > 8250 UART driver catches the recv timeout interrupt, pauses the
> > > > DMA-transfer and terminates it completely, after which the IRQ handler
> > > > manually fetches the leftover data from the UART FIFO into the
> > > > recv-buffer. But since the DMA-channel has been disabled with the data
> > > > left in the DMA FIFO, that data will be just discarded and the recv-buffer
> > > > will have a gap of the "current lvl" size in the recv-buffer at the tail
> > > > of the lately received data portion. So the data will be lost just due to
> > > > the misconfigured DMA transfer.
> > > > 
> > > > Note this is only relevant for the case of the transfer suspension and
> > > > _disabling_. No problem will happen if the transfer will be re-enabled
> > > > afterwards or the block transfer is fully completed. In the later case the
> > > > "FIFO flush mode" will be executed at the transfer final stage in order to
> > > > push out the data left in the DMA FIFO.
> > > > 
> > > > In order to fix the denoted problem the DW AHB DMA-engine driver needs to
> > > > make sure that the _bursted_ source transfer width is greater or equal to
> > > > the single destination transfer (note the HW databook describes more
> > > > strict constraint than actually required). Since the peripheral-device
> > > > side is prescribed by the client driver logic, the memory-side can be only
> > > > used for that. The solution can be easily implemented for the DEV_TO_MEM
> > > > transfers just by adjusting the memory-channel address width. Sadly it's
> > > > not that easy for the MEM_TO_DEV transfers since the mem-to-dma burst size
> > > > is normally dynamically determined by the controller. So the only thing
> > > > that can be done is to make sure that memory-side address width can be
> > > > greater than the peripheral device address width.
> 
> ...
> 
> > > > +static int dwc_verify_m_buswidth(struct dma_chan *chan)
> > > > +{
> > > > +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> > > > +	struct dw_dma *dw = to_dw_dma(chan->device);
> > > > +	u32 reg_width, reg_burst, mem_width;
> > > > +
> > > > +	mem_width = dw->pdata->data_width[dwc->dws.m_master];
> > > > +
> > > > +	/* Make sure src and dst word widths are coherent */
> > > > +	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV) {
> > > > +		reg_width = dwc->dma_sconfig.dst_addr_width;
> > > > +		if (mem_width < reg_width)
> > > > +			return -EINVAL;
> > > > +
> > > > +		dwc->dma_sconfig.src_addr_width = mem_width;
> > > > +	} else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM) {
> > > > +		reg_width = dwc->dma_sconfig.src_addr_width;
> > > > +		reg_burst = rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
> > > > +
> > > > +		dwc->dma_sconfig.dst_addr_width = min(mem_width, reg_width * reg_burst);
> > > 
> > 
> > > I understand the desire to go this way, but wouldn't be better to have
> > > a symmetrical check and return an error?
> > 
> > Sadly the situation isn't symmetrical.
> > 
> > The main idea of the solution proposed in this patch is to make sure
> > that the DMA transactions would fill in the DMA FIFO in a way so in
> > case of the suspension all the data would be delivered to the
> > destination with nothing left in the DMA FIFO and the CFGx.FIFO_EMPTY
> > flag would mean the real FIFO emptiness. It can be reached only if
> > (CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE) >= CTLx.DST_TR_WIDTH
> > (calculated in the real values of course). But CTLx.SRC_MSIZE is only
> > relevant for the flow-control/non-memory peripherals. Thus the
> 

> Oh, if it involves flow control, shouldn't you check for that as well?
> We have a (PPC? IIRC) hardware with this IP that can have peripheral
> as flow control.

Oops. Sorry, I was wrong in saying that the peripheral is a
flow-controller. All my cases imply DMAC as flow-controller. The
correct sentence would be "But CTLx.SRC_MSIZE is only relevant for the
non-memory peripherals."

> 
> > conditions under which the problem can be avoided are:
> > 
> > DMA_MEM_TO_DEV: CTLx.SRC_TR_WIDTH >= CTLx.DST_TR_WIDTH
> > DMA_DEV_TO_MEM: CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE >= CTLx.DST_TR_WIDTH
> > 
> > In both cases the non-memory peripheral side parameters (DEV-side)
> > can't be changed because they are selected by the client drivers based
> > on their specific logic (Device FIFO depth, watermarks, CSR widths,
> > etc). But we can vary the memory-side transfer width as long as it's
> > within the permitted limits.
> > 
> > In case of the DMA_MEM_TO_DEV transfers we can change the
> > CTLx.SRC_TR_WIDTH because it represents the memory side transfer
> > width. But if the maximum memory transfer width is smaller than the
> > specified destination register width, there is nothing we can do. Thus
> > returning the EINVAL error. Note this is mainly a hypothetical
> > situation since normally the max width of the memory master xfers is
> > greater than the peripheral master xfer max width (in my case it's 128
> > and 32 bits respectively).
> > 
> > In case of the DMA_DEV_TO_MEM transfers we can change the CTLx.DST_TR_WIDTH
> > parameter because it's the memory side. Thus if the maximum
> > memory transfer width is smaller than the bursted source transfer,
> > then we can stick to the maximum memory transfer width. But if it's
> > greater than the bursted source transfer, we can freely reduce it
> > so to support the safe suspension+disable DMA-usage pattern.
> > 
> > > 
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > 
> > > IIRC MEM side of the DMA channel will ignore those in HW, so basically you are
> > > (re-)using them purely for the __ffs() corrections.
> > 
> > No. DMAC ignores the _burst length_ parameters CTLx.SRC_MSIZE and
> > CTLx.DEST_MSIZE for the memory side (also see my comment above):
> > 
> > "The CTLx.SRC_MSIZE and CTLx.DEST_MSIZE are properties valid only for
> > peripherals with a handshaking interface; they cannot be used for
> > defining the burst length for memory peripherals.
> > 
> > When the peripherals are memory, the DW_ahb_dmac is always the flow
> > controller and uses DMA transfers to move blocks; thus the
> > CTLx.SRC_MSIZE and CTLx.DEST_MSIZE values are not used for memory
> > peripherals. The SRC_MSIZE/DEST_MSIZE limitations are used to
> > accommodate devices that have limited resources, such as a FIFO.
> > Memory does not normally have limitations similar to the FIFOs."
> > 
> > In my case the problem is in the CTLx.SRC_TR_WIDTH and
> > CTLx.DST_TR_WIDTH values misconfiguration. Here is the crucial comment
> > in the HW-manual about that (cited in the commit messages):
> > 
> > "When CTLx.SRC_TR_WIDTH < CTLx.DST_TR_WIDTH and the CFGx.CH_SUSP bit is
> > high, the CFGx.FIFO_EMPTY is asserted once the contents of the FIFO do not
> > permit a single word of CTLx.DST_TR_WIDTH to be formed. However, there may
> > still be data in the channel FIFO, but not enough to form a single
> > transfer of CTLx.DST_TR_WIDTH. In this scenario, once the channel is
> > disabled, the remaining data in the channel FIFO is not transferred to the
> > destination peripheral."
> > 
> > See Chapter 7.7 "Disabling a Channel Prior to Transfer Completion" of
> > the DW DMAC HW manual for more details.
> 

> Got it. Maybe a little summary in the code to explain all this magic?

Will it be enough to add something like this:
/*
 * It's possible to have a data portion locked in the DMA FIFO in case
 * of the channel suspension. Subsequent channel disabling will cause
 * that data silent loss. In order to prevent that maintain the src
 * and dst transfer widths coherency by means of the relation:
 * (CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE >= CTLx.DST_TR_WIDTH)
 */
?

-Serge(y)

> 
> ...
> 
> > > >  	dwc->dma_sconfig.src_maxburst =
> > > > -		clamp(dwc->dma_sconfig.src_maxburst, 0U, dwc->max_burst);
> > > > +		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
> > > >  	dwc->dma_sconfig.dst_maxburst =
> > > > -		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
> > > > +		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

