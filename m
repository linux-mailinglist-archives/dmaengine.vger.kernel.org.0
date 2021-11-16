Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92045303E
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhKPLYb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:24:31 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:8935 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbhKPLX5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061661; x=1668597661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e0xW+vtVjmLjsFf+6NA01ekbm3ImpiahvMaEB+GwpuM=;
  b=nMB8ns5RwTCa4XMS6D/o5KHwAeVHde/xR7XvcZRr55caPOy21a540Ykx
   KJoICsxfvZvA/YN2ayD96dtmYNpBzu/yoTAM5v13V64dz1WPAfKsHjawT
   bEfDayI4e6SCrId7Ps2Qjb6un5uW+s77OzWxG0DMBRec1OlcwgHKQFmoc
   H7mAgi2njB9IM5pP3A2PxCyQn4FEZo1G367a/y+ttp1Czp1JB98FxqqWg
   Gm/QLslRMaJy0dtk1pAgpK0hSVyw+64lecKr9Kh7fpszZv1iCf8exAPjs
   SZEmY18XO6JawNh/lDH3G414KLRtVY27/JaglapKH2FwVkSWxaJevlPx4
   A==;
IronPort-SDR: 26JTCN7gBgMYdZEXQI7b72/koxLIUrA+IBU2Rh29BjwXJWkJ4HldHAhu8kIzVeAFY3/mdHfInZ
 ALh/mOs6nsKCh4VURTMJt7om5GwtbgSpO25xRLkGCXOsGMyFSp6ZmzY1AlmRjMAca8WaymyrSn
 LzGJJcOuMjqijGlDuQquWZGSMZbqkC2ZP+Apvf9w8dtPo8mjlplIDQjRLwsHiiAvN3kq0xjje9
 qNG2501NZt8wJ23Bm+SXuojEzY6OXradVemafDj3lLo1o32Y6r2c5xH85c0L7RICjbPWtzkrN+
 lK5x2BCsTllf3+j66cB036Gt
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="144082858"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:21:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:21:00 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:20:56 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 05/13] dmaengine: at_xdmac: Print debug message after realeasing the lock
Date:   Tue, 16 Nov 2021 13:20:28 +0200
Message-ID: <20211116112036.96349-6-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It is desirable to do the prints without the lock held if possible.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 9a5c68eda801..b45ae4fee9db 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -473,10 +473,12 @@ static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
 	spin_lock_irqsave(&atchan->lock, irqflags);
 	cookie = dma_cookie_assign(tx);
 
-	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
-		 __func__, atchan, desc);
 	list_add_tail(&desc->xfer_node, &atchan->xfers_list);
 	spin_unlock_irqrestore(&atchan->lock, irqflags);
+
+	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
+		 __func__, atchan, desc);
+
 	return cookie;
 }
 
-- 
2.25.1

