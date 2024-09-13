Return-Path: <dmaengine+bounces-3155-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82C977C2B
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2024 11:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C975B235EC
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2024 09:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B5B1D6DC2;
	Fri, 13 Sep 2024 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIuA0wut"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E41D6DBA;
	Fri, 13 Sep 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219520; cv=none; b=jGR6RXKmLybro/+fZuscoeMIHyvXeYCI9M7xNfcQRyDSN0lgnNVIs+uBxuJxJLOPELKB2JLyX/5SzlPaTwtUBU3XsDGrheo0N1Nonfg8+TIBOt3CwwLtDPMAAKDcp81T6Ilg6uf3NwQR/sq3LVVmdsD8uSIaDoZFg8RGTzYqIJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219520; c=relaxed/simple;
	bh=P4z8wsrIukugVcUAabiMKYqgA7cwXLBlTfTssx8gRls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjA8zjb32Oc56P6fmZ8dAhj5p8hX5tbuBZ+tz0qzN/dJdG/3HXB8/Asd49UJHp5ObmXdeTuAkOTL2m3t/400SCXz/sE7XtGDJMo7GmIEuWbJ7a9ZfvFqWf0mUuHtACEVTIWr+AxIgtNhL5kzHnKQ9TzUC8kRFn8j7ERWYoqB1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIuA0wut; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5356bb5522bso945398e87.1;
        Fri, 13 Sep 2024 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726219516; x=1726824316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CI4Maz5MhJSMSrbd8vlUHHvRPYzjBKBQbweDpVS4Wzc=;
        b=gIuA0wutlQNIz1U/dgx2MiLDczDmbs6iNioa5TXrz1YTq4V4rS/HoYs6CbEkkiLQiM
         MCYr/M4gaGtF2LkCtPKhfEkq7e8F6891nuuetI6fYgVQLaD+ri6ZAy4gjSJtbokUBV9Q
         jfiKm6qmbZd5UHgS96BvfLc8+MvGi7uwgBlkB2Qx22yGvixE65N55f1aXnf6/u9Me0uG
         XtqhjBMTmNrxL6+bBkbghQWwQby/a4a2BApEqymfGfg06mtQIpnZtuzERY6h6BQ/kaXg
         HgN/oGWc8j8E4d9KCpGZvdxgmIGo8/U9psYI4lESYYxw7n4JjOeE3/DNHMxfB8W6GkWj
         leRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726219516; x=1726824316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI4Maz5MhJSMSrbd8vlUHHvRPYzjBKBQbweDpVS4Wzc=;
        b=D9NLpkE57/lf+yWaFWgUzH82eoslYTxa9rYsVrxQm2UIs+rGsU+gGKAKbTCc1rYOcR
         VaP4WjMuSRt4+STnINmvLePYFJmo3TI/qkd2Z132mLCnw1/wSwW+XRg2qmXJ+0psu+TL
         TVvIQTVPFZuLXveprXmwe3oHInTapsg/t7+yrdM1hhDpyE3UtMhgH3w/+PjSUvwaOOYd
         LYn60HVRxCrqIzGC121pN/5cnKvpwj0y2W0Y8MRMXjIUH+CiIb41VKaC7vjJErq1ZaLW
         66YNiR1IeiF4bw/fYI7H42QxiNUYj7V9Wr6xdR74nthNu2AT06k9oElvtnc9Hhzm9Db4
         SWDw==
X-Forwarded-Encrypted: i=1; AJvYcCVC1d3045GqIf4qP493jbE2UUdySFzGL386QInxQhsct6Ho33cuUA6wkgPEMKlHDRs4AqeQbKgad+NGQLC1@vger.kernel.org, AJvYcCWej4nlqMyqLypB5tlB4Tv8chuSw1eeoh8vGC4AKfdyFKt8F7SXQ/nuprUBbv2MfThRm7JdBgbeoJCAVP0K@vger.kernel.org, AJvYcCXluuWRaOKbUFzVwsixuuxY8gklBTHI+X/DiOUJscPnZ+hZTDRmZtPxtI9QMkW057dbyDaH+llYJW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yEgfiA3PgsfucIQvnZkzNWmBZJAZOWJirhll9US7tAOEfrIz
	VPWNcHwIRz+MW7Ib5t7hFyirfkxJrs3Tf4mYTbJ8g1RlOLMddf01
X-Google-Smtp-Source: AGHT+IEIjRmIOsgGC4XWofKXHjHLqqGzfnI11Bfy5byB8W2E34xw9WYLIufy0RTwny0J0v9mVjbcZw==
X-Received: by 2002:a05:6512:1302:b0:535:6b9e:bcdd with SMTP id 2adb3069b0e04-5367fee923cmr1235520e87.33.1726219514904;
        Fri, 13 Sep 2024 02:25:14 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f904093sm2213183e87.236.2024.09.13.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:25:14 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:25:11 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <vireshk@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Maciej Sosnowski <maciej.sosnowski@intel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: dw: Prevent tx-status calling DMA-desc
 callback
Message-ID: <yiizpt6ow6rhtsqwpvkgvuf6gsnpmps6lra2uuqj7hsslsgpdr@gjvqs3tjznnm>
References: <20240911184710.4207-1-fancer.lancer@gmail.com>
 <20240911184710.4207-2-fancer.lancer@gmail.com>
 <2024091215-appraisal-rocket-45d6@gregkh>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091215-appraisal-rocket-45d6@gregkh>

Hi Greg

On Thu, Sep 12, 2024 at 07:27:22AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 11, 2024 at 09:46:09PM +0300, Serge Semin wrote:
> > The dmaengine_tx_status() method implemented in the DW DMAC driver is
> > responsible for not just DMA-transfer status getting, but may also cause
> > the transfer finalization with the Tx-descriptors callback invocation.
> > This makes the simple DMA-transfer status getting being much more complex
> > than it seems with a wider room for possible bugs.
> > 
> > In particular a deadlock has been discovered in the DW 8250 UART device
> > driver interacting with the DW DMA controller channels. Here is the
> > call-trace causing the deadlock:
> > 
> > serial8250_handle_irq()
> >   uart_port_lock_irqsave(port); ----------------------+
> >   handle_rx_dma()                                     |
> >     serial8250_rx_dma_flush()                         |
> >       __dma_rx_complete()                             |
> >         dmaengine_tx_status()                         |
> >           dwc_scan_descriptors()                      |
> >             dwc_complete_all()                        |
> >               dwc_descriptor_complete()               |
> >                 dmaengine_desc_callback_invoke()      |
> >                   cb->callback(cb->callback_param);   |
> >                   ||                                  |
> >                   dma_rx_complete();                  |
> >                     uart_port_lock_irqsave(port); ----+ <- Deadlock!
> > 
> > So in case if the DMA-engine finished working at some point before the
> > serial8250_rx_dma_flush() invocation and the respective tasklet hasn't
> > been executed yet to finalize the DMA transfer, then calling the
> > dmaengine_tx_status() will cause the DMA-descriptors status update and the
> > Tx-descriptor callback invocation.
> > 
> > Generalizing the case up: if the dmaengine_tx_status() method callee and
> > the Tx-descriptor callback refer to the related critical section, then
> > calling dmaengine_tx_status() from the Tx-descriptor callback will
> > inevitably cause a deadlock around the guarding lock as it happens in the
> > Serial 8250 DMA implementation above. (Note the deadlock doesn't happen
> > very often, but can be eventually discovered if the being received data
> > size is greater than the Rx DMA-buffer size defined in the 8250_dma.c
> > driver. In my case reducing the Rx DMA-buffer size increased the deadlock
> > probability.)
> > 
> > Alas there is no obvious way to prevent the deadlock by fixing the
> > 8250-port drivers because the UART-port lock must be held for the entire
> > port IRQ handling procedure. Thus the best way to fix the discovered
> > problem (and prevent similar ones in the drivers using the DW DMAC device
> > channels) is to simplify the DMA-transfer status getter by removing the
> > Tx-descriptors state update from there and making the function to serve
> > just one purpose - calculate the DMA-transfer residue and return the
> > transfer status. The DMA-transfer status update will be performed in the
> > bottom-half procedure only.
> > 
> > Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > ---
> > 
> > Changelog RFC:
> > - Instead of just dropping the dwc_scan_descriptors() method invocation
> >   calculate the residue in the Tx-status getter.
> > ---
> >  drivers/dma/dw/core.c | 90 ++++++++++++++++++++++++-------------------
> >  1 file changed, 50 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> > index dd75f97a33b3..af1871646eb9 100644
> > --- a/drivers/dma/dw/core.c
> > +++ b/drivers/dma/dw/core.c
> > @@ -39,6 +39,8 @@
> >  	BIT(DMA_SLAVE_BUSWIDTH_2_BYTES)		| \
> >  	BIT(DMA_SLAVE_BUSWIDTH_4_BYTES)
> >  
> > +static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc);
> > +
> >  /*----------------------------------------------------------------------*/
> >  
> >  static struct device *chan2dev(struct dma_chan *chan)
> > @@ -297,14 +299,12 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
> >  
> >  static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
> >  {
> > -	dma_addr_t llp;
> >  	struct dw_desc *desc, *_desc;
> >  	struct dw_desc *child;
> >  	u32 status_xfer;
> >  	unsigned long flags;
> >  
> >  	spin_lock_irqsave(&dwc->lock, flags);
> > -	llp = channel_readl(dwc, LLP);
> >  	status_xfer = dma_readl(dw, RAW.XFER);
> >  
> >  	if (status_xfer & dwc->mask) {
> > @@ -358,41 +358,16 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
> >  		return;
> >  	}
> >  
> > -	dev_vdbg(chan2dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
> > +	dev_vdbg(chan2dev(&dwc->chan), "%s: hard LLP mode\n", __func__);
> >  
> >  	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
> > -		/* Initial residue value */
> > -		desc->residue = desc->total_len;
> > -
> > -		/* Check first descriptors addr */
> > -		if (desc->txd.phys == DWC_LLP_LOC(llp)) {
> > -			spin_unlock_irqrestore(&dwc->lock, flags);
> > -			return;
> > -		}
> > -
> > -		/* Check first descriptors llp */
> > -		if (lli_read(desc, llp) == llp) {
> > -			/* This one is currently in progress */
> > -			desc->residue -= dwc_get_sent(dwc);
> > +		desc->residue = dwc_get_hard_llp_desc_residue(dwc, desc);
> > +		if (desc->residue) {
> >  			spin_unlock_irqrestore(&dwc->lock, flags);
> >  			return;
> >  		}
> >  
> > -		desc->residue -= desc->len;
> > -		list_for_each_entry(child, &desc->tx_list, desc_node) {
> > -			if (lli_read(child, llp) == llp) {
> > -				/* Currently in progress */
> > -				desc->residue -= dwc_get_sent(dwc);
> > -				spin_unlock_irqrestore(&dwc->lock, flags);
> > -				return;
> > -			}
> > -			desc->residue -= child->len;
> > -		}
> > -
> > -		/*
> > -		 * No descriptors so far seem to be in progress, i.e.
> > -		 * this one must be done.
> > -		 */
> > +		/* No data left to be send. Finalize the transfer then */
> >  		spin_unlock_irqrestore(&dwc->lock, flags);
> >  		dwc_descriptor_complete(dwc, desc, true);
> >  		spin_lock_irqsave(&dwc->lock, flags);
> > @@ -976,6 +951,45 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
> >  	return NULL;
> >  }
> >  
> > +static u32 dwc_get_soft_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
> > +{
> > +	u32 residue = desc->residue;
> > +
> > +	if (residue)
> > +		residue -= dwc_get_sent(dwc);
> > +
> > +	return residue;
> > +}
> > +
> > +static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
> > +{
> > +	u32 residue = desc->total_len;
> > +	struct dw_desc *child;
> > +	dma_addr_t llp;
> > +
> > +	llp = channel_readl(dwc, LLP);
> > +
> > +	/* Check first descriptor for been pending to be fetched by DMAC */
> > +	if (desc->txd.phys == DWC_LLP_LOC(llp))
> > +		return residue;
> > +
> > +	/* Check first descriptor LLP to see if it's currently in-progress */
> > +	if (lli_read(desc, llp) == llp)
> > +		return residue - dwc_get_sent(dwc);
> > +
> > +	/* Check subordinate LLPs to find the currently in-progress desc */
> > +	residue -= desc->len;
> > +	list_for_each_entry(child, &desc->tx_list, desc_node) {
> > +		if (lli_read(child, llp) == llp)
> > +			return residue - dwc_get_sent(dwc);
> > +
> > +		residue -= child->len;
> > +	}
> > +
> > +	/* Shall return zero if no in-progress desc found */
> > +	return residue;
> > +}
> > +
> >  static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cookie,
> >  				      enum dma_status *status)
> >  {
> > @@ -988,9 +1002,11 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
> >  	desc = dwc_find_desc(dwc, cookie);
> >  	if (desc) {
> >  		if (desc == dwc_first_active(dwc)) {
> > -			residue = desc->residue;
> > -			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
> > -				residue -= dwc_get_sent(dwc);
> > +			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
> > +				residue = dwc_get_soft_llp_desc_residue(dwc, desc);
> > +			else
> > +				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
> > +
> >  			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
> >  				*status = DMA_PAUSED;
> >  		} else {
> > @@ -1012,12 +1028,6 @@ dwc_tx_status(struct dma_chan *chan,
> >  	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
> >  	enum dma_status		ret;
> >  
> > -	ret = dma_cookie_status(chan, cookie, txstate);
> > -	if (ret == DMA_COMPLETE)
> > -		return ret;
> > -
> > -	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
> > -
> >  	ret = dma_cookie_status(chan, cookie, txstate);
> >  	if (ret == DMA_COMPLETE)
> >  		return ret;
> > -- 
> > 2.43.0
> > 
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.

Got it. I'll wait for the maintainers to react and discuss the
problems the series fixes. Then, if required, I'll re-submit the patch
set with the stable list Cc'ed.

-Serge(y)

> 
> thanks,
> 
> greg k-h's patch email bot

