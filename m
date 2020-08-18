Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E862248162
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgHRJH2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJH1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AB6C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so9653042pfw.9
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=31As0TImtle4pJMBIPFKRSxatdRKcSvERFzrO8LgibE=;
        b=Yf9fhpW2xYEAkMsM65bX19TKhEZlPuAf4Xg/LVZQN5ktmfpMfC0yAHQkFVNXayuL8k
         ZYkOUoCBS74heX5h3lBSJZr4pgNxzTUmRAow4miw0fSL7Ijm+jBLNBvDdOgWuIVKEDoJ
         vwVya5Wpxng6EqIZRFWyh1TVR9+H/Im+qi32RnWGguwsAuQxL3FjScmKYUKm4V/Quuzl
         cMbmL6IEeSPs58+za8YQb8JIEQOYj7RcpBsKLLw2qhsUVm3yJVbnq+zGRCH9GyyVk39g
         JiszvWVdDllXW0mjd+sO5FClQnzg/rKjkrpEy5bRNQr4pvi0dBhHjrFQxFY0n3nZCt9X
         iaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=31As0TImtle4pJMBIPFKRSxatdRKcSvERFzrO8LgibE=;
        b=cPBDt8WefCAJ/8z9Nx6odxkMy4885S+1QflsU1nff06l4EG26qskuqHe9y7YsktQss
         Exs5a0WQJXTv7tWh8eKrhq4eYHmJSRaeqPZS8Vwr1af3+sm2ApTTUznn3StGsMdkn4F9
         hBdmgH/E6LEKmK831Hde6FRB+ZwKrMUSs+SWgKbukcC0dIvwAyCUl2+H/1n+p8b67ewO
         QGkZX451y+JOAFxd91bU+iGye+qPuItkS8GTRo6vo40zSk0Xq9emq/zs7tSwYwCF5Eu0
         1vtQiX50KvLo+aDGyfZYMQ2431PYVzP2LiaywWrSP8hjGbCV1J3sDVnl3oMnZp5CSmOk
         wHcQ==
X-Gm-Message-State: AOAM531oXbgn7ZrBZcpTzYjoyIkAOHDRQq4ylZuASu+OexKqMud9/Y3J
        j5WFQtfCCUiYQf/4kf+6vDU=
X-Google-Smtp-Source: ABdhPJwCZNLXg37WfEY8vynP6KS80RMvaNt7/yher3LKv4EgXz9BrycSQM4r8m/FDjzrdgvd/UunuA==
X-Received: by 2002:aa7:947b:: with SMTP id t27mr14190181pfq.117.1597741647376;
        Tue, 18 Aug 2020 02:07:27 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:26 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 07/35] dma: fsl: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:10 +0530
Message-Id: <20200818090638.26362-8-allen.lkml@gmail.com>
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
 drivers/dma/fsl_raid.c | 6 +++---
 drivers/dma/fsldma.c   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 493dc6c59d1d..26764bf2fc6d 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -154,9 +154,9 @@ static void fsl_re_cleanup_descs(struct fsl_re_chan *re_chan)
 	fsl_re_issue_pending(&re_chan->chan);
 }
 
-static void fsl_re_dequeue(unsigned long data)
+static void fsl_re_dequeue(struct tasklet_struct *t)
 {
-	struct fsl_re_chan *re_chan;
+	struct fsl_re_chan *re_chan from_tasklet(re_chan, t, irqtask);
 	struct fsl_re_desc *desc, *_desc;
 	struct fsl_re_hw_desc *hwdesc;
 	unsigned long flags;
@@ -671,7 +671,7 @@ static int fsl_re_chan_probe(struct platform_device *ofdev,
 	snprintf(chan->name, sizeof(chan->name), "re_jr%02d", q);
 
 	chandev = &chan_ofdev->dev;
-	tasklet_init(&chan->irqtask, fsl_re_dequeue, (unsigned long)chandev);
+	tasklet_setup(&chan->irqtask, fsl_re_dequeue);
 
 	ret = request_irq(chan->irq, fsl_re_isr, 0, chan->name, chandev);
 	if (ret) {
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index ad72b3f42ffa..3ce9cf3d62f5 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -976,9 +976,9 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void dma_do_tasklet(unsigned long data)
+static void dma_do_tasklet(struct tasklet_struct *t)
 {
-	struct fsldma_chan *chan = (struct fsldma_chan *)data;
+	struct fsldma_chan *chan = from_tasklet(chan, t, tasklet);
 
 	chan_dbg(chan, "tasklet entry\n");
 
@@ -1151,7 +1151,7 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	}
 
 	fdev->chan[chan->id] = chan;
-	tasklet_init(&chan->tasklet, dma_do_tasklet, (unsigned long)chan);
+	tasklet_setup(&chan->tasklet, dma_do_tasklet);
 	snprintf(chan->name, sizeof(chan->name), "chan%d", chan->id);
 
 	/* Initialize the channel */
-- 
2.17.1

