Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613A978248F
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 09:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHUHjX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 03:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjHUHjX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 03:39:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC64FBA
        for <dmaengine@vger.kernel.org>; Mon, 21 Aug 2023 00:39:20 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTkpk1j9YzrSbf;
        Mon, 21 Aug 2023 15:37:50 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 15:39:17 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <vkoul@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH v2] dmaengine: fsl-edma: use struct_size() helper
Date:   Mon, 21 Aug 2023 15:36:00 +0800
Message-ID: <20230821073600.4078584-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v1 -> v2: remove len and use struct_size() in devm_kzmalloc() parameter
---
 drivers/dma/fsl-edma.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index e40769666e39..8c9ee9fc7240 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -270,9 +270,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma;
 	const struct fsl_edma_drvdata *drvdata = NULL;
-	struct fsl_edma_chan *fsl_chan;
 	struct edma_regs *regs;
-	int len, chans;
+	int chans;
 	int ret, i;
 
 	if (of_id)
@@ -288,8 +287,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	len = sizeof(*fsl_edma) + sizeof(*fsl_chan) * chans;
-	fsl_edma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	fsl_edma = devm_kzalloc(&pdev->dev, struct_size(fsl_edma, chans, chans),
+				GFP_KERNEL);
 	if (!fsl_edma)
 		return -ENOMEM;
 
-- 
2.25.1

