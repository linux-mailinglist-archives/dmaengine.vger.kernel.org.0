Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9749121F82
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfLQAUC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:20:02 -0500
Received: from muru.com ([72.249.23.125]:48756 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfLQAUC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:20:02 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 7B2EF8272;
        Tue, 17 Dec 2019 00:20:40 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 10/14] dmaengine: ti: omap-dma: Pass sdma auxdata to driver and use it
Date:   Mon, 16 Dec 2019 16:19:21 -0800
Message-Id: <20191217001925.44558-11-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We can now start passing sdma auxdata to the dmaengine driver to start
removing the platform based sdma init.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h       |  3 +++
 arch/arm/mach-omap2/dma.c          |  2 +-
 arch/arm/mach-omap2/pdata-quirks.c |  1 +
 drivers/dma/ti/omap-dma.c          | 14 +++++++++-----
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -345,9 +345,12 @@ static inline int dra7xx_pciess_reset(struct omap_hwmod *oh)
 }
 #endif
 
+struct omap_system_dma_plat_info;
+
 void pdata_quirks_init(const struct of_device_id *);
 void omap_auxdata_legacy_init(struct device *dev);
 void omap_pcs_legacy_init(int irq, void (*rearm)(void));
+extern struct omap_system_dma_plat_info dma_plat_info;
 
 struct omap_sdrc_params;
 extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -217,7 +217,7 @@ static struct omap_dma_dev_attr dma_attr = {
 	.lch_count = 32,
 };
 
-static struct omap_system_dma_plat_info dma_plat_info __initdata = {
+struct omap_system_dma_plat_info dma_plat_info = {
 	.reg_map	= reg_map,
 	.channel_stride	= 0x60,
 	.dma_attr	= &dma_attr,
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -514,6 +514,7 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 	/* Common auxdata */
 	OF_DEV_AUXDATA("ti,sysc", 0, NULL, &ti_sysc_pdata),
 	OF_DEV_AUXDATA("pinctrl-single", 0, NULL, &pcs_pdata),
+	OF_DEV_AUXDATA("ti,omap-sdma", 0, NULL, &dma_plat_info),
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1585,14 +1585,18 @@ static int omap_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(od->base);
 
 	conf = of_device_get_match_data(&pdev->dev);
-	if (conf)
+	if (conf) {
 		od->cfg = conf;
-	else
+		od->plat = dev_get_platdata(&pdev->dev);
+		if (!od->plat)
+			dev_warn(&pdev->dev, "no sdma auxdata needed?\n");
+	} else {
 		od->cfg = &default_cfg;
 
-	od->plat = omap_get_plat_info();
-	if (!od->plat)
-		return -EPROBE_DEFER;
+		od->plat = omap_get_plat_info();
+		if (!od->plat)
+			return -EPROBE_DEFER;
+	}
 
 	od->reg_map = od->plat->reg_map;
 
-- 
2.24.1
