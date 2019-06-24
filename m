Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F8150AC6
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfFXMft (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:35:49 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:51570 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFXMfs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 08:35:48 -0400
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id Ucbi200093XaVaC01cbi87; Mon, 24 Jun 2019 14:35:45 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hfOCE-0003jw-FD; Mon, 24 Jun 2019 14:35:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hfOCE-0005NW-E2; Mon, 24 Jun 2019 14:35:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] serial: sh-sci: Fix TX DMA buffer flushing and workqueue races
Date:   Mon, 24 Jun 2019 14:35:39 +0200
Message-Id: <20190624123540.20629-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624123540.20629-1-geert+renesas@glider.be>
References: <20190624123540.20629-1-geert+renesas@glider.be>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When uart_flush_buffer() is called, the .flush_buffer() callback zeroes
the tx_dma_len field.  This may race with the work queue function
handling transmit DMA requests:

  1. If the buffer is flushed before the first DMA API call,
     dmaengine_prep_slave_single() may be called with a zero length,
     causing the DMA request to never complete, leading to messages
     like:

        rcar-dmac e7300000.dma-controller: Channel Address Error happen

     and, with debug enabled:

	sh-sci e6e88000.serial: sci_dma_tx_work_fn: ffff800639b55000: 0...0, cookie 126

     and DMA timeouts.

  2. If the buffer is flushed after the first DMA API call, but before
     the second, dma_sync_single_for_device() may be called with a zero
     length, causing the transmit data not to be flushed to RAM, and
     leading to stale data being output.

Fix this by:
  1. Letting sci_dma_tx_work_fn() return immediately if the transmit
     buffer is empty,
  2. Extending the critical section to cover all DMA preparational work,
     so tx_dma_len stays consistent for all of it,
  3. Using local copies of circ_buf.head and circ_buf.tail, to make sure
     they match the actual operation above.

Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Suggested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index abc705716aa094fd..d4504daff99263f5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1398,6 +1398,7 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned long flags;
 	dma_addr_t buf;
+	int head, tail;
 
 	/*
 	 * DMA is idle now.
@@ -1407,16 +1408,23 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
 	 * consistent xmit buffer state.
 	 */
 	spin_lock_irq(&port->lock);
-	buf = s->tx_dma_addr + (xmit->tail & (UART_XMIT_SIZE - 1));
+	head = xmit->head;
+	tail = xmit->tail;
+	buf = s->tx_dma_addr + (tail & (UART_XMIT_SIZE - 1));
 	s->tx_dma_len = min_t(unsigned int,
-		CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
-		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE));
-	spin_unlock_irq(&port->lock);
+		CIRC_CNT(head, tail, UART_XMIT_SIZE),
+		CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE));
+	if (!s->tx_dma_len) {
+		/* Transmit buffer has been flushed */
+		spin_unlock_irq(&port->lock);
+		return;
+	}
 
 	desc = dmaengine_prep_slave_single(chan, buf, s->tx_dma_len,
 					   DMA_MEM_TO_DEV,
 					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
+		spin_unlock_irq(&port->lock);
 		dev_warn(port->dev, "Failed preparing Tx DMA descriptor\n");
 		goto switch_to_pio;
 	}
@@ -1424,18 +1432,18 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
 	dma_sync_single_for_device(chan->device->dev, buf, s->tx_dma_len,
 				   DMA_TO_DEVICE);
 
-	spin_lock_irq(&port->lock);
 	desc->callback = sci_dma_tx_complete;
 	desc->callback_param = s;
-	spin_unlock_irq(&port->lock);
 	s->cookie_tx = dmaengine_submit(desc);
 	if (dma_submit_error(s->cookie_tx)) {
+		spin_unlock_irq(&port->lock);
 		dev_warn(port->dev, "Failed submitting Tx DMA descriptor\n");
 		goto switch_to_pio;
 	}
 
+	spin_unlock_irq(&port->lock);
 	dev_dbg(port->dev, "%s: %p: %d...%d, cookie %d\n",
-		__func__, xmit->buf, xmit->tail, xmit->head, s->cookie_tx);
+		__func__, xmit->buf, tail, head, s->cookie_tx);
 
 	dma_async_issue_pending(chan);
 	return;
-- 
2.17.1

