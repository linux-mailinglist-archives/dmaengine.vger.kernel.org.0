Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97074845FE
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jan 2022 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiADQft (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jan 2022 11:35:49 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:51358 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229984AbiADQft (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Jan 2022 11:35:49 -0500
X-IronPort-AV: E=Sophos;i="5.88,261,1635174000"; 
   d="scan'208";a="106011213"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jan 2022 01:35:48 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 85852409E465;
        Wed,  5 Jan 2022 01:35:46 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dmaengine: nbpfaxi: Use platform_get_irq_optional() to get the interrupt
Date:   Tue,  4 Jan 2022 16:35:17 +0000
Message-Id: <20220104163519.21929-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220104163519.21929-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220104163519.21929-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_optional().

There are no non-DT users for this driver so interrupt range
(irq_res->start-irq_res->end) is no longer required and with DT we will
be sure it will be a single IRQ resource for each index.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Updated the check to consider 0 as no IRQ
---
 drivers/dma/nbpfaxi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 9c52c57919c6..a7063e9cd551 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1294,7 +1294,7 @@ static int nbpf_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct nbpf_device *nbpf;
 	struct dma_device *dma_dev;
-	struct resource *iomem, *irq_res;
+	struct resource *iomem;
 	const struct nbpf_config *cfg;
 	int num_channels;
 	int ret, irq, eirq, i;
@@ -1335,13 +1335,11 @@ static int nbpf_probe(struct platform_device *pdev)
 	nbpf->config = cfg;
 
 	for (i = 0; irqs < ARRAY_SIZE(irqbuf); i++) {
-		irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!irq_res)
-			break;
-
-		for (irq = irq_res->start; irq <= irq_res->end;
-		     irq++, irqs++)
-			irqbuf[irqs] = irq;
+		irq = platform_get_irq_optional(pdev, i);
+		if (irq < 0 && irq != -ENXIO)
+			return irq;
+		if (irq > 0)
+			irqbuf[irqs++] = irq;
 	}
 
 	/*
-- 
2.17.1

