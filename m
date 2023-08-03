Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CD376E3EB
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 11:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjHCJE7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 05:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjHCJE6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 05:04:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B4AE53
        for <dmaengine@vger.kernel.org>; Thu,  3 Aug 2023 02:04:55 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGjW26xfLztRpn;
        Thu,  3 Aug 2023 17:01:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 17:04:25 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <dmaengine@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] dmaengine: Do not check for 0 return after calling platform_get_irq()
Date:   Thu, 3 Aug 2023 17:03:48 +0800
Message-ID: <20230803090348.158083-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It is not possible for platform_get_irq() to return 0. Use the
return value from platform_get_irq().

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/dma/sa11x0-dma.c | 4 ++--
 drivers/dma/xgene-dma.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index a29c13cae716..53c7975f8aea 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -873,8 +873,8 @@ static int sa11x0_dma_request_irq(struct platform_device *pdev, int nr,
 {
 	int irq = platform_get_irq(pdev, nr);
 
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	return request_irq(irq, sa11x0_dma_irq, 0, dev_name(&pdev->dev), data);
 }
diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index bb4ff8c86733..a22a7cb2bb2c 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -1680,16 +1680,16 @@ static int xgene_dma_get_resources(struct platform_device *pdev,
 
 	/* Get DMA error interrupt */
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENXIO;
+	if (irq < 0)
+		return irq;
 
 	pdma->err_irq = irq;
 
 	/* Get DMA Rx ring descriptor interrupts for all DMA channels */
 	for (i = 1; i <= XGENE_DMA_MAX_CHANNEL; i++) {
 		irq = platform_get_irq(pdev, i);
-		if (irq <= 0)
-			return -ENXIO;
+		if (irq < 0)
+			return irq;
 
 		pdma->chan[i - 1].rx_irq = irq;
 	}
-- 
2.34.1

