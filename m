Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08CC762A7F
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 06:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGZE6g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 00:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGZE6e (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 00:58:34 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F141BD1;
        Tue, 25 Jul 2023 21:58:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4039f0d140eso52276761cf.1;
        Tue, 25 Jul 2023 21:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690347512; x=1690952312;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M087Fgq0E4MMh1I/cPVwdFNlx/VQvGhOV2RTHu7YaBU=;
        b=pU6R0/U1qgBajf5acm5GN3CJoiqNmkCUunPRrSGqoTE9hdz6stnmgrcZ7JA5Q49a5E
         JtueY3tREN64bfuHdFaLJvjc6PucraeYC5Pj64fBpE/O3yTtBGP51jYxrObvHk8nPyS9
         MLUEvtEnie2H2jcItTbIC2kKyFJZHnqfPz9+FGixCqXnl5EKyRCXc4c2Uc0WCtXg6kdB
         iRVaDZwLbSBZMYvXupizNn9YWKiaY0mOczUqCZ+MU7wo4xu3a5oQXxlcplwMYGQ25qH5
         DGgRyMZY0OKhvvRASDw5vLneZep6G0g2FdoRwsQVnepiKa8iJs9dMMi/1gQjdnARd1m4
         ng3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690347512; x=1690952312;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M087Fgq0E4MMh1I/cPVwdFNlx/VQvGhOV2RTHu7YaBU=;
        b=LD7w1saLov8u5pjp2WL4JHDDvPBkD3uvJ3IUv8PgnmWBkn4ABY+eXsUczt5QjfoxMG
         WnHP4++AJJ5bj2gFTmkDUDjcSvD10KbbktI37QqOOdKYAvzsaYZF/hdE1nox6kQM93Tm
         47jyJkEfqsj7kLyQddlbSTLgE3kA/rxJut+dgyiFdB8IZHyKM5od/BJ2sXUwhkyiqTEU
         a7+iyJnf/6pRyv1Yb9lNKdebtnqcRn2tTpgI9U9LirEQB8dIDuKiJr/ovxf18AmtdgAx
         pPErbBgwpuhXUjds0S/Ct3XDvCY/ijpnL6xZe9plZOizU69ymZuO++JwzCuN+dKJXZa4
         LeZw==
X-Gm-Message-State: ABy/qLax/rJsBWHOeyTZ6aO4rf/Wv1mKtF2ULVquXrmYMcYioi3e4mT1
        HhtvtJWYdqmer6M0eaTzWzQ=
X-Google-Smtp-Source: APBJJlGf5vu0wnTC/f1RfEHETiSiriuSo6u0D6X8YQ+PtqkJ4DC2xNEIzE+uILGV6Y37eISxkfemmQ==
X-Received: by 2002:a05:622a:211:b0:403:f659:d716 with SMTP id b17-20020a05622a021100b00403f659d716mr1349217qtx.63.1690347512666;
        Tue, 25 Jul 2023 21:58:32 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902eac600b001bb739e220esm9229001pld.230.2023.07.25.21.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 21:58:32 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     shuge@allwinnertech.com, maxime.ripard@free-electrons.com,
        vkoul@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, p.zabel@pengutronix.de
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] dmaengine: sun6i: Fix potential deadlock on &sdev->lock
Date:   Wed, 26 Jul 2023 04:58:26 +0000
Message-Id: <20230726045826.49554-1-dg573847474@gmail.com>
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

As &sdev->lock is acquired by tasklet sun6i_dma_tasklet() executed under
softirq context, other acquisition of the same lock under process context
should disable irq, otherwise deadlock could happen if the soft irq preempt
the execution while the lock is held in process context on the same CPU.

sun6i_dma_terminate_all() and sun6i_dma_pause() callbacks acquire the same
lock without disabling irq inside the function.

Possible deadlock scenario:
sun6i_dma_pause()
    -> spin_lock(&sdev->lock);
        <tasklet softirq interruption>
        -> sun6i_dma_tasklet()
        -> spin_lock_irq(&sdev->lock) (deadlock here)

This flaw was found by an experimental static analysis tool I am developing
for irq-related deadlock.

The tentative patch fixes the potential deadlock by spin_lock_bh() to
disable softirq.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/dma/sun6i-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index ebfd29888b2f..8bad6ce62ea8 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -873,9 +873,9 @@ static int sun6i_dma_pause(struct dma_chan *chan)
 		writel(DMA_CHAN_PAUSE_PAUSE,
 		       pchan->base + DMA_CHAN_PAUSE);
 	} else {
-		spin_lock(&sdev->lock);
+		spin_lock_bh(&sdev->lock);
 		list_del_init(&vchan->node);
-		spin_unlock(&sdev->lock);
+		spin_unlock_bh(&sdev->lock);
 	}
 
 	return 0;
@@ -914,9 +914,9 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	LIST_HEAD(head);
 
-	spin_lock(&sdev->lock);
+	spin_lock_bh(&sdev->lock);
 	list_del_init(&vchan->node);
-	spin_unlock(&sdev->lock);
+	spin_unlock_bh(&sdev->lock);
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
-- 
2.17.1

