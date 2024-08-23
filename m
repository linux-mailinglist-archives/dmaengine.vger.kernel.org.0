Return-Path: <dmaengine+bounces-2937-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9895C992
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 11:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D737B22253
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043DC183CAB;
	Fri, 23 Aug 2024 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVUxILv3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE35152196;
	Fri, 23 Aug 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406537; cv=none; b=AXKbO8EP/ZJW2VPi/FiuniugQic2H9zYK9zOr5n0B4qepW3EgiTQrH8pjzH9/V4lyvANEumq9ZZ9F28rC5y7cmViEV31cWYzKFXfV3wVHcC2newTO1Uyhx96nJG+xP5DwJna3pRvazvW6l3SK4bCtHnYr+wwLOH6WHR1rM5jKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406537; c=relaxed/simple;
	bh=W9N89YhzqvlO0fBSKWIJYkTsvxbbQ36GoRSXjAKhz9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIbjK4mBfRsqhHL4E1Gog+wgxg105jhIHbCohJimNBqaz2jZGmR/R/ixSebi0OX2yhxKpd6i2cYOwUphbfvxCT2lCfHhxCFovzriiIoY96k9E/z8zuQTZ92uHAl57Z7T1o4F3uhW0Uxm5vZV8oil0sJd2FW/KFi7yA6ZhViN4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVUxILv3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5334c018913so1634045e87.0;
        Fri, 23 Aug 2024 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724406534; x=1725011334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Jsp3qoUY0PJ8j/IbtdYraEvZfGixWFqo2ZZSn6+8oE=;
        b=fVUxILv3gKk8QsGfN4+duWWvwDB0BkZoNJA3IFzb099hYKf0FwhYei88xY61dJk6An
         Sxn7YDoIwUpjeEkf9LZ2lMzOd3+UCiVYyEFAP2j2sffxdqGSiuP6lLBb/qaPg4FJ6fbI
         ghEMS28ev5v4c1jyVEz13oRGEJKBlHRxRsJfXTKgnO2hRiZUz/3ePy2ctEFSnqULzHP5
         VHnDFn1J1nvssh4FewWcP0llQp4a1xyZ3oQb2e2cQyqWRvdwvju5TXLWnCxyfFtvgT2s
         GFB9dje/DyNBDX5fkeBRdwYu9MMguIyoxC3woJ9l8HCX5gcCJD+EzWxL7Nks5FTQcEDD
         T6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724406534; x=1725011334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jsp3qoUY0PJ8j/IbtdYraEvZfGixWFqo2ZZSn6+8oE=;
        b=kRxPvdpKw2ZUo7plaEOl3eBjAk+KUXdtlNnAUCv0YVDynjeqcZTnXzbCGTpy2M3W41
         E1nWs7CbaiQn70ISglO/ecF9U8npIUDhhxaN505wDMHRizfoucyqCww8Dg6LJD6f5ah1
         Wnsrw7Ur72wHpXh8scD/o8M7KXoibBrvjqQkIeHeno/kSLXNDvaPG9YIyoOq+ldqjQ3c
         N9JU2l/A+YwhxuMdIjrHfTaZwUqVf8CkioRcmU0GHYHd2M4iiN1J8CsMGwUG78XZ0OIa
         xoUVWoYNnV3fHYRz9CErX19szEixp20CzVQRV070q9EVtF0KhJcW7VaZstkQ/QWpqBxK
         hcSA==
X-Forwarded-Encrypted: i=1; AJvYcCUGgYzNlOsEq2h+5OaEkvN/Ko55VtvogSQvzeGr9ro+LVlsn2nMHC9NTW7WjUqjZ1k0F+bDIJYjn0I=@vger.kernel.org, AJvYcCVpdA1bkhxM1vb4ZtB3EnCC8lWj6uWWni8zs4wxd78g+96bmULmXL55baAMOLPfqchEcazrzXBN8mS8+32Z@vger.kernel.org, AJvYcCWXyFLL7nHRF0QTmvQzBGFl4ygBYvyK3S+4XVKW5uuw28Zk/jySHOwM2YcmdOQyAOnoo+8y4MtGIUC4y7pe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40JLNKdILcUbIOi4IgYuw0ApCwsvfu5wS8oAUC6x4795XI/tY
	zav7uylXH9ZTZ2+xE7YwMydYadXvaRzefhUt9NzSki2hl96gMi9V
X-Google-Smtp-Source: AGHT+IHjqD9ADGMDqCbXuDoNVCBR4+c0OlGiu6DxZ5/6/LUZy5PHClJ6h01k/aOd7tphvITAso+ZJg==
X-Received: by 2002:a05:6512:3ba1:b0:530:dab8:7dde with SMTP id 2adb3069b0e04-5343883b42amr1117363e87.34.1724406533405;
        Fri, 23 Aug 2024 02:48:53 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5343a58d473sm83862e87.62.2024.08.23.02.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:48:52 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:48:50 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] dmaengine: dw: Prevent tx-status calling desc
 callback (Fix UART deadlock!)
Message-ID: <n6grskuq722vnogwp5obiwzv4pxs5bbqddadesffezhvba5cjh@d6shcrvpxujg>
References: <20240802080756.7415-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240802080756.7415-1-fancer.lancer@gmail.com>

Hi folks

Any comments or suggestion about the change? The kernel occasionally
_deadlocks_ without it for the DW UART + DW DMAC hardware setup.

-Serge(y)

On Fri, Aug 02, 2024 at 11:07:51AM +0300, Serge Semin wrote:
> The dmaengine_tx_status() method updating the DMA-descriptors state and
> eventually calling the Tx-descriptors callback may potentially cause
> problems. In particular the deadlock was discovered in DW UART 8250 device
> interacting with DW DMA controller channels. The call-trace causing the
> deadlock is:
> 
> serial8250_handle_irq()
>   uart_port_lock_irqsave(port); ----------------------+
>   handle_rx_dma()                                     |
>     serial8250_rx_dma_flush()                         |
>       __dma_rx_complete()                             |
>         dmaengine_tx_status()                         |
>           dwc_scan_descriptors()                      |
>             dwc_complete_all()                        |
>               dwc_descriptor_complete()               |
>                 dmaengine_desc_callback_invoke()      |
>                   cb->callback(cb->callback_param);   |
>                   ||                                  |
>                   dma_rx_complete();                  |
>                     uart_port_lock_irqsave(port); ----+ <- Deadlock!
> 
> So in case if the DMA-engine finished working at some point before the
> serial8250_rx_dma_flush() invocation and the respective tasklet hasn't
> been executed yet, then calling the dmaengine_tx_status() will cause the
> DMA-descriptors status update and the Tx-descriptor callback invocation.
> Generalizing the case up: if the dmaengine_tx_status() method callee and
> the Tx-descriptor callback refer to the related critical section, then
> calling dmaengine_tx_status() from the Tx-descriptor callback will
> inevitably cause a deadlock around the guarding lock as it happens in the
> Serial 8250 DMA implementation above. (Note the deadlock doesn't happen
> very often, but can be eventually discovered if the being received data
> size is greater than the Rx DMA-buffer size defined in the 8250_dma.c
> driver. In my case reducing the Rx DMA-buffer size increased the deadlock
> probability.)
> 
> The easiest way to fix the deadlock was to just remove the Tx-descriptors
> state update from the DW DMA-engine Tx-descriptor status method
> implementation, as the most of the DMA-engine drivers imply. After this
> fix is applied the Tx-descriptors status will be only updated in the
> framework of the dwc_scan_descriptors() method called from the tasklet
> handling the deferred DMA-controller IRQ.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com
> 
> ---
> 
> Note I have doubts whether it's the best possible solution of the problem
> since the client-driver deadlock is resolved here by fixing the DMA-engine
> provider code. But I failed to find any reasonable solution in the 8250
> DMA implementation.
> 
> Moreover the suggested fix cause a weird outcome - under the high-speed
> and heavy serial transfers the next error is printed to the log sometimes:
> 
> > dma dma0chan0: BUG: XFER bit set, but channel not idle!
> 
> That's why the patch submitted as RFC. Do you have any better idea in mind
> to prevent the nested lock?
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> CC: Andy Shevchenko <andy@kernel.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/dma/dw/core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 5f7d690e3dba..4b3402156eae 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -925,12 +925,6 @@ dwc_tx_status(struct dma_chan *chan,
>  	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
>  	enum dma_status		ret;
>  
> -	ret = dma_cookie_status(chan, cookie, txstate);
> -	if (ret == DMA_COMPLETE)
> -		return ret;
> -
> -	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
> -
>  	ret = dma_cookie_status(chan, cookie, txstate);
>  	if (ret == DMA_COMPLETE)
>  		return ret;
> -- 
> 2.43.0
> 

