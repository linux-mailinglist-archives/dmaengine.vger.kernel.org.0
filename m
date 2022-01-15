Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C1C48F5B7
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jan 2022 08:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiAOHkw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Jan 2022 02:40:52 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:57993 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiAOHkw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Jan 2022 02:40:52 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id 8dgAniCymhTNk8dgAn3hnT; Sat, 15 Jan 2022 08:40:51 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 15 Jan 2022 08:40:51 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        Stefan Roese <sr@denx.de>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: altera-msgdma: Remove useless DMA-32 fallback configuration
Date:   Sat, 15 Jan 2022 08:40:47 +0100
Message-Id: <01058ada3a0dea207212182ca7525060a204f1e1.1642232423.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As stated in [1], dma_set_mask() with a 64-bit mask never fails if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/altera-msgdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index f5b885d69cd3..6f56dfd375e3 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -891,9 +891,7 @@ static int msgdma_probe(struct platform_device *pdev)
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
 		dev_warn(&pdev->dev, "unable to set coherent mask to 64");
-		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (ret)
-			goto fail;
+		goto fail;
 	}
 
 	msgdma_reset(mdev);
-- 
2.32.0

