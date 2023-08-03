Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C221B76DF0A
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 05:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjHCDdO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Aug 2023 23:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjHCDdI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Aug 2023 23:33:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762FE26B2
        for <dmaengine@vger.kernel.org>; Wed,  2 Aug 2023 20:33:07 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RGZ8g1jN9zNmNZ;
        Thu,  3 Aug 2023 11:29:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 11:33:04 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <lizhi.hou@amd.com>, <brian.xu@amd.com>,
        <raj.kumar.rampelli@amd.com>, <vkoul@kernel.org>,
        <michal.simek@amd.com>
CC:     <lizetao1@huawei.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH -next] dmaengine: xilinx: xdma: Use resource_size() in xdma_probe()
Date:   Thu, 3 Aug 2023 11:32:35 +0800
Message-ID: <20230803033235.3049137-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is a warning reported by coccinelle:

./drivers/dma/xilinx/xdma.c:888:22-25: ERROR:
	Missing resource_size with   res

Use resource_size() on resource object instead of explicit computation.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/dma/xilinx/xdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index e0bfd129d563..da5410dddfbf 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -885,7 +885,7 @@ static int xdma_probe(struct platform_device *pdev)
 		goto failed;
 	}
 	xdev->irq_start = res->start;
-	xdev->irq_num = res->end - res->start + 1;
+	xdev->irq_num = resource_size(res);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-- 
2.34.1

