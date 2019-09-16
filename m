Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509FEB3C7F
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2019 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbfIPOY3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Sep 2019 10:24:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49731 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388595AbfIPOY2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Sep 2019 10:24:28 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1i9rvN-0002y0-MR; Mon, 16 Sep 2019 16:24:17 +0200
Message-ID: <b5c905fadc332ae2ddb30f3f890ff8deff81de71.camel@pengutronix.de>
Subject: Re: [PATCH 3/4] serial: imx: adapt rx buffer and dma periods
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, jslaby@suse.com, vkoul@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        gregkh@linuxfoundation.org, dmaengine@vger.kernel.org,
        dan.j.williams@intel.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 16 Sep 2019 16:24:17 +0200
In-Reply-To: <20190911144943.21554-4-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
         <20190911144943.21554-4-philipp.puschmann@emlix.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mi, 2019-09-11 at 16:49 +0200, Philipp Puschmann wrote:
> Using only 4 DMA periods for UART RX is very few if we have a high
> frequency of small transfers - like in our case using Bluetooth with many
> small packets via UART - causing many dma transfers but in each only
> filling a fraction of a single buffer. Such a case may lead to the
> situation that DMA RX transfer is triggered but no buffer is available.
> While we have addressed the dma handling already we still want to avoid
> UART RX FIFO overrun. So we decrease the size of the buffers and increase
> their number and the total buffer size.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>

Reasoning seems sound:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/tty/serial/imx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 57d6e6ba556e..cdc51569237c 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1028,8 +1028,6 @@ static void imx_uart_timeout(struct timer_list *t)
>  	}
>  }
>  
> -#define RX_BUF_SIZE	(PAGE_SIZE)
> -
>  /*
>   * There are two kinds of RX DMA interrupts(such as in the MX6Q):
>   *   [1] the RX DMA buffer is full.
> @@ -1112,7 +1110,8 @@ static void imx_uart_dma_rx_callback(void *data)
>  }
>  
>  /* RX DMA buffer periods */
> -#define RX_DMA_PERIODS 4
> +#define RX_DMA_PERIODS	16
> +#define RX_BUF_SIZE	(PAGE_SIZE / 4)
>  
>  static int imx_uart_start_rx_dma(struct imx_port *sport)
>  {

