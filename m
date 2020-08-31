Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50134257775
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHaKiA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 06:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgHaKh6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Aug 2020 06:37:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCAAC061573
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j11so2815078plk.9
        for <dmaengine@vger.kernel.org>; Mon, 31 Aug 2020 03:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kndVuf3XgQoygeCo+RpOK5304Nin4tEnJh5Xe+1hjc=;
        b=DcVx9Y6xIpRyheS8BHhXfLOWVGOO6q3Y36PHXL7B9mAwlDOb4S5DRfeL9Lv13mtB9M
         0IZ03+VFfUR/SlGAiIELc4BVpX+XM8wUjcLrCx57sHxxyKBC29bLfQT4XEme6zwfugT/
         Or8g8PI6ugcNIpfHPbPzWShm6ETk335Pl65BTrzyoKwiATGHYBs6GkoA2VRuU0gSpnn7
         DibJgkL5ucKU/0iERqOsOE0qw92+tYAyk7EdcKbkeeLL8fex0tf2Pmhbg+jDFTPsvtvN
         nWKlrTZCfkkeuX569bm+OX4IK1h7DnFB7WJJuw9oOnEZ0bAD4rYvD1R/CV0iMQPu7T4Z
         nTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kndVuf3XgQoygeCo+RpOK5304Nin4tEnJh5Xe+1hjc=;
        b=He39/3fnt4VB1mPUIQFDFElku9S0SvcfOiK0phSY7r2GB+mcfEECNft7Tr5qzthXzL
         C+W5ecrFAIctCTI1gffKxKh4fuHftoDP635oDV8HNjvkbICl9xN8JmSC80bBiZF1/t5R
         iNPA8ZqLOFSOFPUlLr7ZBpbQQxzMINbQPvH9MEzvciyRcrEdoRo9VGGlBF7nwOdwOnRH
         Z3H6SezlKzvcpdAWQh2bJ4XuPfYLO1aMb/meAbbaM6afDz3P/VlSwBVHjY2XWU4uySbb
         uDooh+HOPeqwtTcTKY/idGgNb7SZn9QOwPhACA+nkflF72S2BeICxfrj1+vdilyf26og
         lF2g==
X-Gm-Message-State: AOAM531tTXT91BDi+0orc0vDXIfpunxJdvB2icFzUWyj2aYSZJhjByJh
        CxChu4NLVq94FOjSthSk7RU=
X-Google-Smtp-Source: ABdhPJwYriKWqWI7yi3pwRgEQA7PD5OrJhnz7ZkJoQ2ZsIEogkBD4L6D6wE0KXSzCxXv/QRS9Fp61w==
X-Received: by 2002:a17:90a:2bc8:: with SMTP id n8mr783250pje.189.1598870278146;
        Mon, 31 Aug 2020 03:37:58 -0700 (PDT)
Received: from localhost.localdomain ([49.207.204.90])
        by smtp.gmail.com with ESMTPSA id x6sm6895449pge.61.2020.08.31.03.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:37:57 -0700 (PDT)
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
Subject: [PATCH v3 22/35] dmaengine: qcom: convert tasklets to use new tasklet_setup() API
Date:   Mon, 31 Aug 2020 16:05:29 +0530
Message-Id: <20200831103542.305571-23-allen.lkml@gmail.com>
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
2.25.1

