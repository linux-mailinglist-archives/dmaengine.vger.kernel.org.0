Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159056A1E71
	for <lists+dmaengine@lfdr.de>; Fri, 24 Feb 2023 16:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjBXPWi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Feb 2023 10:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBXPWh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Feb 2023 10:22:37 -0500
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEF66A9E6;
        Fri, 24 Feb 2023 07:22:30 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1677252145; bh=8I53wAm0Lhx1Y1CRpTsp/SrqowkIL26beK+I0BreeKg=;
        h=From:To:Cc:Subject:Date;
        b=KzjvnnBtPMLzkpne5ixV1R5vuvAuRq/riSQMn9JedY18pihL2mEdyY4AVhiv2dpX4
         2jOIvqTVWjw8jMAAe4igDy0ErG5dXi8IdYScZWKLs1WURJu6IVVQGM4gAmerF6KtlL
         uzDbQyJTxoBgbh/cekLbEdEGeCEnorFmhJLgHseg=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dmaengine: apple-admac: Handle 'global' interrupt flags
Date:   Fri, 24 Feb 2023 16:22:20 +0100
Message-Id: <20230224152222.26732-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In addition to TX channel and RX channel interrupt flags there's
another class of 'global' interrupt flags with unknown semantics. Those
weren't being handled up to now, and they are the suspected cause of
stuck IRQ states that have been sporadically occurring. Check the global
flags and clear them if raised.

Fixes: b127315d9a78 ("dmaengine: apple-admac: Add Apple ADMAC driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 drivers/dma/apple-admac.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index 90f28bda29c8..00cbfafe0ed9 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -75,6 +75,7 @@
 
 #define REG_TX_INTSTATE(idx)		(0x0030 + (idx) * 4)
 #define REG_RX_INTSTATE(idx)		(0x0040 + (idx) * 4)
+#define REG_GLOBAL_INTSTATE(idx)	(0x0050 + (idx) * 4)
 #define REG_CHAN_INTSTATUS(ch, idx)	(0x8010 + (ch) * 0x200 + (idx) * 4)
 #define REG_CHAN_INTMASK(ch, idx)	(0x8020 + (ch) * 0x200 + (idx) * 4)
 
@@ -672,13 +673,14 @@ static void admac_handle_chan_int(struct admac_data *ad, int no)
 static irqreturn_t admac_interrupt(int irq, void *devid)
 {
 	struct admac_data *ad = devid;
-	u32 rx_intstate, tx_intstate;
+	u32 rx_intstate, tx_intstate, global_intstate;
 	int i;
 
 	rx_intstate = readl_relaxed(ad->base + REG_RX_INTSTATE(ad->irq_index));
 	tx_intstate = readl_relaxed(ad->base + REG_TX_INTSTATE(ad->irq_index));
+	global_intstate = readl_relaxed(ad->base + REG_GLOBAL_INTSTATE(ad->irq_index));
 
-	if (!tx_intstate && !rx_intstate)
+	if (!tx_intstate && !rx_intstate && !global_intstate)
 		return IRQ_NONE;
 
 	for (i = 0; i < ad->nchannels; i += 2) {
@@ -693,6 +695,12 @@ static irqreturn_t admac_interrupt(int irq, void *devid)
 		rx_intstate >>= 1;
 	}
 
+	if (global_intstate) {
+		dev_warn(ad->dev, "clearing unknown global interrupt flag: %x\n",
+			 global_intstate);
+		writel_relaxed(~(u32) 0, ad->base + REG_GLOBAL_INTSTATE(ad->irq_index));
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.33.0

