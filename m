Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28ED83BF4ED
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jul 2021 07:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhGHFLP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Jul 2021 01:11:15 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:37420 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229646AbhGHFLO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 8 Jul 2021 01:11:14 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d71 with ME
        id SV8U2500221Fzsu03V8UiH; Thu, 08 Jul 2021 07:08:32 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Jul 2021 07:08:32 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dave.jiang@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: idxd: Simplify code and axe the use of a deprecated API
Date:   Thu,  8 Jul 2021 07:08:26 +0200
Message-Id: <70c8a3bc67e41c5fefb526ecd64c5174c1e2dc76.1625720835.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

Replace 'pci_set_dma_mask/pci_set_consistent_dma_mask' by an equivalent
and less verbose 'dma_set_mask_and_coherent()' call.

Even if the code may look different, it should have exactly the same
run-time behavior.
If pci_set_dma_mask(64) fails and pci_set_dma_mask(32) succeeds, then
pci_set_consistent_dma_mask(64) will also fail.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If needed, see post from Christoph Hellwig on the kernel-janitors ML:
   https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
---
 drivers/dma/idxd/init.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index c8ae41d36040..de300ba38b14 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -637,15 +637,9 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	dev_dbg(dev, "Set DMA masks\n");
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc)
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-	if (rc)
-		goto err;
-
-	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (rc)
-		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc)
 		goto err;
 
-- 
2.30.2

