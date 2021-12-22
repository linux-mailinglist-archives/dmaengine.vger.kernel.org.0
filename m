Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E40647D4FB
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbhLVQP6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 11:15:58 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:30791 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241629AbhLVQPv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Dec 2021 11:15:51 -0500
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000"; 
   d="scan'208";a="104850912"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Dec 2021 01:15:50 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 07A0440A14AC;
        Thu, 23 Dec 2021 01:15:47 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/3] dmaengine: mediatek-cqdma: Use platform_get_irq() to get the interrupt
Date:   Wed, 22 Dec 2021 16:15:34 +0000
Message-Id: <20211222161534.1263-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222161534.1263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222161534.1263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/mediatek/mtk-cqdma.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
index 41ef9f15d3d5..f8847c48ba03 100644
--- a/drivers/dma/mediatek/mtk-cqdma.c
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -751,7 +751,6 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 	struct mtk_cqdma_device *cqdma;
 	struct mtk_cqdma_vchan *vc;
 	struct dma_device *dd;
-	struct resource *res;
 	int err;
 	u32 i;
 
@@ -824,13 +823,10 @@ static int mtk_cqdma_probe(struct platform_device *pdev)
 			return PTR_ERR(cqdma->pc[i]->base);
 
 		/* allocate IRQ resource */
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!res) {
-			dev_err(&pdev->dev, "No irq resource for %s\n",
-				dev_name(&pdev->dev));
-			return -EINVAL;
-		}
-		cqdma->pc[i]->irq = res->start;
+		err = platform_get_irq(pdev, i);
+		if (err < 0)
+			return err;
+		cqdma->pc[i]->irq = err;
 
 		err = devm_request_irq(&pdev->dev, cqdma->pc[i]->irq,
 				       mtk_cqdma_irq, 0, dev_name(&pdev->dev),
-- 
2.17.1

