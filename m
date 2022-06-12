Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC5F547CC0
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jun 2022 00:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbiFLWYj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jun 2022 18:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiFLWYa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jun 2022 18:24:30 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACC52603;
        Sun, 12 Jun 2022 15:24:28 -0700 (PDT)
Received: from hednb3.intra.ispras.ru (unknown [109.252.137.140])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1E71A40D403E;
        Sun, 12 Jun 2022 22:24:15 +0000 (UTC)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Vinod Koul <vkoul@kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] dmaengine: stm32-mdma: Remove dead code in stm32_mdma_irq_handler()
Date:   Mon, 13 Jun 2022 01:23:58 +0300
Message-Id: <1655072638-9103-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Local variable chan is initialized by an address of element of chan array
that is part of stm32_mdma_device struct, so it does not make sense to
compare chan with NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: a4ffb13c8946 ("dmaengine: Add STM32 MDMA driver")
---
 drivers/dma/stm32-mdma.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index caf0cce8f528..b11927ed4367 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1328,12 +1328,7 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
 		return IRQ_NONE;
 	}
 	id = __ffs(status);
-
 	chan = &dmadev->chan[id];
-	if (!chan) {
-		dev_warn(mdma2dev(dmadev), "MDMA channel not initialized\n");
-		return IRQ_NONE;
-	}
 
 	/* Handle interrupt for the channel */
 	spin_lock(&chan->vchan.lock);
-- 
2.7.4

