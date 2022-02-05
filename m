Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACACD4AA737
	for <lists+dmaengine@lfdr.de>; Sat,  5 Feb 2022 07:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379541AbiBEG6u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 5 Feb 2022 01:58:50 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:63891 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiBEG6t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 5 Feb 2022 01:58:49 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id GF1yn0ylHIQAdGF1znd3Hp; Sat, 05 Feb 2022 07:58:47 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 05 Feb 2022 07:58:47 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sanjay R Mehta <sanju.mehta@amd.com>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH v2] dmaengine: ptdma: Fix the error handling path in pt_core_init()
Date:   Sat,  5 Feb 2022 07:58:44 +0100
Message-Id: <41a963a35173f89c874f5c44df5530dc09fea8da.1644044244.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In order to free resources correctly in the error handling path of
pt_core_init(), 2 goto's have to be switched. Otherwise, some resources
will leak and we will try to release things that have not been allocated
yet.

Also move a dev_err() to a place where it is more meaningful.

Fixes: fa5d823b16a9 ("dmaengine: ptdma: Initial driver for the AMD PTDMA")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: update label names
    move dev_err(dev, "unable to allocate an IRQ\n");
---
 drivers/dma/ptdma/ptdma-dev.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index 8a6bf291a73f..daafea5bc35d 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -207,7 +207,7 @@ int pt_core_init(struct pt_device *pt)
 	if (!cmd_q->qbase) {
 		dev_err(dev, "unable to allocate command queue\n");
 		ret = -ENOMEM;
-		goto e_dma_alloc;
+		goto e_destroy_pool;
 	}
 
 	cmd_q->qidx = 0;
@@ -229,8 +229,10 @@ int pt_core_init(struct pt_device *pt)
 
 	/* Request an irq */
 	ret = request_irq(pt->pt_irq, pt_core_irq_handler, 0, dev_name(pt->dev), pt);
-	if (ret)
-		goto e_pool;
+	if (ret) {
+		dev_err(dev, "unable to allocate an IRQ\n");
+		goto e_free_dma;
+	}
 
 	/* Update the device registers with queue information. */
 	cmd_q->qcontrol &= ~CMD_Q_SIZE;
@@ -250,21 +252,20 @@ int pt_core_init(struct pt_device *pt)
 	/* Register the DMA engine support */
 	ret = pt_dmaengine_register(pt);
 	if (ret)
-		goto e_dmaengine;
+		goto e_free_irq;
 
 	/* Set up debugfs entries */
 	ptdma_debugfs_setup(pt);
 
 	return 0;
 
-e_dmaengine:
+e_free_irq:
 	free_irq(pt->pt_irq, pt);
 
-e_dma_alloc:
+e_free_dma:
 	dma_free_coherent(dev, cmd_q->qsize, cmd_q->qbase, cmd_q->qbase_dma);
 
-e_pool:
-	dev_err(dev, "unable to allocate an IRQ\n");
+e_destroy_pool:
 	dma_pool_destroy(pt->cmd_q.dma_pool);
 
 	return ret;
-- 
2.32.0

