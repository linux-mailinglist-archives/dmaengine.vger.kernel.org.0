Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB980576B56
	for <lists+dmaengine@lfdr.de>; Sat, 16 Jul 2022 04:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiGPCp7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jul 2022 22:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGPCp7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Jul 2022 22:45:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C4D8C764;
        Fri, 15 Jul 2022 19:45:54 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LlCDb4q09zVfqG;
        Sat, 16 Jul 2022 10:42:07 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Jul 2022 10:45:51 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Jul 2022 10:45:51 +0800
From:   Jie Hai <haijie1@huawei.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liudongdong3@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH] dmaengine: Fix refcount increasing in dma_chan_get
Date:   Sat, 16 Jul 2022 10:44:53 +0800
Message-ID: <20220716024453.1418259-1-haijie1@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When both hisi_dma.ko and async_tx.ko are loaded, you must first remove
async_tx if you want to remove hisi_dma. We expect to remove hisi_dma
successfully after doing so. In fact, hisi_dma is still referenced and
cannot be removed.

Module async_tx.ko references DMAEngine by dmaegnine_get(), which is
recorded by dmaengine_ref_count and it is the only module in the
current kernel that references dmaengine in this way. When the DMA
driver is loaded, the reference is reflected in the reference counts
of the driver and of the channels.

Load hisi_dma.ko and async_tx.ko in sequence, the reference count of
each DMA channel changes from zero to two. If only async_tx.ko is
unloaded, the reference count of each channel should be reduced to zero
again. However, that of each channel is still one without actually being
used.

The reference count of each channel is adjusted to dmaengine_ref_count
and then increased by one in dma_chan_get. This is the reason why the
reference count is greater than the actual reference by one.

This patch swaps the reference counting updating sequence. The
reference counting of each channel increases by one, and then adjusts.

Fixes: d2f4f99db3e9 ("dmaengine: Rework dma_chan_get")
Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 drivers/dma/dmaengine.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51b..78f8a9f3ad82 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -451,7 +451,8 @@ static int dma_chan_get(struct dma_chan *chan)
 	/* The channel is already in use, update client count */
 	if (chan->client_count) {
 		__module_get(owner);
-		goto out;
+		chan->client_count++;
+		return 0;
 	}
 
 	if (!try_module_get(owner))
@@ -470,11 +471,11 @@ static int dma_chan_get(struct dma_chan *chan)
 			goto err_out;
 	}
 
+	chan->client_count++;
+
 	if (!dma_has_cap(DMA_PRIVATE, chan->device->cap_mask))
 		balance_ref_count(chan);
 
-out:
-	chan->client_count++;
 	return 0;
 
 err_out:
-- 
2.30.0

