Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5614B121F7C
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfLQAT7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:19:59 -0500
Received: from muru.com ([72.249.23.125]:48730 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfLQAT7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:19:59 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 8BF51810D;
        Tue, 17 Dec 2019 00:20:36 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 08/14] dmaengine: ti: omap-dma: Add device tree match data and use it for cpu_pm
Date:   Mon, 16 Dec 2019 16:19:19 -0800
Message-Id: <20191217001925.44558-9-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With old DMA code disabled for handling DMA requests for device tree based
SoCs, we can move omap3 specific context save and restore to the dmaengine
driver.

Let's do this by adding cpu_pm notifier handling to save and restore context,
and enable it based on device tree match data. This way we can use the match
data later to configure more SoC specific features later on too.

Note that we only clear the channels in use while the platform code also
clears reserved channels 0 and 1 on high-security SoCs. Based on testing
on n900, this is not needed though and the system idles just fine.

With the dmaengine driver handling context save and restore, we must now
remove the old custom calls for context save and restore.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm34xx.c |   5 --
 arch/arm/plat-omap/dma.c     |  43 ----------
 drivers/dma/ti/omap-dma.c    | 150 ++++++++++++++++++++++++++++++++---
 include/linux/omap-dma.h     |   2 -
 4 files changed, 138 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -25,7 +25,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/omap-dma.h>
 #include <linux/omap-gpmc.h>
 
 #include <trace/events/power.h>
@@ -85,7 +84,6 @@ static void omap3_core_save_context(void)
 	omap3_gpmc_save_context();
 	/* Save the system control module context, padconf already save above*/
 	omap3_control_save_context();
-	omap_dma_global_context_save();
 }
 
 static void omap3_core_restore_context(void)
@@ -96,7 +94,6 @@ static void omap3_core_restore_context(void)
 	omap3_gpmc_restore_context();
 	/* Restore the interrupt controller context */
 	omap_intc_restore_context();
-	omap_dma_global_context_restore();
 }
 
 /*
@@ -547,9 +544,7 @@ int __init omap3_pm_init(void)
 
 		local_irq_disable();
 
-		omap_dma_global_context_save();
 		omap3_save_secure_ram_context();
-		omap_dma_global_context_restore();
 
 		local_irq_enable();
 	}
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -68,13 +68,6 @@ static void omap_clear_dma(int lch);
 static int enable_1510_mode;
 static u32 errata;
 
-static struct omap_dma_global_context_registers {
-	u32 dma_irqenable_l0;
-	u32 dma_irqenable_l1;
-	u32 dma_ocp_sysconfig;
-	u32 dma_gcr;
-} omap_dma_global_context;
-
 struct dma_link_info {
 	int *linked_dmach_q;
 	int no_of_lchs_linked;
@@ -905,42 +898,6 @@ static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
 #define omap1_dma_irq_handler	NULL
 #endif
 
-/*
- * Note that we are currently using only IRQENABLE_L0 and L1.
- * As the DSP may be using IRQENABLE_L2 and L3, let's not
- * touch those for now.
- */
-void omap_dma_global_context_save(void)
-{
-	omap_dma_global_context.dma_irqenable_l0 =
-		p->dma_read(IRQENABLE_L0, 0);
-	omap_dma_global_context.dma_irqenable_l1 =
-		p->dma_read(IRQENABLE_L1, 0);
-	omap_dma_global_context.dma_ocp_sysconfig =
-		p->dma_read(OCP_SYSCONFIG, 0);
-	omap_dma_global_context.dma_gcr = p->dma_read(GCR, 0);
-}
-
-void omap_dma_global_context_restore(void)
-{
-	int ch;
-
-	p->dma_write(omap_dma_global_context.dma_gcr, GCR, 0);
-	p->dma_write(omap_dma_global_context.dma_ocp_sysconfig,
-		OCP_SYSCONFIG, 0);
-	p->dma_write(omap_dma_global_context.dma_irqenable_l0,
-		IRQENABLE_L0, 0);
-	p->dma_write(omap_dma_global_context.dma_irqenable_l1,
-		IRQENABLE_L1, 0);
-
-	if (IS_DMA_ERRATA(DMA_ROMCODE_BUG))
-		p->dma_write(0x3 , IRQSTATUS_L0, 0);
-
-	for (ch = 0; ch < dma_chan_count; ch++)
-		if (dma_chan[ch].dev_id != -1)
-			omap_clear_dma(ch);
-}
-
 struct omap_system_dma_plat_info *omap_get_plat_info(void)
 {
 	return p;
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -2,6 +2,7 @@
 /*
  * OMAP DMAengine support
  */
+#include <linux/cpu_pm.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -23,12 +24,28 @@
 #define OMAP_SDMA_REQUESTS	127
 #define OMAP_SDMA_CHANNELS	32
 
+struct omap_dma_config {
+	int lch_end;
+	unsigned int may_lose_context:1;
+};
+
+struct omap_dma_context {
+	u32 irqenable_l0;
+	u32 irqenable_l1;
+	u32 ocp_sysconfig;
+	u32 gcr;
+};
+
 struct omap_dmadev {
 	struct dma_device ddev;
 	spinlock_t lock;
 	void __iomem *base;
 	const struct omap_dma_reg *reg_map;
 	struct omap_system_dma_plat_info *plat;
+	const struct omap_dma_config *cfg;
+	struct notifier_block nb;
+	struct omap_dma_context context;
+	int lch_count;
 	bool legacy;
 	bool ll123_supported;
 	struct dma_pool *desc_pool;
@@ -376,6 +393,19 @@ static unsigned omap_dma_get_csr(struct omap_chan *c)
 	return val;
 }
 
+static void omap_dma_clear_lch(struct omap_dmadev *od, int lch)
+{
+	struct omap_chan *c;
+	int i;
+
+	c = od->lch_map[lch];
+	if (!c)
+		return;
+
+	for (i = CSDP; i <= od->cfg->lch_end; i++)
+		omap_dma_chan_write(c, i, 0);
+}
+
 static void omap_dma_assign(struct omap_dmadev *od, struct omap_chan *c,
 	unsigned lch)
 {
@@ -652,6 +682,7 @@ static int omap_dma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (ret >= 0) {
 		omap_dma_assign(od, c, c->dma_ch);
+		pr_info("XXX %s: assigned lch: %i\n", __func__, c->dma_ch);
 
 		if (!od->legacy) {
 			unsigned val;
@@ -1453,16 +1484,74 @@ static void omap_dma_free(struct omap_dmadev *od)
 	}
 }
 
+/*
+ * We are using IRQENABLE_L1, and legacy DMA code was using IRQENABLE_L0.
+ * As the DSP may be using IRQENABLE_L2 and L3, let's not touch those for
+ * now. Context save seems to be only currently needed on omap3.
+ */
+static void omap_dma_context_save(struct omap_dmadev *od)
+{
+	od->context.irqenable_l0 = omap_dma_glbl_read(od, IRQENABLE_L0);
+	od->context.irqenable_l1 = omap_dma_glbl_read(od, IRQENABLE_L1);
+	od->context.ocp_sysconfig = omap_dma_glbl_read(od, OCP_SYSCONFIG);
+	od->context.gcr = omap_dma_glbl_read(od, GCR);
+}
+
+static void omap_dma_context_restore(struct omap_dmadev *od)
+{
+	int i;
+
+	omap_dma_glbl_write(od, GCR, od->context.gcr);
+	omap_dma_glbl_write(od, OCP_SYSCONFIG, od->context.ocp_sysconfig);
+	omap_dma_glbl_write(od, IRQENABLE_L0, od->context.irqenable_l0);
+	omap_dma_glbl_write(od, IRQENABLE_L1, od->context.irqenable_l1);
+
+	/* Clear IRQSTATUS_L0 as legacy DMA code is no longer doing it */
+	if (od->plat->errata & DMA_ROMCODE_BUG)
+		omap_dma_glbl_write(od, IRQSTATUS_L0, 0);
+
+	/* Clear dma channels */
+	for (i = 0; i < od->lch_count; i++)
+		omap_dma_clear_lch(od, i);
+}
+
+/* Currently only used for omap3 */
+static int omap_dma_context_notifier(struct notifier_block *nb,
+				     unsigned long cmd, void *v)
+{
+	struct omap_dmadev *od;
+
+	od = container_of(nb, struct omap_dmadev, nb);
+
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		omap_dma_context_save(od);
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		omap_dma_context_restore(od);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 #define OMAP_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
+/*
+ * No flags currently set for default configuration as omap1 is still
+ * using platform data.
+ */
+static const struct omap_dma_config default_cfg;
+
 static int omap_dma_probe(struct platform_device *pdev)
 {
+	const struct omap_dma_config *conf;
 	struct omap_dmadev *od;
 	struct resource *res;
 	int rc, i, irq;
-	u32 lch_count;
 
 	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
 	if (!od)
@@ -1473,6 +1562,12 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(od->base))
 		return PTR_ERR(od->base);
 
+	conf = of_device_get_match_data(&pdev->dev);
+	if (conf)
+		od->cfg = conf;
+	else
+		od->cfg = &default_cfg;
+
 	od->plat = omap_get_plat_info();
 	if (!od->plat)
 		return -EPROBE_DEFER;
@@ -1522,18 +1617,19 @@ static int omap_dma_probe(struct platform_device *pdev)
 
 	/* Number of available logical channels */
 	if (!pdev->dev.of_node) {
-		lch_count = od->plat->dma_attr->lch_count;
-		if (unlikely(!lch_count))
-			lch_count = OMAP_SDMA_CHANNELS;
+		od->lch_count = od->plat->dma_attr->lch_count;
+		if (unlikely(!od->lch_count))
+			od->lch_count = OMAP_SDMA_CHANNELS;
 	} else if (of_property_read_u32(pdev->dev.of_node, "dma-channels",
-					&lch_count)) {
+					&od->lch_count)) {
 		dev_info(&pdev->dev,
 			 "Missing dma-channels property, using %u.\n",
 			 OMAP_SDMA_CHANNELS);
-		lch_count = OMAP_SDMA_CHANNELS;
+		od->lch_count = OMAP_SDMA_CHANNELS;
 	}
 
-	od->lch_map = devm_kcalloc(&pdev->dev, lch_count, sizeof(*od->lch_map),
+	od->lch_map = devm_kcalloc(&pdev->dev, od->lch_count,
+				   sizeof(*od->lch_map),
 				   GFP_KERNEL);
 	if (!od->lch_map)
 		return -ENOMEM;
@@ -1605,6 +1701,11 @@ static int omap_dma_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (od->cfg->may_lose_context) {
+		od->nb.notifier_call = omap_dma_context_notifier;
+		cpu_pm_register_notifier(&od->nb);
+	}
+
 	dev_info(&pdev->dev, "OMAP DMA engine driver%s\n",
 		 od->ll123_supported ? " (LinkedList1/2/3 supported)" : "");
 
@@ -1616,6 +1717,9 @@ static int omap_dma_remove(struct platform_device *pdev)
 	struct omap_dmadev *od = platform_get_drvdata(pdev);
 	int irq;
 
+	if (od->cfg->may_lose_context)
+		cpu_pm_unregister_notifier(&od->nb);
+
 	if (pdev->dev.of_node)
 		of_dma_controller_free(pdev->dev.of_node);
 
@@ -1637,12 +1741,34 @@ static int omap_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct omap_dma_config omap2420_data = {
+	.lch_end = CCFN,
+};
+
+static const struct omap_dma_config omap2430_data = {
+	.lch_end = CCFN,
+};
+
+static const struct omap_dma_config omap3430_data = {
+	.lch_end = CCFN,
+	.may_lose_context = true,
+};
+
+static const struct omap_dma_config omap3630_data = {
+	.lch_end = CCDN,
+	.may_lose_context = true,
+};
+
+static const struct omap_dma_config omap4_data = {
+	.lch_end = CCDN,
+};
+
 static const struct of_device_id omap_dma_match[] = {
-	{ .compatible = "ti,omap2420-sdma", },
-	{ .compatible = "ti,omap2430-sdma", },
-	{ .compatible = "ti,omap3430-sdma", },
-	{ .compatible = "ti,omap3630-sdma", },
-	{ .compatible = "ti,omap4430-sdma", },
+	{ .compatible = "ti,omap2420-sdma", .data = &omap2420_data, },
+	{ .compatible = "ti,omap2430-sdma", .data = &omap2430_data, },
+	{ .compatible = "ti,omap3430-sdma", .data = &omap3430_data, },
+	{ .compatible = "ti,omap3630-sdma", .data = &omap3630_data, },
+	{ .compatible = "ti,omap4430-sdma", .data = &omap4_data, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_dma_match);
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -327,8 +327,6 @@ extern dma_addr_t omap_get_dma_src_pos(int lch);
 extern dma_addr_t omap_get_dma_dst_pos(int lch);
 extern int omap_get_dma_active_status(int lch);
 extern int omap_dma_running(void);
-void omap_dma_global_context_save(void);
-void omap_dma_global_context_restore(void);
 
 #if defined(CONFIG_ARCH_OMAP1) && IS_ENABLED(CONFIG_FB_OMAP)
 #include <mach/lcd_dma.h>
-- 
2.24.1
