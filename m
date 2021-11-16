Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20521453056
	for <lists+dmaengine@lfdr.de>; Tue, 16 Nov 2021 12:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhKPLZE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Nov 2021 06:25:04 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:8935 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhKPLYa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Nov 2021 06:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637061693; x=1668597693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wxTxrAyDEObrB+6U2ISe3JfymaOVc1XxubqpmlFsG4s=;
  b=kXYLc/l1Jw8i4Mc574yLMUEFhVX1EQ0lCcS81UBiOIiC7lOpBPaj9MwW
   1ix/SZJ64CfIpM/uCY24MobeWlyiONcvGEumC/3pf64AfOPSXyT2SeIIf
   rWiiLEUDRY8LhPhstuueJ4bNfDBy4YmLA4NvYkxVM5T6LfosaHqqp+Oxz
   /HVxiR/YIsra051Q6AF8l4sRptnqU/XQcM25uOw2ngSOtHezCoo4xZFVF
   jps+liwgDN9QxWNaSRzRy5Un3pb8OUrtNFUA28Qdq71I3HcCbqUR71nl4
   G1QCVrDqwVVFJYo43Wbil2QIm7luVQKR2VVB4H76h+qz7ZInBjrGysM2h
   w==;
IronPort-SDR: +klTsaNsJRHc5UsqIf+tQaaWFIm16NfFRFpzoUyBGO6O8OEvukF0O4L96+arZyMRX/SkdOQZJq
 LmzV75PpBvQTEWYooZM4m0WhyAVvSX7ZNWmXmr+q4suV3MU1bCUE6nyt6yf64mgqT0KMHKxWwN
 KKjQb/yrF8f9Zv+CJYrNPTvJX5DqlNaWCPgQV5qsRpQqGKRkcQyztyE8Gf7w75iPNXivAbFyWl
 eE2xhg6sJAugeXUTCobhUPlR6mdTOoIXy788ooEG3NMAsQ7g25Bd7rCKCm61nnh08OHzlOBHzq
 ASmeDMtMKdzp1PHkvTd4Ep7J
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="144082954"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 04:21:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 04:21:29 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 16 Nov 2021 04:21:25 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 13/13] dmaengine: at_xdmac: Fix race over irq_status
Date:   Tue, 16 Nov 2021 13:20:36 +0200
Message-ID: <20211116112036.96349-14-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211116112036.96349-1-tudor.ambarus@microchip.com>
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tasklets run with interrupts enabled, so we need to protect
atchan->irq_status with spin_lock_irq() otherwise the tasklet can be
interrupted by the IRQ that modifies irq_status. While at this, rewrite
at_xdmac_tasklet() so that we get rid of a level of indentation.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 80 +++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ccd6ddb12b83..082c18d45188 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1623,6 +1623,7 @@ static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
 		dmaengine_desc_get_callback_invoke(txd, NULL);
 }
 
+/* Called with atchan->lock held. */
 static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 {
 	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
@@ -1641,8 +1642,6 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 	if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
 		dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
 
-	spin_lock_irq(&atchan->lock);
-
 	/* Channel must be disabled first as it's not done automatically */
 	at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
 	while (at_xdmac_read(atxdmac, AT_XDMAC_GS) & atchan->mask)
@@ -1652,10 +1651,8 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 				    struct at_xdmac_desc,
 				    xfer_node);
 
-	spin_unlock_irq(&atchan->lock);
-
 	/* Print bad descriptor's details if needed */
-	dev_dbg(chan2dev(&atchan->chan),
+	dev_err(chan2dev(&atchan->chan),
 		"%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
 		__func__, &bad_desc->lld.mbr_sa, &bad_desc->lld.mbr_da,
 		bad_desc->lld.mbr_ubc);
@@ -1665,55 +1662,52 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 
 static void at_xdmac_tasklet(struct tasklet_struct *t)
 {
+	struct dma_async_tx_descriptor *txd;
 	struct at_xdmac_chan	*atchan = from_tasklet(atchan, t, tasklet);
 	struct at_xdmac_desc	*desc;
 	u32			error_mask;
 
+	if (at_xdmac_chan_is_cyclic(atchan))
+		return at_xdmac_handle_cyclic(atchan);
+
+	error_mask = AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS |
+		AT_XDMAC_CIS_ROIS;
+
+	spin_lock_irq(&atchan->lock);
 	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
 		__func__, atchan->irq_status);
+	if (!(atchan->irq_status & AT_XDMAC_CIS_LIS) &&
+	    !(atchan->irq_status & error_mask)) {
+		return spin_unlock_irq(&atchan->lock);
+	}
 
-	error_mask = AT_XDMAC_CIS_RBEIS
-		     | AT_XDMAC_CIS_WBEIS
-		     | AT_XDMAC_CIS_ROIS;
-
-	if (at_xdmac_chan_is_cyclic(atchan)) {
-		at_xdmac_handle_cyclic(atchan);
-	} else if ((atchan->irq_status & AT_XDMAC_CIS_LIS)
-		   || (atchan->irq_status & error_mask)) {
-		struct dma_async_tx_descriptor  *txd;
-
-		if (atchan->irq_status & error_mask)
-			at_xdmac_handle_error(atchan);
-
-		spin_lock_irq(&atchan->lock);
-		desc = list_first_entry(&atchan->xfers_list,
-					struct at_xdmac_desc,
-					xfer_node);
-		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-		if (!desc->active_xfer) {
-			dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
-			spin_unlock_irq(&atchan->lock);
-			return;
-		}
+	if (atchan->irq_status & error_mask)
+		at_xdmac_handle_error(atchan);
 
-		txd = &desc->tx_dma_desc;
-		dma_cookie_complete(txd);
-		/* Remove the transfer from the transfer list. */
-		list_del(&desc->xfer_node);
-		spin_unlock_irq(&atchan->lock);
+	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc,
+				xfer_node);
+	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
+	if (!desc->active_xfer) {
+		dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
+		return spin_unlock_irq(&atchan->lock);
+	}
 
-		if (txd->flags & DMA_PREP_INTERRUPT)
-			dmaengine_desc_get_callback_invoke(txd, NULL);
+	txd = &desc->tx_dma_desc;
+	dma_cookie_complete(txd);
+	/* Remove the transfer from the transfer list. */
+	list_del(&desc->xfer_node);
+	spin_unlock_irq(&atchan->lock);
 
-		dma_run_dependencies(txd);
+	if (txd->flags & DMA_PREP_INTERRUPT)
+		dmaengine_desc_get_callback_invoke(txd, NULL);
 
-		spin_lock_irq(&atchan->lock);
-		/* Move the xfer descriptors into the free descriptors list. */
-		list_splice_tail_init(&desc->descs_list,
-				      &atchan->free_descs_list);
-		at_xdmac_advance_work(atchan);
-		spin_unlock_irq(&atchan->lock);
-	}
+	dma_run_dependencies(txd);
+
+	spin_lock_irq(&atchan->lock);
+	/* Move the xfer descriptors into the free descriptors list. */
+	list_splice_tail_init(&desc->descs_list, &atchan->free_descs_list);
+	at_xdmac_advance_work(atchan);
+	spin_unlock_irq(&atchan->lock);
 }
 
 static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
-- 
2.25.1

