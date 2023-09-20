Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192B47A8D98
	for <lists+dmaengine@lfdr.de>; Wed, 20 Sep 2023 22:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjITUNN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Sep 2023 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjITUNM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Sep 2023 16:13:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62559CF;
        Wed, 20 Sep 2023 13:13:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c7912416bso185532f8f.1;
        Wed, 20 Sep 2023 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695240785; x=1695845585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHtNaKq4mifJgdLoidd7EGYYdFLlKW8hl+A/qfMHV+Q=;
        b=UYNlACf5ta35UhRPe6ZCjQlbbj8AZ2v4pjEMuijyPBkU1fm5gzn6jXiRiCSPn59lGU
         w9GkXT3wZT3g6iXrG3iSSz34SK2ePGCcPf3hGe78p+Q4jSY3q8D38vMLwI1oinoKkWsZ
         Q00/srgsWL34lCzRUxMxz+8sLSrPYTOrkjxo33TKHvFZ9Zl5fxv9uFCqVXLkZtT8j6kZ
         5yNu1U79K0/3BlYuf++xFIuvPE7JWX94Rkh/+bPOX0owlUkQmti8M/YzoEV/2Am+AACw
         UQ71v6ib6lVHwmMny8a0EyvfYbXJ1j+/4ZnV4kQfU1KzqzdJ4oisWiIzuhQADckD2q7z
         8XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695240785; x=1695845585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHtNaKq4mifJgdLoidd7EGYYdFLlKW8hl+A/qfMHV+Q=;
        b=WGZ9NIEQlbJYasVmR88NaXoojCwauwpzzwnYqKqHHT1zqJzM4OCYTSBMsLFlFOVeoc
         kXuiz0mFJuR5LLOtHb/W468xVaHj9C+IKgqEblr0FbyUMlz1H3/g8ZlODeBuAIraeRDf
         Q3ohYc2Er9zwSxbfROEzGu+qVuxaw2QlRwqX7INR6zDv/M41LLynByLjm0Xi3sF0ZGM/
         Kzd3lmH/S1kyTXWoweOM4RfUzgY5UjFl2ooHPKTLgNjlOZ7Hmxaeq92zIXKWw9Wh1GD/
         6a5rpEQS7FzHchFTUoH8WEAv9/X6Hp82CfYYRVwaegyc5yiav6wtXH3dz9M32BQ4vfS2
         YcpQ==
X-Gm-Message-State: AOJu0Yy99xceU+6MlKzktNUW/KgKd204nsWoUIFplU5igjLHJthfWVL7
        VJ/l2okiP7J7v5aWLnaX2RE=
X-Google-Smtp-Source: AGHT+IHtbxMg2yoDWeiOXQr5ZW5JKEH1+9IPrYQbxBcONDAQA0HQZdbTeLAVrID1Q9k2Q30zRB7IbA==
X-Received: by 2002:a5d:4d92:0:b0:317:5e5e:60e0 with SMTP id b18-20020a5d4d92000000b003175e5e60e0mr2723559wru.28.1695240784579;
        Wed, 20 Sep 2023 13:13:04 -0700 (PDT)
Received: from localhost.localdomain (190-2-133-229.hosted-by-worldstream.net. [190.2.133.229])
        by smtp.googlemail.com with ESMTPSA id uz3-20020a170907118300b009ad8acac02asm10076030ejb.172.2023.09.20.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 13:13:04 -0700 (PDT)
From:   Olivier Dautricourt <olivierdautricourt@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>,
        Eric Schwarz <eas@sw-optimization.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olivier Dautricourt <olivierdautricourt@gmail.com>
Subject: [PATCH] dmaengine: altera-msgdma: fix descriptors freeing logic
Date:   Wed, 20 Sep 2023 21:58:59 +0200
Message-ID: <20230920200636.32870-3-olivierdautricourt@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sparse complains because we first take the lock in msgdma_tasklet -> move
locking to msgdma_chan_desc_cleanup.
In consequence, move calling of msgdma_chan_desc_cleanup outside of the
critical section of function msgdma_tasklet.

Use spin_unlock_irqsave/restore instead of just spinlock/unlock to keep
state of irqs while executing the callbacks.

Remove list_del call in msgdma_chan_desc_cleanup, this should be the role
of msgdma_free_descriptor. In consequence replace list_add_tail with
list_move_tail in msgdma_free_descriptor. This fixes the path:
msgdma_free_chan_resources -> msgdma_free_descriptors ->
msgdma_free_desc_list -> msgdma_free_descriptor
which does __not__ seems to free correctly the descriptors as firsts nodes
where not removed from the specified list.

Signed-off-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
---
Following Eric Schwarz comments on altera-msgdma driver not having some
of the fixes made to zynqmp-dma driver (which msgdma driver is based on):
This patch should address at least the spinlock part, it __has not__ been
tested yet so please don't accept it right away. I'm in the process of
getting a new hardware to test with. Meanwhile it is open to reviews
and even better if someone is able to test it.

 drivers/dma/altera-msgdma.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 4153c2edb049..c39937bfcdf1 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -233,7 +233,7 @@ static void msgdma_free_descriptor(struct msgdma_device *mdev,
 	struct msgdma_sw_desc *child, *next;
 
 	mdev->desc_free_cnt++;
-	list_add_tail(&desc->node, &mdev->free_list);
+	list_move_tail(&desc->node, &mdev->free_list);
 	list_for_each_entry_safe(child, next, &desc->tx_list, node) {
 		mdev->desc_free_cnt++;
 		list_move_tail(&child->node, &mdev->free_list);
@@ -583,22 +583,25 @@ static void msgdma_issue_pending(struct dma_chan *chan)
 static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
 {
 	struct msgdma_sw_desc *desc, *next;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&mdev->lock, irqflags);
 
 	list_for_each_entry_safe(desc, next, &mdev->done_list, node) {
 		struct dmaengine_desc_callback cb;
 
-		list_del(&desc->node);
-
 		dmaengine_desc_get_callback(&desc->async_tx, &cb);
 		if (dmaengine_desc_callback_valid(&cb)) {
-			spin_unlock(&mdev->lock);
+			spin_unlock_irqrestore(&mdev->lock, irqflags);
 			dmaengine_desc_callback_invoke(&cb, NULL);
-			spin_lock(&mdev->lock);
+			spin_lock_irqsave(&mdev->lock, irqflags);
 		}
 
 		/* Run any dependencies, then free the descriptor */
 		msgdma_free_descriptor(mdev, desc);
 	}
+
+	spin_unlock_irqrestore(&mdev->lock, irqflags);
 }
 
 /**
@@ -713,10 +716,11 @@ static void msgdma_tasklet(struct tasklet_struct *t)
 		}
 
 		msgdma_complete_descriptor(mdev);
-		msgdma_chan_desc_cleanup(mdev);
 	}
 
 	spin_unlock_irqrestore(&mdev->lock, flags);
+
+	msgdma_chan_desc_cleanup(mdev);
 }
 
 /**
-- 
2.41.0

