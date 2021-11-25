Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B569645D6D6
	for <lists+dmaengine@lfdr.de>; Thu, 25 Nov 2021 10:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353778AbhKYJIG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Nov 2021 04:08:06 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:35754 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353468AbhKYJGF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Nov 2021 04:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637830975; x=1669366975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wxTxrAyDEObrB+6U2ISe3JfymaOVc1XxubqpmlFsG4s=;
  b=FQ8B6kO3cb2yaIYxEdPVNDXJT32BWWitGvHxwQ2jTRniznkMXpzVXhz4
   JsP9gw+qig2wg1oeiU5a0Nyn7svnJ3QHX49lfFN7EXWdApH30xTVzrwio
   FH5PJAA60Fy/m0gO1CQnwf5KE+kBSyg7lOlrP/yL4yh8US1cxUqrtEaNW
   T1INr7B6+SpQ1YkA2hXxBgTS6Jb8oKRUx47dR+tckHg4965mEIG12EA/h
   G/3HlHjaNdHqdS1CkvfGWcsYvNKOIpvPr2ZGnzj5VG1DhrfXYeD0tQiyQ
   uNbCluoNztl7+8XxiaV52r1VxAvaeHdeb1ZrZTMic+vAtp8PMjYwpf8dU
   g==;
IronPort-SDR: Nu8AhUwcC4Ratr26yIMKGc9G1Tj8O578fEcQbMXXZHgRY9h+GsSt8xQCbCD6Y7jJeeHM44pPnb
 NFWReFkhGS/EGEWrN58IaqgLqBW2aJ+DIWF8tGErl7V/zo/OzvFCKRIpuefktdxRfyRFnz4Mpo
 Rv5745oUuj4PSnlicw5ZWTCu+1GAbngFFcpvDLalB74ul15p+h+RxvoEsjYUTHuq/JCurw+hFg
 B5TPfa54iG55s25SFHlukTNjYSkZ3InCW1dUFsZrtpTHOE6039iBs1GmV8qt6Y4eJjuxaQv98V
 rGcEDrD8L88ee6HqmsyFhwDY
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="145122015"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 02:01:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 02:01:16 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 02:01:13 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mripard@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 13/13] dmaengine: at_xdmac: Fix race over irq_status
Date:   Thu, 25 Nov 2021 11:00:28 +0200
Message-ID: <20211125090028.786832-14-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125090028.786832-1-tudor.ambarus@microchip.com>
References: <20211125090028.786832-1-tudor.ambarus@microchip.com>
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

