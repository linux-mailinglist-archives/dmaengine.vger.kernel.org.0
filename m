Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99969A598
	for <lists+dmaengine@lfdr.de>; Fri, 17 Feb 2023 07:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBQG1n (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Feb 2023 01:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBQG1m (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Feb 2023 01:27:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE2C5A399
        for <dmaengine@vger.kernel.org>; Thu, 16 Feb 2023 22:27:41 -0800 (PST)
Received: from dggpemm100007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PJ1y70kBbzRs84;
        Fri, 17 Feb 2023 14:25:03 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm100007.china.huawei.com
 (7.185.36.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 17 Feb
 2023 14:27:39 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <dmaengine@vger.kernel.org>, <lizhi.hou@amd.com>,
        <brian.xu@amd.com>, <raj.kumar.rampelli@amd.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>,
        <sonal.santan@amd.com>, <max.zhen@amd.com>
CC:     <yangyingliang@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH -next] dmaengine: xilinx: xdma: fix return value check in xdma_probe()
Date:   Fri, 17 Feb 2023 14:26:52 +0800
Message-ID: <20230217062652.172480-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100007.china.huawei.com (7.185.36.116)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

devm_ioremap_resource() never returns NULL pointer, it will return
ERR_PTR() when it fails, so replace the check with IS_ERR().

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/dma/xilinx/xdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 462109c61653..1c836cbdafa1 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -892,8 +892,9 @@ static int xdma_probe(struct platform_device *pdev)
 	}
 
 	reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (!reg_base) {
+	if (IS_ERR(reg_base)) {
 		xdma_err(xdev, "ioremap failed");
+		ret = PTR_ERR(reg_base);
 		goto failed;
 	}
 
-- 
2.25.1

