Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0F24816D
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHRJIA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHRJIA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E720C061342
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c6so9137255pje.1
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jvxuy1l/tmoRx6ToQ9/CnHSagxvVLNtLIuN2aBXKG9w=;
        b=mbFFtVBkZxhC6KXfo0Hm6xW8t3/4oBnAbolVL1NCdj1ZMtoeLAUnJG2jH/DWTNckwL
         8gIK/9MdehbzvU7wvOzLqI0+UO8Rt3CvzeJlXzW5Gm/M/TTRGnCHx0LXbjHssqsxAoW2
         GJ9vGL06y29B4R99KmNDGRa1+JCWCYWmri51it1redIAh5tLn9kKwS5sLpARv7IXQIK4
         lsIrakMA9obSvtM2TUVxid3LQ5Cn7HvsbyPxdeSVlbeowvOLCM5gJ61Qb2CCmUz+qYP+
         XCA/Upwa2F+mGm3PBSYrE9vdzF313ycxBsEqL6irdCjps87bG2q82Z9VqyKcqr0JIJEl
         uGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jvxuy1l/tmoRx6ToQ9/CnHSagxvVLNtLIuN2aBXKG9w=;
        b=ifkXD5tHNP7n5aC29NuELr4uP1JaieeMy63x1/ahat8keWRsyu7Rt7rnvSP6xw3TxH
         Q2/DR3n3BXX5rnCp42lIDEOwAtmkvZgPoAqgjQHowglrIuT1rP2JTvN04bA+OJzFLx8/
         Md9IC7mCsobPa+5gGe1gX/xd29jjMAmc5ykoPAmgFd3W4NCR4RTzAc3bB+TNALxKWGjS
         CH0dDdnumRCCw65o+fF6VI0rdsCEf7Vdg4HvWgzX/K7Tu/LyyXjIDUbqUvx3UBapOfle
         Vu9/o5YXnENTkAgM9K2ZrLvp20KSdiIhW5LRjZ6PLMYtfUql0UQ6FH2wIHAr6TRqwH+w
         6CTA==
X-Gm-Message-State: AOAM530wKFZc5VFOpn2+wBdB3lkEkVDZrxhzgcBHUTRZI+NR0C7x2Fkx
        5pQfGS8zVuLth9qDJbJFa+U=
X-Google-Smtp-Source: ABdhPJxmOxfaZoR6VjP9Hm66qK6YJqavHpARoge0n+06fLI1CsR2X+wAb0zenbAMacWQ3yVsZ7RJ9Q==
X-Received: by 2002:a17:90a:36a7:: with SMTP id t36mr16189053pjb.36.1597741679866;
        Tue, 18 Aug 2020 02:07:59 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:59 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 14/35] dma: mmp: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:17 +0530
Message-Id: <20200818090638.26362-15-allen.lkml@gmail.com>
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
 drivers/dma/mmp_pdma.c | 6 +++---
 drivers/dma/mmp_tdma.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index f42f792db277..b84303be8edf 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -873,9 +873,9 @@ static void mmp_pdma_issue_pending(struct dma_chan *dchan)
  * Do call back
  * Start pending list
  */
-static void dma_do_tasklet(unsigned long data)
+static void dma_do_tasklet(struct tasklet_struct *t)
 {
-	struct mmp_pdma_chan *chan = (struct mmp_pdma_chan *)data;
+	struct mmp_pdma_chan *chan = from_tasklet(chan, t, tasklet);
 	struct mmp_pdma_desc_sw *desc, *_desc;
 	LIST_HEAD(chain_cleanup);
 	unsigned long flags;
@@ -993,7 +993,7 @@ static int mmp_pdma_chan_init(struct mmp_pdma_device *pdev, int idx, int irq)
 	spin_lock_init(&chan->desc_lock);
 	chan->dev = pdev->dev;
 	chan->chan.device = &pdev->device;
-	tasklet_init(&chan->tasklet, dma_do_tasklet, (unsigned long)chan);
+	tasklet_setup(&chan->tasklet, dma_do_tasklet);
 	INIT_LIST_HEAD(&chan->chain_pending);
 	INIT_LIST_HEAD(&chan->chain_running);
 
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 960c7c40aef7..a262e0eb4cc9 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -346,9 +346,9 @@ static irqreturn_t mmp_tdma_int_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 }
 
-static void dma_do_tasklet(unsigned long data)
+static void dma_do_tasklet(struct tasklet_struct *t)
 {
-	struct mmp_tdma_chan *tdmac = (struct mmp_tdma_chan *)data;
+	struct mmp_tdma_chan *tdmac = from_tasklet(tdmac, t, tasklet);
 
 	dmaengine_desc_get_callback_invoke(&tdmac->desc, NULL);
 }
@@ -586,7 +586,7 @@ static int mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
 	tdmac->pool	   = pool;
 	tdmac->status = DMA_COMPLETE;
 	tdev->tdmac[tdmac->idx] = tdmac;
-	tasklet_init(&tdmac->tasklet, dma_do_tasklet, (unsigned long)tdmac);
+	tasklet_setup(&tdmac->tasklet, dma_do_tasklet);
 
 	/* add the channel to tdma_chan list */
 	list_add_tail(&tdmac->chan.device_node,
-- 
2.17.1

