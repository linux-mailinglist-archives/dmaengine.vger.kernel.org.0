Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 286CA2771B
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2019 09:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfEWHfX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 May 2019 03:35:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39391 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbfEWHfW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 May 2019 03:35:22 -0400
X-UUID: 6e2832516f8746e5ba414606f3f850cf-20190523
X-UUID: 6e2832516f8746e5ba414606f3f850cf-20190523
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 523751359; Thu, 23 May 2019 15:35:16 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 23 May 2019 15:35:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 23 May 2019 15:35:14 +0800
From:   Long Cheng <long.cheng@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
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
        Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH 2/2] serial: 8250-mtk: modify uart DMA rx
Date:   Thu, 23 May 2019 15:35:09 +0800
Message-ID: <1558596909-14084-3-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1558596909-14084-1-git-send-email-long.cheng@mediatek.com>
References: <1558596909-14084-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2482CA85B661DC8764D4515A4275E8B6BC1A308EAB7BD6FB1D1E48C73F6E41C32000:8
X-MTK:  N
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Modify uart rx and complete for DMA

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c |   49 +++++++++++++++---------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 417c7c8..f470ded 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -47,7 +47,6 @@
 #define MTK_UART_DMA_EN_RX	0x5
 
 #define MTK_UART_ESCAPE_CHAR	0x77	/* Escape char added under sw fc */
-#define MTK_UART_TX_SIZE	UART_XMIT_SIZE
 #define MTK_UART_RX_SIZE	0x8000
 #define MTK_UART_TX_TRIGGER	1
 #define MTK_UART_RX_TRIGGER	MTK_UART_RX_SIZE
@@ -89,28 +88,30 @@ static void mtk8250_dma_rx_complete(void *param)
 	struct mtk8250_data *data = up->port.private_data;
 	struct tty_port *tty_port = &up->port.state->port;
 	struct dma_tx_state state;
+	int copied, total, cnt;
 	unsigned char *ptr;
-	int copied;
 
-	dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
-				dma->rx_size, DMA_FROM_DEVICE);
+	if (data->rx_status == DMA_RX_SHUTDOWN)
+		return;
 
 	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
+	total = dma->rx_size - state.residue;
+	cnt = total;
 
-	if (data->rx_status == DMA_RX_SHUTDOWN)
-		return;
+	if ((data->rx_pos + cnt) > dma->rx_size)
+		cnt = dma->rx_size - data->rx_pos;
 
-	if ((data->rx_pos + state.residue) <= dma->rx_size) {
-		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
-		copied = tty_insert_flip_string(tty_port, ptr, state.residue);
-	} else {
-		ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
-		copied = tty_insert_flip_string(tty_port, ptr,
-						dma->rx_size - data->rx_pos);
+	ptr = (unsigned char *)(data->rx_pos + dma->rx_buf);
+	copied = tty_insert_flip_string(tty_port, ptr, cnt);
+	data->rx_pos += cnt;
+
+	if (total > cnt) {
 		ptr = (unsigned char *)(dma->rx_buf);
-		copied += tty_insert_flip_string(tty_port, ptr,
-				data->rx_pos + state.residue - dma->rx_size);
+		cnt = total - cnt;
+		copied += tty_insert_flip_string(tty_port, ptr, cnt);
+		data->rx_pos = cnt;
 	}
+
 	up->port.icount.rx += copied;
 
 	tty_flip_buffer_push(tty_port);
@@ -121,9 +122,7 @@ static void mtk8250_dma_rx_complete(void *param)
 static void mtk8250_rx_dma(struct uart_8250_port *up)
 {
 	struct uart_8250_dma *dma = up->dma;
-	struct mtk8250_data *data = up->port.private_data;
 	struct dma_async_tx_descriptor	*desc;
-	struct dma_tx_state	 state;
 
 	desc = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
 					   dma->rx_size, DMA_DEV_TO_MEM,
@@ -138,12 +137,6 @@ static void mtk8250_rx_dma(struct uart_8250_port *up)
 
 	dma->rx_cookie = dmaengine_submit(desc);
 
-	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
-	data->rx_pos = state.residue;
-
-	dma_sync_single_for_device(dma->rxchan->device->dev, dma->rx_addr,
-				   dma->rx_size, DMA_FROM_DEVICE);
-
 	dma_async_issue_pending(dma->rxchan);
 }
 
@@ -156,13 +149,11 @@ static void mtk8250_dma_enable(struct uart_8250_port *up)
 	if (data->rx_status != DMA_RX_START)
 		return;
 
-	dma->rxconf.direction		= DMA_DEV_TO_MEM;
-	dma->rxconf.src_addr_width	= dma->rx_size / 1024;
-	dma->rxconf.src_addr		= dma->rx_addr;
+	dma->rxconf.src_port_window_size	= dma->rx_size;
+	dma->rxconf.src_addr				= dma->rx_addr;
 
-	dma->txconf.direction		= DMA_MEM_TO_DEV;
-	dma->txconf.dst_addr_width	= MTK_UART_TX_SIZE / 1024;
-	dma->txconf.dst_addr		= dma->tx_addr;
+	dma->txconf.dst_port_window_size	= UART_XMIT_SIZE;
+	dma->txconf.dst_addr				= dma->tx_addr;
 
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR |
 		UART_FCR_CLEAR_XMIT);
-- 
1.7.9.5

