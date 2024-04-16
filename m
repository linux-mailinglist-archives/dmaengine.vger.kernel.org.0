Return-Path: <dmaengine+bounces-1852-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7924C8A73D1
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 20:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A4D282701
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2BD13775D;
	Tue, 16 Apr 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpAzZnHr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B947134CFA;
	Tue, 16 Apr 2024 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293230; cv=none; b=BsC9pcdapi431BgF27aZ1gwtA5bxb8GvtBmkka0VTBS9Ri+Dn21dSqym77zro5irVLMGBqh9EsTcTVs4rn+YEMSx+KsNgTxfX2Y4zzjDG+IH+JRYoUJhfkwHX2h62vuVrY47tSg0j3qhsvT7LNSqcoNEvkB50x/ubyUzRZtL/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293230; c=relaxed/simple;
	bh=sLh7jAnxEgDhzrphM2vEc6n61fuaaaO6jruIdretCgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnWj49opBVXqAHIvhDINZaBUHYZPtgh+dKe5e2YXJnd/kKruDF0EIdSYVRWK6kwkrY+rLECWp/u2v35oCoyT35b9iyq/lkWFpUPIATslj0X1UsR62gTYz+etB65CgA90VTJPEFpRFcgrVyZ/qSXO2Sttg5WNIemJ8yNiSksf9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpAzZnHr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713293229; x=1744829229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sLh7jAnxEgDhzrphM2vEc6n61fuaaaO6jruIdretCgo=;
  b=fpAzZnHrcytTBpZ3LfofDSpFuLuiIaP6maCbJfjmKEkxZaIv3bWqfK6U
   /UKtqJBZRtP2mmjkt4dcwa/hxwkKDjFhWMuzG2JCcGRknRZ3f/gYpqPfO
   SlBbcBN/Jh23UD+QGw3fjJYsPUJOgdpbPQChO4hmFS21twUt4B6+TyZ3e
   EFz6XCGBRXUSwqN/YFSHTbVKEirezrVlexSjitMkMd75tLW9ei8bs/7j0
   G21dahg4Y3W7rklPFj+8Zegfn/28aS12su/zNUUTLVUQZP4eBvp7+/xYL
   TcwkBXlzUDh8udHzGfch3i7bHQlzhWRheVz8/ySAzwfT+zjMwNKyzUBzu
   w==;
X-CSE-ConnectionGUID: 9pOB0gXcQpy5MlprmTVsgw==
X-CSE-MsgGUID: 2AC8O8geRQm4iTCxti+csw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8635859"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8635859"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:47:08 -0700
X-CSE-ConnectionGUID: w3p3xxn4RA2V89Fo/JnbYw==
X-CSE-MsgGUID: SewNWemiSEWsv6xMweAcTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22422655"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:47:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwnpe-00000004nLf-2an3;
	Tue, 16 Apr 2024 21:47:02 +0300
Date: Tue, 16 Apr 2024 21:47:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] dmaengine: dw: Add memory bus width verification
Message-ID: <Zh7Hpuo-TzSmlz69@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416162908.24180-3-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 07:28:56PM +0300, Serge Semin wrote:
> Currently in case of the DEV_TO_MEM or MEM_TO_DEV DMA transfers the memory
> data width (single transfer width) is determined based on the buffer
> length, buffer base address or DMA master-channel max address width
> capability. It isn't enough in case of the channel disabling prior the
> block transfer is finished. Here is what DW AHB DMA IP-core databook says
> regarding the port suspension (DMA-transfer pause) implementation in the
> controller:
> 
> "When CTLx.SRC_TR_WIDTH < CTLx.DST_TR_WIDTH and the CFGx.CH_SUSP bit is
> high, the CFGx.FIFO_EMPTY is asserted once the contents of the FIFO do not
> permit a single word of CTLx.DST_TR_WIDTH to be formed. However, there may
> still be data in the channel FIFO, but not enough to form a single
> transfer of CTLx.DST_TR_WIDTH. In this scenario, once the channel is
> disabled, the remaining data in the channel FIFO is not transferred to the
> destination peripheral."
> 
> So in case if the port gets to be suspended and then disabled it's
> possible to have the data silently discarded even though the controller
> reported that FIFO is empty and the CTLx.BLOCK_TS indicated the dropped
> data already received from the source device. This looks as if the data
> somehow got lost on a way from the peripheral device to memory and causes
> problems for instance in the DW APB UART driver, which pauses and disables
> the DMA-transfer as soon as the recv data timeout happens. Here is the way
> it looks:
> 
>  Memory <------- DMA FIFO <------ UART FIFO <---------------- UART
>   DST_TR_WIDTH -+--------|       |         |
>                 |        |       |         |                No more data
>    Current lvl -+--------|       |---------+- DMA-burst lvl
>                 |        |       |---------+- Leftover data
>                 |        |       |---------+- SRC_TR_WIDTH
>                -+--------+-------+---------+
> 
> In the example above: no more data is getting received over the UART port
> and BLOCK_TS is not even close to be fully received; some data is left in
> the UART FIFO, but not enough to perform a bursted DMA-xfer to the DMA
> FIFO; some data is left in the DMA FIFO, but not enough to be passed
> further to the system memory in a single transfer. In this situation the
> 8250 UART driver catches the recv timeout interrupt, pauses the
> DMA-transfer and terminates it completely, after which the IRQ handler
> manually fetches the leftover data from the UART FIFO into the
> recv-buffer. But since the DMA-channel has been disabled with the data
> left in the DMA FIFO, that data will be just discarded and the recv-buffer
> will have a gap of the "current lvl" size in the recv-buffer at the tail
> of the lately received data portion. So the data will be lost just due to
> the misconfigured DMA transfer.
> 
> Note this is only relevant for the case of the transfer suspension and
> _disabling_. No problem will happen if the transfer will be re-enabled
> afterwards or the block transfer is fully completed. In the later case the
> "FIFO flush mode" will be executed at the transfer final stage in order to
> push out the data left in the DMA FIFO.
> 
> In order to fix the denoted problem the DW AHB DMA-engine driver needs to
> make sure that the _bursted_ source transfer width is greater or equal to
> the single destination transfer (note the HW databook describes more
> strict constraint than actually required). Since the peripheral-device
> side is prescribed by the client driver logic, the memory-side can be only
> used for that. The solution can be easily implemented for the DEV_TO_MEM
> transfers just by adjusting the memory-channel address width. Sadly it's
> not that easy for the MEM_TO_DEV transfers since the mem-to-dma burst size
> is normally dynamically determined by the controller. So the only thing
> that can be done is to make sure that memory-side address width can be
> greater than the peripheral device address width.

...

> +static int dwc_verify_m_buswidth(struct dma_chan *chan)
> +{
> +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> +	struct dw_dma *dw = to_dw_dma(chan->device);
> +	u32 reg_width, reg_burst, mem_width;
> +
> +	mem_width = dw->pdata->data_width[dwc->dws.m_master];
> +
> +	/* Make sure src and dst word widths are coherent */
> +	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV) {
> +		reg_width = dwc->dma_sconfig.dst_addr_width;
> +		if (mem_width < reg_width)
> +			return -EINVAL;
> +
> +		dwc->dma_sconfig.src_addr_width = mem_width;
> +	} else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM) {
> +		reg_width = dwc->dma_sconfig.src_addr_width;
> +		reg_burst = rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
> +
> +		dwc->dma_sconfig.dst_addr_width = min(mem_width, reg_width * reg_burst);

I understand the desire to go this way, but wouldn't be better to have
a symmetrical check and return an error?

> +	}
> +
> +	return 0;
> +}

IIRC MEM side of the DMA channel will ignore those in HW, so basically you are
(re-)using them purely for the __ffs() corrections.

...

>  	dwc->dma_sconfig.src_maxburst =
> -		clamp(dwc->dma_sconfig.src_maxburst, 0U, dwc->max_burst);
> +		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
>  	dwc->dma_sconfig.dst_maxburst =
> -		clamp(dwc->dma_sconfig.dst_maxburst, 0U, dwc->max_burst);
> +		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);

-- 
With Best Regards,
Andy Shevchenko



