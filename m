Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBB2248434
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 13:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHRLwE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 07:52:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbgHRLwD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Aug 2020 07:52:03 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CCB8D1464C8F88828435;
        Tue, 18 Aug 2020 19:52:00 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 19:51:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dmaengine: iop-adma: Fix pointer cast warnings
Date:   Tue, 18 Aug 2020 19:51:01 +0800
Message-ID: <20200818115101.55700-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

drivers/dma/iop-adma.c: In function ‘iop_adma_alloc_chan_resources’:
drivers/dma/iop-adma.c:447:13: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   hw_desc = (char *) iop_chan->device->dma_desc_pool;
             ^
drivers/dma/iop-adma.c:449:4: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    (dma_addr_t) &hw_desc[idx * IOP_ADMA_SLOT_SIZE];
    ^
drivers/dma/iop-adma.c: In function ‘iop_adma_probe’:
drivers/dma/iop-adma.c:1301:3: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   (void *) adev->dma_desc_pool);

Use dma_addr_t for dma_desc_pool, and %pad to print dma_addr_t.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/iop-adma.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 3350bffb2e93..48d56c9f3619 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -416,6 +416,7 @@ static void iop_chan_start_null_xor(struct iop_adma_chan *iop_chan);
 static int iop_adma_alloc_chan_resources(struct dma_chan *chan)
 {
 	char *hw_desc;
+	dma_addr_t dma_desc;
 	int idx;
 	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
 	struct iop_adma_desc_slot *slot = NULL;
@@ -444,9 +445,8 @@ static int iop_adma_alloc_chan_resources(struct dma_chan *chan)
 		INIT_LIST_HEAD(&slot->tx_list);
 		INIT_LIST_HEAD(&slot->chain_node);
 		INIT_LIST_HEAD(&slot->slot_node);
-		hw_desc = (char *) iop_chan->device->dma_desc_pool;
-		slot->async_tx.phys =
-			(dma_addr_t) &hw_desc[idx * IOP_ADMA_SLOT_SIZE];
+		dma_desc = iop_chan->device->dma_desc_pool;
+		slot->async_tx.phys = dma_desc + idx * IOP_ADMA_SLOT_SIZE;
 		slot->idx = idx;
 
 		spin_lock_bh(&iop_chan->lock);
@@ -1296,9 +1296,8 @@ static int iop_adma_probe(struct platform_device *pdev)
 		goto err_free_adev;
 	}
 
-	dev_dbg(&pdev->dev, "%s: allocated descriptor pool virt %p phys %p\n",
-		__func__, adev->dma_desc_pool_virt,
-		(void *) adev->dma_desc_pool);
+	dev_dbg(&pdev->dev, "%s: allocated descriptor pool virt %p phys %pad\n",
+		__func__, adev->dma_desc_pool_virt, &adev->dma_desc_pool);
 
 	adev->id = plat_data->hw_id;
 
-- 
2.17.1


