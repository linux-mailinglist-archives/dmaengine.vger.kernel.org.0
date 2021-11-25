Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458CA45D6AD
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353769AbhKYJF6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:05:58 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17363 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353515AbhKYJD5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830846; x=1669366846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIM45Syj4kYFKQaSN/c1s5pHZ3uPQK0krZOBDew05DM=;
  b=O46lbanNL958YrKfYF02PQzb2lk7fKRNVprYEyl9RgTQbPvinn/0Sxbf
   Pqgc7+kqANVnBlDspz8j124LUzNXXT9NZ+V96bSpbVkRnYXfptr9rH6Qv
   FtVcoOHc87Z7pep5GEwPmwUKAYkKRAFp7vVEUKzltY3CxJ8ZsBqIkyWuD
   1s8zzvyFSLF50KRVSP8PoU6zWgELUFEZeo1msUuE965cvQUWF/FnoZAN0
   q40VxvYKPvhl4Q6P5horMXuHgl1pCEAImYZ/FsAivUA81I+o0etxRB37D
   0w9t5qw16iGyiTzZprE8SJRFaF25vsx4xg58btLm3HVMZ547KEejfeWow
   g==;
IronPort-SDR: Nxij3NzZqEF/71SN6wh8X6Zq5Wz54ngQptptk6TV745XvJ67XxLVRSGtoMWyEBrhn9zO+UKsTj
 MDXQ5xUbIPhz692e5yi3NGOtFMkEWv66y7S15mqsKUJxciYmusrFm6P0tP9DhA4lzP3EBq6PYP
 FgKmtAgo5atTQJQy66FuaBli7sTX7sIZL3dvVgTFChBcP6b1xdz/ORMMhzMGqhYVZk2LTX/aqR
 gTUvpU+Su7wfGrcHT9jB5O8oqyrxV92OKOrlUrQOmWcEYd/JkjdQM/16vGz08zOWL3uO1P1u4x
 sQBArGZkb8DjD+rZvOTsZCXA
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="137700238"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:00:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:00:43 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:00:40 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 03/13] tty: serial: atmel: Call dma_async_issue_pending()
Date:   Thu, 25 Nov 2021 11:00:18 +0200
Message-ID: <20211125090028.786832-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
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
transfer, not tx_submit.

Fixes: 34df42f59a60 ("serial: at91: add rx dma support")
Fixes: 08f738be88bb ("serial: at91: add tx dma support")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 376f7a9c2868..269b4500e9e7 100644
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
@@ -1269,6 +1271,8 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 		goto chan_err;
 	}
 
+	dma_async_issue_pending(atmel_port->chan_rx);
+
 	return 0;
 
 chan_err:
-- 
2.25.1

