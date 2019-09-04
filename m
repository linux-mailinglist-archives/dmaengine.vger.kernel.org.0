Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDAA7DC1
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 10:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfIDIYm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 04:24:42 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:54118 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729394AbfIDIYl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Sep 2019 04:24:41 -0400
X-IronPort-AV: E=Sophos;i="5.64,465,1559487600"; 
   d="scan'208";a="25713448"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Sep 2019 17:24:39 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2D4224009641;
        Wed,  4 Sep 2019 17:24:39 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 1/3] dmaengine: rcar-dmac: Use of_data values instead of a macro
Date:   Wed,  4 Sep 2019 17:24:36 +0900
Message-Id: <1567585478-23902-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567585478-23902-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1567585478-23902-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since we will have changed memory mapping of the DMAC in the future,
this patch uses of_data values instead of a macro to calculate
each channel's base offset.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 3993ab6..74996a0 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -210,12 +210,20 @@ struct rcar_dmac {
 
 #define to_rcar_dmac(d)		container_of(d, struct rcar_dmac, engine)
 
+/*
+ * struct rcar_dmac_of_data - This driver's OF data
+ * @chan_offset_base: DMAC channels base offset
+ * @chan_offset_stride: DMAC channels offset stride
+ */
+struct rcar_dmac_of_data {
+	u32 chan_offset_base;
+	u32 chan_offset_stride;
+};
+
 /* -----------------------------------------------------------------------------
  * Registers
  */
 
-#define RCAR_DMAC_CHAN_OFFSET(i)	(0x8000 + 0x80 * (i))
-
 #define RCAR_DMAISTA			0x0020
 #define RCAR_DMASEC			0x0030
 #define RCAR_DMAOR			0x0060
@@ -1726,6 +1734,7 @@ static const struct dev_pm_ops rcar_dmac_pm = {
 
 static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 				struct rcar_dmac_chan *rchan,
+				const struct rcar_dmac_of_data *data,
 				unsigned int index)
 {
 	struct platform_device *pdev = to_platform_device(dmac->dev);
@@ -1735,7 +1744,8 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	int ret;
 
 	rchan->index = index;
-	rchan->iomem = dmac->iomem + RCAR_DMAC_CHAN_OFFSET(index);
+	rchan->iomem = dmac->iomem + data->chan_offset_base +
+		       data->chan_offset_stride * index;
 	rchan->mid_rid = -EINVAL;
 
 	spin_lock_init(&rchan->lock);
@@ -1813,10 +1823,15 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		DMA_SLAVE_BUSWIDTH_32_BYTES | DMA_SLAVE_BUSWIDTH_64_BYTES;
 	struct dma_device *engine;
 	struct rcar_dmac *dmac;
+	const struct rcar_dmac_of_data *data;
 	struct resource *mem;
 	unsigned int i;
 	int ret;
 
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
+		return -EINVAL;
+
 	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
 	if (!dmac)
 		return -ENOMEM;
@@ -1901,7 +1916,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		if (!(dmac->channels_mask & BIT(i)))
 			continue;
 
-		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], i);
+		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], data, i);
 		if (ret < 0)
 			goto error;
 	}
@@ -1948,8 +1963,16 @@ static void rcar_dmac_shutdown(struct platform_device *pdev)
 	rcar_dmac_stop_all_chan(dmac);
 }
 
+static const struct rcar_dmac_of_data rcar_dmac_data = {
+	.chan_offset_base = 0x8000,
+	.chan_offset_stride = 0x80,
+};
+
 static const struct of_device_id rcar_dmac_of_ids[] = {
-	{ .compatible = "renesas,rcar-dmac", },
+	{
+		.compatible = "renesas,rcar-dmac",
+		.data = &rcar_dmac_data,
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rcar_dmac_of_ids);
-- 
2.7.4

