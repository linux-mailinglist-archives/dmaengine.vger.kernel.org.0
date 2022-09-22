Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3FB5E6353
	for <lists+dmaengine@lfdr.de>; Thu, 22 Sep 2022 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiIVNNA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Sep 2022 09:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiIVNM4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Sep 2022 09:12:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5DEC57F;
        Thu, 22 Sep 2022 06:12:49 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MYFwL1fbNzWgyY;
        Thu, 22 Sep 2022 21:08:50 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 21:12:46 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 21:12:45 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <vkoul@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: [PATCH v2 -next 1/3] dmaengine: qcom: bam_dma: fix PM usage counter unbalance in bam_dma
Date:   Thu, 22 Sep 2022 21:16:16 +0800
Message-ID: <20220922131616.104320-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here.
We fix it by replacing it with the newer pm_runtime_resume_and_get
to keep usage counter balanced.

Fixes:0ac9c3dd0d6fe ("dmaengine: qcom: bam_dma: fix runtime PM underflow")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/dma/qcom/bam_dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 2ff787df513e..415ad0008f18 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -573,7 +573,7 @@ static void bam_free_chan(struct dma_chan *chan)
 	unsigned long flags;
 	int ret;
 
-	ret = pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_resume_and_get(bdev->dev);
 	if (ret < 0)
 		return;
 
@@ -776,7 +776,7 @@ static int bam_pause(struct dma_chan *chan)
 	unsigned long flag;
 	int ret;
 
-	ret = pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_resume_and_get(bdev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -802,7 +802,7 @@ static int bam_resume(struct dma_chan *chan)
 	unsigned long flag;
 	int ret;
 
-	ret = pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_resume_and_get(bdev->dev);
 	if (ret < 0)
 		return ret;
 
@@ -911,7 +911,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 	if (srcs & P_IRQ)
 		tasklet_schedule(&bdev->task);
 
-	ret = pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_resume_and_get(bdev->dev);
 	if (ret < 0)
 		return IRQ_NONE;
 
@@ -1029,7 +1029,7 @@ static void bam_start_dma(struct bam_chan *bchan)
 	if (!vd)
 		return;
 
-	ret = pm_runtime_get_sync(bdev->dev);
+	ret = pm_runtime_resume_and_get(bdev->dev);
 	if (ret < 0)
 		return;
 
-- 
2.25.1

