Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CBC778F93
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 14:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHKMcP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Aug 2023 08:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjHKMcO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Aug 2023 08:32:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8DCE60;
        Fri, 11 Aug 2023 05:32:12 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMjkx0S1VzCrn0;
        Fri, 11 Aug 2023 20:28:41 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 20:32:10 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>,
        <yuehaibing@huawei.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] dmaengine: ti: k3-udma: Remove unused declarations
Date:   Fri, 11 Aug 2023 20:32:09 +0800
Message-ID: <20230811123209.45800-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Commit d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
declared but never implemented these.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/dma/ti/k3-udma.h         | 1 -
 include/linux/dma/k3-udma-glue.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index d349c6d482ae..9062a237cd16 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -131,7 +131,6 @@ int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
 struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property);
 struct device *xudma_get_device(struct udma_dev *ud);
 struct k3_ringacc *xudma_get_ringacc(struct udma_dev *ud);
-void xudma_dev_put(struct udma_dev *ud);
 u32 xudma_dev_get_psil_base(struct udma_dev *ud);
 struct udma_tisci_rm *xudma_dev_get_tisci_rm(struct udma_dev *ud);
 
diff --git a/include/linux/dma/k3-udma-glue.h b/include/linux/dma/k3-udma-glue.h
index e443be4d3b4b..57d6e7e1e091 100644
--- a/include/linux/dma/k3-udma-glue.h
+++ b/include/linux/dma/k3-udma-glue.h
@@ -126,8 +126,6 @@ u32 k3_udma_glue_rx_flow_get_fdq_id(struct k3_udma_glue_rx_channel *rx_chn,
 u32 k3_udma_glue_rx_get_flow_id_base(struct k3_udma_glue_rx_channel *rx_chn);
 int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
 			    u32 flow_num);
-void k3_udma_glue_rx_put_irq(struct k3_udma_glue_rx_channel *rx_chn,
-			     u32 flow_num);
 void k3_udma_glue_reset_rx_chn(struct k3_udma_glue_rx_channel *rx_chn,
 		u32 flow_num, void *data,
 		void (*cleanup)(void *data, dma_addr_t desc_dma),
-- 
2.34.1

