Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3052E4CA1A7
	for <lists+dmaengine@lfdr.de>; Wed,  2 Mar 2022 11:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbiCBKD0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Mar 2022 05:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiCBKDZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Mar 2022 05:03:25 -0500
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 02:02:40 PST
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 425E8DFD3;
        Wed,  2 Mar 2022 02:02:39 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowAAXH9u9QB9io77tAQ--.28212S2;
        Wed, 02 Mar 2022 18:02:38 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] dmaengine: mmp_pdma: Handle error for dma_set_mask
Date:   Wed,  2 Mar 2022 18:02:36 +0800
Message-Id: <20220302100236.170743-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAXH9u9QB9io77tAQ--.28212S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr45GF45CF1xZF18trW5KFg_yoWDCwbEvr
        WUZryvgFs8ArZ29w1akryayr95u34vgr1j9Fn2gan3Wry5G39xA3y7ZF1kCr1UZasFkrW5
        Cr4DurWfJF1fCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8twCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5sqWUUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As the potential failure of the dma_set_mask(),
it should be better to check it and return error
if fails.

Fixes: c8acd6aa6bed ("dmaengine: mmp-pdma support")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/dma/mmp_pdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 5a53d7fcef01..12085d9fae95 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -1101,9 +1101,11 @@ static int mmp_pdma_probe(struct platform_device *op)
 	pdev->device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 
 	if (pdev->dev->coherent_dma_mask)
-		dma_set_mask(pdev->dev, pdev->dev->coherent_dma_mask);
+		ret = dma_set_mask(pdev->dev, pdev->dev->coherent_dma_mask);
 	else
-		dma_set_mask(pdev->dev, DMA_BIT_MASK(64));
+		ret = dma_set_mask(pdev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
 
 	ret = dma_async_device_register(&pdev->device);
 	if (ret) {
-- 
2.25.1

