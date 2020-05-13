Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222E31D06D9
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2020 08:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgEMGEQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 May 2020 02:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726220AbgEMGEQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 May 2020 02:04:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD477C061A0C
        for <dmaengine@vger.kernel.org>; Tue, 12 May 2020 23:04:15 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jYkV2-0000e1-27; Wed, 13 May 2020 08:04:12 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jYkUx-0004sD-QX; Wed, 13 May 2020 08:04:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Robin Gong <yibin.gong@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] dmaengine: imx-sdma: initialize all script addresses
Date:   Wed, 13 May 2020 08:04:05 +0200
Message-Id: <20200513060405.18685-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The script addresses array increases with each new version. The driver
initializes the array to -EINVAL initially, but only up to the size
of the v1 array. Initialize the additional addresses for the newer
versions as well. Without this unitialized values of the newer arrays
are treated as valid.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 01422e721b26e..2ca79357f57dc 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2080,7 +2080,7 @@ static int sdma_probe(struct platform_device *pdev)
 
 	/* initially no scripts available */
 	saddr_arr = (s32 *)sdma->script_addrs;
-	for (i = 0; i < SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1; i++)
+	for (i = 0; i < sizeof(*sdma->script_addrs) / sizeof(s32); i++)
 		saddr_arr[i] = -EINVAL;
 
 	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
-- 
2.26.2

