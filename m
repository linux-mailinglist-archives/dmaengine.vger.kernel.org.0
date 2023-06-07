Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC458725215
	for <lists+dmaengine@lfdr.de>; Wed,  7 Jun 2023 04:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbjFGC0X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Jun 2023 22:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbjFGC0W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Jun 2023 22:26:22 -0400
X-Greylist: delayed 316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jun 2023 19:26:21 PDT
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C61C1990
        for <dmaengine@vger.kernel.org>; Tue,  6 Jun 2023 19:26:21 -0700 (PDT)
Received: from ed3e173716be.home.arpa (unknown [124.16.138.125])
        by APP-01 (Coremail) with SMTP id qwCowAC3vg6H6X9kIU3ODA--.1995S2;
        Wed, 07 Jun 2023 10:20:57 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     vkoul@kernel.org, zhangfei.gao@marvell.com, leoy@marvell.com,
        zhouqiao@marvell.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] dmaengine: mmp_tdma: Add missing check for dma_set_mask
Date:   Wed,  7 Jun 2023 10:20:53 +0800
Message-Id: <20230607022053.32696-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAC3vg6H6X9kIU3ODA--.1995S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr48KF1DJF4Uur4ftFW5ZFb_yoWfAFXEgr
        y0vFW8WFyDAF40qF4Ikr1ayryFkrn0qr9xWF1kKa4fZry5JrZxWayUZF1kGr4UZ34UCr4U
        Cr4j9rW3G3WxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHWlkUUUUU=
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add check for dma_set_mask() and return the error if it fails.

Fixes: c6da0ba8dfc8 ("dmaengine: mmp_tdma: add mmp tdma support")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/dma/mmp_tdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index d49fa6bc6775..99cf4f7cd50b 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -717,7 +717,10 @@ static int mmp_tdma_probe(struct platform_device *pdev)
 	tdev->device.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	tdev->device.descriptor_reuse = true;
 
-	dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, tdev);
 
 	ret = dmaenginem_async_device_register(&tdev->device);
-- 
2.25.1

