Return-Path: <dmaengine+bounces-1872-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 666AB8A8A29
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 19:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AFA1C21BF9
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91BC171678;
	Wed, 17 Apr 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8J8Oi/J"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE316FF52;
	Wed, 17 Apr 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374894; cv=none; b=o3f9m1ffl8gCMWmk+towI83xRoEBdQQKWIQArW0HsscNp1w2vhDhXo6IrjY4n6ocW09O0frS3taE4RPZ7A7lmgNtIc6vPAIUmrEJFN6Use1MnIZvYrR9Qn3tFn/2ZtuSMk0EEhdWa4Cfmx7T2Yo8Xndg3HGBTGTqx+k2aN0ETgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374894; c=relaxed/simple;
	bh=oPZxgfSsc9EeEBm+XEY2LfevwwdvWe2DRuzWIBF6D/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+sGHkyx5ezi8V8zkCACu1n5wqyIKXtyjnGwtH8kUZMgq6fmOYcajfwSqA4ZEMfBTZ2CO+mvDyaIhiDKCM2nk8P8QZerhkbEuTfujllFIA8JF6Hqbw+nOCCJri/ydg5P7xG8hexi4S25Q/PKhrFBtAu0P5YbAXGv+2Lo6YYHQmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8J8Oi/J; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713374893; x=1744910893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oPZxgfSsc9EeEBm+XEY2LfevwwdvWe2DRuzWIBF6D/4=;
  b=Q8J8Oi/JHRZaV0QUZkeJ+05jpijUVgafaCl9Sz4QIvLmKyOg+spKVHVU
   rojWaWvqvxN3X+270cEFNgEv7L8HVjFrQhQhu8V3O4inu/XVyFvtQTPPz
   VyWbWf8GLSmMVWOBdRgmt8AkRViC+KY8RZ701X5At62Ct8O2vL9nO5nnG
   mqzco1s905UAae/9Yx+OBsMgDeNPPARWUmGkNg7Vkjhshi8zZhS4neSK8
   PTc//kJuEFBAfncXU2K/IuJ4ccQYezU7olmOOXVoxZtilzvz5uoawCKij
   /8LjE9gCKUyMfFkUhKu7bFOAlEJTba0A8j+x8fiYu339pdcHCbvy4/Ynj
   Q==;
X-CSE-ConnectionGUID: a/pIwFouRnaUwOU3N9zbng==
X-CSE-MsgGUID: FFUlY6zdQZeawYQcvGOjpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20031496"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="20031496"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:28:12 -0700
X-CSE-ConnectionGUID: 7/REKtTHTn6s6/OznTIrdg==
X-CSE-MsgGUID: RtWcpmSuSxWhnv+3UDAuKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27329719"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:28:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rx94p-000000006zn-0RXK;
	Wed, 17 Apr 2024 20:28:07 +0300
Date: Wed, 17 Apr 2024 20:28:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] dmaengine: dw: Add memory bus width verification
Message-ID: <ZiAGpsldQMB-dKkn@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-3-fancer.lancer@gmail.com>
 <Zh7Hpuo-TzSmlz69@smile.fi.intel.com>
 <lzipslbrr4fkpqc3plfllltls2sy2mrlentp7clpjoppvgscoi@zlmysqym2kyb>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lzipslbrr4fkpqc3plfllltls2sy2mrlentp7clpjoppvgscoi@zlmysqym2kyb>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 08:13:59PM +0300, Serge Semin wrote:
> On Tue, Apr 16, 2024 at 09:47:02PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 16, 2024 at 07:28:56PM +0300, Serge Semin wrote:
> > > Currently in case of the DEV_TO_MEM or MEM_TO_DEV DMA transfers the memory
> > > data width (single transfer width) is determined based on the buffer
> > > length, buffer base address or DMA master-channel max address width
> > > capability. It isn't enough in case of the channel disabling prior the
> > > block transfer is finished. Here is what DW AHB DMA IP-core databook says
> > > regarding the port suspension (DMA-transfer pause) implementation in the
> > > controller:
> > > 
> > > "When CTLx.SRC_TR_WIDTH < CTLx.DST_TR_WIDTH and the CFGx.CH_SUSP bit is
> > > high, the CFGx.FIFO_EMPTY is asserted once the contents of the FIFO do not
> > > permit a single word of CTLx.DST_TR_WIDTH to be formed. However, there may
> > > still be data in the channel FIFO, but not enough to form a single
> > > transfer of CTLx.DST_TR_WIDTH. In this scenario, once the channel is
> > > disabled, the remaining data in the channel FIFO is not transferred to the
> > > destination peripheral."
> > > 
> > > So in case if the port gets to be suspended and then disabled it's
> > > possible to have the data silently discarded even though the controller
> > > reported that FIFO is empty and the CTLx.BLOCK_TS indicated the dropped
> > > data already received from the source device. This looks as if the data
> > > somehow got lost on a way from the peripheral device to memory and causes
> > > problems for instance in the DW APB UART driver, which pauses and disables
> > > the DMA-transfer as soon as the recv data timeout happens. Here is the way
> > > it looks:
> > > 
> > >  Memory <------- DMA FIFO <------ UART FIFO <---------------- UART
> > >   DST_TR_WIDTH -+--------|       |         |
> > >                 |        |       |         |                No more data
> > >    Current lvl -+--------|       |---------+- DMA-burst lvl
> > >                 |        |       |---------+- Leftover data
> > >                 |        |       |---------+- SRC_TR_WIDTH
> > >                -+--------+-------+---------+
> > > 
> > > In the example above: no more data is getting received over the UART port
> > > and BLOCK_TS is not even close to be fully received; some data is left in
> > > the UART FIFO, but not enough to perform a bursted DMA-xfer to the DMA
> > > FIFO; some data is left in the DMA FIFO, but not enough to be passed
> > > further to the system memory in a single transfer. In this situation the
> > > 8250 UART driver catches the recv timeout interrupt, pauses the
> > > DMA-transfer and terminates it completely, after which the IRQ handler
> > > manually fetches the leftover data from the UART FIFO into the
> > > recv-buffer. But since the DMA-channel has been disabled with the data
> > > left in the DMA FIFO, that data will be just discarded and the recv-buffer
> > > will have a gap of the "current lvl" size in the recv-buffer at the tail
> > > of the lately received data portion. So the data will be lost just due to
> > > the misconfigured DMA transfer.
> > > 
> > > Note this is only relevant for the case of the transfer suspension and
> > > _disabling_. No problem will happen if the transfer will be re-enabled
> > > afterwards or the block transfer is fully completed. In the later case the
> > > "FIFO flush mode" will be executed at the transfer final stage in order to
> > > push out the data left in the DMA FIFO.
> > > 
> > > In order to fix the denoted problem the DW AHB DMA-engine driver needs to
> > > make sure that the _bursted_ source transfer width is greater or equal to
> > > the single destination transfer (note the HW databook describes more
> > > strict constraint than actually required). Since the peripheral-device
> > > side is prescribed by the client driver logic, the memory-side can be only
> > > used for that. The solution can be easily implemented for the DEV_TO_MEM
> > > transfers just by adjusting the memory-channel address width. Sadly it's
> > > not that easy for the MEM_TO_DEV transfers since the mem-to-dma burst size
> > > is normally dynamically determined by the controller. So the only thing
> > > that can be done is to make sure that memory-side address width can be
> > > greater than the peripheral device address width.

...

> > > +static int dwc_verify_m_buswidth(struct dma_chan *chan)
> > > +{
> > > +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> > > +	struct dw_dma *dw = to_dw_dma(chan->device);
> > > +	u32 reg_width, reg_burst, mem_width;
> > > +
> > > +	mem_width = dw->pdata->data_width[dwc->dws.m_master];
> > > +
> > > +	/* Make sure src and dst word widths are coherent */
> > > +	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV) {
> > > +		reg_width = dwc->dma_sconfig.dst_addr_width;
> > > +		if (mem_width < reg_width)
> > > +			return -EINVAL;
> > > +
> > > +		dwc->dma_sconfig.src_addr_width = mem_width;
> > > +	} else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM) {
> > > +		reg_width = dwc->dma_sconfig.src_addr_width;
> > > +		reg_burst = rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
> > > +
> > > +		dwc->dma_sconfig.dst_addr_width = min(mem_width, reg_width * reg_burst);
> > 
> 
> > I understand the desire to go this way, but wouldn't be better to have
> > a symmetrical check and return an error?
> 
> Sadly the situation isn't symmetrical.
> 
> The main idea of the solution proposed in this patch is to make sure
> that the DMA transactions would fill in the DMA FIFO in a way so in
> case of the suspension all the data would be delivered to the
> destination with nothing left in the DMA FIFO and the CFGx.FIFO_EMPTY
> flag would mean the real FIFO emptiness. It can be reached only if
> (CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE) >= CTLx.DST_TR_WIDTH
> (calculated in the real values of course). But CTLx.SRC_MSIZE is only
> relevant for the flow-control/non-memory peripherals. Thus the

Oh, if it involves flow control, shouldn't you check for that as well?
We have a (PPC? IIRC) hardware with this IP that can have peripheral
as flow control.

> conditions under which the problem can be avoided are:
> 
> DMA_MEM_TO_DEV: CTLx.SRC_TR_WIDTH >= CTLx.DST_TR_WIDTH
> DMA_DEV_TO_MEM: CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE >= CTLx.DST_TR_WIDTH
> 
> In both cases the non-memory peripheral side parameters (DEV-side)
> can't be changed because they are selected by the client drivers based
> on their specific logic (Device FIFO depth, watermarks, CSR widths,
> etc). But we can vary the memory-side transfer width as long as it's
> within the permitted limits.
> 
> In case of the DMA_MEM_TO_DEV transfers we can change the
> CTLx.SRC_TR_WIDTH because it represents the memory side transfer
> width. But if the maximum memory transfer width is smaller than the
> specified destination register width, there is nothing we can do. Thus
> returning the EINVAL error. Note this is mainly a hypothetical
> situation since normally the max width of the memory master xfers is
> greater than the peripheral master xfer max width (in my case it's 128
> and 32 bits respectively).
> 
> In case of the DMA_DEV_TO_MEM transfers we can change the CTLx.DST_TR_WIDTH
> parameter because it's the memory side. Thus if the maximum
> memory transfer width is smaller than the bursted source transfer,
> then we can stick to the maximum memory transfer width. But if it's
> greater than the bursted source transfer, we can freely reduce it
> so to support the safe suspension+disable DMA-usage pattern.
> 
> > 
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> 
> > IIRC MEM side of the DMA channel will ignore those in HW, so basically you are
> > (re-)using them purely for the __ffs() corrections.
> 
> No. DMAC ignores the _burst length_ parameters CTLx.SRC_MSIZE and
> CTLx.DEST_MSIZE for the memory side (also see my comment above):
> 
> "The CTLx.SRC_MSIZE and CTLx.DEST_MSIZE are properties valid only for
> peripherals with a handshaking interface; they cannot be used for
> defining the burst length for memory peripherals.
> 
> When the peripherals are memory, the DW_ahb_dmac is always the flow
> controller and uses DMA transfers to move blocks; thus the
> CTLx.SRC_MSIZE and CTLx.DEST_MSIZE values are not used for memory
> peripherals. The SRC_MSIZE/DEST_MSIZE limitations are used to
> accommodate devices that have limited resources, such as a FIFO.
> Memory does not normally have limitations similar to the FIFOs."
> 
> In my case the problem is in the CTLx.SRC_TR_WIDTH and
> CTLx.DST_TR_WIDTH values misconfiguration. Here is the crucial comment
> in the HW-manual about that (cited in the commit messages):
> 
> "When CTLx.SRC_TR_WIDTH < CTLx.DST_TR_WIDTH and the CFGx.CH_SUSP bit is
> high, the CFGx.FIFO_EMPTY is asserted once the contents of the FIFO do not
> permit a single word of CTLx.DST_TR_WIDTH to be formed. However, there may
> still be data in the channel FIFO, but not enough to form a single
> transfer of CTLx.DST_TR_WIDTH. In this scenario, once the channel is
> disabled, the remaining data in the channel FIFO is not transferred to the
> destination peripheral."
> 
> See Chapter 7.7 "Disabling a Channel Prior to Transfer Completion" of
> the DW DMAC HW manual for more details.

Got it. Maybe a little summary in the code to explain all this magic?

...

> > >  	dwc->dma_sconfig.src_maxburst =
> > > -		clamp(dwc->dma_sconfig.src_maxburst, 0U, dwc->max_burst);
> > > +		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
> > >  	dwc->dma_sconfig.dst_maxburst =
> > > -		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
> > > +		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);

-- 
With Best Regards,
Andy Shevchenko



