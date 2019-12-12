Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFEC11CC87
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2019 12:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfLLLtS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Dec 2019 06:49:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbfLLLtR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Dec 2019 06:49:17 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F16E573E5B837CD73032;
        Thu, 12 Dec 2019 19:49:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 12 Dec 2019 19:49:02 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        YueHaibing <yuehaibing@huawei.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <dmaengine@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] dmaengine: ti: edma: Fix error return code in edma_probe()
Date:   Thu, 12 Dec 2019 11:46:22 +0000
Message-ID: <20191212114622.127322-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix to return negative error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 2a03c1314506 ("dmaengine: ti: edma: add missed operations")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/dma/ti/edma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 0628ee4bf1b4..03a7f647f7b2 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2342,8 +2342,10 @@ static int edma_probe(struct platform_device *pdev)
 	ecc->channels_mask = devm_kcalloc(dev,
 					   BITS_TO_LONGS(ecc->num_channels),
 					   sizeof(unsigned long), GFP_KERNEL);
-	if (!ecc->slave_chans || !ecc->slot_inuse || !ecc->channels_mask)
+	if (!ecc->slave_chans || !ecc->slot_inuse || !ecc->channels_mask) {
+		ret = -ENOMEM;
 		goto err_disable_pm;
+	}
 
 	/* Mark all channels available initially */
 	bitmap_fill(ecc->channels_mask, ecc->num_channels);



