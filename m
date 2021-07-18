Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B123CC911
	for <lists+dmaengine@lfdr.de>; Sun, 18 Jul 2021 14:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhGRMXo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 18 Jul 2021 08:23:44 -0400
Received: from aposti.net ([89.234.176.197]:37114 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232851AbhGRMXo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 18 Jul 2021 08:23:44 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        list@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] dma: jz4780: Add support for the MDMA in the JZ4760(B)
Date:   Sun, 18 Jul 2021 13:20:24 +0100
Message-Id: <20210718122024.204907-3-paul@crapouillou.net>
In-Reply-To: <20210718122024.204907-1-paul@crapouillou.net>
References: <20210718122024.204907-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The JZ4760 and JZ4760B SoCs have two regular DMA controllers with 6
channels each. They also have an extra DMA controller named MDMA
with only 2 channels, that only supports memcpy operations.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index d71bc7235959..eed505e3cce2 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -93,6 +93,7 @@
 #define JZ_SOC_DATA_PER_CHAN_PM		BIT(2)
 #define JZ_SOC_DATA_NO_DCKES_DCKEC	BIT(3)
 #define JZ_SOC_DATA_BREAK_LINKS		BIT(4)
+#define JZ_SOC_DATA_ONLY_MEMCPY		BIT(5)
 
 /**
  * struct jz4780_dma_hwdesc - descriptor structure read by the DMA controller.
@@ -896,8 +897,10 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	dd = &jzdma->dma_device;
 
 	dma_cap_set(DMA_MEMCPY, dd->cap_mask);
-	dma_cap_set(DMA_SLAVE, dd->cap_mask);
-	dma_cap_set(DMA_CYCLIC, dd->cap_mask);
+	if (!(soc_data->flags & JZ_SOC_DATA_ONLY_MEMCPY)) {
+		dma_cap_set(DMA_SLAVE, dd->cap_mask);
+		dma_cap_set(DMA_CYCLIC, dd->cap_mask);
+	}
 
 	dd->dev = dev;
 	dd->copy_align = DMAENGINE_ALIGN_4_BYTES;
@@ -1018,12 +1021,25 @@ static const struct jz4780_dma_soc_data jz4760_dma_soc_data = {
 	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC,
 };
 
+static const struct jz4780_dma_soc_data jz4760_mdma_soc_data = {
+	.nb_channels = 2,
+	.transfer_ord_max = 6,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC |
+		 JZ_SOC_DATA_ONLY_MEMCPY,
+};
+
 static const struct jz4780_dma_soc_data jz4760b_dma_soc_data = {
 	.nb_channels = 5,
 	.transfer_ord_max = 6,
 	.flags = JZ_SOC_DATA_PER_CHAN_PM,
 };
 
+static const struct jz4780_dma_soc_data jz4760b_mdma_soc_data = {
+	.nb_channels = 2,
+	.transfer_ord_max = 6,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_ONLY_MEMCPY,
+};
+
 static const struct jz4780_dma_soc_data jz4770_dma_soc_data = {
 	.nb_channels = 6,
 	.transfer_ord_max = 6,
@@ -1052,7 +1068,9 @@ static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = &jz4740_dma_soc_data },
 	{ .compatible = "ingenic,jz4725b-dma", .data = &jz4725b_dma_soc_data },
 	{ .compatible = "ingenic,jz4760-dma", .data = &jz4760_dma_soc_data },
+	{ .compatible = "ingenic,jz4760-mdma", .data = &jz4760_mdma_soc_data },
 	{ .compatible = "ingenic,jz4760b-dma", .data = &jz4760b_dma_soc_data },
+	{ .compatible = "ingenic,jz4760b-mdma", .data = &jz4760b_mdma_soc_data },
 	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
 	{ .compatible = "ingenic,x1000-dma", .data = &x1000_dma_soc_data },
-- 
2.30.2

