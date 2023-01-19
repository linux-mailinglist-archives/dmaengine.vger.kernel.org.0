Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2CE6730CB
	for <lists+dmaengine@lfdr.de>; Thu, 19 Jan 2023 05:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjASE5r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 23:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjASE5Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 23:57:16 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F481014
        for <dmaengine@vger.kernel.org>; Wed, 18 Jan 2023 20:48:46 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-15bb8ec196aso1364767fac.3
        for <dmaengine@vger.kernel.org>; Wed, 18 Jan 2023 20:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEU4QD9SWQApD1QuhGrlDzmlZOGDz8Awb6os1RW3IkA=;
        b=SEJz6/UNcnwqyCbhmvAlCxKgFx4GgSg7nGiFLhUg2eSqG4KJxHfpoW1AGhgWZPLxtp
         t1Yfu1Act4hbmcLsBcA0yxaxZr0l6nJYsGIxZ8qXOEeGM1GXcQtw6VFC25jWraiVUihI
         IQ0uZb9t7AcXYe2yf9UZPXSwxfrfupYH5PgXNSeK3uGybfcm9Mwgw+sP6xJ5w4gbzjN/
         YuHWpxnwQM+Y07GLHdsTA++5Zljx6UL5/F0t4mb8OD9fo2C7L/mjIB98PZBE0bldwA89
         IuT2yPO72eKONkyJD7cQgUPKLlXmJoFydMSadZjjnXrBMa+GA3zIQxU0kXnrvyXIRXcl
         rYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEU4QD9SWQApD1QuhGrlDzmlZOGDz8Awb6os1RW3IkA=;
        b=G6mKT9CybQgz4Vet9ajsn8fDudl3axPPZPVkHOp9k1mVz7Itqgo4rZKemi3nCVK3xR
         5LZxRRfe0pvedM9HgfKGie6eoIBLKQjn0G3KE95IkHVAQ7dC3V1K0r/Fdehw6djPNKLC
         /fdzlHiDhgUK/iIX5VWChvNm83YoxZmIXfkcRGG+FlBdlf+KMltb/tjpybKQlk/j30T3
         Dbq4JDa0S8HUiMEkZBmJi9siP+XzSOlpgO4wc5dTlZHOfs9y/XgswdpSftg/E3lJUF2R
         nEXq6QgTniaXahsz2D6F859ENtJfImZ12uasD/oGiWAVPTzZ5UPS29C++e/C2/Gsi1uc
         4Rdg==
X-Gm-Message-State: AFqh2krLjptZTuUnbFUtGMlhuDeYWN45i5HN/xMi65gIBi7PPIJrxIrf
        3Q5JBqvlp4EjT9VZ9m+KvJ0tyXOHuRz33G7C
X-Google-Smtp-Source: AMrXdXtWS8/CKS1e54oshK1S37JMtV/ZOd3FkLSM3fji9QzMIJW5RZqOw/MDuYHv5CvntiB+zKo3ww==
X-Received: by 2002:aa7:874c:0:b0:58d:a1e9:36d with SMTP id g12-20020aa7874c000000b0058da1e9036dmr9860873pfo.31.1674099780151;
        Wed, 18 Jan 2023 19:43:00 -0800 (PST)
Received: from bigtwin1b.gigaio.com ([12.22.252.226])
        by smtp.gmail.com with ESMTPSA id b10-20020aa78eca000000b0058bc37f3d1csm9110435pfr.44.2023.01.18.19.42.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2023 19:42:59 -0800 (PST)
From:   Eric Pilmore <epilmore@gigaio.com>
To:     sanju.mehta@amd.com, dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     Eric Pilmore <epilmore@gigaio.com>
Subject: [PATCH] ptdma: pt_core_execute_cmd() should use spinlock
Date:   Wed, 18 Jan 2023 19:39:08 -0800
Message-Id: <20230119033907.35071-1-epilmore@gigaio.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Eric Pilmore <epilmore@gigaio.com>

The interrupt handler (pt_core_irq_handler()) of the ptdma
driver can be called from interrupt context. The code flow
in this function can lead down to pt_core_execute_cmd() which
will attempt to grab a mutex, which is not appropriate in
interrupt context and ultimately leads to a kernel panic.
The fix here changes this mutex to a spinlock, which has
been verified to resolve the issue.

Fixes: fa5d823b16a94 ("dmaengine: ptdma: Initial driver for the AMD PTDMA")
Signed-off-by: Eric Pilmore <epilmore@gigaio.com>
---
 drivers/dma/ptdma/ptdma-dev.c | 7 ++++---
 drivers/dma/ptdma/ptdma.h     | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index 377da23012ac..a2bf13ff18b6 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -71,12 +71,13 @@ static int pt_core_execute_cmd(struct ptdma_desc *desc, struct pt_cmd_queue *cmd
 	bool soc = FIELD_GET(DWORD0_SOC, desc->dw0);
 	u8 *q_desc = (u8 *)&cmd_q->qbase[cmd_q->qidx];
 	u32 tail;
+	unsigned long flags;
 
 	if (soc) {
 		desc->dw0 |= FIELD_PREP(DWORD0_IOC, desc->dw0);
 		desc->dw0 &= ~DWORD0_SOC;
 	}
-	mutex_lock(&cmd_q->q_mutex);
+	spin_lock_irqsave(&cmd_q->q_lock, flags);
 
 	/* Copy 32-byte command descriptor to hw queue. */
 	memcpy(q_desc, desc, 32);
@@ -91,7 +92,7 @@ static int pt_core_execute_cmd(struct ptdma_desc *desc, struct pt_cmd_queue *cmd
 
 	/* Turn the queue back on using our cached control register */
 	pt_start_queue(cmd_q);
-	mutex_unlock(&cmd_q->q_mutex);
+	spin_unlock_irqrestore(&cmd_q->q_lock, flags);
 
 	return 0;
 }
@@ -199,7 +200,7 @@ int pt_core_init(struct pt_device *pt)
 
 	cmd_q->pt = pt;
 	cmd_q->dma_pool = dma_pool;
-	mutex_init(&cmd_q->q_mutex);
+	spin_lock_init(&cmd_q->q_lock);
 
 	/* Page alignment satisfies our needs for N <= 128 */
 	cmd_q->qsize = Q_SIZE(Q_DESC_SIZE);
diff --git a/drivers/dma/ptdma/ptdma.h b/drivers/dma/ptdma/ptdma.h
index d093c43b7d13..21b4bf895200 100644
--- a/drivers/dma/ptdma/ptdma.h
+++ b/drivers/dma/ptdma/ptdma.h
@@ -196,7 +196,7 @@ struct pt_cmd_queue {
 	struct ptdma_desc *qbase;
 
 	/* Aligned queue start address (per requirement) */
-	struct mutex q_mutex ____cacheline_aligned;
+	spinlock_t q_lock ____cacheline_aligned;
 	unsigned int qidx;
 
 	unsigned int qsize;
-- 
2.38.1

