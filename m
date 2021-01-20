Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA12FD02F
	for <lists+dmaengine@lfdr.de>; Wed, 20 Jan 2021 13:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbhATMf2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jan 2021 07:35:28 -0500
Received: from aposti.net ([89.234.176.197]:50458 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388391AbhATKzp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Jan 2021 05:55:45 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] dma: jz4780: Add support for the JZ4760(B)
Date:   Wed, 20 Jan 2021 10:53:22 +0000
Message-Id: <20210120105322.16116-2-paul@crapouillou.net>
In-Reply-To: <20210120105322.16116-1-paul@crapouillou.net>
References: <20210120105322.16116-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for the JZ4760 and JZ4760B SoCs.

Both SoCs have only 5 DMA channels per chip. The JZ4760B introduced the
DCKES/DCKEC registers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-jz4780.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 612d353648cf..ebee94dbd630 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1004,6 +1004,18 @@ static const struct jz4780_dma_soc_data jz4725b_dma_soc_data = {
 		 JZ_SOC_DATA_BREAK_LINKS,
 };
 
+static const struct jz4780_dma_soc_data jz4760_dma_soc_data = {
+	.nb_channels = 5,
+	.transfer_ord_max = 6,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC,
+};
+
+static const struct jz4780_dma_soc_data jz4760b_dma_soc_data = {
+	.nb_channels = 5,
+	.transfer_ord_max = 6,
+	.flags = JZ_SOC_DATA_PER_CHAN_PM,
+};
+
 static const struct jz4780_dma_soc_data jz4770_dma_soc_data = {
 	.nb_channels = 6,
 	.transfer_ord_max = 6,
@@ -1031,6 +1043,8 @@ static const struct jz4780_dma_soc_data x1830_dma_soc_data = {
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = &jz4740_dma_soc_data },
 	{ .compatible = "ingenic,jz4725b-dma", .data = &jz4725b_dma_soc_data },
+	{ .compatible = "ingenic,jz4760-dma", .data = &jz4760_dma_soc_data },
+	{ .compatible = "ingenic,jz4760b-dma", .data = &jz4760b_dma_soc_data },
 	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
 	{ .compatible = "ingenic,x1000-dma", .data = &x1000_dma_soc_data },
-- 
2.29.2

