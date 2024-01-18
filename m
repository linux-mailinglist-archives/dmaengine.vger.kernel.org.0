Return-Path: <dmaengine+bounces-743-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037AC83146D
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 09:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AD81F24827
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jan 2024 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72151CAB6;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK9+8388"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7427134BC;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566179; cv=none; b=m7YTF0eKo9yCEz6tWHTTOjX1nqd4vClrBLhcEPXNngmgZMOgNsZvAVHywxRIA2M9rgsYeDWbTfGutabWGqHVQm1nRqSNBhTReYUNRTmdb2Ly7scmVJWVacMqojZkwbnBtUvnFN113ZI0izRLWAb027JTZDZpu3xQrQqwchArSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566179; c=relaxed/simple;
	bh=cW4t/c/65tahKXf158GKvsree3NbkcrxqShNSYwKYTs=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=jtPdNB5dDTtFufiMtCl0iM+6ksrk8JfHWHRwgIwEhiYao3tZPbVgxxgl6EcKEHGaOMDUsTi98YLIOvBLTCoLVSFUAmB7ag6EzF2HXcMkUqEEUBxDOTmu+rupB3yPTIZnYmmRQwIRsvVV5PkVRtgHfcBffXdXDnk3TgYF4hdAfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK9+8388; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20F3AC3277F;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566179;
	bh=cW4t/c/65tahKXf158GKvsree3NbkcrxqShNSYwKYTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jK9+83882bgt7C7dnyfaXuJutITRYIEkZSJdZ4RJrJ3egLhXvsjL0rfJcsz07qDOH
	 qGYsrBJIyzZoqGYtaY5IdvylXlKGmSPn4dAiuZt4G4ERxv0cS+aZGSsaf7hGs77EKz
	 h55ZQyBAjoOK9gsoDoD8InMwWD0RVIaVBiFn1eDy03dQa7w7lx1MHclIi8KF0rPmPP
	 DdB7UZb6RqKLJGSFa7vGFNbAdi97Kxm14MKsgso0JucGcMAZdxDUNNBzzXj4rcW5od
	 avNo3kc4B2DbF97u6h1rf4GPTU6N7kOILZ6U5+m88lKfgsSTDyPN24OswbwXF3yuH9
	 86m39CGSFNrHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F433C47DB1;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:20:53 +0300
Subject: [PATCH v7 10/39] dma: cirrus: Convert to DT for Cirrus EP93xx
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-10-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Vinod Koul <vkoul@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=14536;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=mdpNGwpBBy5oSdaMUbGhAYg7Ew2XhahdNmCTMAvwI3A=; =?utf-8?q?b=3Doikq0GGYlQOI?=
 =?utf-8?q?s8YwNcpe9xFD0Hsq6VxFNPi0ZDS6gXJGVuPIayD7r+ODERsaIDdt9ACr/R0StKvT?=
 DnFlTjRmByKFJcOXPDUOh+O5iRQS5QEHLouyaBxWqRXmnnVUL923
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Convert Cirrus EP93xx DMA to device tree usage:

- add OF ID match table with data
- add of_probe for device tree
- add xlate for m2m/m2p
- drop subsys_initcall code
- drop platform probe
- drop platform structs usage

From now on it only supports device tree probing.

Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/dma/ep93xx_dma.c                 | 239 ++++++++++++++++++++++++-------
 include/linux/platform_data/dma-ep93xx.h |   6 +
 2 files changed, 191 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index d6c60635e90d..a214680a837d 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -20,6 +20,8 @@
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_dma.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -104,6 +106,11 @@
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
@@ -129,11 +136,17 @@ struct ep93xx_dma_desc {
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
@@ -157,14 +170,12 @@ struct ep93xx_dma_desc {
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
@@ -216,6 +227,11 @@ struct ep93xx_dma_engine {
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
@@ -318,10 +334,9 @@ static void m2p_set_control(struct ep93xx_dma_chan *edmac, u32 control)
 
 static int m2p_hw_setup(struct ep93xx_dma_chan *edmac)
 {
-	struct ep93xx_dma_data *data = edmac->chan.private;
 	u32 control;
 
-	writel(data->port & 0xf, edmac->regs + M2P_PPALLOC);
+	writel(edmac->dma_cfg.port & 0xf, edmac->regs + M2P_PPALLOC);
 
 	control = M2P_CONTROL_CH_ERROR_INT | M2P_CONTROL_ICE
 		| M2P_CONTROL_ENABLE;
@@ -458,16 +473,15 @@ static int m2p_hw_interrupt(struct ep93xx_dma_chan *edmac)
 
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
@@ -477,7 +491,7 @@ static int m2m_hw_setup(struct ep93xx_dma_chan *edmac)
 		control = (5 << M2M_CONTROL_PWSC_SHIFT);
 		control |= M2M_CONTROL_NO_HDSK;
 
-		if (data->direction == DMA_MEM_TO_DEV) {
+		if (edmac->dma_cfg.dir == DMA_MEM_TO_DEV) {
 			control |= M2M_CONTROL_DAH;
 			control |= M2M_CONTROL_TM_TX;
 			control |= M2M_CONTROL_RSS_SSPTX;
@@ -493,7 +507,7 @@ static int m2m_hw_setup(struct ep93xx_dma_chan *edmac)
 		 * This IDE part is totally untested. Values below are taken
 		 * from the EP93xx Users's Guide and might not be correct.
 		 */
-		if (data->direction == DMA_MEM_TO_DEV) {
+		if (edmac->dma_cfg.dir == DMA_MEM_TO_DEV) {
 			/* Worst case from the UG */
 			control = (3 << M2M_CONTROL_PWSC_SHIFT);
 			control |= M2M_CONTROL_DAH;
@@ -548,7 +562,6 @@ static void m2m_fill_desc(struct ep93xx_dma_chan *edmac)
 
 static void m2m_hw_submit(struct ep93xx_dma_chan *edmac)
 {
-	struct ep93xx_dma_data *data = edmac->chan.private;
 	u32 control = readl(edmac->regs + M2M_CONTROL);
 
 	/*
@@ -574,7 +587,7 @@ static void m2m_hw_submit(struct ep93xx_dma_chan *edmac)
 	control |= M2M_CONTROL_ENABLE;
 	writel(control, edmac->regs + M2M_CONTROL);
 
-	if (!data) {
+	if (edmac->dma_cfg.dir == DMA_MEM_TO_MEM) {
 		/*
 		 * For memcpy channels the software trigger must be asserted
 		 * in order to start the memcpy operation.
@@ -636,7 +649,7 @@ static int m2m_hw_interrupt(struct ep93xx_dma_chan *edmac)
 		 */
 		if (ep93xx_dma_advance_active(edmac)) {
 			m2m_fill_desc(edmac);
-			if (done && !edmac->chan.private) {
+			if (done && edmac->dma_cfg.dir == DMA_MEM_TO_MEM) {
 				/* Software trigger for memcpy channel */
 				control = readl(edmac->regs + M2M_CONTROL);
 				control |= M2M_CONTROL_START;
@@ -867,25 +880,22 @@ static dma_cookie_t ep93xx_dma_tx_submit(struct dma_async_tx_descriptor *tx)
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
@@ -894,9 +904,6 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
 		}
 	}
 
-	if (data && data->name)
-		name = data->name;
-
 	ret = clk_prepare_enable(edmac->clk);
 	if (ret)
 		return ret;
@@ -1315,36 +1322,53 @@ static void ep93xx_dma_issue_pending(struct dma_chan *chan)
 	ep93xx_dma_advance_work(to_ep93xx_dma_chan(chan));
 }
 
-static int __init ep93xx_dma_probe(struct platform_device *pdev)
+static struct ep93xx_dma_engine *ep93xx_dma_of_probe(struct platform_device *pdev)
 {
-	struct ep93xx_dma_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	const struct ep93xx_edma_data *data;
+	struct device *dev = &pdev->dev;
 	struct ep93xx_dma_engine *edma;
 	struct dma_device *dma_dev;
-	int ret, i;
+	char dma_clk_name[5];
+	int i;
 
-	edma = kzalloc(struct_size(edma, channels, pdata->num_channels), GFP_KERNEL);
+	data = device_get_match_data(dev);
+	if (!data)
+		return ERR_PTR(dev_err_probe(dev, -ENODEV, "No device match found\n"));
+
+	edma = devm_kzalloc(dev, struct_size(edma, channels, data->num_channels),
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
+		edmac->irq = fwnode_irq_get(dev_fwnode(dev), i);
+		if (edmac->irq < 0)
+			return ERR_PTR(edmac->irq);
+
 		edmac->edma = edma;
 
-		edmac->clk = clk_get(NULL, cdata->name);
+		if (edma->m2m)
+			sprintf(dma_clk_name, "m2m%u", i);
+		else
+			sprintf(dma_clk_name, "m2p%u", i);
+
+		edmac->clk = devm_clk_get(dev, dma_clk_name);
 		if (IS_ERR(edmac->clk)) {
-			dev_warn(&pdev->dev, "failed to get clock for %s\n",
-				 cdata->name);
-			continue;
+			dev_err_probe(dev, PTR_ERR(edmac->clk), 
+				      "no %s clock found\n", dma_clk_name);
+			return ERR_CAST(edmac->clk);
 		}
 
 		spin_lock_init(&edmac->lock);
@@ -1357,6 +1381,90 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
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
+	if (cfg->dir != ep93xx_dma_chan_direction(chan))
+		return false;
+
+	echan->dma_cfg = *cfg;
+	return true;
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
+	if (!is_slave_direction(direction))
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
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	switch (port) {
+	case EP93XX_DMA_SSP:
+	case EP93XX_DMA_IDE:
+		break;
+	default:
+		return NULL;
+	}
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
+	int ret;
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
@@ -1393,21 +1501,46 @@ static int __init ep93xx_dma_probe(struct platform_device *pdev)
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
+		return ret;
+
+	if (edma->m2m) {
+		ret = of_dma_controller_register(pdev->dev.of_node, ep93xx_m2m_dma_of_xlate,
+						 edma);
 	} else {
-		dev_info(dma_dev->dev, "EP93xx M2%s DMA ready\n",
-			 edma->m2m ? "M" : "P");
+		ret = of_dma_controller_register(pdev->dev.of_node, ep93xx_m2p_dma_of_xlate,
+						 edma);
 	}
+	if (ret)
+		goto err_dma_unregister;
+
+	dev_info(dma_dev->dev, "EP93xx M2%s DMA ready\n", edma->m2m ? "M" : "P");
+
+	return 0;
+
+err_dma_unregister:
+	dma_async_device_unregister(dma_dev);
 
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
@@ -1417,15 +1550,13 @@ static const struct platform_device_id ep93xx_dma_driver_ids[] = {
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
+module_platform_driver(ep93xx_dma_driver);
 
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
 MODULE_DESCRIPTION("EP93xx DMA driver");
diff --git a/include/linux/platform_data/dma-ep93xx.h b/include/linux/platform_data/dma-ep93xx.h
index eb9805bb3fe8..9ec5cdd5a1eb 100644
--- a/include/linux/platform_data/dma-ep93xx.h
+++ b/include/linux/platform_data/dma-ep93xx.h
@@ -3,8 +3,11 @@
 #define __ASM_ARCH_DMA_H
 
 #include <linux/types.h>
+#include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/property.h>
+#include <linux/string.h>
 
 /*
  * M2P channels.
@@ -70,6 +73,9 @@ struct ep93xx_dma_platform_data {
 
 static inline bool ep93xx_dma_chan_is_m2p(struct dma_chan *chan)
 {
+	if (device_is_compatible(chan->device->dev, "cirrus,ep9301-dma-m2p"))
+		return true;
+
 	return !strcmp(dev_name(chan->device->dev), "ep93xx-dma-m2p");
 }
 

-- 
2.41.0


