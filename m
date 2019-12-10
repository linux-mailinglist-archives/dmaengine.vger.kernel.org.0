Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8796511888F
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 13:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfLJMeY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 07:34:24 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42241 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfLJMeY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Dec 2019 07:34:24 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ieeiF-0003ay-39; Tue, 10 Dec 2019 13:33:59 +0100
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ieeiE-0002DF-7r; Tue, 10 Dec 2019 13:33:58 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/6] dmaengine: imx-sdma: find desc first in sdma_tx_status
Date:   Tue, 10 Dec 2019 13:33:50 +0100
Message-Id: <20191210123352.7555-5-s.hauer@pengutronix.de>
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

In sdma_tx_status() we must first find the current sdma_desc. In cyclic
mode we assume that this can always be found with vchan_find_desc().
This is true because do not remove the current descriptor from the
desc_issued list:

	/*
	 * Do not delete the node in desc_issued list in cyclic mode, otherwise
	 * the desc allocated will never be freed in vchan_dma_desc_free_list
	 */
	if (!(sdmac->flags & IMX_DMA_SG_LOOP))
		list_del(&vd->node);

We will change this in the next step, so check if the current descriptor is
the desired one also for the cyclic case.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 527f8a81f50b..99dbfd9039cf 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1648,7 +1648,7 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 				      struct dma_tx_state *txstate)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_desc *desc;
+	struct sdma_desc *desc = NULL;
 	u32 residue;
 	struct virt_dma_desc *vd;
 	enum dma_status ret;
@@ -1659,19 +1659,23 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 		return ret;
 
 	spin_lock_irqsave(&sdmac->vc.lock, flags);
+
 	vd = vchan_find_desc(&sdmac->vc, cookie);
-	if (vd) {
+	if (vd)
 		desc = to_sdma_desc(&vd->tx);
+	else if (sdmac->desc && sdmac->desc->vd.tx.cookie == cookie)
+		desc = sdmac->desc;
+
+	if (desc) {
 		if (sdmac->flags & IMX_DMA_SG_LOOP)
 			residue = (desc->num_bd - desc->buf_ptail) *
 				desc->period_len - desc->chn_real_count;
 		else
 			residue = desc->chn_count - desc->chn_real_count;
-	} else if (sdmac->desc && sdmac->desc->vd.tx.cookie == cookie) {
-		residue = sdmac->desc->chn_count - sdmac->desc->chn_real_count;
 	} else {
 		residue = 0;
 	}
+
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 
 	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
-- 
2.24.0

