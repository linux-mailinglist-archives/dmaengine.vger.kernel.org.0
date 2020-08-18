Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436EA248176
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgHRJIl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJIj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:08:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD131C061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c6so9137951pje.1
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dvX6FlWRqibGpy5qHiY9CD/HZDa4GdoItaD6hrOhnJQ=;
        b=a7lYhqZoZTu2DttvB82PncAAs5gccT68nypV7myi/GwOwO8C3o/YF73D1rChw+UglH
         pv7u/XxdAyZ4pEZUcmJde9sG38aUNhVBkkvO2E082Fn0YRlGLp7pw450NkQZqlQqwcqo
         tj4Jdpb4l/0zTWbclhWzEFS8wfiw9kAldBv5brThWEBp1SPidZ7H8meb3DrNbC1iKjqI
         Pd8ieLNa3Gb2Ffx5UEjKuBvhIPcGvjkMQ9aYYlvIiKRC6/jELxw48AEUr5fpVMZKAY7l
         FOHMFZQhb0Lc/WMvFDB+XLAs2oWIMHua0lwKP1/Oe2osNRKLnm1+t0ERtnGUVxle7klA
         wsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dvX6FlWRqibGpy5qHiY9CD/HZDa4GdoItaD6hrOhnJQ=;
        b=ewq/svfGhO6b26JxqtdasQbGYyjmrEx40Uhky1wshA+JU8Psku44AolLs3KQCu0jm9
         XLOf+FnMawpx5wo6ykRPCJcshz0WRMwbH8Tc0tJyFShu+piaSnc0a+MbdZlXJIwVBzqw
         wDZTMyrDuM+wtyqfJJIk8yKi5vqootIecvHGHOHJo5RKDDz31/797O+mvLfFaZjzsn1n
         +7Kb8OIPdBes5GZksnP1SiCu+gFZN5htaCIWu4HSlBouLNKD1XBmqLoOaTl1xW4j56b0
         btcHI9Nj1g4Emx4YTITVk5KnncYySdAj3u1QQJBrKca8ErP/q/C3xR8t0epfE9M4xGlk
         Hbcw==
X-Gm-Message-State: AOAM5322Phdc0nQb/u0i2RBeL+hIVnXiTLM/WrLXWmmlGcMntkRUTcvk
        QkjnkR7M35ZUhqgoGgFl6tM=
X-Google-Smtp-Source: ABdhPJxgr46jnUzVzPR2mtBi5iXY00fYhmsiWSaOK0CEENEs1jzeU6bRtLX3bCCaWGy1Ptn0lHcZRQ==
X-Received: by 2002:a17:902:ed4a:: with SMTP id y10mr14740037plb.106.1597741718239;
        Tue, 18 Aug 2020 02:08:38 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:08:37 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 22/35] dma: qcom: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:25 +0530
Message-Id: <20200818090638.26362-23-allen.lkml@gmail.com>
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
 drivers/dma/qcom/bam_dma.c  | 6 +++---
 drivers/dma/qcom/hidma.c    | 6 +++---
 drivers/dma/qcom/hidma_ll.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 5a08dd0d3388..8ba7a8f089c8 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1075,9 +1075,9 @@ static void bam_start_dma(struct bam_chan *bchan)
  *
  * Sets up next DMA operation and then processes all completed transactions
  */
-static void dma_tasklet(unsigned long data)
+static void dma_tasklet(struct tasklet_struct *t)
 {
-	struct bam_device *bdev = (struct bam_device *)data;
+	struct bam_device *bdev = from_tasklet(bdev, t, task);
 	struct bam_chan *bchan;
 	unsigned long flags;
 	unsigned int i;
@@ -1293,7 +1293,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_clk;
 
-	tasklet_init(&bdev->task, dma_tasklet, (unsigned long)bdev);
+	tasklet_setup(&bdev->task, dma_tasklet);
 
 	bdev->channels = devm_kcalloc(bdev->dev, bdev->num_channels,
 				sizeof(*bdev->channels), GFP_KERNEL);
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 0a6d3ea08c78..6c0f9eb8ecc6 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -224,9 +224,9 @@ static int hidma_chan_init(struct hidma_dev *dmadev, u32 dma_sig)
 	return 0;
 }
 
-static void hidma_issue_task(unsigned long arg)
+static void hidma_issue_task(struct tasklet_struct *t)
 {
-	struct hidma_dev *dmadev = (struct hidma_dev *)arg;
+	struct hidma_dev *dmadev = from_tasklet(dmadev, t, task);
 
 	pm_runtime_get_sync(dmadev->ddev.dev);
 	hidma_ll_start(dmadev->lldev);
@@ -885,7 +885,7 @@ static int hidma_probe(struct platform_device *pdev)
 		goto uninit;
 
 	dmadev->irq = chirq;
-	tasklet_init(&dmadev->task, hidma_issue_task, (unsigned long)dmadev);
+	tasklet_setup(&dmadev->task, hidma_issue_task);
 	hidma_debug_init(dmadev);
 	hidma_sysfs_init(dmadev);
 	dev_info(&pdev->dev, "HI-DMA engine driver registration complete\n");
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index bb4471e84e48..53244e0e34a3 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -173,9 +173,9 @@ int hidma_ll_request(struct hidma_lldev *lldev, u32 sig, const char *dev_name,
 /*
  * Multiple TREs may be queued and waiting in the pending queue.
  */
-static void hidma_ll_tre_complete(unsigned long arg)
+static void hidma_ll_tre_complete(struct tasklet_struct *t)
 {
-	struct hidma_lldev *lldev = (struct hidma_lldev *)arg;
+	struct hidma_lldev *lldev = from_tasklet(lldev, t, task);
 	struct hidma_tre *tre;
 
 	while (kfifo_out(&lldev->handoff_fifo, &tre, 1)) {
@@ -792,7 +792,7 @@ struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
 		return NULL;
 
 	spin_lock_init(&lldev->lock);
-	tasklet_init(&lldev->task, hidma_ll_tre_complete, (unsigned long)lldev);
+	tasklet_setup(&lldev->task, hidma_ll_tre_complete);
 	lldev->initialized = 1;
 	writel(ENABLE_IRQS, lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
 	return lldev;
-- 
2.17.1

