Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3C2C0C7D
	for <lists+dmaengine@lfdr.de>; Mon, 23 Nov 2020 14:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbgKWNzM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Nov 2020 08:55:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7669 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388420AbgKWNzL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Nov 2020 08:55:11 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CfpYG0b3dz15RD0;
        Mon, 23 Nov 2020 21:54:26 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 23 Nov 2020
 21:54:40 +0800
From:   Wang Xiaojun <wangxiaojun11@huawei.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>
Subject: [PATCH] dmaengine: ti: edma: Fix reference count leaks due to pm_runtime_get_sync
Date:   Mon, 23 Nov 2020 21:59:28 +0800
Message-ID: <20201123135928.2702845-1-wangxiaojun11@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, should decrement the reference
count before returning the error. So we fixed it by replacing it
with pm_runtime_resume_and_get.

Signed-off-by: Wang Xiaojun <wangxiaojun11@huawei.com>
---
 drivers/dma/ti/edma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 35d81bd857f1..38af8b596e1c 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2399,7 +2399,7 @@ static int edma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ecc);
 
 	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm_runtime_get_sync() failed\n");
 		pm_runtime_disable(dev);
-- 
2.25.1

