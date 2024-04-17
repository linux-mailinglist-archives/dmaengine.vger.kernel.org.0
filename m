Return-Path: <dmaengine+bounces-1868-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 070738A8A0A
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 19:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7378B1F249E0
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E025217166B;
	Wed, 17 Apr 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhYLUlDN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0127214199C;
	Wed, 17 Apr 2024 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374045; cv=none; b=KocJIUaP7sbBB94aCOHLtjd9b2ugACMRLxrxfZKuAS8dAFivDGPq0v96QpQuKMicJZ+2TtfhybGCzDs65y7zDqI7xYq7ciUJ1YckpPFxjUAKtMeeQPwzCeJedYpdQp6YxHUFv+Z8/UawV6xMk4hkhzGhei7XZycZxVCSmpnfLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374045; c=relaxed/simple;
	bh=lj8aJUMl44Y4DxflO3LqH+eNRX9TRbSUMZYJVsKLiY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlyBMCXqI7r4mJO1tCuBtxXRIzrrxQB1lsUR/o3j505ftBZseEdJgDpl3WCjR9R6f+LuWeObtrU92K/bMtGZxXlvHnn6yfa9MvQMkaWxam0kK2EcggzTUkvTHASt7gAFuI4gUR/1o0cp/S+h2stCOBrKYqbIgM/EY9JhjYUBKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhYLUlDN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518f8a69f82so4004157e87.2;
        Wed, 17 Apr 2024 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713374042; x=1713978842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1WlPy7Sg/AbF3lG9IuHJ6Ld8oFGaFqFMXHnnnRw8iY=;
        b=WhYLUlDNmg0Gy24mY+BdQ5ly1WLwqnWUuIeWK3ls/lUIQMp6yt6/IBX2fHTONVh+3U
         TvmdjwaQlFSyOFIOByPjazWOIWcR3QcdBAncxF+QMpQRdaxE00xtYMelpoEs58G2aJMg
         +a4s1ck6oVcDNTXgKKlPQkpIGLOOZ9mUXqybXI2cRdW0vvCLTBv3U7z4oXh30AVkq6vv
         LdXNZ71+Wca3/b2+rojo92fMqtfunEGq7GDHRx9+fQV1tTF87KiTanDe6XUvVuwT8aGI
         7HlCDdBfX6Euahbqa4Zp+0Ile5m5Ru18H0PAkXZK93gEJbjBBDcSNPUtftz5AS3GQKNQ
         USnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374042; x=1713978842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1WlPy7Sg/AbF3lG9IuHJ6Ld8oFGaFqFMXHnnnRw8iY=;
        b=Qn6LWCTjX5WihT8n7Bc1X7gUOsVraOeAeMOy02okmO6mPgdu5Pm6VWIVeEaQhljJtb
         zalJwZjppy2s53IS/CXMbGu87tjzZZUf5UNoENxLuSzXRiupDt3Xnyso7GTkwPk/wxlM
         XupSj0I/ryFzR3U2eZ2cQ87wcg+DKjN7eJ26/+BswQI32lejIugpbEW+3c+/mrR13dGj
         7eUP80boKOALS9YzgbsVZcebodInTjhW9F6gQyzjHBVI0CF93d2GS4bl/OI3BZqazU48
         lrvI21rO/7IIVSnxCN2QuaEGy8kLHWtmFg7rLjutCdowazWS80k2AQyw8tM0zw5O6QxL
         ZZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcR7nsa29sO+llogQHgUoi2ifIjUmu7WP8mHvYqwjU0bAx5aKR0QzOK70kedtLYbVRPon2Z6mRT+muhm9NjP5c7F1D1Vzfw6EzQeXffBC7aKdYbVE3Tiboj8OqaVgWk6RzAghOGjf6z8z/aKc/0W7iJg03PIOxQe/gUIDM8cxzNRNIqdU9
X-Gm-Message-State: AOJu0Yyfigh2bBUqh6t2rYIm7Zt5uWsFNp8ze40qJrqlbXTAjOsHkTsR
	Ql0oMun+MOCmFEU5kTart4J/faQtpV80xZkgSZ4ZyN2UtiMoEk1ctqjniw==
X-Google-Smtp-Source: AGHT+IGcIV12jfWYrHmoGAn10S6hsqSnQ+zpqC4kPUQUcwpfqg33BTEVy4vyYHhM1HSjj7OlnYv7/A==
X-Received: by 2002:ac2:46e6:0:b0:518:c2fb:a365 with SMTP id q6-20020ac246e6000000b00518c2fba365mr8484901lfo.31.1713374041742;
        Wed, 17 Apr 2024 10:14:01 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id z18-20020a19f712000000b00518e3a194e9sm1078669lfe.304.2024.04.17.10.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:14:01 -0700 (PDT)
Date: Wed, 17 Apr 2024 20:13:59 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] dmaengine: dw: Add memory bus width verification
Message-ID: <lzipslbrr4fkpqc3plfllltls2sy2mrlentp7clpjoppvgscoi@zlmysqym2kyb>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-3-fancer.lancer@gmail.com>
 <Zh7Hpuo-TzSmlz69@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh7Hpuo-TzSmlz69@smile.fi.intel.com>

On Tue, Apr 16, 2024 at 09:47:02PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 16, 2024 at 07:28:56PM +0300, Serge Semin wrote:
> > Currently in case of the DEV_TO_MEM or MEM_TO_DEV DMA transfers the memory
> > data width (single transfer width) is determined based on the buffer
> > length, buffer base address or DMA master-channel max address width
> > capability. It isn't enough in case of the channel disabling prior the
> > block transfer is finished. Here is what DW AHB DMA IP-core databook says
> > regarding the port suspension (DMA-transfer pause) implementation in the
> > controller:
> > 
> > "When CTLx.SRC_TR_WIDTH < CTLx.DST_TR_WIDTH and the CFGx.CH_SUSP bit is
> > high, the CFGx.FIFO_EMPTY is asserted once the contents of the FIFO do not
> > permit a single word of CTLx.DST_TR_WIDTH to be formed. However, there may
> > still be data in the channel FIFO, but not enough to form a single
> > transfer of CTLx.DST_TR_WIDTH. In this scenario, once the channel is
> > disabled, the remaining data in the channel FIFO is not transferred to the
> > destination peripheral."
> > 
> > So in case if the port gets to be suspended and then disabled it's
> > possible to have the data silently discarded even though the controller
> > reported that FIFO is empty and the CTLx.BLOCK_TS indicated the dropped
> > data already received from the source device. This looks as if the data
> > somehow got lost on a way from the peripheral device to memory and causes
> > problems for instance in the DW APB UART driver, which pauses and disables
> > the DMA-transfer as soon as the recv data timeout happens. Here is the way
> > it looks:
> > 
> >  Memory <------- DMA FIFO <------ UART FIFO <---------------- UART
> >   DST_TR_WIDTH -+--------|       |         |
> >                 |        |       |         |                No more data
> >    Current lvl -+--------|       |---------+- DMA-burst lvl
> >                 |        |       |---------+- Leftover data
> >                 |        |       |---------+- SRC_TR_WIDTH
> >                -+--------+-------+---------+
> > 
> > In the example above: no more data is getting received over the UART port
> > and BLOCK_TS is not even close to be fully received; some data is left in
> > the UART FIFO, but not enough to perform a bursted DMA-xfer to the DMA
> > FIFO; some data is left in the DMA FIFO, but not enough to be passed
> > further to the system memory in a single transfer. In this situation the
> > 8250 UART driver catches the recv timeout interrupt, pauses the
> > DMA-transfer and terminates it completely, after which the IRQ handler
> > manually fetches the leftover data from the UART FIFO into the
> > recv-buffer. But since the DMA-channel has been disabled with the data
> > left in the DMA FIFO, that data will be just discarded and the recv-buffer
> > will have a gap of the "current lvl" size in the recv-buffer at the tail
> > of the lately received data portion. So the data will be lost just due to
> > the misconfigured DMA transfer.
> > 
> > Note this is only relevant for the case of the transfer suspension and
> > _disabling_. No problem will happen if the transfer will be re-enabled
> > afterwards or the block transfer is fully completed. In the later case the
> > "FIFO flush mode" will be executed at the transfer final stage in order to
> > push out the data left in the DMA FIFO.
> > 
> > In order to fix the denoted problem the DW AHB DMA-engine driver needs to
> > make sure that the _bursted_ source transfer width is greater or equal to
> > the single destination transfer (note the HW databook describes more
> > strict constraint than actually required). Since the peripheral-device
> > side is prescribed by the client driver logic, the memory-side can be only
> > used for that. The solution can be easily implemented for the DEV_TO_MEM
> > transfers just by adjusting the memory-channel address width. Sadly it's
> > not that easy for the MEM_TO_DEV transfers since the mem-to-dma burst size
> > is normally dynamically determined by the controller. So the only thing
> > that can be done is to make sure that memory-side address width can be
> > greater than the peripheral device address width.
> 
> ...
> 
> > +static int dwc_verify_m_buswidth(struct dma_chan *chan)
> > +{
> > +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> > +	struct dw_dma *dw = to_dw_dma(chan->device);
> > +	u32 reg_width, reg_burst, mem_width;
> > +
> > +	mem_width = dw->pdata->data_width[dwc->dws.m_master];
> > +
> > +	/* Make sure src and dst word widths are coherent */
> > +	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV) {
> > +		reg_width = dwc->dma_sconfig.dst_addr_width;
> > +		if (mem_width < reg_width)
> > +			return -EINVAL;
> > +
> > +		dwc->dma_sconfig.src_addr_width = mem_width;
> > +	} else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM) {
> > +		reg_width = dwc->dma_sconfig.src_addr_width;
> > +		reg_burst = rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
> > +
> > +		dwc->dma_sconfig.dst_addr_width = min(mem_width, reg_width * reg_burst);
> 

> I understand the desire to go this way, but wouldn't be better to have
> a symmetrical check and return an error?

Sadly the situation isn't symmetrical.

The main idea of the solution proposed in this patch is to make sure
that the DMA transactions would fill in the DMA FIFO in a way so in
case of the suspension all the data would be delivered to the
destination with nothing left in the DMA FIFO and the CFGx.FIFO_EMPTY
flag would mean the real FIFO emptiness. It can be reached only if
(CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE) >= CTLx.DST_TR_WIDTH
(calculated in the real values of course). But CTLx.SRC_MSIZE is only
relevant for the flow-control/non-memory peripherals. Thus the
conditions under which the problem can be avoided are:

DMA_MEM_TO_DEV: CTLx.SRC_TR_WIDTH >= CTLx.DST_TR_WIDTH
DMA_DEV_TO_MEM: CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE >= CTLx.DST_TR_WIDTH

In both cases the non-memory peripheral side parameters (DEV-side)
can't be changed because they are selected by the client drivers based
on their specific logic (Device FIFO depth, watermarks, CSR widths,
etc). But we can vary the memory-side transfer width as long as it's
within the permitted limits.

In case of the DMA_MEM_TO_DEV transfers we can change the
CTLx.SRC_TR_WIDTH because it represents the memory side transfer
width. But if the maximum memory transfer width is smaller than the
specified destination register width, there is nothing we can do. Thus
returning the EINVAL error. Note this is mainly a hypothetical
situation since normally the max width of the memory master xfers is
greater than the peripheral master xfer max width (in my case it's 128
and 32 bits respectively).

In case of the DMA_DEV_TO_MEM transfers we can change the CTLx.DST_TR_WIDTH
parameter because it's the memory side. Thus if the maximum
memory transfer width is smaller than the bursted source transfer,
then we can stick to the maximum memory transfer width. But if it's
greater than the bursted source transfer, we can freely reduce it
so to support the safe suspension+disable DMA-usage pattern.

> 
> > +	}
> > +
> > +	return 0;
> > +}
> 

> IIRC MEM side of the DMA channel will ignore those in HW, so basically you are
> (re-)using them purely for the __ffs() corrections.

No. DMAC ignores the _burst length_ parameters CTLx.SRC_MSIZE and
CTLx.DEST_MSIZE for the memory side (also see my comment above):

"The CTLx.SRC_MSIZE and CTLx.DEST_MSIZE are properties valid only for
peripherals with a handshaking interface; they cannot be used for
defining the burst length for memory peripherals.

When the peripherals are memory, the DW_ahb_dmac is always the flow
controller and uses DMA transfers to move blocks; thus the
CTLx.SRC_MSIZE and CTLx.DEST_MSIZE values are not used for memory
peripherals. The SRC_MSIZE/DEST_MSIZE limitations are used to
accommodate devices that have limited resources, such as a FIFO.
Memory does not normally have limitations similar to the FIFOs."

In my case the problem is in the CTLx.SRC_TR_WIDTH and
CTLx.DST_TR_WIDTH values misconfiguration. Here is the crucial comment
in the HW-manual about that (cited in the commit messages):

"When CTLx.SRC_TR_WIDTH < CTLx.DST_TR_WIDTH and the CFGx.CH_SUSP bit is
high, the CFGx.FIFO_EMPTY is asserted once the contents of the FIFO do not
permit a single word of CTLx.DST_TR_WIDTH to be formed. However, there may
still be data in the channel FIFO, but not enough to form a single
transfer of CTLx.DST_TR_WIDTH. In this scenario, once the channel is
disabled, the remaining data in the channel FIFO is not transferred to the
destination peripheral."

See Chapter 7.7 "Disabling a Channel Prior to Transfer Completion" of
the DW DMAC HW manual for more details.

-Serge(y)

> 
> ...
> 
> >  	dwc->dma_sconfig.src_maxburst =
> > -		clamp(dwc->dma_sconfig.src_maxburst, 0U, dwc->max_burst);
> > +		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
> >  	dwc->dma_sconfig.dst_maxburst =
> > -		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
> > +		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

