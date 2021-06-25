Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07583B3FE8
	for <lists+dmaengine@lfdr.de>; Fri, 25 Jun 2021 11:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFYJEY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Jun 2021 05:04:24 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:55047 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhFYJEX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Jun 2021 05:04:23 -0400
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 930A510000E;
        Fri, 25 Jun 2021 09:02:01 +0000 (UTC)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: at_xdmac: use module_platform_driver
Date:   Fri, 25 Jun 2021 11:00:42 +0200
Message-Id: <20210625090042.17085-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver was previously probed with platform_driver_probe. This does
not allow the driver to be probed again later if probe function
returns -EPROBE_DEFER. This patch replace the use of
platform_driver_probe with module_platform_driver which allows that.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/dma/at_xdmac.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 64a52bf4d737..109a4c0895f4 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2238,11 +2238,7 @@ static struct platform_driver at_xdmac_driver = {
 	}
 };
 
-static int __init at_xdmac_init(void)
-{
-	return platform_driver_probe(&at_xdmac_driver, at_xdmac_probe);
-}
-subsys_initcall(at_xdmac_init);
+module_platform_driver(at_xdmac_driver);
 
 MODULE_DESCRIPTION("Atmel Extended DMA Controller driver");
 MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@atmel.com>");
-- 
2.32.0

