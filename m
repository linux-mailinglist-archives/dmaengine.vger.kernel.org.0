Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9F44B47A
	for <lists+dmaengine@lfdr.de>; Tue,  9 Nov 2021 22:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbhKIVMw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Nov 2021 16:12:52 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:57591 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbhKIVMt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Nov 2021 16:12:49 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id kYNSmHD8XIEdlkYNSmbJt2; Tue, 09 Nov 2021 22:10:00 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 09 Nov 2021 22:10:00 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org, wangqing@vivo.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: dw-edma: Fix (and simplify) the probe broken since ecb8c88bd31c
Date:   Tue,  9 Nov 2021 22:09:56 +0100
Message-Id: <935fbb40ae930c5fe87482a41dcb73abf2257973.1636492127.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The commit in the Fixes: tag has changed the logic of the code and now it
is likely that the probe will return an early success (0), even if not
completely executed.

This should lead to a crash or similar issue later on when the code
accesses to some never allocated resources.

Change the '!err' into a 'err' when checking if
'dma_set_mask_and_coherent()' has failed or not.

While at it, simplify the code and remove the "can't success code" related
to 32 DMA mask.
As stated in [1], 'dma_set_mask_and_coherent(DMA_BIT_MASK(64))' can't fail
if 'dev->dma_mask' is non-NULL. And if it is NULL, it would fail for the
same reason when tried with DMA_BIT_MASK(32).

[1]: https://lkml.org/lkml/2021/6/7/398

Fixes: ecb8c88bd31c ("dmaengine: dw-edma-pcie: switch from 'pci_' to 'dma_' API")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 198f6cd8ac1b..cee7aa231d7b 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -187,17 +187,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 	/* DMA configuration */
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (!err) {
+	if (err) {
 		pci_err(pdev, "DMA mask 64 set failed\n");
 		return err;
-	} else {
-		pci_err(pdev, "DMA mask 64 set failed\n");
-
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			pci_err(pdev, "DMA mask 32 set failed\n");
-			return err;
-		}
 	}
 
 	/* Data structure allocation */
-- 
2.30.2

