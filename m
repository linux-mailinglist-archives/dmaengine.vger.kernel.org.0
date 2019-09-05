Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA2A9A58
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 08:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbfIEGDu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 02:03:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfIEGDu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Sep 2019 02:03:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0180536790BE16221016;
        Thu,  5 Sep 2019 14:03:48 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 14:03:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <peter.ujfalusi@ti.com>, <arnd@arndb.de>, <yuehaibing@huawei.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] dmaengine: ti: edma: remove unused code
Date:   Thu, 5 Sep 2019 14:02:49 +0800
Message-ID: <20190905060249.23928-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

drivers/dma/ti/edma.c: In function edma_probe:
drivers/dma/ti/edma.c:2252:11: warning:
 variable off set but not used [-Wunused-but-set-variable]

'off' is not used now, so remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/ti/edma.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index ba7c4f0..54fd981 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2249,10 +2249,8 @@ static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	*info = pdev->dev.platform_data;
 	s8			(*queue_priority_mapping)[2];
-	int			i, off;
 	const s16		(*rsv_slots)[2];
-	const s16		(*xbar_chans)[2];
-	int			irq;
+	int			i, irq;
 	char			*irq_name;
 	struct resource		*mem;
 	struct device_node	*node = pdev->dev.of_node;
@@ -2349,14 +2347,6 @@ static int edma_probe(struct platform_device *pdev)
 			edma_write_slot(ecc, i, &dummy_paramset);
 	}
 
-	/* Clear the xbar mapped channels in unused list */
-	xbar_chans = info->xbar_chans;
-	if (xbar_chans) {
-		for (i = 0; xbar_chans[i][1] != -1; i++) {
-			off = xbar_chans[i][1];
-		}
-	}
-
 	irq = platform_get_irq_byname(pdev, "edma3_ccint");
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 0);
-- 
2.7.4


