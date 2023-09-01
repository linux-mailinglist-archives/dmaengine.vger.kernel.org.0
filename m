Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA0178F8EF
	for <lists+dmaengine@lfdr.de>; Fri,  1 Sep 2023 09:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjIAHLX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Sep 2023 03:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjIAHLX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Sep 2023 03:11:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68299E49
        for <dmaengine@vger.kernel.org>; Fri,  1 Sep 2023 00:11:20 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcTg50rn6zrSNv;
        Fri,  1 Sep 2023 15:09:37 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 1 Sep
 2023 15:11:18 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <dmaengine@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] dmaengine: fsl-edma: Remove redundant dev_err() for platform_get_irq()
Date:   Fri, 1 Sep 2023 15:11:14 +0800
Message-ID: <20230901071115.1322000-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since commit 7723f4c5ecdb ("driver core: platform: Add an error message
to platform_get_irq*()") and commit 2043727c2882 ("driver core:
platform: Make use of the helper function dev_err_probe()"), there is
no need to call the dev_err() function directly to print a custom
message when handling an error from platform_get_irq() function as it is
going to display an appropriate error message in case of a failure.

Fixes: 72f5801a4e2b ("dmaengine: fsl-edma: integrate v3 support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/dma/fsl-edma-main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 63d48d046f04..d493dddd55b1 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -230,10 +230,8 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 
 		/* request channel irq */
 		fsl_chan->txirq = platform_get_irq(pdev, i);
-		if (fsl_chan->txirq < 0) {
-			dev_err(&pdev->dev, "Can't get chan %d's irq.\n", i);
+		if (fsl_chan->txirq < 0)
 			return  -EINVAL;
-		}
 
 		ret = devm_request_irq(&pdev->dev, fsl_chan->txirq,
 			fsl_edma3_tx_handler, IRQF_SHARED,
-- 
2.34.1

