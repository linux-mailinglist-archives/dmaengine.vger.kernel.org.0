Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1756E121F80
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfLQAUB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:20:01 -0500
Received: from muru.com ([72.249.23.125]:48738 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfLQAUA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:20:00 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CB83681D8;
        Tue, 17 Dec 2019 00:20:38 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 09/14] dmaengine: ti: omap-dma: Configure global priority register directly
Date:   Mon, 16 Dec 2019 16:19:20 -0800
Message-Id: <20191217001925.44558-10-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We can move the global priority register configuration to the dmaengine
driver and configure it based on the of_device_id match data.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c  | 36 ------------------------------------
 drivers/dma/ti/omap-dma.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -557,38 +557,6 @@ void omap_free_dma(int lch)
 }
 EXPORT_SYMBOL(omap_free_dma);
 
-/**
- * @brief omap_dma_set_global_params : Set global priority settings for dma
- *
- * @param arb_rate
- * @param max_fifo_depth
- * @param tparams - Number of threads to reserve : DMA_THREAD_RESERVE_NORM
- * 						   DMA_THREAD_RESERVE_ONET
- * 						   DMA_THREAD_RESERVE_TWOT
- * 						   DMA_THREAD_RESERVE_THREET
- */
-static void
-omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
-{
-	u32 reg;
-
-	if (dma_omap1()) {
-		printk(KERN_ERR "FIXME: no %s on 15xx/16xx\n", __func__);
-		return;
-	}
-
-	if (max_fifo_depth == 0)
-		max_fifo_depth = 1;
-	if (arb_rate == 0)
-		arb_rate = 1;
-
-	reg = 0xff & max_fifo_depth;
-	reg |= (0x3 & tparams) << 12;
-	reg |= (arb_rate & 0xff) << 16;
-
-	p->dma_write(reg, GCR, 0);
-}
-
 /*
  * Clears any DMA state so the DMA engine is ready to restart with new buffers
  * through omap_start_dma(). Any buffers in flight are discarded.
@@ -969,10 +937,6 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (d->dev_caps & IS_RW_PRIORITY)
-		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
-				DMA_DEFAULT_FIFO_DEPTH, 0);
-
 	/* reserve dma channels 0 and 1 in high security devices on 34xx */
 	if (d->dev_caps & HS_CHANNELS_RESERVED) {
 		pr_info("Reserving DMA channels 0 and 1 for HS ROM code\n");
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -26,6 +26,7 @@
 
 struct omap_dma_config {
 	int lch_end;
+	unsigned int rw_priority:1;
 	unsigned int may_lose_context:1;
 };
 
@@ -1536,6 +1537,27 @@ static int omap_dma_context_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void omap_dma_init_gcr(struct omap_dmadev *od, int arb_rate,
+			      int max_fifo_depth, int tparams)
+{
+	u32 val;
+
+	/* Set only for omap2430 and later */
+	if (!od->cfg->rw_priority)
+		return;
+
+	if (max_fifo_depth == 0)
+		max_fifo_depth = 1;
+	if (arb_rate == 0)
+		arb_rate = 1;
+
+	val = 0xff & max_fifo_depth;
+	val |= (0x3 & tparams) << 12;
+	val |= (arb_rate & 0xff) << 16;
+
+	omap_dma_glbl_write(od, GCR, val);
+}
+
 #define OMAP_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
@@ -1701,6 +1723,8 @@ static int omap_dma_probe(struct platform_device *pdev)
 		}
 	}
 
+	omap_dma_init_gcr(od, DMA_DEFAULT_ARB_RATE, DMA_DEFAULT_FIFO_DEPTH, 0);
+
 	if (od->cfg->may_lose_context) {
 		od->nb.notifier_call = omap_dma_context_notifier;
 		cpu_pm_register_notifier(&od->nb);
@@ -1743,24 +1767,29 @@ static int omap_dma_remove(struct platform_device *pdev)
 
 static const struct omap_dma_config omap2420_data = {
 	.lch_end = CCFN,
+	.rw_priority = true,
 };
 
 static const struct omap_dma_config omap2430_data = {
 	.lch_end = CCFN,
+	.rw_priority = true,
 };
 
 static const struct omap_dma_config omap3430_data = {
 	.lch_end = CCFN,
+	.rw_priority = true,
 	.may_lose_context = true,
 };
 
 static const struct omap_dma_config omap3630_data = {
 	.lch_end = CCDN,
+	.rw_priority = true,
 	.may_lose_context = true,
 };
 
 static const struct omap_dma_config omap4_data = {
 	.lch_end = CCDN,
+	.rw_priority = true,
 };
 
 static const struct of_device_id omap_dma_match[] = {
-- 
2.24.1
