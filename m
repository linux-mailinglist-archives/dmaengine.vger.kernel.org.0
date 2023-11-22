Return-Path: <dmaengine+bounces-164-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 926637F40CE
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 10:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4981D28157E
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9FC3C09B;
	Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e57LrrkH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171063B293
	for <dmaengine@vger.kernel.org>; Wed, 22 Nov 2023 09:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD527C433BC;
	Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700643674;
	bh=PuABHE4mflBXPOvn6q6gAN1gQjopi4IJHSrGRQqaA1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e57LrrkH11m4kdCYoVlD+lBt162mr5tr8W67m0vCQrIpAF843473yLaTjjBcqYqlc
	 qidA1E6JR4xRMZphI0Uz8SfK4ockFiaqWyayoyC50dMBGt4aSJfhXusdG1+8yLK2Sw
	 t57SXj8y9Qmg6JHOFnW3MltD715Ldk3OzMfWEHoQpbctQV7Xo59oxP6jXQZQONZZXJ
	 PvCzOqwDao/K60F1OwQWjcJ7ilznNwmganmq8R+YiRgOVg9F/vWJvwa4aYe4+N6FTu
	 6tv78DCoLPMdQY+9yvqpAPolbuKQRPaRrSsugl1RilGP5/NAG6Bs+KdbJjB9F3dfM1
	 On5CM7V/Q/QnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC33C072A2;
	Wed, 22 Nov 2023 09:01:14 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Wed, 22 Nov 2023 11:59:47 +0300
Subject: [PATCH v5 09/39] dma: cirrus: add DT support for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-ep93xx-v5-9-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
In-Reply-To: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
To: Vinod Koul <vkoul@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700643671; l=14505;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=Zak/RUxsoxIiJKrVj7ZlBzNeZ+MTd93wfov/QXAOOrQ=; =?utf-8?q?b=3DKcIVaE++MEML?=
 =?utf-8?q?iupcFq2ZGxS5c+2nXa6F0faSNTSeZ8zVdVr47EF5M/6GKTjzqFrRUHxatMAsIRyP?=
 5RuS3GdbBrxb4FaH6+jDNMRL7WbXCJWXQJflhkxPUs8eVx3R7Cbw
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

- drop subsys_initcall code
- drop platform probe
- add OF ID match table with data
- add of_probe for device tree
- add xlate for m2m/m2p
- drop platform structs usage

Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/dma/ep93xx_dma.c                 | 245 ++++++++++++++++++++++++-------
 include/linux/platform_data/dma-ep93xx.h |   4 +
 2 files changed, 195 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index d6c60635e90d..5e29b64caa46 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -20,6 +20,9 @@
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -104,6 +107,11 @@
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
@@ -129,11 +137,17 @@ struct ep93xx_dma_desc {
 	struct list_head		node;
 };
 
+struct ep93xx_dma_chan_cfg {
+	u8				port;
+	enum dma_transfer_direction	dir;
+};
+
 /**
  * struct ep93xx_dma_chan - an EP93xx DMA M2P/M2M channel
  * @chan: dmaengine API channel
  * @edma: pointer to the engine device
  * @regs: memory mapped registers
+ * @dma_cfg: channel number, direction
  * @irq: interrupt number of the channel
  * @clk: clock used by this channel
  * @tasklet: channel specific tasklet used for callbacks
@@ -157,14 +171,12 @@ struct ep93xx_dma_desc {
  * descriptor in the chain. When a descriptor is moved to the @active queue,
  * the first and chained descriptors are flattened into a single list.
  *
- * @chan.private holds pointer to &struct ep93xx_dma_data which contains
- * necessary channel configuration information. For memcpy channels this must
- * be %NULL.
  */
 struct ep93xx_dma_chan {
 	struct dma_chan			chan;
 	const struct ep93xx_dma_engine	*edma;
 	void __iomem			*regs;
+	struct ep93xx_dma_chan_cfg	dma_cfg;
 	int				irq;
 	struct clk			*clk;
 	struct tasklet_struct		tasklet;
@@ -216,6 +228,11 @@ struct ep93xx_dma_engine {
 	struct ep93xx_dma_chan	channels[] __counted_by(num_channels);
 };
 
+struct ep93xx_edma_data {
+	u32	id;
+	size_t	num_channels;
+};
+
 static inline struct device *chan2dev(struct ep93xx_dma_chan *edmac)
 {
 	return &edmac->chan.dev->device;
@@ -318,10 +335,9 @@ static void m2p_set_control(struct ep93xx_dma_chan *edmac, u32 control)
 
 static int m2p_hw_setup(struct ep93xx_dma_chan *edmac)
 {
-	struct ep93xx_dma_data *data = edmac->chan.private;
 	u32 control;
 
-	writel(data->port & 0xf, edmac->regs + M2P_PPALLOC);
+	writel(edmac->dma_cfg.port & 0xf, edmac->regs + M2P_PPALLOC);
 
 	control = M2P_CONTROL_CH_ERROR_INT | M2P_CONTROL_ICE
 		| M2P_CONTROL_ENABLE;
@@ -458,16 +474,15 @@ static int m2p_hw_interrupt(struct ep93xx_dma_chan *edmac)
 
 static int m2m_hw_setup(struct ep93xx_dma_chan *edmac)
 {
-	const struct ep93xx_dma_data *data = edmac->chan.private;
 	u32 control = 0;
 
-	if (!data) {
+	if (edmac->dma_cfg.dir == DMA_MEM_TO_MEM) {
 		/* This is memcpy channel, nothing to configure */
 		writel(control, edmac->regs + M2M_CONTROL);
 		return 0;
 	}
 
-	switch (data->port) {
+	switch (edmac->dma_cfg.port) {
 	case EP93XX_DMA_SSP:
 		/*
 		 * This was found via experimenting - anything less than 5
@@ -477,7 +492,7 @@ static int m2m_hw_setup(struct ep93xx_dma_chan *edmac)
 		control = (5 << M2M_CONTROL_PWSC_SHIFT);
 		control |= M2M_CONTROL_NO_HDSK;
 
-		if (data->direction == DMA_MEM_TO_DEV) {
+		if (edmac->dma_cfg.dir == DMA_MEM_TO_DEV) {
 			control |= M2M_CONTROL_DAH;
 			control |= M2M_CONTROL_TM_TX;
 			control |= M2M_CONTROL_RSS_SSPTX;
@@ -493,7 +508,7 @@ static int m2m_hw_setup(struct ep93xx_dma_chan *edmac)
 		 * This IDE part is totally untested. Values below are taken
 		 * from the EP93xx Users's Guide and might not be correct.
 		 */
-		if (data->direction == DMA_MEM_TO_DEV) {
+		if (edmac->dma_cfg.dir == DMA_MEM_TO_DEV) {
 			/* Worst case from the UG */
 			control = (3 << M2M_CONTROL_PWSC_SHIFT);
 			control |= M2M_CONTROL_DAH;
@@ -548,7 +563,6 @@ static void m2m_fill_desc(struct ep93xx_dma_chan *edmac)
 
 static void m2m_hw_submit(struct ep93xx_dma_chan *edmac)
 {
-	struct ep93xx_dma_data *data = edmac->chan.private;
 	u32 control = readl(edmac->regs + M2M_CONTROL);
 
 	/*
@@ -574,7 +588,7 @@ static void m2m_hw_submit(struct ep93xx_dma_chan *edmac)
 	control |= M2M_CONTROL_ENABLE;
 	writel(control, edmac->regs + M2M_CONTROL);
 
-	if (!data) {
+	if (edmac->dma_cfg.dir == DMA_MEM_TO_MEM) {
 		/*
 		 * For memcpy channels the software trigger must be asserted
 		 * in order to start the memcpy operation.
@@ -636,7 +650,7 @@ static int m2m_hw_interrupt(struct ep93xx_dma_chan *edmac)
 		 */
 		if (ep93xx_dma_advance_active(edmac)) {
 			m2m_fill_desc(edmac);
-			if (done && !edmac->chan.private) {
+			if (done && edmac->dma_cfg.dir == DMA_MEM_TO_MEM) {
 				/* Software trigger for memcpy channel */
 				control = readl(edmac->regs + M2M_CONTROL);
 				control |= M2M_CONTROL_START;
@@ -867,25 +881,22 @@ static dma_cookie_t ep93xx_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct ep93xx_dma_chan *edmac = to_ep93xx_dma_chan(chan);
-	struct ep93xx_dma_data *data = chan->private;
 	const char *name = dma_chan_name(chan);
 	int ret, i;
 
 	/* Sanity check the channel parameters */
 	if (!edmac->edma->m2m) {
-		if (!data)
+		if (edmac->dma_cfg.port < EP93XX_DMA_I2S1 ||
+		    edmac->dma_cfg.port > EP93XX_DMA_IRDA)
 			return -EINVAL;
-		if (data->port < EP93XX_DMA_I2S1 ||
-		    data->port > EP93XX_DMA_IRDA)
-			return -EINVAL;
-		if (data->direction != ep93xx_dma_chan_direction(chan))
+		if (edmac->dma_cfg.dir != ep93xx_dma_chan_direction(chan))
 			return -EINVAL;
 	} else {
-		if (data) {
-			switch (data->port) {
+		if (edmac->dma_cfg.dir != DMA_MEM_TO_MEM) {
+			switch (edmac->dma_cfg.port) {
 			case EP93XX_DMA_SSP:
 			case EP93XX_DMA_IDE:
-				if (!is_slave_direction(data->direction))
+				if (!is_slave_direction(edmac->dma_cfg.dir))
 					return -EINVAL;
 				break;
 			default:
@@ -894,9 +905,6 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
 		}
 	}
 
-	if (data && data->name)
-		name = data->name;
-
 	ret = clk_prepare_enable(edmac->clk);
 	if (ret)
 		return ret;
@@ -1315,35 +1323,46 @@ static void ep93xx_dma_issue_pending(struct dma_chan *chan)
 	ep93xx_dma_advance_work(to_ep93xx_dma_chan(chan));
 }
 
-static int __init ep93xx_dma_probe(struct platform_device *pdev)
+static struct ep93xx_dma_engine *ep93xx_dma_of_probe(struct platform_device *pdev)
 {
-	struct ep93xx_dma_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
+	const struct ep93xx_edma_data *data;
 	struct ep93xx_dma_engine *edma;
 	struct dma_device *dma_dev;
-	int ret, i;
+	int i;
 
-	edma = kzalloc(struct_size(edma, channels, pdata->num_channels), GFP_KERNEL);
+	data = device_get_match_data(&pdev->dev);
+	if (!data)
+		return ERR_PTR(dev_err_probe(&pdev->dev, -ENODEV, "No device match found\n"));
+
+	edma = devm_kzalloc(&pdev->dev,
+			    struct_size(edma, channels, data->num_channels),
+			    GFP_KERNEL);
 	if (!edma)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
+	edma->m2m = data->id;
+	edma->num_channels = data->num_channels;
 	dma_dev = &edma->dma_dev;
-	edma->m2m = platform_get_device_id(pdev)->driver_data;
-	edma->num_channels = pdata->num_channels;
 
 	INIT_LIST_HEAD(&dma_dev->channels);
-	for (i = 0; i < pdata->num_channels; i++) {
-		const struct ep93xx_dma_chan_data *cdata = &pdata->channels[i];
+	for (i = 0; i < edma->num_channels; i++) {
 		struct ep93xx_dma_chan *edmac = &edma->channels[i];
 
 		edmac->chan.device = dma_dev;
-		edmac->regs = cdata->base;
-		edmac->irq = cdata->irq;
+		edmac->regs = devm_platform_ioremap_resource(pdev, i);
+		if (IS_ERR(edmac->regs))
+			return edmac->regs;
+
+		edmac->irq = fwnode_irq_get(dev_fwnode(&pdev->dev), i);
+		if (edmac->irq < 0)
+			return ERR_PTR(edmac->irq);
+
 		edmac->edma = edma;
 
-		edmac->clk = clk_get(NULL, cdata->name);
+		edmac->clk = of_clk_get(np, i);
 		if (IS_ERR(edmac->clk)) {
-			dev_warn(&pdev->dev, "failed to get clock for %s\n",
-				 cdata->name);
+			dev_warn(&pdev->dev, "failed to get clock\n");
 			continue;
 		}
 
@@ -1357,6 +1376,93 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
 			      &dma_dev->channels);
 	}
 
+	return edma;
+}
+
+static bool ep93xx_m2p_dma_filter(struct dma_chan *chan, void *filter_param)
+{
+	struct ep93xx_dma_chan *echan = to_ep93xx_dma_chan(chan);
+	struct ep93xx_dma_chan_cfg *cfg = filter_param;
+
+	if (cfg->dir == ep93xx_dma_chan_direction(chan)) {
+		echan->dma_cfg = *cfg;
+		return true;
+	}
+
+	return false;
+}
+
+static struct dma_chan *ep93xx_m2p_dma_of_xlate(struct of_phandle_args *dma_spec,
+					    struct of_dma *ofdma)
+{
+	struct ep93xx_dma_engine *edma = ofdma->of_dma_data;
+	dma_cap_mask_t mask = edma->dma_dev.cap_mask;
+	struct ep93xx_dma_chan_cfg dma_cfg;
+	u8 port = dma_spec->args[0];
+	u8 direction = dma_spec->args[1];
+
+	if (port > EP93XX_DMA_IRDA)
+		return NULL;
+
+	if (direction != DMA_MEM_TO_DEV && direction != DMA_DEV_TO_MEM)
+		return NULL;
+
+	dma_cfg.port = port;
+	dma_cfg.dir = direction;
+
+	return __dma_request_channel(&mask, ep93xx_m2p_dma_filter, &dma_cfg, ofdma->of_node);
+}
+
+static bool ep93xx_m2m_dma_filter(struct dma_chan *chan, void *filter_param)
+{
+	struct ep93xx_dma_chan *echan = to_ep93xx_dma_chan(chan);
+	struct ep93xx_dma_chan_cfg *cfg = filter_param;
+
+	echan->dma_cfg = *cfg;
+
+	return true;
+}
+
+static struct dma_chan *ep93xx_m2m_dma_of_xlate(struct of_phandle_args *dma_spec,
+					    struct of_dma *ofdma)
+{
+	struct ep93xx_dma_engine *edma = ofdma->of_dma_data;
+	dma_cap_mask_t mask = edma->dma_dev.cap_mask;
+	struct ep93xx_dma_chan_cfg dma_cfg;
+	u8 port = dma_spec->args[0];
+	u8 direction = dma_spec->args[1];
+
+	dev_info(edma->dma_dev.dev, "%s: port=%d", __func__, port);
+
+	switch (port) {
+	case EP93XX_DMA_SSP:
+	case EP93XX_DMA_IDE:
+		break;
+	default:
+		return NULL;
+	}
+
+	if (direction != DMA_MEM_TO_DEV && direction != DMA_DEV_TO_MEM)
+		return NULL;
+
+	dma_cfg.port = port;
+	dma_cfg.dir = direction;
+
+	return __dma_request_channel(&mask, ep93xx_m2m_dma_filter, &dma_cfg, ofdma->of_node);
+}
+
+static int ep93xx_dma_probe(struct platform_device *pdev)
+{
+	struct ep93xx_dma_engine *edma;
+	struct dma_device *dma_dev;
+	int ret, i;
+
+	edma = ep93xx_dma_of_probe(pdev);
+	if (!edma)
+		return PTR_ERR(edma);
+
+	dma_dev = &edma->dma_dev;
+
 	dma_cap_zero(dma_dev->cap_mask);
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
 	dma_cap_set(DMA_CYCLIC, dma_dev->cap_mask);
@@ -1393,21 +1499,55 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
 	}
 
 	ret = dma_async_device_register(dma_dev);
-	if (unlikely(ret)) {
-		for (i = 0; i < edma->num_channels; i++) {
-			struct ep93xx_dma_chan *edmac = &edma->channels[i];
-			if (!IS_ERR_OR_NULL(edmac->clk))
-				clk_put(edmac->clk);
-		}
-		kfree(edma);
+	if (ret)
+		goto err_clk_disable;
+
+	if (edma->m2m) {
+		ret = of_dma_controller_register(pdev->dev.of_node, ep93xx_m2m_dma_of_xlate,
+						 edma);
 	} else {
-		dev_info(dma_dev->dev, "EP93xx M2%s DMA ready\n",
-			 edma->m2m ? "M" : "P");
+		ret = of_dma_controller_register(pdev->dev.of_node, ep93xx_m2p_dma_of_xlate,
+						 edma);
+	}
+	if (ret)
+		goto err_dma_unregister;
+
+	dev_info(dma_dev->dev, "EP93xx M2%s DMA ready\n",
+			       edma->m2m ? "M" : "P");
+
+	return 0;
+
+err_dma_unregister:
+	dma_async_device_unregister(dma_dev);
+
+err_clk_disable:
+	for (i = 0; i < edma->num_channels; i++) {
+		struct ep93xx_dma_chan *edmac = &edma->channels[i];
+
+		if (!IS_ERR_OR_NULL(edmac->clk))
+			clk_put(edmac->clk);
 	}
 
 	return ret;
 }
 
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
 static const struct platform_device_id ep93xx_dma_driver_ids[] = {
 	{ "ep93xx-dma-m2p", 0 },
 	{ "ep93xx-dma-m2m", 1 },
@@ -1417,15 +1557,12 @@ static const struct platform_device_id ep93xx_dma_driver_ids[] = {
 static struct platform_driver ep93xx_dma_driver = {
 	.driver		= {
 		.name	= "ep93xx-dma",
+		.of_match_table = ep93xx_dma_of_ids,
 	},
 	.id_table	= ep93xx_dma_driver_ids,
+	.probe		= ep93xx_dma_probe,
 };
 
-static int __init ep93xx_dma_module_init(void)
-{
-	return platform_driver_probe(&ep93xx_dma_driver, ep93xx_dma_probe);
-}
-subsys_initcall(ep93xx_dma_module_init);
-
+module_platform_driver(ep93xx_dma_driver);
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
 MODULE_DESCRIPTION("EP93xx DMA driver");
diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
index eb9805bb3fe8..7a2ef279498b 100644
--- a/include/linux/platform_data/dma-ep93xx.h
+++ b/include/linux/platform_data/dma-ep93xx.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/property.h>
 
 /*
  * M2P channels.
@@ -70,6 +71,9 @@ struct ep93xx_dma_platform_data {
 
 static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
 {
+	if (device_is_compatible(chan->device->dev, "cirrus,ep9301-dma-m2p"))
+		return true;
+
 	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");
 }
 

-- 
2.41.0


