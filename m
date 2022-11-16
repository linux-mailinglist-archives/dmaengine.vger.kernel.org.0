Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7701D62B39E
	for <lists+dmaengine@lfdr.de>; Wed, 16 Nov 2022 08:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiKPHAh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Nov 2022 02:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiKPHAg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Nov 2022 02:00:36 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BF917E3F;
        Tue, 15 Nov 2022 23:00:31 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NBv4K1RdpzJnlG;
        Wed, 16 Nov 2022 14:57:21 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 15:00:29 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <linus.walleij@linaro.org>, <vkoul@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v2] dmaengine: ste_dma40: use devm_request_irq to avoid  missing free_irq() in error path
Date:   Wed, 16 Nov 2022 14:57:17 +0800
Message-ID: <20221116065717.3069712-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

free_irq() is missing in some cases of error in d40_probe(), use
devm_request_irq to fix that.

Fixes: d7b7ecce4bcb ("ste_dma40: Rename a jump label in d40_probe()")
Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
v2:
- use devm_request_irq instead of adding free_irq() to fix the problem.
---
 drivers/dma/ste_dma40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index f093e08c23b1..3214d2cb027e 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3598,7 +3598,7 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	base->irq = platform_get_irq(pdev, 0);
 
-	ret = request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
+	ret = devm_request_irq(&pdev->dev, base->irq, d40_handle_interrupt, 0, D40_NAME, base);
 	if (ret) {
 		d40_err(&pdev->dev, "No IRQ defined\n");
 		goto destroy_cache;
-- 
2.25.1

