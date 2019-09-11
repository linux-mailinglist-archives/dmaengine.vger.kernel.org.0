Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD756AFF47
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2019 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfIKOzk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Sep 2019 10:55:40 -0400
Received: from mx1.emlix.com ([188.40.240.192]:37226 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbfIKOzk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Sep 2019 10:55:40 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 10:55:39 EDT
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id CB1555FCF6;
        Wed, 11 Sep 2019 16:50:00 +0200 (CEST)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     linux-kernel@vger.kernel.org
Cc:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH 3/4] serial: imx: adapt rx buffer and dma periods
Date:   Wed, 11 Sep 2019 16:49:42 +0200
Message-Id: <20190911144943.21554-4-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Using only 4 DMA periods for UART RX is very few if we have a high
frequency of small transfers - like in our case using Bluetooth with many
small packets via UART - causing many dma transfers but in each only
filling a fraction of a single buffer. Such a case may lead to the
situation that DMA RX transfer is triggered but no buffer is available.
While we have addressed the dma handling already we still want to avoid
UART RX FIFO overrun. So we decrease the size of the buffers and increase
their number and the total buffer size.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---
 drivers/tty/serial/imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 57d6e6ba556e..cdc51569237c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1028,8 +1028,6 @@ static void imx_uart_timeout(struct timer_list *t)
 	}
 }
 
-#define RX_BUF_SIZE	(PAGE_SIZE)
-
 /*
  * There are two kinds of RX DMA interrupts(such as in the MX6Q):
  *   [1] the RX DMA buffer is full.
@@ -1112,7 +1110,8 @@ static void imx_uart_dma_rx_callback(void *data)
 }
 
 /* RX DMA buffer periods */
-#define RX_DMA_PERIODS 4
+#define RX_DMA_PERIODS	16
+#define RX_BUF_SIZE	(PAGE_SIZE / 4)
 
 static int imx_uart_start_rx_dma(struct imx_port *sport)
 {
-- 
2.23.0

