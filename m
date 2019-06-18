Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C34A209
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfFRNYt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 09:24:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34174 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRNYt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 09:24:49 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5IDOh9E096783;
        Tue, 18 Jun 2019 08:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560864283;
        bh=fEiVVUNxKUTV5pmE+DhrGRrNcaajXtj3g4DtOVkNe0M=;
        h=From:To:CC:Subject:Date;
        b=QlI1GmFLreu8eCjET3RN0CrEx0VSThOz75oIzfCTr1zBTqYix4JHb1h5GJL5Hzmmm
         K2xN9p2g+k0/rd9zSzGlT7N7Kk0jq9+s7NAJdT38K5Vz1DB+sq0xnPWrpaJPcro3Ux
         K/1Sqs+gqOhwD74eliSDF2Wlm5/7ssPnG9W/xnEU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5IDOhbu024943
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Jun 2019 08:24:43 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 18
 Jun 2019 08:23:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 18 Jun 2019 08:23:42 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5IDNeIC121888;
        Tue, 18 Jun 2019 08:23:40 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH] dmaengine: ti: omap-dma: Improved memcpy polling support
Date:   Tue, 18 Jun 2019 16:24:16 +0300
Message-ID: <20190618132416.26874-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
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
Hi,

This patch fine-tunes the omap-dma polled memcpy support to be inline with how
the EDMA driver is handling it.

The polled completion can be tested by applying:
https://patchwork.kernel.org/patch/10966499/

and run the dmatest with polled = 1 on boards where sDMA is used.

Or boot up any dra7 family device with display enabled. The workaround for DMM
errata i878 uses polled DMA memcpy.

Regards,
Peter

 drivers/dma/ti/omap-dma.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 5ba7d8485026..75d8f7e13c8d 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -94,6 +94,7 @@ struct omap_desc {
 	bool using_ll;
 	enum dma_transfer_direction dir;
 	dma_addr_t dev_addr;
+	bool polled;
 
 	int32_t fi;		/* for OMAP_DMA_SYNC_PACKET / double indexing */
 	int16_t ei;		/* for double indexing */
@@ -834,20 +835,10 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 
 	ret = dma_cookie_status(chan, cookie, txstate);
 
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
+	spin_lock_irqsave(&c->vc.lock, flags);
 	if (ret == DMA_COMPLETE || !txstate)
-		return ret;
+		goto out;
 
-	spin_lock_irqsave(&c->vc.lock, flags);
 	vd = vchan_find_desc(&c->vc, cookie);
 	if (vd) {
 		txstate->residue = omap_dma_desc_size(to_omap_dma_desc(&vd->tx));
@@ -868,6 +859,23 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 	}
 	if (ret == DMA_IN_PROGRESS && c->paused)
 		ret = DMA_PAUSED;
+
+out:
+	if (ret == DMA_IN_PROGRESS && c->running && c->desc &&
+	    c->desc->polled && c->desc->vd.tx.cookie == cookie) {
+		uint32_t ccr = omap_dma_chan_read(c, CCR);
+		/*
+		 * The channel is no longer active, set the return value
+		 * accordingly
+		 */
+		if (!(ccr & CCR_ENABLE)) {
+			struct omap_desc *d = c->desc;
+			ret = DMA_COMPLETE;
+			omap_dma_start_desc(c);
+			vchan_cookie_complete(&d->vd);
+		}
+	}
+
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
 	return ret;
@@ -1233,7 +1241,10 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
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

