Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA745D6B5
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353849AbhKYJGG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:06:06 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:35754 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbhKYJEF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830855; x=1669366855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e0xW+vtVjmLjsFf+6NA01ekbm3ImpiahvMaEB+GwpuM=;
  b=oW/+iBj0ZMz4R0JVxHzvOqkjtcbN50+cmFhae6wq83MzVznNo8PhLKe2
   dQi0lqvNQ09ugJdI1Q5d8d6Wx24iiutHYae6LBNvZasXXyat8sw2mbQeB
   QSV+Fm/BePimkp5+1+vKKtom+SZag+/AHH0mo/mtVfLLEkBwv4/JFJ8lN
   AYs3KJrBYPvqkG3Knawpj0UQkFP77htiwgC/wF07IJtcTeC8XKQhI4b+P
   qHKCpddo0BXdjgDkYyW41w/tCk7EuvXkbTecySV5CnG3aCxgl5dsxghDd
   ThqGhzBO7mHV40ZIUJmKAifme2TD/G475r9AWuu2Lh4NQqHMY34axEpP6
   Q==;
IronPort-SDR: n2gujLM5LqrbMg+iNdjizYWaI56rI1O50LpeIETyYLJLYx8ZxrC8hw5GSoEylWEKLjmVeYZpMj
 LN4aVJIW0+YyjMk4wA8so92TIBNkl4L8x198mG5ye097qhVYRk9gDgj9quGI81pRese9Vt1/tt
 Dw1P6jpUvG/Ww7eHAbCk5J5fRrUMoePjCClMGoAbJghu+Vd4i9pd83Ec/z/+D96hdbNToEBB3E
 qNZ2xLGnhQdpanuv9IySo6+RJJT3sD+0Tre3DZ4+4ueIa11u4wrA+RN13SMTDnij/hdGsdOfn/
 WOw80xeX1V56nLvbnw0UkvFp
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="145121879"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:00:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:00:49 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:00:46 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 05/13] dmaengine: at_xdmac: Print debug message after realeasing the lock
Date:   Thu, 25 Nov 2021 11:00:20 +0200
Message-ID: <20211125090028.786832-6-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
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

