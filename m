Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236E93D8B16
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 11:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhG1JsF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 05:48:05 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:47511 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhG1JsF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Jul 2021 05:48:05 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id C6C9DCEE03;
        Wed, 28 Jul 2021 09:46:39 +0000 (UTC)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DB5D4C0010;
        Wed, 28 Jul 2021 09:46:16 +0000 (UTC)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dmaengine: at_xdmac: use platform_driver_register
Date:   Wed, 28 Jul 2021 11:46:07 +0200
Message-Id: <20210728094607.50589-1-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When using SCMI clocks, the clocks are probed later than subsys initcall
level. This driver uses platform_driver_probe which is not compatible with
deferred probing and won't be probed again later if probe function fails
due to clocks not being available at that time.

This patch replaces the use of platform_driver_probe with
platform_driver_register which will allow probing the driver later again
when clocks will be available.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/dma/at_xdmac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 64a52bf4d737..ab78e0f6afd7 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2240,10 +2240,16 @@ static struct platform_driver at_xdmac_driver = {
 
 static int __init at_xdmac_init(void)
 {
-	return platform_driver_probe(&at_xdmac_driver, at_xdmac_probe);
+	return platform_driver_register(&at_xdmac_driver);
 }
 subsys_initcall(at_xdmac_init);
 
+static void __exit at_xdmac_exit(void)
+{
+	platform_driver_unregister(&at_xdmac_driver);
+}
+module_exit(at_xdmac_exit);
+
 MODULE_DESCRIPTION("Atmel Extended DMA Controller driver");
 MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@atmel.com>");
 MODULE_LICENSE("GPL");
-- 
2.32.0

