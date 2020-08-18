Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4560A248174
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgHRJIa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgHRJI3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAB1C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x25so9667129pff.4
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2u/40339c50ypFs7M618Prb7hCf6hscGSknPACX7w9w=;
        b=dKQ7XOywsUCd+xNSMZnHL1zymT5h8KFhNeJoIrRuOCAR97LGhBfeJ9OyvcraJ8J77d
         IJNO/uqepQLdfDg1QJAgiA3fdamFNek/blMR4yLTWxWHIAC6XRQf+heaUbbhvauW5ZBa
         4MMn2ew6fscwJDbkCVKMwsKflXAkogTgmazyI2H63DBt8C1Pox0sUOO/+ZAzIMaEuU3l
         t2X/L72i+S7yigfMwOBAgZkGozfa2Ji/bBWEUOSJf8WC1OpFg0LXhRLhVspVAgDGPvzp
         egJVUGARHGV0P6HzwxMGu53JZ8Zt6QtxUTwW98HnuHFh/AmxWw7W1vu57A8epgMWQJWF
         8zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2u/40339c50ypFs7M618Prb7hCf6hscGSknPACX7w9w=;
        b=H7NBFTHmHSed9H9c0TICed1AGOOBBDqgaQKts4lHIA8GULKAYczT+MLz4/I1BLuYxS
         951IUOxutHof151dvX7hsgrI4c4TQb/TdTC9YbcdZZ3Bycwvl6I+Xmgfas9KfqW+x+yS
         V7sPA3VWixJSEUlYu4YkBioy6922KLTMzT+gXyu8+QQpHlZNCc3L0IGC+v/+2YrJDGGz
         CSrxUeX/viCzSSLfa1zKJ1GV9RunDztLAjlAVgSXhPaGFX6BvIDh4r9QPBigyHxJiyKv
         dROQglSNh/26QdiszNcZ42A5VyWvmH3udBFM7044FQJGx0EsJm/SWSQ0Mg2fpMi2ENuA
         V2QQ==
X-Gm-Message-State: AOAM530/sTMrbA68alC7saBWTANGiDuW2OmTnkCvfRV/yivC2CsaeO/Q
        bzukV2sWpZHJMNQO4OLmSlM=
X-Google-Smtp-Source: ABdhPJzE+qzdxh+5Xj5ZSZ2Il5hxsrRssw2KakhpWCwcLgdyePxwEz6ZyXBfpcHqjJ+oX9pBV7cMKA==
X-Received: by 2002:aa7:980f:: with SMTP id e15mr14443865pfl.194.1597741708699;
        Tue, 18 Aug 2020 02:08:28 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:28 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 20/35] dma: pl330: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:23 +0530
Message-Id: <20200818090638.26362-21-allen.lkml@gmail.com>
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
 drivers/dma/pl330.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 2c508ee672b9..5599d350ec79 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1580,9 +1580,9 @@ static void dma_pl330_rqcb(struct dma_pl330_desc *desc, enum pl330_op_err err)
 	tasklet_schedule(&pch->task);
 }
 
-static void pl330_dotask(unsigned long data)
+static void pl330_dotask(struct tasklet_struct *t)
 {
-	struct pl330_dmac *pl330 = (struct pl330_dmac *) data;
+	struct pl330_dmac *pl330 = from_tasklet(pl330, t, tasks);
 	unsigned long flags;
 	int i;
 
@@ -1986,7 +1986,7 @@ static int pl330_add(struct pl330_dmac *pl330)
 		return ret;
 	}
 
-	tasklet_init(&pl330->tasks, pl330_dotask, (unsigned long) pl330);
+	tasklet_setup(&pl330->tasks, pl330_dotask);
 
 	pl330->state = INIT;
 
@@ -2069,9 +2069,9 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
 	}
 }
 
-static void pl330_tasklet(unsigned long data)
+static void pl330_tasklet(struct tasklet_struct *t)
 {
-	struct dma_pl330_chan *pch = (struct dma_pl330_chan *)data;
+	struct dma_pl330_chan *pch = from_tasklet(pch, t, task);
 	struct dma_pl330_desc *desc, *_dt;
 	unsigned long flags;
 	bool power_down = false;
@@ -2179,7 +2179,7 @@ static int pl330_alloc_chan_resources(struct dma_chan *chan)
 		return -ENOMEM;
 	}
 
-	tasklet_init(&pch->task, pl330_tasklet, (unsigned long) pch);
+	tasklet_setup(&pch->task, pl330_tasklet);
 
 	spin_unlock_irqrestore(&pl330->lock, flags);
 
-- 
2.17.1

