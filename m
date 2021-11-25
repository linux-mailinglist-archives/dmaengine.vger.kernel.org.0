Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B192B45D6C0
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353951AbhKYJGQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:06:16 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:35782 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353583AbhKYJEP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830864; x=1669366864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K/FEmA4LkPsJngFC8rtp+wxmQUsyLjyVWQASV+7XuoM=;
  b=cDRP4N1sn5iKMldWHv1Uu+lxhB9TBX02uAfYnDWju0QfYUcKaT+yacia
   iQQtsTOO3mUj8mh4UvllMsh81Frc8DOUNhT+mAkmC+uhhyAYY114+9T4k
   FsAVzXHeQ62k5S5GyS9sLu4W+utfIiQ6gRHAMmRLvUrgIH+6MznTLw4Iz
   9+i51F92TjAlfvsYpbb1zKGZyWA4h8AadyIrOYfOQQOI165ooCuNvhXYQ
   Yf0LG7givg7fuw51voTYfelMxHXdxx48a6+RA6lBhuq9ngP82l9vE9vz/
   lL2rjRYHskDESb7HS3QdM7/XZexejkRXPJLjQp7IKZEnm0pyrlQNR6oJp
   g==;
IronPort-SDR: /+Gs0Dgw9sHQuGHVwu3hC6fRTgebf3/L3vAinrlLIXXexeY7pTImM19FOcI7TjxTtCqdewv+lp
 7C0hKLW5Zr1XR/7tHfhqHY9aGW0CmZYYfzdeWlsXiaX13gxp3FflOwlwsIXcNcXWtXvRPd4CWF
 pxaVYUvf84C1JjoI3IzNr5/eAtO9uZrNRrZHLHK7xGRpiMOf/LpxlK1gRy3VMcvV9J7U/8s8OV
 lIx7420ve58kKdQ4DhcOyzuaX7x6UpQtvowWNjzRVNp0O3XbweGAD2/j7Czo1vqUyRlTQZJE/f
 qKceAEhpQ2MZGFvE7lzp6JcZ
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="145121934"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:01:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:01:02 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:00:59 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 09/13] dmaengine: at_xdmac: Fix concurrency over xfers_list
Date:   Thu, 25 Nov 2021 11:00:24 +0200
Message-ID: <20211125090028.786832-10-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since tx_submit can be called from a hard irq, xfers_list must be
protected with a lock to avoid concurency on the list's elements.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 8804a86a9bcc..81f6f1357dcb 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1608,14 +1608,17 @@ static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
 	struct at_xdmac_desc		*desc;
 	struct dma_async_tx_descriptor	*txd;
 
-	if (!list_empty(&atchan->xfers_list)) {
-		desc = list_first_entry(&atchan->xfers_list,
-					struct at_xdmac_desc, xfer_node);
-		txd = &desc->tx_dma_desc;
-
-		if (txd->flags & DMA_PREP_INTERRUPT)
-			dmaengine_desc_get_callback_invoke(txd, NULL);
+	spin_lock_irq(&atchan->lock);
+	if (list_empty(&atchan->xfers_list)) {
+		spin_unlock_irq(&atchan->lock);
+		return;
 	}
+	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc,
+				xfer_node);
+	spin_unlock_irq(&atchan->lock);
+	txd = &desc->tx_dma_desc;
+	if (txd->flags & DMA_PREP_INTERRUPT)
+		dmaengine_desc_get_callback_invoke(txd, NULL);
 }
 
 static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
-- 
2.25.1

