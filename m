Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18686118889
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 13:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLJMeB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 07:34:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42327 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfLJMeA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Dec 2019 07:34:00 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ieeiF-0003az-32; Tue, 10 Dec 2019 13:33:59 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ieeiE-0002DI-8a; Tue, 10 Dec 2019 13:33:58 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 5/6] dmaengine: imx-sdma: Fix memory leak
Date:   Tue, 10 Dec 2019 13:33:51 +0100
Message-Id: <20191210123352.7555-6-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210123352.7555-1-s.hauer@pengutronix.de>
References: <20191210123352.7555-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The current descriptor is not on any list of the virtual DMA channel.
Once sdma_terminate_all() is called when a descriptor is currently
in flight then this one is forgotten to be freed. We have to call
vchan_terminate_vdesc() on this descriptor to re-add it to the lists.
Now that we also free the currently running descriptor we can (and
actually have to) remove the current descriptor from its list also
for the cyclic case.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 99dbfd9039cf..066b21a32232 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -760,12 +760,8 @@ static void sdma_start_desc(struct sdma_channel *sdmac)
 		return;
 	}
 	sdmac->desc = desc = to_sdma_desc(&vd->tx);
-	/*
-	 * Do not delete the node in desc_issued list in cyclic mode, otherwise
-	 * the desc allocated will never be freed in vchan_dma_desc_free_list
-	 */
-	if (!(sdmac->flags & IMX_DMA_SG_LOOP))
-		list_del(&vd->node);
+
+	list_del(&vd->node);
 
 	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
 	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
@@ -1071,7 +1067,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 
 	spin_lock_irqsave(&sdmac->vc.lock, flags);
 	vchan_get_all_descriptors(&sdmac->vc, &head);
-	sdmac->desc = NULL;
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 	vchan_dma_desc_free_list(&sdmac->vc, &head);
 	sdmac->context_loaded = false;
@@ -1080,11 +1075,19 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 static int sdma_terminate_all(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
 
 	sdma_disable_channel(chan);
 
-	if (sdmac->desc)
+	if (sdmac->desc) {
+		vchan_terminate_vdesc(&sdmac->desc->vd);
+		sdmac->desc = NULL;
 		schedule_work(&sdmac->terminate_worker);
+	}
+
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 
 	return 0;
 }
-- 
2.24.0

