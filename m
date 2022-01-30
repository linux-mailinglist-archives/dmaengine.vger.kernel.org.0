Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E014A3699
	for <lists+dmaengine@lfdr.de>; Sun, 30 Jan 2022 15:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354957AbiA3OMT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 30 Jan 2022 09:12:19 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:64683 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347147AbiA3OMS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 30 Jan 2022 09:12:18 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id EAwCnru7fEuQ2EAwCnR8Qu; Sun, 30 Jan 2022 15:12:17 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 30 Jan 2022 15:12:17 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sanjay R Mehta <sanju.mehta@amd.com>, Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: ptdma: Fix the error handling path in pt_core_init()
Date:   Sun, 30 Jan 2022 15:12:09 +0100
Message-Id: <1b2573cf3cd077494531993239f80c08e7feb39e.1643551909.git.christophe.jaillet@wanadoo.fr>
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

Fixes: fa5d823b16a9 ("dmaengine: ptdma: Initial driver for the AMD PTDMA")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/ptdma/ptdma-dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index 8a6bf291a73f..3fa2a6ed4b68 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -207,7 +207,7 @@ int pt_core_init(struct pt_device *pt)
 	if (!cmd_q->qbase) {
 		dev_err(dev, "unable to allocate command queue\n");
 		ret = -ENOMEM;
-		goto e_dma_alloc;
+		goto e_pool;
 	}
 
 	cmd_q->qidx = 0;
@@ -230,7 +230,7 @@ int pt_core_init(struct pt_device *pt)
 	/* Request an irq */
 	ret = request_irq(pt->pt_irq, pt_core_irq_handler, 0, dev_name(pt->dev), pt);
 	if (ret)
-		goto e_pool;
+		goto e_dma_alloc;
 
 	/* Update the device registers with queue information. */
 	cmd_q->qcontrol &= ~CMD_Q_SIZE;
-- 
2.32.0

