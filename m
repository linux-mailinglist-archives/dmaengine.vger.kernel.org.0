Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B060277D81F
	for <lists+dmaengine@lfdr.de>; Wed, 16 Aug 2023 04:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjHPCH3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Aug 2023 22:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbjHPCHS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Aug 2023 22:07:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A0D2121
        for <dmaengine@vger.kernel.org>; Tue, 15 Aug 2023 19:07:16 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQWf971bdzFqYx;
        Wed, 16 Aug 2023 10:04:17 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 10:07:14 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <vkoul@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH -next 1/2] dmaengine: fsl-edma: use struct_size() helper
Date:   Wed, 16 Aug 2023 10:03:54 +0800
Message-ID: <20230816020355.3002617-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/dma/fsl-edma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index e40769666e39..caca3566ba82 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -270,7 +270,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma;
 	const struct fsl_edma_drvdata *drvdata = NULL;
-	struct fsl_edma_chan *fsl_chan;
 	struct edma_regs *regs;
 	int len, chans;
 	int ret, i;
@@ -288,7 +287,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	len = sizeof(*fsl_edma) + sizeof(*fsl_chan) * chans;
+	len = struct_size(fsl_edma, chans, chans);
 	fsl_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
 	if (!fsl_edma)
 		return -ENOMEM;
-- 
2.25.1

