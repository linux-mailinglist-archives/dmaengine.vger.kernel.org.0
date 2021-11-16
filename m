Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12633453053
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhKPLYy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:24:54 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:8906 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhKPLYZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061688; x=1668597688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K/FEmA4LkPsJngFC8rtp+wxmQUsyLjyVWQASV+7XuoM=;
  b=XUOEgZnN3uyBQmGHA5g0Ie0z5DXFuSqVfEcPAoCAEBsGswjp8e++zrKf
   BLyJwTW1lrxZlUJLQAbN8vO61P9OaSUxDfD/hSyXq4TAmszkbsh+CdraM
   cKHGGj5qbQ4TnHmD73mWpKh32ncgyqCeIaSzvb7Vl3opHc4hjwxxhw5vA
   qC/Q21ammK4wlVlYQTua4O4Kxvc8/OhAP4NevUbZdNVusaRarmEfMdTUr
   9ov5/gU4t043auwCEehX0GNVjwmJgEOvv0mJWcDGyLLbM5swRefES+eX8
   0ip5xI37NZgcqvlE1y2Kp67acQTeBGNrmtx22vaS0+uI5D8AT73kOQiiP
   w==;
IronPort-SDR: 5I2Vtcxo1XNNrl5JKRV9Iz2lWjTf+jEudImraPfg9kfTsmk9Gq7BpbHvQWy8Z76ZizoLZC3vZg
 BTGwli5YolnlP5P8j2XexhEXs6jh126hdPMjF/YfFzSBYv7O9/IYKm8QZhheb2mNtSo7qIzepI
 uGgKLlma30lWyEE+YiRlCY3Aj7rc0Z0V17CK3GDQBzM2niE0PCJkK6kq75eTlQsZo7rLEh8ZOI
 /Gr8YAacR+NXlJAbFzulHwa1LeroQuar2AXH6L9I4Bsy/tOMAubQSpE+HRiHi9X8q8NKuKtoNt
 R8xnXSG44ai+VvlgIeZKpKym
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="144082911"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:21:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:21:14 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:21:11 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 09/13] dmaengine: at_xdmac: Fix concurrency over xfers_list
Date:   Tue, 16 Nov 2021 13:20:32 +0200
Message-ID: <20211116112036.96349-10-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
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

