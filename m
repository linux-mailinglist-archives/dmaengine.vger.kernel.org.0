Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5ED587A71
	for <lists+dmaengine@lfdr.de>; Tue,  2 Aug 2022 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiHBKPc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Aug 2022 06:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiHBKPb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Aug 2022 06:15:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432A11D0DD;
        Tue,  2 Aug 2022 03:15:29 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LxrRb5K0fzmVcP;
        Tue,  2 Aug 2022 18:13:31 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 18:15:27 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 18:15:27 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>, <wangzhou1@hisilicon.com>
CC:     <haijie1@huawei.com>, <liudongdong3@huawei.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/7] dmaengine: hisilicon: Disable channels when unregister hisi_dma
Date:   Tue, 2 Aug 2022 18:12:20 +0800
Message-ID: <20220802101226.9005-2-haijie1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220802101226.9005-1-haijie1@huawei.com>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220802101226.9005-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When hisi_dma is unloaded or unbinded, all of channels should be
disabled. This patch disables DMA channels when driver is unloaded
or unbinded.

Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
Signed-off-by: Jie Hai <haijie1@huawei.com>
Acked-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/dma/hisi_dma.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index 43817ced3a3e..98bc488893cc 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -180,7 +180,8 @@ static void hisi_dma_reset_qp_point(struct hisi_dma_dev *hdma_dev, u32 index)
 	hisi_dma_chan_write(hdma_dev->base, HISI_DMA_CQ_HEAD_PTR, index, 0);
 }
 
-static void hisi_dma_reset_hw_chan(struct hisi_dma_chan *chan)
+static void hisi_dma_reset_or_disable_hw_chan(struct hisi_dma_chan *chan,
+					      bool disable)
 {
 	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
 	u32 index = chan->qp_num, tmp;
@@ -201,8 +202,11 @@ static void hisi_dma_reset_hw_chan(struct hisi_dma_chan *chan)
 	hisi_dma_do_reset(hdma_dev, index);
 	hisi_dma_reset_qp_point(hdma_dev, index);
 	hisi_dma_pause_dma(hdma_dev, index, false);
-	hisi_dma_enable_dma(hdma_dev, index, true);
-	hisi_dma_unmask_irq(hdma_dev, index);
+
+	if (!disable) {
+		hisi_dma_enable_dma(hdma_dev, index, true);
+		hisi_dma_unmask_irq(hdma_dev, index);
+	}
 
 	ret = readl_relaxed_poll_timeout(hdma_dev->base +
 		HISI_DMA_Q_FSM_STS + index * HISI_DMA_OFFSET, tmp,
@@ -218,7 +222,7 @@ static void hisi_dma_free_chan_resources(struct dma_chan *c)
 	struct hisi_dma_chan *chan = to_hisi_dma_chan(c);
 	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
 
-	hisi_dma_reset_hw_chan(chan);
+	hisi_dma_reset_or_disable_hw_chan(chan, false);
 	vchan_free_chan_resources(&chan->vc);
 
 	memset(chan->sq, 0, sizeof(struct hisi_dma_sqe) * hdma_dev->chan_depth);
@@ -394,7 +398,7 @@ static void hisi_dma_enable_qp(struct hisi_dma_dev *hdma_dev, u32 qp_index)
 
 static void hisi_dma_disable_qp(struct hisi_dma_dev *hdma_dev, u32 qp_index)
 {
-	hisi_dma_reset_hw_chan(&hdma_dev->chan[qp_index]);
+	hisi_dma_reset_or_disable_hw_chan(&hdma_dev->chan[qp_index], true);
 }
 
 static void hisi_dma_enable_qps(struct hisi_dma_dev *hdma_dev)
-- 
2.33.0

