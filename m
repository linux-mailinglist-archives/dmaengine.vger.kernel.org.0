Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5495C59C00
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jun 2019 14:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfF1Mx2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jun 2019 08:53:28 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36307 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfF1Mx1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jun 2019 08:53:27 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 498A23C00D1;
        Fri, 28 Jun 2019 14:53:25 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6m3R6_z5fLkn; Fri, 28 Jun 2019 14:53:19 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 90EF33C00C6;
        Fri, 28 Jun 2019 14:53:19 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 28 Jun
 2019 14:53:19 +0200
Date:   Fri, 28 Jun 2019 14:53:19 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-serial@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 1/2] serial: sh-sci: Fix TX DMA buffer flushing and
 workqueue races
Message-ID: <20190628125319.GB10962@vmlxhi-102.adit-jv.com>
References: <20190624123540.20629-1-geert+renesas@glider.be>
 <20190624123540.20629-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190624123540.20629-2-geert+renesas@glider.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

One bikeshedding below.

On Mon, Jun 24, 2019 at 02:35:39PM +0200, Geert Uytterhoeven wrote:
[..]
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index abc705716aa094fd..d4504daff99263f5 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1398,6 +1398,7 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
>  	struct circ_buf *xmit = &port->state->xmit;
>  	unsigned long flags;
>  	dma_addr_t buf;
> +	int head, tail;
>  
>  	/*
>  	 * DMA is idle now.
> @@ -1407,16 +1408,23 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
>  	 * consistent xmit buffer state.
>  	 */
>  	spin_lock_irq(&port->lock);
> -	buf = s->tx_dma_addr + (xmit->tail & (UART_XMIT_SIZE - 1));
> +	head = xmit->head;
> +	tail = xmit->tail;
> +	buf = s->tx_dma_addr + (tail & (UART_XMIT_SIZE - 1));
>  	s->tx_dma_len = min_t(unsigned int,
> -		CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
> -		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE));
> -	spin_unlock_irq(&port->lock);
> +		CIRC_CNT(head, tail, UART_XMIT_SIZE),
> +		CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE));
> +	if (!s->tx_dma_len) {
> +		/* Transmit buffer has been flushed */
> +		spin_unlock_irq(&port->lock);
> +		return;

Since we can now return before using the result stored in 'buf', we
could relocate the 'buf' calculation next to the return statement, just
before calling dmaengine_prep_slave_single(), as micro-optimization.

> +	}
>  
>  	desc = dmaengine_prep_slave_single(chan, buf, s->tx_dma_len,
>  					   DMA_MEM_TO_DEV,
>  					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);

Otherwise:

Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

-- 
Best Regards,
Eugeniu.
