Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EA86E30ED
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjDOKt2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjDOKtI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:49:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D421A5;
        Sat, 15 Apr 2023 03:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83881617DC;
        Sat, 15 Apr 2023 10:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA98C4339B;
        Sat, 15 Apr 2023 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681555624;
        bh=X0v6md0ShrzygWDpZi0pa8rfM30TOG9ETPBgqjPAHbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T6CMvl6ic67rJ9fk5P7QINVFIWza30v0pJhTUJ776WxC4ymOf25G00vG9xBTW1n5I
         G0tisLndvMwCOVMi/6bzCJW633NGY3pKfl4hhmkQqg4ReNYyqbvggVbtYuHqEf3f9d
         g8qilRRTGR5nJ3dglEguHUEbUHXP/WFd8JeyPQBvAol0FkQnOJSUnAWG4fVQtjlYm5
         vQ/0XhI1VDR7i3eP8wUpTAjQXt5GPW276iKky9X1hn0j4sjCw5JgW2dtZ53Jr6cqXb
         uEY5rEDs20DVK/2LGQWckSxxXp8s0a20C/nP1UrfpGV1wIwPpMbGNfUrsRvcGpEILS
         VBO/lFMFPxeUg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] dmaengine: dw-axi-dmac: move ch irq handling into common routine
Date:   Sat, 15 Apr 2023 18:35:56 +0800
Message-Id: <20230415103601.2979-7-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415103601.2979-1-jszhang@kernel.org>
References: <20230415103601.2979-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 6087fb7d567a..796fd0136781 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1101,13 +1101,30 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
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
@@ -1115,16 +1132,7 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)
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
2.39.2

