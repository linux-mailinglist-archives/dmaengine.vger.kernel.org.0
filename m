Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AFF257764
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHaKgy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgHaKgw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64115C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so385058pgl.2
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gSZRlybSosr68du+S8eouqXuhNTnABdaSjfdYOwaFI8=;
        b=QRQiyrvf9uM+yK7JyBGjBZFOcNFQ8qVGtkhuNBRHW7O9vZlwo5p45rRUMA6Q1g/GcK
         Tz2TDwPZJKO2rJkcRlc7kNsJ6nNh11O/WEgwwINLltd3C/FxioVHcfwjHknIqdyURyYO
         zsgZb3O6/KPi5PghcoDdlC82Aft7BgUjv3BPdeIy2v/nVr50VIVlj7uOmqm/Bkypz50G
         Y4KtuNcCD7LoWguAdzFAps7pUWmPLLWrpz2u9KslPNzROnyjFZ329Z+/4AeAo0nBBQCn
         /tgNQCHycjmjwEOo9OvwLDbvZbIyJpPWH190JmKTBSKv+4MpXY5kuyNX2QABIaW0f6tI
         OgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSZRlybSosr68du+S8eouqXuhNTnABdaSjfdYOwaFI8=;
        b=MxroQVRmGX7sd9PGhPN5ITwk1MmAJdSrcefstLjq2sblJD+BrBzR2U9lNalv7AwDIF
         0vCmzmQIGYF6D+Kq/+1vXKJc8YI1oeA8YBDzP5cKXnv6ifOO7ENEileQBPucGE9MohUc
         6MQ5c7sso1QP0SVmqRdJx2IzY0LBt7SegZtIR0wKmuycxy+TqjeFf476/+2GZur10zKw
         uBmGkNuGSvaXgVewojZhJfJrNsS58KFB5PQ8uNMmsJ6TdZCLjwAIaka7KtWVAafoqr7t
         601iqme0aaHkXSgqb9h6Tc0jgdJlLap87mcpq6zPNzP1P/ZgzzWv2MobSmF9xFk+HAjD
         mL+A==
X-Gm-Message-State: AOAM530dh8k92AStR5VObnZSnYXdxwhJm8x6JeIF3Gzn2ZhAn8ZAKRrC
        UdbcMZBqQGE7T2hcGzLdljI=
X-Google-Smtp-Source: ABdhPJwdH1ely4yn6Q9Ct01gYnMkPrud3bt+h5qbhZGTEo4qES6yvTZUGP4s/Xn1j5w3R9biDZXufg==
X-Received: by 2002:a63:475d:: with SMTP id w29mr705459pgk.287.1598870209848;
        Mon, 31 Aug 2020 03:36:49 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:49 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v3 09/35] dmaengine: ioat: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:16 +0530
Message-Id: <20200831103542.305571-10-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831103542.305571-1-allen.lkml@gmail.com>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/ioat/dma.c  | 6 +++---
 drivers/dma/ioat/dma.h  | 2 +-
 drivers/dma/ioat/init.c | 4 +---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index a814b200299b..bfcf67febfe6 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -165,7 +165,7 @@ void ioat_stop(struct ioatdma_chan *ioat_chan)
 	tasklet_kill(&ioat_chan->cleanup_task);
 
 	/* final cleanup now that everything is quiesced and can't re-arm */
-	ioat_cleanup_event((unsigned long)&ioat_chan->dma_chan);
+	ioat_cleanup_event(&ioat_chan->cleanup_task);
 }
 
 static void __ioat_issue_pending(struct ioatdma_chan *ioat_chan)
@@ -690,9 +690,9 @@ static void ioat_cleanup(struct ioatdma_chan *ioat_chan)
 	spin_unlock_bh(&ioat_chan->cleanup_lock);
 }
 
-void ioat_cleanup_event(unsigned long data)
+void ioat_cleanup_event(struct tasklet_struct *t)
 {
-	struct ioatdma_chan *ioat_chan = to_ioat_chan((void *)data);
+	struct ioatdma_chan *ioat_chan = from_tasklet(ioat_chan, t, cleanup_task);
 
 	ioat_cleanup(ioat_chan);
 	if (!test_bit(IOAT_RUN, &ioat_chan->state))
diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index f7f31fdf14cf..140cfe3782fb 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -393,7 +393,7 @@ int ioat_reset_hw(struct ioatdma_chan *ioat_chan);
 enum dma_status
 ioat_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate);
-void ioat_cleanup_event(unsigned long data);
+void ioat_cleanup_event(struct tasklet_struct *t);
 void ioat_timer_event(struct timer_list *t);
 int ioat_check_space_lock(struct ioatdma_chan *ioat_chan, int num_descs);
 void ioat_issue_pending(struct dma_chan *chan);
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 8a53f5c96b16..191b59279007 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -767,8 +767,6 @@ ioat_init_channel(struct ioatdma_device *ioat_dma,
 		  struct ioatdma_chan *ioat_chan, int idx)
 {
 	struct dma_device *dma = &ioat_dma->dma_dev;
-	struct dma_chan *c = &ioat_chan->dma_chan;
-	unsigned long data = (unsigned long) c;
 
 	ioat_chan->ioat_dma = ioat_dma;
 	ioat_chan->reg_base = ioat_dma->reg_base + (0x80 * (idx + 1));
@@ -778,7 +776,7 @@ ioat_init_channel(struct ioatdma_device *ioat_dma,
 	list_add_tail(&ioat_chan->dma_chan.device_node, &dma->channels);
 	ioat_dma->idx[idx] = ioat_chan;
 	timer_setup(&ioat_chan->timer, ioat_timer_event, 0);
-	tasklet_init(&ioat_chan->cleanup_task, ioat_cleanup_event, data);
+	tasklet_setup(&ioat_chan->cleanup_task, ioat_cleanup_event);
 }
 
 #define IOAT_NUM_SRC_TEST 6 /* must be <= 8 */
-- 
2.25.1

