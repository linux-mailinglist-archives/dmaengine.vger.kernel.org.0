Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8677BC130
	for <lists+dmaengine@lfdr.de>; Fri,  6 Oct 2023 23:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjJFVip (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Oct 2023 17:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjJFVip (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 Oct 2023 17:38:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BBCBD;
        Fri,  6 Oct 2023 14:38:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC90C433C7;
        Fri,  6 Oct 2023 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628323;
        bh=mtOK85aeQi5zxtQ5qxl21dr+kSNJG6tsBGqhON2xals=;
        h=From:To:Cc:Subject:Date:From;
        b=mdA3EliYhLBRpICdZsSU/iSXwksjuJCbPBVnMmVEXFlTNPi4yUhxf5ukz9QIMWj5W
         B2iCefR1QD8PN2ISKt18ovC8btGFvYO4HSXQhvNJagWYw+oI5iwUa6HROCmKqznthQ
         +dqEN11aHAySxDS7qK5Yk7YUIx+GMCAogv9FoTsJysUo8dSfshzP4Gn0dEv4OkjpSr
         /eeNZ1JrfFMt2AoYaw6+XsIpWrgFob+Cc8snCZaV25CNCUraZagwFw28wEBcmC8OFK
         g362ICGYQbYa1Z/hjCDITCmz2lXa9m/RCck7Pios36Fbw1WwljU8whA5WHZrTEsfex
         E1/8Qk4EMB2RQ==
Received: (nullmailer pid 332965 invoked by uid 1000);
        Fri, 06 Oct 2023 21:38:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] dmaengine: Drop unnecessary of_match_device() calls
Date:   Fri,  6 Oct 2023 16:38:35 -0500
Message-Id: <20231006213835.332848-1-robh@kernel.org>
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

If probe is reached, we've already matched the device and in the case of
DT matching, the struct device_node pointer will be set. Therefore, there
is no need to call of_match_device() in probe.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/dma/k3dma.c     | 25 ++++++++++---------------
 drivers/dma/mmp_pdma.c  |  5 +----
 drivers/dma/pxa_dma.c   |  7 ++-----
 drivers/dma/stm32-dma.c |  8 --------
 4 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 22b37b525a48..5de8c21d41e7 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -15,7 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/of_dma.h>
@@ -839,7 +838,6 @@ static int k3_dma_probe(struct platform_device *op)
 {
 	const struct k3dma_soc_data *soc_data;
 	struct k3_dma_dev *d;
-	const struct of_device_id *of_id;
 	int i, ret, irq = 0;
 
 	d = devm_kzalloc(&op->dev, sizeof(*d), GFP_KERNEL);
@@ -854,19 +852,16 @@ static int k3_dma_probe(struct platform_device *op)
 	if (IS_ERR(d->base))
 		return PTR_ERR(d->base);
 
-	of_id = of_match_device(k3_pdma_dt_ids, &op->dev);
-	if (of_id) {
-		of_property_read_u32((&op->dev)->of_node,
-				"dma-channels", &d->dma_channels);
-		of_property_read_u32((&op->dev)->of_node,
-				"dma-requests", &d->dma_requests);
-		ret = of_property_read_u32((&op->dev)->of_node,
-				"dma-channel-mask", &d->dma_channel_mask);
-		if (ret) {
-			dev_warn(&op->dev,
-				 "dma-channel-mask doesn't exist, considering all as available.\n");
-			d->dma_channel_mask = (u32)~0UL;
-		}
+	of_property_read_u32((&op->dev)->of_node,
+			"dma-channels", &d->dma_channels);
+	of_property_read_u32((&op->dev)->of_node,
+			"dma-requests", &d->dma_requests);
+	ret = of_property_read_u32((&op->dev)->of_node,
+			"dma-channel-mask", &d->dma_channel_mask);
+	if (ret) {
+		dev_warn(&op->dev,
+			 "dma-channel-mask doesn't exist, considering all as available.\n");
+		d->dma_channel_mask = (u32)~0UL;
 	}
 
 	if (!(soc_data->flags & K3_FLAG_NOCLK)) {
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 492ec491a59b..136fcaeff8dd 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -15,7 +15,6 @@
 #include <linux/device.h>
 #include <linux/platform_data/mmp_dma.h>
 #include <linux/dmapool.h>
-#include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/of.h>
 
@@ -1019,7 +1018,6 @@ static struct dma_chan *mmp_pdma_dma_xlate(struct of_phandle_args *dma_spec,
 static int mmp_pdma_probe(struct platform_device *op)
 {
 	struct mmp_pdma_device *pdev;
-	const struct of_device_id *of_id;
 	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
 	int i, ret, irq = 0;
 	int dma_channels = 0, irq_num = 0;
@@ -1039,8 +1037,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 	if (IS_ERR(pdev->base))
 		return PTR_ERR(pdev->base);
 
-	of_id = of_match_device(mmp_pdma_dt_ids, pdev->dev);
-	if (of_id) {
+	if (pdev->dev->of_node) {
 		/* Parse new and deprecated dma-channels properties */
 		if (of_property_read_u32(pdev->dev->of_node, "dma-channels",
 					 &dma_channels))
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 3c574dc0613b..e260cadfc46f 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -15,9 +15,8 @@
 #include <linux/device.h>
 #include <linux/platform_data/mmp_dma.h>
 #include <linux/dmapool.h>
-#include <linux/of_device.h>
-#include <linux/of_dma.h>
 #include <linux/of.h>
+#include <linux/of_dma.h>
 #include <linux/wait.h>
 #include <linux/dma/pxa-dma.h>
 
@@ -1342,7 +1341,6 @@ static int pxad_init_dmadev(struct platform_device *op,
 static int pxad_probe(struct platform_device *op)
 {
 	struct pxad_device *pdev;
-	const struct of_device_id *of_id;
 	const struct dma_slave_map *slave_map = NULL;
 	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
 	int ret, dma_channels = 0, nb_requestors = 0, slave_map_cnt = 0;
@@ -1360,8 +1358,7 @@ static int pxad_probe(struct platform_device *op)
 	if (IS_ERR(pdev->base))
 		return PTR_ERR(pdev->base);
 
-	of_id = of_match_device(pxad_dt_ids, &op->dev);
-	if (of_id) {
+	if (op->dev.of_node) {
 		/* Parse new and deprecated dma-channels properties */
 		if (of_property_read_u32(op->dev.of_node, "dma-channels",
 					 &dma_channels))
diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index a732b3807b11..c8089e77c950 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -21,7 +21,6 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -1561,17 +1560,10 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	struct stm32_dma_chan *chan;
 	struct stm32_dma_device *dmadev;
 	struct dma_device *dd;
-	const struct of_device_id *match;
 	struct resource *res;
 	struct reset_control *rst;
 	int i, ret;
 
-	match = of_match_device(stm32_dma_of_match, &pdev->dev);
-	if (!match) {
-		dev_err(&pdev->dev, "Error: No device match found\n");
-		return -ENODEV;
-	}
-
 	dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev), GFP_KERNEL);
 	if (!dmadev)
 		return -ENOMEM;
-- 
2.40.1

