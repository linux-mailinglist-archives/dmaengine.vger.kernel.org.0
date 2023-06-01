Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C4719285
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 07:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjFAFqP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 01:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFAFqK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 01:46:10 -0400
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BAD138;
        Wed, 31 May 2023 22:46:02 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward101a.mail.yandex.net (Yandex) with ESMTP id 2315846CFB;
        Thu,  1 Jun 2023 08:46:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-DFHBlyHk;
        Thu, 01 Jun 2023 08:45:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598359;
        bh=KLrVnMEd2y4nYOzhJZ2F3t2Pu1RnxbcBeOQuWdAc4II=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=ejglrTOdUB3ez90jf397QIvZUmL2qYb1aYthQDJNcoJCpi8t+4UzvEYAIkDEiRUDq
         +O8QnwVwUnS6dDIMKW2C7iQ6ThYaPHeFFIVA/OFpHOjC9DlYilBK9fPRL2DOEXSUJe
         mZ6f+blyWV02Jo/sDu3PN6NIFb10pOO07y3gADT4=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v1 22/43] dma: cirrus: add DT support for Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:45:27 +0300
Message-Id: <20230601054549.10843-4-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

- find register range from the device tree
- get clocks, interrupts from device tree

Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/mach-ep93xx/dma.c               |   1 +
 drivers/dma/ep93xx_dma.c                 | 136 +++++++++++++++++++++--
 include/linux/platform_data/dma-ep93xx.h |   3 +
 3 files changed, 130 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-ep93xx/dma.c b/arch/arm/mach-ep93xx/dma.c
index 74515acab8ef..273954cbfced 100644
--- a/arch/arm/mach-ep93xx/dma.c
+++ b/arch/arm/mach-ep93xx/dma.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #include <linux/platform_data/dma-ep93xx.h>
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 5338a94f1a69..9f71e08ca380 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -20,6 +20,7 @@
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
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
@@ -1315,20 +1323,105 @@ static void ep93xx_dma_issue_pending(struct dma_chan *chan)
 	ep93xx_dma_advance_work(to_ep93xx_dma_chan(chan));
 }
 
-static int __init ep93xx_dma_probe(struct platform_device *pdev)
+
+#ifdef CONFIG_OF
+struct ep93xx_edma_data {
+	u32	id;
+	size_t	num_channels;
+};
+
+static const struct ep93xx_edma_data edma_m2p = {
+	.id = M2P_DMA,
+	.num_channels = 10,
+};
+
+static const struct ep93xx_edma_data edma_m2m = {
+	.id = M2M_DMA,
+	.num_channels = 2,
+};
+
+static const struct of_device_id ep93xx_dma_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-dma-m2p", .data = &edma_m2p },
+	{ .compatible = "cirrus,ep9301-dma-m2m", .data = &edma_m2m },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_dma_of_ids);
+
+static int ep93xx_dma_of_probe(struct platform_device *pdev,
+			struct ep93xx_dma_engine *edma)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match = of_match_node(ep93xx_dma_of_ids, pdev->dev.of_node);
+	const struct ep93xx_edma_data *data = match->data;
+	struct dma_device *dma_dev = &edma->dma_dev;
+	int num_channels;
+	int i;
+
+	match = of_match_device((ep93xx_dma_of_ids), &pdev->dev);
+	if (!match || !match->data) {
+		dev_err(&pdev->dev, "No device match found\n");
+		return -ENODEV;
+	}
+
+	edma->m2m = data->id;
+	num_channels = data->num_channels;
+	edma->channels = devm_kzalloc(&pdev->dev,
+				      num_channels * sizeof(struct ep93xx_dma_chan),
+				      GFP_KERNEL);
+	if (!edma->channels)
+		return -ENOMEM;
+
+	edma->num_channels = num_channels;
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
 
@@ -1359,6 +1452,27 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
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
@@ -1415,10 +1529,12 @@ static const struct platform_device_id ep93xx_dma_driver_ids[] = {
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
2.37.4

