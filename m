Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2766BA4A8
	for <lists+dmaengine@lfdr.de>; Wed, 15 Mar 2023 02:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCOB34 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Mar 2023 21:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCOB3z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Mar 2023 21:29:55 -0400
Received: from out-17.mta0.migadu.com (out-17.mta0.migadu.com [IPv6:2001:41d0:1004:224b::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A80E244B5
        for <dmaengine@vger.kernel.org>; Tue, 14 Mar 2023 18:29:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678843761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuhZwNjSOPm/eDk+Fqlhqet/RDQ4z4+j3b/7ckisd5c=;
        b=xFC47dqql51lUOH4YGBLc5sJRb7ipvsq/2DBVELS8+7EwnKHoV7AXuihN2kHRzZyzn1/pi
        e5/5rxbjZP7wzx+B3LbJI1U5nVXy5e/Knjww1PrYN9z0eCG0vG5MWbEwLTRdvJ91yqGkq/
        eLrBl8IowCzfytJHDvCcMklUMz2cVCQ=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     fancer.lancer@gmail.com
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 5/5] dmaengine: dw-edma: Optimization in dw_edma_v0_core_handle_int
Date:   Wed, 15 Mar 2023 09:28:36 +0800
Message-Id: <20230315012840.6986-6-cai.huoqing@linux.dev>
In-Reply-To: <20230315012840.6986-1-cai.huoqing@linux.dev>
References: <20230315012840.6986-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Optimization in dw_edma_v0_core_handle_int, remove some
unnecessary wrapper function.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
v6 link:
  https://lore.kernel.org/lkml/20230310032342.17395-6-cai.huoqing@linux.dev/


 drivers/dma/dw-edma/dw-edma-v0-core.c | 38 +++++----------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 16c48197d3c6..c3eab82cc1c7 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -258,34 +258,6 @@ static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 		return DMA_ERROR;
 }
 
-static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
-{
-	struct dw_edma *dw = chan->dw;
-
-	SET_RW_32(dw, chan->dir, int_clear,
-		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
-}
-
-static void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
-{
-	struct dw_edma *dw = chan->dw;
-
-	SET_RW_32(dw, chan->dir, int_clear,
-		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
-}
-
-static u32 dw_edma_v0_core_status_done_int(struct dw_edma *dw, enum dw_edma_dir dir)
-{
-	return FIELD_GET(EDMA_V0_DONE_INT_MASK,
-			 GET_RW_32(dw, dir, int_status));
-}
-
-static u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
-{
-	return FIELD_GET(EDMA_V0_ABORT_INT_MASK,
-			 GET_RW_32(dw, dir, int_status));
-}
-
 static irqreturn_t
 dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 			   dw_edma_handler_t done, dw_edma_handler_t abort)
@@ -307,23 +279,25 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 		mask = dw_irq->rd_mask;
 	}
 
-	val = dw_edma_v0_core_status_done_int(dw, dir);
+	val = FIELD_GET(EDMA_V0_DONE_INT_MASK, GET_RW_32(dw, dir, int_status));
 	val &= mask;
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_done_int(chan);
+		SET_RW_32(dw, chan->dir, int_clear,
+			  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
 		done(chan);
 
 		ret = IRQ_HANDLED;
 	}
 
-	val = dw_edma_v0_core_status_abort_int(dw, dir);
+	val = FIELD_GET(EDMA_V0_ABORT_INT_MASK, GET_RW_32(dw, dir, int_status));
 	val &= mask;
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_abort_int(chan);
+		SET_RW_32(dw, chan->dir, int_clear,
+			  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
 		abort(chan);
 
 		ret = IRQ_HANDLED;
-- 
2.34.1

