Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8AD453039
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhKPLY0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:24:26 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:8906 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbhKPLXv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061654; x=1668597654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xaQDP9vrd8gtsEUZVxgHa5VLGiEX80T1mW9+VkOCiK8=;
  b=cIhFLBS4jMYpAHFKje+Rd7Scpxotkw3b+k6y7iuGck75jNY5M8B2JT94
   PxR0IWfJ3biJ4/nRPfDSVYRFUMSHrJhJULHWyzVR7bkUweJ4kd4bZI0VP
   Fh4IQa/opDqXqn9Ap9Fb2kxk8uf8QAlj8SE4fqm78BwY1lD+obLp1WCun
   fYNm89TFAjONwDOdGam8N5nH8GKsqnxjtovbs8H2M00aMGdRvYlbOq5wM
   8902EHg1EKj+Ast+VfRj38EXF67oWVYwiAcZ2IuznrNaTFNKAxX30U99Q
   rsFpCy6eWVrEoSDvMGwjBc2i0s496MsKfk23e+M3RDquZ19gidG2c1bQk
   Q==;
IronPort-SDR: AvLCpxdZ63WH8CN4xCAxbx9yjhF1PyUe6YemaWAxEi2Bq0ujWbW0gnjoK3O5S/HGcasdKvx77x
 apeh4dceBqeE27QgAp4ltVu6mvwjebZ2TfAogXZhAffZqzosAm6gVXAbE8QpZJHTCeUeWMRSWt
 4VlBy64kDKrmiYVA6S56pjFSXqe8fxKCYGmSq+MUGZoOfMhnrozulvJdFMdVsBdhm6RH0CN8wr
 MlwiI0ah5GBDhcNo+p8swaPXQ8dr3ba3xnSs/PuPsmM92ww4NES2Pp/nVuk3TgTHL399mbjHYK
 OuyLDwj/SyxkZs9MOQ7p1gOP
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="144082826"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:20:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:20:49 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:20:45 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 02/13] tty: serial: atmel: Check return code of dmaengine_submit()
Date:   Tue, 16 Nov 2021 13:20:25 +0200
Message-ID: <20211116112036.96349-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
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

