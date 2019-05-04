Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B413C2E
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2019 23:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfEDViI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 May 2019 17:38:08 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56400 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfEDViH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 4 May 2019 17:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1557005886; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=ixblMq9gpsv2V5t/BACIvNf/S56OJS9Yyae3o4eLU6E=;
        b=LEbu+fcyhPKMMdnaGlKBwbYRtSENCThXbjT59r9HC55Hyn31HkDmFDUYDOWXE17Tuum4sY
        RL+Z5fd7NuBVQFJw7592yJzqsa+0UO1S5xHe25DdXorOfIgSlcgi+hMxJNJlJtKA0G6UZe
        8tF7h0kBXCJjnryRTbA7193UZm7+500=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] dmaengine: jz4780: Fix transfers being ACKed too soon
Date:   Sat,  4 May 2019 23:37:57 +0200
Message-Id: <20190504213757.6693-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When a multi-descriptor DMA transfer is in progress, the "IRQ pending"
flag will apparently be set for that channel as soon as the last
descriptor loads, way before the IRQ actually happens. This behaviour
has been observed on the JZ4725B, but maybe other SoCs are affected.

In the case where another DMA transfer is running into completion on a
separate channel, the IRQ handler would then run the completion handler
for our previous channel even if the transfer didn't actually finish.

Fix this by checking in the completion handler that we're indeed done;
if not the interrupted DMA transfer will simply be resumed.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 02075417c69f..5c34d23bdea4 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -662,10 +662,11 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 	return status;
 }
 
-static void jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
-	struct jz4780_dma_chan *jzchan)
+static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
+				struct jz4780_dma_chan *jzchan)
 {
 	uint32_t dcs;
+	bool ack = true;
 
 	spin_lock(&jzchan->vchan.lock);
 
@@ -688,12 +689,20 @@ static void jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 		if ((dcs & (JZ_DMA_DCS_AR | JZ_DMA_DCS_HLT)) == 0) {
 			if (jzchan->desc->type == DMA_CYCLIC) {
 				vchan_cyclic_callback(&jzchan->desc->vdesc);
-			} else {
+
+				jz4780_dma_begin(jzchan);
+			} else if (dcs & JZ_DMA_DCS_TT) {
 				vchan_cookie_complete(&jzchan->desc->vdesc);
 				jzchan->desc = NULL;
-			}
 
-			jz4780_dma_begin(jzchan);
+				jz4780_dma_begin(jzchan);
+			} else {
+				/* False positive - continue the transfer */
+				ack = false;
+				jz4780_dma_chn_writel(jzdma, jzchan->id,
+						      JZ_DMA_REG_DCS,
+						      JZ_DMA_DCS_CTE);
+			}
 		}
 	} else {
 		dev_err(&jzchan->vchan.chan.dev->device,
@@ -701,21 +710,22 @@ static void jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 	}
 
 	spin_unlock(&jzchan->vchan.lock);
+
+	return ack;
 }
 
 static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 {
 	struct jz4780_dma_dev *jzdma = data;
+	unsigned int nb_channels = jzdma->soc_data->nb_channels;
 	uint32_t pending, dmac;
 	int i;
 
 	pending = jz4780_dma_ctrl_readl(jzdma, JZ_DMA_REG_DIRQP);
 
-	for (i = 0; i < jzdma->soc_data->nb_channels; i++) {
-		if (!(pending & (1<<i)))
-			continue;
-
-		jz4780_dma_chan_irq(jzdma, &jzdma->chan[i]);
+	for_each_set_bit(i, (unsigned long *)&pending, nb_channels) {
+		if (jz4780_dma_chan_irq(jzdma, &jzdma->chan[i]))
+			pending &= ~BIT(i);
 	}
 
 	/* Clear halt and address error status of all channels. */
@@ -724,7 +734,7 @@ static irqreturn_t jz4780_dma_irq_handler(int irq, void *data)
 	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC, dmac);
 
 	/* Clear interrupt pending status. */
-	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DIRQP, 0);
+	jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DIRQP, pending);
 
 	return IRQ_HANDLED;
 }
-- 
2.21.0.593.g511ec345e18

