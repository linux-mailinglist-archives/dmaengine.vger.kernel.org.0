Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED18570ADCE
	for <lists+dmaengine@lfdr.de>; Sun, 21 May 2023 13:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjEULsM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 21 May 2023 07:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjEUK1w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 21 May 2023 06:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F9D10F1;
        Sun, 21 May 2023 03:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B57861237;
        Sun, 21 May 2023 10:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EC9C4339B;
        Sun, 21 May 2023 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684664619;
        bh=CgvF8Omo2JeTGnqmRi2Go52uNuV9rdRbFiAeV3NJTAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHw5+gVjEIOb+e4UbCc7hGKVU4uLX2hcCGsPYe4SmaCXZUVwwW2ZRC+CVIVxhTK5E
         hZTQLv54htOvEfBkLSkdRlMA762KQhvnN/etb/FE9/qyPXn3/h7HLgDBvZ2KcmN+BB
         k1h2sgi+1zLsTy0FuiKu/6M2EgQCWZiIy0zfqwfhLmQs1MM92/Vuur23CRe4aDU/Um
         ZLLAD14zUEE4zWrmVs16IS9D5E16I9nbNCO+DfxNLyNnRBO/mqE+yyVZOx6wINoCVh
         7HIuyU5gbJGKhOR6cB2sHgC+eBW4zb8U/F4eLb7ApuIryThJNMe8ws+DAsO8MQIkZb
         1lWhPMUffXPYw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] dmaengine: dw-axi-dmac: support polled mode
Date:   Sun, 21 May 2023 18:12:16 +0800
Message-Id: <20230521101216.4084-12-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230521101216.4084-1-jszhang@kernel.org>
References: <20230521101216.4084-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 091c15c2ec31..37ab9a03d94b 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -390,7 +390,10 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	write_chan_llp(chan, first->hw_desc[0].llp | lms);
 
 	irq_mask = DWAXIDMAC_IRQ_DMA_TRF | DWAXIDMAC_IRQ_ALL_ERR;
-	axi_chan_irq_sig_set(chan, irq_mask);
+	if (chan->polled)
+		axi_chan_irq_sig_set(chan, DWAXIDMAC_IRQ_NONE);
+	else
+		axi_chan_irq_sig_set(chan, irq_mask);
 
 	/* Generate 'suspend' status but don't generate interrupt */
 	irq_mask |= DWAXIDMAC_IRQ_SUSPENDED;
@@ -721,6 +724,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 	if (unlikely(!desc))
 		goto err_desc_get;
 
+	chan->polled = !(flags & DMA_PREP_INTERRUPT);
 	chan->direction = direction;
 	desc->chan = chan;
 	chan->cyclic = true;
@@ -803,6 +807,7 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 
 	desc->chan = chan;
 	desc->length = 0;
+	chan->polled = !(flags & DMA_PREP_INTERRUPT);
 	chan->direction = direction;
 
 	for_each_sg(sgl, sg, sg_len, i) {
@@ -866,6 +871,7 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 	if (unlikely(!desc))
 		goto err_desc_get;
 
+	chan->polled = !(flags & DMA_PREP_INTERRUPT);
 	desc->chan = chan;
 	num = 0;
 	desc->length = 0;
@@ -1146,6 +1152,9 @@ dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	u32 length;
 	u32 len;
 
+	if (chan->polled)
+		dw_axi_dma_handle_ch(chan);
+
 	status = dma_cookie_status(dchan, cookie, txstate);
 	if (status == DMA_COMPLETE || !txstate)
 		return status;
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 1f9772e9be30..33ae4280dacc 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -55,6 +55,7 @@ struct axi_dma_chan {
 	bool				cyclic;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
+	bool				polled;
 };
 
 struct dw_axi_dma {
-- 
2.40.0

