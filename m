Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3726A3BC
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2019 10:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfGPIYP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jul 2019 04:24:15 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51816 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfGPIYO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Jul 2019 04:24:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6G8O6Ui119083;
        Tue, 16 Jul 2019 03:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563265446;
        bh=4Fiov9ICVTKsuEOGfYBQ72laYt1CMD60PYz6s4obMvc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TGve+00YhWHhMTLWOv8Rn0qCsWrh2RsEz7k9h4P2Y+ajHZ9EWFOcgiREgbDClNcxs
         2QWT0t62vX7RZIIU0O7lSROmsVIWkqz3FKQDmfN7CVCKN3xI0R9cmVWY/OV5sLcNLl
         wYi/jln10NfJcKg0vDJZayAwkscRIzAouStUpEjo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6G8O6vX051628
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jul 2019 03:24:06 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 16
 Jul 2019 03:24:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 16 Jul 2019 03:24:05 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6G8O0lh033709;
        Tue, 16 Jul 2019 03:24:04 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v2 2/2] dmaengine: ti: omap-dma: Improved memcpy polling support
Date:   Tue, 16 Jul 2019 11:24:59 +0300
Message-ID: <20190716082459.1222-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716082459.1222-1-peter.ujfalusi@ti.com>
References: <20190716082459.1222-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When a DMA client driver does not set the DMA_PREP_INTERRUPT because it
does not want to use interrupts for DMA completion or because it can not
rely on DMA interrupts due to executing the memcpy when interrupts are
disabled it will poll the status of the transfer.

If the interrupts are enabled then the cookie will be set completed in the
interrupt handler so only check in HW completion when the polling is really
needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/omap-dma.c | 44 +++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 029c0bd550d5..966d8f0323b5 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -91,6 +91,7 @@ struct omap_desc {
 	bool using_ll;
 	enum dma_transfer_direction dir;
 	dma_addr_t dev_addr;
+	bool polled;
 
 	int32_t fi;		/* for OMAP_DMA_SYNC_PACKET / double indexing */
 	int16_t ei;		/* for double indexing */
@@ -815,26 +816,20 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 	struct virt_dma_desc *vd;
 	enum dma_status ret;
 	unsigned long flags;
+	struct omap_desc *d = NULL;
 
 	ret = dma_cookie_status(chan, cookie, txstate);
-
-	if (!c->paused && c->running) {
-		uint32_t ccr = omap_dma_chan_read(c, CCR);
-		/*
-		 * The channel is no longer active, set the return value
-		 * accordingly
-		 */
-		if (!(ccr & CCR_ENABLE))
-			ret = DMA_COMPLETE;
-	}
-
-	if (ret == DMA_COMPLETE || !txstate)
+	if (ret == DMA_COMPLETE)
 		return ret;
 
 	spin_lock_irqsave(&c->vc.lock, flags);
+	if (c->desc && c->desc->vd.tx.cookie == cookie)
+		d = c->desc;
+
+	if (!txstate)
+		goto out;
 
-	if (c->desc && c->desc->vd.tx.cookie == cookie) {
-		struct omap_desc *d = c->desc;
+	if (d) {
 		dma_addr_t pos;
 
 		if (d->dir == DMA_MEM_TO_DEV)
@@ -851,8 +846,22 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 		txstate->residue = 0;
 	}
 
-	if (ret == DMA_IN_PROGRESS && c->paused)
+out:
+	if (ret == DMA_IN_PROGRESS && c->paused) {
 		ret = DMA_PAUSED;
+	} else if (d && d->polled && c->running) {
+		uint32_t ccr = omap_dma_chan_read(c, CCR);
+		/*
+		 * The channel is no longer active, set the return value
+		 * accordingly and mark it as completed
+		 */
+		if (!(ccr & CCR_ENABLE)) {
+			struct omap_desc *d = c->desc;
+			ret = DMA_COMPLETE;
+			omap_dma_start_desc(c);
+			vchan_cookie_complete(&d->vd);
+		}
+	}
 
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
@@ -1180,7 +1189,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
 	d->ccr = c->ccr;
 	d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_POSTINC;
 
-	d->cicr = CICR_DROP_IE | CICR_FRAME_IE;
+	if (tx_flags & DMA_PREP_INTERRUPT)
+		d->cicr |= CICR_FRAME_IE;
+	else
+		d->polled = true;
 
 	d->csdp = data_type;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

