Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6694645303A
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhKPLY2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:24:28 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9398 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbhKPLXv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061654; x=1668597654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7030hvhk+GyvGFoZdT8hEUR+asnDYZB5TD3r6ASNYf8=;
  b=mphiBJUYtn6A5QqN4jYb4cvxrOwqR9tOYC8HTQMp+SxEUXvXxe6+zOqV
   USlYyrVV2RPdLdm78AzFRe/QFq4GR5oZJ0PCsqQO4+T0Hgwpuq4v1pDqO
   31YWleFvVpaPXBsC4W/nczPKC6M2cvA5qxgZ4p+Dbmkm6LAwkFmo5aSSK
   SKG+jeAlbZfer7OcGr7xLB90lpe1q2n9juLcujDaQ54228dbFeEE3m6u8
   R/xg6bNS0AgS8MRfmrecPykJJx1lMHBoHige7JcOSt9e78U+2WUOMdIF/
   OTj4QTTYj+tBGDnPI7/MHgAuL7tUZ1ZSohpAWbDTBuFxcN67PIldFOjpW
   w==;
IronPort-SDR: vP4IylrDmpr41BZ0h9LqOX4oYD4f/RLAgj6VzjZ+gMpavYHlc81Un63nhcsYlM2XPxcEvKsbMK
 i4v68XL3MUM1NfObDxUdnJoEPOBCmc/UgFYJ6paBjsxfvE7+qGuZfa51udfG+SwkaVaOU9Ff74
 LlicIewnJGYIf76z2Ppjb3SYiVdDqP5DDKNlLCSjAMmBmTPf4zBr/P2METbN4Lh9MRkieXgbBh
 pXOYt5JhC6PT9/HxNVNkyNzn8/aCmSQME9qQqpWyIspUgJi1mZGm8hZj49GbCcfheuDceiXEt3
 SWqBAexBtnZJgKADTUStv431
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="139277971"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:20:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:20:52 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:20:49 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 03/13] tty: serial: atmel: Call dma_async_issue_pending()
Date:   Tue, 16 Nov 2021 13:20:26 +0200
Message-ID: <20211116112036.96349-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver wrongly assummed that tx_submit() will start the transfer,
which is not the case, now that the at_xdmac driver is fixed. tx_submit
is supposed to push the current transaction descriptor to a pending queue,
waiting for issue_pending to be called. issue_pending must start the
transfer, not tx_submit. While touching atmel_prepare_rx_dma(), introduce
a local variable for the RX dma channel.

Fixes: 34df42f59a60 ("serial: at91: add rx dma support")
Fixes: 08f738be88bb ("serial: at91: add tx dma support")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 376f7a9c2868..b3e593f3c17f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1009,6 +1009,8 @@ static void atmel_tx_dma(struct uart_port *port)
 				atmel_port->cookie_tx);
 			return;
 		}
+
+		dma_async_issue_pending(chan);
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -1191,6 +1193,7 @@ static void atmel_rx_from_dma(struct uart_port *port)
 static int atmel_prepare_rx_dma(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	struct dma_chan *chan_rx;
 	struct device *mfd_dev = port->dev->parent;
 	struct dma_async_tx_descriptor *desc;
 	dma_cap_mask_t		mask;
@@ -1203,11 +1206,13 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_CYCLIC, mask);
 
-	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
-	if (atmel_port->chan_rx == NULL)
+	chan_rx = dma_request_slave_channel(mfd_dev, "rx");
+	if (chan_rx == NULL)
 		goto chan_err;
+	atmel_port->chan_rx = chan_rx;
+
 	dev_info(port->dev, "using %s for rx DMA transfers\n",
-		dma_chan_name(atmel_port->chan_rx));
+		 dma_chan_name(chan_rx));
 
 	spin_lock_init(&atmel_port->lock_rx);
 	sg_init_table(&atmel_port->sg_rx, 1);
@@ -1239,8 +1244,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	config.src_addr = port->mapbase + ATMEL_US_RHR;
 	config.src_maxburst = 1;
 
-	ret = dmaengine_slave_config(atmel_port->chan_rx,
-				     &config);
+	ret = dmaengine_slave_config(chan_rx, &config);
 	if (ret) {
 		dev_err(port->dev, "DMA rx slave configuration failed\n");
 		goto chan_err;
@@ -1249,7 +1253,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	 * Prepare a cyclic dma transfer, assign 2 descriptors,
 	 * each one is half ring buffer size
 	 */
-	desc = dmaengine_prep_dma_cyclic(atmel_port->chan_rx,
+	desc = dmaengine_prep_dma_cyclic(chan_rx,
 					 sg_dma_address(&atmel_port->sg_rx),
 					 sg_dma_len(&atmel_port->sg_rx),
 					 sg_dma_len(&atmel_port->sg_rx)/2,
@@ -1269,12 +1273,14 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 		goto chan_err;
 	}
 
+	dma_async_issue_pending(chan_rx);
+
 	return 0;
 
 chan_err:
 	dev_err(port->dev, "RX channel not available, switch to pio\n");
 	atmel_port->use_dma_rx = false;
-	if (atmel_port->chan_rx)
+	if (chan_rx)
 		atmel_release_rx_dma(port);
 	return -EINVAL;
 }
-- 
2.25.1

