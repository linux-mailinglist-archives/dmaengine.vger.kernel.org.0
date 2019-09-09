Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB97EAD329
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2019 08:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfIIGfj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Sep 2019 02:35:39 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:12578 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729708AbfIIGfj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Sep 2019 02:35:39 -0400
X-IronPort-AV: E=Sophos;i="5.64,483,1559487600"; 
   d="scan'208";a="26091410"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Sep 2019 15:35:35 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B1B6141A59F7;
        Mon,  9 Sep 2019 15:35:35 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vinod.koul@intel.com
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 3/4] dmaengine: rcar-dmac: Use devm_platform_ioremap_resource()
Date:   Mon,  9 Sep 2019 15:34:51 +0900
Message-Id: <1568010892-17606-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568010892-17606-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1568010892-17606-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch uses devm_platform_ioremap_resource() instead of
using platform_get_resource() and devm_ioremap_resource() together
to simplify.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 74996a0..542786d 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1824,7 +1824,6 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	struct dma_device *engine;
 	struct rcar_dmac *dmac;
 	const struct rcar_dmac_of_data *data;
-	struct resource *mem;
 	unsigned int i;
 	int ret;
 
@@ -1863,8 +1862,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Request resources. */
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmac->iomem = devm_ioremap_resource(&pdev->dev, mem);
+	dmac->iomem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dmac->iomem))
 		return PTR_ERR(dmac->iomem);
 
-- 
2.7.4

