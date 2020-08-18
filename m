Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5D248183
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHRJJY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHRJJV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:09:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55843C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so8961600pjb.2
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7Q+JLR8+W/rWkKJtwswByUgPhPynE2pfcWEkcTUtiM=;
        b=SWfcZgfK0hoB8N9ro8ZhhYFk9ffx3WOztkEt9fJHq7v96ZxYk0rZbwxcVv5+9wW4KK
         MDamE+8Cy4m62TlpGzwzzWiwswwb5Ut0ch2Iv1jN9bDuUFUnW0gw1jyDyfh5Pgc8z91n
         UwlSsqYK3DIsWb/rBRSNmFcXWLh9h5HgPDvox9Tyfiwt3/8k7nQQPLpviQJpAUpA7K87
         kA3FuyIcIHRxbxEFqqI9GuETEabaFa1mTzqlQjRJKq7rCeZQS1ymvTRWvdTL4xuQDjij
         D20591JHuEHK1LxtzL55NEPgsJPd28uCg8xF//n6aTiuCa4nHmMK2U+ar6J32x2azN0m
         t07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K7Q+JLR8+W/rWkKJtwswByUgPhPynE2pfcWEkcTUtiM=;
        b=HAzW0GP90e7HMjfCyA/h3JZCMr5ssPYiR3ak13wbaLeXV/MnQFq6r7MgwfaLON5s40
         TW/NkIR3oedPwV4THsjN37bq4F51ZGhkZDMwMmhVbdFuwTJ8RWkAq1fjzMckF+95Nkbu
         JFSwEwXabgnMVDnkgsT9PBhFx200P4z4FOz9u7dnYmZMpdnKdzDhCJHnEKl2nGoMJNx1
         t7aDc06iQA0ZP63N/4sVTSzMh9UPeSiRYB60gMCFb9I5TaaFt/RJZ1kJiTUwJ4Q40/1B
         PbBb4Si0NVXBUphf0C13isYei+dyA2W7EiURB0G+jqfj3t+EWhdvREzRQSa5Ryhhkiet
         4b4A==
X-Gm-Message-State: AOAM530U770RIsDcGPnvYk1FVCmagDyNwN6y07P1mHkOgAd+rjsb+KQu
        kQDsVBXAUMx2KZYyZUxXXx4=
X-Google-Smtp-Source: ABdhPJybyh8OekSLAgYU3NkwR+eiwnXmBQDp7nnVBXAhHyhBIaD8lpaLao9m36fbVDNTC8Wwnl9zWw==
X-Received: by 2002:a17:90a:ff92:: with SMTP id hf18mr16091715pjb.107.1597741760945;
        Tue, 18 Aug 2020 02:09:20 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:09:20 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 31/35] dma: xgene: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:34 +0530
Message-Id: <20200818090638.26362-32-allen.lkml@gmail.com>
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
 drivers/dma/xgene-dma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 4f733d37a22e..3589b4ef50b8 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -975,9 +975,9 @@ static enum dma_status xgene_dma_tx_status(struct dma_chan *dchan,
 	return dma_cookie_status(dchan, cookie, txstate);
 }
 
-static void xgene_dma_tasklet_cb(unsigned long data)
+static void xgene_dma_tasklet_cb(struct tasklet_struct *t)
 {
-	struct xgene_dma_chan *chan = (struct xgene_dma_chan *)data;
+	struct xgene_dma_chan *chan = from_tasklet(chan, t, tasklet);
 
 	/* Run all cleanup for descriptors which have been completed */
 	xgene_dma_cleanup_descriptors(chan);
@@ -1539,8 +1539,7 @@ static int xgene_dma_async_register(struct xgene_dma *pdma, int id)
 	INIT_LIST_HEAD(&chan->ld_pending);
 	INIT_LIST_HEAD(&chan->ld_running);
 	INIT_LIST_HEAD(&chan->ld_completed);
-	tasklet_init(&chan->tasklet, xgene_dma_tasklet_cb,
-		     (unsigned long)chan);
+	tasklet_setup(&chan->tasklet, xgene_dma_tasklet_cb);
 
 	chan->pending = 0;
 	chan->desc_pool = NULL;
-- 
2.17.1

