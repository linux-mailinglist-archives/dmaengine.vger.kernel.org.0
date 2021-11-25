Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FB245D6B0
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353811AbhKYJF7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:05:59 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:24997 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353468AbhKYJDz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830844; x=1669366844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cg+xZ2PGt65To32w9HMZeNhhilFG7R1i38Kj7UwqKts=;
  b=ow/WyPEzFq/14/+hhp7KniNt+ZYEag5yU+ca3On+oER5+8jzxI2vxWQJ
   ZKJVkZLNU1LANWOpRZFYnZMkerURtXcNVJeLylt9kX7fVBbku+Tjz71KF
   idZlOOuzKzZu8nN5vlxiechGSPhQvNQkEYfoB2gQDy5aHAkJ71uPnpDbg
   C5SjyiU6dyBIWZ7kEqFK2AU7sUJu21PUCZdcsU4RxcmW4AzIQYJpF2PcF
   sSHut1PEkkBHMYzDzi9TD2CuhvZPvpezoXYA9xgOcBqCKKvWdPt91rERL
   r6TOJe1g7Bfq48r25N51SBu0eykdNMCsQ4OfR+SrUSvYtJQuFaJyREJv8
   w==;
IronPort-SDR: ycMZcZFHklBLfUpbzfagNyY871FwnJuGLro2l3NwuVGfKQ21ArXcGJPOMXYGUNjkwv2U6mcoWD
 4cKp7ifp7p0UsAy/bblivdSHVY/db7uj4IAggSwPkmpgg1d9yrrPZBoFoOduNMvm3g+Cp5b5W3
 9SllRejbN+S6i9npKYvaZyH4gcvpstGqvOiaNhL3ZwwgVWycpZrRzVeTiW5Id6YIlszh9OSzZh
 FOY+cdI0XpAqxFA12BvASBmTENM+TWKVzKSJN3/ae0r5BBpXwYtkNUnSkdR8hjYYN2tiiD1nUY
 nwQl/jnuUZSljrjA7AX7I42j
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="77556012"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:00:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:00:39 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:00:36 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 02/13] tty: serial: atmel: Check return code of dmaengine_submit()
Date:   Thu, 25 Nov 2021 11:00:17 +0200
Message-ID: <20211125090028.786832-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The tx_submit() method of struct dma_async_tx_descriptor is entitled
to do sanity checks and return errors if encountered. It's not the
case for the DMA controller drivers that this client is using
(at_h/xdmac), because they currently don't do sanity checks and always
return a positive cookie at tx_submit() method. In case the controller
drivers will implement sanity checks and return errors, print a message
so that the client will be informed that something went wrong at
tx_submit() level.

Fixes: 08f738be88bb ("serial: at91: add tx dma support")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2c99a47a2535..376f7a9c2868 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1004,6 +1004,11 @@ static void atmel_tx_dma(struct uart_port *port)
 		desc->callback = atmel_complete_tx_dma;
 		desc->callback_param = atmel_port;
 		atmel_port->cookie_tx = dmaengine_submit(desc);
+		if (dma_submit_error(atmel_port->cookie_tx)) {
+			dev_err(port->dev, "dma_submit_error %d\n",
+				atmel_port->cookie_tx);
+			return;
+		}
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -1258,6 +1263,11 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	desc->callback_param = port;
 	atmel_port->desc_rx = desc;
 	atmel_port->cookie_rx = dmaengine_submit(desc);
+	if (dma_submit_error(atmel_port->cookie_rx)) {
+		dev_err(port->dev, "dma_submit_error %d\n",
+			atmel_port->cookie_rx);
+		goto chan_err;
+	}
 
 	return 0;
 
-- 
2.25.1

