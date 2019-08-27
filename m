Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D387B9E68E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2019 13:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfH0LMN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Aug 2019 07:12:13 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:44344 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727058AbfH0LMN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Aug 2019 07:12:13 -0400
X-IronPort-AV: E=Sophos;i="5.64,436,1559487600"; 
   d="scan'208";a="25050329"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Aug 2019 20:12:11 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A866A40041AB;
        Tue, 27 Aug 2019 20:12:11 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/2] dmaengine: rcar-dmac: Use devm_platform_ioremap_resource()
Date:   Tue, 27 Aug 2019 20:10:31 +0900
Message-Id: <1566904231-25486-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566904231-25486-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1566904231-25486-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch uses devm_platform_ioremap_resource() instead of
using platform_get_resource() and devm_ioremap_resource() together
to simplify.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 1ff6d81..779b715 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1814,7 +1814,6 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	struct dma_device *engine;
 	struct rcar_dmac *dmac;
 	const struct rcar_dmac_of_data *data;
-	struct resource *mem;
 	unsigned int i;
 	int ret;
 
@@ -1855,8 +1854,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Request resources. */
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmac->iomem = devm_ioremap_resource(&pdev->dev, mem);
+	dmac->iomem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dmac->iomem))
 		return PTR_ERR(dmac->iomem);
 
-- 
2.7.4

