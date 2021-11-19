Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17A7457258
	for <lists+dmaengine@lfdr.de>; Fri, 19 Nov 2021 17:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhKSQH5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Nov 2021 11:07:57 -0500
Received: from mout01.posteo.de ([185.67.36.65]:42155 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235596AbhKSQH5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 19 Nov 2021 11:07:57 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A121A240035
        for <dmaengine@vger.kernel.org>; Fri, 19 Nov 2021 17:04:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1637337893; bh=ei4Pk91+TG41LS+YkQ10EcqKAyIbbtRGkKfMKOIYZ2M=;
        h=Subject:To:Cc:From:Date:From;
        b=m9IglhsjeQX7m+RVmH1faKP63vrgMJ2K5PGP2RQLWJPlRkuMzLzn7k8/VuvyODaqO
         mc/UAgZ41rwKweXHivlXechl7F4Hdll+7K3xZupCn04/JgwI5gp3l8E3arQ1dJQsZa
         c5hV2qTDI7aI9WOv3PW7aDHi6HBIpDi0NJq9jZNGZ8x7FWPXMm1b9eJs/bh79EIaSZ
         eKIYxjP/AiSc7TFT5vZL8eB+AyM08OhsDQj/fOJ63NeiKoNXHQ54VnlyP3htmRAYG1
         POKN4GW51xFTAyf9osFeIwVGRxFPrtj3GDloMZmmlSRe/WgZkfitE0/7pE6R67TWnB
         qg+1cphB1tU+Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4HwhM649g7z9rwg;
        Fri, 19 Nov 2021 17:04:50 +0100 (CET)
Subject: Re: [PATCH 03/13] tty: serial: atmel: Call dma_async_issue_pending()
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Richard Genoud <richard.genoud@gmail.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
 <20211116112036.96349-4-tudor.ambarus@microchip.com>
From:   Richard Genoud <richard.genoud@posteo.net>
Message-ID: <6e29ab5d-070e-0407-96ad-129eb82afc88@posteo.net>
Date:   Fri, 19 Nov 2021 16:04:49 +0000
MIME-Version: 1.0
In-Reply-To: <20211116112036.96349-4-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Le 16/11/2021 à 12:20, Tudor Ambarus a écrit :
> The driver wrongly assummed that tx_submit() will start the transfer,
> which is not the case, now that the at_xdmac driver is fixed. tx_submit
> is supposed to push the current transaction descriptor to a pending queue,
> waiting for issue_pending to be called. issue_pending must start the
> transfer, not tx_submit. While touching atmel_prepare_rx_dma(), introduce
> a local variable for the RX dma channel.
> 
> Fixes: 34df42f59a60 ("serial: at91: add rx dma support")
> Fixes: 08f738be88bb ("serial: at91: add tx dma support")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 376f7a9c2868..b3e593f3c17f 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1009,6 +1009,8 @@ static void atmel_tx_dma(struct uart_port *port)
>  				atmel_port->cookie_tx);
>  			return;
>  		}
> +
> +		dma_async_issue_pending(chan);
>  	}
>  
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)

From this hunk...
> @@ -1191,6 +1193,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
>  static int atmel_prepare_rx_dma(struct uart_port *port)
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	struct dma_chan *chan_rx;
>  	struct device *mfd_dev = port->dev->parent;
>  	struct dma_async_tx_descriptor *desc;
>  	dma_cap_mask_t		mask;
> @@ -1203,11 +1206,13 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_CYCLIC, mask);
>  
> -	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
> -	if (atmel_port->chan_rx == NULL)
> +	chan_rx = dma_request_slave_channel(mfd_dev, "rx");
> +	if (chan_rx == NULL)
>  		goto chan_err;
> +	atmel_port->chan_rx = chan_rx;
> +
>  	dev_info(port->dev, "using %s for rx DMA transfers\n",
> -		dma_chan_name(atmel_port->chan_rx));
> +		 dma_chan_name(chan_rx));
>  
>  	spin_lock_init(&atmel_port->lock_rx);
>  	sg_init_table(&atmel_port->sg_rx, 1);
> @@ -1239,8 +1244,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	config.src_addr = port->mapbase + ATMEL_US_RHR;
>  	config.src_maxburst = 1;
>  
> -	ret = dmaengine_slave_config(atmel_port->chan_rx,
> -				     &config);
> +	ret = dmaengine_slave_config(chan_rx, &config);
>  	if (ret) {
>  		dev_err(port->dev, "DMA rx slave configuration failed\n");
>  		goto chan_err;
> @@ -1249,7 +1253,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	 * Prepare a cyclic dma transfer, assign 2 descriptors,
>  	 * each one is half ring buffer size
>  	 */
> -	desc = dmaengine_prep_dma_cyclic(atmel_port->chan_rx,
> +	desc = dmaengine_prep_dma_cyclic(chan_rx,
>  					 sg_dma_address(&atmel_port->sg_rx),
>  					 sg_dma_len(&atmel_port->sg_rx),
>  					 sg_dma_len(&atmel_port->sg_rx)/2,
...to here :
I think this should go in another patch since these hunks only introduce "chan_rx".
And in this other patch, maybe add a little note on why "atmel_port->chan_rx = chan_rx;"
is after "chan_rx = dma_request_slave_channel(mfd_dev, "rx");"


> @@ -1269,12 +1273,14 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  		goto chan_err;
>  	}
>  
> +	dma_async_issue_pending(chan_rx);
> +
>  	return 0;
>  
>  chan_err:
>  	dev_err(port->dev, "RX channel not available, switch to pio\n");
>  	atmel_port->use_dma_rx = false;
> -	if (atmel_port->chan_rx)
> +	if (chan_rx)
>  		atmel_release_rx_dma(port);
>  	return -EINVAL;
>  }
> 
The rest seems ok.

Thanks !

Richard.
