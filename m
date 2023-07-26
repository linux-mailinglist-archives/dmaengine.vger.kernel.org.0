Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754FB762B56
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 08:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGZGXW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 02:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGZGXV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 02:23:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D95F13E;
        Tue, 25 Jul 2023 23:23:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6726d5d92afso410411b3a.1;
        Tue, 25 Jul 2023 23:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690352600; x=1690957400;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDM55a7oG0BbneN1PGa6XS/VJPe7aeTnTfnVkzF/JIE=;
        b=nZz028quw61q937OjrPzn8myljO8jiYivrxSF4Cs910WeGGdFwOOzIDb3aopUbaRyd
         ABqkfPeLS2Ye95VG6PiSDuNn5rjmmQ2fq0gJ6in1sX3J6YddkHRg67XZRMQwPCygylLe
         KSuZxAAdFWSj+HoM90PxrKkQfeXbTEgMm4R3uJyQmmvKRkmSsfM9mI4e5czIEk+xwsBX
         1ByoJlBwbufdBMdFidt+70/rU9DPsLU/wZ30VQBjSt8OY73//rAh599Y30fBTjGgb+Hw
         YWwXlfSzULs+ocgKHJheE0YsikNrzDe8sCxSH0Wz91I8GWs/Y1Esh4UxE2MK5ls5G+yx
         1vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690352600; x=1690957400;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDM55a7oG0BbneN1PGa6XS/VJPe7aeTnTfnVkzF/JIE=;
        b=JGHHH33AS3QmJsy0g14Wbx2Q93LpCiLlvXLYpQOS5+WRuNyET5qj7Ub0MhHhYhmdhb
         E2rD5yxa119GytI2+ZxvhD3kCJoT+4OoDtpdehfib1HhWgjGbIzcdLQDRPJ4WK/WuwbV
         BdpR3ufdP21sIwobzHsso9UlEGI6j/No8DktlZSTZL3RD78tdpVz++RmjEDp4e5C/MAf
         AdUM1e7QE1Y/MmDz5GXjNUZnBWue0reoub2gZiUw6aPa2TyE380pX+R0TS07n0IqbaR6
         jC+jvKHLW09Jj4C5jxhksPZFrGncae6IfztkFhIXAlzZ9SeDgLYE/IG0UovsCgTxRAKJ
         WL9g==
X-Gm-Message-State: ABy/qLazqFlEY4pdrj//6lHwDslyk6KIM6z84S27WgEt6nvRG2narA3Y
        NNSqlbS4YqXKVCRHOXMRs2yVFsJlDXr8VQ==
X-Google-Smtp-Source: APBJJlEB7qZ26SVOr2o7VznR47KNYIV2dYLF1H3Z4k6gkC/jgUCeqWA5UqXrb6QTpWXSSxDdmDTE/Q==
X-Received: by 2002:a05:6a20:6a1a:b0:133:6696:1db with SMTP id p26-20020a056a206a1a00b00133669601dbmr1583346pzk.29.1690352599945;
        Tue, 25 Jul 2023 23:23:19 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id e19-20020a62aa13000000b0066ccb8e8024sm623266pff.30.2023.07.25.23.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 23:23:19 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     vkoul@kernel.org, allen.lkml@gmail.com, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, yong.y.wang@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] dmaengine: pch_dma: Fix potential deadlock on &pd_chan->lock
Date:   Wed, 26 Jul 2023 06:23:13 +0000
Message-Id: <20230726062313.77121-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As &pd_chan->lock is acquired by pdc_tasklet() under softirq context
scheduled by pd_irq(), other acquisition of the same lock under process
context should disable irq, otherwise deadlock could happen if the soft
irq preempts the execution of process context code while the lock is held
in process context on the same CPU.

pd_issue_pending(), pd_tx_submit(), pdc_desc_put() and pdc_desc_get() are
callbacks function or executed by callback functions that could execute
without irq disaled.

Possible deadlock scenario:
pd_prep_slave_sg()
    -> pdc_desc_put()
    -> spin_lock(&pd_chan->lock)
        <tasklet softirq interruption>
        -> pdc_tasklet()
        -> spin_lock_irqsave(&pd_chan->lock, flags); (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The tentative patch fixes the potential deadlock by spin_lock_irqsave() to
disable irq while lock is held.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/dma/pch_dma.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index c359decc07a3..ad9ac4f64961 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -409,8 +409,9 @@ static dma_cookie_t pd_tx_submit(struct dma_async_tx_descriptor *txd)
 {
 	struct pch_dma_desc *desc = to_pd_desc(txd);
 	struct pch_dma_chan *pd_chan = to_pd_chan(txd->chan);
+	unsigned long flags;
 
-	spin_lock(&pd_chan->lock);
+	spin_lock_irqsave(&pd_chan->lock, flags);
 
 	if (list_empty(&pd_chan->active_list)) {
 		list_add_tail(&desc->desc_node, &pd_chan->active_list);
@@ -419,7 +420,7 @@ static dma_cookie_t pd_tx_submit(struct dma_async_tx_descriptor *txd)
 		list_add_tail(&desc->desc_node, &pd_chan->queue);
 	}
 
-	spin_unlock(&pd_chan->lock);
+	spin_unlock_irqrestore(&pd_chan->lock, flags);
 	return 0;
 }
 
@@ -445,9 +446,10 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 {
 	struct pch_dma_desc *desc, *_d;
 	struct pch_dma_desc *ret = NULL;
+	unsigned long flags;
 	int i = 0;
 
-	spin_lock(&pd_chan->lock);
+	spin_lock_irqsave(&pd_chan->lock, flags);
 	list_for_each_entry_safe(desc, _d, &pd_chan->free_list, desc_node) {
 		i++;
 		if (async_tx_test_ack(&desc->txd)) {
@@ -457,15 +459,15 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 		}
 		dev_dbg(chan2dev(&pd_chan->chan), "desc %p not ACKed\n", desc);
 	}
-	spin_unlock(&pd_chan->lock);
+	spin_unlock_irqrestore(&pd_chan->lock, flags);
 	dev_dbg(chan2dev(&pd_chan->chan), "scanned %d descriptors\n", i);
 
 	if (!ret) {
 		ret = pdc_alloc_desc(&pd_chan->chan, GFP_ATOMIC);
 		if (ret) {
-			spin_lock(&pd_chan->lock);
+			spin_lock_irqsave(&pd_chan->lock, flags);
 			pd_chan->descs_allocated++;
-			spin_unlock(&pd_chan->lock);
+			spin_unlock_irqrestore(&pd_chan->lock, flags);
 		} else {
 			dev_err(chan2dev(&pd_chan->chan),
 				"failed to alloc desc\n");
@@ -478,11 +480,13 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 static void pdc_desc_put(struct pch_dma_chan *pd_chan,
 			 struct pch_dma_desc *desc)
 {
+	unsigned long flags;
+
 	if (desc) {
-		spin_lock(&pd_chan->lock);
+		spin_lock_irqsave(&pd_chan->lock, flags);
 		list_splice_init(&desc->tx_list, &pd_chan->free_list);
 		list_add(&desc->desc_node, &pd_chan->free_list);
-		spin_unlock(&pd_chan->lock);
+		spin_unlock_irqrestore(&pd_chan->lock, flags);
 	}
 }
 
@@ -555,11 +559,12 @@ static enum dma_status pd_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 static void pd_issue_pending(struct dma_chan *chan)
 {
 	struct pch_dma_chan *pd_chan = to_pd_chan(chan);
+	unsigned long flags;
 
 	if (pdc_is_idle(pd_chan)) {
-		spin_lock(&pd_chan->lock);
+		spin_lock_irqsave(&pd_chan->lock, flags);
 		pdc_advance_work(pd_chan);
-		spin_unlock(&pd_chan->lock);
+		spin_unlock_irqrestore(&pd_chan->lock, flags);
 	}
 }
 
-- 
2.17.1

