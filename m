Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF33AA559
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 22:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhFPUgz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 16:36:55 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:52184 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhFPUgz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Jun 2021 16:36:55 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d21 with ME
        id Hwag2500A21Fzsu03wag3C; Wed, 16 Jun 2021 22:34:42 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 16 Jun 2021 22:34:42 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     wangzhou1@hisilicon.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] dmaengine: hisi_dma: Remove some useless code
Date:   Wed, 16 Jun 2021 22:34:38 +0200
Message-Id: <4f8932e2d0d8d092bf60272511100030e013bc72.1623875508.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When using 'pcim_enable_device()', 'pci_alloc_irq_vectors()' is
auto-magically a managed function.

It is useless (but harmless) to record an action to explicitly call
'pci_free_irq_vectors()'.

So keep things simple, comment why and how these resources are freed, axe
some useless code and save some memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/hisi_dma.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index a259ee010e9b..c855a0e4f9ff 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -133,11 +133,6 @@ static inline void hisi_dma_update_bit(void __iomem *addr, u32 pos, bool val)
 	writel_relaxed(tmp, addr);
 }
 
-static void hisi_dma_free_irq_vectors(void *data)
-{
-	pci_free_irq_vectors(data);
-}
-
 static void hisi_dma_pause_dma(struct hisi_dma_dev *hdma_dev, u32 index,
 			       bool pause)
 {
@@ -544,6 +539,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_drvdata(pdev, hdma_dev);
 	pci_set_master(pdev);
 
+	/* This will be freed by 'pcim_release()'. See 'pcim_enable_device()' */
 	ret = pci_alloc_irq_vectors(pdev, HISI_DMA_MSI_NUM, HISI_DMA_MSI_NUM,
 				    PCI_IRQ_MSI);
 	if (ret < 0) {
@@ -551,10 +547,6 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev, hisi_dma_free_irq_vectors, pdev);
-	if (ret)
-		return ret;
-
 	dma_dev = &hdma_dev->dma_dev;
 	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
 	dma_dev->device_free_chan_resources = hisi_dma_free_chan_resources;
-- 
2.30.2

