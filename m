Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E152A6EC930
	for <lists+dmaengine@lfdr.de>; Mon, 24 Apr 2023 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjDXJnY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Apr 2023 05:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjDXJnY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Apr 2023 05:43:24 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC61713;
        Mon, 24 Apr 2023 02:43:22 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id 049B55ED95;
        Mon, 24 Apr 2023 12:35:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-sBZEtp6G;
        Mon, 24 Apr 2023 12:35:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328953;
        bh=VqfiwALsF03HPfSwF1n2+qvEWhTX1pcFlF7KBnRBI1M=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=r1YWhj6Re3tcztiNcfjIT5JWvetrei9XhHPcHmLkzP4kQTKoPi0o2ym7cX7c4GYU6
         bGmMGcYvg5BjYMjmVsjAHIIF0PMY5c2rWG/UJY1FWBVuQTH6RNqQRU1tzBnROYIvn2
         q0WQfNyz+8S5W6S8+K6/mQ5IHz/BpOAQ83ZAgdzs=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/43] dma: cirrus: add DT support for Cirrus EP93xx
Date:   Mon, 24 Apr 2023 15:34:37 +0300
Message-Id: <20230424123522.18302-22-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

- find register range from the device tree
- get clocks, interrupts from device tree

Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    Arnd Bergmann:
    - wildcards ep93xx to something meaningful, i.e. ep9301
    - drop wrappers
    
    Changes by Alexander:
    - correct dma compatible checks
    - fix dma compatible namings

 drivers/dma/ep93xx_dma.c                 | 119 +++++++++++++++++++++--
 include/linux/platform_data/dma-ep93xx.h |   3 +
 2 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index d19ea885c63e..1da1e20a4d77 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -20,6 +20,7 @@
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -104,6 +105,11 @@
 #define DMA_MAX_CHAN_BYTES		0xffff
 #define DMA_MAX_CHAN_DESCRIPTORS	32
 
+enum ep93xx_dma_type {
+	M2P_DMA,
+	M2M_DMA,
+};
+
 struct ep93xx_dma_engine;
 static int ep93xx_dma_slave_config_write(struct dma_chan *chan,
 					 enum dma_transfer_direction dir,
@@ -213,7 +219,7 @@ struct ep93xx_dma_engine {
 #define INTERRUPT_NEXT_BUFFER	2
 
 	size_t			num_channels;
-	struct ep93xx_dma_chan	channels[];
+	struct ep93xx_dma_chan	*channels;
 };
 
 static inline struct device *chan2dev(struct ep93xx_dma_chan *edmac)
@@ -875,9 +881,11 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
 	if (!edmac->edma->m2m) {
 		if (!data)
 			return -EINVAL;
+
 		if (data->port < EP93XX_DMA_I2S1 ||
 		    data->port > EP93XX_DMA_IRDA)
 			return -EINVAL;
+
 		if (data->direction != ep93xx_dma_chan_direction(chan))
 			return -EINVAL;
 	} else {
@@ -1315,20 +1323,88 @@ static void ep93xx_dma_issue_pending(struct dma_chan *chan)
 	ep93xx_dma_advance_work(to_ep93xx_dma_chan(chan));
 }
 
-static int __init ep93xx_dma_probe(struct platform_device *pdev)
+
+#ifdef CONFIG_OF
+static const struct of_device_id ep93xx_dma_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-dma-m2p", .data = (const void *)M2P_DMA },
+	{ .compatible = "cirrus,ep9301-dma-m2m", .data = (const void *)M2M_DMA },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ep93xx_dma_of_ids);
+
+static int ep93xx_dma_of_probe(struct platform_device *pdev,
+			struct ep93xx_dma_engine *edma)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match = of_match_node(ep93xx_dma_of_ids, pdev->dev.of_node);
+	struct dma_device *dma_dev = &edma->dma_dev;
+	int num_channels;
+	int i, ret;
+
+	ret = of_property_read_u32(np, "dma-channels", &num_channels);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to read dma-channels\n");
+		return ret;
+	}
+
+	edma->channels = devm_kzalloc(&pdev->dev,
+				      num_channels * sizeof(struct ep93xx_dma_chan),
+				      GFP_KERNEL);
+	if (!edma->channels)
+		return -ENOMEM;
+
+	edma->num_channels = num_channels;
+	edma->m2m = match->data;
+
+	INIT_LIST_HEAD(&dma_dev->channels);
+	for (i = 0; i < num_channels; i++) {
+		struct ep93xx_dma_chan *edmac = &edma->channels[i];
+
+		edmac->chan.device = dma_dev;
+		edmac->regs = devm_platform_ioremap_resource(pdev, i);
+		edmac->irq = platform_get_irq(pdev, i);
+		edmac->edma = edma;
+
+		edmac->clk = of_clk_get(np, i);
+
+		if (IS_ERR(edmac->clk)) {
+			dev_warn(&pdev->dev, "failed to get clock\n");
+			continue;
+		}
+
+		spin_lock_init(&edmac->lock);
+		INIT_LIST_HEAD(&edmac->active);
+		INIT_LIST_HEAD(&edmac->queue);
+		INIT_LIST_HEAD(&edmac->free_list);
+		tasklet_setup(&edmac->tasklet, ep93xx_dma_tasklet);
+
+		list_add_tail(&edmac->chan.device_node,
+			      &dma_dev->channels);
+	}
+
+	return 0;
+}
+#else
+static int ep93xx_dma_of_probe(struct platform_device *pdev,
+			struct ep93xx_dma_engine *edma)
+{
+	return -EINVAL;
+}
+#endif
+
+static int ep93xx_init_from_pdata(struct platform_device *pdev,
+				  struct ep93xx_dma_engine *edma)
 {
 	struct ep93xx_dma_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct ep93xx_dma_engine *edma;
-	struct dma_device *dma_dev;
-	size_t edma_size;
-	int ret, i;
+	struct dma_device *dma_dev = &edma->dma_dev;
+	int i;
 
-	edma_size = pdata->num_channels * sizeof(struct ep93xx_dma_chan);
-	edma = kzalloc(sizeof(*edma) + edma_size, GFP_KERNEL);
-	if (!edma)
+	edma->channels = devm_kzalloc(&pdev->dev,
+				      pdata->num_channels * sizeof(struct ep93xx_dma_chan),
+				      GFP_KERNEL);
+	if (!edma->channels)
 		return -ENOMEM;
 
-	dma_dev = &edma->dma_dev;
 	edma->m2m = platform_get_device_id(pdev)->driver_data;
 	edma->num_channels = pdata->num_channels;
 
@@ -1359,6 +1435,27 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
 			      &dma_dev->channels);
 	}
 
+	return 0;
+}
+
+static int __init ep93xx_dma_probe(struct platform_device *pdev)
+{
+	struct ep93xx_dma_engine *edma;
+	struct dma_device *dma_dev;
+	int ret, i;
+
+	edma = devm_kzalloc(&pdev->dev, sizeof(*edma), GFP_KERNEL);
+
+	if (platform_get_device_id(pdev))
+		ret = ep93xx_init_from_pdata(pdev, edma);
+	else
+		ret = ep93xx_dma_of_probe(pdev, edma);
+
+	if (ret)
+		return ret;
+
+	dma_dev = &edma->dma_dev;
+
 	dma_cap_zero(dma_dev->cap_mask);
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
 	dma_cap_set(DMA_CYCLIC, dma_dev->cap_mask);
@@ -1415,10 +1512,12 @@ static const struct platform_device_id ep93xx_dma_driver_ids[] = {
 	{ "ep93xx-dma-m2m", 1 },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, ep93xx_dma_driver_ids);
 
 static struct platform_driver ep93xx_dma_driver = {
 	.driver		= {
 		.name	= "ep93xx-dma",
+		.of_match_table = ep93xx_dma_of_ids,
 	},
 	.id_table	= ep93xx_dma_driver_ids,
 };
diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
index eb9805bb3fe8..d485e3c21a3a 100644
--- a/include/linux/platform_data/dma-ep93xx.h
+++ b/include/linux/platform_data/dma-ep93xx.h
@@ -70,6 +70,9 @@ struct ep93xx_dma_platform_data {
 
 static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
 {
+	if (of_device_is_compatible(dev_of_node(chan->device->dev), "cirrus,ep9301-dma-m2p"))
+		return true;
+
 	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");
 }
 
-- 
2.39.2

