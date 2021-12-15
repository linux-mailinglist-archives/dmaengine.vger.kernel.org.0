Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C647572F
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbhLOLBe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:34 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23495 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241897AbhLOLBd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566094; x=1671102094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gg1aOoAbFdXCK2iIdjdkeyi1r5cweAwvByOXGAnrlsg=;
  b=bGqEMIAcHDMMyy5YxMzKShzRN+dFL+xMV3GuOpHDhbMZuYt3KR2xqley
   Je48eCxN3oFO2etdl9NTqXCWs0FPuDMwGfJosgkJ+DAJz7EN0J19AnUnD
   N5MKh30sSTB7H1ldyAt4C1Iqneieh35nBNutF+cN6ve8c6hSx28ZoXoaG
   DhjdKTwjY5rlodC8xe6gKTRbeF3HrsfSZFMp5c+vhCWRPAeETPWnaD7Re
   qhZlZQEx1t9lA1Zayb6TYWtzr2x281qfHxkFFlHcmMOLnzzQ6XGCFVQ+l
   8+86Gufm1bP6y5y/YkrxHmB7Be70t1UiiafBjavZRcYEMv7fNJAochJ28
   Q==;
IronPort-SDR: 8U7SQuFLe/DgjTBD8N8bpNi/8HrOYuJlk2UrEq+CgbILcNxq6FpAx5R0OtA1EXv0QFok3r7+Yr
 ouGkW7B76ONMlDwh3zbCaBXHudGRjKetG424hiW6VzGQk38xGtjPqN/5CATRRmkSh5ayqGfF67
 cmJyMl1Nmve6dcN/Y/5Nfl4/KphiQL/t3ZCp4vkvbaxV1166mymniSN9EmWcqxf2HTqCOYepvo
 L1Y7S5jvUWNv2BLMSAUtj9NwimlEX9SzVF1f0T9gfTjBRMN+kPMcDXQjZNEIG3KScIV7htDK/S
 5MIvlG/ewl3mtZzOn5ch8jfy
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="142483369"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:30 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:28 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 04/12] dmaengine: at_xdmac: Fix concurrency over chan's completed_cookie
Date:   Wed, 15 Dec 2021 13:01:07 +0200
Message-ID: <20211215110115.191749-5-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Caller of dma_cookie_complete is expected to hold a lock to prevent
concurrency over the channel's completed cookie marker. Call
dma_cookie_complete() with the lock held.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 7d3560acedbb..83c031207530 100644
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

