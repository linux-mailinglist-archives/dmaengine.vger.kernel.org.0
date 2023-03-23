Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48F06C63A3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Mar 2023 10:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCWJcD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Mar 2023 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCWJbh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Mar 2023 05:31:37 -0400
X-Greylist: delayed 491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Mar 2023 02:27:35 PDT
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E13E2234C3;
        Thu, 23 Mar 2023 02:27:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-03 (Coremail) with SMTP id rQCowAAHDQmYGRxk0agVFQ--.22173S2;
        Thu, 23 Mar 2023 17:19:20 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] dmaengine: fsl-edma: Add check for dma_pool_create
Date:   Thu, 23 Mar 2023 17:19:18 +0800
Message-Id: <20230323091918.32596-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAHDQmYGRxk0agVFQ--.22173S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrW7Kw4xGF1xZr47Kw18Grg_yoWfZrc_CF
        WrZrWfur1Dtrn3CF12krW3ZrWSkrZ8ZFs293Zrt3Zxtw13GFWfJ34Ut3s5XrW7X3y7Arsr
        A34DZry3ZryIgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjqYLDUUUUU==
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the check for the return value of the dma_pool_create and return the
error if it fails, in order to avoid NULL pointer dereference in the
fsl_edma_alloc_desc.

Fixes: d6be34fbd39b ("dma: Add Freescale eDMA engine driver support")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/dma/fsl-edma-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index a06a1575a2a5..a24095c941b6 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -658,6 +658,9 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
 				sizeof(struct fsl_edma_hw_tcd),
 				32, 0);
+	if (!fsl_chan->tcd_pool)
+		return -ENOMEM;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fsl_edma_alloc_chan_resources);
-- 
2.25.1

