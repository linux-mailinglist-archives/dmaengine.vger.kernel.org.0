Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBF94DD5D2
	for <lists+dmaengine@lfdr.de>; Fri, 18 Mar 2022 09:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiCRIJq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Mar 2022 04:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiCRIJq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Mar 2022 04:09:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A20238DB8
        for <dmaengine@vger.kernel.org>; Fri, 18 Mar 2022 01:08:27 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKc660dXjzCqqj;
        Fri, 18 Mar 2022 16:06:22 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 18 Mar 2022 16:08:24 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 16:08:24 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <sean.wang@mediatek.com>, <vkoul@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <dmaengine@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH -next] dmaengine: mediatek:Fix PM usage reference leak of tegra
Date:   Fri, 18 Mar 2022 16:08:09 +0800
Message-ID: <20220318080809.22562-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: zhangqilong <zhangqilong3@huawei.com>

pm_runtime_get_sync will increment pm usage counter even it failed.
Forgetting to putting operation will result in reference leak here.
We fix it:
1) Replacing it with pm_runtime_resume_and_get to keep usage counter
   balanced.
2) Add putting operation before returning error.

Fixes:9135408c3ace4 ("dmaengine: mediatek: Add MediaTek UART APDMA support")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 375e7e647df6..a1517ef1f4a0 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -274,7 +274,7 @@ static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
 	unsigned int status;
 	int ret;
 
-	ret = pm_runtime_get_sync(mtkd->ddev.dev);
+	ret = pm_runtime_resume_and_get(mtkd->ddev.dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(chan->device->dev);
 		return ret;
@@ -288,18 +288,21 @@ static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
 	ret = readx_poll_timeout(readl, c->base + VFF_EN,
 			  status, !status, 10, 100);
 	if (ret)
-		return ret;
+		goto err_pm;
 
 	ret = request_irq(c->irq, mtk_uart_apdma_irq_handler,
 			  IRQF_TRIGGER_NONE, KBUILD_MODNAME, chan);
 	if (ret < 0) {
 		dev_err(chan->device->dev, "Can't request dma IRQ\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_pm;
 	}
 
 	if (mtkd->support_33bits)
 		mtk_uart_apdma_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_CLR_B);
 
+err_pm:
+	pm_runtime_put_noidle(mtkd->ddev.dev);
 	return ret;
 }
 
-- 
2.31.1

