Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881751359F4
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jan 2020 14:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgAINUB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jan 2020 08:20:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40478 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgAINUB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jan 2020 08:20:01 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ipXj7-0000gk-Fu; Thu, 09 Jan 2020 13:19:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] dmaengine: ti: omap-dma: don't allow a null od->plat pointer to be dereferenced
Date:   Thu,  9 Jan 2020 13:19:53 +0000
Message-Id: <20200109131953.157154-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when the call to dev_get_platdata returns null the driver issues
a warning and then later dereferences the null pointer.  Avoid this issue
by returning -ENODEV errror rather when the platform data is null and
change the warning to an appropriate error message.

Addresses-Coverity: ("Dereference after null check")
Fixes: 211010aeb097 ("dmaengine: ti: omap-dma: Pass sdma auxdata to driver and use it")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: return -ENODEV and change warning to an error message as suggested by
    Peter Ujfalusi.
---
 drivers/dma/ti/omap-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index fc8f7b2fc7b3..a93515015dce 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1658,8 +1658,10 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (conf) {
 		od->cfg = conf;
 		od->plat = dev_get_platdata(&pdev->dev);
-		if (!od->plat)
-			dev_warn(&pdev->dev, "no sdma auxdata needed?\n");
+		if (!od->plat) {
+			dev_err(&pdev->dev, "omap_system_dma_plat_info is missing");
+			return -ENODEV;
+		}
 	} else {
 		od->cfg = &default_cfg;
 
-- 
2.24.0

