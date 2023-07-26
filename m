Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2D762AA7
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jul 2023 07:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGZFRh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Jul 2023 01:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGZFRf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 26 Jul 2023 01:17:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50121FF2;
        Tue, 25 Jul 2023 22:17:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686b91c2744so665959b3a.0;
        Tue, 25 Jul 2023 22:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690348654; x=1690953454;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G473Rd1/aPrSLPnmj7YzjECNP8faN6IVLpdxjT2zGJU=;
        b=hgeBpx3c/oLoI+N/EnRuoPHEXWV1ZMvAHbHrNATLNtHKYSbX3NiaJ2CR47ha9Z0naJ
         JJEd80CGU2IPJBl0C5i42pl3T9qRl1+GgOc1Noy2/S1GRPxagsBdHZpUHr3ZAxmk6qmZ
         GKyOZgj8qpgD5slarsZ5etQvGcSOP3bGh1s8t+1QNIlXjFR+JrUsxIRDzFNXLQL2SV2M
         1UotnWKNUdEaNePQO9M/JBwDbK0xik/qExEL0MCHjB7HwzrBoxqhG5PigiQ8Eh5XXgkf
         JVGy/UzCYJZYhCbzpQWyr7Yp8bAoTRsUBOGmZghp/dfCX8ZW3JQDpDfU4tWz2+98BxhE
         T1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690348654; x=1690953454;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G473Rd1/aPrSLPnmj7YzjECNP8faN6IVLpdxjT2zGJU=;
        b=j7ywHuNX+SpEs7aoTIE3hMj7K+IK4xcHE0jJZvckCKlRsHKBCR7yMQjzZXQgICZwpd
         URq+vQVk369JXPmIgbLCz4glg2t8wwJabY5bSOxKW8xJ8pDmyoklKYGoMftHlEdhIEl4
         FjbGdgAJYRJVv40ucnsnTmaVqwf7oIKOdChbnf6XaPHKm2Wv5ZPMexHRmQ1iIzhJ20FR
         O0mVXARs2fHZFPvf5c7pHH25cMsFwKauRv7G1VxvGXP4qjNDUAQbZ7gbcbjwYVjyy3ri
         c6zmhVesu9rKGC4exi2Y2Hjx+8cJXj8HuRq/8JXOC7p4opKuv+WEUvMtC5qTaz2uEKaf
         lQjg==
X-Gm-Message-State: ABy/qLaGI3Kys/EbJFm5iHPoNywrMI2/JPEgym/Iu2sAztSIXn6vjR5k
        ybHMND+zS+9+qLKQqC+QdXk=
X-Google-Smtp-Source: APBJJlHJEz55OoJvWUKBZQCFzqMVzKd+NR2g4A7drBfTB5ZDrCjJmV11OrtZ8JyoW5Zci1hMPLCehg==
X-Received: by 2002:a05:6a00:2e93:b0:668:99aa:3f17 with SMTP id fd19-20020a056a002e9300b0066899aa3f17mr1259727pfb.16.1690348654049;
        Tue, 25 Jul 2023 22:17:34 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id b7-20020aa78107000000b0066884d4efdbsm10891167pfi.12.2023.07.25.22.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 22:17:33 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     shuge@allwinnertech.com, maxime.ripard@free-electrons.com,
        vkoul@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, p.zabel@pengutronix.de
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v2] dmaengine: sun6i: Fix potential deadlock on &sdev->lock
Date:   Wed, 26 Jul 2023 05:17:27 +0000
Message-Id: <20230726051727.64088-1-dg573847474@gmail.com>
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

The tentative patch fixes the potential deadlock by spin_lock_irqsave() to
disable softirq.

Changelog:
v1 - >v2
- Use spin_lock_irqsave() instead of spin_lock_bh(), since outside caller
  could already call with bh disable, in the case spin_unlock_bh() would
  unintentionally enable bh.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/dma/sun6i-dma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index ebfd29888b2f..30f426299703 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -866,6 +866,7 @@ static int sun6i_dma_pause(struct dma_chan *chan)
 	struct sun6i_dma_dev *sdev = to_sun6i_dma_dev(chan->device);
 	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
 	struct sun6i_pchan *pchan = vchan->phy;
+	unsigned long flags;
 
 	dev_dbg(chan2dev(chan), "vchan %p: pause\n", &vchan->vc);
 
@@ -873,9 +874,9 @@ static int sun6i_dma_pause(struct dma_chan *chan)
 		writel(DMA_CHAN_PAUSE_PAUSE,
 		       pchan->base + DMA_CHAN_PAUSE);
 	} else {
-		spin_lock(&sdev->lock);
+		spin_lock_irqsave(&sdev->lock, flags);
 		list_del_init(&vchan->node);
-		spin_unlock(&sdev->lock);
+		spin_unlock_irqrestore(&sdev->lock, flags);
 	}
 
 	return 0;
@@ -914,9 +915,9 @@ static int sun6i_dma_terminate_all(struct dma_chan *chan)
 	unsigned long flags;
 	LIST_HEAD(head);
 
-	spin_lock(&sdev->lock);
+	spin_lock_irqsave(&sdev->lock, flags);
 	list_del_init(&vchan->node);
-	spin_unlock(&sdev->lock);
+	spin_unlock_irqrestore(&sdev->lock, flags);
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
-- 
2.17.1

