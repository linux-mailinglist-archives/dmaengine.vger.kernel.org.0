Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE759257ABC
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgHaNsI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHaNsA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 09:48:00 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45265C061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 06:48:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so3035531plb.12
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vywUkL7JCdzm/J9Nqy3BgvINYlUhWd5GM04GnOGUXjw=;
        b=UCSzd5JE+lKwVHezyPrOPW57as/Lqr+V8c0GQSaeIeSJ2Yu8wmX+SPCNtTPYK9vzFl
         Viqin2z2tO7XOdnUS8nIr5bMDtXXldRWzcNe471tW/Wb9sasBOb4G4mjY26vk1Qw6cl/
         K6mGFvNVBfBAcbfva6u3KKVKtwOLheV0k+XKuqxnc3WFbg7dg1H+xryU/f5kDstg7qSf
         SUrHXz81ekaJYNNnNXqz5Y6A1FRfBd8Ky17CrWjeWhODK6nBgI+ihaxFuIyj4pW6iNJ4
         Sd5eWHgAvlai7uqNPv6k+bptuwXHE31yb/mrtrYnf9wIM1gFIhjvYFbKFuesbHWPWxcH
         vPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vywUkL7JCdzm/J9Nqy3BgvINYlUhWd5GM04GnOGUXjw=;
        b=XqPyakl1oXc2c9oWYh+8Mzk4qAMn3AINelRm+aABMTIJJCljBHIS9jPnb+VYkViQ7z
         ydHhxkWOh+t1ZYTBFUy5CzJUeci9m9xPD+HCR1C1B+wJbhCmV1d3YMZPrKT89Es73WcJ
         MthZ+AgmYBv+bKafEW9A0WZz7if5oI6NZC4Z2R/Qf924l++TcEgjPZFQkNC+GQU++Quk
         RAf3VhPWUjjzOhsTLlpX+jf5rvAOPbewzV+s7MfDGcfwaP/yxGbNJlDIoR9kryoAotZJ
         zUY0qP132VOKw/qYfooqa3ySTgQ3glLL9+t7lds10C9ENmGzDstG5E7+rSEu3ATnHi7g
         vRWw==
X-Gm-Message-State: AOAM531vRa6hNakdYnGLAaJRG3well3zcpuP5Z3S2I+qDs3Kc7krMfKY
        OMWlJNE07YcbVSjepE6GYIY=
X-Google-Smtp-Source: ABdhPJyZveZKvpDHUJNBLOzGWIzYjmY+FOwDNsDmKsAJWJhPkP0vCDbdDbPqU+lRQSfUKVREh7gMHA==
X-Received: by 2002:a17:902:42:: with SMTP id 60mr581497pla.277.1598881679862;
        Mon, 31 Aug 2020 06:47:59 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id d4sm7367038pju.56.2020.08.31.06.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 06:47:59 -0700 (PDT)
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
Subject: [PATCH] [RESEND]dmaengine: fsl: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 19:17:45 +0530
Message-Id: <20200831134745.314945-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/dma/fsl_raid.c | 6 +++---
 drivers/dma/fsldma.c   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 493dc6c59d1d..1ddd7cee2e7a 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -154,9 +154,9 @@ static void fsl_re_cleanup_descs(struct fsl_re_chan *re_chan)
 	fsl_re_issue_pending(&re_chan->chan);
 }
 
-static void fsl_re_dequeue(unsigned long data)
+static void fsl_re_dequeue(struct tasklet_struct *t)
 {
-	struct fsl_re_chan *re_chan;
+	struct fsl_re_chan *re_chan = from_tasklet(re_chan, t, irqtask);
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
index e342cf52d296..0feb323bae1e 100644
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
2.25.1

