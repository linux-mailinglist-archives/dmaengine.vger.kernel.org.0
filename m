Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6CB453041
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhKPLYc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:24:32 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3771 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhKPLYB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061665; x=1668597665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xHR1pSMET19iq1R2ORya7V1yqiD9c113vKBUFK5yTw=;
  b=U1YFmQ5AnSAKEHVmssrZAqJiNwlV3zBa3wN9FQefYFVf0OAwQiU5y+dz
   EYpuialrpWagzhRkibhmjSCNZ0pMTCJvBtNYX4BVrYV+jyFUzHY0lFc55
   WEiEKxnrXpxtLk5FsjArHxKahDLgv1Ya2uXKaQSNvcz2rZVRFCCIMjbi9
   nylsS7hzwGJw4zmjEssyWFC4fIrGvjZmI0qxUHZHYBtYlMqq2KcvqY5vx
   wuIujdJFnKv6dEPMohdPGJe/vPWpKanW8iZM/S4lQI5Pna4DxWdbR7gmk
   1n4hMy2KeQT/aWh6au/L2gS8r9gIjpWpS8fbOAaMy9ukZ39G44/xwq813
   g==;
IronPort-SDR: nEaswDJg6UvN1Ak1k5snxDBueJXCkjA/TZHVY+1/T2B1dAY07tQGG1LrfRuZa9m+38lrF9XE0P
 lKna2Wl5adWWKHh/HCQ3jNYY7/wZmbI7calkFrXuiDctO/acd4xL3gHUMYLixQoumL3wgP3HRz
 i8KsDoOBZB83LdFviPxl7FyfGzE8ZSUseaKNR/ws+hrHJ+qfTCCfDzF+9W19ycXtRH/yVsQfXh
 mYe9HJf/p4+BhHSyqyAKvQY/Wd5pnsCAb1HE/Ua7Ir3jOAjSVIdpQugbcclg/axCOctF9ta0IR
 94LEaPFwvDU5xku5ARpCm85x
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="143500780"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:21:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:21:03 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:21:00 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 06/13] dmaengine: at_xdmac: Fix concurrency over chan's completed_cookie
Date:   Tue, 16 Nov 2021 13:20:29 +0200
Message-ID: <20211116112036.96349-7-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
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

