Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462B869C646
	for <lists+dmaengine@lfdr.de>; Mon, 20 Feb 2023 09:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBTIFg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Feb 2023 03:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjBTIFf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Feb 2023 03:05:35 -0500
X-Greylist: delayed 479 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Feb 2023 00:05:31 PST
Received: from forward105o.mail.yandex.net (forward105o.mail.yandex.net [37.140.190.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B18910A80
        for <dmaengine@vger.kernel.org>; Mon, 20 Feb 2023 00:05:31 -0800 (PST)
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 591724C3376;
        Mon, 20 Feb 2023 10:57:28 +0300 (MSK)
Received: from vla3-79cc00068f6d.qloud-c.yandex.net (vla3-79cc00068f6d.qloud-c.yandex.net [IPv6:2a02:6b8:c15:2582:0:640:79cc:6])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id 5458CBF00007;
        Mon, 20 Feb 2023 10:57:28 +0300 (MSK)
Received: by vla3-79cc00068f6d.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id Ivjq2NRXXuQ1-KS7gvaSd;
        Mon, 20 Feb 2023 10:57:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1676879847;
        bh=iFnKL93KxL9SdK/eflxH09jRVqzX06vX7MEqcbf13VM=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=mWLaheKZ/hl2GSvEQ/fD3aIxUFh8Nt+OmxqPPOkFaWS0C50/mE6iy150OzDlp7Pzl
         Y4kO6UNQ8CPJSvc4r/3IJickOZcvbdOtCeQbmWD98WSMTNLyVmJly99h285K/ToLjl
         ovDueZCIgdQryzDnKyAzp4Ztqc5WQzegW7wRtA4A=
Authentication-Results: vla3-79cc00068f6d.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Sergey Khimich <sergo-hfz@yandex.ru>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux@yadro.com,
        Sergey Khimich <s.khimich@yadro.com>
Subject: [PATCH] dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 16
Date:   Mon, 20 Feb 2023 10:57:18 +0300
Message-Id: <20230220075718.1818122-1-sergo-hfz@yandex.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Sergey Khimich <s.khimich@yadro.com>

Added support for DMA controllers with more than 16 channels.

Signed-off-by: Sergey Khimich <s.khimich@yadro.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 159 +++++++++++++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   6 +-
 2 files changed, 121 insertions(+), 44 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a183d93bd7e2..38a3c2d8dc4d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -57,6 +57,17 @@ static inline u32 axi_dma_ioread32(struct axi_dma_chip *chip, u32 reg)
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
@@ -176,38 +187,72 @@ static inline u32 axi_chan_irq_read(struct axi_dma_chan *chan)
 
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
-			BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
-	axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
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
+				BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
+		}
+		axi_dma_iowrite64(chan->chip, DMAC_CHEN, val);
+	} else {
+		val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+		if (chan->chip->dw->hdata->reg_map_8_channels)
+			val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
+				BIT(chan->id) << DMAC_CHAN_EN_WE_SHIFT;
+		else
+			val |= BIT(chan->id) << DMAC_CHAN_EN_SHIFT |
+				BIT(chan->id) << DMAC_CHAN_EN2_WE_SHIFT;
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
@@ -1165,20 +1210,34 @@ static int dma_chan_pause(struct dma_chan *dchan)
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
+				BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
+		}
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
 	} else {
-		val = axi_dma_ioread32(chan->chip, DMAC_CHSUSPREG);
-		val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
-			BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
-		axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, val);
+		if (chan->chip->dw->hdata->reg_map_8_channels) {
+			val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
+			val |= BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT |
+				BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
+			axi_dma_iowrite32(chan->chip, DMAC_CHEN, (u32)val);
+		} else {
+			val = axi_dma_ioread32(chan->chip, DMAC_CHSUSPREG);
+			val |= BIT(chan->id) << DMAC_CHAN_SUSP2_SHIFT |
+				BIT(chan->id) << DMAC_CHAN_SUSP2_WE_SHIFT;
+			axi_dma_iowrite32(chan->chip, DMAC_CHSUSPREG, (u32)val);
+		}
 	}
 
 	do  {
@@ -1200,18 +1259,32 @@ static int dma_chan_pause(struct dma_chan *dchan)
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
+		axi_dma_iowrite64(chan->chip, DMAC_CHSUSPREG, val);
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
index 40c13f689b67..c98e3a28647b 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -18,7 +18,7 @@
 
 #include "../virt-dma.h"
 
-#define DMAC_MAX_CHANNELS	16
+#define DMAC_MAX_CHANNELS	32
 #define DMAC_MAX_MASTERS	2
 #define DMAC_MAX_BLK_SIZE	0x400000
 
@@ -221,6 +221,10 @@ static inline struct axi_dma_chan *dchan_to_axi_dma_chan(struct dma_chan *dchan)
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

