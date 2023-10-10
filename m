Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6255B7BF846
	for <lists+dmaengine@lfdr.de>; Tue, 10 Oct 2023 12:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjJJKO7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Oct 2023 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjJJKO5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Oct 2023 06:14:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFCB97;
        Tue, 10 Oct 2023 03:14:54 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c27d653856so78013191fa.0;
        Tue, 10 Oct 2023 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696932893; x=1697537693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uevVZ5l49O79IDGgv2qzPiOyxsWvTfFBE56J4eeoZk=;
        b=hA1iDf9sro/q53QWqn5VyD3qwu+6NO1J/ZTfz+LpxJNuwjBrPpfqQ59bJcAW+HQBJC
         xFDPDR4PNs/7xupoIG13oIXE+pbAZMAVmuHGJEZApQyuwQCnSpw8ymICqXjowiktXgJv
         aw7ivBLZSXbi3YbqXcMc00Wn2pn/T2B3kRz7fbE3pP6i9QQE7J4hAgAtMYfYgvapMwnJ
         LbLPrGLPID/WW+jQg667PQpbCs6mtp/DOrsR48Y1FJ2Vf1rd+yOR2Vl3qBjqB8AqZE7g
         irrSAxYZlfDRiHwSPUYObERhMmypQfVbx0AJuj0KwNmSYXo+heelyRZddfTFyI6x38MF
         fGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696932893; x=1697537693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uevVZ5l49O79IDGgv2qzPiOyxsWvTfFBE56J4eeoZk=;
        b=RT5CNxFTFxj5uk6TcEL0eNlvs2wmWnIuaGuNPfX8thMqvkTb6eX7bVL9L7GKdxkpmX
         iv404CxR1phkyKQDsKTS8JiKoW1ZeyLFBBQ4x0qVUPgmEajQYpUXVx4LSEgxhSe/0SIU
         X0BB+n5XJB92cYshh0vpxEu8WK+x5Rl405wsajD8L4dKqGIHYHVv6NOlJWlPGUcQKx6X
         zxz8GNMlqcJjeKcIvwtpQptnkoY9oHz5yG6PKfXYkGZljJV6M/iAZCXupBhdNyr+wzOW
         gq0OjSZeS1ATzxi2CH84k6r8v+d7iJ5wdS7xD/8lVVSD4ydI02W21h9+AR7QKe0ZZZ71
         4I5w==
X-Gm-Message-State: AOJu0YyiAIjBALkKUFgJP6D++LKUUEKD6PXjpNkP8d+sPGyAt65927hv
        jkHJuHCZDWO4qjANroMeX5WDYPGfYAUlqHv6
X-Google-Smtp-Source: AGHT+IGB9wiyCZOSwRuBPq5oqH4OQsHTMF8mPErWaOJ5w3L00pL0BFWosieAxXXzZXTmjo/nTGYRUA==
X-Received: by 2002:a05:6512:3b88:b0:504:b84f:7b19 with SMTP id g8-20020a0565123b8800b00504b84f7b19mr11632877lfv.20.1696932892561;
        Tue, 10 Oct 2023 03:14:52 -0700 (PDT)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id w2-20020ac25d42000000b004fce9e8c390sm1754454lfd.63.2023.10.10.03.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 03:14:52 -0700 (PDT)
From:   Sergey Khimich <serghox@gmail.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 1/1] dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16
Date:   Tue, 10 Oct 2023 13:14:50 +0300
Message-Id: <20231010101450.2949126-2-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231010101450.2949126-1-serghox@gmail.com>
References: <20231010101450.2949126-1-serghox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sergey Khimich <serghox@gmail.com>

Added support for DMA controller with more than 16 channels.

Signed-off-by: Sergey Khimich <serghox@gmail.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 156 +++++++++++++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   6 +-
 2 files changed, 120 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index dd02f84e404d..f2587159bf5a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -62,6 +62,17 @@ static inline u32 axi_dma_ioread32(struct axi_dma_chip *chip, u32 reg)
 	return ioread32(chip->regs + reg);
 }
 
+static inline void
+axi_dma_iowrite64(struct axi_dma_chip *chip, u32 reg, u64 val)
+{
+	iowrite64(val, chip->regs + reg);
+}
+
+static inline u64 axi_dma_ioread64(struct axi_dma_chip *chip, u32 reg)
+{
+	return ioread64(chip->regs + reg);
+}
+
 static inline void
 axi_chan_iowrite32(struct axi_dma_chan *chan, u32 reg, u32 val)
 {
@@ -182,38 +193,73 @@ static inline u32 axi_chan_irq_read(struct axi_dma_chan *chan)
 
 static inline void axi_chan_disable(struct axi_dma_chan *chan)
 {
-	u32 val;
-
-	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-	val &= ~(BIT(chan->id) << DMAC_CHAN_EN_SHIFT);
-	if (chan->chip->dw->hdata->reg_map_8_channels)
-		val |=   BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
-	else
-		val |=   BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
-	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+	u64 val;
+
+	if (chan->chip->dw->hdata->nr_channels >= DMAC_CHAN_16) {
+		val = axi_dma_ioread64(chan->chip, DMAC_CHEN);
+		if (chan->id >= DMAC_CHAN_16) {
+			val &= ~((u64)(BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_EN_SHIFT + DMAC_CHAN_BLOCK_SHIFT));
+			val |=   (u64)(BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_EN2_WE_SHIFT + DMAC_CHAN_BLOCK_SHIFT);
+		} else {
+			val &= ~(BIT(chan->id) << DMAC_CHAN_EN_SHIFT);
+			val |=   BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
+		}
+		axi_dma_iowrite64(chan->chip, DMAC_CHEN, val);
+	} else {
+		val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+		val &= ~(BIT(chan->id) << DMAC_CHAN_EN_SHIFT);
+		if (chan->chip->dw->hdata->reg_map_8_channels)
+			val |=   BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
+		else
+			val |=   BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
+		axi_dma_iowrite32(chan->chip, DMAC_CHEN, (u32)val);
+	}
 }
 
 static inline void axi_chan_enable(struct axi_dma_chan *chan)
 {
-	u32 val;
-
-	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-	if (chan->chip->dw->hdata->reg_map_8_channels)
-		val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
-			BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
-	else
-		val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
+	u64 val;
+
+	if (chan->chip->dw->hdata->nr_channels >= DMAC_CHAN_16) {
+		val = axi_dma_ioread64(chan->chip, DMAC_CHEN);
+		if (chan->id >= DMAC_CHAN_16) {
+			val |= (u64)(BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_EN_SHIFT + DMAC_CHAN_BLOCK_SHIFT) |
+				(u64)(BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_EN2_WE_SHIFT + DMAC_CHAN_BLOCK_SHIFT);
+		} else {
+			val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
 			BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
-	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+		}
+		axi_dma_iowrite64(chan->chip, DMAC_CHEN, val);
+	} else {
+		val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+		if (chan->chip->dw->hdata->reg_map_8_channels) {
+			val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
+			BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
+		} else {
+			val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
+				BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
+		}
+		axi_dma_iowrite32(chan->chip, DMAC_CHEN, (u32)val);
+	}
 }
 
 static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
 {
-	u32 val;
+	u64 val;
 
-	val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+	if (chan->chip->dw->hdata->nr_channels >= DMAC_CHAN_16)
+		val = axi_dma_ioread64(chan->chip, DMAC_CHEN);
+	else
+		val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
 
-	return !!(val & (BIT(chan->id) << DMAC_CHAN_EN_SHIFT));
+	if (chan->id >= DMAC_CHAN_16)
+		return !!(val & ((u64)(BIT(chan->id) >> DMAC_CHAN_16) << DMAC_CHAN_BLOCK_SHIFT));
+	else
+		return !!(val & (BIT(chan->id) << DMAC_CHAN_EN_SHIFT));
 }
 
 static void axi_dma_hw_init(struct axi_dma_chip *chip)
@@ -1175,20 +1221,34 @@ static int dma_chan_pause(struct dma_chan *dchan)
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
 	unsigned long flags;
 	unsigned int timeout = 20; /* timeout iterations */
-	u32 val;
+	u64 val;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
-	if (chan->chip->dw->hdata->reg_map_8_channels) {
-		val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-		val |= BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT |
-			BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
-		axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+	if (chan->chip->dw->hdata->nr_channels >= DMAC_CHAN_16) {
+		val = axi_dma_ioread64(chan->chip, DMAC_CHSUSPREG);
+		if (chan->id >= DMAC_CHAN_16) {
+			val |= (u64)(BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_SUSP2_SHIFT + DMAC_CHAN_BLOCK_SHIFT) |
+				(u64)(BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_SUSP2_WE_SHIFT + DMAC_CHAN_BLOCK_SHIFT);
+		} else {
+			val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
+			       BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
+			}
+			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
-		val = axi_dma_ioread32(chan->chip, DMAC_CHSUSPREG);
-		val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
+		if (chan->chip->dw->hdata->reg_map_8_channels) {
+			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+			val |= BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT |
+			BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
+			axi_dma_iowrite32(chan->chip, DMAC_CHEN, (u32)val);
+		} else {
+			val = axi_dma_ioread32(chan->chip, DMAC_CHSUSPREG);
+			val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
 			BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
-		axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, val);
+			axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, (u32)val);
+		}
 	}
 
 	do  {
@@ -1210,18 +1270,32 @@ static int dma_chan_pause(struct dma_chan *dchan)
 /* Called in chan locked context */
 static inline void axi_chan_resume(struct axi_dma_chan *chan)
 {
-	u32 val;
-
-	if (chan->chip->dw->hdata->reg_map_8_channels) {
-		val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
-		val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT);
-		val |=  (BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT);
-		axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
+	u64 val;
+
+	if (chan->chip->dw->hdata->nr_channels >= DMAC_CHAN_16) {
+		val = axi_dma_ioread64(chan->chip, DMAC_CHSUSPREG);
+		if (chan->id >= DMAC_CHAN_16) {
+			val &= ~((u64)(BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_SUSP2_SHIFT + DMAC_CHAN_BLOCK_SHIFT));
+			val |=  ((u64)(BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_SUSP2_WE_SHIFT + DMAC_CHAN_BLOCK_SHIFT));
+		} else {
+			val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT);
+			val |=  (BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT);
+		}
+			axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
-		val = axi_dma_ioread32(chan->chip, DMAC_CHSUSPREG);
-		val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT);
-		val |=  (BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT);
-		axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, val);
+		if (chan->chip->dw->hdata->reg_map_8_channels) {
+			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+			val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT);
+			val |=  (BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT);
+			axi_dma_iowrite32(chan->chip, DMAC_CHEN, (u32)val);
+		} else {
+			val = axi_dma_ioread32(chan->chip, DMAC_CHSUSPREG);
+			val &= ~(BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT);
+			val |=  (BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT);
+			axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, (u32)val);
+		}
 	}
 
 	chan->is_paused = false;
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index eb267cb24f67..454904d99654 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -18,7 +18,7 @@
 
 #include "../virt-dma.h"
 
-#define DMAC_MAX_CHANNELS	16
+#define DMAC_MAX_CHANNELS	32
 #define DMAC_MAX_MASTERS	2
 #define DMAC_MAX_BLK_SIZE	0x200000
 
@@ -222,6 +222,10 @@ static inline struct axi_dma_chan *dchan_to_axi_dma_chan(struct dma_chan *dchan)
 /* DMAC_CHEN2 */
 #define DMAC_CHAN_EN2_WE_SHIFT		16
 
+/* DMAC CHAN BLOCKS */
+#define DMAC_CHAN_BLOCK_SHIFT		32
+#define DMAC_CHAN_16			16
+
 /* DMAC_CHSUSP */
 #define DMAC_CHAN_SUSP2_SHIFT		0
 #define DMAC_CHAN_SUSP2_WE_SHIFT	16
-- 
2.30.2

