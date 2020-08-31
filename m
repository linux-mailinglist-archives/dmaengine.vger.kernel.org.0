Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7BD25775E
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHaKga (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHaKgY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:36:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E6CC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so355978pfh.3
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k44gMsX07XTMlTArd+3SB33+vAZam0V8KHCa0v3YAqE=;
        b=tIfN7p5yPRwLYNy43YSm97eEi+rTGTbsKKHhh25nMQsOXiarZA2QYk2BLqbxbgEBc+
         Jv5qregrinD8QGZUvD06aw7tUhbJeMNGeVQ9LDUy1rwNc6ZbjcYa7iSU7w5h9Szk9XRG
         Q+VUvEKU2pBjqkZbQ3COl015baiRG7QQnqeq95SglGs++4jrUUduDUvJ+lhqmjKQg322
         s61xQhc8wqsH5LXr/hL+KZkze3pbvDI3NdH+Qr18LUACQwmN6wpsGTzjXEiE/Cq3tgTM
         UNZngdL929n1J0EkkNXY+c88qYdBIawKlkFrh1JUNSY5ZTMT1AZfxKNhGI9A1SL8ETcs
         LF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k44gMsX07XTMlTArd+3SB33+vAZam0V8KHCa0v3YAqE=;
        b=jHCNQ4m8Zp95BHRxCfb5mvI+eY9kM5wOUYpRliQvQXgORBUgxLse71jKE5nA5ZbmGs
         3VEBs0FNQmZuCkYx28slTFj1ER+i6kMAvJ0DyGXqfNflJf5aJpgUqTPfjZbvGvEyweP/
         1MQk36TBaOqn/JmYS48ER7a1q476a+YFmPXsbtlXtIo1hUUaTZp5DfVkK/NCupW72C6F
         abscMZeoIsZ6ny74KEyDV1KQn15sk4t3pv4bkkvZs8YtchlwO6PdYwI+w5DHKo0vhmXs
         lm14uVVnxxV41xw9ydBGGQ86Gp0Cg+2GEDlDPZHXZR0PI/NUw66nGBgDuXIreR3K1VcN
         GcWQ==
X-Gm-Message-State: AOAM532lz38Ckke6eYgzipFqgW1056br5XTIJb1BRVHx7wtPZMBXs4hj
        So1TCu4UnIApuBDkjeJn7X8=
X-Google-Smtp-Source: ABdhPJzqFlTGEOqjLxgtatKtcihhrImSLRYMM6dUKSWgDcNv33V/dconxicZdGP6tK4+ADurY3AiLw==
X-Received: by 2002:a62:444:: with SMTP id 65mr788657pfe.86.1598870183859;
        Mon, 31 Aug 2020 03:36:23 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:36:23 -0700 (PDT)
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
Subject: [PATCH v3 04/35] dmaengine: coh901318: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:11 +0530
Message-Id: <20200831103542.305571-5-allen.lkml@gmail.com>
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
 drivers/dma/coh901318.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index 1092d4ce723e..95b9b2f5358e 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1868,9 +1868,9 @@ static struct coh901318_desc *coh901318_queue_start(struct coh901318_chan *cohc)
  * This tasklet is called from the interrupt handler to
  * handle each descriptor (DMA job) that is sent to a channel.
  */
-static void dma_tasklet(unsigned long data)
+static void dma_tasklet(struct tasklet_struct *t)
 {
-	struct coh901318_chan *cohc = (struct coh901318_chan *) data;
+	struct coh901318_chan *cohc = from_tasklet(cohc, t, tasklet);
 	struct coh901318_desc *cohd_fin;
 	unsigned long flags;
 	struct dmaengine_desc_callback cb;
@@ -2615,8 +2615,7 @@ static void coh901318_base_init(struct dma_device *dma, const int *pick_chans,
 			INIT_LIST_HEAD(&cohc->active);
 			INIT_LIST_HEAD(&cohc->queue);
 
-			tasklet_init(&cohc->tasklet, dma_tasklet,
-				     (unsigned long) cohc);
+			tasklet_setup(&cohc->tasklet, dma_tasklet);
 
 			list_add_tail(&cohc->chan.device_node,
 				      &dma->channels);
-- 
2.25.1

