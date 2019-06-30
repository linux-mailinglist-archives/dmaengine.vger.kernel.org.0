Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2765B242
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2019 00:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfF3WxA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jun 2019 18:53:00 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:34098 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfF3WxA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jun 2019 18:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561935178; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=KvIG/VfrTUfK/8wMArtIEsLKTaGU5+E6+X/a55rpgZU=;
        b=yaQQsx/e37FXjMLCckjNTuIDcxCfdKLkM2xc5dPSDTn6lM2VRUjbriHATJNNLSC1IPEHHH
        ry1R4vGjXOhHRXMoCxYdUTrkM1pb2aCfhPJD0OV1F+604+wF54Xyeezzw1tbHXA1w4JpPC
        g0KYI+9BYjyQLDiSDzolRA2bkLG89zc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] dmaengine: dma-jz4780: Break descriptor chains on JZ4740
Date:   Mon,  1 Jul 2019 00:52:49 +0200
Message-Id: <20190630225249.27369-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The current driver works perfectly fine on every generation of the
JZ47xx SoCs, except on the JZ4740.

There, when hardware descriptors are chained together (with the LINK
bit set), the next descriptor isn't automatically fetched as it should -
instead, an interrupt is raised, even if the TIE bit (Transfer Interrupt
Enable) bit is cleared. When it happens, the DMA transfer seems to be
stopped (it doesn't chain), and it's uncertain how many bytes have
actually been transferred.

Until somebody smarter than me can figure out how to make chained
descriptors work on the JZ4740, we now disable chained descriptors on
that particular SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 263bee76ef0d..aae83389cc10 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -92,6 +92,7 @@
 #define JZ_SOC_DATA_PROGRAMMABLE_DMA	BIT(1)
 #define JZ_SOC_DATA_PER_CHAN_PM		BIT(2)
 #define JZ_SOC_DATA_NO_DCKES_DCKEC	BIT(3)
+#define JZ_SOC_DATA_BREAK_LINKS		BIT(4)
 
 /**
  * struct jz4780_dma_hwdesc - descriptor structure read by the DMA controller.
@@ -356,6 +357,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_slave_sg(
 	void *context)
 {
 	struct jz4780_dma_chan *jzchan = to_jz4780_dma_chan(chan);
+	struct jz4780_dma_dev *jzdma = jz4780_dma_chan_parent(jzchan);
 	struct jz4780_dma_desc *desc;
 	unsigned int i;
 	int err;
@@ -376,7 +378,8 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_slave_sg(
 
 		desc->desc[i].dcm |= JZ_DMA_DCM_TIE;
 
-		if (i != (sg_len - 1)) {
+		if (i != (sg_len - 1) &&
+		    !(jzdma->soc_data->flags & JZ_SOC_DATA_BREAK_LINKS)) {
 			/* Automatically proceeed to the next descriptor. */
 			desc->desc[i].dcm |= JZ_DMA_DCM_LINK;
 
@@ -665,6 +668,7 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 				struct jz4780_dma_chan *jzchan)
 {
+	struct jz4780_dma_desc *desc = jzchan->desc;
 	uint32_t dcs;
 	bool ack = true;
 
@@ -692,8 +696,10 @@ static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 
 				jz4780_dma_begin(jzchan);
 			} else if (dcs & JZ_DMA_DCS_TT) {
-				vchan_cookie_complete(&jzchan->desc->vdesc);
-				jzchan->desc = NULL;
+				if (jzchan->curr_hwdesc + 1 == desc->count) {
+					vchan_cookie_complete(&desc->vdesc);
+					jzchan->desc = NULL;
+				}
 
 				jz4780_dma_begin(jzchan);
 			} else {
@@ -994,6 +1000,7 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 static const struct jz4780_dma_soc_data jz4740_dma_soc_data = {
 	.nb_channels = 6,
 	.transfer_ord_max = 5,
+	.flags = JZ_SOC_DATA_BREAK_LINKS,
 };
 
 static const struct jz4780_dma_soc_data jz4725b_dma_soc_data = {
-- 
2.21.0.593.g511ec345e18

