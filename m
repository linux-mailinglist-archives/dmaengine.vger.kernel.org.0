Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C57248165
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHRJHh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHRJHg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62CAC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so7359146plr.11
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jWR4tpYKdIgwTfTifXGcZkODpDZhHIDKqvJr9MK44Qo=;
        b=XKKbR6Urf24/2tPNVuqNT2rPrMjmt323FoLr6MWaqu0oiehf+Qnzuw+S5GItLdxjkn
         Npi22AKlZbSvDY6nU5WKTQ5CUFhExKpfl4sZ8nb9VVG/wXetSacUs9sXMcWtS4n3DmrX
         R9ImbN74WuLWwdHqH9PKuFDC5sLf+eW3F1Eseh671oCp4mlrxpDfKatB+TWCK2mffRY5
         O9BR+DLyld2tsYeZlrJBo69gVbWqaBfikKR7xEyE3spWk3MYz0cMsM4akprJJpXvrEM+
         lWYSkssnI5jG8FmiQJcpNdBSZiRmtoliUGDbLUuRAWVZNyDkLvKrb3nvbX/ITiaDlzCY
         nPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jWR4tpYKdIgwTfTifXGcZkODpDZhHIDKqvJr9MK44Qo=;
        b=mvGbqDusXp8ufE+/1VOoV5jF249DEjcgw3LVSj9cdcyVCPXaET5OAmPsZg+9aG+8P8
         syYS/qW5Y3KKpvXnDZi9GryNnb04MVRP5j+B42YRYrPwLVkq7Aywnn8YDAYYmG6zZ0iZ
         2KsfgmDFW53YHXwlbKXGkYrrFB06gcKoAWi7vCLtzSUk8gtMlxs/Kdcbco6NVGOTG4i3
         z43zbaV2W5Zfpaw2j38NjdXofNAPchPdarDD4qvRBpIgKu6qGxJecrkhY8kY09am/TSG
         cf94ZOwr34eO4u9E8bykJkTG5wfUGtiaXfEXMMFSSsFu1sh3OAAUM0wV6dGkhsOg9yMJ
         ak2Q==
X-Gm-Message-State: AOAM5333YN3nc7xeJFY+NmZSG5m4oBKpTOBziMzONkiKwZCHNRxqgn8W
        93/sDyj3Ogt3XPpTNjWPzEE=
X-Google-Smtp-Source: ABdhPJwqjDuv3NQX4sgZyBNatIYx8zuOfGO+J5G8O0gdhqdXVzJXnR1aqdOJt8I9fMpimAXGdAhLjA==
X-Received: by 2002:a17:902:c3c9:: with SMTP id j9mr14980864plj.62.1597741656369;
        Tue, 18 Aug 2020 02:07:36 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:35 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 09/35] dma: ioat: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:12 +0530
Message-Id: <20200818090638.26362-10-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
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
2.17.1

