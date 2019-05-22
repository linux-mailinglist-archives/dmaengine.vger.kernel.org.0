Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4282525D87
	for <lists+dmaengine@lfdr.de>; Wed, 22 May 2019 07:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfEVFYb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 May 2019 01:24:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53719 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725796AbfEVFYb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 May 2019 01:24:31 -0400
X-UUID: c79c5609883e4e05bbfd9eabfb832317-20190522
X-UUID: c79c5609883e4e05bbfd9eabfb832317-20190522
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1054208324; Wed, 22 May 2019 13:24:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 22 May
 2019 13:24:23 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 22 May 2019 13:24:22 +0800
Message-ID: <1558502662.14150.31.camel@mhfsdcap03>
Subject: Re: [PATCH 4/4] serial: 8250-mtk: modify uart DMA rx
From:   Long Cheng <long.cheng@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>
Date:   Wed, 22 May 2019 13:24:22 +0800
In-Reply-To: <1558078602.14150.27.camel@mhfsdcap03>
References: <1556336193-15198-1-git-send-email-long.cheng@mediatek.com>
         <1556336193-15198-5-git-send-email-long.cheng@mediatek.com>
         <CANMq1KDTyu48joV6uMksGBMz9EmjFH9SEpGAm93YCZ40jxgBpQ@mail.gmail.com>
         <1558078602.14150.27.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 2019-05-17 at 15:36 +0800, Long Cheng wrote:
> On Wed, 2019-05-15 at 21:48 +0800, Nicolas Boichat wrote:
> > On Sat, Apr 27, 2019 at 11:36 AM Long Cheng <long.cheng@mediatek.com> wrote:
> > >
> > > Modify uart rx and complete for DMA.
> > 
> > I don't know much about the DMA framework, but can you please explain
> > why you are making the changes in this CL? I see that you are dropping
> > dma_sync_single_for_device calls, for example, why?
> > 
> 
> the rx buffer is create by 'dma_alloc_coherent'. in the function, the
> buffer is uncache. We don't need to sync between CPU and DMA. So I
> remove it.
> 
> > >
> > > Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_mtk.c |   53 ++++++++++++++++--------------------
> > >  1 file changed, 23 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> > > index c1fdbc0..04081a6 100644
> > > --- a/drivers/tty/serial/8250/8250_mtk.c
> > > +++ b/drivers/tty/serial/8250/8250_mtk.c
> > > @@ -30,7 +30,6 @@
> > >  #define MTK_UART_DMA_EN_TX     0x2
> > >  #define MTK_UART_DMA_EN_RX     0x5
> > >
> > > -#define MTK_UART_TX_SIZE       UART_XMIT_SIZE
> > >  #define MTK_UART_RX_SIZE       0x8000
> > >  #define MTK_UART_TX_TRIGGER    1
> > >  #define MTK_UART_RX_TRIGGER    MTK_UART_RX_SIZE
> > > @@ -64,28 +63,30 @@ static void mtk8250_dma_rx_complete(void *param)
> > >         struct mtk8250_data *data = up->port.private_data;
> > >         struct tty_port *tty_port = &up->port.state->port;
> > >         struct dma_tx_state state;
> > > +       int copied, cnt, tmp;
> > >         unsigned char *ptr;
> > > -       int copied;
> > >
> > > -       dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
> > > -                               dma->rx_size, DMA_FROM_DEVICE);
> > > +       if (data->rx_status == DMA_RX_SHUTDOWN)
> > > +               return;
> > >
> > >         dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> > > +       cnt = dma->rx_size - state.residue;
> > > +       tmp = cnt;
> > 
> > I ponder, maybe we should rename cnt to left? (like, how many bytes
> > are left to transfer, in total) Or maybe "total"
> > Then maybe rename tmp to cnt.
> > 
> like better.
> 
> > >
> > > -       if (data->rx_status == DMA_RX_SHUTDOWN)
> > > -               return;
> > > +       if ((data->rx_pos + cnt) > dma->rx_size)
> > > +               tmp = dma->rx_size - data->rx_pos;
> > 
> > Maybe replace this and the line above:
> > tmp = max_t(int, cnt, dma->rx_size - data->rx_pos);
> > 
> Yes. It's better.
> 

can't replace by 'max_t'. So I will keep original code.

> > >
> > > -       if ((data->rx_pos + state.residue) <= dma->rx_size) {
> > > -               ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> > > -               copied = tty_insert_flip_string(tty_port, ptr, state.residue);
> > > -       } else {
> > > -               ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> > > -               copied = tty_insert_flip_string(tty_port, ptr,
> > > -                                               dma->rx_size - data->rx_pos);
> > > +       ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
> > > +       copied = tty_insert_flip_string(tty_port, ptr, tmp);
> > > +       data->rx_pos += tmp;
> > > +
> > > +       if (cnt > tmp) {
> > >                 ptr = (unsigned char *)(dma->rx_buf);
> > > -               copied += tty_insert_flip_string(tty_port, ptr,
> > > -                               data->rx_pos + state.residue - dma->rx_size);
> > > +               tmp = cnt - tmp;
> > > +               copied += tty_insert_flip_string(tty_port, ptr, tmp);
> > > +               data->rx_pos = tmp;
> > >         }
> > > +
> > >         up->port.icount.rx += copied;
> > >
> > >         tty_flip_buffer_push(tty_port);
> > > @@ -96,9 +97,7 @@ static void mtk8250_dma_rx_complete(void *param)
> > >  static void mtk8250_rx_dma(struct uart_8250_port *up)
> > >  {
> > >         struct uart_8250_dma *dma = up->dma;
> > > -       struct mtk8250_data *data = up->port.private_data;
> > >         struct dma_async_tx_descriptor  *desc;
> > > -       struct dma_tx_state      state;
> > >
> > >         desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
> > >                                            dma->rx_size, DMA_DEV_TO_MEM,
> > > @@ -113,12 +112,6 @@ static void mtk8250_rx_dma(struct uart_8250_port *up)
> > >
> > >         dma->rx_cookie = dmaengine_submit(desc);
> > >
> > > -       dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> > > -       data->rx_pos = state.residue;
> > > -
> > > -       dma_sync_single_for_device(dma->rxchan->device->dev, dma->rx_addr,
> > > -                                  dma->rx_size, DMA_FROM_DEVICE);
> > > -
> > >         dma_async_issue_pending(dma->rxchan);
> > >  }
> > >
> > > @@ -131,13 +124,13 @@ static void mtk8250_dma_enable(struct uart_8250_port *up)
> > >         if (data->rx_status != DMA_RX_START)
> > >                 return;
> > >
> > > -       dma->rxconf.direction           = DMA_DEV_TO_MEM;
> > > -       dma->rxconf.src_addr_width      = dma->rx_size / 1024;
> > > -       dma->rxconf.src_addr            = dma->rx_addr;
> > > +       dma->rxconf.direction                           = DMA_DEV_TO_MEM;
> > > +       dma->rxconf.src_port_window_size        = dma->rx_size;
> > > +       dma->rxconf.src_addr                            = dma->rx_addr;
> > >
> > > -       dma->txconf.direction           = DMA_MEM_TO_DEV;
> > > -       dma->txconf.dst_addr_width      = MTK_UART_TX_SIZE / 1024;
> > > -       dma->txconf.dst_addr            = dma->tx_addr;
> > > +       dma->txconf.direction                           = DMA_MEM_TO_DEV;
> > > +       dma->txconf.dst_port_window_size        = UART_XMIT_SIZE;
> > > +       dma->txconf.dst_addr                            = dma->tx_addr;
> > >
> > >         serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
> > >                 UART_FCR_CLEAR_XMIT);
> > > @@ -217,7 +210,7 @@ static void mtk8250_shutdown(struct uart_port *port)
> > >          * Mediatek UARTs use an extra highspeed register (UART_MTK_HIGHS)
> > >          *
> > >          * We need to recalcualte the quot register, as the claculation depends
> > > -        * on the vaule in the highspeed register.
> > > +        * on the value in the highspeed register.
> > 
> > Since you're doing some cosmetic changes here, you might as well fix
> > recalcualte => recalculate and claculation => calculation on the line
> > above.
> > 
> 
> I see.
> 
> > But technically, this should belong in another patch...
> > 
> > >          *
> > >          * Some baudrates are not supported by the chip, so we use the next
> > >          * lower rate supported and update termios c_flag.
> > > --
> > > 1.7.9.5
> > >
> 


