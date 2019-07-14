Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC7E68157
	for <lists+dmaengine@lfdr.de>; Sun, 14 Jul 2019 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfGNVzP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 14 Jul 2019 17:55:15 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49126 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfGNVzP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 14 Jul 2019 17:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563141313; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=6UJuUeCfvEq3MBZzbHN53eBeuNrdTvzgI5WTeKesFo8=;
        b=Zc/ih5ZnKomKG0ja5TK4unkUcOeT411cvXIfL9xqmu1s/vVGn1kWrIv43sLCYzuLb9tUlr
        vp/x0+KpETJk5xA4jrDON6y+aeu0kiVSbhxBzPOp1huYDimgL0IuPkpaFrxZaGTd5rpNFt
        iNBdfawgw8B+Ch7TjTrgknyutXC1FXY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] dmaengine: dma-jz4780: Break descriptor chains on JZ4740
Date:   Sun, 14 Jul 2019 17:55:04 -0400
Message-Id: <20190714215504.10877-1-paul@crapouillou.net>
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

Notes:
    v2: Add fix for other (non JZ4740) SoCs.

 drivers/dma/dma-jz4780.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 6b8c4c458e8a..3fd91e665a52 100644
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
 
@@ -665,6 +668,8 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 				struct jz4780_dma_chan *jzchan)
 {
+	const unsigned int soc_flags = jzdma->soc_data->flags;
+	struct jz4780_dma_desc *desc = jzchan->desc;
 	uint32_t dcs;
 	bool ack = true;
 
@@ -692,8 +697,11 @@ static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 
 				jz4780_dma_begin(jzchan);
 			} else if (dcs & JZ_DMA_DCS_TT) {
-				vchan_cookie_complete(&jzchan->desc->vdesc);
-				jzchan->desc = NULL;
+				if (!(soc_flags & JZ_SOC_DATA_BREAK_LINKS) ||
+				    (jzchan->curr_hwdesc + 1 == desc->count)) {
+					vchan_cookie_complete(&desc->vdesc);
+					jzchan->desc = NULL;
+				}
 
 				jz4780_dma_begin(jzchan);
 			} else {
@@ -995,6 +1003,7 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 static const struct jz4780_dma_soc_data jz4740_dma_soc_data = {
 	.nb_channels = 6,
 	.transfer_ord_max = 5,
+	.flags = JZ_SOC_DATA_BREAK_LINKS,
 };
 
 static const struct jz4780_dma_soc_data jz4725b_dma_soc_data = {
-- 
2.21.0.593.g511ec345e18

