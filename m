Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6822F97D
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2019 11:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfE3JeZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 May 2019 05:34:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:6637 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726454AbfE3JeZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 May 2019 05:34:25 -0400
X-UUID: f5d7923273f442588693eb1f7c57bba2-20190530
X-UUID: f5d7923273f442588693eb1f7c57bba2-20190530
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 189638788; Thu, 30 May 2019 17:34:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 May
 2019 17:34:17 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 30 May 2019 17:34:16 +0800
Message-ID: <1559208856.14150.35.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] serial: 8250-mtk: modify uart DMA rx
From:   Long Cheng <long.cheng@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Long Cheng <Long.cheng@mediatek.com>,
        "Changqi Hu" <changqi.hu@mediatek.com>
Date:   Thu, 30 May 2019 17:34:16 +0800
In-Reply-To: <1558596909-14084-3-git-send-email-long.cheng@mediatek.com>
References: <1558596909-14084-1-git-send-email-long.cheng@mediatek.com>
         <1558596909-14084-3-git-send-email-long.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: B27139AB2F1BB9957CAE9332638E0C210155CD5265085DED026FD2DB4FE943502000:8
X-MTK:  N
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 2019-05-23 at 15:35 +0800, Long Cheng wrote:


Hi Greg,

Just a gentle ping!

thanks.

> Modify uart rx and complete for DMA
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  drivers/tty/serial/8250/8250_mtk.c |   49 +++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index 417c7c8..f470ded 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -47,7 +47,6 @@
>  #define MTK_UART_DMA_EN_RX	0x5
>  
>  #define MTK_UART_ESCAPE_CHAR	0x77	/* Escape char added under sw fc */
> -#define MTK_UART_TX_SIZE	UART_XMIT_SIZE
>  #define MTK_UART_RX_SIZE	0x8000
>  #define MTK_UART_TX_TRIGGER	1
>  #define MTK_UART_RX_TRIGGER	MTK_UART_RX_SIZE
> @@ -89,28 +88,30 @@ static void mtk8250_dma_rx_complete(void *param)
>  	struct mtk8250_data *data = up->port.private_data;
>  	struct tty_port *tty_port = &up->port.state->port;
>  	struct dma_tx_state state;
> +	int copied, total, cnt;
>  	unsigned char *ptr;
> -	int copied;
>  
> -	dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
> -				dma->rx_size, DMA_FROM_DEVICE);
> +	if (data->rx_status == DMA_RX_SHUTDOWN)
> +		return;
>  
>  	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> +	total = dma->rx_size - state.residue;
> +	cnt = total;
>  
> -	if (data->rx_status == DMA_RX_SHUTDOWN)
> -		return;
> +	if ((data->rx_pos + cnt) > dma->rx_size)
> +		cnt = dma->rx_size - data->rx_pos;
>  
> -	if ((data->rx_pos + state.residue) <= dma->rx_size) {
> -		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> -		copied = tty_insert_flip_string(tty_port, ptr, state.residue);
> -	} else {
> -		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> -		copied = tty_insert_flip_string(tty_port, ptr,
> -						dma->rx_size - data->rx_pos);
> +	ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> +	copied = tty_insert_flip_string(tty_port, ptr, cnt);
> +	data->rx_pos += cnt;
> +
> +	if (total > cnt) {
>  		ptr = (unsigned char *)(dma->rx_buf);
> -		copied += tty_insert_flip_string(tty_port, ptr,
> -				data->rx_pos + state.residue - dma->rx_size);
> +		cnt = total - cnt;
> +		copied += tty_insert_flip_string(tty_port, ptr, cnt);
> +		data->rx_pos = cnt;
>  	}
> +
>  	up->port.icount.rx += copied;
>  
>  	tty_flip_buffer_push(tty_port);
> @@ -121,9 +122,7 @@ static void mtk8250_dma_rx_complete(void *param)
>  static void mtk8250_rx_dma(struct uart_8250_port *up)
>  {
>  	struct uart_8250_dma *dma = up->dma;
> -	struct mtk8250_data *data = up->port.private_data;
>  	struct dma_async_tx_descriptor	*desc;
> -	struct dma_tx_state	 state;
>  
>  	desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
>  					   dma->rx_size, DMA_DEV_TO_MEM,
> @@ -138,12 +137,6 @@ static void mtk8250_rx_dma(struct uart_8250_port *up)
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
> @@ -156,13 +149,11 @@ static void mtk8250_dma_enable(struct uart_8250_port *up)
>  	if (data->rx_status != DMA_RX_START)
>  		return;
>  
> -	dma->rxconf.direction		= DMA_DEV_TO_MEM;
> -	dma->rxconf.src_addr_width	= dma->rx_size / 1024;
> -	dma->rxconf.src_addr		= dma->rx_addr;
> +	dma->rxconf.src_port_window_size	= dma->rx_size;
> +	dma->rxconf.src_addr				= dma->rx_addr;
>  
> -	dma->txconf.direction		= DMA_MEM_TO_DEV;
> -	dma->txconf.dst_addr_width	= MTK_UART_TX_SIZE / 1024;
> -	dma->txconf.dst_addr		= dma->tx_addr;
> +	dma->txconf.dst_port_window_size	= UART_XMIT_SIZE;
> +	dma->txconf.dst_addr				= dma->tx_addr;
>  
>  	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
>  		UART_FCR_CLEAR_XMIT);


