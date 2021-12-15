Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2FC475733
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 12:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbhLOLBl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 06:01:41 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:23511 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbhLOLBj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 06:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639566099; x=1671102099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XvtFfCx1rLVyUeXpqg4YPLygK1ixJghu3MJP5+44Jns=;
  b=pwzqVx+7GQPjEG8nXd2tn0a9bk5TInIaTdgDL2kqDhuG8BCzuiF6puXb
   iCwgmI3+blBxSPVRNBWJMrnJPKraJdZERFteL2ohU0IyrmxBUSNGDh+GG
   d3TYFUe95GYtRmfuq7gDql9gBBaKaho1lkxwzUaXrfG2nn28npQWjK+pY
   4vzzcU8azxylcS/COisAt/Eo4qoVUppl5h6XWtJUKv/zr4LPPgNbWDlhI
   SEASkkrtTQbTd+HTObcVnqPUSodKpLpYMk2IeuAZ3JAg/tvs9rGYXvLGl
   Jlo+EZPfibeUf7JEqcbehZpcQnZTPDsPmvmX4KdxBMhB1a+BIiXaJbfU7
   A==;
IronPort-SDR: Im18tkvGcN0wtb6sizqdmXMoVo4izt4F/wxC+1nfh2QTsEdvS47omxlOVWPdCBeL5gdIgUs9BP
 6AsaEWGTwgALAKxF+g0p/wLcmMf5pgcqIitRLvc95SB0hVbt7+DgOIw4T+41oOc/M7+4wloLm6
 Uetpkgn68rrD2HJFuC597wQcomV2ib4cZULCDLuAGmjGV+7JEBQIn2SU4qllekuRTaCY3TNZzG
 tz+oSdFflhBeZ1TgEBBrtVrgeUmHLG0CfFW6C8pQEbFBSoAZKUmuuwpBrvNwkSf8di8fgh9Rqi
 KMqtx/UEZt9sg8Nc2cokB3S5
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="142483384"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:01:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:01:38 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:01:36 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 07/12] dmaengine: at_xdmac: Fix concurrency over xfers_list
Date:   Wed, 15 Dec 2021 13:01:10 +0200
Message-ID: <20211215110115.191749-8-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215110115.191749-1-tudor.ambarus@microchip.com>
References: <20211215110115.191749-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since tx_submit can be called from a hard IRQ, xfers_list must be
protected with a lock to avoid concurency on the list's elements.
Since at_xdmac_handle_cyclic() is called from a tasklet, spin_lock_irq
is enough to protect from a hard IRQ.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index b6547f1b5645..eeb03065d484 100644
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

