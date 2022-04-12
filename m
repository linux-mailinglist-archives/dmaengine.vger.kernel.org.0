Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55304FCBCD
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 03:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiDLBTb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 21:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349081AbiDLBSk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 21:18:40 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1870D10C0;
        Mon, 11 Apr 2022 18:16:24 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 12 Apr
 2022 09:16:22 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 12 Apr
 2022 09:16:22 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V3] dmaengine: pl08x: drop the useless function
Date:   Tue, 12 Apr 2022 09:16:20 +0800
Message-ID: <1649726180-13133-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <YlQ1i3DFqoFFFszO@matsya>
References: <YlQ1i3DFqoFFFszO@matsya>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-123.meizu.com (172.16.1.123) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Unneeded variable: "retval". Return "NULL" , so we have to make code clear.
better way, drop the function.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: drop the useless function.
V2->V3: change title

 drivers/dma/amba-pl08x.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a24882ba3764..a4a794e62ac2 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1535,14 +1535,6 @@ static void pl08x_free_chan_resources(struct dma_chan *chan)
 	vchan_free_chan_resources(to_virt_chan(chan));
 }
 
-static struct dma_async_tx_descriptor *pl08x_prep_dma_interrupt(
-		struct dma_chan *chan, unsigned long flags)
-{
-	struct dma_async_tx_descriptor *retval = NULL;
-
-	return retval;
-}
-
 /*
  * Code accessing dma_async_is_complete() in a tight loop may give problems.
  * If slaves are relying on interrupts to signal completion this function
@@ -2760,7 +2752,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	pl08x->memcpy.dev = &adev->dev;
 	pl08x->memcpy.device_free_chan_resources = pl08x_free_chan_resources;
 	pl08x->memcpy.device_prep_dma_memcpy = pl08x_prep_dma_memcpy;
-	pl08x->memcpy.device_prep_dma_interrupt = pl08x_prep_dma_interrupt;
 	pl08x->memcpy.device_tx_status = pl08x_dma_tx_status;
 	pl08x->memcpy.device_issue_pending = pl08x_issue_pending;
 	pl08x->memcpy.device_config = pl08x_config;
@@ -2787,8 +2778,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		pl08x->slave.dev = &adev->dev;
 		pl08x->slave.device_free_chan_resources =
 			pl08x_free_chan_resources;
-		pl08x->slave.device_prep_dma_interrupt =
-			pl08x_prep_dma_interrupt;
 		pl08x->slave.device_tx_status = pl08x_dma_tx_status;
 		pl08x->slave.device_issue_pending = pl08x_issue_pending;
 		pl08x->slave.device_prep_slave_sg = pl08x_prep_slave_sg;
-- 
2.7.4

