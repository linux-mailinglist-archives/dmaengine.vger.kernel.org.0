Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C93F62932B
	for <lists+dmaengine@lfdr.de>; Tue, 15 Nov 2022 09:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKOITn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Nov 2022 03:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKOITn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Nov 2022 03:19:43 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DEFDCA;
        Tue, 15 Nov 2022 00:19:42 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NBJxN67TCz15Mbt;
        Tue, 15 Nov 2022 16:19:20 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 16:19:09 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <linus.walleij@linaro.org>, <vkoul@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] dmaengine: ste_dma40: add missing free_irq() in error path
Date:   Tue, 15 Nov 2022 16:15:46 +0800
Message-ID: <20221115081546.2389164-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

free_irq() is missing in some cases of error in d40_probe(), fix that.

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 drivers/dma/ste_dma40.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index f093e08c23b1..1cedb53bc3dd 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3611,7 +3611,7 @@ static int __init d40_probe(struct platform_device *pdev)
 			d40_err(&pdev->dev, "Failed to get lcpa_regulator\n");
 			ret = PTR_ERR(base->lcpa_regulator);
 			base->lcpa_regulator = NULL;
-			goto destroy_cache;
+			goto free_irq;
 		}
 
 		ret = regulator_enable(base->lcpa_regulator);
@@ -3620,7 +3620,7 @@ static int __init d40_probe(struct platform_device *pdev)
 				"Failed to enable lcpa_regulator\n");
 			regulator_put(base->lcpa_regulator);
 			base->lcpa_regulator = NULL;
-			goto destroy_cache;
+			goto free_irq;
 		}
 	}
 
@@ -3635,12 +3635,12 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	ret = d40_dmaengine_init(base, num_reserved_chans);
 	if (ret)
-		goto destroy_cache;
+		goto free_irq;
 
 	ret = dma_set_max_seg_size(base->dev, STEDMA40_MAX_SEG_SIZE);
 	if (ret) {
 		d40_err(&pdev->dev, "Failed to set dma max seg size\n");
-		goto destroy_cache;
+		goto free_irq;
 	}
 
 	d40_hw_init(base);
@@ -3654,6 +3654,8 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	dev_info(base->dev, "initialized\n");
 	return 0;
+free_irq:
+	free_irq(base->irq, base);
  destroy_cache:
 	kmem_cache_destroy(base->desc_slab);
 	if (base->virtbase)
-- 
2.25.1

