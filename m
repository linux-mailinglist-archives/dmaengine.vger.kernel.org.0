Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0508A74005A
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jun 2023 18:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjF0QIi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Jun 2023 12:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjF0QIg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Jun 2023 12:08:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E119430EA;
        Tue, 27 Jun 2023 09:08:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b80f2e6c17so15266375ad.0;
        Tue, 27 Jun 2023 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687882105; x=1690474105;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcMATJN8xXqVyRFtTuyOpaRPWGgCQutMdeEQmPJDSaM=;
        b=dW5tIzc8PZWHLch9wtCYSSNk5Kk7CDKrQbzjr+kL4FL53IsKmldGk7iocVp4frRgMm
         f4tg+3DIJA59hHmJwY2GVV+X6a3nenchRPAfJ3wfOuycfUBon/lPe4Yi9D5X/HIfxSNO
         C43Go4tahpLRb6S/YyUdFwKs8dGwvP0lDOH3dyV373LEb6kcS7E/s+knitRtMgPDqx4K
         f+9Q6TXKRhLoM31qQnb1z0/HgKpHM/jQa2NReKiOYsEV3fZEcrX8F6GbelCbmJgH20j1
         6OncEHi/3DcsUtOIrVO1Weoq0tVBA9SpGmrgYtFg3rztpF7LPEa78qCnvT1RGIO4J49/
         CDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687882105; x=1690474105;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcMATJN8xXqVyRFtTuyOpaRPWGgCQutMdeEQmPJDSaM=;
        b=bqplZAdO0emLut9fZOKlgCE3O2jR+1bblUGpmxmOHOaR9kSw07mAcfByqVQRofzpTa
         ioJurMCHg1yfL6AWZnKzQjWJemlFcijW228vFlTsUr6SnmZBnWn3ndvw9Ta4rkTSInve
         XHhMX82RSuUOFyjDyUzzmJr5vOjA75GugEQIxy5BBrtUkesw352+XF54qQTgHF3XhvX9
         roJXlMzeT+5L5gQjqOx1O8N/wDrH7SeOEQ67JFxo8s/OC/UmTY6sEMFC1e2lpwkNMezu
         G+GuqU9MY6ajU2ufRs2J9ej98SUmZmznekd59LhCAMt0y5nreVAQlHen7+DS73ZfcdNb
         YV1A==
X-Gm-Message-State: AC+VfDz38Pt/2vgN8ci4BxqGZKuDmO2AO4keMO9qdWBMvyN84CapirWr
        F1rY7o+ABVYczIuPhOOybGxvRlf1E38zzw==
X-Google-Smtp-Source: ACHHUZ5BTauw/zKna/oWZR79JVRvXQg9k9SzKWVgse9pUJT5oj4EIVac4+zntqBTSsG9g25aKVdn8A==
X-Received: by 2002:a17:902:e5c1:b0:1b6:b4e5:23a with SMTP id u1-20020a170902e5c100b001b6b4e5023amr12542835plf.26.1687882105163;
        Tue, 27 Jun 2023 09:08:25 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001ae7fad1598sm6206468plh.29.2023.06.27.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:08:24 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] dmaengine: k3dma: fix potential deadlock on &d->lock
Date:   Tue, 27 Jun 2023 16:08:17 +0000
Message-Id: <20230627160817.47353-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As &d->lock is acquired by the tasklet k3_dma_tasklet() under softirq
context, other process context code acquring the lock should disable
irq or at least bottom-half irq. The dma terminate callback
k3_dma_terminate_all() and pause callback k3_dma_transfer_pause()
acquire the same lock but without closing irq.

I am not sure whether the two callbacks are already irq close in the
core, if not, then it would have the following deadlocks. But I saw
a spin_lock_irq() or another lock inside the terminate callback so
I guess not.

Possible deadlock scenario:
k3_dma_transfer_pause()
    -> spin_lock(&d->lock)
        <tasklet interrupt>
        -> k3_dma_tasklet()
        -> spin_lock_irq(&d->lock) (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_irqsave(),
or it can be spin_lock_bh() if should be fixed?

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/dma/k3dma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index ecdaada95120..ee398cb4ac11 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -728,9 +728,9 @@ static int k3_dma_terminate_all(struct dma_chan *chan)
 	dev_dbg(d->slave.dev, "vchan %p: terminate all\n", &c->vc);
 
 	/* Prevent this channel being scheduled */
-	spin_lock(&d->lock);
+	spin_lock_irqsave(&d->lock, flags);
 	list_del_init(&c->node);
-	spin_unlock(&d->lock);
+	spin_unlock_irqrestore(&d->lock, flags);
 
 	/* Clear the tx descriptor lists */
 	spin_lock_irqsave(&c->vc.lock, flags);
@@ -764,6 +764,7 @@ static int k3_dma_transfer_pause(struct dma_chan *chan)
 	struct k3_dma_chan *c = to_k3_chan(chan);
 	struct k3_dma_dev *d = to_k3_dma(chan->device);
 	struct k3_dma_phy *p = c->phy;
+	unsigned long flags;
 
 	dev_dbg(d->slave.dev, "vchan %p: pause\n", &c->vc);
 	if (c->status == DMA_IN_PROGRESS) {
@@ -771,9 +772,9 @@ static int k3_dma_transfer_pause(struct dma_chan *chan)
 		if (p) {
 			k3_dma_pause_dma(p, false);
 		} else {
-			spin_lock(&d->lock);
+			spin_lock_irqsave(&d->lock, flags);
 			list_del_init(&c->node);
-			spin_unlock(&d->lock);
+			spin_unlock_irqrestore(&d->lock, flags);
 		}
 	}
 
-- 
2.17.1

