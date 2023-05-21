Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFC370ADD7
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjEULsR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjEUK1w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580BA10E7;
        Sun, 21 May 2023 03:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2E2560E05;
        Sun, 21 May 2023 10:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B94EC4339C;
        Sun, 21 May 2023 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664613;
        bh=nugoBLj1hecEiOwev69EKFxOoV/ysyY1qdC6Ej2+N0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENzZSteHBMg9fdrWHXxObejJbr5ltEU9QUiC30q3DfDy9y+OP0jxZTEmuLAdibzdG
         YLQ87KQPJ17QYMtDaPvTnE0fFsgHHeN8UycYTKvPq7DXmOqjtlERXuN09OKsGnVOjb
         qZKlfUbdMDB3GE+D0SeB2wJ/w+n8YbS5hVsXbdZFvupfpBcqseyN7TzKdlbQ9Lh/+s
         z9197/37ryoJMGWMxFVVm6WmvF0aKIw0z2e1tzRktZ1SLTCBMOAmd23rXdABiKECWt
         mGadMpLY4wOWXwO2Q8W8TLu+t8iBFPSfhjj71delITJOL0XjTfr0to6GHrie0t6EPJ
         oJL5rAQKIH5ig==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/11] dmaengine: dw-axi-dmac: move ch irq handling into common routine
Date:   Sun, 21 May 2023 18:12:11 +0800
Message-Id: <20230521101216.4084-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230521101216.4084-1-jszhang@kernel.org>
References: <20230521101216.4084-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In next patch, we will add per-channel irq support, we will use the
common routine in per-channel irq handler.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 30 ++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 64b4ee2d618b..24a93b0c1489 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1108,13 +1108,30 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
+static void dw_axi_dma_handle_ch(struct axi_dma_chan *chan)
+{
+	u32 status;
+
+	/* Poll, clear and process this channel interrupt status */
+	status = axi_chan_irq_read(chan);
+	axi_chan_irq_clear(chan, status);
+
+	dev_vdbg(chan->chip->dev, "%s IRQ status: 0x%08x\n", axi_chan_name(chan), status);
+
+	if (status & DWAXIDMAC_IRQ_ALL_ERR)
+		axi_chan_handle_err(chan, status);
+	else if (status & DWAXIDMAC_IRQ_DMA_TRF)
+		axi_chan_block_xfer_complete(chan);
+
+}
+
 static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 {
 	struct axi_dma_chip *chip = dev_id;
 	struct dw_axi_dma *dw = chip->dw;
 	struct axi_dma_chan *chan;
 
-	u32 status, i;
+	u32 i;
 
 	/* Disable DMAC interrupts. We'll enable them after processing channels */
 	axi_dma_irq_disable(chip);
@@ -1122,16 +1139,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
 	/* Poll, clear and process every channel interrupt status */
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		chan = &dw->chan[i];
-		status = axi_chan_irq_read(chan);
-		axi_chan_irq_clear(chan, status);
-
-		dev_vdbg(chip->dev, "%s %u IRQ status: 0x%08x\n",
-			axi_chan_name(chan), i, status);
-
-		if (status & DWAXIDMAC_IRQ_ALL_ERR)
-			axi_chan_handle_err(chan, status);
-		else if (status & DWAXIDMAC_IRQ_DMA_TRF)
-			axi_chan_block_xfer_complete(chan);
+		dw_axi_dma_handle_ch(chan);
 	}
 
 	/* Re-enable interrupts */
-- 
2.40.0

