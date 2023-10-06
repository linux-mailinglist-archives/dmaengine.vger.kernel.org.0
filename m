Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70877BC133
	for <lists+dmaengine@lfdr.de>; Fri,  6 Oct 2023 23:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjJFViz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Oct 2023 17:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJFViv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Oct 2023 17:38:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86605BD;
        Fri,  6 Oct 2023 14:38:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA44C433C7;
        Fri,  6 Oct 2023 21:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628330;
        bh=iArrLU+Z+tOWUtxgddvqoQCmYNdeqno+QP+vyryCqYs=;
        h=From:To:Cc:Subject:Date:From;
        b=uRGXMqrYu6XQj1f/L6XAiYU4O5gJ/Zt4o5paEhdll4QZdw9HA/gcBceCOBadQOTvq
         arfZOE1TOwGeEyGT0OD7EiVYVsHbdRW2bu0HX+efC7cR6oJqxxb7Fe1gjMC/aao/Kv
         OrbDuOYtLuoI6yjQjEkyHhzT27fWNwiyoHoeWklnIyoMxT03NBTwVgMStLSRW/BmDH
         gEmxSvERb0c5nqaxp7+d4vfqdf11G43doA5WqpICU75QBe7vk7YZyO1Y8Y4sx+wunb
         relDMSBD7D9m0QBoHf3d/UsuJkKExkSuXyZhtB2m1ToVfvn9sgxKAOBjTwTkPNZALy
         3mQ4EEvFLl3Qg==
Received: (nullmailer pid 333149 invoked by uid 1000);
        Fri, 06 Oct 2023 21:38:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:38:43 -0500
Message-Id: <20231006213844.333027-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/dma/fsl-edma-main.c |  9 ++-------
 drivers/dma/mmp_tdma.c      | 29 +++++++----------------------
 drivers/dma/mv_xor.c        | 11 +++--------
 drivers/dma/st_fdma.c       | 12 +++---------
 4 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 5f8b71eb029c..e122ebb7c018 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -13,13 +13,11 @@
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 #include <linux/of_dma.h>
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
+#include <linux/property.h>
 
 #include "fsl-edma-common.h"
 
@@ -416,8 +414,6 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
 
 static int fsl_edma_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(fsl_edma_dt_ids, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma;
 	const struct fsl_edma_drvdata *drvdata = NULL;
@@ -426,8 +422,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	int chans;
 	int ret, i;
 
-	if (of_id)
-		drvdata = of_id->data;
+	drvdata = device_get_match_data(&pdev->dev);
 	if (!drvdata) {
 		dev_err(&pdev->dev, "unable to find driver data\n");
 		return -EINVAL;
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index f039e07181f7..b76fe99e1151 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -14,9 +14,9 @@
 #include <linux/slab.h>
 #include <linux/dmaengine.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/device.h>
 #include <linux/genalloc.h>
-#include <linux/of_device.h>
 #include <linux/of_dma.h>
 
 #include "dmaengine.h"
@@ -635,18 +635,13 @@ MODULE_DEVICE_TABLE(of, mmp_tdma_dt_ids);
 static int mmp_tdma_probe(struct platform_device *pdev)
 {
 	enum mmp_tdma_type type;
-	const struct of_device_id *of_id;
 	struct mmp_tdma_device *tdev;
 	int i, ret;
 	int irq = 0, irq_num = 0;
 	int chan_num = TDMA_CHANNEL_NUM;
 	struct gen_pool *pool = NULL;
 
-	of_id = of_match_device(mmp_tdma_dt_ids, &pdev->dev);
-	if (of_id)
-		type = (enum mmp_tdma_type) of_id->data;
-	else
-		type = platform_get_device_id(pdev)->driver_data;
+	type = (enum mmp_tdma_type)device_get_match_data(&pdev->dev);
 
 	/* always have couple channels */
 	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev), GFP_KERNEL);
@@ -724,32 +719,22 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (pdev->dev.of_node) {
-		ret = of_dma_controller_register(pdev->dev.of_node,
-							mmp_tdma_xlate, tdev);
-		if (ret) {
-			dev_err(tdev->device.dev,
-				"failed to register controller\n");
-			return ret;
-		}
+	ret = of_dma_controller_register(pdev->dev.of_node,
+					 mmp_tdma_xlate, tdev);
+	if (ret) {
+		dev_err(tdev->device.dev, "failed to register controller\n");
+		return ret;
 	}
 
 	dev_info(tdev->device.dev, "initialized\n");
 	return 0;
 }
 
-static const struct platform_device_id mmp_tdma_id_table[] = {
-	{ "mmp-adma",	MMP_AUD_TDMA },
-	{ "pxa910-squ",	PXA910_SQU },
-	{ },
-};
-
 static struct platform_driver mmp_tdma_driver = {
 	.driver		= {
 		.name	= "mmp-tdma",
 		.of_match_table = mmp_tdma_dt_ids,
 	},
-	.id_table	= mmp_tdma_id_table,
 	.probe		= mmp_tdma_probe,
 	.remove_new	= mmp_tdma_remove,
 };
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 23b232b57518..bcd3b623ac6c 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -10,8 +10,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/memory.h>
 #include <linux/clk.h>
 #include <linux/of.h>
@@ -1328,13 +1328,8 @@ static int mv_xor_probe(struct platform_device *pdev)
 	 * setting up. In non-dt case it can only be the legacy one.
 	 */
 	xordev->xor_type = XOR_ORION;
-	if (pdev->dev.of_node) {
-		const struct of_device_id *of_id =
-			of_match_device(mv_xor_dt_ids,
-					&pdev->dev);
-
-		xordev->xor_type = (uintptr_t)of_id->data;
-	}
+	if (pdev->dev.of_node)
+		xordev->xor_type = (uintptr_t)device_get_match_data(&pdev->dev);
 
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index 145bd0f2496e..8880b5e336f8 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -10,9 +10,10 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/interrupt.h>
 #include <linux/remoteproc.h>
 #include <linux/slab.h>
@@ -739,18 +740,11 @@ static void st_fdma_free(struct st_fdma_dev *fdev)
 static int st_fdma_probe(struct platform_device *pdev)
 {
 	struct st_fdma_dev *fdev;
-	const struct of_device_id *match;
 	struct device_node *np = pdev->dev.of_node;
 	const struct st_fdma_driverdata *drvdata;
 	int ret, i;
 
-	match = of_match_device((st_fdma_match), &pdev->dev);
-	if (!match || !match->data) {
-		dev_err(&pdev->dev, "No device match found\n");
-		return -ENODEV;
-	}
-
-	drvdata = match->data;
+	drvdata = device_get_match_data(&pdev->dev);
 
 	fdev = devm_kzalloc(&pdev->dev, sizeof(*fdev), GFP_KERNEL);
 	if (!fdev)
-- 
2.40.1

