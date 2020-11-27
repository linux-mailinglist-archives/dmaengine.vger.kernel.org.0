Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2232C6204
	for <lists+dmaengine@lfdr.de>; Fri, 27 Nov 2020 10:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgK0Jka (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Nov 2020 04:40:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8129 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgK0Jk1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Nov 2020 04:40:27 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cj8jr56qTz15QqJ;
        Fri, 27 Nov 2020 17:40:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Nov 2020 17:40:16 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] dmaengine: usb-mac: fix reference leak in usb_dmac_probe
Date:   Fri, 27 Nov 2020 17:44:32 +0800
Message-ID: <20201127094432.120816-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it
failed. Forgetting to putting operation will result in a
reference leak here.

A new function pm_runtime_resume_and_get is introduced in
[0] to keep usage counter balanced. So We fix the reference
leak by replacing it with new funtion.

[0] dd8088d5a896 ("PM: runtime: Add  pm_runtime_resume_and_get to deal with usage counter")

Fixes: 0c1c8ff32fa2 ("dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/dma/sh/usb-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 8f7ceb698..2a6c8fd88 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -796,7 +796,7 @@ static int usb_dmac_probe(struct platform_device *pdev)
 
 	/* Enable runtime PM and initialize the device. */
 	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
 		goto error_pm;
-- 
2.23.0

