Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662367BA504
	for <lists+dmaengine@lfdr.de>; Thu,  5 Oct 2023 18:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbjJEQNc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Oct 2023 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbjJEQMT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Oct 2023 12:12:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B4F24EAA;
        Thu,  5 Oct 2023 04:36:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50573e85ee0so1077011e87.3;
        Thu, 05 Oct 2023 04:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696505800; x=1697110600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBUY5sKoG8544w0xkR7tsGcBR4jBl32mFG7ayB2c9ik=;
        b=dWYWNFG09+EQIyCVhcvEX5KLLOduNOdHONjazySQ2aL+R/OZ+3jk5zYXsrDB88Mzaq
         Me12/sBNOUU5tnTHasE8sjWl8iEx38PHgtj2HyVxuBBPXjRmO4LmIbG2R4Z1VLQ3oVtk
         azOeScxd0FLxbCalvLOLWhE3nKtAMCcfss00XIER49szgKA9p8+Rhv/zfXaoEcbm5aCN
         Xqp4jNwEaGMPqRIEZWU5nwg9ASJn0aSFfCMlw123UMJnAVqQpa0nz8/xhgPyv6oUcSCd
         /+sZByoPcdy/zgoHT4knTu/P/b80E1pe56MXQMsAyk/jvQvz/K7emmv6a0iTJ4CuIrUs
         156A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696505800; x=1697110600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBUY5sKoG8544w0xkR7tsGcBR4jBl32mFG7ayB2c9ik=;
        b=aZ/1NeeWzeZEfBVz5RJv6VFvMKsY2314MqUhAYYhAUmEEsHuCkizhkTZV4oGSqysCm
         2tJp2JijqxzcwO3DQOsQS5IuzZfUI5si8cooyZLA2gcB0SbJgTIAUtPkWLoM59cM7ImV
         Fi1OrCAsz9bfcoGL7qyuC391B5r/hSX1bwZRB3O1GZB4fI0DlwpV4ZLFznrcDpFaKY9K
         9uYqihwMcYMM6us4O/HrwlARuXhR/EhZFZaHryYroGtJOlDCPXpF6rjYDt+e//Tdd+HR
         9iER4lFXjI5FWA4Hpa7NPqu6wQVqjZmlZJfo5PCtyewaNRIoz9A0LT4Q1IxHIkhex/PI
         aWIQ==
X-Gm-Message-State: AOJu0Ywr29dUlUyC1CGpJEPCkKNSXPE2j0gaqmVdHsliBSlIC3ixHkxY
        EuHbTX8zv52x+dwO3MSlb/PR1QPVeohDUQ3/
X-Google-Smtp-Source: AGHT+IH0kMz3sZo2ZfDCA48VQyxur5aWbWuEwihKendW4HaaYWNDoGqnkckdyklkcQgK2ZBFX2k6ZA==
X-Received: by 2002:a05:6512:282:b0:502:cc8d:f20a with SMTP id j2-20020a056512028200b00502cc8df20amr4904793lfp.27.1696505800023;
        Thu, 05 Oct 2023 04:36:40 -0700 (PDT)
Received: from skhimich.dev.yadro.com ([185.15.172.210])
        by smtp.gmail.com with ESMTPSA id n18-20020a195512000000b004fe1bc7e4acsm260720lfe.131.2023.10.05.04.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 04:36:39 -0700 (PDT)
From:   Sergey Khimich <serghox@gmail.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16
Date:   Thu,  5 Oct 2023 14:36:38 +0300
Message-Id: <20231005113638.2039726-1-serghox@gmail.com>
X-Mailer: git-send-email 2.30.2
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
index dd02f84e404d..984e953046c4 100644
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
+			val &= ~((BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_EN_SHIFT + DMAC_CHAN_BLOCK_SHIFT));
+			val |=   (BIT(chan->id) >> DMAC_CHAN_16)
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
+			val |= (BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_EN_SHIFT + DMAC_CHAN_BLOCK_SHIFT) |
+				(BIT(chan->id) >> DMAC_CHAN_16)
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
+		return !!(val & ((BIT(chan->id) >> DMAC_CHAN_16) << DMAC_CHAN_BLOCK_SHIFT));
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
+			val |= (BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_SUSP2_SHIFT + DMAC_CHAN_BLOCK_SHIFT) |
+				(BIT(chan->id) >> DMAC_CHAN_16)
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
+			val &= ~((BIT(chan->id) >> DMAC_CHAN_16)
+				<< (DMAC_CHAN_SUSP2_SHIFT + DMAC_CHAN_BLOCK_SHIFT));
+			val |=  ((BIT(chan->id) >> DMAC_CHAN_16)
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

