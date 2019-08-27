Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 536AA9E68F
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2019 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfH0LMO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Aug 2019 07:12:14 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:25612 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbfH0LMO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Aug 2019 07:12:14 -0400
X-IronPort-AV: E=Sophos;i="5.64,436,1559487600"; 
   d="scan'208";a="24831576"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Aug 2019 20:12:11 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9CAD44005E14;
        Tue, 27 Aug 2019 20:12:11 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] dmaengine: rcar-dmac: Use of_data values instead of a macro
Date:   Tue, 27 Aug 2019 20:10:30 +0900
Message-Id: <1566904231-25486-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566904231-25486-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1566904231-25486-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since we will have changed memory mapping of the DMAC in the future,
this patch uses of_data values instead of a macro to calculate
each channel's base offset.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index eb6f231..1ff6d81 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -208,12 +208,20 @@ struct rcar_dmac {
 
 #define to_rcar_dmac(d)		container_of(d, struct rcar_dmac, engine)
 
+/*
+ * struct rcar_dmac_of_data - This driver's OF data
+ * @chan_offset_base: DMAC channels base offset
+ * @chan_offset_coefficient: DMAC channels offset coefficient
+ */
+struct rcar_dmac_of_data {
+	u32 chan_offset_base;
+	u32 chan_offset_coefficient;
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
@@ -1721,6 +1729,7 @@ static const struct dev_pm_ops rcar_dmac_pm = {
 
 static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 				struct rcar_dmac_chan *rchan,
+				const struct rcar_dmac_of_data *data,
 				unsigned int index)
 {
 	struct platform_device *pdev = to_platform_device(dmac->dev);
@@ -1730,7 +1739,8 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	int ret;
 
 	rchan->index = index;
-	rchan->iomem = dmac->iomem + RCAR_DMAC_CHAN_OFFSET(index);
+	rchan->iomem = dmac->iomem + data->chan_offset_base +
+		       data->chan_offset_coefficient * index;
 	rchan->mid_rid = -EINVAL;
 
 	spin_lock_init(&rchan->lock);
@@ -1803,10 +1813,15 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	unsigned int channels_offset = 0;
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
@@ -1890,7 +1905,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&engine->channels);
 
 	for (i = 0; i < dmac->n_channels; ++i) {
-		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i],
+		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], data,
 					   i + channels_offset);
 		if (ret < 0)
 			goto error;
@@ -1938,8 +1953,16 @@ static void rcar_dmac_shutdown(struct platform_device *pdev)
 	rcar_dmac_stop_all_chan(dmac);
 }
 
+static const struct rcar_dmac_of_data rcar_dmac_data = {
+	.chan_offset_base = 0x8000,
+	.chan_offset_coefficient = 0x80,
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

