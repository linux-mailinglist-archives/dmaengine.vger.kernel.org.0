Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEE6633222
	for <lists+dmaengine@lfdr.de>; Tue, 22 Nov 2022 02:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiKVB3B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Nov 2022 20:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiKVB3A (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Nov 2022 20:29:00 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7897A82;
        Mon, 21 Nov 2022 17:28:59 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NGRQv08jHzFqVB;
        Tue, 22 Nov 2022 09:25:43 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 09:28:57 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 09:28:57 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] dmaengine: xilinx_dma: call of_node_put() when breaking out of for_each_child_of_node()
Date:   Tue, 22 Nov 2022 10:16:12 +0800
Message-ID: <20221122021612.1908866-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since for_each_child_of_node() will increase the refcount of node, we need
to call of_node_put() manually when breaking out of the iteration.

Fixes: 9cd4360de609 ("dma: Add Xilinx AXI Video Direct Memory Access Engine driver support")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8cd4e69dc7b4..766017570488 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3141,8 +3141,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	/* Initialize the channels */
 	for_each_child_of_node(node, child) {
 		err = xilinx_dma_child_probe(xdev, child);
-		if (err < 0)
+		if (err < 0) {
+			of_node_put(child);
 			goto error;
+		}
 	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
-- 
2.25.1

