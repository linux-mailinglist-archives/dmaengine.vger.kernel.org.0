Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61416B7F2F
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCMRRZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjCMRRM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:17:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E2C80902;
        Mon, 13 Mar 2023 10:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 417C3B811B2;
        Mon, 13 Mar 2023 17:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C2CC4339E;
        Mon, 13 Mar 2023 17:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678727749;
        bh=do8+kPrEABA/+sArd48GuvtE5icgNiKsJ/7FNgFAelM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/qc6WSx2eaxfWUOaCR+Jt4U8paKMjj7KnDAWCX+J3H2/KXdEoE/A1nkimEhlbjId
         Y209A1IzajyXtQfyP7cyCqN9F2qVAT6MTQVxk0cpCzRZYiLgRB0Ee1JeM29PeOievu
         vJHJWiMJTTSYjMJN799lYCJ47zl+b3YXI+ZhbcAntWpxIDHvUgOQn/bVWv0cGauw55
         7T8uruloIifyaQnZb+FNgLYkHX+pkDSOqrXpuWmj6P7yHRglLFseQOd1MMQfcDCgpY
         LOyCZ5qowffCRz1O5QVnL7JcyO0U2rXTxEH9LLMEs3ivku9ahB4G+knIWDtqNed30M
         KAgELShJAfwYA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] dmaengine: dw-axi-dmac: support polled mode
Date:   Tue, 14 Mar 2023 01:04:50 +0800
Message-Id: <20230313170450.897-12-jszhang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313170450.897-1-jszhang@kernel.org>
References: <20230313170450.897-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Run in polled mode if the DMA_PREP_INTERRUPT flag is not provided.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 11 ++++++++++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 1d00793a83bf..8daeb22d4560 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -383,7 +383,10 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	write_chan_llp(chan, first->hw_desc[0].llp | lms);
 
 	irq_mask = DWAXIDMAC_IRQ_DMA_TRF | DWAXIDMAC_IRQ_ALL_ERR;
-	axi_chan_irq_sig_set(chan, irq_mask);
+	if (chan->polled)
+		axi_chan_irq_sig_set(chan, DWAXIDMAC_IRQ_NONE);
+	else
+		axi_chan_irq_sig_set(chan, irq_mask);
 
 	/* Generate 'suspend' status but don't generate interrupt */
 	irq_mask |= DWAXIDMAC_IRQ_SUSPENDED;
@@ -714,6 +717,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 	if (unlikely(!desc))
 		goto err_desc_get;
 
+	chan->polled = !(flags & DMA_PREP_INTERRUPT);
 	chan->direction = direction;
 	desc->chan = chan;
 	chan->cyclic = true;
@@ -796,6 +800,7 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 
 	desc->chan = chan;
 	desc->length = 0;
+	chan->polled = !(flags & DMA_PREP_INTERRUPT);
 	chan->direction = direction;
 
 	for_each_sg(sgl, sg, sg_len, i) {
@@ -859,6 +864,7 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 	if (unlikely(!desc))
 		goto err_desc_get;
 
+	chan->polled = !(flags & DMA_PREP_INTERRUPT);
 	desc->chan = chan;
 	num = 0;
 	desc->length = 0;
@@ -1139,6 +1145,9 @@ dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	u32 length;
 	u32 len;
 
+	if (chan->polled)
+		dw_axi_dma_handle_ch(chan);
+
 	status = dma_cookie_status(dchan, cookie, txstate);
 	if (status == DMA_COMPLETE || !txstate)
 		return status;
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index f57961620d2d..e4fbc38446ec 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -54,6 +54,7 @@ struct axi_dma_chan {
 	bool				cyclic;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
+	bool				polled;
 };
 
 struct dw_axi_dma {
-- 
2.39.2

