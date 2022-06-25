Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4D555A7DA
	for <lists+dmaengine@lfdr.de>; Sat, 25 Jun 2022 09:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiFYHpA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 25 Jun 2022 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiFYHo5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 25 Jun 2022 03:44:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFA3473BD;
        Sat, 25 Jun 2022 00:44:54 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LVQwt5SqzzDsS8;
        Sat, 25 Jun 2022 15:44:14 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 15:44:51 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 25 Jun 2022 15:44:50 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] dmaengine: hisilicon: Use macros instead of magic number
Date:   Sat, 25 Jun 2022 15:44:18 +0800
Message-ID: <20220625074422.3479591-5-haijie1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20220625074422.3479591-1-haijie1@huawei.com>
References: <20220625074422.3479591-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

readl_relaxed_poll_timeout() uses magic numbers 10 and 1000, which
indicate maximum time to sleep between reads in us and timeout in us,
respectively.

Use macros HISI_DMA_POLL_Q_STS_DELAY_US and
HISI_DMA_POLL_Q_STS_TIME_OUT_US instead of these two numbers.

Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 drivers/dma/hisi_dma.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 0385419be8d5..d69a73272467 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -36,6 +36,9 @@
 
 #define PCI_BAR_2			2
 
+#define HISI_DMA_POLL_Q_STS_DELAY_US	10
+#define HISI_DMA_POLL_Q_STS_TIME_OUT_US	1000
+
 enum hisi_dma_mode {
 	EP = 0,
 	RC,
@@ -185,15 +188,20 @@ static void hisi_dma_reset_or_disable_hw_chan(struct hisi_dma_chan *chan,
 {
 	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
 	u32 index = chan->qp_num, tmp;
+	void __iomem *addr;
 	int ret;
 
 	hisi_dma_pause_dma(hdma_dev, index, true);
 	hisi_dma_enable_dma(hdma_dev, index, false);
 	hisi_dma_mask_irq(hdma_dev, index);
 
-	ret = readl_relaxed_poll_timeout(hdma_dev->base +
-		HISI_DMA_Q_FSM_STS + index * HISI_DMA_OFFSET, tmp,
-		FIELD_GET(HISI_DMA_FSM_STS_MASK, tmp) != RUN, 10, 1000);
+	addr = hdma_dev->base +
+	       HISI_DMA_Q_FSM_STS + index * HISI_DMA_Q_OFFSET;
+
+	ret = readl_relaxed_poll_timeout(addr, tmp,
+		FIELD_GET(HISI_DMA_Q_FSM_STS_MASK, tmp) != RUN,
+		HISI_DMA_POLL_Q_STS_DELAY_US,
+		HISI_DMA_POLL_Q_STS_TIME_OUT_US);
 	if (ret) {
 		dev_err(&hdma_dev->pdev->dev, "disable channel timeout!\n");
 		WARN_ON(1);
@@ -208,9 +216,10 @@ static void hisi_dma_reset_or_disable_hw_chan(struct hisi_dma_chan *chan,
 		hisi_dma_unmask_irq(hdma_dev, index);
 	}
 
-	ret = readl_relaxed_poll_timeout(hdma_dev->base +
-		HISI_DMA_Q_FSM_STS + index * HISI_DMA_OFFSET, tmp,
-		FIELD_GET(HISI_DMA_FSM_STS_MASK, tmp) == IDLE, 10, 1000);
+	ret = readl_relaxed_poll_timeout(addr, tmp,
+		FIELD_GET(HISI_DMA_Q_FSM_STS_MASK, tmp) == IDLE,
+		HISI_DMA_POLL_Q_STS_DELAY_US,
+		HISI_DMA_POLL_Q_STS_TIME_OUT_US);
 	if (ret) {
 		dev_err(&hdma_dev->pdev->dev, "reset channel timeout!\n");
 		WARN_ON(1);
-- 
2.33.0

