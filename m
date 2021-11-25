Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2BA45D6B8
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353873AbhKYJGI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:06:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17379 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353566AbhKYJEH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830856; x=1669366856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xHR1pSMET19iq1R2ORya7V1yqiD9c113vKBUFK5yTw=;
  b=L4XZg4gAll3zuMPyDJ06ZnHtJxvFEVGjd/WjdWb1a3uz+NLcK2QB2m+Z
   PfFXPEqdRhXIxPVJc+glmBTg6/RspTiWpVlfzWk6dUhxXxWFuI9xhXQzQ
   JvhtcOKiougplFy1RLowd0hQQJdze8rnfDEANfSB5yRHNWGqPhcMfnXud
   zCPYRi8rUw6x2xHqWrypZxDYmzAGUKbmBhR8I6WoyP4l/8Is7K2lYWH5C
   GC7lR8NlVuEME/QTF3UUTr7Xzz1dzqMsNwXQLQzM0XtCGyI+4EXBYlSB/
   yPHgSXFEQTBBDJ4xYe50Tqhg6R3bW8aa2+vPlqyHNSp7PY/sNRXRpN22f
   w==;
IronPort-SDR: dabU9dLW4qKDsvn0Eu1nLS3EMTV2WJ8SGT4eW+YHLq5VlzssreaOrMSiNYjP6itM5nM9hNAHXi
 EkcIksnJwTGYNEFRpJQrBNJ4fV616j5fx6NFntyZ91Oa81DYvOg3aFn0EO4wRlyMigujI0Z7fN
 Fj/RqCNwlAJBFyNLaeVNZEPIreAB3tVM7Of/QTzzvBSHfPbx3RsxuwjdOH9ZHYRwdP+TRoYJ5q
 k4qGHL+3eVYMg5uVi6o/dJeyyqgO1/l2U7PwJHyFnVFgPK1ur6dgc5f9NLEnDE/uKxeMsxwt8K
 aW/E7pTXPORs5JIfMIA0+Z5R
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="137700269"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:00:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:00:53 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:00:50 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 06/13] dmaengine: at_xdmac: Fix concurrency over chan's completed_cookie
Date:   Thu, 25 Nov 2021 11:00:21 +0200
Message-ID: <20211125090028.786832-7-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Caller of dma_cookie_complete is expected to hold a lock to prevent
concurrency over the channel's completed cookie marker.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index b45ae4fee9db..4d8476845c20 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1703,11 +1703,10 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 		}
 
 		txd = &desc->tx_dma_desc;
-
+		dma_cookie_complete(txd);
 		at_xdmac_remove_xfer(atchan, desc);
 		spin_unlock_irq(&atchan->lock);
 
-		dma_cookie_complete(txd);
 		if (txd->flags & DMA_PREP_INTERRUPT)
 			dmaengine_desc_get_callback_invoke(txd, NULL);
 
-- 
2.25.1

