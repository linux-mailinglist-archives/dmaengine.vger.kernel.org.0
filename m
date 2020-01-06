Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D58131217
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jan 2020 13:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgAFMXb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jan 2020 07:23:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43791 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgAFMXb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Jan 2020 07:23:31 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ioRPp-0001Cb-Jd; Mon, 06 Jan 2020 12:23:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dmaengine: ti: omap-dma: don't allow a null od->plat pointer to be dereferenced
Date:   Mon,  6 Jan 2020 12:23:25 +0000
Message-Id: <20200106122325.39121-1-colin.king@canonical.com>
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
by returning -EPROBE_DEFER errror rather when the platform data is null.

Addresses-Coverity: ("Dereference after null check")
Fixes: 211010aeb097 ("dmaengine: ti: omap-dma: Pass sdma auxdata to driver and use it")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/ti/omap-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index fc8f7b2fc7b3..335c3fa7a3b1 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1658,8 +1658,10 @@ static int omap_dma_probe(struct platform_device *pdev)
 	if (conf) {
 		od->cfg = conf;
 		od->plat = dev_get_platdata(&pdev->dev);
-		if (!od->plat)
+		if (!od->plat) {
 			dev_warn(&pdev->dev, "no sdma auxdata needed?\n");
+			return -EPROBE_DEFER;
+		}
 	} else {
 		od->cfg = &default_cfg;
 
-- 
2.24.0

