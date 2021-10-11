Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A619642923D
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 16:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhJKOmo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 10:42:44 -0400
Received: from aposti.net ([89.234.176.197]:46790 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242408AbhJKOlJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 Oct 2021 10:41:09 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/5] dmaengine: jz4780: Add support for the MDMA and BDMA in the JZ4760(B)
Date:   Mon, 11 Oct 2021 16:36:51 +0200
Message-Id: <20211011143652.51976-5-paul@crapouillou.net>
In-Reply-To: <20211011143652.51976-1-paul@crapouillou.net>
References: <20211011143652.51976-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The JZ4760 and JZ4760B SoCs have two regular DMA controllers with 6
channels each. They also have an extra DMA controller named MDMA
with only 2 channels, that only supports memcpy operations, and one
named BDMA with only 3 channels, that is mostly used for transfers
between memories and the BCH controller.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index d71bc7235959..4d62e24ebff9 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1018,12 +1018,36 @@ static const struct jz4780_dma_soc_data jz4760_dma_soc_data = {
 	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC,
 };
 
+static const struct jz4780_dma_soc_data jz4760_mdma_soc_data = {
+	.nb_channels = 2,
+	.transfer_ord_max = 6,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC,
+};
+
+static const struct jz4780_dma_soc_data jz4760_bdma_soc_data = {
+	.nb_channels = 3,
+	.transfer_ord_max = 6,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC,
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
+	.flags = JZ_SOC_DATA_PER_CHAN_PM,
+};
+
+static const struct jz4780_dma_soc_data jz4760b_bdma_soc_data = {
+	.nb_channels = 3,
+	.transfer_ord_max = 6,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM,
+};
+
 static const struct jz4780_dma_soc_data jz4770_dma_soc_data = {
 	.nb_channels = 6,
 	.transfer_ord_max = 6,
@@ -1052,7 +1076,11 @@ static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = &jz4740_dma_soc_data },
 	{ .compatible = "ingenic,jz4725b-dma", .data = &jz4725b_dma_soc_data },
 	{ .compatible = "ingenic,jz4760-dma", .data = &jz4760_dma_soc_data },
+	{ .compatible = "ingenic,jz4760-mdma", .data = &jz4760_mdma_soc_data },
+	{ .compatible = "ingenic,jz4760-bdma", .data = &jz4760_bdma_soc_data },
 	{ .compatible = "ingenic,jz4760b-dma", .data = &jz4760b_dma_soc_data },
+	{ .compatible = "ingenic,jz4760b-mdma", .data = &jz4760b_mdma_soc_data },
+	{ .compatible = "ingenic,jz4760b-bdma", .data = &jz4760b_bdma_soc_data },
 	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
 	{ .compatible = "ingenic,x1000-dma", .data = &x1000_dma_soc_data },
-- 
2.33.0

