Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38793A4009
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 12:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFKKUs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 06:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhFKKUr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 06:20:47 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2245AC061283
        for <dmaengine@vger.kernel.org>; Fri, 11 Jun 2021 03:18:48 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:2411:a261:8fe2:b47f])
        by baptiste.telenet-ops.be with bizsmtp
        id FmJl2500o25eH3q01mJl6K; Fri, 11 Jun 2021 12:18:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lreFR-00Fd2B-Cm; Fri, 11 Jun 2021 12:18:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lreFQ-00CaZf-Jy; Fri, 11 Jun 2021 12:18:44 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] dmaengine: sh: Remove unused shdma-of driver
Date:   Fri, 11 Jun 2021 12:18:40 +0200
Message-Id: <e9445a5f4ac15fc4d3b376b5e675e39f8c95b967.1623406640.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623406640.git.geert+renesas@glider.be>
References: <cover.1623406640.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove the DT-based Renesas SHDMA DMA multiplexer driver, as it is
unused.  The DMA multiplexer node and one DMA controller instance were
added to the R-Mobile APE6 .dtsi file, but DMA support was never fully
enabled, cfr. commit a19788612f51b787 ("dmaengine: sh: Remove R-Mobile
APE6 support").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/Makefile   |  2 +-
 drivers/dma/sh/shdma-of.c | 76 ---------------------------------------
 2 files changed, 1 insertion(+), 77 deletions(-)
 delete mode 100644 drivers/dma/sh/shdma-of.c

diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 112fbd22bb3fb984..abdf10341725c36b 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -3,7 +3,7 @@
 # DMA Engine Helpers
 #
 
-obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
+obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o
 
 #
 # DMA Controllers
diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
deleted file mode 100644
index be89dd894328f589..0000000000000000
--- a/drivers/dma/sh/shdma-of.c
+++ /dev/null
@@ -1,76 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * SHDMA Device Tree glue
- *
- * Copyright (C) 2013 Renesas Electronics Inc.
- * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- */
-
-#include <linux/dmaengine.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_dma.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/shdma-base.h>
-
-#define to_shdma_chan(c) container_of(c, struct shdma_chan, dma_chan)
-
-static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
-				       struct of_dma *ofdma)
-{
-	u32 id = dma_spec->args[0];
-	dma_cap_mask_t mask;
-	struct dma_chan *chan;
-
-	if (dma_spec->args_count != 1)
-		return NULL;
-
-	dma_cap_zero(mask);
-	/* Only slave DMA channels can be allocated via DT */
-	dma_cap_set(DMA_SLAVE, mask);
-
-	chan = dma_request_channel(mask, shdma_chan_filter,
-				   (void *)(uintptr_t)id);
-	if (chan)
-		to_shdma_chan(chan)->hw_req = id;
-
-	return chan;
-}
-
-static int shdma_of_probe(struct platform_device *pdev)
-{
-	const struct of_dev_auxdata *lookup = dev_get_platdata(&pdev->dev);
-	int ret;
-
-	ret = of_dma_controller_register(pdev->dev.of_node,
-					 shdma_of_xlate, pdev);
-	if (ret < 0)
-		return ret;
-
-	ret = of_platform_populate(pdev->dev.of_node, NULL, lookup, &pdev->dev);
-	if (ret < 0)
-		of_dma_controller_free(pdev->dev.of_node);
-
-	return ret;
-}
-
-static const struct of_device_id shdma_of_match[] = {
-	{ .compatible = "renesas,shdma-mux", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
-
-static struct platform_driver shdma_of = {
-	.driver		= {
-		.name	= "shdma-of",
-		.of_match_table = shdma_of_match,
-	},
-	.probe		= shdma_of_probe,
-};
-
-module_platform_driver(shdma_of);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("SH-DMA driver DT glue");
-MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
-- 
2.25.1

