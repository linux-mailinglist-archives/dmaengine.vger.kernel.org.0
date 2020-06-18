Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5794C1FF282
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2020 15:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgFRNAH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Jun 2020 09:00:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbgFRNAH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 18 Jun 2020 09:00:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1BF1FF9C323EE1E6F0DE;
        Thu, 18 Jun 2020 21:00:05 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 18 Jun 2020
 20:59:53 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <peter.ujfalusi@ti.com>, <grygorii.strashko@ti.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] dmaengine: ti: k3-udma: add missing put_device() call in of_xudma_dev_get()
Date:   Thu, 18 Jun 2020 21:01:10 +0800
Message-ID: <20200618130110.582543-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

if of_find_device_by_node() succeed and platform_get_drvdata() failed,
of_xudma_dev_get() will return without put_device(), which will leak
the memory.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/dma/ti/k3-udma-private.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 0b8f3dd6b146..77e8e67d995b 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -42,6 +42,7 @@ struct udma_dev *of_xudma_dev_get(struct device_node *np, const char *property)
 	ud = platform_get_drvdata(pdev);
 	if (!ud) {
 		pr_debug("UDMA has not been probed\n");
+		put_device(&pdev->dev);
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-- 
2.25.4

