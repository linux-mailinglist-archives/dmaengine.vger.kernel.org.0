Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB925143
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 15:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfEUN5b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 09:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEUN5b (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 09:57:31 -0400
Received: from localhost (unknown [106.51.105.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04AC621479;
        Tue, 21 May 2019 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558447050;
        bh=p5zj6aoLLNC0yMiNnBSt2O1dX8e+LCMuZRJxjILAIfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgXxUEe1venUsogc/J7JRiQZeehTDpwIWNaoFUysa+vgHozkfEzxPdBnv6w452wux
         0H8q2NuqSq+LleLgJhAoKYAypYZz7jMPws06tLgOW0oLo6LXekJc7fEvT6w7aERLGW
         vZS4BQBBoiOHcuGYUC16SQ5k2QBs9SkKj+R0VaS8=
Date:   Tue, 21 May 2019 19:27:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
Subject: Re: [PATCH 4/4] serial: 8250-mtk: modify uart DMA rx
Message-ID: <20190521135725.GN15118@vkoul-mobl>
References: <1556336193-15198-1-git-send-email-long.cheng@mediatek.com>
 <1556336193-15198-5-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556336193-15198-5-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-04-19, 11:36, Long Cheng wrote:
> Modify uart rx and complete for DMA.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c |   53 ++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index c1fdbc0..04081a6 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -30,7 +30,6 @@
>  #define MTK_UART_DMA_EN_TX	0x2
>  #define MTK_UART_DMA_EN_RX	0x5
>  
> -#define MTK_UART_TX_SIZE	UART_XMIT_SIZE
>  #define MTK_UART_RX_SIZE	0x8000
>  #define MTK_UART_TX_TRIGGER	1
>  #define MTK_UART_RX_TRIGGER	MTK_UART_RX_SIZE
> @@ -64,28 +63,30 @@ static void mtk8250_dma_rx_complete(void *param)
>  	struct mtk8250_data *data = up->port.private_data;
>  	struct tty_port *tty_port = &up->port.state->port;
>  	struct dma_tx_state state;
> +	int copied, cnt, tmp;
>  	unsigned char *ptr;
> -	int copied;
>  
> -	dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
> -				dma->rx_size, DMA_FROM_DEVICE);
> +	if (data->rx_status == DMA_RX_SHUTDOWN)
> +		return;
>  
>  	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> +	cnt = dma->rx_size - state.residue;
> +	tmp = cnt;
>  
> -	if (data->rx_status == DMA_RX_SHUTDOWN)
> -		return;
> +	if ((data->rx_pos + cnt) > dma->rx_size)
> +		tmp = dma->rx_size - data->rx_pos;
>  
> -	if ((data->rx_pos + state.residue) <= dma->rx_size) {
> -		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> -		copied = tty_insert_flip_string(tty_port, ptr, state.residue);
> -	} else {
> -		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> -		copied = tty_insert_flip_string(tty_port, ptr,
> -						dma->rx_size - data->rx_pos);
> +	ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> +	copied = tty_insert_flip_string(tty_port, ptr, tmp);
> +	data->rx_pos += tmp;
> +
> +	if (cnt > tmp) {
>  		ptr = (unsigned char *)(dma->rx_buf);
> -		copied += tty_insert_flip_string(tty_port, ptr,
> -				data->rx_pos + state.residue - dma->rx_size);
> +		tmp = cnt - tmp;
> +		copied += tty_insert_flip_string(tty_port, ptr, tmp);
> +		data->rx_pos = tmp;
>  	}
> +
>  	up->port.icount.rx += copied;
>  
>  	tty_flip_buffer_push(tty_port);
> @@ -96,9 +97,7 @@ static void mtk8250_dma_rx_complete(void *param)
>  static void mtk8250_rx_dma(struct uart_8250_port *up)
>  {
>  	struct uart_8250_dma *dma = up->dma;
> -	struct mtk8250_data *data = up->port.private_data;
>  	struct dma_async_tx_descriptor	*desc;
> -	struct dma_tx_state	 state;
>  
>  	desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
>  					   dma->rx_size, DMA_DEV_TO_MEM,
> @@ -113,12 +112,6 @@ static void mtk8250_rx_dma(struct uart_8250_port *up)
>  
>  	dma->rx_cookie = dmaengine_submit(desc);
>  
> -	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> -	data->rx_pos = state.residue;
> -
> -	dma_sync_single_for_device(dma->rxchan->device->dev, dma->rx_addr,
> -				   dma->rx_size, DMA_FROM_DEVICE);
> -
>  	dma_async_issue_pending(dma->rxchan);
>  }
>  
> @@ -131,13 +124,13 @@ static void mtk8250_dma_enable(struct uart_8250_port *up)
>  	if (data->rx_status != DMA_RX_START)
>  		return;
>  
> -	dma->rxconf.direction		= DMA_DEV_TO_MEM;
> -	dma->rxconf.src_addr_width	= dma->rx_size / 1024;
> -	dma->rxconf.src_addr		= dma->rx_addr;
> +	dma->rxconf.direction				= DMA_DEV_TO_MEM;

Direction field is deprecated, please do not use this anymore...

> +	dma->rxconf.src_port_window_size	= dma->rx_size;
> +	dma->rxconf.src_addr				= dma->rx_addr;
>  
> -	dma->txconf.direction		= DMA_MEM_TO_DEV;
> -	dma->txconf.dst_addr_width	= MTK_UART_TX_SIZE / 1024;
> -	dma->txconf.dst_addr		= dma->tx_addr;
> +	dma->txconf.direction				= DMA_MEM_TO_DEV;
> +	dma->txconf.dst_port_window_size	= UART_XMIT_SIZE;
> +	dma->txconf.dst_addr				= dma->tx_addr;
>  
>  	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
>  		UART_FCR_CLEAR_XMIT);
> @@ -217,7 +210,7 @@ static void mtk8250_shutdown(struct uart_port *port)
>  	 * Mediatek UARTs use an extra highspeed register (UART_MTK_HIGHS)
>  	 *
>  	 * We need to recalcualte the quot register, as the claculation depends
> -	 * on the vaule in the highspeed register.
> +	 * on the value in the highspeed register.
>  	 *
>  	 * Some baudrates are not supported by the chip, so we use the next
>  	 * lower rate supported and update termios c_flag.
> -- 
> 1.7.9.5

-- 
~Vinod
