Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E8F75DA9E
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jul 2023 09:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGVHcF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jul 2023 03:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGVHcE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jul 2023 03:32:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F9E211E;
        Sat, 22 Jul 2023 00:32:02 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R7J4x2Kp6z18Lfx;
        Sat, 22 Jul 2023 15:31:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 15:32:00 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <vkoul@kernel.org>, <afaerber@suse.de>, <mani@kernel.org>
CC:     <chris.zjh@huawei.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-actions@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] dmaengine: owl-dma: Modify mismatched function name
Date:   Sat, 22 Jul 2023 15:32:44 +0000
Message-ID: <20230722153244.2086949-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

No functional modification involved.

drivers/dma/owl-dma.c:208: warning: expecting prototype for struct owl_dma_pchan. Prototype was for struct owl_dma_vchan instead HDRTEST usr/include/sound/asequencer.h

Fixes: 47e20577c24d ("dmaengine: Add Actions Semi Owl family S900 DMA driver")
Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
 drivers/dma/owl-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 95a462a1f511..b6e0ac8314e5 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -192,7 +192,7 @@ struct owl_dma_pchan {
 };
 
 /**
- * struct owl_dma_pchan - Wrapper for DMA ENGINE channel
+ * struct owl_dma_vchan - Wrapper for DMA ENGINE channel
  * @vc: wrapped virtual channel
  * @pchan: the physical channel utilized by this channel
  * @txd: active transaction on this channel
-- 
2.34.1

