Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295FDC9713
	for <lists+dmaengine@lfdr.de>; Thu,  3 Oct 2019 05:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfJCD6K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Oct 2019 23:58:10 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:23587 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728740AbfJCD6J (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Oct 2019 23:58:09 -0400
X-IronPort-AV: E=Sophos;i="5.67,250,1566831600"; 
   d="scan'208";a="27948079"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Oct 2019 12:58:06 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AAF76400D4F3;
        Thu,  3 Oct 2019 12:58:06 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 2/3] dmaengine: rcar-dmac: Use devm_platform_ioremap_resource()
Date:   Thu,  3 Oct 2019 12:58:05 +0900
Message-Id: <1570075086-25126-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570075086-25126-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1570075086-25126-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch uses devm_platform_ioremap_resource() instead of
using platform_get_resource() and devm_ioremap_resource() together
to simplify.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
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

