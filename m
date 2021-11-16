Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC4A45303B
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhKPLYa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:24:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3754 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhKPLXx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061658; x=1668597658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVeVzCqLqbVxX1jH3+OLNjcxNS2IlcvbF+cf1Wql48c=;
  b=pMfzOPxStm9c51za7QZA/+jDEkFlux8X1RoKfs1Zs/KqO4UiiRcIvtdR
   scJPhzDL51RPVU4+fZVai1Rekzapj1WPt0QLW/dpy0FNgOK+kIuglVlWg
   B305nIwx36w5BAIabCjDaVj8aLoXMctA/8tlKNarLlowLznzKuKeYTrmp
   Ejc2DUThBOUbKkaTOQ3ntXOn6/5wezlXHq2MIIAoq29IV+QVDFLB8HcBt
   qoNev23Sh/TfdJo7w/3Y1TfH4ToVseWPV73aYhSn+f3uYL8QvqV8nzt2i
   PyOiqdYpSGbbBS75+y13e2e4NwpkzUVluQn33tJPM0LH6ZVVTNVjCjUwN
   g==;
IronPort-SDR: ptQ4ClZml3U4feFRucCBtUBeG4D6cQHb8HHbkcrn1IlLTDN/KcK6pT4Wi3j3ot6dqWZWUjNrt4
 qFY95XrgSq5nnqwuT6spNUzvwjguNbOOb/zraNi0LwBvLcVt4yo7Rv9PFQKANzEz5sONIj8zm3
 OhhNEpxKhrmw52vf6U01ViQ0u4si2LQElCV8/Jw1dzq9ByOQDMxGWJ58THrP33RS62c3F0fVnl
 ghKwNfymUoCILV+YIj42S6r/tDEoWB0hl49eBleOaeykPks2DROZvkbkig2gBUwAk6kN8EDwNe
 UByUwo93SLhxbXE4qFDt/GFq
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="143500766"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:20:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:20:56 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:20:53 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 04/13] dmaengine: at_xdmac: Start transfer for cyclic channels in issue_pending
Date:   Tue, 16 Nov 2021 13:20:27 +0200
Message-ID: <20211116112036.96349-5-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
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

