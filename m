Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4C145F5D
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 00:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAVXwq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jan 2020 18:52:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51809 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVXwq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jan 2020 18:52:46 -0500
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iuPna-0000S8-Aw; Wed, 22 Jan 2020 23:52:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: s3c24xx-dma: fix spelling mistake "to" -> "too"
Date:   Wed, 22 Jan 2020 23:52:37 +0000
Message-Id: <20200122235237.2830344-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/dma/s3c24xx-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 1ed5dc1f597c..8e14c72d03f0 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1198,7 +1198,7 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 
 	/* Basic sanity check */
 	if (pdata->num_phy_channels > MAX_DMA_CHANNELS) {
-		dev_err(&pdev->dev, "to many dma channels %d, max %d\n",
+		dev_err(&pdev->dev, "too many dma channels %d, max %d\n",
 			pdata->num_phy_channels, MAX_DMA_CHANNELS);
 		return -EINVAL;
 	}
-- 
2.24.0

