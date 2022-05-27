Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98302535A97
	for <lists+dmaengine@lfdr.de>; Fri, 27 May 2022 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245077AbiE0Hkk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 May 2022 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiE0Hkk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 May 2022 03:40:40 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BFAF7495;
        Fri, 27 May 2022 00:40:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VEW88T-_1653637234;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VEW88T-_1653637234)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 15:40:35 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     olivierdautricourt@gmail.com
Cc:     sr@denx.de, vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] dmaengine: altera-msgdma: Fix kernel-doc
Date:   Fri, 27 May 2022 15:40:08 +0800
Message-Id: <20220527074008.8458-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix the following W=1 kernel warnings:

drivers/dma/altera-msgdma.c:927: warning: expecting prototype for
msgdma_dma_remove(). Prototype was for msgdma_remove() instead.

drivers/dma/altera-msgdma.c:758: warning: expecting prototype for
msgdma_chan_remove(). Prototype was for msgdma_dev_remove() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Make the commit message more clearer,replace msgdma_remove()
with msgdma_dma_remove() in doc.

 drivers/dma/altera-msgdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 6f56dfd375e3..4153c2edb049 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -749,7 +749,7 @@ static irqreturn_t msgdma_irq_handler(int irq, void *data)
 }
 
 /**
- * msgdma_chan_remove - Channel remove function
+ * msgdma_dev_remove() - Device remove function
  * @mdev: Pointer to the Altera mSGDMA device structure
  */
 static void msgdma_dev_remove(struct msgdma_device *mdev)
@@ -918,7 +918,7 @@ static int msgdma_probe(struct platform_device *pdev)
 }
 
 /**
- * msgdma_dma_remove - Driver remove function
+ * msgdma_remove() - Driver remove function
  * @pdev: Pointer to the platform_device structure
  *
  * Return: Always '0'
-- 
2.20.1.7.g153144c

