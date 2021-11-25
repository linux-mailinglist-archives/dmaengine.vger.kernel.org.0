Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974C945D6B2
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353827AbhKYJGC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:06:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25006 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353564AbhKYJEB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830851; x=1669366851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVeVzCqLqbVxX1jH3+OLNjcxNS2IlcvbF+cf1Wql48c=;
  b=vnbyhKdwQzLOBeGu6tHb2FvRgiXTZthbhqunbnrNJnfeyYU4ESMVxa/l
   cHc13jKw9TbDlfP7ismVuDFrK4STFJalEnZK3VLHr3RUTWOOx85XrARp7
   W55yUpmOmD25pqi4E8UO/sa2F4ZX7QMG3+xpO75/kMFnlR8uStYzx6vOL
   Pf9gNe7g/4Jxn/VcBV1PY6kh+a8bkGf4iqoGhqPJUV6hKI1WYFo0T8Xoz
   xQXy9yu4yrI2jTfF8KVvbB9lVP0RVap835DAJSqah03A6j1cZpDMSB0qc
   eSYNu/d9JWwFijRmW/V6KEKe4flsl3UGercY+VWKk68SXPKg8Zzga7Jfh
   Q==;
IronPort-SDR: wwdNLaSeDwc3uZjrbnVoHjfv6c3saIjn6b2PUPy/Jnh+fPFqY5h0ByCAKWbZCuT5EsXsayUO1I
 2GGDGUbInNcUfliVF6ouY3j7BfHii7/GUxarWU7rrSmf4ExD44lLakQQOSLY95oZE03GLN1tTp
 X9wq/I6V+gWnXfrQF7WagYn3lmKmgYqQpitsIwEn87d7EylYbgMKnWo72FP7vvUmqEFgEQ78Rl
 KLi/sCU0wEx5BpdnvKPTyjsE7PvE0NaaZEMCqsVSEcMvIHSdYusGV25Qenxw4a4+bD4KHHeYKK
 pc+Eoq4Gu0+MAgBfipR4aScO
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="77556049"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:00:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:00:46 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:00:43 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 04/13] dmaengine: at_xdmac: Start transfer for cyclic channels in issue_pending
Date:   Thu, 25 Nov 2021 11:00:19 +0200
Message-ID: <20211125090028.786832-5-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Cyclic channels must too call issue_pending in order to start a
transfer. This wrongly worked before, because in the past the
transfer was started at tx_submit level when only a desc in the
transfer list.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ccf796a3b9f3..9a5c68eda801 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1778,11 +1778,9 @@ static void at_xdmac_issue_pending(struct dma_chan *chan)
 
 	dev_dbg(chan2dev(&atchan->chan), "%s\n", __func__);
 
-	if (!at_xdmac_chan_is_cyclic(atchan)) {
-		spin_lock_irqsave(&atchan->lock, flags);
-		at_xdmac_advance_work(atchan);
-		spin_unlock_irqrestore(&atchan->lock, flags);
-	}
+	spin_lock_irqsave(&atchan->lock, flags);
+	at_xdmac_advance_work(atchan);
+	spin_unlock_irqrestore(&atchan->lock, flags);
 
 	return;
 }
-- 
2.25.1

