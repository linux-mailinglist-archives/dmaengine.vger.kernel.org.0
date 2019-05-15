Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9EB1F5E6
	for <lists+dmaengine@lfdr.de>; Wed, 15 May 2019 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfEONtG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 May 2019 09:49:06 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33326 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfEONtG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 May 2019 09:49:06 -0400
Received: by mail-qk1-f194.google.com with SMTP id k189so15555qkc.0
        for <dmaengine@vger.kernel.org>; Wed, 15 May 2019 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bU82F+gt2zE3PINH+I2iOdx7/P2Z54mTmX7HD0f23g=;
        b=Rz/eTH+AhP/E1BbGJwPsapzQcGBCN6AsXcTjNCMhLwf/Y4ROLeWXnzuXXCGskE4ial
         C6vT5lbVMECErTsbOqncFmph2Tp1d0H7MkmabSVn4yEYTkDH28DQUEmZW/+6q04J8i/T
         CJuQRVnjMj4PSEctgFELgkj3rPlU7ctawx7IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bU82F+gt2zE3PINH+I2iOdx7/P2Z54mTmX7HD0f23g=;
        b=TYoPV5Y0UhZU39x8Q8l8DS/azWmCdSh8gThjGJwnf3s+0+maU66OSW/pmJLTqO6/L+
         kJgSL/oabZDTWdyrDdorCc6+OEDBeH/VEAXiMgy1V1SpYxC0DtofwCxJYOHPTiYXAB+J
         FxDewXyTG9SR9DPtFpPZhqgS8H+hlDmcPB5NxlXWbtjKmgGaE3q38p3YXFBibkcRjSMt
         5NkEbdUfgRuo9b0xWY53TRbskLQfhw7cAfipBN7UA0IZvOhkexm+rWiKsK9ixIXLBoDV
         2cK5Nylk6Q8EHehhmJlNaL/fqKcZ7/HvU/if5vEb3oc+FyApd7ssew/4r+j/99SoYr0D
         H9Tg==
X-Gm-Message-State: APjAAAUbVPfYu3w3E5eCaPFwwIiSQs8sk4eAHfhZR/pDOn2V1FgxFv3F
        +lLDEHptkUNGFkGOvCEqvT/kb9uSHGHPI8RET9W4hw==
X-Google-Smtp-Source: APXvYqwlUOhQfWVG0cDXJfSD77I136CNQYmnycgW7CY0DPgH6v1ONynTfzyo3enPqgR8mXrkE9bC5wWl+/AN2lmlbhE=
X-Received: by 2002:ae9:f818:: with SMTP id x24mr32636878qkh.329.1557928145116;
 Wed, 15 May 2019 06:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <1556336193-15198-1-git-send-email-long.cheng@mediatek.com> <1556336193-15198-5-git-send-email-long.cheng@mediatek.com>
In-Reply-To: <1556336193-15198-5-git-send-email-long.cheng@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 15 May 2019 21:48:52 +0800
Message-ID: <CANMq1KDTyu48joV6uMksGBMz9EmjFH9SEpGAm93YCZ40jxgBpQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] serial: 8250-mtk: modify uart DMA rx
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Apr 27, 2019 at 11:36 AM Long Cheng <long.cheng@mediatek.com> wrote:
>
> Modify uart rx and complete for DMA.

I don't know much about the DMA framework, but can you please explain
why you are making the changes in this CL? I see that you are dropping
dma_sync_single_for_device calls, for example, why?

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
>  #define MTK_UART_DMA_EN_TX     0x2
>  #define MTK_UART_DMA_EN_RX     0x5
>
> -#define MTK_UART_TX_SIZE       UART_XMIT_SIZE
>  #define MTK_UART_RX_SIZE       0x8000
>  #define MTK_UART_TX_TRIGGER    1
>  #define MTK_UART_RX_TRIGGER    MTK_UART_RX_SIZE
> @@ -64,28 +63,30 @@ static void mtk8250_dma_rx_complete(void *param)
>         struct mtk8250_data *data = up->port.private_data;
>         struct tty_port *tty_port = &up->port.state->port;
>         struct dma_tx_state state;
> +       int copied, cnt, tmp;
>         unsigned char *ptr;
> -       int copied;
>
> -       dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
> -                               dma->rx_size, DMA_FROM_DEVICE);
> +       if (data->rx_status == DMA_RX_SHUTDOWN)
> +               return;
>
>         dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> +       cnt = dma->rx_size - state.residue;
> +       tmp = cnt;

I ponder, maybe we should rename cnt to left? (like, how many bytes
are left to transfer, in total) Or maybe "total"
Then maybe rename tmp to cnt.

>
> -       if (data->rx_status == DMA_RX_SHUTDOWN)
> -               return;
> +       if ((data->rx_pos + cnt) > dma->rx_size)
> +               tmp = dma->rx_size - data->rx_pos;

Maybe replace this and the line above:
tmp = max_t(int, cnt, dma->rx_size - data->rx_pos);

>
> -       if ((data->rx_pos + state.residue) <= dma->rx_size) {
> -               ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> -               copied = tty_insert_flip_string(tty_port, ptr, state.residue);
> -       } else {
> -               ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> -               copied = tty_insert_flip_string(tty_port, ptr,
> -                                               dma->rx_size - data->rx_pos);
> +       ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> +       copied = tty_insert_flip_string(tty_port, ptr, tmp);
> +       data->rx_pos += tmp;
> +
> +       if (cnt > tmp) {
>                 ptr = (unsigned char *)(dma->rx_buf);
> -               copied += tty_insert_flip_string(tty_port, ptr,
> -                               data->rx_pos + state.residue - dma->rx_size);
> +               tmp = cnt - tmp;
> +               copied += tty_insert_flip_string(tty_port, ptr, tmp);
> +               data->rx_pos = tmp;
>         }
> +
>         up->port.icount.rx += copied;
>
>         tty_flip_buffer_push(tty_port);
> @@ -96,9 +97,7 @@ static void mtk8250_dma_rx_complete(void *param)
>  static void mtk8250_rx_dma(struct uart_8250_port *up)
>  {
>         struct uart_8250_dma *dma = up->dma;
> -       struct mtk8250_data *data = up->port.private_data;
>         struct dma_async_tx_descriptor  *desc;
> -       struct dma_tx_state      state;
>
>         desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
>                                            dma->rx_size, DMA_DEV_TO_MEM,
> @@ -113,12 +112,6 @@ static void mtk8250_rx_dma(struct uart_8250_port *up)
>
>         dma->rx_cookie = dmaengine_submit(desc);
>
> -       dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> -       data->rx_pos = state.residue;
> -
> -       dma_sync_single_for_device(dma->rxchan->device->dev, dma->rx_addr,
> -                                  dma->rx_size, DMA_FROM_DEVICE);
> -
>         dma_async_issue_pending(dma->rxchan);
>  }
>
> @@ -131,13 +124,13 @@ static void mtk8250_dma_enable(struct uart_8250_port *up)
>         if (data->rx_status != DMA_RX_START)
>                 return;
>
> -       dma->rxconf.direction           = DMA_DEV_TO_MEM;
> -       dma->rxconf.src_addr_width      = dma->rx_size / 1024;
> -       dma->rxconf.src_addr            = dma->rx_addr;
> +       dma->rxconf.direction                           = DMA_DEV_TO_MEM;
> +       dma->rxconf.src_port_window_size        = dma->rx_size;
> +       dma->rxconf.src_addr                            = dma->rx_addr;
>
> -       dma->txconf.direction           = DMA_MEM_TO_DEV;
> -       dma->txconf.dst_addr_width      = MTK_UART_TX_SIZE / 1024;
> -       dma->txconf.dst_addr            = dma->tx_addr;
> +       dma->txconf.direction                           = DMA_MEM_TO_DEV;
> +       dma->txconf.dst_port_window_size        = UART_XMIT_SIZE;
> +       dma->txconf.dst_addr                            = dma->tx_addr;
>
>         serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
>                 UART_FCR_CLEAR_XMIT);
> @@ -217,7 +210,7 @@ static void mtk8250_shutdown(struct uart_port *port)
>          * Mediatek UARTs use an extra highspeed register (UART_MTK_HIGHS)
>          *
>          * We need to recalcualte the quot register, as the claculation depends
> -        * on the vaule in the highspeed register.
> +        * on the value in the highspeed register.

Since you're doing some cosmetic changes here, you might as well fix
recalcualte => recalculate and claculation => calculation on the line
above.

But technically, this should belong in another patch...

>          *
>          * Some baudrates are not supported by the chip, so we use the next
>          * lower rate supported and update termios c_flag.
> --
> 1.7.9.5
>
